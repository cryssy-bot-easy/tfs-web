package com.ucpb.tfsweb.other.exports

import grails.converters.JSON
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils

import org.apache.commons.lang.WordUtils
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import java.text.SimpleDateFormat

class ExportAdvisingController {

    def etsService
    def dataEntryService

    def coreAPIService
    def routingInformationService
    def chargesService
    def parserService
    def documentUploadingService
    def tabUtilityService
	def exportAdvisingService
	
    private static DEFAULT_TABS = ["basicDetails", "attachedDocuments", "instructionsAndRouting"]

    // OPENING
    def viewOpeningFirst() {

        println "viewOpeningFirsst >>>>>>>>>>>>>>>>>>>"

        if (chainModel) {
            if (chainModel.parsedLc) {
                session.dataEntryModel = chainModel.parsedLc
            } else {
                session.dataEntryModel = chainModel
                session.dataEntryModel.lcIssueDateClass = "datepicker_field"
            }


            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "viewOpeningFirst >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }
			session.dataEntryModel << [formName: chainModel.formName]

        }

        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advising/opening/dataentry/first/basic_details_tab"]

        session.dataEntryModel << [title: "1st Advising Bank - Opening - Data Entry",
                tabs: DEFAULT_TABS,
                serviceType: "OPENING_ADVISING",
                documentClass: "EXPORT_ADVISING",
                documentType: "",
                documentSubType1: "FIRST_ADVISING",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                tsdInitiated: "true"
        ]

        session.dataEntryModel << [basicDetailsAction: "saveOpeningFirst"]
        session.dataEntryModel << [routeAction: "updateExportAdvisingStatus"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "DATA_ENTRY", "OPENING_ADVISING", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "OPENING_ADVISING", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "OPENING_ADVISING", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing
		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
        if (session['userrole']['id']?.equalsIgnoreCase("TSDO")) {
            session.dataEntryModel << [viewMode: "viewMode"]
			if(!session.dataEntryModel?.hasRoute){
				session.dataEntryModel << [hasRoute: "true"]
			}
        }
		
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def viewOpeningSecond() {

        println "viewOpeningSecond >>>>>>>>>>>>>>>>>>>"

        if (chainModel) {
            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "viewOpeningSecond >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advising/opening/dataentry/second/basic_details_tab"]

        session.dataEntryModel << [title: "2nd Advising Bank - Opening - Data Entry",
                tabs: DEFAULT_TABS,
                serviceType: "OPENING_ADVISING",
                documentClass: "EXPORT_ADVISING",
                documentType: "",
                documentSubType1: "SECOND_ADVISING",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                tsdInitiated: "true"
        ]

        session.dataEntryModel << [basicDetailsAction: "saveOpeningSecond"]
        session.dataEntryModel << [routeAction: "updateExportAdvisingStatus"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "DATA_ENTRY", "OPENING_ADVISING", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "OPENING_ADVISING", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "OPENING_ADVISING", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing
		
		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}

        if (session['userrole']['id']?.equalsIgnoreCase("TSDO")) {
            session.dataEntryModel << [viewMode: "viewMode"]
            if(!session.dataEntryModel?.hasRoute){
				session.dataEntryModel << [hasRoute: "true"]
			}
        }

        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveOpeningFirst() {
        println"saveOpeningFirst"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        params.lcAmount = params.lcAmount.replaceAll(",","")

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvising", action: "viewOpeningFirst", model: sessionModel)
    }

    def saveOpeningSecond() {
        println"saveOpeningSecond"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        params.lcAmount = params.lcAmount.replaceAll(",","")
        params.totalBankCharges = params.totalBankCharges.replaceAll(",","")

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvising", action: "viewOpeningSecond", model: sessionModel)
    }

    def viewPayment() {

        println "viewPayment >>>>>>>>>>>>>>>>>>>"

        if (chainModel) {
			println "xxxxxxxxxxxxx chainModel.tradeServiceId " +chainModel.tradeServiceId
			
			
            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                println "*** chainModel.tradeServiceId = ${chainModel.tradeServiceId}"

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "viewPayment >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
				
				println "xxxxxxxxxxx [charges:charges]" + charges
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        def PAYMENT_TABS = ["charges", "chargesPayment"]

        session.dataEntryModel << [title: "Payment Processing - " +
                WordUtils.capitalizeFully(session.dataEntryModel.serviceType.replace("_ADVISING","")) + " " +
//				WordUtils.capitalizeFully(session.dataEntryModel.documentSubType1.replace("_"," ")),
				exportAdvisingService.replaceDocumentSubType1ExportAdvising(session.dataEntryModel.documentSubType1),
                tabs: PAYMENT_TABS,
                serviceType: session.dataEntryModel.serviceType,
                documentClass: "EXPORT_ADVISING",
                documentType: "",
                documentSubType1: session.dataEntryModel.documentSubType1,
                documentSubType2: "",
                referenceType: "PAYMENT"
        ]

        session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        session.dataEntryModel << [chargesAction: "updateExportAdvising"]
        session.dataEntryModel << [chargesPaymentAction: "updateExportAdvising"]
        session.dataEntryModel << [routeAction: "updateExportAdvisingStatus"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVISING", null, session.dataEntryModel.documentSubType1, null, "DATA_ENTRY", session.dataEntryModel.serviceType, session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVISING", null, session.dataEntryModel.documentSubType1, null, session.dataEntryModel.serviceType, session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVISING", null, session.dataEntryModel.documentSubType1, null, session.dataEntryModel.serviceType, session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing

		if(chainModel){
			session.dataEntryModel << [viewMode:chainModel?.viewMode,onViewMode:chainModel?.onViewMode]
			session.viewMode=chainModel?.viewMode
			session.onViewMode=chainModel?.onViewMode
		}else if(params.viewMode){
			session.dataEntryModel << [viewMode:params.viewMode,onViewMode:params.onViewMode]
			session.viewMode=params.viewMode
			session.onViewMode=params.onViewMode
		}else{
			session.dataEntryModel << [viewMode:session.viewMode,onViewMode:session.onViewMode]
		}
//		println "SESSION VIEW MODE"+session.viewMode
        if (session['userrole']['id']?.equalsIgnoreCase("TSDO")) {
            session.dataEntryModel << [viewMode: "viewMode"]
            if(!session.dataEntryModel?.hasRoute){
				session.dataEntryModel << [hasRoute: "true"]
			}
        }
		
		if (session.dataEntryModel.tradeServiceId){
			
			List<Map<String, Object>> charges1 = chargesService.findAllChargesByTradeService(session.dataEntryModel.tradeServiceId)
			session.dataEntryModel << [charges:charges1]
			
		}
		
		println "xxxxxxxxxxxxx session.dataEntryModel" +session.dataEntryModel
		
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def updateExportAdvising() {
        //println"updateExportAdvising"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        // map = etsService.updateEts(params)
        // map = dataEntryService.updateDataEntry(params)
        map = chargesService.updateCharges(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "exportAdvising", action: "viewPayment", model: map)
    }

    def updateExportAdvisingStatus() {
        //println"updateExportAdvisingStatus"
        params.unitcode = session.unitcode
        params.username = session.username

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    // AMENDMENT
    def viewAmendmentFirst() {

        println "viewAmendmentFirst >>>>>>>>>>>>>>>>>>>"

        if (chainModel) {
            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "viewAmendmentFirst >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }

            if (chainModel.documentNumber && chainModel.referenceType.equals("DATAENTRY")) {
                def exportAdvising = coreAPIService.dummySendQuery([:], "details/"+chainModel.documentNumber, "product/exportAdvising/").details

                session.dataEntryModel << exportAdvising
                session.dataEntryModel.processDate = null
                session.dataEntryModel.lcCurrency = exportAdvising.lcCurrency.currencyCode
                session.dataEntryModel.lcNumber = exportAdvising.lcNumber.documentNumber
                session.dataEntryModel.documentNumber = exportAdvising.documentNumber.documentNumber

//                def cwtFlag = (exportAdvising.cwtFlag == true) ? 1 : 0

                session.dataEntryModel << [cwtFlag: exportAdvising.cwtFlag]
                session.dataEntryModel << [cwtFlagDisplay: exportAdvising.cwtFlag]

                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a")


                if (exportAdvising.lcIssueDate) {
                    Date lcIssueDate = simpleDateFormat.parse(exportAdvising.lcIssueDate)
                    session.dataEntryModel.lcIssueDate = DateUtils.shortDateFormat(lcIssueDate)
                }

                if (exportAdvising.lcExpiryDate) {
                    Date lcExpiryDate = simpleDateFormat.parse(exportAdvising.lcExpiryDate)
                    session.dataEntryModel.lcExpiryDate = DateUtils.shortDateFormat(lcExpiryDate)
                }

                if (exportAdvising.lastAmendmentDate) {
                    Date lastAmendmentDate = simpleDateFormat.parse(exportAdvising.lastAmendmentDate)
                    session.dataEntryModel.lastAmendmentDate = DateUtils.shortDateFormat(lastAmendmentDate)
                }

                session.dataEntryModel.usanceTerm = exportAdvising.usanceTerm ?: ''

                if (exportAdvising.numberOfAmendments != null) {
                    session.dataEntryModel.numberOfAmendments = NumberUtils.integerFormat(new Double(exportAdvising.numberOfAmendments))
                } else {
                    session.dataEntryModel.numberOfAmendments = null
                }

                session.dataEntryModel.lcAmount = NumberUtils.currencyFormat(new Double(exportAdvising.lcAmount))

                if (exportAdvising.totalBankCharges != null) {
                    session.dataEntryModel.totalBankCharges = NumberUtils.currencyFormat(new Double(exportAdvising.totalBankCharges))
                } else {
                    session.dataEntryModel.totalBankCharges = null
                }
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advising/amendment/dataentry/first/basic_details_tab"]


        session.dataEntryModel << [title: "1st Advising Bank - Amendment - Data Entry",
                tabs: DEFAULT_TABS,
                serviceType: "AMENDMENT_ADVISING",
                documentClass: "EXPORT_ADVISING",
                documentType: "",
                documentSubType1: "FIRST_ADVISING",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                tsdInitiated: "true"
        ]

        session.dataEntryModel << [basicDetailsAction: "saveAmendmentFirst"]
        session.dataEntryModel << [routeAction: "updateExportAdvisingStatus"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "DATA_ENTRY", "AMENDMENT_ADVISING", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "AMENDMENT_ADVISING", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "AMENDMENT_ADVISING", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing
		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
        if (session['userrole']['id']?.equalsIgnoreCase("TSDO")) {
            session.dataEntryModel << [viewMode: "viewMode"]
            if(!session.dataEntryModel?.hasRoute){
				session.dataEntryModel << [hasRoute: "true"]
			}
        }
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def viewAmendmentSecond() {

        println "viewAmendmentSecond >>>>>>>>>>>>>>>>>>>"

        if (chainModel) {
            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "viewAmendmentSecond >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }

            if (chainModel.documentNumber && chainModel.referenceType.equals("DATAENTRY")) {
                def exportAdvising = coreAPIService.dummySendQuery([:], "details/"+chainModel.documentNumber, "product/exportAdvising/").details

                session.dataEntryModel << exportAdvising
                session.dataEntryModel.processDate = null
                session.dataEntryModel.lcCurrency = exportAdvising.lcCurrency.currencyCode
                session.dataEntryModel.lcNumber = exportAdvising.lcNumber.documentNumber
                session.dataEntryModel.documentNumber = exportAdvising.documentNumber.documentNumber

//                def cwtFlag = (exportAdvising.cwtFlag == true) ? 1 : 0

                session.dataEntryModel << [cwtFlag: exportAdvising.cwtFlag]
                session.dataEntryModel << [cwtFlagDisplay: exportAdvising.cwtFlag]


                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a")

                if (exportAdvising.lcIssueDate) {
                    Date lcIssueDate = simpleDateFormat.parse(exportAdvising.lcIssueDate)
                    session.dataEntryModel.lcIssueDate = DateUtils.shortDateFormat(lcIssueDate)
                }

                if (exportAdvising.lcExpiryDate) {
                    Date lcExpiryDate = simpleDateFormat.parse(exportAdvising.lcExpiryDate)
                    session.dataEntryModel.lcExpiryDate = DateUtils.shortDateFormat(lcExpiryDate)
                }

                session.dataEntryModel.usanceTerm = exportAdvising.usanceTerm ?: ''

                if (exportAdvising.numberOfAmendments != null) {
                    session.dataEntryModel.numberOfAmendments = NumberUtils.integerFormat(new Double(exportAdvising.numberOfAmendments))
                } else {
                    session.dataEntryModel.numberOfAmendments = null
                }

                session.dataEntryModel.lcAmount = NumberUtils.currencyFormat(new Double(exportAdvising.lcAmount))

                if (exportAdvising.totalBankCharges != null) {
                    session.dataEntryModel.totalBankCharges = NumberUtils.currencyFormat(new Double(exportAdvising.totalBankCharges))
                } else {
                    session.dataEntryModel.totalBankCharges = null
                }
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advising/amendment/dataentry/second/basic_details_tab"]


        session.dataEntryModel << [title: "2nd Advising Bank - Amendment - Data Entry",
                tabs: DEFAULT_TABS,
                serviceType: "AMENDMENT_ADVISING",
                documentClass: "EXPORT_ADVISING",
                documentType: "",
                documentSubType1: "SECOND_ADVISING",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                tsdInitiated: "true"
        ]

        session.dataEntryModel << [basicDetailsAction: "saveAmendmentSecond"]
        session.dataEntryModel << [routeAction: "updateExportAdvisingStatus"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVISING", null, "SECOND_ADVISING", null, "DATA_ENTRY", "AMENDMENT_ADVISING", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVISING", null, "SECOND_ADVISING", null, "AMENDMENT_ADVISING", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVISING", null, "SECOND_ADVISING", null, "AMENDMENT_ADVISING", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing

		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
        if (session['userrole']['id']?.equalsIgnoreCase("TSDO")) {
            session.dataEntryModel << [viewMode: "viewMode"]
            if(!session.dataEntryModel?.hasRoute){
				session.dataEntryModel << [hasRoute: "true"]
			}
        }
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveAmendmentFirst() {
        //println"saveAmendmentFirst"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        params.lcAmount = params.lcAmount.replaceAll(",","")

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvising", action: "viewAmendmentFirst", model: sessionModel)
    }

    def saveAmendmentSecond() {
        //println"saveAmendmentSecond"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        params.lcAmount = params.lcAmount.replaceAll(",","")
        params.totalBankCharges = params.totalBankCharges.replaceAll(",","")

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvising", action: "viewAmendmentSecond", model: sessionModel)
    }

    // cancellation
    def viewCancellationFirst() {

        println "viewCancellationFirst >>>>>>>>>>>>>>>>>>>"

        if (chainModel) {
            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "viewCancellationFirst >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }

            if (chainModel.documentNumber && chainModel.referenceType.equals("DATAENTRY")) {
                def exportAdvising = coreAPIService.dummySendQuery([:], "details/"+chainModel.documentNumber, "product/exportAdvising/").details

                session.dataEntryModel << exportAdvising
                session.dataEntryModel.processDate = null
                session.dataEntryModel.lcCurrency = exportAdvising.lcCurrency.currencyCode
                session.dataEntryModel.lcNumber = exportAdvising.lcNumber.documentNumber
                session.dataEntryModel.documentNumber = exportAdvising.documentNumber.documentNumber

                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a")

                if (exportAdvising.lcIssueDate) {
                    Date lcIssueDate = simpleDateFormat.parse(exportAdvising.lcIssueDate)
                    session.dataEntryModel.lcIssueDate = DateUtils.shortDateFormat(lcIssueDate)
                }

                if (exportAdvising.lcExpiryDate) {
                    Date lcExpiryDate = simpleDateFormat.parse(exportAdvising.lcExpiryDate)
                    session.dataEntryModel.lcExpiryDate = DateUtils.shortDateFormat(lcExpiryDate)
                }

                session.dataEntryModel.usanceTerm = exportAdvising.usanceTerm ?: ''

                session.dataEntryModel.lcAmount = NumberUtils.currencyFormat(new Double(exportAdvising.lcAmount))

                if (exportAdvising.totalBankCharges != null) {
                    session.dataEntryModel.totalBankCharges = NumberUtils.currencyFormat(new Double(exportAdvising.totalBankCharges))
                } else {
                    session.dataEntryModel.totalBankCharges = null
                }
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advising/cancellation/dataentry/first/basic_details_tab"]


        session.dataEntryModel << [title: "1st Advising Bank - Cancellation - Data Entry",
                tabs: DEFAULT_TABS,
                serviceType: "CANCELLATION_ADVISING",
                documentClass: "EXPORT_ADVISING",
                documentType: "",
                documentSubType1: "FIRST_ADVISING",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                tsdInitiated: "true"
        ]

        session.dataEntryModel << [basicDetailsAction: "saveCancellationFirst"]
        session.dataEntryModel << [routeAction: "updateExportAdvisingStatus"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "DATA_ENTRY", "CANCELLATION_ADVISING", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "CANCELLATION_ADVISING", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVISING", null, "FIRST_ADVISING", null, "CANCELLATION_ADVISING", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing

		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
        if (session['userrole']['id']?.equalsIgnoreCase("TSDO")) {
            session.dataEntryModel << [viewMode: "viewMode"]
            if(!session.dataEntryModel?.hasRoute){
				session.dataEntryModel << [hasRoute: "true"]
			}
        }
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def viewCancellationSecond() {

        println "viewCancellationSecond >>>>>>>>>>>>>>>>>>>"

        if (chainModel) {
            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "viewCancellationSecond >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }

            if (chainModel.documentNumber && chainModel.referenceType.equals("DATAENTRY")) {
                def exportAdvising = coreAPIService.dummySendQuery([:], "details/"+chainModel.documentNumber, "product/exportAdvising/").details

                session.dataEntryModel << exportAdvising
                session.dataEntryModel.processDate = null
                session.dataEntryModel.lcCurrency = exportAdvising.lcCurrency.currencyCode
                session.dataEntryModel.lcNumber = exportAdvising.lcNumber.documentNumber
                session.dataEntryModel.documentNumber = exportAdvising.documentNumber.documentNumber

                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a")
                if (exportAdvising.lcIssueDate) {
                    Date lcIssueDate = simpleDateFormat.parse(exportAdvising.lcIssueDate)
                    session.dataEntryModel.lcIssueDate = DateUtils.shortDateFormat(lcIssueDate)
                }

                if (exportAdvising.lcExpiryDate) {
                    Date lcExpiryDate = simpleDateFormat.parse(exportAdvising.lcExpiryDate)
                    session.dataEntryModel.lcExpiryDate = DateUtils.shortDateFormat(lcExpiryDate)
                }

                session.dataEntryModel.usanceTerm = exportAdvising.usanceTerm ?: ''

                session.dataEntryModel.lcAmount = NumberUtils.currencyFormat(new Double(exportAdvising.lcAmount))

                if (exportAdvising.totalBankCharges != null) {
                    session.dataEntryModel.totalBankCharges = NumberUtils.currencyFormat(new Double(exportAdvising.totalBankCharges))
                } else {
                    session.dataEntryModel.totalBankCharges = null
                }
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advising/cancellation/dataentry/second/basic_details_tab"]


        session.dataEntryModel << [title: "2nd Advising Bank - Cancellation - Data Entry",
                tabs: DEFAULT_TABS,
                serviceType: "CANCELLATION_ADVISING",
                documentClass: "EXPORT_ADVISING",
                documentType: "",
                documentSubType1: "SECOND_ADVISING",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                tsdInitiated: "true"
        ]

        session.dataEntryModel << [basicDetailsAction: "saveCancellationSecond"]
        session.dataEntryModel << [routeAction: "updateExportAdvisingStatus"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVISING", null, "SECOND_ADVISING", null, "DATA_ENTRY", "CANCELLATION_ADVISING", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVISING", null, "SECOND_ADVISING", null, "CANCELLATION_ADVISING", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVISING", null, "SECOND_ADVISING", null, "CANCELLATION_ADVISING", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing

		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
        if (session['userrole']['id']?.equalsIgnoreCase("TSDO")) {
            session.dataEntryModel << [viewMode: "viewMode"]
            if(!session.dataEntryModel?.hasRoute){
				session.dataEntryModel << [hasRoute: "true"]
			}
        }
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveCancellationFirst() {
        //println"saveCancellationFirst"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        params.lcAmount = params.lcAmount.replaceAll(",","")

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvising", action: "viewCancellationFirst", model: sessionModel)
    }

    def saveCancellationSecond() {
        //println"saveCancellationSecond"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        params.lcAmount = params.lcAmount.replaceAll(",","")

        params.totalBankCharges = params.totalBankCharges.replaceAll(",","")

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvising", action: "viewCancellationSecond", model: sessionModel)
    }

    //Upload Documents Related
    def uploadDocument() {

        try{
            //handle uploaded file
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
        redirect(controller:'exportAdvising', action:'invokeUploadCommand',params:params)
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
        String action

        if(session.dataEntryModel.documentSubType1.equals("FIRST_ADVISING")){
            //action = "viewOpeningFirst"
            if (session.dataEntryModel.title.contains("Cancellation")) {
                action = "viewCancellationFirst"
            } else if (session.dataEntryModel.title.contains("Amendment")) {
                action = "viewAmendmentFirst"
            } else {
                action = "viewOpeningFirst"
            }
        } else {
            //action = "viewOpeningSecond"
            if (session.dataEntryModel.title.contains("Cancellation")) {
                action = "viewCancellationSecond"
            } else if (session.dataEntryModel.title.contains("Amendment")) {
                action = "viewAmendmentSecond"
            } else {
                action = "viewOpeningSecond"
            }
        }


        chain(action:action, model: session.dataEntryModel)
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
	
	def viewAttachments() {
		
				def tradeServiceIdHolder =  params.tradeServiceIdHolder
				////println"tradeServiceIdHolder:" + tradeServiceIdHolder
		
				def maxRows = params.int('rows') ?: 10
				def currentPage = params.int('page') ?: 1
				def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
				def mapList = dataEntryService.getAttachmentList( maxRows, rowOffset, currentPage, tradeServiceIdHolder)
		
				def totalRows = mapList.totalRows
				def numberOfPages = Math.ceil(totalRows / maxRows)
				def results
				if(params.referenceType == "ETS"){
					if (session.userrole.id.contains("TSD")){
						results = etsService.getGridFormattedAttachmentsReadonly(mapList.display, tradeServiceIdHolder)
					} else {
						results = etsService.getGridFormattedAttachments(mapList.display, tradeServiceIdHolder)
					}
				} else {
					results = dataEntryService.getGridFormattedAttachments(mapList.display, tradeServiceIdHolder)
				}
				def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
				render jsonData as JSON		
	}

}
