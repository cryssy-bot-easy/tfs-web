package com.ucpb.tfsweb.otherexports.dataentry

class DataEntryProcessingOfOtherExportChargesController {

	def headerService
	
	// sets service type
	protected String SERVICE_TYPE = 'Processing of Other Export Charges'
	protected String REFERENCE_TYPE = 'Data Entry'
	protected String DOCUMENT_TYPE = 'Export'
	
	def viewProcessingOfOtherExportCharges() {
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
	def viewProcessingOfOtherExportChargesDataEntry() {
		
		SERVICE_TYPE = params.serviceType
		REFERENCE_TYPE = params.referenceType
		DOCUMENT_TYPE = params.documentType
		String documentClass = 'test'
		String subType1 = params.subType1
		String subType2 = 'test'
		// construct header title
		String headerTitle = headerService.getOtherExportsTitle(SERVICE_TYPE, REFERENCE_TYPE)
		
		// keep session model
		session.otherExportsModel = [subType2: subType2, subType1:subType1, documentClass: documentClass, serviceType: SERVICE_TYPE,documentType: DOCUMENT_TYPE, referenceType: REFERENCE_TYPE, title: headerTitle]
		
		// chain to render page
		chain(action:"viewProcessingOfOtherExportCharges", model: session.otherExportsModel)
	}
}

