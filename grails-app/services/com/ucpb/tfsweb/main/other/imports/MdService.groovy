package com.ucpb.tfsweb.main.other.imports

import net.ipc.utils.NumberUtils
import com.ucpb.tfs.application.command.ToggleMarginalDepositPnSupportCommand

class MdService {

    def queryService
    def commandService
    def commandBusService

    def marginalDepositFinder = com.ucpb.tfs.application.query.settlementaccount.IMarginalDepositFinder.class

    Map<String, Object> findAllMdCollection(maxRows, rowOffset, currentPage, params) {
        String methodName = "mdCollectionInquiry"

        Map<String, Object> param = [documentNumber: params.documentNumber?.trim() ?: "",
                                     cifName: params.cifName ? "%" + params.cifName.trim().toUpperCase() + "%" : "",
							 		 unitcode: params.unitcode ?: "",
									 unitCode: params.unitCode ?: ""
        ]

        List<Map<String, Object>> queryResult = queryService.executeQuery(marginalDepositFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size() ?: 0]
    }

    Map<String, Object> findAllMdApplication(maxRows, rowOffset, currentPage, params) {
        String methodName = "mdApplicationInquiry"
                        
        Map<String, Object> param = [documentNumber: params.documentNumber?.trim() ?: "",
                cifName: params.clientName ? "%" + params.clientName.trim().toUpperCase() + "%" : "",
                expiryDate: params.expiryDate ?: "",
                status: params.status ?: "",
				unitcode: params.unitcode ?: "",
				unitCode: params.unitCode ?: ""
        ]

        ////println"param >> " + param

        List<Map<String, Object>> queryResult = queryService.executeQuery(marginalDepositFinder, methodName, param)

        // query by status = paid or oustanding
        if(params.status?.equalsIgnoreCase("PAID")) {
            Iterator listIterator = queryResult.iterator()

            while(listIterator.hasNext()) {
                Map<String, Object> map = listIterator.next()

                BigDecimal outstandingAmount = 0
                BigDecimal debitAmount = 0
                BigDecimal creditAmount = 0

                Iterator mapIterator = map.entrySet().iterator()
                while(mapIterator.hasNext()){
                    Map.Entry pairs = (Map.Entry) mapIterator.next()

                    if(pairs.getKey()?.equalsIgnoreCase("DAMT")) {
                        debitAmount = pairs.getValue()
                    }

                    if(pairs.getKey()?.equalsIgnoreCase("CAMT")) {
                        creditAmount = pairs.getValue()
                    }
                }

                outstandingAmount = creditAmount - debitAmount

                if(outstandingAmount > 0) {
                    listIterator.remove()
                }
            }
        }
        println queryResult
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size() ?: 0]
    }

    def constructOutstandingBalance(display) {
        def list = display.collect {
            UUID uuid = UUID.randomUUID()
            String id = String.valueOf(uuid)

            BigDecimal outstandingAmount = 0
            BigDecimal debitAmount = it.DAMT ?: 0
            BigDecimal creditAmount = it.CAMT ?: 0

            outstandingAmount = creditAmount - debitAmount

            String currency = it.CCCY ?: it.DCCY
            
            [id: id,
                    cell:[
                            currency,
                            NumberUtils.currencyFormat(outstandingAmount.doubleValue())
                    ]
            ]
        }

        return list
    }

    Boolean togglePnSupport(params) {
        ToggleMarginalDepositPnSupportCommand command = new ToggleMarginalDepositPnSupportCommand()
        
        Map<String, Object> parameterMap = new HashMap<String, Object>()

        params.each {
            if(!it.key.equalsIgnoreCase("controller") && !it.key.equalsIgnoreCase("action")){
                parameterMap.put(it.key, it.value)
            }
        }
        
        command.setParameterMap(parameterMap)

        try {
            commandBusService.dispatch(command)
        } catch (Exception e) {
            e.printStackTrace()
            return false
        }

        return true
    }

    def getTotalMd(currency, documentNumber) {
        List<Map<String, Object>> queryResult = queryService.executeQuery(marginalDepositFinder, "getTotalMd", [currency: currency ?: "", documentNumber: documentNumber ?: ""])
        //printlnqueryResult
        return queryResult
    }

}
