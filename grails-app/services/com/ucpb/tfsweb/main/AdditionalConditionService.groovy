package com.ucpb.tfsweb.main

import org.springframework.transaction.annotation.Transactional
import net.ipc.utils.NumberUtils


/**
 * Description:   Added methods getAllOriginalConditions, constructOriginalConditionsGridDisplay, getAllConditions and getRefConditions for fixing MT707
 * Modified by:   Cedrick C. Nungay
 * Date Modified: 09/04/18
 *
 */
class AdditionalConditionService {

    def queryService

    def requiredConditionFinder = com.ucpb.tfs.application.query.condition.IAdditionalConditionFinder.class

    @Transactional(readOnly=true)
    Map<String, Object> getAllAdditionalConditions(dataEntryModel, maxRows, rowOffset, currentPage) {
        String methodName = "findAllDefaultAdditionalCondition"

        Map<String, Object> param = [tradeServiceId: dataEntryModel.tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredConditionFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructAdditionalConditionsGridDisplay(display, discrepancyFee, discrepancyCurrency, confirmingFlag, confirmingBankA, confirmingBankB) {
        display.collect {
            String condition = it.CONDITION

            if(condition.contains("(extracted from Discrepancy Fee field)")) {
                //condition = condition.replace("(extracted from Discrepancy Fee field)", "")

                if(discrepancyFee != null && discrepancyFee != "") {
                    condition = condition.replace("(extracted from Discrepancy Fee field)", discrepancyCurrency + " " + NumberUtils.currencyFormat(new Double(discrepancyFee)))
                }
            }
									
			if(condition.contains("(extracted from Available With field)")) {
				if(confirmingFlag != null) {
					if(confirmingFlag == 'A' && (confirmingBankA != null && confirmingBankA != "")) {
						condition = condition.replace("(extracted from Available With field)", confirmingBankA)
					} else {
						condition = condition.replace("(extracted from Available With field)", confirmingBankB)
					}
				}
			}
            
            [ id: it.CONDITIONCODE,
                    cell:[
                            condition,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.CONDITIONCODE + "'; editAdditionalCondition(id);\">edit</a>"
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    List<String> getAllSavedAdditionalConditions(tradeServiceId) {
        String methodName = "findAllSavedAdditionalCondition"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredConditionFinder, methodName, param)

        if(queryResult) {
            if(queryResult.size() == 0) return []
        }else{
            return []
        }

        return queryResult['CONDITIONCODE']
    }

    public String getSavedAdditionalConditionsAsString(tradeServiceId){
        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredConditionFinder, "findAllSavedAdditionalCondition", [tradeServiceId: tradeServiceId])
        String additionalConditions = "";
        queryResult.each {
            additionalConditions = additionalConditions + "+" + it.CONDITION
        }

        return additionalConditions;
    }

    def constructAddedAdditionalConditions(display) {
        display.collect {
            [id: it.id,
                    cell: [
                            it.condition.toUpperCase(),
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + it.id + "\'; editAddedAdditionalCondition(id);\">edit</a>",
                            "<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + it.id + "\'; deleteAddedAdditionalCondition(id);\">delete</a>"
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    Map<String, Object> getAllSavedNewCondition(tradeServiceId) {
        String methodName = "findAllNewAdditionalCondition"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredConditionFinder, methodName, param)

        def list = []

        queryResult.each {
            Map<String,Object> m = new HashMap<String, Object>()
            m.put("id", it.ID)
            m.put("condition", it.CONDITION)

            list << m
        }
        return [display: list]
    }

    @Transactional(readOnly=true)
    Map<String, Object> getAllOriginalConditions(dataEntryModel, maxRows, rowOffset, currentPage) {
        String methodName = "findAllOriginalConditions"
        Map<String, Object> param = [documentNumber: dataEntryModel.documentNumber]
        List<Map<String, Object>> queryResult = queryService.executeQuery(requiredConditionFinder, methodName, param)
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructOriginalConditionsGridDisplay(display) {
        display.collect {
            [ id: it.id,
                    cell:[
                            it.CONDITION?.toUpperCase()
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    List<Map<String, Object>> getAllConditions(dataEntryModel) {
        String methodName = "findAllConditions"
        Map<String, Object> param = [documentNumber: dataEntryModel.documentNumber,
									 tradeServiceId: dataEntryModel.tradeServiceId]
        return queryService.executeQuery(requiredConditionFinder, methodName, param)
    }

    @Transactional(readOnly=true)
    List<Map<String, Object>> getRefConditions(dataEntryModel) {
    	String methodName = "findDefaultConditions"
		Map<String, Object> param = [documentNumber: dataEntryModel.documentNumber]
		return queryService.executeQuery(requiredConditionFinder, methodName, param)
    }

    @Transactional(readOnly=true)
    List<String> getAllAdditionalCondition(dataEntryModel) {
        String methodName = "findAllAdditionalConditions"
        Map<String, Object> param = [tradeServiceId: dataEntryModel.tradeServiceId]
		return queryService.executeQuery(requiredConditionFinder, methodName, param)
    }
}
