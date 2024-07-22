package com.ucpb.tfsweb.main

class ExportAdvisingService {

    def coreAPIService

    def queryService

    def tradeServiceFinder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class;

    def searchExportAdvising(paramMap, maxRows, currentPage, rowOffset) {
        def queryResult = coreAPIService.dummySendQuery(paramMap, "search", "exportAdvising/").details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def getExportAdvising(documentNumber) {
        Map<String, Object> queryResult = coreAPIService.dummySendQuery(null, (String) documentNumber, "product/", "exportAdvising/", "details/").details

        return queryResult
    }

    def searchExportAdvisingForPayment(paramMap, maxRows, currentPage, rowOffset) {
        def queryResult = queryService.executeQuery(tradeServiceFinder, "findAllExportAdvisingForPayment", paramMap)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
	
	def replaceDocumentSubType1ExportAdvising(String documentSubType1){
		switch(documentSubType1){
			case "FIRST_ADVISING":
				return "1st Advising"
				break;
			case "SECOND_ADVISING":
				return "2nd Advising"
				break;
			default:
				return ""
				break;
		}
	}
}