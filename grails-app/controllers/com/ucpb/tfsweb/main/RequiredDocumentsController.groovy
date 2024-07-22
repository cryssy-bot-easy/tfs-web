package com.ucpb.tfsweb.main

import grails.converters.JSON
import net.sf.json.JSONObject

/**
 * User: Marv
 * Date: 10/10/12
 */

/**
 * Description:   Added methods findAllOriginalDocuments, getAllDocuments and getRefDocuments for fixing MT707
 * Modified by:   Cedrick C. Nungay
 * Date Modified: 08/24/18
 *
 */

class RequiredDocumentsController {

    def requiredDocumentsService
    def parserService

    def dataEntryService

    def findAllRequiredDocuments() {
        session.addedList = []

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = requiredDocumentsService.getAllRequiredDocuments(session.dataEntryModel, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = requiredDocumentsService.constructRequiredDocumentsGridDisplay(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def findAllSavedRequiredDocuments() {
        def result = requiredDocumentsService.getAllSavedRequiredDocuments(session.dataEntryModel.tradeServiceId)

        def jsonData = [documentCode: result]

        render jsonData as JSON
    }

    def findAllAddedDocuments() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def ml = requiredDocumentsService.getAllSavedNewDocuments(session.dataEntryModel.tradeServiceId)
		
		println "addedDocuments"+params.addedDocuments
		println "updatedDocs"+params.updatedDocuments
		println "deletedDocus"+params.deletedDocument
		
        if (params.addedDocuments) {
            def m = JSON.parse(params.addedDocuments)

            Map<String, Object> map = new HashMap<String, Object>()

            map.put("id", m.id)
            map.put("description", m.description)
			
			if(!session.addedList.contains(map)) {
				session.addedList << map
			}

            params.remove("addedDocuments")
        } else if(params.updatedDocuments) {
            def updatedDocument = JSON.parse(params.updatedDocuments)
            def newAddedList = []

            session.addedList.each {
                if (updatedDocument.id != it.id) {
                    newAddedList << it
                }
            }
            session.addedList.clear()
            session.addedList.addAll(newAddedList)
            session.addedList << updatedDocument

            params.remove("updatedDocuments")
        } else if(params.deletedDocument) {
            String deletedDocument = params.deletedDocument
            def newList = []
            session.addedList.each {
                if (deletedDocument != it.id) {
                    newList << it
                }
            }
			println "newList"+newList
            session.addedList.clear()
            session.addedList.addAll(newList)

            params.remove("deletedDocument")
        } else {
            ml.display.each{
				println "IT"+it
				if(!session.addedList.contains(it)) {
					session.addedList << it
				}
            }
			println "SESSION ADDED LIST"+session.addedList
        }
//        ////println"session.addedList >> " + session.addedList
        Integer toIndex = ((currentPage * maxRows) < session.addedList?.size()) ? (currentPage * maxRows) : session.addedList?.size()
        def mapList = [display: session.addedList?.subList(rowOffset, toIndex), totalRows: session.addedList?.size()]


        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = requiredDocumentsService.constructAddedRequiredDocuments(mapList.display)


        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
    
    def getAllAddedDocuments() {
        def arr = []

        session.addedList.each { map ->
            Map<String,Object> m = new HashMap<String, Object>()
            m.put("description", map.get("description"))
            m.put("requiredDocumentType", "NEW")
            arr.add(m)
        }

        render([addedList: arr] as JSON)
    }

    def findAllOriginalDocuments() {
        session.addedList = []

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = requiredDocumentsService.getAllOriginalDocuments(session.dataEntryModel, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = requiredDocumentsService.constructOriginalDocumentsGridDisplay(mapList.display)

        render ([rows: results, page: currentPage, records: totalRows, total: numberOfPages] as JSON)
    }

    def getAllDocuments() {
        def results = requiredDocumentsService.getAllDocuments(session.dataEntryModel).collect { r ->
            [
                documentCode: r.DOCUMENTCODE ?: '',
                description: r.DESCRIPTION?.toUpperCase(),
                amendCode: r.AMENDCODE ?: '',
                isChecked: r.ISCHECKED == 'Y',
                isLcSaved: r.ISLCSAVED == 'Y',
                isNew: r.ISNEW == 'Y',
                isForModify: r.ISFORMODIFY == 'Y',
                isDisabled: false
            ]
        }
        render ([results: results] as JSON)
    }

    def getRefDocuments() {
        def results = requiredDocumentsService.getRefDocuments(session.dataEntryModel).collect { r ->
            [
                documentCode: r.DOCUMENTCODE ?: '',
                description: r.DESCRIPTION?.toUpperCase()
            ]
        }
    	render ([results: results] as JSON)
    }
}
