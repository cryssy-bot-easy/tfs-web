package com.ucpb.tfsweb.main

import org.springframework.transaction.annotation.Transactional
import net.ipc.utils.NumberUtils

class SwiftChargeService {

    def queryService
    def swiftChargeFinder = com.ucpb.tfs.application.query.swift.ISwiftChargeFinder.class

    @Transactional(readOnly=true)
    def findAllSwiftCharges(tradeServiceId, maxRows, rowOffset, currentPage) {
        String methodName = "findAllDefaultSwiftCharge"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(swiftChargeFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructSwiftChargeDisplay(display) {
        display.collect {
            [ id: it.CODE,
                    cell:[
                            it.CODE,
//                            "<select name='swiftCurrency' class='select_dropdown swiftCurrency' id='swiftCurrency' value='"+it.CURRENCY+"'/>",
                            "<input type='text' name='swiftCurrency' class='defCcy' value='"+it.CURRENCY+"' />",
                            "<input type='text' name='swiftAmount' class='defAmount' value='"+NumberUtils.currencyFormat(it.AMOUNT)+"' />"
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    def findAllSavedSwiftCharges(tradeServiceId) {
        String methodName = "findAllSavedSwiftCharge"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(swiftChargeFinder, methodName, param)

        if(queryResult) {
            if(queryResult.size() == 0) return []
        }else{
            return []
        }

        return [code: queryResult['CODE'], currency: queryResult['CURRENCY']]
    }
}
