package com.ucpb.tfsweb.otherexports.inquiry

import grails.converters.JSON

class InquiryExportBillsController {

   def headerService 
	
    def viewInquiry() { 
		// if accessed from create transaction
		if(chainModel) {
			session.otherExportsModel = chainModel
		}
		
		if(session.otherExportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/exports/inquiry/index", model: chainModel ? chainModel : session.otherExportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}

	def viewExportBillsInquiry(){
		String referenceType = params.referenceType
		String serviceType = params.serviceType
		String documentType = params.documentType
		String username = params.username
		
		
		// construct header title
		String headerTitle = headerService.getOtherExportsInquiryTitle(referenceType, serviceType, documentType)
		
		// keep session model
		session.otherExportsModel = [documentType: documentType, referenceType: referenceType, title: headerTitle, serviceType: serviceType, username: username]
		
		
		// chain to render page
		chain(action:"viewInquiry", model: session.otherExportsModel)
	}
}
