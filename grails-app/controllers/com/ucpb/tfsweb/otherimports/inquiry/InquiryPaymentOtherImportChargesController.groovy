package com.ucpb.tfsweb.otherimports.inquiry

import grails.converters.JSON


class InquiryPaymentOtherImportChargesController {
	
	def headerService

    def viewInquiry() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherImportsModel = chainModel
		}
		
		if(session.otherImportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/imports/inquiry/index", model: chainModel ? chainModel : session.otherImportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewPaymentOtherImportChargesInquiry() {
		// get lc class and type
        String serviceType = params.serviceType
		String documentType = params.documentType
		String referenceType= params.referenceType
		String username= params.username
		
		// construct header title
		String headerTitle = headerService.getOtherImportsTitleWithConjunction(referenceType,serviceType,documentType)
		
		// keep session model
		session.otherImportsModel = [documentType: documentType, referenceType: referenceType, title: headerTitle, serviceType: serviceType, username: username]
		
		// chain to render page
		chain(action:"viewInquiry", model: session.otherImportsModel)
	}
}
