package com.ucpb.tfsweb.otherimports.cdt

import grails.converters.JSON

class PayDutiesTaxesController {

   def headerService
		
	// sets service type
	//protected String SERVICE_TYPE = "Monitoring Setup"
	
	
	//render page
	def viewCdt() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherImportsModel = chainModel
		}
		
		if(session.otherImportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/imports/cdt/pay_duties_taxes/content", model: chainModel ? chainModel : session.otherImportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewPayDutiesTaxesCdt() {
		// get lc class and type
		String serviceType = params.serviceType
		String documentType = params.documentType
		String referenceType= params.referenceType
		String documentClass= params.documentClass
		String username= params.username
		
		// construct header title
		String headerTitle = headerService.getOtherImportsTitleWithConjunction(referenceType,serviceType,documentType)
		
		// keep session model
		session.otherImportsModel = [documentType: documentType, referenceType: referenceType, documentClass:documentClass, title: headerTitle, serviceType: serviceType, username: username]
		
		// chain to render page
		chain(action:"viewCdt", model: session.otherImportsModel)
	}
}
