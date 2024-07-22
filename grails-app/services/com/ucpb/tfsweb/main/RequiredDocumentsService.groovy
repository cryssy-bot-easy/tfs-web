package com.ucpb.tfsweb.main

import org.springframework.transaction.annotation.Transactional


/**
 * Description:   Added methods getAllOriginalDocuments, constructOriginalDocumentsGridDisplay, getAllDocuments and getRefDocuments for fixing MT707
 * Modified by:   Cedrick C. Nungay
 * Date Modified: 08/24/18
 *
 */

class RequiredDocumentsService {

    def queryService

    def requiredDocumentsFinder = com.ucpb.tfs.application.query.documents.IRequiredDocumentFinder.class

    @Transactional(readOnly=true)
    Map<String, Object> getAllRequiredDocuments(dataEntryModel, maxRows, rowOffset, currentPage) {
        String methodName = "findAllDefaultDocuments"

        Map<String, Object> param = [tradeServiceId: dataEntryModel.tradeServiceId,
                                     documentType: dataEntryModel.documentType]

        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredDocumentsFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructRequiredDocumentsGridDisplay(display) {
        display.collect {
            [ id: it.DOCUMENTCODE,
                    cell:[
                            it.DESCRIPTION?.toUpperCase(),
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links jqgrid_lowercase\" onclick=\"var id='" + it.DOCUMENTCODE + "'; editDocsRequired(id);\">edit</a>"
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    List<String> getAllSavedRequiredDocuments(tradeServiceId) {
        String methodName = "findAllSavedRequiredDocuments"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredDocumentsFinder, methodName, param)

        if(queryResult) {
            if(queryResult.size() == 0) return []
        }else{
            return []
        }

        return queryResult['DOCUMENTCODE']
    }
    
    def constructAddedRequiredDocuments(display) {
        display.collect {
            [id: it.id,
                    cell: [
                            it.description?.toUpperCase(),
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + it.id + "\'; editAddedDocsRequired(id);\">edit</a>",
                            "<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + it.id + "\'; deleteAddedDocsRequired(id);\">delete</a>"
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    Map<String, Object> getAllSavedNewDocuments(tradeServiceId) {
        String methodName = "findAllNewDocuments"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredDocumentsFinder, methodName, param)

        def list = []
        
        queryResult.each {
            Map<String,Object> m = new HashMap<String, Object>()
            m.put("id", it.ID)
            m.put("description", it.DESCRIPTION)

            list << m
        }


        return [display: list]
    }

    public String getSavedDocumentsAsString(tradeServiceId){
        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredDocumentsFinder, "findAllSavedRequiredDocuments", [tradeServiceId: tradeServiceId])
        String requiredDocuments = "";
        queryResult.each {
            requiredDocuments = requiredDocuments + "+" + it.DESCRIPTION
        }

        return requiredDocuments;
    }

    @Transactional(readOnly=true)
    Map<String, Object> getAllOriginalDocuments(dataEntryModel, maxRows, rowOffset, currentPage) {
        String methodName = "findAllOriginalDocuments"
        Map<String, Object> param = [documentNumber: dataEntryModel.documentNumber]
        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredDocumentsFinder, methodName, param)
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructOriginalDocumentsGridDisplay(display) {
        display.collect {
            [ id: it.id,
                cell:[
                    it.DESCRIPTION?.toUpperCase()
                ]
            ]
        }
    }

    @Transactional(readOnly=true)
    List<Map<String, Object>> getAllDocuments(dataEntryModel) {
        String methodName = "findAllDocuments"
        Map<String, Object> param = [documentNumber: dataEntryModel.documentNumber,
                                     tradeServiceId: dataEntryModel.tradeServiceId,
                                     documentType: dataEntryModel.documentType]
        return queryService.executeQuery(requiredDocumentsFinder, methodName, param)
    }

    @Transactional(readOnly=true)
    List<Map<String, Object>> getRefDocuments(dataEntryModel) {
    	String methodName = "findDefaultDocuments"
        Map<String, Object> param = [documentNumber: dataEntryModel.documentNumber,
                                     documentType: dataEntryModel.documentType]
		return queryService.executeQuery(requiredDocumentsFinder, methodName, param)
    }

    @Transactional(readOnly=true)
    List<String> getAllRequiredDocument(dataEntryModel) {
        String methodName = "findAllRequiredDocument"
        Map<String, Object> param = [tradeServiceId: dataEntryModel.tradeServiceId]
		return queryService.executeQuery(requiredDocumentsFinder, methodName, param)
    }
}
