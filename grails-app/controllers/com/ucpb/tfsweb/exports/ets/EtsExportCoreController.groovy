package com.ucpb.tfsweb.exports.ets

import grails.converters.JSON

class EtsExportCoreController {

    def headerService
	
	def chargesService
		
	// sets service type
	protected String DOCUMENT_CLASS = ""
	
	
	//render page
	def viewExportCore() {
		// if accessed from create transaction
		if(chainModel) {
			session.exportsModel = chainModel
			
			String etsNumber = '909-01-932-12-464031' //dummy value
			
			List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

			session.exportsModel << [charges:charges]
			session.exportsModel << [chargesJson: charges as JSON]
		}
		
		if(session.exportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/exports/ets/core/index", model: chainModel ?: session.exportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewExportCoreEts() {
		// get lc class and type
		String documentType = params.documentType
		DOCUMENT_CLASS = params.documentClass
		String serviceType = params.serviceType
		String referenceType= params.referenceType
		
		// construct header title
		String headerTitle = headerService.getExportsCoreTitle(documentType,DOCUMENT_CLASS,serviceType,referenceType)
		
		// keep session model
		session.exportsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, referenceType: referenceType, title: headerTitle, serviceType: serviceType]
		
		// chain to render page
		chain(action:"viewExportCore", model: session.exportsModel)
	}
	
}
