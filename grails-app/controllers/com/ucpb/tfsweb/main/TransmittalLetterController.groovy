package com.ucpb.tfsweb.main

import com.google.gson.JsonObject
import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.JSONObject

class TransmittalLetterController {
    
    def transmittalLetterService

    def findAllTransmittalLetter() {
        session.addedTransmittalLetterList = []

        def maxRows = params.int('rows') ?: 1000
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = transmittalLetterService.getAllTransmittalLetter(session.dataEntryModel, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = transmittalLetterService.constructTransmittalLettersGridDisplay(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def findAllSavedTransmittalLetters() {
        def result = transmittalLetterService.getAllSavedTransmittalLetters(session.dataEntryModel.tradeServiceId)

        def jsonData = [transmittalLetterCode: result]

        render jsonData as JSON
    }

    def findAllAddedLetter() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def ml = transmittalLetterService.getAllSavedNewTransmittalLetter(session.dataEntryModel.tradeServiceId)

        if (params.addedLetter != null) {
            println "addedLetter"

            def m = JSON.parse(params.addedLetter)

            if (m.id && JSONObject.NULL.equals(m.get("id")) != true) {
                Map<String, Object> map = new HashMap<String, Object>()

                map.put("id", m.id)
                map.put("letterDescription", m.letterDescription)
                map.put("originalCopy", m.originalCopy)
                map.put("duplicateCopy", m.duplicateCopy)

                session.addedTransmittalLetterList << map

                params.remove("addedLetter")
            }
        } else if(params.updatedLetter != null) {
            println "updatedLetter"
            def updatedLetter = JSON.parse(params.updatedLetter)

            if (updatedLetter.id && JSONObject.NULL.equals(updatedLetter.get("id")) != true) {

                def newAddedList = []

                session.addedTransmittalLetterList.each {
                    if (updatedLetter.id != it.id) {
                        newAddedList << it
                    }
                }
                session.addedTransmittalLetterList.clear()
                session.addedTransmittalLetterList.addAll(newAddedList)
                session.addedTransmittalLetterList << updatedLetter

                params.remove("updatedLetter")
            }
        } else if(params.deletedLetter != null) {
            println "deletedLetter"

            String deletedLetter = params.deletedLetter
            def newList = []
            session.addedTransmittalLetterList.each {
                if (deletedLetter != it.id) {
                    newList << it
                }
            }

            session.addedTransmittalLetterList.clear()
            session.addedTransmittalLetterList.addAll(newList)

            params.remove("deletedLetter")
        } else {
            println 'i am here'
            ml.display.each{
                if(!session.addedTransmittalLetterList.contains(it)) {
                    session.addedTransmittalLetterList << it
                }
            }
        }

        Integer toIndex = ((currentPage * maxRows) < session.addedTransmittalLetterList?.size()) ? (currentPage * maxRows) : session.addedTransmittalLetterList?.size()
        def mapList = [display: session.addedTransmittalLetterList?.subList(rowOffset, toIndex), totalRows: session.addedTransmittalLetterList?.size()]


        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = transmittalLetterService.constructAddedTransmittalLetter(mapList.display)


        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def getAllAddedLetters() {
        def arr = []
        session.addedTransmittalLetterList.each { map ->

            Map<String,Object> m = new HashMap<String, Object>()
            m.put("letterDescription", map.get("letterDescription"))
            m.put("letterType", "NEW")
            m.put("originalCopy", map.get("originalCopy"))
            m.put("duplicateCopy", map.get("duplicateCopy"))
            arr.add(m)
        }

        render([addedLettersList: arr] as JSON)
    }    
}
