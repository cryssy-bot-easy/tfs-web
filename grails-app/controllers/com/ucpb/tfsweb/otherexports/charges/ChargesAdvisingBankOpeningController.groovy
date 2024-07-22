package com.ucpb.tfsweb.otherexports.charges

class ChargesAdvisingBankOpeningController {
	
	def headerService
	
	protected String REFERENCE_TYPE = 'Payment Processing'
	protected String SERVICE_TYPE = 'Opening'
	
    def viewOpening() { 
		
		println "xxxxxxxxxxxx viewOpening()"
		
		// if accessed from create transaction
		if(chainModel) {
			session.otherExportsModel = chainModel
		}
		
		if(session.otherExportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/exports/charges/index", model: chainModel ? chainModel : session.otherExportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	def viewOpeningCharges() {
		REFERENCE_TYPE = params.referenceType
		SERVICE_TYPE = params.serviceType
		String documentType = 'test'
		String documentClass = 'test'
		String subType1 = 'test'
		String subType2 = params.subType2

		// construct header title
		String headerTitle = headerService.getOtherExportsTitle(SERVICE_TYPE, REFERENCE_TYPE)
		
		// keep session model
		session.otherExportsModel = [title: headerTitle, referenceType: REFERENCE_TYPE, serviceType: SERVICE_TYPE, documentType: documentType, documentClass: documentClass, subType1: subType1, subType2: params.subType2 ]
		
		// chain to render page
		chain(action:"viewOpening", model: session.otherExportsModel)
	}
}
