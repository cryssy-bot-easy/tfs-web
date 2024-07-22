package com.ucpb.tfsweb.utilities

import grails.converters.JSON
import org.springframework.transaction.annotation.Transactional

class ParserService {
	
    static transactional = true
    
	// parses grid values
	@Transactional(readOnly=true)
	def parseGrid(gridItemsToParse) {
        def gridItemList = []
		
		if(gridItemsToParse?.contains(",")){
			String allGridItems = gridItemsToParse.toString().substring(1,gridItemsToParse.toString().length() - 1)

            allGridItems.replaceAll(",\\{","\\|\\|\\|\\{").split("\\|\\|\\|").each{

                Map<String, Object> map = new HashMap<String, Object>()
                
                JSON.parse(it).each { a->
                    if(a.key.toString() != "deletePaymentSummary" && a.key.toString() != "pay") {
                        if(a.key.toString().contains("amount")) {
                            a.value = a.value.toString().replaceAll(",", "")
                        }
                        
                        if(a.key.toString().equals("setupString")) {
                            Map<String, String> setupStringMap = new LinkedHashMap<String, String>();
                            for(String keyValue : a.value.split(" *& *")) {
                                String[] pairs = keyValue.split(" *= *", 2);
                                setupStringMap.put(pairs[0], pairs.length == 1 ? "" : pairs[1]);
                            }

                            a.value = setupStringMap
                        }

                        map.put(a.key, a.value)
                    }
                }

				gridItemList.add(map)
			}
		}

        return gridItemList
	}

    // converts list to string
    @Transactional(readOnly=true)
    String listHashMapToString(list) {
        String returnString = ""
        
        list.eachWithIndex{ charges, chargeCount ->
            String chargesString = "["

            charges.eachWithIndex{ property, propertyCount ->

                def prop = property.toString().split("=")
                chargesString += prop[0] + "=\"" + (prop.length == 2 ? prop[1] : "") + "\""

                if(propertyCount+1 < charges.size()) {
                    chargesString += " "
                }
            }

            chargesString += "]"

            returnString += chargesString

            if(chargeCount+1 < list.size()) {
                returnString += ";"
            }
        }
        
        return returnString
    }
    
    // obtain session model and returns a hashmap
    @Transactional(readOnly=true)
    Map<String, Object> sessionModelToHashMap(sessionModel) {
        Map<String,Object> map = new HashMap<String, Object>()
//        ////println"converting hashmap to string"
        sessionModel.each{
            def value = it.value
            
            if(value instanceof String) {
                value = value.replaceAll(" ", "%20").replaceAll("[\r\n]+","%0D").replaceAll("\'","%27")
            }
            
            map.put(it.key, value)
        }

        return map
    }

    def getMapFromListById(id, list) {
        list.each {
            if (it.id == id) {
                return it
            }
        }
    }

    def getMapListNotIn(idList, list) {
        def returnList = []
        list.each {
            if (!(it.id in idList)) {
                returnList << it
            }
        }

        return returnList
    }
}
