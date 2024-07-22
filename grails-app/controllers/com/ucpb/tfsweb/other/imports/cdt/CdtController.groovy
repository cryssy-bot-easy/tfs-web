package com.ucpb.tfsweb.other.imports.cdt

import grails.converters.JSON
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils
import net.ipc.utils.UploaderUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

import java.text.DecimalFormat
import java.text.SimpleDateFormat

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: CdtController
 */

/**
	 (revision)
	SCR/ER Number:
	SCR/ER Description: Add parameter on uploadDocument()
	[Revised by:] Jonh Henry Alabin
	[Date deployed:]
	Program [Revision] Details: Added parameters (user role, Email and Full name) for formatting of Email Notification
	PROJECT: CORE
	MEMBER TYPE  : Groovy

*/

/**
	 (revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick Nungay
	7[Date deployed:] 10/18/2017
	Program [Revision] Details: Added parameters newClient for checking if the client is newly registered
	PROJECT: CORE
	MEMBER TYPE  : Groovy

*/

/**
	 (revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick Nungay
	7[Date deployed:] 10/23/2017
	Program [Revision] Details: Added email and fullname of the user as parameter on uploading/resend email
	PROJECT: CORE
	MEMBER TYPE  : Groovy

*/

/**
 (revision)
SCR/ER Number:
SCR/ER Description:
[Revised by:] Cedrick Nungay
7[Date deployed:] 01/11/2018
Program [Revision] Details: Added email status on model gsp for viewCdtPayment
PROJECT: CORE
MEMBER TYPE  : Groovy

*/
class CdtController {

    def parserService
    def coreAPIService
    def routingInformationService

    def dataEntryService
    def cdtService

    def grailsApplication

    private static REMITTANCE_TABS = ["basicDetails", "instructionsAndRouting"]

	def validateAabRefCode() {
		
		def cdtParam = [aabRefCode: params.aabRefCode]
		
		def returnedValue = coreAPIService.dummySendQuery(cdtParam , "validateAabRefCode" , "cdt/")?.details 
		
		render returnedValue as JSON
	}
	
    def viewCdtPayment() {
        println 'CdtController viewCdtPayment'
        // TODO: this gets loaded thrice, need to fix grids breaking this
        if (chainModel) {

            session.model = chainModel

            // TODO: the grid breaks this too
            if (chainModel?.iedieirdNumber) {
                //println"number exists"
                def cdtPayment = coreAPIService.dummySendQuery([ied: session.model?.iedieirdNumber], "details", "cdt/payment/")?.details



                cdtPayment?.paymentRequest?.each {
                    session.model << it
                }

                println 'session.model' + session.model

                cdtPayment?.client?.each {
                    session.model << it
                }
                println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
                println 'session.model' + session.model
                println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

                if (cdtPayment?.tradeService?.tradeServiceId) {
                    session.model << cdtPayment?.tradeService?.tradeServiceId
                }
				
				if(cdtPayment?.paymentRequest?.status.equalsIgnoreCase("PAID") || 
					cdtPayment?.paymentRequest?.status.equalsIgnoreCase("NEW") ||
					cdtPayment?.paymentRequest?.status.equalsIgnoreCase("PENDING")){
					session.model << [paymentviewMode: false]
					
				}else{
					session.model << [paymentviewMode: true]
				}
                session.model << [emailStatus: cdtPayment?.paymentRequest?.emailNotifs?.iterator().next().emailStatus,
					rmbmEmail: cdtPayment?.paymentRequest?.rmbmEmail]
            }
        }

        session.model << [title: "Collection of Customs Duties and Taxes - Pay Duties and Taxes",
                tabs: [],
                serviceType: "PAYMENT",
                documentClass: "CDT",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "PAYMENT"
        ]

        session.model << [content: "../product/other/imports/cdt/payment/content"]

        session.model << [cdtAction: "saveCdtPayment"]
        println 'session.model' + session.model

        render(view: "../product/index", model: session.model)
    }

    def saveCdtPayment() {
        //println"saveCdtPayment"
        def parameterMap = [username: session.username,
                unitcode: session.unitcode,
                processingUnitCode: session.unitcode,
                userrole: session.userrole.id,
                documentNumber: params.documentNumber,
                tradeServiceId: params.tradeServiceId,
                ied: params.iedieirdNumber,
                amount: params.amount,
                bankCharge: params.defaultBankCharge,
                totalAmountDue: params.totalAmountDue,
                totalAmountOfPayment: params.totalAmountOfPayment,
                transactionReferenceNumber: params.cdtTransaction,
                paymentReferenceNumber: params.paymentReferenceNumber,
                serviceType: "PAYMENT",
                documentClass: "CDT",
                cifNumber: params.cifNumber
        ]
        println "params >>> " + params
        def returnedValues = coreAPIService.dummySendCommand(parameterMap, "save", "cdt/payment")

        String iedieirdNumber = returnedValues["details"]["paymentRequest"]["iedieirdNumber"]
        String tradeServiceId = returnedValues["details"]["tradeService"]["tradeServiceId"]["tradeServiceId"]

        // we get the eTS number from
        def sessionModel = [iedieirdNumber: iedieirdNumber, tradeServiceId: tradeServiceId]

        chain(action: "viewCdtPayment", model: sessionModel)
    }

    def viewCdtRefund() {
//      println "chainModel " + chainModel
        if (chainModel) {
            session.model = chainModel

            // TODO: the grid breaks this too
            if (chainModel?.iedieirdNumber && !chainModel?.tradeServiceId) {
                def cdtPayment = coreAPIService.dummySendQuery([ied: session.model?.iedieirdNumber, tsdInitiated: "true"], "details", "cdt/refund/")?.details

                cdtPayment?.paymentRequest?.each {
                    session.model << it
                }

                cdtPayment?.client?.each {
                    session.model << it
                }

//              println "cdtPayment?.totalAmountOfPayment " + cdtPayment?.totalAmountOfPayment
//				println "cdtPayment?.cdtAmount " + cdtPayment?.cdtAmount
//				println "cdtPayment?.ipf " + cdtPayment?.ipf
				
                session.model << [totalAmountOfPayment : cdtPayment?.totalAmountOfPayment]
				session.model << [cdtAmount : cdtPayment?.cdtAmount]
				session.model << [ipf : cdtPayment?.ipf]
				
				if(chainModel?.forViewing){
					session.model << cdtPayment?.tradeService?.details
					session.model << [tradeServiceId: cdtPayment?.tradeService?.tradeServiceId?.tradeServiceId]
				}

            } else if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.model << tradeService?.details
                session.model << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
                session.model.approvers = tradeService?.approvers
                session.model.approvalLevel = (session.model.approvers.isEmpty()) ? 1 : session.model.approvers.split(",").size() + 1
                session.model.paymentStatus = tradeService?.paymentStatus
            }
        }
		
		session.model << [title: "Collection of Customs Duties and Taxes - Refund",
		tabs: REMITTANCE_TABS,
		serviceType: "REFUND",
		documentClass: "CDT",
		documentType: "",
		documentSubType1: "",
		documentSubType2: "",
		referenceType: "DATA_ENTRY"
		]

		session.model << [tsdInitiated: "true"]
	
		session.model << [basicDetailsTab: "../product/other/imports/cdt/refund/basic_details_tab"]
	
		def documentServiceRoute = routingInformationService.getNextMainApprover("CDT", null, null, null, "DATA_ENTRY", "REFUND", session.username, session.userrole.id, session.unitcode, session.model, session.userLevel)
		session.nextRoute = documentServiceRoute
		session.model << routingInformationService.getMainApprovalMode("CDT", null, null, null, "REFUND", session.model.approvers)
	
        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("CDT", null, null, null, "REFUND", session.model, session.unitcode, session.username)
		
        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.model << [basicDetailsAction: "saveCdtRefund"]
        session.model << [routeAction: "updateDataEntryStatus"]
		
        render(view: "../product/index", model: session.model)
    }
	
    def saveCdtRefund() {
//        println"saveCdtRefund"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]

        chain(controller: "cdt", action: "viewCdtRefund", model: sessionModel)
    }

	def viewCdtBranchRefund() {
//		println 'CdtController viewCdtBranchRefund'
		// TODO: this gets loaded thrice, need to fix grids breaking this
		if (chainModel) {

			session.model = chainModel

			// TODO: the grid breaks this too
			if (chainModel?.iedieirdNumber) {
				//println"number exists"
				def cdtPayment = coreAPIService.dummySendQuery([ied: session.model?.iedieirdNumber, tsdInitiated: "false"], "details", "cdt/refund/")?.details

                cdtPayment?.paymentRequest?.each {
                    session.model << it
                }

                cdtPayment?.client?.each {
                    session.model << it
                }

//              println "cdtPayment?.totalAmountOfPayment " + cdtPayment?.totalAmountOfPayment
//				println "cdtPayment?.cdtAmount " + cdtPayment?.cdtAmount
//				println "cdtPayment?.ipf " + cdtPayment?.ipf
//				println "cdtPayment?.unitCode " + cdtPayment?.paymentRequest?.unitCode
				
                session.model << [totalAmountOfPayment : cdtPayment?.totalAmountOfPayment]
                session.model << [cdtAmount : cdtPayment?.cdtAmount]
				session.model << [ipf : cdtPayment?.ipf]
				session.model << [processingUnitCode : cdtPayment?.paymentRequest?.unitCode]

				if (cdtPayment?.tradeService?.tradeServiceId) {
//					println 'cdtPayment?.tradeService' + cdtPayment?.tradeService
					session.model << cdtPayment?.tradeService?.details
					session.model << cdtPayment?.tradeService?.tradeServiceId
				}
			}
		}

		session.model << [title: "Collection of Customs Duties and Taxes - Refund",
	                tabs: ["basicDetails"],
	                serviceType: "REFUND",
	                documentClass: "CDT",
	                documentType: "",
	                documentSubType1: "",
	                documentSubType2: "",
	                referenceType: "ETS"
	        ]
		session.model << [tsdInitiated: "false"]
        session.model << [basicDetailsTab: "../product/other/imports/cdt/refund/basic_details_tab"]
		
		session.model << [basicDetailsAction: "saveCdtBranchRefund"]

		render(view: "../product/index", model: session.model)
	}
	
	
	def viewRemittancereport(){
		
		
		if (chainModel) {
			session.model = chainModel

			if (chainModel?.tradeServiceId) {
				def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details
//                println "tradeService >> " + tradeService
				session.model << tradeService?.details
				session.model << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
				session.model << tradeService["tradeServiceReferenceNumber"]
				session.model << tradeService["documentNumber"]
				session.model.approvers = tradeService?.approvers
				session.model.put("approvalLevel", (tradeService.approvers.isEmpty()) ? 1 : tradeService.approvers.split(",").size() + 1)
				session.model.paymentStatus = tradeService?.paymentStatus
			}
		}
		println '.a.a.a.a ' + session.model.paymentStatus
		session.model << [title: "(View Report)Remittance of Customs Duties and Taxes - CDT",
				tabs: REMITTANCE_TABS,
				serviceType: "REMITTANCE",
				documentClass: "CDT",
				documentfor: "reportCDT",
				documentType: "",
				documentSubType1: "",
				documentSubType2: "",
				referenceType: "DATA_ENTRY"
		]

		session.model << [tsdInitiated: "true"]

		session.model << [basicDetailsTab: "../product/other/imports/cdt/remittance/basic_details_tab"]


		session.model << [basicDetailsAction: "saveCdtRemittance"]
		session.model << [routeAction: "updateDataEntryStatus"]
		
		
		render(view: "../product/index", model: session.model)
		
		
	}
	


	def saveCdtBranchRefund() {
//		println"saveCdtBranchRefund"
		
		params.username = session.username
		params.unitcode = session.unitcode
		params.userrole = session.userrole.id
		params.serviceType = "REFUND"
		params.documentClass = "CDT"
		params.tsdInitiated = "false"
		
//		println "params >>> " + params
		def returnedValues = coreAPIService.dummySendCommand(params, "save", "cdt/refund")

		String iedieirdNumber = returnedValues["details"]["paymentRequest"]["iedieirdNumber"]
		String tradeServiceId = returnedValues["details"]["tradeService"]["tradeServiceId"]["tradeServiceId"]
		String tsdInitiated = returnedValues["details"]["tsdInitiated"]

		// we get the eTS number from
		def sessionModel = [iedieirdNumber: iedieirdNumber, tradeServiceId: tradeServiceId, tsdInitiated: tsdInitiated]

		chain(controller: "cdt", action: "viewCdtBranchRefund", model: sessionModel)
	}

    def viewRemittance() {
        if (chainModel) {
            session.model = chainModel

            if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details
//                println "tradeService >> " + tradeService
                session.model << tradeService?.details
                session.model << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
                session.model << tradeService["tradeServiceReferenceNumber"]
                session.model << tradeService["documentNumber"]
                session.model.approvers = tradeService?.approvers
                session.model.put("approvalLevel", (tradeService.approvers.isEmpty()) ? 1 : tradeService.approvers.split(",").size() + 1)
                session.model.paymentStatus = tradeService?.paymentStatus
            }
        }
        println '.a.a.a.a ' + session.model.paymentStatus
        session.model << [title: "Remittance of Customs Duties and Taxes - CDT",
                tabs: REMITTANCE_TABS,
                serviceType: "REMITTANCE",
                documentClass: "CDT",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

        session.model << [tsdInitiated: "true"]

        session.model << [basicDetailsTab: "../product/other/imports/cdt/remittance/basic_details_tab"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("CDT", null, null, null, "DATA_ENTRY", "REMITTANCE", session.username, session.userrole.id, session.unitcode, session.model, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.model << routingInformationService.getMainApprovalMode("CDT", null, null, null, "REMITTANCE", session.model.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("CDT", null, null, null, "REMITTANCE", session.model, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.model << [basicDetailsAction: "saveCdtRemittance"]
        session.model << [routeAction: "updateDataEntryStatus"]

        render(view: "../product/index", model: session.model)
    }

    def saveCdtRemittance() {
        //println"saveCdtRemittance"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]

        chain(controller: "cdt", action: "viewRemittance", model: sessionModel)
    }

    def viewCdtClient() {
//        if (session.model.ccn) {
//            def client = coreAPIService.dummySendQuery([ccn: session.model?.ccn], "details", "cdt/importer/")?.details
//            println client
//            //printlnclient
//            session.model << client
//        }

        if (session.model?.agentBankCode) {
            println "session.model?.agentBankCode:"+session.model?.agentBankCode
            def client = coreAPIService.dummySendQuery([agentBankCode: session.model?.agentBankCode], "details", "cdt/importer/")?.details
            if(client!=null){
                session.model << client
            }
        }

        session.model << [title: "Collection of Customs Duties and Taxes - Encode Client Details",
                tabs: [],
                serviceType: "",
                documentClass: "",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "CLIENT"
        ]

        session.model << [content: "../product/other/imports/cdt/client/content"]

        session.model << [cdtAction: "saveCdtClient"]

        render(view: "../product/index", model: session.model)
    }

    def saveCdtClient() {
        println"saveCdtClient"
        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

		def email = coreAPIService.dummySendQuery([agentBankCode: params.agentBankCode], "details", "cdt/importer/")?.details?.email ?: ''
		if (email.equalsIgnoreCase('')) {
			params.newClient = 'y'
		} else {
			params.newClient = 'n'
		}
		
        def returnedValues = coreAPIService.dummySendCommand(params, "save", "cdt/importer")

        chain(action: "viewCdtClient")
    }

    def viewCdtUploadTransactions() {
        session.model = [:]
        session.model << [title: "Collection of Customs Duties and Taxes - Upload Transactions",
                tabs: [],
                serviceType: "",
                documentClass: "CDT",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "TRANSACTIONS"
        ]

        session.model << [content: "../product/other/imports/cdt/upload/content"]

        render(view: "../product/index", model: session.model)
    }

    def viewCdtUploadClients() {
        session.model = [:]
        session.model << [title: "Collection of Customs Duties and Taxes - Upload Client File",
                tabs: [],
                serviceType: "",
                documentClass: "CDT",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "TRANSACTIONS"
        ]

        session.model << [content: "../product/other/imports/cdt/upload/clientuploadcontent"]

        render(view: "../product/index", model: session.model)
    }
    
    def todaysTransactions() {

        def transactions = coreAPIService.dummySendQuery([:], "history", "cdt/payment/").details
        //http://localhost:9090/tfs-core/api/cdt/payment/history

        render transactions as JSON
    }

    def viewCdtUploadPaymentHistory() {

        session.model = [:]
        session.model << [title: "Collection of Customs Duties and Taxes - Upload Payment History",
                tabs: [],
                serviceType: "",
                documentClass: "CDT",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "TRANSACTIONS"
        ]

        session.model << [content: "../product/other/imports/cdt/upload/paymenthistory"]
	
		

        def transactions = coreAPIService.dummySendQuery([unitCode: session.unitcode,confDate: params.confDate], "history", "cdt/payment/").details
        println 'transactions ' + transactions
        BigDecimal cdtTotal = BigDecimal.ZERO
		BigDecimal totalPaid = BigDecimal.ZERO
        BigDecimal e2mTotal = coreAPIService.dummySendQuery([unitCode: session.unitcode,confDate: params.confDate], "getCurrentTotal", "cdt/history/").details

        transactions.each() { transaction ->
            if (transaction?.status?.toString().equalsIgnoreCase("PAID") || transaction?.status?.toString().equalsIgnoreCase("SENTTOBOC")) {
//            if (transaction?.status?.toString().equalsIgnoreCase("PAID")) {
                //cdtTotal = transaction.amount ? cdtTotal?.add(new BigDecimal(transaction.amount?.toString()?.replaceAll(",", ""))) : BigDecimal.ZERO
                totalPaid += (transaction.amount ? new BigDecimal(transaction.amount?.toString()?.replaceAll(",", "")) : BigDecimal.ZERO)
               
				 println '* ' + transaction?.amount
				println "++++ " + transaction?.confDate
				
				
				if(transaction?.confDate){
					
//					tmpTrans << transaction
					cdtTotal += (transaction.amount ? new BigDecimal(transaction.amount?.toString()?.replaceAll(",", "")) : BigDecimal.ZERO)
					
				}
		
	
            }
        }

        Map model = session.model

        model.cdtTotal = cdtTotal ?: 0
        model.e2mTotal = e2mTotal ?: 0
		model.totalPaid = totalPaid ?: 0
		
        println "cdtTotal " + cdtTotal
        println "e2mTotal " + e2mTotal

        // get current tradeservice

        def returnedValues = coreAPIService.dummySendQuery([unitCode: session.unitcode, confDate: params.confDate], "getCurrentTradeService", "cdt/").details

        println " returnedValues " + returnedValues + " " + session.unitcode
        session.model << [tradeServiceId : returnedValues?.tradeServiceId]
        session.model << [referenceNumber : returnedValues?.referenceNumber]

//        if (returnedValues?.tradeServiceId) {
//            session.model << [cdtTotal: returnedValues?.sentAmount]
//        }

        render(view: "../product/index", model: session.model)
    }    
	
	def computeonChangeDate(){
		
		println params.unitcode + " params.unitcode"
		println params.confDate + " params.sentBOCDate"
		def transactions = coreAPIService.dummySendQuery([unitCode: params.unitcode,confDate: params.confDate], "history", "cdt/payment/").details
		
		BigDecimal cdtTotal = BigDecimal.ZERO
		
		BigDecimal e2mTotal = BigDecimal.ZERO
		
		BigDecimal totalPaid = BigDecimal.ZERO

		e2mTotal = coreAPIService.dummySendQuery([unitCode: params.unitcode,confDate: params.confDate], "getCurrentTotal", "cdt/history/").details
		
		
		transactions.each() { transaction ->
			if (transaction?.status?.toString().equalsIgnoreCase("PAID") || transaction?.status?.toString().equalsIgnoreCase("SENTTOBOC")) {
//            if (transaction?.status?.toString().equalsIgnoreCase("PAID")) {
				//cdtTotal = transaction.amount ? cdtTotal?.add(new BigDecimal(transaction.amount?.toString()?.replaceAll(",", ""))) : BigDecimal.ZERO
				println "date---" + transaction?.confDate
//				if(!transaction?.confDate)
				totalPaid += (transaction.amount ? new BigDecimal(transaction.amount?.toString()?.replaceAll(",", "")) : BigDecimal.ZERO)
				println '* ' + transaction?.amount
				
				if(transaction?.confDate){
					
//					tmpTrans << transaction
					cdtTotal += (transaction.amount ? new BigDecimal(transaction.amount?.toString()?.replaceAll(",", "")) : BigDecimal.ZERO)
					
				}
				

			}
		}
		
		
		
		
		render([e2mTotal: e2mTotal ? e2mTotal : 0.00, cdtTotal: cdtTotal? cdtTotal : 0.00, totalPaid: totalPaid? totalPaid : 0.00] as JSON)

		
		
		
	}

    def uploadDocument() {
        // http://www.intelligrape.com/blog/2012/08/31/groovy-http-builder-for-sending-multipart-file/
		
		

        String fileType = params.fileType
        println "the fileType >> " + fileType
		def confDate = params.confDate

        //println"in the upload controller"     
		def params = [:]
		
        try{
			
            //handle uploaded file
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request

            MultipartFile uploadedFile = multiRequest.getFile("fileLocation")

            UploaderUtils uploaderUtils = new UploaderUtils();

            String cdtApiUrl = grailsApplication.config.tfs.core.api.cdt.upload.url
			String userId = session.username
			def employeeDetails = coreAPIService.dummySendQuery([:], userId, "security/user/");
            println ">>>>>>>>>>>>> cdtApiUrl = ${cdtApiUrl}"
//			println "Henry Na naman : " + employeeList
			String fullName = employeeDetails.details.employeeDetails.fullName
			String email = employeeDetails.details.employeeDetails.email
            if ("clients".equals(fileType)) {
                String userrole = "TSD"

                if (session.userrole.id.startsWith("BR")) {
                    userrole = "BRANCH"
                }

//                uploaderUtils.sendMultiPartFile2((CommonsMultipartFile) uploadedFile, fileType, cdtApiUrl, userrole)
                uploaderUtils.sendMultiPartClient((CommonsMultipartFile) uploadedFile, fileType, cdtApiUrl, userrole, session.unitcode)
				println "Clients"
            } else if ("transactions".equals(fileType)) {
				String userrole = "TSD"
			
				if (session.userrole.id.startsWith("BR")) {
					userrole = "BRANCH"
				}
				println "email Pasok " + email
				println "fullName Pasok " + fullName
                uploaderUtils.sendMultiPartFileWithBookCodeAndAlloc((CommonsMultipartFile) uploadedFile, fileType, cdtApiUrl, session.unitcode, session.fullUnitCode, userrole, fullName, email)
            } else {

                uploaderUtils.sendMultiPartFileWithBookCode((CommonsMultipartFile) uploadedFile, fileType, cdtApiUrl, session.unitcode, confDate)
            }/*else if ("transactions".equals(fileType)) {
                uploaderUtils.sendMultiPartFileWithBookCode((CommonsMultipartFile) uploadedFile, fileType, cdtApiUrl, session.unitcode)
            } else {
                // history
//                uploaderUtils.sendMultiPartFile((CommonsMultipartFile) uploadedFile, fileType, cdtApiUrl)
                uploaderUtils.sendMultiPartFileWithBookCode((CommonsMultipartFile) uploadedFile, fileType, cdtApiUrl, session.unitcode)
            }*/
			
            params << [upload : "ok"]

        } catch(Exception e) {

            e.printStackTrace()
            params << [upload : "error"]
        }

        //NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
//        redirect(controller:'lcEtsOpening', action:'invokeUploadCommand',params:params)

        if (fileType.equalsIgnoreCase("transactions")) {
            chain(action: 'viewCdtUploadTransactions', params : params)
        } else if (fileType.equalsIgnoreCase("history")) {
            chain(action: 'viewCdtUploadPaymentHistory', params : params)
        } else {
            chain(action: 'viewCdtUploadClients', params : params)
        }
    }
	
	def resendEmail(){
		def iedieirdNumbers = JSON.parse(params.iedieirdNumbers)
		
		def paramMap = [params.iedieirdNumbers]
		
		def employeeDetails = coreAPIService.dummySendQuery([:], session.username, "security/user/");
		def iedieirdNumber = cdtService.getDetailsByIedierdNumber(paramMap, employeeDetails.details.employeeDetails.fullName, employeeDetails.details.employeeDetails.email)
		
		redirect(controller: "cdt", action: "viewCdtUploadTransactions")
		
	}
    def updateDataEntryStatus() {
        //println"updateDataEntryStatus"
        params.unitcode = session.unitcodek
        params.username = session.username

        Map<String, Object> map = new HashMap<>()

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        if(statusAction.equalsIgnoreCase("postApprove")){
           statusAction = "Approve"
        }
        params.statusAction = statusAction

        map = dataEntryService.updateDataEntry(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

	def test1(){
		
		
		def cdtList = coreAPIService.dummySendQuery("getBranches", "cdt/");
	}

	def computeCollectionDate() {

		def collectionDate = cdtService.computeCollectionDate(DateUtils.parse(params.remittanceDate), params.reportType)

		def test
		if(params.reportType.equalsIgnoreCase("IPF") || params.reportType.equalsIgnoreCase("EXPORT_CHARGES"))
			test = []
		else
			test = params.reportType
		def cdtList = coreAPIService.dummySendQuery([collectionPeriodFrom: DateUtils.shortDateFormat(collectionDate.from),
			collectionPeriodTo: DateUtils.shortDateFormat(collectionDate.to),
			paymentRequestType: test],
		"getAllSentToMobBoc", "cdt/")?.details

		def remittanceAmount = BigDecimal.ZERO


		cdtList.each {
			if (params.reportType.equalsIgnoreCase("IPF")) {
				if(it.IPFRemittedDate == null){
					remittanceAmount += it.ipf
				}
			} else if (params.reportType.equalsIgnoreCase("FINAL_CDT")) {
				if(!it.iedieirdNumber.contains(" E") && it.dutiesAndTaxesRemittedDate == null){
					remittanceAmount += (it.amount - it.ipf)
				}
			}else if (params.reportType.equalsIgnoreCase("EXPORT_CHARGES")) {
				if(it.iedieirdNumber.contains(" E") && it.dutiesAndTaxesRemittedDate == null){
					remittanceAmount += (it.amount - it.ipf)
				}
			}else if (params.reportType.equalsIgnoreCase("ADVANCE_CDT")) {
				if(!it.iedieirdNumber.contains(" E") && it.dutiesAndTaxesRemittedDate == null){
					remittanceAmount += (it.amount - it.ipf)
				}
			}
			else {

				if(it.IPFRemittedDate == null){

					if(it.dutiesAndTaxesRemittedDate == null)
						remittanceAmount += it.amount
					else
						remittanceAmount += it.ipf
				}
				else{
					if(it.dutiesAndTaxesRemittedDate == null)
						remittanceAmount += (it.amount.toBigDecimal() - it.ipf.toBigDecimal())
				}
			}
		}

		render([collectionPeriodFrom: DateUtils.shortDateFormat(collectionDate.from),
			collectionPeriodTo: DateUtils.shortDateFormat(collectionDate.to),
			remittanceAmount: NumberUtils.currencyFormat(remittanceAmount)] as JSON)
	}

    def computeTotalRemittance() {
	
		def test
		if(params.reportType.equalsIgnoreCase("IPF") || params.reportType.equalsIgnoreCase("EXPORT_CHARGES"))
			test = []
		else
			test = params.reportType


		def cdtList = coreAPIService.dummySendQuery([collectionPeriodFrom: DateUtils.shortDateFormat(new Date(params.collectionPeriodFrom)),
			collectionPeriodTo: DateUtils.shortDateFormat(new Date(params.collectionPeriodTo)),
			paymentRequestType: test],
		"getAllSentToMobBoc", "cdt/")?.details

		def remittanceAmount = BigDecimal.ZERO

		cdtList.each {

			if (params.reportType.equalsIgnoreCase("IPF")) {
				if(it.IPFRemittedDate == null){
					remittanceAmount += it.ipf
				}
			} else if (params.reportType.equalsIgnoreCase("FINAL_CDT")) {
				if(!it.iedieirdNumber.contains(" E") && it.dutiesAndTaxesRemittedDate == null){
					remittanceAmount += (it.amount - it.ipf)
				}
			}else if (params.reportType.equalsIgnoreCase("EXPORT_CHARGES")) {
				if(it.iedieirdNumber.contains(" E") && it.dutiesAndTaxesRemittedDate == null){
					remittanceAmount += (it.amount - it.ipf)
				}
			}else if (params.reportType.equalsIgnoreCase("ADVANCE_CDT")) {
				if(!it.iedieirdNumber.contains(" E") && it.dutiesAndTaxesRemittedDate == null){
					remittanceAmount += (it.amount - it.ipf)
				}
			}
			else {

				if(it.IPFRemittedDate == null){

					if(it.dutiesAndTaxesRemittedDate == null)
						remittanceAmount += it.amount
					else
						remittanceAmount += it.ipf

				}
				else{
					if(it.dutiesAndTaxesRemittedDate == null)
						remittanceAmount += (it.amount.toBigDecimal() - it.ipf.toBigDecimal())
				}
			}

		}



		render([remittanceAmount: NumberUtils.currencyFormat(remittanceAmount)] as JSON)
    }

    def sendToMobBoc() {
        println params

        //00-001-026924-1
        def parameterMap = [userId: session.username,
                accountNumber: params.accountNumber,
                amount: params.amount,
                supervisorId: params.supervisorId,
                processingUnitCode: session.unitcode,
                accountName: params.accountName,
                tradeServiceId: params.tradeServiceId,
                unitCode: session.unitcode,
				confDate: params.confDate
        ]
        println "parameterMap " + parameterMap
        def returnedValues = coreAPIService.dummySendCommand(parameterMap, "sendToMobBoc", "cdt")
        println "returnedValues  " + returnedValues

        session.model << [tradeServiceId: returnedValues?.details?.tradeServiceId]
        session.model << [referenceNumber: returnedValues?.details?.referenceNumber]

        render(returnedValues as JSON)
    }

    def errorCorrectMobBoc() {
        println params

        //00-001-026924-1
        def parameterMap = [userId: session.username,
                accountNumber: params.accountNumber,
                amount: params.amount,
                supervisorId: params.supervisorId,
                processingUnitCode: session.unitcode,
                accountName: params.accountName,
                tradeServiceId: params.tradeServiceId,
                unitCode: session.unitcode
        ]

        def returnedValues = coreAPIService.dummySendCommand(parameterMap, "errorCorrectMobBoc", "cdt")
        println "returnedValues  " + returnedValues

        session.model << [tradeServiceId: returnedValues?.details?.tradeServiceId]
        session.model << [referenceNumber: returnedValues?.details?.referenceNumber]

        render(returnedValues as JSON)
    }

    def debitFromRemittance() {
        println params

        def parameterMap = [userId: session.username,
                accountNumber: params.accountNumber,
                amount: params.amount,
                supervisorId: params.supervisorId,
                processingUnitCode: session.unitcode,
                accountName: params.accountName,
                tradeServiceId: params.tradeServiceId,
                collectionPeriodFrom: params.collectionPeriodFrom,
                collectionPeriodTo: params.collectionPeriodTo,
                paymentRequestType: params.paymentRequestType
        ]
        def returnedValues = coreAPIService.dummySendCommand(parameterMap, "debitFromRemittance", "cdt")


        session.model << [paymentStatus: 'PAID']

        render(returnedValues as JSON)
    }

    def errorCorrectFromRemittance() {
        println params

        def parameterMap = [userId: session.username,
                accountNumber: params.accountNumber,
                amount: params.amount,
                supervisorId: params.supervisorId,
                processingUnitCode: session.unitcode,
                accountName: params.accountName,
                tradeServiceId: params.tradeServiceId,
                collectionPeriodFrom: params.collectionPeriodFrom,
                collectionPeriodTo: params.collectionPeriodTo,
                paymentRequestType: params.paymentRequestType
        ]

        def returnedValues = coreAPIService.dummySendCommand(parameterMap, "errorCorrectRemittance", "cdt")
        println "returnedValues  " + returnedValues

        session.model << [paymentStatus: 'UNPAID']
        session.model << [referenceNumber: returnedValues?.details?.referenceNumber]

        render(returnedValues as JSON)
    }

    def transactRefund() {
//        println params
        def parameterMap = [userId: session.username,
                accountNumber: params.accountNumber,
                amount: params.amount,
                supervisorId: params.supervisorId,
                processingUnitCode: session.unitcode,
                type: params.type,
                tradeServiceId: params.tradeServiceId,
                currency: params.currency,
                accountName: params.accountName
        ]

        def returnedValues = coreAPIService.dummySendCommand(parameterMap, "payCasa", "cdt")

        if ("ok".equals(returnedValues.status)) {
            if ("DEBIT".equals(params.type)) {
                session.model << [debitTransactionStatus: "PAID"]
            } else {
                session.model << [creditTransactionStatus: "PAID"]
            }
        } else {
            if ("DEBIT".equals(params.type)) {
                session.model << [debitTransactionStatus: ""]
            } else {
                session.model << [creditTransactionStatus: ""]
            }
        }

        render(returnedValues as JSON)
    }

    def errorCorrectCasa() {
        def parameterMap = [type: params.type,
                userId: session.username,
                tradeServiceId: params.tradeServiceId,
                supervisorId: params.supervisorId,
                accountNumber: params.accountNumber,
                currency: params.currency,
                amount:  params.amount,
                accountName:  params.accountName
        ]

        def returnedValues = coreAPIService.dummySendCommand(parameterMap, "errorCorrectCasa", "cdt")
//        println returnedValues

        if ("ok".equals(returnedValues.status)) {
            if ("DEBIT".equals(params.type)) {
                session.model << [debitTransactionStatus: "ERROR_CORRECTED"]
            } else {
                session.model << [creditTransactionStatus: "ERROR_CORRECTED"]
            }
        } else {
            if ("DEBIT".equals(params.type)) {
                session.model << [debitTransactionStatus: "PAID"]
            } else {
                session.model << [creditTransactionStatus: "PAID"]
            }
        }

        render(returnedValues as JSON)
    }

    def tagAsPaid() {
        println params
        def returnedValues = coreAPIService.dummySendCommand([iedierdNumber: params.iedierdNumber, tradeServiceId: params.tradeServiceId], "tagAsPaid", "cdt")

        if ("ok".equals(returnedValues.status)) {
            session.model.status = "PAID"

            render([success: true, paymentReferenceNumber: returnedValues.paymentReferenceNumber] as JSON)
        } else {
            render([success: false, message: returnedValues.error] as JSON)
        }
    }

    def tagAsNew() {
        println params
        def returnedValues = coreAPIService.dummySendCommand([iedierdNumber: params.iedierdNumber, tradeServiceId: params.tradeServiceId], "tagAsNew", "cdt")

        if ("ok".equals(returnedValues.status)) {
            session.model.status = "NEW"

            render([success: true] as JSON)
        } else {
            render([success: false, message: returnedValues.error, paymentReferenceNumber: returnedValues.paymentReferenceNumber] as JSON)
        }
    }

    def getPaymentReferenceByMC() {
        println "params " + params
        def cdtPayment = coreAPIService.dummySendQuery([ied: params.ied], "details", "cdt/payment/")?.details
        println "cdtPayment " + cdtPayment.paymentRequest.paymentReferenceNumber
        session.model << [paymentReferenceNumber: cdtPayment.paymentRequest.paymentReferenceNumber]

        render([paymentReferenceNumber: cdtPayment.paymentRequest.paymentReferenceNumber] as JSON)
    }

    def clearPaymentReferenceByMC() {
        session.model << [paymentReferenceNumber: ""]

        render([paymentReferenceNumber: ""] as JSON)
    }

    private String tramsFileName(Date tramsDate) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMddyy");

        return "BOC_" + simpleDateFormat.format(tramsDate);
    }

    def generateTrams() {
        def allCDTsForTrams = coreAPIService.dummySendQuery([dateGenerated: params.onlineReportDate], "generateTramsReport", "cdt/payment/")?.details

        String fullFileName = tramsFileName(DateUtils.parse(params.onlineReportDate)) + ".txt";

        File file = new File(fullFileName);
        BufferedWriter output = new BufferedWriter(new FileWriter(file));

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMddyyyy");

        DecimalFormat decimalFormat = new DecimalFormat("0.00")

        def boc3Entry = null
        try {
            allCDTsForTrams.each {
                String tramsEntry
                println "begin..."
                if ("C".equals(it.collectionLine)) {
                    println "i am c " + it.datePaid
                    if ("BOC1".equals(it.collectionType) && it.ipf > 0) {
                        println "boc1"
                        def amount = (it.amount - it.ipf)
                        tramsEntry = it.collectionLine + "|" + it.collectionAgencyCode + "|" + it.collectionType + "|" + it.collectionChannel + "|" + it.transactionTypeCode + "|" + decimalFormat.format(amount) + "|" + simpleDateFormat.format(DateUtils.parse(it.datePaid)) + "\r\n"

                        println "setting boc3 entry"
                        boc3Entry = (it.collectionLine + "|" + it.collectionAgencyCode + "|BOC3|" + it.collectionChannel + "|" + it.transactionTypeCode + "|" + decimalFormat.format(it.ipf) + "|" + simpleDateFormat.format(DateUtils.parse(it.datePaid)) + "\r\n")
                    } else {
                        println "non-boc1"
                        tramsEntry = it.collectionLine + "|" + it.collectionAgencyCode + "|" + it.collectionType + "|" + it.collectionChannel + "|" + it.transactionTypeCode + "|" + decimalFormat.format(it.amount) + "|" + simpleDateFormat.format(DateUtils.parse(it.datePaid)) + "\r\n"
                    }
                } else if ("A".equals(it.collectionLine)) {
                    println "i am a " + it.pchcDateReceived

                    if (it.ipf > 0) {
                        def amount = (it.amount - it.ipf)

                        tramsEntry = it.collectionLine + "|"+simpleDateFormat.format(DateUtils.parse(it.datePaid))+"|"+simpleDateFormat.format(DateUtils.parse(it.pchcDateReceived))+"||ADC|"+decimalFormat.format(amount)+"|\r\n"

                        boc3Entry = it.collectionLine + "|"+simpleDateFormat.format(DateUtils.parse(it.datePaid))+"|"+simpleDateFormat.format(DateUtils.parse(it.pchcDateReceived))+"||ADC|"+decimalFormat.format(it.ipf)+"|\r\n"
                    } else {
                        tramsEntry = it.collectionLine + "|"+simpleDateFormat.format(DateUtils.parse(it.datePaid))+"|"+simpleDateFormat.format(DateUtils.parse(it.pchcDateReceived))+"||ADC|"+decimalFormat.format(it.amount)+"|\r\n"
                    }
                }
                println "after setting"

                output.write(tramsEntry)
                if (boc3Entry != null) {
                    println "writing boc3 entry"
                    output.write(boc3Entry)
                    boc3Entry = null
                }
            }

            output.close();

        } catch ( IOException e ) {
            e.printStackTrace();
        }

        response.contentType = "text/plain"
        response.setHeader("Content-disposition", "attachment;filename= " + fullFileName)
        response.characterEncoding = "UTF-8"
        response.outputStream << file.newInputStream()
    }
	
	
	def validateMultipleCdtTradeService() {
		def cdtPayment = coreAPIService.dummySendQuery([ied: params.iedieirdNumber, tsdInitiated: "true"], "details", "cdt/refund/")?.details
		def validationResult = [success: "true"]
		
		if (cdtPayment?.tradeService) {
			validationResult = [success: "false", message: "There is an on-going refund transaction for this CDT. Abort this transaction?"]
		}

		def jsonData = validationResult
		render(jsonData as JSON)
	}
}
