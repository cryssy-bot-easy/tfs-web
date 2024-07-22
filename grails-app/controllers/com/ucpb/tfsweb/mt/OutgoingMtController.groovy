package com.ucpb.tfsweb.mt


class OutgoingMtController {

    def mtService
    def dataEntryService
	def coreAPIService
	def outgoingMtService
	def commandService
	def commandBusService
	
    private String SOURCE_TYPE = "OUTGOING"

	@Deprecated
	def viewOutgoingMt() {
		if(chainModel) {
			session.mtModel = chainModel
		}

		if(session.mtModel) {
			if (session.mtModel.errorMessage) {
				flash.message = session.mtModel.errorMessage
			}
			session.mtModel.remove("errorMessage")

			render(view:"/telecoms/index", model: chainModel ?: session.mtModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	def viewOutgoingMtMessage() {
		session.mtModel = [sourceType: SOURCE_TYPE, title: "Outgoing MT Monitoring - MT Message", userType: params.userType]

		if (params.id) {
			Map<String, Object> mtMessageMap = mtService.getMtMessage(params.id)

			mtMessageMap.each {
				session.mtModel << it
			}
		}

		chain(action:"viewOutgoingMt", model: session.mtModel)
	}
	
	def transmitMtMessage(){
		session.mtModel = [sourceType: SOURCE_TYPE, title: "Outgoing MT Monitoring - MT Message", userType: ""]

		params.statusAction = "transmit"

		Map<String, Object> mtMessageMap = mtService.updateMtMessage(params)

		mtMessageMap.each {
			session.mtModel << it
		}

		redirect(controller: "telecoms", action: params.returnUrl ?: "viewUnactedMt")
	}
	
	def discardMtMessage() {
		session.mtModel = [sourceType: SOURCE_TYPE, title: "Outgoing MT Monitoring - MT Message", userType: ""]

		params.statusAction = "discard"

		Map<String, Object> mtMessageMap = mtService.updateMtMessage(params)

		mtMessageMap.each {
			session.mtModel << it
		}

		redirect(controller: "telecoms", action: params.returnUrl ?: "viewUnactedMt")
	}

	def reverseMtMessage() {
		session.mtModel = [sourceType: SOURCE_TYPE, title: "Outgoing MT Monitoring - MT Message", userType: ""]

		params.statusAction = "reverse"

		Map<String, Object> mtMessageMap = mtService.updateMtMessage(params)

		mtMessageMap.each {
			session.mtModel << it
		}

		redirect(controller: "telecoms", action: params.returnUrl ?: "viewUnactedMt")
	}

    def saveOutgoingMt(){
		boolean isNew = false;
		params.put("username", session.username);
		params.put("unitcode", session.unitcode);
		
		//field 20 has different names from each MT so have to hardcode documentNumber
		if(params.get("documentNumber") == null){
			def tempDocumentNumber = [:]			
			params.each {
				if((it.key?.toString().equalsIgnoreCase("transactionReferenceNumber") ||
						it.key?.toString().equalsIgnoreCase("lcNumber") ||
								it.key?.toString().equalsIgnoreCase("documentNumberMt799"))){
					tempDocumentNumber.put("documentNumber", it.value)
				}
			}
			params << tempDocumentNumber
		}
		
		if(params.outgoingTradeServiceId && !("".equals(params.outgoingTradeServiceId))){
			params.put("tradeServiceId", params.outgoingTradeServiceId)
		}else{
			isNew=true
		}
		def model = null
		if(isNew){
			model = outgoingMtService.getExistingTransaction(params.get("documentNumber")?.toString(),params.get("messageType")?.toString())
			if(model != null){
				def parameters = outgoingMtService.loadExistingDataToParams(model,params)
				model = coreAPIService.dummySendCommand(parameters, "save","tradeservice/").details;			
			}
		}
		if(model == null){
			model = coreAPIService.dummySendCommand(params, "save","tradeservice/").details;			
		}
		
		println "OUTGOING MT MODEL: "+model
		if(session.mtMessageType){
			chain(action: "viewMt", model : model);
		}else{
			render(view: "/main/outgoing_mt_error")
		}
    }
	
	
    def routeMtMessage() {
        String commandName=""
		switch(params.commandName?.toUpperCase()){
			case "PENDING":
            case "RETURNED":
				commandName="Prepare";
				break;
			case "PREPARED":
				commandName="Check";
				break;
			case "CHECKED":
				commandName="Approve";
				break;

            case "RETURN":
                commandName = "Return"
                break;

            case "ABORT":
                commandName = "Abort";
		}
		//adding extra parameters, some handlers need those
		def parameters=[tradeServiceId:params.routeOutgoingTradeServiceId,
		                username:session.username,unitcode:session.unitcode,
		                documentClass:"MT",routeTo:params.routeTo,
						referenceType:"OUTGOING_MT",
						documentType:"OUTGOING",
						serviceType:"CREATE"
						]
		commandService.updateCommand("instructionsAndRouting", parameters, commandName)
		if(params.userRole?.indexOf("TSD") != -1){
			redirect(controller: "unactedTransactions", action: "viewUnactedTsd",params:[tsdLabelText:params.tsdLabelText,
				tsdTableId:params.tsdTableId])
		}else{
			redirect(controller: "unactedTransactions", action: "viewUnacted")
		}
    }

    def viewMt(){
        //get routes here
		session.mtMessageType=params.mtMessageType ?: session.mtMessageType
		
		if(chainModel){
			session.mtModel= chainModel 
		}else if(params.tradeServiceId){
            session.mtModel= outgoingMtService.loadMtDetails(params.tradeServiceId,session.mtMessageType)
			//rewrite message type value for viewing MT
			session.mtMessageType = session.mtModel?.details?.messageType ?: (params.mtMessageType ?: session.mtMessageType)
		}else if(params.resetModel == 'true'){
			session.removeAttribute("mtModel")
		}
		
		//view outgoing MT
		if(session.mtModel != null){
			session.mtModel.viewMode = params.viewMode			
		}
		
        try{
			if(session.mtModel){
				session.nextRoute=outgoingMtService.getNextApprovers(session.username, session.userrole.id, session.userLevel, session.unitcode, session.mtModel)
				session.mtModel << outgoingMtService.getApprovalMode(session.mtModel?.approvers)

                session.mtModel.tsdInitiated = "true"
				render(view: "/others/imports/dataentry/outgoing_mt/mt"+session.mtMessageType, model: session.mtModel);
			}else{
				render(view: "/others/imports/dataentry/outgoing_mt/mt"+session.mtMessageType, model: [:]);
			}
		}catch(Exception e){
			e.printStackTrace()
			render(view: "/main/outgoing_mt_error")
		}
//		def model = chainModel ?:  ?: session.mtModel ?: [:];
    }    
}
