package com.ucpb.tfsweb.otherimports.dataentry

import grails.converters.JSON

class DataentrySettlementActualCorresChargesController {

    def headerService
		
	// sets service type
	//protected String SERVICE_TYPE = "Monitoring Setup"
	protected String DOCUMENT_CLASS = ""
	
	
	//render page
	def viewSettlementActualCorres() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherImportsModel = chainModel
		}
		
		if(session.otherImportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/imports/dataentry/index", model: chainModel ? chainModel : session.otherImportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewSettlementActualCorresDataentry() {
		// get lc class and type
		String serviceType = params.serviceType
		String documentType = params.documentType
		String referenceType= params.referenceType
		String username= params.username
		
		// construct header title
		String headerTitle = headerService.getOtherImportsTitleWithConjunction(referenceType,serviceType,documentType)
		
		// keep session model
		session.otherImportsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, referenceType: referenceType, title: headerTitle, serviceType: serviceType, username: username]
		
		// chain to render page
		chain(action:"viewSettlementActualCorres", model: session.otherImportsModel)
	}
}
