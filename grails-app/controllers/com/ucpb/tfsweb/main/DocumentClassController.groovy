package com.ucpb.tfsweb.main

import grails.converters.JSON
import net.ipc.utils.NumberUtils

class DocumentClassController {

    def documentClassService
    def headerService

    def viewApprovedLc() {
        //printlnparams
        ////println"accessed from lc inquiry....."
//        Map<String,Object> lc = documentClassService.getLetterOfCredit(params.tradeServiceId)
        Map<String,Object> lc = documentClassService.getLetterOfCredit(params.documentNumber, params.documentClass)

        Map<String, String> chainMap = documentClassService.evaluateParameters(params)

        String headerTitle = headerService.getEtsTitle(lc.documentType, params.documentClass.toUpperCase(), lc.documentSubType1, params.serviceType, lc.documentSubType2)

        // keep session model
        session.etsModel = [documentType: lc.documentType, documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: "ETS"]

        if (params?.serviceType?.toString().equalsIgnoreCase("AMENDMENT") 
            && lc.documentType?.toString().equalsIgnoreCase("FOREIGN")
            ) {
            lc.put("productAmount", lc.get("amount"))
            println "FX DocumentClassController: lc.get(amount): " + lc.get("amount")
            println "FX DocumentClassController: lc.get(productAmount): " + lc.get("productAmount")
        }

        if (params?.serviceType?.toString().equalsIgnoreCase("AMENDMENT") 
            && lc.documentType?.toString().equalsIgnoreCase("DOMESTIC")
            ) {
            lc.put("productAmount", lc.get("amount"))
            println "DM DocumentClassController: lc.get(amount): " + lc.get("amount")
            println "DM DocumentClassController: lc.get(productAmount): " + lc.get("productAmount")
        }

        lc.each {
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")&& !it.key.equalsIgnoreCase("passOnRateConfirmedBy")) {
                if (params.documentClass?.equals("INDEMNITY")) {
                    if (!it.key.equals("documentNumber")) {
                        session.etsModel << it
                    }
                } else {
                    session.etsModel << it
                }
            }
        }

        if(params.reinstateFlag) {
            session.etsModel << [reinstateFlag: params.reinstateFlag]
        }

        chain(controller: chainMap.controller, action: chainMap.action)
    }

    def viewApprovedLcTsdInitiated() {
        ////println"accessed from lc inquiry tsd initiated....."
//        Map<String,Object> lc = documentClassService.getLetterOfCredit(params.tradeServiceId)
        Map<String,Object> lc = documentClassService.getLetterOfCredit(params.documentNumber, params.documentClass)

        lc.remove("tradeServiceId")
        lc.remove("etsNumber")

        Map<String, String> chainMap = documentClassService.evaluateParametersTsdInitiated(params)

        String headerTitle = headerService.getDataEntryTitle(lc.documentType, params.documentClass.toUpperCase(), lc.documentSubType1, params.serviceType, lc.documentSubType2)

        // keep session model
        session.dataEntryModel = [documentType: lc.documentType, documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: "DATA_ENTRY"]

        session.dataEntryModel << [tsdInitiated:"true"]

        lc.each {
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && !it.key.equals("processDate")) {
                session.dataEntryModel << it
            }
        }

		if (params.serviceType.equalsIgnoreCase("NEGOTIATION_DISCREPANCY")) {			
			if (session?.dataEntryModel?.senderToReceiverInformation != null &&
				!session?.dataEntryModel?.senderToReceiverInformation.equalsIgnoreCase("")) {				
				session.dataEntryModel << [senderToReceiverInformation: ""]
			}
		}		
		
        chain(controller: chainMap.controller, action: chainMap.action)
    }
	
	def viewApprovedNonLc() {
		////println"accessed from non lc inquiry....."
		////printlnparams.documentNumber + " " + params.documentClass
		Map<String,Object> dc = documentClassService.getDocumentaryCredit(params.documentNumber, params.documentClass, params.serviceType.toUpperCase())

		Map<String, String> chainMap = documentClassService.evaluateParameters(params)

		String headerTitle = headerService.getEtsTitle(dc.documentType, params.documentClass.toUpperCase(), "", params.serviceType, "")

		// keep session model
		session.etsModel = [documentType: dc.documentType, documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: "ETS"]

		dc.each {
			if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")&& !it.key.equalsIgnoreCase("passOnRateConfirmedBy")) {
				session.etsModel << it
			}
		}

//		if(params.reinstateFlag) {
//			session.etsModel << [reinstateFlag: params.reinstateFlag]
//		}

		chain(controller: chainMap.controller, action: chainMap.action)
	}
	
	def viewApprovedNonLcTsdInitiated() {
		//println"accessed from nonlc inquiry tsd initiated....."
		Map<String,Object> dc = documentClassService.getDocumentaryCredit(params.documentNumber, params.documentClass, params.serviceType.toUpperCase())
		
		dc.remove("tradeServiceId")
		dc.remove("tsNumber")
		
		Map<String, String> chainMap = documentClassService.evaluateParametersTsdInitiated(params)
		
		String headerTitle = headerService.getDataEntryTitle(dc.documentType, params.documentClass, "", params.serviceType, "")
		////println"title " +headerTitle
		// keep session model
		session.dataEntryModel = [documentType: dc.documentType, documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: "DATA_ENTRY"]
		
		session.dataEntryModel << ["tsdInitiated":"true"]

		dc.each {
			if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
				session.dataEntryModel << it
			}
		}

		chain(controller: chainMap.controller, action: chainMap.action)
	}

    def viewApprovedIndemnity() {
        ////println"accessed from bg inquiry....."
        Map<String,Object> lc = documentClassService.getIndemnity(params.referenceNumber, params.indemnityNumber)

        Map<String, String> chainMap = documentClassService.evaluateParameters(params)

        String headerTitle = headerService.getDataEntryTitle(lc.documentType, params.documentClass.toUpperCase(), lc.documentSubType1, params.serviceType, lc.documentSubType2)

        // keep session model
        session.dataEntryModel = [documentType: lc.documentType, documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: "DATA_ENTRY"]

        lc.each {
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.dataEntryModel << it
            }
        }

        chain(controller: chainMap.controller, action: chainMap.action)
    }

    def viewApprovedLcNegotiation() {
        ////println"accessed from negotiation inquiry....."
        Map<String,Object> lcNegotiation = documentClassService.getLcNegotiation(params.id)

        Map<String, String> chainMap = documentClassService.evaluateParameters(params)

        String headerTitle = headerService.getEtsTitle(lcNegotiation.documentType, params.documentClass.toUpperCase(), lcNegotiation.documentSubType1, params.serviceType, lcNegotiation.documentSubType2)

        // keep session model
        session.etsModel = [documentType: lcNegotiation.documentType, documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: "ETS"]

        lcNegotiation.each {
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }

//        session.etsModel.put("computedOutstandingBalance", (lcNegotiation.outstandingBalance - lcNegotiation.amount))
        chain(controller: chainMap.controller, action: chainMap.action)
    }

    def viewApprovedAp() {
        ////println"accessed from ap inquiry....."
        Map<String,Object> ap = documentClassService.getAccountsPayable(params.id)
                    
        Map<String, String> chainMap = documentClassService.evaluateParameters(params)

        String headerTitle = ""

        if (params.referenceType.equalsIgnoreCase("DATA_ENTRY")) {
            // keep session model
            headerTitle = headerService.getDataEntryTitle("", params.documentClass.toUpperCase(), "", params.serviceType, "")

            session.dataEntryModel = [documentType: "", documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: params.referenceType]

            ap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }
        } else if (params.referenceType.equalsIgnoreCase("ETS")) {
            // keep session model
            headerTitle = headerService.getEtsTitle("", params.documentClass.toUpperCase(), "", params.serviceType, "")

            session.etsModel= [documentType: "", documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: params.referenceType]

            ap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }
			session.etsModel << [natureOfTransaction: params.natureOfTransaction, documentNumber: params.documentNumber]
        }

        chain(controller: chainMap.controller, action: chainMap.action)
    }

    def viewApprovedAr() {
        ////println"accessed from ar inquiry....."
        Map<String,Object> ar = documentClassService.getAccountsReceivable(params.id)

        Map<String, String> chainMap = documentClassService.evaluateParameters(params)

        String headerTitle = ""

        if (params.referenceType.equalsIgnoreCase("DATA_ENTRY")) {
            // keep session model
            headerTitle = headerService.getDataEntryTitle("", params.documentClass.toUpperCase(), "", params.serviceType, "")

            session.dataEntryModel = [documentType: "", documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: params.referenceType]

            ar.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }
        } else if (params.referenceType.equalsIgnoreCase("ETS")) {
            // keep session model
            headerTitle = headerService.getEtsTitle("", params.documentClass.toUpperCase(), "", params.serviceType, "")
            ////printlnparams
            session.etsModel= [documentType: "", documentClass: params.documentClass.toUpperCase(), title: headerTitle, serviceType: params.serviceType, referenceType: params.referenceType]

            ar.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }
			session.etsModel << [natureOfTransaction: params.natureOfTransaction, documentNumber: params.documentNumber]
        }

        chain(controller: chainMap.controller, action: chainMap.action)
    }

    def viewRelatedLc() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = documentClassService.findAllRelatedLc(maxRows, rowOffset, currentPage, params.cifNumber)

        def totalRows = mapList.totalRows
        ////println"totalRows " + totalRows + " maxRows" + maxRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = documentClassService.constructRelatedLc(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }


    def findIcDetailsByIc() {
        Map<String, Object> icDetails = documentClassService.findNegotiationDiscrepancyByIcNumber(params.icNumber)

        def jsonData = [negotiationAmount: NumberUtils.currencyFormat(new Double(icDetails.NEGOTIATIONAMOUNT)),
                negotiationBank: icDetails.NEGOTIATIONBANK,
                negotiationBankRefNumber: icDetails.NEGOTIATIONBANKREFNUMBER,
                senderToReceiverInformation: icDetails.SENDERTORECEIVERINFORMATION,
				icCashAmount: NumberUtils.currencyFormat(new Double(icDetails.CASHAMOUNT)),
				icRegularAmount: NumberUtils.currencyFormat(new Double(icDetails.REGULARAMOUNT))]
        
        render jsonData as JSON
    }


    def extractDataFromRelatedLc() {
        println params
        Map<String,Object> lc = documentClassService.getLetterOfCredit(params.documentNumber, "LC")
        lc.each {
            println it
        }
        render([lc: lc] as JSON)
    }
	
	def extractRelatedLcDocumentsRequired() {
		def result = documentClassService.getAllSavedRequiredDocuments(params.documentNumber, session.dataEntryModel.tradeServiceId)

		println "AAAAAAAAAAAAAAAAAresult" + result
		def jsonData = [documentCode: result]

		render jsonData as JSON
	}
	
	def extractAddedDocuments() {
		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def ml = documentClassService.getAllSavedNewDocuments(params.documentNumber, session.dataEntryModel.tradeServiceId)
		
		if(params.deleteDocuments) {
			session.addedList.clear()
			
			params.remove("deleteDocuments")
		}
		
		 if (params.addedDocuments) {
            def m = JSON.parse(params.addedDocuments)

            Map<String, Object> map = new HashMap<String, Object>()

            map.put("id", m.id)
            map.put("description", m.description)
			
			if(!session.addedList.contains(map)) {
				session.addedList << map
			}

            params.remove("addedDocuments")
		 } else {
            ml.display.each{
				println "IT"+it
				if(!session.addedList.contains(it)) {
					session.addedList << it
				}
            }
			println "SESSION ADDED LIST"+session.addedList
        }
		

		Integer toIndex = ((currentPage * maxRows) < session.addedList?.size()) ? (currentPage * maxRows) : session.addedList?.size()
		def mapList = [display: session.addedList?.subList(rowOffset, toIndex), totalRows: session.addedList?.size()]


		def totalRows = mapList.totalRows ?:0

		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = documentClassService.constructAddedRequiredDocuments(mapList.display)


		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		render jsonData as JSON
	}
	
	def extractAllAddedDocuments() {
		def arr = []

		session.addedList.each { map ->
			Map<String,Object> m = new HashMap<String, Object>()
			m.put("id", map.get("id"))
			m.put("description", map.get("description"))
			m.put("requiredDocumentType", "NEW")
			arr.add(m)
		}

		render([addedList: arr] as JSON)
	}
	
	def extractAllRequiredDocuments() {

		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = documentClassService.getAllRequiredDocuments(session.dataEntryModel, params.relatedLcNumber, maxRows, rowOffset, currentPage)

		def totalRows = mapList.totalRows ?:0

		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = documentClassService.constructRequiredDocumentsGridDisplay(mapList.display)
		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		render jsonData as JSON
	}
	
	def extractAllSavedAdditionalConditions() {
		def result = documentClassService.getAllSavedAdditionalConditions(params.documentNumber, session.dataEntryModel.tradeServiceId)

		def jsonData = [conditionCode: result]

		render jsonData as JSON
	}
	
	def extractAddedConditions() {
		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def ml = documentClassService.getAllSavedNewCondition(params.documentNumber, session.dataEntryModel.tradeServiceId)

		if(params.deletedCondition) {
			session.addedConditionsList.clear()
			
			params.remove("deletedCondition")
		}
		if (params.addedCondition) {
			def m = JSON.parse(params.addedCondition)

			Map<String, Object> map = new HashMap<String, Object>()

			map.put("id", m.id)
			map.put("condition", m.condition)

			session.addedConditionsList << map

			params.remove("addedCondition")
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
		def results = documentClassService.constructAddedAdditionalConditions(mapList.display)


		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		render jsonData as JSON
	}

	def extractAllAddedConditions() {
		def arr = []
		session.addedConditionsList.each { map ->
			Map<String,Object> m = new HashMap<String, Object>()
			m.put("condition", map.get("condition"))
			m.put("conditionType", "NEW")
			arr.add(m)
		}

		render([addedConditionsList: arr] as JSON)
	}
}
