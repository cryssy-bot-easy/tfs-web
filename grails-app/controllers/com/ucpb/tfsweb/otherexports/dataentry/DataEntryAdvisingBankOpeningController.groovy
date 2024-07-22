package com.ucpb.tfsweb.otherexports.dataentry

class DataEntryAdvisingBankOpeningController {
	
	def headerService
	
	protected String REFERENCE_TYPE = 'Data Entry'
	protected String SERVICE_TYPE = 'Opening'
	
    def viewOpening() {
		
		// if accessed from create transaction
		if(chainModel) {
			session.otherExportsModel = chainModel
		}
		
		if(session.otherExportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/exports/dataentry/index", model: chainModel ? chainModel : session.otherExportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	def viewOpeningDataEntry(){
		REFERENCE_TYPE = params.referenceType
		SERVICE_TYPE = params.serviceType
		String subType1 = params.subType1
		String subType2 = params.subType2
		String documentType = 'test'
		String documentClass = params.documentClass
		// construct header title
		String headerTitle = headerService.getOtherExportsTitle(REFERENCE_TYPE, SERVICE_TYPE)
		
		// keep session model
		session.otherExportsModel = [ subType1: subType1,documentType: documentType, serviceType: SERVICE_TYPE, documentClass: documentClass, referenceType: REFERENCE_TYPE, subType2: params.subType2, title: headerTitle]
		
		if("View Data Entry" == params.dataEntryButtonCaption){
			session.otherExportsModel<<[viewMode:'viewMode']
		}else{
			session.otherExportsModel<<[viewMode:params.viewMode]
		}
		
		// chain to render page
		chain(action:"viewOpening", model: session.otherExportsModel)
	}
}
