package com.ucpb.tfsweb.main

import grails.converters.JSON


/**
 * Description:   Added methods findAllOriginalConditions, getAllConditions and getRefConditions for fixing MT707
 * Modified by:   Cedrick C. Nungay
 * Date Modified: 09/04/18
 *
 */
class AdditionalConditionController {

    def additionalConditionService
    def parserService

    def dataEntryService

    def findAllAdditionalConditions() {
        session.addedConditionsList = []

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = additionalConditionService.getAllAdditionalConditions(session.dataEntryModel, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)		
        def results = additionalConditionService.constructAdditionalConditionsGridDisplay(mapList.display, (session.dataEntryModel.discrepancyAmount ?: '60.00'), (session.dataEntryModel.discrepancyCurrency ?: 'USD'), session.dataEntryModel.availableWithFlag, session.dataEntryModel.availableWithLabel, session.dataEntryModel.nameAndAddress)
 
        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def findAllSavedAdditionalConditions() {
        def result = additionalConditionService.getAllSavedAdditionalConditions(session.dataEntryModel.tradeServiceId)

        def jsonData = [conditionCode: result]

        render jsonData as JSON
    }

    def findAllAddedConditions() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def ml = additionalConditionService.getAllSavedNewCondition(session.dataEntryModel.tradeServiceId)

        if (params.addedCondition) {
            def m = JSON.parse(params.addedCondition)

            Map<String, Object> map = new HashMap<String, Object>()

            map.put("id", m.id)
            map.put("condition", m.condition)

            session.addedConditionsList << map

            params.remove("addedCondition")
        } else if(params.updatedCondition) {
            def updatedCondition = JSON.parse(params.updatedCondition)
            def newAddedList = []

            session.addedConditionsList.each {
                if (updatedCondition.id != it.id) {
                    newAddedList << it
                }
            }
            session.addedConditionsList.clear()
            session.addedConditionsList.addAll(newAddedList)
            session.addedConditionsList << updatedCondition

            params.remove("updatedCondition")
        } else if(params.deletedCondition) {
            String deletedCondition = params.deletedCondition
            def newList = []
            session.addedConditionsList.each {
                if (deletedCondition != it.id) {
                    newList << it
                }
            }

            session.addedConditionsList.clear()
            session.addedConditionsList.addAll(newList)

            params.remove("deletedCondition")
        } else {
            ml.display.each{
                if(!session.addedConditionsList.contains(it)) {
                    session.addedConditionsList << it
                }
            }
        }

        Integer toIndex = ((currentPage * maxRows) < session.addedConditionsList?.size()) ? (currentPage * maxRows) : session.addedConditionsList?.size()
        def mapList = [display: session.addedConditionsList?.subList(rowOffset, toIndex), totalRows: session.addedConditionsList?.size()]


        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = additionalConditionService.constructAddedAdditionalConditions(mapList.display)


        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def getAllAddedConditions() {
        def arr = []
        session.addedConditionsList.each { map ->
            Map<String,Object> m = new HashMap<String, Object>()
            m.put("condition", map.get("condition"))
            m.put("conditionType", "NEW")
            arr.add(m)
        }

        render([addedConditionsList: arr] as JSON)
    }

    def findAllOriginalConditions() {
        session.addedList = []

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = additionalConditionService.getAllOriginalConditions(session.dataEntryModel, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?:0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = additionalConditionService.constructOriginalConditionsGridDisplay(mapList.display)

        def jsonData = 
        render ([rows: results, page: currentPage, records: totalRows, total: numberOfPages] as JSON)
    }

    def getAllConditions() {
        def results = additionalConditionService.getAllConditions(session.dataEntryModel).collect { r ->
            [
                conditionCode: r.CONDITIONCODE ?: '',
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

    def getRefConditions() {
        def results = additionalConditionService.getRefConditions(session.dataEntryModel).collect { r ->
            [
                conditionCode: r.CONDITIONCODE ?: '',
                description: r.DESCRIPTION?.toUpperCase()
            ]
        }
        render ([results: results] as JSON)
    }

}
