package com.ucpb.tfsweb.main

import grails.converters.JSON
import net.ipc.utils.NumberUtils
import java.util.regex.Matcher;
import java.util.regex.Pattern;


//  PROLOGUE:
//* 	(revision)
//   SCR/ER Number:20160414-052
//   SCR/ER Description: Transaction was approved in TSD, but is found on TSD Makers' screen the next day, with Pending status.
//   [Revised by:] Allan Comboy Jr.
//   [Date Deployed:] 04/14/2016
//   Program [Revision] Details: Add pop-up alert to notify user if transaction failed to route(TSD only)
//   PROJECT: WEB
//   MEMBER TYPE  : GROOVY
//   Project Name: UnactedTransactionsController.groovy


/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: UnactedTransactionsController
 */


class UnactedTransactionsController {

    def unactedService
    def etsService
    def routingInformationService
	def headerService
	def chargesService
	def chargesPaymentService
	
	public static def confirmationMsg = ""
	public static boolean confirmationVer = false
	public static def headTitle = ""
	public static def message1 = ""
	public static def message2 = ""

	//this function will catch the error returned from core.	
	public static def confirmationRoute(String confirmationMs){

		confirmationMsg = confirmationMs
		confirmationVer = true;
		int msgLngth = confirmationMs.length();
		println "## Message confirmation " +  confirmationMs
			
		if(confirmationMs.startsWith('~~~')){ // Unable to import EmailSendingException
			
			headTitle = "ERROR: Unable to send email notification"
			def values = confirmationMs.split('~~~')
			confirmationMsg = "EXCEPTION: " + values[1];	
			message1 = "1. Please manually notify the recipient instead."
			message2 = "2. Please call " + values[2] +" about the error."
		}
	}//end of function
	
    def viewUnacted() {
		
        //println "${grailsApplication.config.tfs.rates}"
        String title = session['group'].toString().equalsIgnoreCase("branch") ? "Branch Unacted Transactions" : "Main Unacted Transactions"

		println confirmationMsg + "##translated error:"  + confirmationVer.toString()	
		println "user role: " + session['userrole']['id'].toString();
			
		def unactedModel

        if (!session['userrole']) {
            flash.message = "You are not authenticated or your session has expired please login again."
            redirect(controller: 'login', action: 'logout')
        } else if (session['userrole']['id']?.startsWith('BR')) {
            session['group'] = 'BRANCH'
        } else if (session['userrole']['id']?.startsWith('TSD')) {
            session['group'] = 'TSD'
        } else if (session['userrole']['id']?.startsWith('TEL')) {
            session['group'] = 'TELECOMS'
        } else {
            session['group'] = 'NONE'
            redirect(controller: 'login', action: 'logout')
        }
	
		if(confirmationVer == true){
		unactedModel = [username: params.username, title: title,email: confirmationVer,message: confirmationMsg,headtitle:headTitle,message1:message1,message2:message2]
		} else {
		unactedModel = [username: params.username, title: title]
		}
		confirmationVer = false;
        render(view: '/main/unacted_transaction', model: unactedModel)
    }

    def viewUnactedTsd() {
        session['group'] = 'TSD'
//		println "VIEWUNACTEDTSD********"+params.tsdLabelText+ " " +params.tsdTableId
        params << [username: params.username, title: "Main Unacted Transactions"]
        params << [setTsdGrid: 'true', tsdGridWrapperClass: 'grid_wrapper_unacted fix']
//		params << [message: "some message"]
//		println "SHEET456"
        session['tsdUnactedLabelText'] = params.tsdLabelText
        session['tsdUnactedTableId'] = params.tsdTableId

        render(view: '/main/unacted_transaction', model: params)
    }

    def getTotalUnactedEntries() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
        def unactedEntries = [:]

        unactedEntries << [totalLc: unactedService.findAllUnactedLcMainByUser(session.username, maxRows, rowOffset, currentPage, session.userrole.id)?.totalRows]
        unactedEntries << [totalNonLc: unactedService.findAllUnactedNonLcMainByUser(session.username, maxRows, rowOffset, currentPage, session.userrole.id)?.totalRows]
        unactedEntries << [totalAuxiliary: unactedService.findAllUnactedAuxillaryMainByUser(session.username, session.userrole.id, maxRows, rowOffset, currentPage)?.totalRows]
        unactedEntries << [totalCashAdvance: unactedService.findAllUnactedCashAdvanceMain(session.username, session.userrole.id, maxRows, rowOffset, currentPage)?.totalRows]
        unactedEntries << [totalExportAdvising: unactedService.findAllUnactedExportAdvising(session.username, session.userrole.id, maxRows, rowOffset, currentPage)?.totalRows]
        unactedEntries << [totalExportBills: unactedService.findAllUnactedExportBillsTsd(session.username, session.userrole.id, maxRows, rowOffset, currentPage)?.totalRows]

//        if ("TSDM" == session['userrole']['id']) {
//            unactedEntries << [totalMt: unactedService.findAllRoutedIncomingMt(maxRows, rowOffset, currentPage)?.totalRows]
//        } else {
//            unactedEntries << [totalMt: unactedService.findAllIncomingMtTsd(maxRows, rowOffset, currentPage)?.totalRows]
//        }

        render unactedEntries as JSON
    }

    def viewUnactedLcBranch() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        String statusToDisplay = ""
        def mapList = unactedService.findAllUnactedLcBranchByUser(session.username, maxRows, rowOffset, currentPage, session.userrole.id)

        def totalRows = mapList.totalRows ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructLcBranchGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedLcMain() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllUnactedLcMainByUser(session.username, maxRows, rowOffset, currentPage, session.userrole.id)

        def totalRows = mapList.totalRows
		
        def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = unactedService.constructLcMainGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
       
		 render jsonData as JSON
    }

    def viewUnactedNonLcBranch() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows


        String statusToDisplay = ""
        def mapList = unactedService.findAllUnactedNonLcBranchByUser(session.username, maxRows, rowOffset, currentPage, session.userrole.id)

        def totalRows = mapList.totalRows ?: 0

        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructNonLcBranchGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedNonLcMain() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllUnactedNonLcMainByUser(session.username, maxRows, rowOffset, currentPage, session.userrole.id)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructNonLcMainGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedAuxilllaryBranch() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllUnactedAuxillaryBranchByUser(session.username, maxRows, rowOffset, currentPage, session.userrole.id)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructAuxillaryBranchGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedAuxilllaryMain() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllUnactedAuxillaryMainByUser(session.username, session.userrole.id, maxRows, rowOffset, currentPage)

 
        def results = unactedService.constructAuxillaryMainGrid(mapList.display)
		
		 def totalRows = results.size ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

	
	def viewUnactedAuxilllaryMaincdt() {
		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = unactedService.findAllUnactedAuxillaryMainByUser(session.username, session.userrole.id, maxRows, rowOffset, currentPage)

 
		def results = unactedService.constructAuxillaryMainGridcdt(mapList.display)
		
		 def totalRows = results.size ?: 0
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		render jsonData as JSON
	}
	
	
    def viewUnactedIncomingMtTsd() {
        println "viewUnactedIncomingMtTsd"
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllIncomingMtTsd(maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructIncomingMtTsd(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedRoutedIncomingMt() {
        println 'viewUnactedRoutedIncomingMt'
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllRoutedIncomingMt(maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructRoutedIncomingMt(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
	
	def viewApprovedEtsChargesAndPayments() {
		
		String headerTitle = headerService.getEtsTitle(params.documentType, params.documentClass, params.documentSubType1, params.serviceType, params.documentSubType2)
		
		Map<String, Object> etsMap = etsService.getEts(params.etsNumber)
		List<Map<String, Object>> approvedEtsProductPayment = chargesPaymentService.findAllApprovedEtsProductPayment(params.tradeServiceId)
		List<Map<String, Object>> approvedEtsProceedsPayment = chargesPaymentService.findAllApprovedEtsProceedsPayment(params.tradeServiceId)
		List<Map<String, Object>> approvedEtsCharges = chargesService.findAllApprovedEtsCharges(params.tradeServiceId)
		List<Map<String, Object>> approvedEtsServicePayment = chargesPaymentService.findAllApprovedEtsServicePayment(params.tradeServiceId)
		
		session.approvedEtsModel = [title: headerTitle, 
			windowed: params.windowed,
			approvedEtsProductPayment: approvedEtsProductPayment, 
			approvedEtsProceedsPayment: approvedEtsProceedsPayment, 
			approvedEtsCharges: approvedEtsCharges, 
			approvedEtsServicePayment: approvedEtsServicePayment]
		
		etsMap.each {
			session.approvedEtsModel << it
		}
		
		render(view: "/layouts/view_approved_ets_charges_and_payments", model: session.approvedEtsModel)
	}

    def viewUnactedOutgoingMt() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllOutgoingMt(maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructOutgoingMt(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // view ets from grid
    def viewEts() {
        Map<String, Object> forwardMap = unactedService.evaluateEtsParams(params)
	
        if (params.reversalEtsNumber != null && params.reversalEtsNumber) {
            forwardMap.reversal = true;
            // this is for reversal
            params.reverseEts = "true"
        }

        if (!(params.documentClass in ["EXPORT_ADVANCE", "IMPORT_ADVANCE", "BP", "BC"]) &&
                !(params.documentClass in ["DA","DP","OA","DR","LC"] && params.serviceType.equals("REFUND")) &&
                !(params.documentClass.equals("CORRES_CHARGE") && params.serviceType.equals("SETTLEMENT")) &&
                !(params.documentClass in ["IMPORT_CHARGES", "EXPORT_CHARGES"] && params.serviceType in ["PAYMENT", "REFUND"])) {
            forward(forwardMap)
        } else {
            def model = params
            model << [serviceInstructionId: params.etsNumber]
            if (params.serviceType?.equalsIgnoreCase("PAYMENT")) {
                if (params.documentClass.equals("IMPORT_ADVANCE")) {
                    chain(controller: "importAdvance", action: "viewPaymentEts", model: model)
                } else if (params.documentClass.equals("EXPORT_ADVANCE")) {
                    chain(controller: "exportAdvance", action: "viewPaymentEts", model: model)
                } else if (params.documentClass.equals("IMPORT_CHARGES")) {
                    chain(controller: "importCharges", action: "viewPaymentChargesEts", model: model)
                } else if (params.documentClass.equals("EXPORT_CHARGES")) {
                    chain(controller: "exportCharges", action: "viewPaymentChargesEts", model: model)
                }

            } else if (params.serviceType?.equalsIgnoreCase("REFUND")) {
                if (params.documentClass.equals("IMPORT_ADVANCE")) {
                    chain(controller: "importAdvance", action: "viewRefundEts", model: model)
                } else if (params.documentClass.equals("EXPORT_ADVANCE")) {
                    chain(controller: "exportAdvance", action: "viewRefundEts", model: model)
                } else if (params.documentClass.equals("EXPORT_CHARGES")) {
                    chain(controller: "exportsRefund", action: "viewRefundEts", model: model)
                } else {
                    chain(controller: "refund", action: "viewRefundEts", model: model)
                }
            } else if (params.serviceType?.equalsIgnoreCase("NEGOTIATION")) {
                if (params.documentClass?.equals("BP")) {
                    if ("FOREIGN".equals(params.documentType)) {
                        chain(controller: "exportBillsPurchase", action: "viewNegotiationEts", model: model)
                    } else if ("DOMESTIC".equals(params.documentType)) {
                        chain(controller: "domesticBillsPurchase", action: "viewNegotiationEts", model: model)
                    }
                }
            } else if (params.serviceType.equals("SETTLEMENT")) {
                if (params.documentClass.equals("BC")) {
                    if ("FOREIGN".equals(params.documentType)) {
                        chain(controller: "exportBillsCollection", action: "viewSettlementEts", model: model)
                    } else if ("DOMESTIC".equals(params.documentType)) {
                        chain(controller: "domesticBillsCollection", action: "viewSettlementEts", model: model)
                    }
                } // corres charge
                else if (params.documentClass.equals("CORRES_CHARGE")) {
                    chain(controller: "corresCharge", action: "viewCorresChargeEts", model: model)
                }
            }
        }
    }

    // view data entry from grid
    def viewDataEntry() {
		
        Map<String, Object> forwardMap = unactedService.evaluateDataEntryParams(params)
		
		if(params.cdtgrid == true){
			params.documentClass = "CDT"
			params.serviceType = "REMITTANCE"
	
		}
		
        if (!(params.documentClass in ["IMPORT_ADVANCE", "CDT", "EXPORT_ADVANCE", "EXPORT_ADVISING", "BC", "BP", "REBATE", "CORRES_CHARGE"])) {
            if (params.serviceType.equals("REFUND") && params.documentClass != "AP") {
                def model = params
                if (params.documentClass in ["DA","DP","OA","DR","LC"]) {
                    chain(controller: "refund", action: "viewRefundDataEntry", model: model)
                } else if (params.documentClass.equals("EXPORT_CHARGES")) {
                    chain(controller: "exportsRefund", action: "viewRefundDataEntry", model: model)
                }
            } else if (params.serviceType.equals("PAYMENT_OTHER")) {
                def model = params
                if (params.documentClass.equals("IMPORT_CHARGES")) {
                    chain(controller: "otherCharges", action: "viewOtherChargesDataEntry", model: model)
                } else if (params.documentClass.equals("EXPORT_CHARGES")) {
                    chain(controller: "otherCharges", action: "viewOtherChargesDataEntry", model: model)
                }
            } else if (params.serviceType.equals("PAYMENT")) {
                def model = params
                if (params.documentClass.equals("IMPORT_CHARGES")) {
                    chain(controller: "importCharges", action: "viewPaymentChargesDataEntry", model: model)
                } else if (params.documentClass.equals("EXPORT_CHARGES")) {
                    chain(controller: "exportCharges", action: "viewPaymentChargesDataEntry", model: model)
                }
            } else if ("MT".equals(params.documentClass) && "CREATE".equals(params.serviceType)) {
                chain(controller: "outgoingMt", action: "viewMt", params: params)
            } else {
                forward(forwardMap)
            }
        } else {
            println "haloooo "
            if (params.documentClass == "IMPORT_ADVANCE") {
                def model = params
                model << [tradeServiceId: params.tradeServiceId]
                if (params.serviceType?.equalsIgnoreCase("PAYMENT")) {
                    chain(controller: "importAdvance", action: "viewPaymentDataEntry", model: model)
                } else if (params.serviceType?.equalsIgnoreCase("REFUND")) {
                    chain(controller: "importAdvance", action: "viewRefundDataEntry", model: model)
                }

            } else if (params.documentClass == "EXPORT_ADVANCE") {
                def model = params
                model << [tradeServiceId: params.tradeServiceId]
                if (params.serviceType?.equalsIgnoreCase("PAYMENT")) {
                    chain(controller: "exportAdvance", action: "viewPaymentDataEntry", model: model)
                } else if (params.serviceType?.equalsIgnoreCase("REFUND")) {
                    chain(controller: "exportAdvance", action: "viewRefundDataEntry", model: model)
                }
            } else if (params.documentClass == "CDT") {
                def model = params
                model << [tradeServiceId: params.tradeServiceId]
                if (params.serviceType.equals("REMITTANCE")) {
                    chain(controller: "cdt", action: "viewRemittance", model: model)
                } else if (params.serviceType.equals("REFUND")) {
                    def refundModel = [tradeServiceId: params.tradeServiceId]
                    chain(controller: "cdt", action: "viewCdtRefund", model: refundModel)
                }

            } else if (params.documentClass.equals("EXPORT_ADVISING")) {
                def model = params
                model << [tradeServiceId: params.tradeServiceId]

                if (params.serviceType.equals("OPENING") || params.serviceType.equals("OPENING_ADVISING")) {
                    if (params.documentSubType1 != null && params.documentSubType1.equals("FIRST_ADVISING")) {
                        chain(controller: "exportAdvising", action: "viewOpeningFirst", model: model)
                    } else if (params.documentSubType1 != null && params.documentSubType1.equals("SECOND_ADVISING")) {
                        chain(controller: "exportAdvising", action: "viewOpeningSecond", model: model)
                    }
                } else if (params.serviceType.equals("AMENDMENT") || params.serviceType.equals("AMENDMENT_ADVISING")) {
                    if (params.documentSubType1 != null && params.documentSubType1.equals("FIRST_ADVISING")) {
                        chain(controller: "exportAdvising", action: "viewAmendmentFirst", model: model)
                    } else if (params.documentSubType1 != null && params.documentSubType1.equals("SECOND_ADVISING")) {
                        chain(controller: "exportAdvising", action: "viewAmendmentSecond", model: model)
                    }
                } else if (params.serviceType.equals("CANCELLATION") || params.serviceType.equals("CANCELLATION_ADVISING")) {
                    if (params.documentSubType1 != null && params.documentSubType1.equals("FIRST_ADVISING")) {
                        chain(controller: "exportAdvising", action: "viewCancellationFirst", model: model)
                    } else if (params.documentSubType1 != null && params.documentSubType1.equals("SECOND_ADVISING")) {
                        chain(controller: "exportAdvising", action: "viewCancellationSecond", model: model)
                    }
                }
            } else if (params.documentClass in ["BP", "BC"]) {
				def model = params
				model << [tradeServiceId: params.tradeServiceId]
                //switch (params.documentClass) {
                if ("BP".equals(params.documentClass)) {
                        if (params.serviceType.equals("NEGOTIATION")) {
                            if ("FOREIGN".equals(params.documentType)) {
                                chain(controller: "exportBillsPurchase", action: "viewNegotiationDataEntry", model: model)
                            } else if ("DOMESTIC".equals(params.documentType)) {
                                chain(controller: "domesticBillsPurchase", action: "viewNegotiationDataEntry", model: model)
                            }
                        } else if ("SETTLEMENT".equals(params.serviceType)) {
                            if ("FOREIGN".equals(params.documentType)) {
                                chain(controller: "exportBillsPurchase", action: "viewSettlementDataEntry", model: model)
                            } else if ("DOMESTIC".equals(params.documentType)) {
                                chain(controller: "domesticBillsPurchase", action: "viewSettlementDataEntry", model: model)
                            }
                        }
                } else if ("BC".equals(params.documentClass)) {
                        if (params.serviceType.equals("NEGOTIATION")) {
                            if ("FOREIGN".equals(params.documentType)) {
                                chain(controller: "exportBillsCollection", action: "viewNegotiationDataEntry", model: model)
                            } else if ("DOMESTIC".equals(params.documentType)) {
                                chain(controller: "domesticBillsCollection", action: "viewNegotiationDataEntry", model: model)
                            }
                        } else if ("SETTLEMENT".equals(params.serviceType)) {
                            if ("FOREIGN".equals(params.documentType)) {
                                chain(controller: "exportBillsCollection", action: "viewSettlementDataEntry", model: model)
                            } else if ("DOMESTIC".equals(params.documentType)) {
                                chain(controller: "domesticBillsCollection", action: "viewSettlementDataEntry", model: model)
                            }
                        } else if ("CANCELLATION".equals(params.serviceType)) {
                            chain(controller: "exportBillsCollection", action: "viewCancellationDataEntry", model: model)
                        }
                }
            } else if ("REBATE".equals(params.documentClass)) {
                def rebateModel = [tradeServiceId: params.tradeServiceId]

                chain(controller: "rebate", action: "viewRebate", model: rebateModel)
            } else if ("CORRES_CHARGE".equals(params.documentClass)) {
                def corresChargeModel = [tradeServiceId: params.tradeServiceId, viewMode: params.viewMode, hasRoute: params.hasRoute]
                chain(controller: "corresCharge", action: "viewCorresChargeDataEntry", model: corresChargeModel)
            }
        }
    }

    // view payment processing from grid
    def viewPaymentProcessing() {
        println "parameters " + params
        if (!params.documentClass.equals("EXPORT_ADVISING") && !(params.serviceType.equals("REFUND") && params.documentClass in ["DA","DP","OA","DR","LC", "EXPORT_CHARGES"])) {
            Map<String, Object> forwardMap = unactedService.evaluatePaymentProcessingParams(params)
            forward(forwardMap)
        } else {
            if (params.documentClass.equals("EXPORT_ADVISING")) {
                chain(controller: "exportAdvising", action: "viewPayment",
					model: [tradeServiceId: params.tradeServiceId,viewMode:params.viewMode,onViewMode:params.onViewMode])
            } else if (params.serviceType.equals("REFUND")){
                if (params.documentClass in ["DA","DP","OA","DR","LC"]) {
                    chain(controller: "refund", action: "viewRefundPayment",
                            model: [tradeServiceId: params.tradeServiceId])
                } else if (params.documentClass.equals("EXPORT_CHARGES")) {
                    chain(controller: "exportsRefund", action: "viewRefundPayment",
                            model: [tradeServiceId: params.tradeServiceId])
                }
            }
        }
    }

    def viewMt() {
        Map<String, Object> forwardMap = unactedService.evaluateMtParams(params)

        forward(forwardMap)
    }

    def viewUnactedCashAdvanceBranch() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllUnactedCashAdvanceBranch(session.username, maxRows, rowOffset, currentPage, session.userrole.id)

        def totalRows = mapList.totalRows ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructCashAdvanceBranch(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedCashAdvanceMain() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllUnactedCashAdvanceMain(session.username, session.userrole.id, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = unactedService.constructCashAdvanceMain(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedExportAdvisingMain() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = unactedService.findAllUnactedExportAdvising(session.username, session.userrole.id, maxRows, rowOffset, currentPage)

        def totalRows = mapList.totalRows ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = mapList.display.collect {
            Map<String, Object> map = JSON.parse(it.DETAILS)
			
			
			if(map.serviceType.equalsIgnoreCase("OPENING_ADVISING")) {
				map.serviceType = "Advise on Opening"
			} else if(map.serviceType.equalsIgnoreCase("AMENDMENT_ADVISING")) {
				map.serviceType = "Advise on Amendment"
			}else if(map.serviceType.equalsIgnoreCase("CANCELLATION_ADVISING")) {
				map.serviceType = "Advise on Cancellation"
			}
			
			println it.PAYMENTSTATUS
            [id: it.TRADESERVICEID,
                    cell: [
                            it.DOCUMENTNUMBER,
                            it.CIFNAME,
                            "AMENDMENT_ADVISING".equals(map.serviceType) ? map.exporterNameFrom : map.exporterName,
							map.serviceType,
                            "AMENDMENT_ADVISING".equals(map.serviceType) ? map.lcCurrencyFrom : map.lcCurrency,
                            "AMENDMENT_ADVISING".equals(map.serviceType) ?
                                (map.lcAmountFrom ? NumberUtils.currencyFormat(new Double(map.lcAmountFrom.replaceAll(",",""))) : "" ) :
                                (map.lcAmount ? NumberUtils.currencyFormat(new Double(map.lcAmount)) : ''),
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; viewExportAdvising(id);\">view/edit</a>",
							(session['userrole']['id'] != "TSDM" && it.PAYMENTSTATUS != "PAID" && it.PAYMENTSTATUS != "NO_PAYMENT_REQUIRED") ?
								'' : "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; payExportAdvising(id);\">pay</a>",
                            it.DOCUMENTSUBTYPE1,
                            it.SERVICETYPE
                    ]
            ]
        }
		
        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewUnactedExportBillsBranch() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList
        println session.group
        if (session.group.equals("BRANCH")) {
            mapList = unactedService.findAllUnactedExportBillsBranch(session.username, maxRows, rowOffset, currentPage, session.userrole.id)
        } else if (session.group.equals("TSD")) {
            mapList = unactedService.findAllUnactedExportBillsTsd(session.username, session.userrole.id, maxRows, rowOffset, currentPage)
        }

        def totalRows = mapList.totalRows ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = mapList.display.collect {
            Map<String, Object> map = JSON.parse(it.DETAILS)

            String ahref = ""
			
			String transactionType
			if(it.DOCUMENTTYPE.equalsIgnoreCase("FOREIGN") && it.DOCUMENTCLASS.equalsIgnoreCase("BP") && it.SERVICETYPE.equalsIgnoreCase("SETTLEMENT")){
				transactionType = "Export Bills Purchase Settlement"
				
			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("FOREIGN") && it.DOCUMENTCLASS.equalsIgnoreCase("BP") && it.SERVICETYPE.equalsIgnoreCase("NEGOTIATION")){
				transactionType = "Export Bills Purchase Negotiation"
		
			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("FOREIGN") && it.DOCUMENTCLASS.equalsIgnoreCase("BC") && it.SERVICETYPE.equalsIgnoreCase("SETTLEMENT")){
				transactionType = "Export Bills Collection Settlement"
		
			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("FOREIGN") && it.DOCUMENTCLASS.equalsIgnoreCase("BC") && it.SERVICETYPE.equalsIgnoreCase("NEGOTIATION")){
				transactionType = "Export Bills Collection Negotiation"
	
			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("FOREIGN") && it.DOCUMENTCLASS.equalsIgnoreCase("BC") && it.SERVICETYPE.equalsIgnoreCase("CANCELLATION")){
				transactionType = "Export Bills Collection Cancellation"
	
			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("DOMESTIC") && it.DOCUMENTCLASS.equalsIgnoreCase("BP") && it.SERVICETYPE.equalsIgnoreCase("SETTLEMENT")){
				transactionType = "Domestic Bills Purchase Settlement"
			
			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("DOMESTIC") && it.DOCUMENTCLASS.equalsIgnoreCase("BP") && it.SERVICETYPE.equalsIgnoreCase("NEGOTIATION")){
				transactionType = "Domestic Bills Purchase Negotiation"

			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("DOMESTIC") && it.DOCUMENTCLASS.equalsIgnoreCase("BC") && it.SERVICETYPE.equalsIgnoreCase("SETTLEMENT")){
				transactionType = "Domestic Bills Collection Settlement"

			}
			if(it.DOCUMENTTYPE.equalsIgnoreCase("DOMESTIC") && it.DOCUMENTCLASS.equalsIgnoreCase("BC") && it.SERVICETYPE.equalsIgnoreCase("NEGOTIATION")){
				transactionType = "Domestic Bills Collection Negotiation"

			}
			
			
			

            if (("BC".equals(it.DOCUMENTCLASS) && "SETTLEMENT".equals(it.SERVICETYPE)) ||
                ("BP".equals(it.DOCUMENTCLASS) && "NEGOTIATION".equals(it.SERVICETYPE))) {
                ahref = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; var tsid='" + it.TRADESERVICEID + "'; viewExportBillsEts(id, tsid);\">view</a>"
            }

            String tsdhref = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; viewExportBillsDataEntry(id);\">view/edit</a>"

            if (session.group.equals("BRANCH")) {
                tsdhref = ""
            }

            [id: it.TRADESERVICEID,
                    cell: [
                            it.DOCUMENTNUMBER,
                            it.CIFNAME,
                            map.exporterName ?: map.sellerName ,
                            transactionType,
                            map.currency,
//                            map.amount ? NumberUtils.currencyFormat(new Double(map.amount)) : '',
                            //bug#2505
//                            map.proceedsAmount ? NumberUtils.currencyFormat(new Double(map.proceedsAmount)) : '',
                            NumberUtils.currencyFormat("SETTLEMENT".equals(it.SERVICETYPE) ? (map?.proceedsAmount ? new Double(map?.proceedsAmount) : Double.MIN_VALUE) : (map?.amount ? new Double(map?.amount) : Double.MIN_VALUE)),
                            ahref,
                            tsdhref,
                            it.SERVICETYPE,
                            it.DOCUMENTTYPE,
                            it.DOCUMENTCLASS
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
}
