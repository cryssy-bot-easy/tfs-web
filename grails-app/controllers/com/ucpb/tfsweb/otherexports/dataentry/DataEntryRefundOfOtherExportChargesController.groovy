package com.ucpb.tfsweb.otherexports.dataentry

class DataEntryRefundOfOtherExportChargesController {

	def headerService
	
	// sets service type
	protected String SERVICE_TYPE = 'Refund of Other Export Charges' 
	protected String REFERENCE_TYPE = 'Data Entry'
	protected String DOCUMENT_TYPE = 'Export'
	
    def viewRefundOfOtherExportCharges() {
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
	
	// trigger viewing of page
	def viewRefundOfOtherExportChargesDataEntry() {
		REFERENCE_TYPE = params.referenceType
		SERVICE_TYPE = params.serviceType
		String documentClass = 'test'
		String subType1 = 'test'
		String subType2 = 'test'
		// construct header title
		String headerTitle = headerService.getOtherExportsTitle(SERVICE_TYPE, REFERENCE_TYPE,)
		
		// keep session model
		session.otherExportsModel = [subType2: subType2, subType1: subType1, serviceType: SERVICE_TYPE, documentType: DOCUMENT_TYPE, documentClass: documentClass, referenceType: REFERENCE_TYPE, title: headerTitle]
		
		// chain to render page
		chain(action:"viewRefundOfOtherExportCharges", model: session.otherExportsModel)
	}
}

