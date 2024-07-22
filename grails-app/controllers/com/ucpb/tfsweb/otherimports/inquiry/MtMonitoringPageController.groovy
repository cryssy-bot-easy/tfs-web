package com.ucpb.tfsweb.otherimports.inquiry

import grails.converters.JSON

class MtMonitoringPageController {

   def headerService
	
	// sets service type
	protected String SERVICE_TYPE = "MT Monitoring" 
	protected String DOCUMENT_TYPE = "Outgoing"
	protected String REFERENCE_TYPE = "MT Message"

    def viewMtPage() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherImportsModel = chainModel
		}
		
		if(session.otherImportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/imports/inquiry/mt_monitoring_page/content", model: chainModel ? chainModel : session.otherImportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewMtMonitoringPage() {
		// get lc class and type
		String serviceType = SERVICE_TYPE
		String documentType = DOCUMENT_TYPE
		String referenceType= REFERENCE_TYPE
		String username= params.username
		session.mtType = params.mtType
		
		// construct header title
		String headerTitle = headerService.getOtherImportsTitle(referenceType,serviceType,documentType)
		
		// keep session model
		session.otherImportsModel = [documentType: DOCUMENT_TYPE, referenceType: REFERENCE_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, username: username]
		
		// chain to render page
		chain(action:"viewMtPage", model: session.otherImportsModel)
	}
}
