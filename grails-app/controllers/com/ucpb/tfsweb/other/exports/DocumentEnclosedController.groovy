package com.ucpb.tfsweb.other.exports

import grails.converters.JSON

class DocumentEnclosedController {

    def coreAPIService
    def documentEnclosedService
    def parserService

    def displayDocumentsEnclosedDM() {
        def maxRows = params.int("rows") ?: 10
        def currentPage = params.int("page") ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def gridDisplay = []

        if (params.documentName) {
            UUID uuid = UUID.randomUUID()
            String id = String.valueOf(uuid).toString().substring(0, 8)

            session.dataEntryModel.documentsEnclosed << [id: id,
                    documentName: params.documentName,
                    original1: 0,
                    duplicate1: 0
            ]
        }

        session.dataEntryModel.documentsEnclosed.each {
            gridDisplay << [
                    id: it.id,
                    cell: [
                            it.documentName,
                            it.original1,
                            it.duplicate1
                    ]
            ]
        }

        def documentsEnclosed = documentEnclosedService.retrieveDefaultDocumentsEnclosedDM()
        def unionList = parserService.getMapListNotIn(session.dataEntryModel.documentsEnclosed ? session.dataEntryModel.documentsEnclosed.id : [], documentsEnclosed)

        unionList.each {
            gridDisplay << [
                id: it.id,
                    cell: [
                        it.documentName,
                        it.original1,
                        it.duplicate1
                    ]
            ]
        }

        Integer toIndex = ((currentPage * maxRows) < gridDisplay.size()) ? (currentPage * maxRows) : gridDisplay?.size()

        def results = gridDisplay.subList(rowOffset, toIndex)

        def totalRows = gridDisplay.size()
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
	
	def displayDocumentsEnclosed() {
        def maxRows = params.int("rows") ?: 10
        def currentPage = params.int("page") ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def gridDisplay = []

        if (params.documentName) {
            UUID uuid = UUID.randomUUID()
            String id = String.valueOf(uuid).toString().substring(0, 8)

            session.dataEntryModel.documentsEnclosed << [id: id,
                    documentName: params.documentName,
                    original1: 0,
                    original2: 0,
                    duplicate1: 0,
                    duplicate2: 0
            ]
        }

        session.dataEntryModel.documentsEnclosed.each {
            gridDisplay << [
                    id: it.id,
                    cell: [
                            it.documentName,
                            it.original1,
                            it.original2,
                            it.duplicate1,
                            it.duplicate2
                    ]
            ]
        }

        def documentsEnclosed = documentEnclosedService.retrieveDefaultDocumentsEnclosed()
        def unionList = parserService.getMapListNotIn(session.dataEntryModel.documentsEnclosed ? session.dataEntryModel.documentsEnclosed.id : [], documentsEnclosed)

        println "&&&&&&&&"
        println "============"
        session.dataEntryModel.documentsEnclosed
        println "============"
        session.dataEntryModel.documentsEnclosed.each {
            println it.id
        }
        println "&&&&&&&&"

        unionList.each {
            gridDisplay << [
                id: it.id,
                    cell: [
                        it.documentName,
                        it.original1,
                        it.original2,
                        it.duplicate1,
                        it.duplicate2
                    ]
            ]
        }

        Integer toIndex = ((currentPage * maxRows) < gridDisplay.size()) ? (currentPage * maxRows) : gridDisplay?.size()

        def results = gridDisplay.subList(rowOffset, toIndex)

        def totalRows = gridDisplay.size()
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def displayInstructions() {
        def maxRows = params.int("rows") ?: 10
        def currentPage = params.int("page") ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def gridDisplay = []

        session.dataEntryModel.enclosedInstruction.each {
            gridDisplay << [
                    id: it.id,
                    cell: [
                            it.instruction,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.id + "'; editEnclosedInstruction(id);\">edit</a>"
                    ]
            ]
        }

        def enclosedInstruction = documentEnclosedService.retrieveDefaultEnclosedInstruction()

        def unionList = parserService.getMapListNotIn(session.dataEntryModel.enclosedInstruction ? session.dataEntryModel.enclosedInstruction.id : [], enclosedInstruction)

        unionList.each {
            gridDisplay << [
                    id: it.id,
                    cell: [
                            it.instruction,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.id + "'; editEnclosedInstruction(id);\">edit</a>"
                    ]
            ]
        }

        Integer toIndex = ((currentPage * maxRows) < gridDisplay.size()) ? (currentPage * maxRows) : gridDisplay?.size()

        def results = gridDisplay.subList(rowOffset, toIndex)

        def totalRows = gridDisplay.size()
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def displayAdditionalInstructions() {
        def maxRows = params.int("rows") ?: 10
        def currentPage = params.int("page") ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def gridDisplay = []

        if (params.instruction) {
            String id = ""
            if (params.id) {
                if (params.add == "true") {
                    println 'add'
                    def newList = parserService.getMapListNotIn(params.id, session.dataEntryModel.additionalInstruction)
                    newList << [id: params.id, instruction: params.instruction]

                    session.dataEntryModel.additionalInstruction = newList
                } else {
                    def newList = parserService.getMapListNotIn(params.id, session.dataEntryModel.additionalInstruction)
                    println 'delete'
                    session.dataEntryModel.additionalInstruction = newList
                }
            } else {
                UUID uuid = UUID.randomUUID()
                id = String.valueOf(uuid).toString().substring(0, 8)

                session.dataEntryModel.additionalInstruction << [id: id,
                        instruction: params.instruction
                ]
            }
        }

        session.dataEntryModel.additionalInstruction.each {
            gridDisplay << [
                    id: it.id,
                    cell: [
                            it.instruction,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.id + "'; editNewInstruction(id);\">edit</a>",
                            "<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id='" + it.id + "'; deleteNewInstruction(id);\">delete</a>",
                    ]
            ]
        }

        Integer toIndex = ((currentPage * maxRows) < gridDisplay.size()) ? (currentPage * maxRows) : gridDisplay?.size()

        def results = gridDisplay.subList(rowOffset, toIndex)

        def totalRows = gridDisplay.size()
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def validateDocEnclosed() {
        println params

        int error = 0

        def allDocEnclosed = []

        session.dataEntryModel.documentsEnclosed.each {
            allDocEnclosed << it.id.toString()
        }

        if (allDocEnclosed.isEmpty() == false) {
            if (allDocEnclosed.containsAll(params.docEnclosedIds.split(",")) == false) {
                error ++
            }
        } /*else {
            error ++
        }*/

        //

        def allInstruction = []

        session.dataEntryModel.enclosedInstruction.each {
            allInstruction << it.id.toString()
        }

        if (allInstruction.isEmpty() == false) {
            if (allInstruction.containsAll(params.instructionIds.split(",")) == false) {
                error ++
            }
        }

        //

        def allAddedInstruction = []

        session.dataEntryModel.additionalInstruction.each {
            allAddedInstruction << it.id.toString()
        }
        println allAddedInstruction

        if (allAddedInstruction.isEmpty() == false) {
            if (allAddedInstruction.containsAll(params.addedInstructionIds.split(",")) == false) {
                error ++
            }
        }


        println 'error >' + error

        if (error > 0) {
            render([success: 'false'] as JSON)
        } else {
            render([success: 'true'] as JSON)
        }
    }
}
