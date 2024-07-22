package com.ucpb.tfsweb.main

import grails.converters.JSON

class SwiftChargeController {

    def swiftChargeService

    def displayAllSwiftCharges() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = swiftChargeService.findAllSwiftCharges(session.dataEntryModel?.tradeServiceId, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = swiftChargeService.constructSwiftChargeDisplay(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def getAllSavedSwiftCharges() {
        def result = swiftChargeService.findAllSavedSwiftCharges(session.dataEntryModel.tradeServiceId)

        def jsonData = [code: result.code, currency: result.currency]

        render jsonData as JSON
    }
}
