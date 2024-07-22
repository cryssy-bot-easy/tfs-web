package com.ucpb.tfsweb.main

import org.springframework.transaction.annotation.Transactional

class InstructionToBankService {

    def queryService

    def instructionToBankFinder = com.ucpb.tfs.application.query.reimbursing.IInstructionToBankFinder.class

    @Transactional(readOnly=true)
    Map<String, Object> findAllDefaultInstructionsToBank(tradeServiceId, maxRows, rowOffset, currentPage) {
        String methodName = "findAllDefaultInstructionToBank"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(instructionToBankFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructInstructionsToBankGrid(display, lcNumber) {
        display.collect {
			String instructionToBank = it.INSTRUCTION
			
			if(instructionToBank.contains("(LCNUMBER)")) {

				if(lcNumber != null && lcNumber != "") {
					instructionToBank = instructionToBank.replace("(LCNUMBER)", lcNumber).replaceAll("-", "")
				}
			}
			
			
			
            [id: it.INSTRUCTIONTOBANKCODE,
                    cell:[
                            instructionToBank,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.INSTRUCTIONTOBANKCODE + "'; onEditInstructionsToBank(id);\">edit</a>"
                    ]
            ]
        }
    }

    @Transactional(readOnly=true)
    List<String> findAllSavedInstructionsToBank(tradeServiceId) {
        String methodName = "findAllSavedInstructionToBank"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(instructionToBankFinder, methodName, param)

        if(queryResult) {
            if(queryResult.size() == 0) return []
        }else{
            return []
        }

        return queryResult["INSTRUCTIONTOBANKCODE"]
    }

    @Transactional(readOnly=true)
    List<String> findAllSavedLcInstructionsToBank(documentNumber) {
        String methodName = "findAllSavedLcInstructionToBank"

        Map<String, Object> param = [documentNumber: documentNumber]

        List<Map<String, Object>> queryResult = queryService.executeQuery(instructionToBankFinder, methodName, param)

        if(queryResult) {
            if(queryResult.size() == 0) return []
        }else{
            return []
        }

        return queryResult["INSTRUCTIONTOBANKCODE"]
    }
}
