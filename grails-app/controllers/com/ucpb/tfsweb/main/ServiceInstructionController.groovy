package com.ucpb.tfsweb.main

import grails.converters.JSON

class ServiceInstructionController {
    
    def serviceInstructionService
    def documentClassService

    def constructEtsCreatePopup() {

        Map<String, Object> documentMap = new HashMap<String, Object>()

        switch (params.documentClass) {
            case "LC":
                documentMap = documentClassService.getLetterOfCreditCriteria(params.documentNumber)
        }

        Map<String, Object> availableServices = serviceInstructionService.constructServiceAvailable(params.documentClass, documentMap, params.accessFrom)

        def jsonData = [:]//availableServices
        jsonData = [radioItems: availableServices, productStatus: documentMap.get("productStatus")]
        
        render jsonData as JSON
    }
}
