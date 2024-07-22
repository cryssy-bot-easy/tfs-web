package com.ucpb.tfsweb.otherexports.ets

import grails.converters.JSON

class EtsExportAdvanceRefundController {

   	def headerService
    def chargesService
	   
	// sets service type
	protected String SERVICE_TYPE = "Export Advance Refund" 
	protected String REFERENCE_TYPE = "eTS"
	protected String DOCUMENT_TYPE = "Export"
	
    def viewExportAdvanceRefund() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherExportsModel = chainModel

            String etsNumber = '000-00-000-00-000000'

            List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

            session.otherExportsModel << [charges:charges]
            session.otherExportsModel << [chargesJson: charges as JSON]
		}
		
		if(session.otherExportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/exports/ets/index", model: chainModel ? chainModel : session.otherExportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewExportAdvanceRefundEts() {
		REFERENCE_TYPE = params.referenceType
		SERVICE_TYPE = params.serviceType
		String documentType = DOCUMENT_TYPE
		String documentClass = 'test'
		String subType1 = 'test'
		String subType2 = 'test'
		
		// construct header title
		String headerTitle = headerService.getOtherExportsTitle(REFERENCE_TYPE,SERVICE_TYPE)
		
		// keep session model
		session.otherExportsModel = [title: headerTitle, referenceType: REFERENCE_TYPE, serviceType: SERVICE_TYPE, documentType: DOCUMENT_TYPE, documentClass: documentClass, subType1: subType1, subType2:subType2]
		
		// chain to render page
		chain(action:"viewExportAdvanceRefund", model: session.otherExportsModel)
	}
}