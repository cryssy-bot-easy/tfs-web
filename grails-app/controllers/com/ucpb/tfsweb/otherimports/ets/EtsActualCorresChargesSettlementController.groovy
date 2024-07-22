package com.ucpb.tfsweb.otherimports.ets

class EtsActualCorresChargesSettlementController {
	
	def headerService
	
	// sets service type
	protected String SERVICE_TYPE = "" //"APPLICATION"
	protected String DOCUMENT_CLASS = ""
	
	//render page
	def viewCharges() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherImportsModel = chainModel
		}
		
		if(session.otherImportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/imports/ets/index", model: chainModel ? chainModel : session.otherImportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewChargesSettlement() {
		// get lc class and type
		String documentType = params.documentType
		
		//for testing purposes
		String referenceType= params.referenceType
		String username= params.username
		SERVICE_TYPE = params.serviceType
		
		// construct header title
		String headerTitle = headerService.getOtherImportsTitleWithConjunction(referenceType,SERVICE_TYPE,documentType)
		
		// keep session model
		session.otherImportsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, referenceType: referenceType, title: headerTitle, serviceType: SERVICE_TYPE, username: username]
		
		// chain to render page
		chain(action:"viewCharges", model: session.otherImportsModel)
	}
}
