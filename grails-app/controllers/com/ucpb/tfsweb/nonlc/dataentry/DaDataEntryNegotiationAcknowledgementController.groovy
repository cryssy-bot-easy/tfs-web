package com.ucpb.tfsweb.nonlc.dataentry

class DaDataEntryNegotiationAcknowledgementController {

    def dataEntryService
	def routingInformationService
	def headerService
	def tabUtilityService
    def foreignExchangeService
    def ratesService

    // sets service type
    protected String REFERENCE_TYPE = "DATA_ENTRY"
    protected String SERVICE_TYPE = "Negotiation Acknowledgement"
    protected String DOCUMENT_CLASS = "DA"
	protected String DOCUMENT_TYPE = "FOREIGN"

    // render page
    def viewNegotiationAcknowledgement() {
        if(chainModel) {
            session.dataEntryModel = chainModel
        }
		//go to unacted if cancelled from basic details tab
		if(session.cancelBd){
			 session.removeAttribute("cancelBd")
			 render(view:"/main/unacted_transaction")
		}
        else if(session.dataEntryModel) {
            def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
            session.dataEntryModel << [exchange:exchange]

            def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
            session.dataEntryModel << [urrrates:urrrates]

            session.dataEntryModel << [tsdInitiated:"true"]

            render(view: "/nonlc/da/index", model:chainModel ? chainModel : session.dataEntryModel)
        }else{
            render(view: "/main/unauthorized")
        }
    }

    def viewNegotiationAcknowledgementDataEntry() {
//        String headerTitle = "FX Document Against Acceptance Negotiation Acknowledgement Non-LC - Data Entry"
		String headerTitle = headerService.getDataEntryTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")

        session.dataEntryModel = [documentType: DOCUMENT_TYPE, documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

		if (params.tradeServiceId) {
//			Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)
			Map<String, Object> dataEntryMap = dataEntryService.getNonEtsDataEntry(params.tradeServiceId)

			dataEntryMap.each {
				if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
					session.dataEntryModel << it
				}
			}
		}

        // todo: refactor, this should be in a service or something
        // todo: we are still using etsModel so we don't have to do an if in the instructions and routing tab
        def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "", REFERENCE_TYPE.toUpperCase(), 'NEGOTIATION_ACKNOWLEDGEMENT', session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "",'NEGOTIATION_ACKNOWLEDGEMENT', session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "", 'NEGOTIATION_ACKNOWLEDGEMENT', session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        //println"**********************" + session.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
		}
        chain(action: "viewNegotiationAcknowledgement", model: session.dataEntryModel)
    }

    def saveNegotiationAcknowledgementDataEntry() {
//        String headerTitle = "FX Document Against Acceptance Negotiation Acknowledgement Non-LC - Data Entry"
		String headerTitle = headerService.getDataEntryTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")

        // keep session model
        session.dataEntryModel = [documentType: "FOREIGN",  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.saveAs = "PENDING"

        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        Map<String, Object> dataEntryMap = dataEntryService.saveDataEntry(params)

        dataEntryMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.dataEntryModel << it
            }
        }
		session.cancelBd=params.cancelBd
		
        // chain to render page
        chain(action:"viewNegotiationAcknowledgement", model: session.dataEntryModel)
    }

    def updateNegotiationAcknowledgementDataEntry() {
//        String headerTitle = "FX Document Against Acceptance Negotiation Acknowledgement Non-LC - Data Entry"
		String headerTitle = headerService.getDataEntryTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")

        // keep session model
        session.dataEntryModel = [documentType: "FOREIGN",  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
		session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

		// trigger command
		params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        params.put("userrole", session.userrole.id)

        // trigger command
        Map<String, Object> dataEntryMap = dataEntryService.updateDataEntry(params)

        dataEntryMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.dataEntryModel << it
            }
        }
		session.cancelBd=params.cancelBd
		
		// chain to render page
		chain(action:"viewNegotiationAcknowledgement", model:session.dataEntryModel)
    }

    def updateDataEntryStatus() {
//		String headerTitle = "FX Document Against Acceptance Negotiation Acknowledgement Non-LC - Data Entry"
		String headerTitle = headerService.getDataEntryTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction
		
		// keep session model
		session.dataEntryModel = [documentType: "FOREIGN",  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
        
        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)

        // trigger command
        dataEntryService.updateDataEntry(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }
}