package com.ucpb.tfsweb.main.other.exports

import org.apache.commons.lang.StringUtils
import org.springframework.transaction.annotation.Transactional

class DocumentEnclosedService {

    private static DOCUMENTS_ENCLOSED = [[id: 0, documentName: "Draft", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 1, documentName: "Bill of Lading", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 2, documentName: "Airway Bill of Lading", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 3, documentName: "Commercial Invoice", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 4, documentName: "Packing List", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 5, documentName: "Insurance Policy/Cerfificate", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 6, documentName: "Original Certificate", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 7, documentName: "Weight Certificate", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 8, documentName: "Clean/Tight/Fit Certificate", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 9, documentName: "Analysis", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 10, documentName: "Loading/Survey Rep.", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 11, documentName: "Beneficiary Certificate", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 12, documentName: "Inspection Certificate", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 13, documentName: "Master\'s Authority", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 14, documentName: "Heating Instructions", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 15, documentName: "Charter Party Rep.", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 16, documentName: "Customs Invoice", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
            [id: 17, documentName: "Export Declaration", original1: 0, original2: 0, duplicate1: 0, duplicate2: 0],
    ]
	
	private static DOCUMENTS_ENCLOSED_DM = [[id: 0, documentName: "Draft", original1: 0, duplicate1: 0],
		[id: 1, documentName: "Bill of Lading", original1: 0, duplicate1: 0],
		[id: 2, documentName: "Airway Bill of Lading", original1: 0, duplicate1: 0],
		[id: 3, documentName: "Commercial Invoice", original1: 0, duplicate1: 0],
		[id: 4, documentName: "Packing List", original1: 0, duplicate1: 0],
		[id: 5, documentName: "Insurance Policy/Cerfificate", original1: 0, duplicate1: 0],
		[id: 6, documentName: "Original Certificate", original1: 0, duplicate1: 0],
		[id: 7, documentName: "Weight Certificate", original1: 0, duplicate1: 0],
		[id: 8, documentName: "Beneficiary Certificate", original1: 0, duplicate1: 0],
		[id: 9, documentName: "Extra Copies", original1: 0, duplicate1: 0],
]

    private static ENCLOSED_INSTRUCTIONS = [[id: 0, instruction: "We transmit the enclosed documents for payment/ collection."],
            [id: 1, instruction: "Please deliver documents against payment/ acceptance."],
            [id: 2, instruction: "We have noted/ negotiated under reserve on account of the following discrepancies:"],
            [id: 3, instruction: "Please follow the reimbursement instructions of"],
            [id: 4, instruction: "Kindly advise us payment/ non-payment, acceptance/ non-acceptance via SWIFT (TLBPPHMM)."],
            [id: 5, instruction: "We are sending documents under Uniform Rules for Collection Publication No. 522"],
            [id: 6, instruction: "Kindly remit proceeds telegraphically to _____ for credit to our account with ______ quoting our above reference number under your telex advice to us."],
            [id: 7, instruction: "In case of dishonor, kindly advise us by cable, holding the documents at our disposal."],
            [id: 8, instruction: "We decline the responsibility whatsoever for the correctness, genuineness, validity of the documents surrendered to us for the quantity condition, description or of the respective goods."]
    ]

    def retrieveDefaultDocumentsEnclosed() {
        return DOCUMENTS_ENCLOSED
    }
    
    def retrieveDefaultDocumentsEnclosedDM() {
    	return DOCUMENTS_ENCLOSED_DM
    }

    def retrieveDefaultEnclosedInstruction() {
        return ENCLOSED_INSTRUCTIONS
    }

    def setupDocumentEnclosed(documentsEnclosedStr) {
        def tempDocumentsEnclosed = []

        def documentsEnclosedActual = []

        documentsEnclosedStr.toString().trim().replace("[[","[").replaceAll("]]","]").split("],").each { a ->
            a = a.replace("[","").replace("]","")

            def hashMap = new HashMap()

            a.split(",").each { b ->
                def map = b.split(":")

                hashMap.put(map[0].toString().trim(), map[1].toString().trim())
            }

            documentsEnclosedActual << hashMap.get("id")

            tempDocumentsEnclosed << hashMap


            //println'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
        }



        return [display: tempDocumentsEnclosed, actual: documentsEnclosedActual]
    }

    def setupEnclosedInstruction(enclosedInstructionStr) {
        def enclosedInstruction = []

        enclosedInstructionStr.toString().trim().replace("[[","[").replaceAll("]]","]").split("],").each { a ->

            a = a.replace("[","").replace("]","")

            def hashMap = new HashMap()

            a.split(", instruction:").each { b ->
                if (b.contains("id:") == true) {
                    hashMap.put("id", b.split(":")[1].toString())
                } else {
                    hashMap.put("instruction",b)
                }
            }

            enclosedInstruction << [id: hashMap.get("id"),
                    cell: [
                            hashMap.get("instruction"),
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + hashMap.get("id") + "'; editEnclosedInstruction(id);\">edit</a>"

                    ]
            ]
        }

        return enclosedInstruction
    }

    def setupAdditionalInstruction(additionalInstructionStr) {
        def additionalInstruction = []

        additionalInstructionStr.toString().trim().replace("[[","[").replaceAll("]]","]").split("],").each { a ->

            a = a.replace("[","").replace("]","")

            def hashMap = new HashMap()

            a.split(", instruction:").each { b ->
                if (b.contains("id:") == true) {
                    hashMap.put("id", b.split(":")[1].toString())
                } else {
                    hashMap.put("instruction",b)
                }
            }

            additionalInstruction << [id: hashMap.get("id"),
                    cell: [
                            hashMap.get("instruction"),
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + hashMap.get("id") + "'; editEnclosedInstruction(id);\">edit</a>",
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id='" + hashMap.get("id") + "'; deleteNewInstruction(id);\">delete</a>"
                    ]
            ]
        }

        return additionalInstruction
    }

    List<Map<String, Object>> stringToListMap(String details) {
        def returnList = []
        println "details " + details
        def listString = details.substring(1, details.length()-1)
        listString.split("],").each { a ->
            String mapString = a.toString().trim().replaceAll("\\[","").replaceAll("\\]","")
            def map = [:]

            println "mapString " + mapString

            def newMapString = ""

            mapString.trim().split(",").each { b ->
                println "b " + b
                def mapParts = b.split(":")

                def value = mapParts[1]

                if ("id".equals(mapParts[0])) {
                    try {
                        value = Integer.parseInt(mapParts[1])
                    } catch (NumberFormatException e) {
                        value = mapParts[1]
                    }
                }
                map.put(mapParts[0].toString().trim(), value)
            }

            returnList << map
        }

        return returnList
    }

    List<Map<String, Object>> stringToListMapAdditionalCondition(String details) {
        def returnList = []
        println "details " + details
        def listString = details.substring(1, details.length()-1)
        listString.split("],").each { a ->
            String mapString = a.toString().trim().replaceAll("\\[","").replaceAll("\\]","")
            def map = [:]
            println "mapString " + mapString

            mapString = mapString.replaceFirst(",", "&&")
            println "new mapString >>" + mapString

            mapString.trim().split("&&").each { b ->
                def mapParts = b.split(":")

                def value = mapParts[1].toString()

                if (value.contains("\\n")) {
                    def valueParts = value.split("\\\\n")

                    value = ""
                    for (String x : valueParts) {
                        value += x + "\n"
                    }
                }

                if ("id".equals(mapParts[0])) {
                    try {
                        value = Integer.parseInt(mapParts[1])
                    } catch (NumberFormatException e) {
                        value = mapParts[1]
                    }
                }
                map.put(mapParts[0].toString().trim(), value)
            }

            returnList << map
        }

        return returnList
    }

    List<Map<String, Object>> stringToListMapDocEnclosed(String details) {
        def returnList = []
        println "details " + details
        def listString = details.substring(1, details.length()-1)

//        int commaCount = 0;

        listString.split("],").each { a ->
            int commaCount = 0;

            String mapString = a.toString().trim().replaceAll("\\[","").replaceAll("\\]","")
            def map = [:]
            println "mapString " + mapString

            def newString = ""

            mapString.toCharArray().each { ch ->
                println "hahaha " + ch.toString()
                if (ch.toString().equals(",") && commaCount < 5) {
                    commaCount ++;
                    newString += "&&"
                } else {
                    newString += ch.toString()
                }
            }
            println "newString " + newString
//            mapString = mapString.replaceFirst(",", "&&")
//            println "new mapString >>" + mapString

            newString.split("&&").each { b ->
                println "b " + b
                def mapParts = b.split(":")
				try {
					def value = mapParts[1].toString()
				}catch (ArrayIndexOutOfBoundsException aiofbe){
					def value = " "
				}finally{
					if (value.contains("\\n")) {
						def valueParts = value.split("\\\\n")
	
						value = ""
						for (String x : valueParts) {
							value += x + "\n"
						}
					}
	
					if ("id".equals(mapParts[0])) {
						try {
							value = Integer.parseInt(mapParts[1])
						} catch (NumberFormatException e) {
							value = mapParts[1]
						}
					}
	
					println "key " + mapParts[0].toString().trim() + " = " + value
					map.put(mapParts[0].toString().trim(), value)
				}

            }
            println "map " + map
            returnList << map
        }

        return returnList
    }

    def gridSwapper(id, list, params) {
        list.each {
            if (it.id.toString().equals(id)) {
                it.cell = [
                        it.cell[0],
                        params.original1,
                        params.original2,
                        params.duplicate1,
                        params.duplicate2,
                ]
            }
        }

        return list
    }
}
