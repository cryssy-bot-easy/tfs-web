package com.ucpb.tfsweb.otherexports.ets

class EtsRefundOfOtherExportChargesController {

   	def headerService
	
	// sets service type
	protected String SERVICE_TYPE = "REFUND OF OTHER EXPORT CHARGES" 
	protected String REFERENCE_TYPE = "eTS"
	protected String DOCUMENT_CLASS = "a"
	protected String DOCUMENT_TYPE = "Export"
	
    def viewRefundOfOtherExportCharges() {
		// if accessed from create transaction
		if(chainModel) {
			session.otherExportsModel = chainModel
		}
		
		if(session.otherExportsModel) {
			// passes chain model if existing else passes session model
			render(view: "/others/exports/ets/index", model: chainModel ? chainModel : session.otherExportsModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewRefundOfOtherExportChargesEts() {
		REFERENCE_TYPE = params.referenceType
		SERVICE_TYPE = params.serviceType
		
		// construct header title
		String headerTitle = headerService.getOtherExportsTitle(SERVICE_TYPE, REFERENCE_TYPE,)
		
		// keep session model
		session.otherExportsModel = [serviceType: SERVICE_TYPE, documentType: DOCUMENT_TYPE, documentClass: DOCUMENT_CLASS, referenceType: REFERENCE_TYPE, title: headerTitle]
		
		// chain to render page
		chain(action:"viewRefundOfOtherExportCharges", model: session.otherExportsModel)
	}
}