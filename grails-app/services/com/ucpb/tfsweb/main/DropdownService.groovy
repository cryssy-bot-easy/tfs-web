package com.ucpb.tfsweb.main

import com.incuventure.cqrs.query.QueryItem

class DropdownService {

    def queryService
    def queryBusService
    
    def finder = com.ucpb.tfs.application.query.SelectBoxDataProvider.class

    def initializeDropdowns() {
        String methodName = "getAllProductSelectData"
        
        try {
            QueryItem qi = new QueryItem("data", finder, methodName)
            List<QueryItem> qis = new ArrayList<QueryItem>()
            qis.add(qi)

            HashMap<String, Object> returnValues = queryBusService.dispatch(qis)

            return returnValues.data.LetterOfCredit
        } catch(NoSuchMethodException nsme) {
	    ////println"TEST ...................... "
            nsme.printStackTrace()
        }
    }

}
