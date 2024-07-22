package com.ucpb.tfsweb.otherexports.inquiry

class InquiryOtherExportChargesController {
	
	def headerService
	// reference type
	protected String REFERENCE_TYPE
	
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
	
	def viewOtherExportChargesInquiry(){
		String referenceType = params.referenceType
		String serviceType = params.serviceType
		String documentType = params.documentType
		String documentClass = 'test'
		String subType1 = 'test'
		String subType2 = 'test'
		String username = params.username
		
		// construct header title
		String headerTitle = headerService.getOtherExportsInquiryTitle(referenceType, serviceType, documentType)
		
		// keep session model
		session.otherExportsModel = [documentType: documentType, referenceType: referenceType, title: headerTitle, serviceType: serviceType, username: username]

		// chain to render page
		chain(action:"viewInquiry", model: session.otherExportsModel)
	}
}

