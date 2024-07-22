package com.ucpb.tfsweb.main.other.imports

class ApService {

    def queryService
    def commandService
    def commandBusService
//    def inquiryService

    def apFinder = com.ucpb.tfs.application.query.settlementaccount.IAccountsPayableFinder.class

    Map<String, Object> findAllAccountsPayable(maxRows, rowOffset, currentPage, params) {
        String methodName = "apMonitoringInquiry"

        Map<String, Object> param = [referenceNumber: params.referenceNumber ?: "",
									 cifName: params?.cifNameSearch?.toUpperCase() ?: "",
									 status: params.status ?: "",
                                     documentNumber: params.documentNumber ?: "",
                            		 natureOfTransaction: params.natureOfTransaction ?: "",
                    				 unitCode: params.unitCode ?: "",
									 unitcode: params.unitcode ?: ""
        ]
		println "params: "+param

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
    
    Map<String, Object> findAccountsPayable(id) {
        String methodName = "findAccountsPayable"
        
        Map<String, Object> param = [id: id]
        
        Map<String, Object> queryResult = queryService.executeQuery(apFinder, methodName, param)
        ////println"hhahahaha"+queryResult
        Map<String, Object> ap = new HashMap<String, Object>()

        ap.put("cifNumber", queryResult[0].CIFNUMBER)
        ap.put("modifiedDate", queryResult[0].MODIFIEDDATE)
        ap.put("settlementAccountNumber", queryResult[0].SETTLEMENTACCOUNTNUMBER)
        ap.put("settlementAccountType", queryResult[0].SETTLEMENTACCOUNTTYPE)
        ap.put("status", queryResult[0].STATUS)

        return ap
    }
    
    List<Map<String, Object>> findAllAccountsPayableByCifNumber(cifNumber, currency) {
        String methodName = "findAllApByCifNumberAndCurrency"
        Map<String, Object> param = [cifNumber: cifNumber, currency: currency]

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        return queryResult
    }

    Map<String, Object> findAllAccountsPayableByDocumentNumber(maxRows, rowOffset, currentPage, params) {
        String methodName = "findAllMultipleAccountsPayable"

        Map<String, Object> param = [documentNumber: params.documentNumber ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
    
    def constructApByDocumentNumber(display) {
        display.collect {

            [id: it.ID,
                    cell:[
                            it.REFERENCETYPE,
//                            it.SERVICETYPE ? inquiryService.getServiceType(it.SERVICETYPE) : "",
                            it.CURRENCY,
                            it.AMOUNT
                    ]
            ]
        }
    }

    def findAllApByCifNumberAndCurrency(cifNumber, currency) {
        String methodName = "findAllApByCifNumberAndCurrency"
        Map<String, Object> param = [cifNumber: cifNumber, currency: currency]

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        return queryResult
    }

    def findAllApBySettlementAcctNo(cifNumber, currency, settlementAccountNumber) {
        String methodName = "findAllApBySettlementAcctNo"
        Map<String, Object> param = [cifNumber: cifNumber, currency: currency, settlementAccountNumber: settlementAccountNumber]

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        return queryResult
    }

    def findMultipleAp(maxRows, rowOffset, currentPage, params) {
        String methodName = "findAllApBySettlementAcctNo"

        Map<String, Object> param = [cifNumber: params.cifNumber ?: "",
                                     currency: params.currency ?: "",
                                     settlementAccountNumber: params.settlementAccountNumber ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def findAllApById(id) {
        String methodName = "findAllApById"
        Map<String, Object> param = [id: id]

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        return queryResult
    }
}
