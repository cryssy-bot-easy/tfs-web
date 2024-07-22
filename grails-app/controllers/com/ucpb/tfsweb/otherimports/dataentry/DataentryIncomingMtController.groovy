package com.ucpb.tfsweb.otherimports.dataentry

import grails.converters.JSON

class DataentryIncomingMtController {

	def headerService

    def viewMtPage() {
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
	def viewIncomingMt() {
		// get lc class and type
		String serviceType = params.serviceType
		String documentType = params.documentType
		String referenceType= params.referenceType
		String username= params.username
		String userType= params.userType
		
		// construct header title
		String headerTitle = headerService.getOtherImportsTitle(referenceType,serviceType,documentType)
		
		// keep session model
		session.otherImportsModel = [documentType: documentType, referenceType: referenceType, title: headerTitle, serviceType: serviceType, username: username, userType: userType]
		
		// chain to render page
		chain(action:"viewMtPage", model: session.otherImportsModel)
	}
}
