package com.ucpb.tfsweb.otherexports.charges

class ChargesAdvisingBankCancellationController {
	
	def headerService
	
	protected String REFERENCE_TYPE = 'Payment Processing'
	protected String SERVICE_TYPE = 'Cancellation'
	
    def viewCancellation() {
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
	
	def viewCancellationCharges(){
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
		chain(action:"viewCancellation", model: session.otherExportsModel)
	}
}
