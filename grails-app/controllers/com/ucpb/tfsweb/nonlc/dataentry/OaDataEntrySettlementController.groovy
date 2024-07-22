package com.ucpb.tfsweb.nonlc.dataentry

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartFile

/**
 * <pre>
 * Program_id    : OaDataEntrySettlementController
 * Program_name  : TFS Open Account Settlement Controller
 * SCR_Number    : IBD-12-0502-01
 * Process_Mode  : WEB
 * Frequency     : Daily
 * Input         : N/A
 * Output        : N/A
 * Description   : Controller for the OA Settlement Data Entry Module
 * Called In     : User Interface, UnactedService.groovy
 * </pre>
 * @author Marvin Volante
 * @author Arvin Patrick Guiam
 *
 */
class OaDataEntrySettlementController {

    /**
	* Definition of the HeaderService.groovy
	* @see com.ucpb.tfsweb.utilities.HeaderService
	*/
    def headerService
	/**
	* Definition of the DataEntryService.groovy
	* @see com.ucpb.tfsweb.main.lc.dataentry.DataEntryService
	*/
    def dataEntryService
	/**
	* Definition of the ChargesPaymentService.groovy
	* @see com.ucpb.tfsweb.main.ChargesPaymentService
	*/
	def chargesPaymentService
	/**
	* Definition of the DocumentUploadingService.groovy
	* @see com.ucpb.tfsweb.utilities.DocumentUploadingService
	*/
    def documentUploadingService
	/**
	* Definition of the RoutingInformationService.groovy
	* @see com.ucpb.tfsweb.main.lc.routing.RoutingInformationService
	*/
    def routingInformationService
	/**
	* Definition of the ParserService.groovy
	* @see com.ucpb.tfsweb.utilities.ParserService
	*/
	def parserService
	/**
	* Definition of the TabUtilityService.groovy
	* @see com.ucpb.tfsweb.utilities.TabUtilityService
	*/
    def tabUtilityService
	/**
	* Definition of the ForeignExchangeService.groovy
	* @see com.ucpb.tfsweb.main.utilities.ForeignExchangeService
	*/
    def foreignExchangeService
	/**
	* Definition of the RatesService.groovy
	* @see com.ucpb.tfsweb.main.RatesService
	*/
    def ratesService
	/**
	* Definition of the CoreAPIService.groovy
	* @see com.ucpb.tfsweb.utilities.CoreAPIService
	*/
	def coreAPIService

    /** Defines the Reference Type of the module*/
    protected String REFERENCE_TYPE = "DATA_ENTRY"
    /** Defines the Service Type Type of the module*/
    protected String SERVICE_TYPE = "Settlement"
    /** Defines the Document Class Type of the module*/
    protected String DOCUMENT_CLASS = "OA"
	/** Defines the Document Type Type of the module*/
	protected String DOCUMENT_TYPE = "FOREIGN"

	/**
     * Renders the Page
     * @return the view of the Settlement Module
     */
    def viewSettlement() {
        if(chainModel) {
			session.dataEntryModel = chainModel
		}

        def mapz = parserService.sessionModelToHashMap(session.dataEntryModel)

		//go to unacted if cancelled from basic details tab
		if(session.cancelBd){
			 session.removeAttribute("cancelBd")
			 render(view:"/main/unacted_transaction")
		}
        else if(session.dataEntryModel) {
            String tradeServiceId = session.dataEntryModel.tradeServiceId
            Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
            session.dataEntryModel << [paymentsMade: paymentsMade.payments]
            session.dataEntryModel << [loanCount: paymentsMade.loanCount]
			
            def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
            session.dataEntryModel << [exchange:exchange]

            def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
            session.dataEntryModel << [urrrates:urrrates]

            render(view: "/nonlc/oa/index", model:chainModel ? chainModel : session.dataEntryModel)
        }else{
            render(view: "/main/unauthorized")
        }
    }

	/**
	* Prepares the data for viewing of the Module.
	* Chains to viewSettlement
	*/
    def viewSettlementDataEntry() {

        Boolean reverseDE
        String reversalDENumber = ""
        String reversedDENumber = ""
        String reversalEtsNumber = ""
        String realPaymentStatus = ""
        Integer realApprovalLevel = 0
        String realStatus = ""
        String approvers=""

        if((params.serviceType == null) || (params.serviceType.toString().equalsIgnoreCase("SETTLEMENT"))
			|| "viewMode" == params.viewMode) {
            reverseDE = false
        } else {
            reverseDE = true
        }
        println "i am reverse " + reverseDE
//        String headerTitle = "FX Document Against Acceptance Settlement Non-LC - Data Entry"
//		String headerTitle = headerService.getDataEntryTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, null, SERVICE_TYPE + (reverseDE ? " Reversal" : ""))
		String headerTitle = reverseDE ? headerService.getNonLcReversalTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, SERVICE_TYPE, REFERENCE_TYPE) : headerService.getDataEntryTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")

        session.dataEntryModel = [documentType: DOCUMENT_TYPE, documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
        println "params " + params
        if (reverseDE) {
            reversalDENumber = params.tradeServiceId
            Map<String, Object> reversalDEMap = dataEntryService.getDataEntry(reversalDENumber)

            realPaymentStatus = reversalDEMap.paymentStatus
            realStatus = reversalDEMap.status

            approvers = reversalDEMap.approvers

            realApprovalLevel = reversalDEMap.approvalLevel

            reversalEtsNumber = reversalDEMap.serviceInstructionId
            reversedDENumber = reversalDEMap.originalTradeServiceId
            println "original " + reversedDENumber
            session.dataEntryModel << [reversalDataEntry: true]
        }

		if (params.tradeServiceId) {
			// Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            Map<String, Object> dataEntryMap

            dataEntryMap = reverseDE ? dataEntryService.getDataEntry(reversedDENumber) : dataEntryService.getDataEntry(params.tradeServiceId)

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

        // todo: refactor, this should be in a service or something
        // todo: we are still using etsModel so we don't have to do an if in the instructions and routing tab
        def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "", REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "",SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "", SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        ////println"*******view**********"
        ////println"financial >> " + session.financial
        ////println"postApprovalRequirement >> " + session.postApprovalRequirement
        ////println"amountToCheck >> " + session.amountToCheck
        ////println"signingLimit >> " + session.signingLimit
        ////println"postingAuthority >> " + session.postingAuthority
        ////println"status >> " + session.dataEntryModel?.status
        ////println"***********************"

        ////println"*******view**********"
        ////println"financial >> " + session.financial
        ////println"postApprovalRequirement >> " + session.postApprovalRequirement
        ////println"amountToCheck >> " + session.amountToCheck
        ////println"signingLimit >> " + session.signingLimit
        ////println"postingAuthority >> " + session.postingAuthority
        ////println"status >> " + session.dataEntryModel?.status
        ////println"***********************"
		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
		}
		
		//for Amla
		def paymentsMade = chargesPaymentService.findAllPaymentsForAmla(params.tradeServiceId)
		
		List<Object> paymentList = new ArrayList<Map<String, Object>>();
		paymentList.addAll(paymentsMade)

		def count=0;

		for(Object listahan:paymentList.listIterator()) {
			
			println paymentList.get(count).toString() + " aaaarrrrraaaaayyyyy " + count.toString()
			
			def paymentDetail = paymentList.get(count)
			for(Map.Entry<String, String> laman: paymentDetail.entrySet()) {
				
				println laman.getKey() + " : " + laman.getValue()
				
				if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASA")) {
						session.dataEntryModel<<[amlaCasaFlag:"1",
												 amlaCashFlag:"0",
												 amlaCheckFlag:"0",
												 amlaRemittanceFlag:"0",
												 amlaCheckFlagAmount:"0.00",
												 amlaRemittanceFlagAmount:"0.00",
												 amlaCashFlagAmount:"0.00",
												 amlaCasaFlagAmount:paymentDetail.get("AMOUNTINLCCURRENCY").toString()]
				}

				if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASH")) {
					session.dataEntryModel<<[amlaCashFlag:"1",
											 amlaCasaFlag:"0",
											 amlaCheckFlag:"0",
											 amlaRemittanceFlag:"0",
											 amlaCasaFlagAmount:"0.00",
											 amlaRemittanceFlagAmount:"0.00",
											 amlaCheckFlagAmount:"0.00",
											 amlaCashFlagAmount:paymentDetail.get("AMOUNTINLCCURRENCY").toString()]
				}
					
				if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CHECK")) {
					session.dataEntryModel<<[amlaCheckFlag:"1",
											 amlaCasaFlag:"0",
											 amlaCashFlag:"0",
											 amlaRemittanceFlag:"0",
										     amlaCasaFlagAmount:"0.00",
											 amlaRemittanceFlagAmount:"0.00",
											 amlaCashFlagAmount:"0.00",
											 amlaCheckFlagAmount:paymentDetail.get("AMOUNTINLCCURRENCY").toString()]
				}
				
				//added Remittance as per discussion with maam juliet 02/20/2015
				//same trancode with Check
				if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("REMITTANCE")) {
					session.dataEntryModel<<[amlaRemittanceFlag:"1",
											 amlaCasaFlag:"0",
											 amlaCashFlag:"0",
											 amlaCheckFlag:"0",
											 amlaCasaFlagAmount:"0.00",
											 amlaCheckFlagAmount:"0.00",
											 amlaCashFlagAmount:"0.00",
											 amlaRemittanceFlagAmount:paymentDetail.get("AMOUNTINLCCURRENCY").toString()]

				}

			}
			count++
		}
		
        // chain to render page
		chain(action: "viewSettlement", model: session.dataEntryModel)
    }

    def saveSettlementDataEntry() {
        ////println'save nego data entry'
    }

	/**
	* Updates the data in the Database with the data encoded in the Module.
	* Chains to viewSettlement
	*/
    def updateSettlementDataEntry() {
        ////println'update nego data entry'
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
		
		//For AMLA
		session.dataEntryModel<<[amlaCasaFlag:params.amlaCasaFlag,
								amlaCashFlag:params.amlaCashFlag,
								amlaCheckFlag:params.amlaCheckFlag,
								amlaRemittanceFlag:params.amlaRemittanceFlag,
								amlaCasaFlagAmount:params.amlaCasaFlagAmount,
								amlaCashFlagAmount:params.amlaCashFlagAmount,
								amlaCheckFlagAmount:params.amlaCheckFlagAmount,
								amlaRemittanceFlagAmount:params.amlaRemittanceFlagAmount]
		
		// chain to render page
		chain(action: "viewSettlement", model: session.dataEntryModel)
    }

	/**
	* Updates the data in the Database with the data encoded in the Module.
	* Redirects the Page back to the Unacted Screen when called.
	*/
    def updateDataEntryStatus() {
        //println'update nego data entry status'
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

    def viewAttachments() {

        def tradeServiceIdHolder =  params.tradeServiceIdHolder
        ////println"tradeServiceIdHolder:" + tradeServiceIdHolder

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
        def jsonData
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
        redirect(action:'invokeUploadCommand',params:params)
    }

    def invokeUploadCommand(){
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
        chain(action:"viewSettlement", model: session.dataEntryModel)
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
