package com.ucpb.tfsweb.main

import grails.converters.JSON

class InstructionToBankController {

    def instructionToBankService

    def findAllInstructionsToBank() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = instructionToBankService.findAllDefaultInstructionsToBank(session.dataEntryModel.tradeServiceId, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = instructionToBankService.constructInstructionsToBankGrid(mapList.display, session.dataEntryModel.documentNumber)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def findAllSavedInstructionsToBank() {
        def result = instructionToBankService.findAllSavedInstructionsToBank(session.dataEntryModel.tradeServiceId)
        //printlnresult
        def jsonData = [instructionsToBankCode: result]

        render jsonData as JSON
    }

    def findAllSavedLcInstructionsToBank() {
        def result = instructionToBankService.findAllSavedLcInstructionsToBank(session.dataEntryModel.documentNumber)
        //printlnresult
        def jsonData = [instructionsToBankCode: result]

        render jsonData as JSON
    }

}
