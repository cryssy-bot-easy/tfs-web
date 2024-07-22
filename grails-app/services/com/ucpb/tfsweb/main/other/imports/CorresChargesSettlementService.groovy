package com.ucpb.tfsweb.main.other.imports

class CorresChargesSettlementService {

    def coreAPIService
    
    Map<String, Object> findAllCorresCharges(maxRows, rowOffset, currentPage, params) {

        def queryResult = coreAPIService.sendQuery("findCorresCharges", [documentNumber: params.documentNumber ?: ""])

        Integer toIndex = ((currentPage * maxRows) < queryResult?.response?.size()) ? (currentPage * maxRows) : queryResult?.response?.size()
        return [display: queryResult?.response?.subList(rowOffset, toIndex), totalRows: queryResult?.response?.size()]
    }

    Map<String, Object> findAllAdvanceCorresCharges(maxRows, rowOffset, currentPage, params) {

        def queryResult = coreAPIService.dummySendQuery(params, "search", "corresCharge/advance/").details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
    
    Map<String, Object> findCorresCharge(documentNumber) {
        def queryResult = coreAPIService.sendQuery("findCorresChargeByDocumentNumber", [documentNumber: documentNumber])

        Map<String, Object> corresCharge = queryResult?.response[0]

        return corresCharge
    }
}
