package com.ucpb.tfsweb.main.other.imports

class ArService {

    def queryService
    def commandService
    def commandBusService

    def arFinder = com.ucpb.tfs.application.query.settlementaccount.IAccountsReceivableFinder.class

    Map<String, Object> findAllAccountsReceivable(maxRows, rowOffset, currentPage, params) {
        String methodName = "arMonitoringInquiry"

        Map<String, Object> param = [referenceNumber: params.referenceNumber ?: "",
				cifName: params?.cifNameSearch?.toUpperCase() ?: "",
                status: params.status ?: "",
                documentNumber: params.documentNumber ?: "",
        		unitCode: params.unitCode ?: "",
                unitcode: params.unitcode ?: ""
        ]
		println "paramsz: "+param
        List<Map<String, Object>> queryResult = queryService.executeQuery(arFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    Map<String, Object> findAccountsReceivable(id) {
        String methodName = "findAccountsReceivable"

        Map<String, Object> param = [id: id]

        Map<String, Object> queryResult = queryService.executeQuery(arFinder, methodName, param)

        Map<String, Object> ar = new HashMap<String, Object>()

        ap.put("cifNumber", queryResult[0].CIFNUMBER)
        ap.put("modifiedDate", queryResult[0].MODIFIEDDATE)
        ap.put("settlementAccountNumber", queryResult[0].SETTLEMENTACCOUNTNUMBER)
        ap.put("settlementAccountType", queryResult[0].SETTLEMENTACCOUNTTYPE)
        ap.put("status", queryResult[0].STATUS)

        return ap
    }

    List<Map<String, Object>> findAllAccountsReceivableByCifNumber(cifNumber) {
        String methodName = "findAllAccountsReceivableByCifNumber"
        Map<String, Object> param = [cifNumber: cifNumber]

        List<Map<String, Object>> queryResult = queryService.executeQuery(arFinder, methodName, param)

        return queryResult
    }

    Map<String, Object> findAllAccountsReceivableByDocumentNumber(maxRows, rowOffset, currentPage, params) {
        String methodName = "findAllMultipleAccountsReceivable"
        ////println"hello"
        Map<String, Object> param = [documentNumber: params.documentNumber ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(arFinder, methodName, param)
        ////printlnqueryResult
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructArByDocumentNumber(display) {
        display.collect {

            [id: it.ID,
                    cell:[
                            it.REFERENCETYPE,
                            it.CURRENCY,
                            it.AMOUNT
                    ]
            ]
        }
    }
}
