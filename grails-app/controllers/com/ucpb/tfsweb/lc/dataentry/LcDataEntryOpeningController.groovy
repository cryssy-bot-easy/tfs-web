package com.ucpb.tfsweb.lc.dataentry

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartFile

/**
 * <pre>
 * Program_id    : LcDataEntryOpeningController
 * Program_name  : LcDataEntryOpeningController
 * SCR_Number    : 
 * Process_Mode  : WEB
 * Frequency     : Daily
 * Input         : N/A
 * Output        : N/A
 * Description   : 
 * Called in     : 
 * </pre>
 *
 * @author 
 * @version 
 */
/**
 * <pre>
 * Revision      : Added Validation of DraftStatus for Advance Copy
 * Revised By    : Christopher Opeña
 * SCR_Number    : IBD-13-1202-01
 * Keyword       : [Advance_Copy]
 * </pre>
 * 
 * <pre>
 * Revision      : Added fields use for AMLA Format1.0
 * Revised By    : Alexander Bilalang
 * SCR_Number    : 
 * Keyword       : AMLA Format 1.0
 * </pre>
 */
class LcDataEntryOpeningController {
	
	def headerService
    def dataEntryService
    def documentUploadingService
    def routingInformationService
	
	def parserService

    def tabUtilityService

    def coreAPIService

	//for AMLA
	def chargesPaymentService
	
	def requiredDocumentsService
	def additionalConditionService
	
	// sets service type
    protected String REFERENCE_TYPE = "DATA_ENTRY"
	protected String SERVICE_TYPE = "Opening"
	protected String DOCUMENT_CLASS = "LC"
	
	// render page
	def viewOpening() {
		if(chainModel) {
			session.dataEntryModel = chainModel
		}

        def mapz = parserService.sessionModelToHashMap(session.dataEntryModel)
		if(session.cancelBd){
			session.removeAttribute("cancelBd")
			render(view:"/main/unacted_transaction")
	    }
        else if(session.dataEntryModel) {
			
			session.dataEntryModel << [requiredDocumentsList : requiredDocumentsService.getAllRequiredDocument(session.dataEntryModel).collect { r -> r.DESCRIPTION?.toUpperCase()}]
			session.dataEntryModel << [additionalConditionsList : additionalConditionService.getAllAdditionalCondition(session.dataEntryModel).collect { r -> r.CONDITION?.toUpperCase()}]
			
			render(view: "/lc/dataentry/opening/index", model:chainModel ?: session.dataEntryModel)
		}else{
			render(view: "/main/unauthorized")
		}
	}

	// trigger viewing of page
	def viewOpeningDataEntry() {
		// get lc class and type
		Boolean reverseDE
		String reversalDENumber = ""
		String reversedDENumber = ""
		String reversalEtsNumber = ""
		String realPaymentStatus = ""
		Integer realApprovalLevel = 0
		String realStatus = ""
		String approvers=""
		String documentType = params.documentType
		String documentSubType1 = params.documentSubType1.toUpperCase()
		String documentSubType2 = params.documentSubType2
		session.etsPopup = "false"
		
		if((params.serviceType == null) || (params.serviceType.toString().equalsIgnoreCase("OPENING"))
			|| "viewMode" == params.viewMode) {
			reverseDE = false
		} else {
			reverseDE = true
		}

        // construct header title
		String headerTitle = headerService.getDataEntryTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        if (params.serviceType.contains("_REVERSAL")) {
            headerTitle += " Reversal"
        }

		// keep session model
		session.dataEntryModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

		if (reverseDE) {
			reversalDENumber = params.tradeServiceId
			Map<String, Object> reversalDEMap = dataEntryService.getDataEntry(reversalDENumber)

			realPaymentStatus = reversalDEMap.paymentStatus
			realStatus = reversalDEMap.status

			approvers = reversalDEMap.approvers

			realApprovalLevel = reversalDEMap.approvalLevel

			reversalEtsNumber = reversalDEMap.serviceInstructionId
			reversedDENumber = reversalDEMap.originalTradeServiceId

			session.dataEntryModel << [reversalDataEntry: true]
		}
		
        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = reverseDE ? dataEntryService.getDataEntry(reversedDENumber) : dataEntryService.getDataEntry(params.tradeServiceId)
			
			if (reverseDE) {

				Map<String, Object> originalDEMap
				originalDEMap = dataEntryService.getDataEntry(reversedDENumber)

				dataEntryMap.put("amount", originalDEMap.amount)

				dataEntryMap.approvers = approvers
				dataEntryMap.put("reversalDENumber", reversalDENumber)
				dataEntryMap.put("reversalEtsNumber", reversalEtsNumber)
				dataEntryMap.put("reverseDE", true)
				dataEntryMap.put("paymentStatus", realPaymentStatus)
				dataEntryMap.put("status", realStatus)
				dataEntryMap.put("approvalLevel", realApprovalLevel)
			}
			
            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }
        }
		println "params.reversalEtsNumber: " + params.reversalEtsNumber
        if ((params.reversalEtsNumber ?: params.serviceInstructionId) && params.serviceType.contains("_REVERSAL")) {
            println "reversal ako at parameters ko" + params
			
            session.dataEntryModel << [reversalDataEntry: true]
            session.dataEntryModel << [reversalTradeServiceId: params.tradeServiceId]
			session.dataEntryModel << [reversalEtsNumber : params.serviceInstructionId]
			
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntryByServiceInstructionId(params.reversalEtsNumber ?: params.serviceInstructionId)

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }
        }

        // todo: refactor, this should be in a service or something
        // todo: we are still using etsModel so we don't have to do an if in the instructions and routing tab
        def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
			session.dataEntryModel<<[hasRoute:true]
			println "has Route - hardcoded"
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
			println "has Route - from params"
		}
		
		// For Advance Copy [Advance_Copy]
		if (params?.statusInquiry?.equalsIgnoreCase("DRAFT")){
			session.dataEntryModel<<[draftStatus: params.statusInquiry]  
		}else{
			session.dataEntryModel<<[draftStatus: "not draft"]
		}
		
		if(documentSubType1.toString().equalsIgnoreCase("CASH")) {
			
			//for Amla
			def paymentsMade = chargesPaymentService.findAllPaymentsForAmla(params.tradeServiceId)
			
			List<Object> paymentList = new ArrayList<Map<String, Object>>();
			paymentList.addAll(paymentsMade)
			
			def count=0;
	
			for(Object listahan:paymentList.listIterator()) {
				
				println paymentList.get(count).toString() + " laaaammmmmmaaaaannn " + count.toString()
				
				def paymentDetail = paymentList.get(count)
				for(Map.Entry<String, String> laman: paymentDetail.entrySet()) {
					
					println laman.getKey() + " : " + laman.getValue()
					
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASA")
						&& paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")){
						session.dataEntryModel<<[amlaCasaFlag:"1",
												 amlaCasaFlagPhp:"1",
												 amlaCasaFlagAmount:paymentDetail.get("AMOUNT").toString()]

					}
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASA")
							&& !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")){
							session.dataEntryModel<<[amlaCasaFlag:"1",
													 amlaCasaFlagFx:"1",
													 amlaCasaFlagAmount:paymentDetail.get("AMOUNT").toString(),
													 amlaCasaFlagFxCurrency:paymentDetail.get("CURRENCY").toString()]
					}
							
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("REMITTANCE")
						&& paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
						session.dataEntryModel<<[amlaRemittanceFlag:"1",
												 amlaRemittanceFlagPhp:"1",
												 amlaRemittanceFlagAmount:paymentDetail.get("AMOUNT").toString()]
					}
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("REMITTANCE")
						&& !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
						session.dataEntryModel<<[amlaRemittanceFlag:"1",
												 amlaRemittanceFlagFx:"1",
												 amlaRemittanceFlagAmount:paymentDetail.get("AMOUNT").toString()]
					}
					
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASH")
						&& paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
						session.dataEntryModel<<[amlaCashFlag:"1",
												 amlaCashFlagPhp:"1",
												 amlaCashFlagAmount:paymentDetail.get("AMOUNT").toString()]
					}
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASH")
						&& !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
						session.dataEntryModel<<[amlaCashFlag:"1",
												  amlaCashFlagFx:"1",
												 amlaCashFlagAmount:paymentDetail.get("AMOUNT").toString()]
					}
						
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CHECK")
						&& paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
						session.dataEntryModel<<[amlaCheckFlag:"1",
												 amlaCheckFlagPhp:"1",
												 amlaCheckFlagAmount:paymentDetail.get("AMOUNT").toString()]

					}
					if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CHECK")
						&& !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
						session.dataEntryModel<<[amlaCheckFlag:"1",
												 amlaCheckFlagFx:"1",
												 amlaCheckFlagAmount:paymentDetail.get("AMOUNT").toString()]
					}
						
						//added Remittance as per discussion with maam juliet 02/20/2015
						//same trancode with Check
						if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("REMITTANCE")
							&& paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
							session.dataEntryModel<<[amlaRemittanceFlag:"1",
													 amlaRemittanceFlagPhp:"1",
													 amlaRemittanceFlagAmount:paymentDetail.get("AMOUNT").toString()]
	
						}
						if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("REMITTANCE")
							&& !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")) {
							session.dataEntryModel<<[amlaRemittanceFlag:"1",
													 amlaRemittanceFlagFx:"1",
													 amlaRemittanceFlagAmount:paymentDetail.get("AMOUNT").toString(),
												 amlaRemittanceFlagFxCurrency:paymentDetail.get("CURRENCY").toString()]
						}
				}
				count++
			}
		}

        // chain to render page
		chain(action:"viewOpening", model: session.dataEntryModel)
	}
	
	def updateOpeningDataEntry() {
        ////println"updateOpeningDataEntry"
        // get lc class and type
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getDataEntryTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.dataEntryModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
        session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

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
		
		session.dataEntryModel<<[draftStatus: params.draftStatus]
		
		if(documentSubType1.equalsIgnoreCase("CASH")) {
			//For AMLA
			session.dataEntryModel<<[amlaCasaFlag:params.amlaCasaFlag,
									amlaCashFlag:params.amlaCashFlag,
									amlaCheckFlag:params.amlaCheckFlag,
									amlaRemittanceFlag:params.amlaRemittanceFlag,
									amlaCasaFlagPhp:params.amlaCasaFlagPhp,
									amlaCashFlagPhp:params.amlaCashFlagPhp,
									amlaCheckFlagPhp:params.amlaCheckFlagPhp,
									amlaRemittanceFlagPhp:params.amlaRemittanceFlagPhp,
									amlaCasaFlagAmount:params.amlaCasaFlagAmount,
									amlaCashFlagAmount:params.amlaCashFlagAmount,
									amlaCheckFlagAmount:params.amlaCheckFlagAmount,
									amlaRemittanceFlagAmount:params.amlaRemittanceFlagAmount,
									amlaCasaFlagFx:params.amlaCasaFlagFx,
									amlaCashFlagFx:params.amlaCashFlagFx,
									amlaCheckFlagFx:params.amlaCheckFlagFx,
									amlaRemittanceFlagFx:params.amlaRemittanceFlagFx,
									amlaRemittanceFlagFxCurrency:params.amlaRemittanceFlagFxCurrency,
									amlaCasaFlagFxCurrency:params.amlaCasaFlagFxCurrency]
		}


		// chain to render page
		chain(action:"viewOpening", model:session.dataEntryModel)
	}

    def updateDataEntryStatus() {
        ////println"updateDataEntryStatus"
        // get lc class and type
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getDataEntryTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        ////println"*******update status*********"
        ////println"financial >> " + session.financial
        ////println"postApprovalRequirement >> " + session.postApprovalRequirement
        ////println"amountToCheck >> " + session.amountToCheck
        ////println"signingLimit >> " + session.signingLimit
        ////println"postingAuthority >> " + session.postingAuthority
        ////println"status >> " + session.dataEntryModel?.status
        ////println"***********************"

        String statusAction = routingInformationService.getStatusAction(session.financial,
                                                  params.statusAction, 
                                                  session.signingLimit, 
                                                  session.amountToCheck, 
                                                  session.dataEntryModel?.status, 
                                                  session.postApprovalRequirement)

        params.statusAction = statusAction

        // keep session model
        session.dataEntryModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)


        ////println"params.statusAction >> " + params.statusAction
        // this is for reversal
        if (params.reversalTradeServiceId) {
            params.tradeServiceId = params.reversalTradeServiceId
        }
        dataEntryService.updateDataEntry(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def viewAttachments() {

        def tradeServiceIdHolder =  params.tradeServiceIdHolder
        // println "tradeServiceIdHolder = ${tradeServiceIdHolder}"

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = dataEntryService.getAttachmentList( maxRows, rowOffset, currentPage, tradeServiceIdHolder)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = dataEntryService.getGridFormattedAttachments(mapList.display, tradeServiceIdHolder)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def uploadDocument() {

        try{

            ////printlnrequest
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
            MultipartFile uploadedFile = multiRequest.getFile("fileLocation")

            String tradeServiceId = params?.tradeServiceId
            println "tradeServiceId = ${tradeServiceId}"

            params.filename = documentUploadingService.saveFile(uploadedFile, tradeServiceId)

        } catch(Exception e){
            e.printStackTrace()
            ////printlne.message
        }
        //NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
        redirect(controller:'lcDataEntryOpening', action:'invokeUploadCommand', params:params)
        // forward controller: "lcDataEntryOpening", action: "invokeUploadCommand", params: params
    }

//    def invokeUploadCommand(){
//        def jsonData
//
//        try{
//            // trigger command
//            String temp =  dataEntryService.uploadAttachedToTradeService(params)
//            jsonData = [success: true]
//        } catch(Exception e){
//            e.printStackTrace()
//            ////printlne.message
//            jsonData = [success: false]
//        }
//        chain(action:"viewOpening", model: session.dataEntryModel)
//    }

    def invokeUploadCommand() {

        def jsonData

        try{

            session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            // trigger command
            String temp =  dataEntryService.uploadAttachedToTradeService(params)
            jsonData = [success: true]

        } catch(Exception e){

            e.printStackTrace()
            ////printlne.message
            jsonData = [success: false]
        }

        chain(action:"viewOpening", model: session.dataEntryModel)
    }

    def downloadFile() {

        String id = params?.id
        println "id = ${id}"

        String tradeServiceId = params?.tradeServiceId
        println "tradeServiceId = ${tradeServiceId}"

        def returnValue = coreAPIService.dummySendQuery(params, "getFileDetails", "attachment/")

        def fileName = returnValue?.details?.filename

        if (fileName != null) {

            File file = documentUploadingService.retrieveFile(fileName, tradeServiceId)

            if (file.exists()) {
                if(file.canRead()){
                    response.setContentType("application/octet-stream")
                    response.setHeader("Content-disposition", "filename=${file.name}")
                    response.outputStream << file.bytes
                    return
                }
            }

        } else {
            return
        }
    }

    def deleteDocument() {

        // sets statusAction to deleteDocument
        params.statusAction = "deleteDocument"

        // trigger command
        // TODO do delete document

        String id = params?.id
        String tradeServiceId = params?.tradeServiceId

        // println "id = ${id}"
        // println "filename = ${filename}"
        // println "tradeServiceId = ${tradeServiceId}"

        def jsonData = [:]

        try {

            // Delete attachment record first in db, then delete the file. The reverse is dangerous.
            def returnValue = coreAPIService.dummySendCommand(params, "delete", "attachment")

            def deleted = null
            if (returnValue.status == "ok") {
                // If successful, delete the actual file
                deleted = documentUploadingService.deleteFile(returnValue.details.filename, tradeServiceId)
            } else if (returnValue.status == "error") {
                throw new Exception(returnValue.error.code);
            }

            jsonData = [success: true]

        } catch (Exception e) {
            e.printStackTrace()
            jsonData = [success: false, message: e.getMessage()]
        }

        render jsonData as JSON
    }
}
