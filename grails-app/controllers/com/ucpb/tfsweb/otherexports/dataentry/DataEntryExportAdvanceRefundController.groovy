package com.ucpb.tfsweb.otherexports.dataentry

import grails.converters.JSON

class DataEntryExportAdvanceRefundController {

	def headerService
	
	def chargesService
	
	// sets service type
	protected String SERVICE_TYPE = 'Export Advance Refund'
	protected String REFERENCE_TYPE = 'Data Entry'
	protected String DOCUMENT_TYPE = 'Export'
	
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
			render(view: "/others/exports/dataentry/index", model: chainModel ? chainModel : session.otherExportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewExportAdvanceRefundDataEntry() {
		REFERENCE_TYPE = params.referenceType
		SERVICE_TYPE = params.serviceType
		String documentClass = 'test'
		String subType1 = 'test'
		String subType2 = 'test'
		// construct header title
		String headerTitle = headerService.getOtherExportsTitle(SERVICE_TYPE, REFERENCE_TYPE,)
		
		// keep session model
		session.otherExportsModel = [subType2: subType2, subType1: subType1, serviceType: SERVICE_TYPE,documentType: DOCUMENT_TYPE, documentClass: documentClass, referenceType: REFERENCE_TYPE, title: headerTitle]
		
		// chain to render page
		chain(action:"viewExportAdvanceRefund", model: session.otherExportsModel)
	}
}

