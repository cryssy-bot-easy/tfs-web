package com.ucpb.tfsweb.other.exports.exportbills

import grails.converters.JSON
import net.ipc.utils.JsonUtil
import net.sf.json.util.JSONUtils
import groovy.json.JsonSlurper


//	PROLOGUE:
//	(revision)
//	SCR/ER Number:
//	SCR/ER Description: redmine 3700 - EBP Nego - Special characters and next words omitted
//	[Revised by:] Maximo Brian Lulab
//	[Date revised:] 04/05/2016
//	Program [Revision] Details: To have validation on input of additional instruction when special characters
//                              are inputted,system auto-omit the special character and the words next to it on the nego advise generated.
//	Date deployment:
//	Member Type: groovy
//	Project: WEB
//	Project Name: ExportBillsPurchaseController.groovy

/*
(revision)
SCR/ER Number:
SCR/ER Description: Tenor Term and Collecting Bank's Name in Set-up NonLC Details tab of EBP NEGO,
be extracted from EBC Nego (Redmine# 3739)
[Revised by:] Robin C. Rafael
[Date deployed:]
Program [Revision] Details: Extract Tenor Term and Collecting Bank's Name on EBC Details
Member Type: Groovy
Project: WEB
Project Name: ExportBillsPurchaseController.groovy
*/

/**
 * (revision)
 *	SCR/ER Number:
 *	SCR/ER Description: Missing Save Button in EBP Nego and EBC Settlement Data Entry (Redmine# 4213)
 *	[Revised by:] Brian Harold A. Aquino
 *	[Date revised:] 05/23/2017 (tfs Rev# 7497)
 *	[Date deployed:] 06/16/2017
 *	Program [Revision] Details: Added a new condition that can save.
 *	Member Type: Groovy 
 *	Project: WEB
 *	Project Name: ExportBillsPurchaseController.groovy
 */
/**
 * PROLOGUE
 * SCR/ER Description:
 *	[Revised by:] Cedrick C. Nungay
 *	[Date revised:] 03/20/2018
 *	Program [Revision] Details: Added centavos model on page load.
 *	Date deployment: 3/20/2018
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: ExportBillsPurchaseController.groovy
*/
class ExportBillsPurchaseController {

	def coreAPIService
	def ratesService
	def routingInformationService
	def etsService
	def dataEntryService
	def chargesPaymentService
	def documentEnclosedService
	def parserService
	def chargesService
	def foreignExchangeService
	def tabUtilityService

	def exportBillsService

	private DEF_TABS = ["basicDetails",
			"productPayment",
			"loanSetup",
			"docEnclosedInstructions",
			"charges",
			"chargesPayment",
			"settlementToBeneficiary",
			"mt103",
			"pddts",
			"instructionsAndRouting"]

	// NEGOTIATION - ETS
	def viewNegotiationEts() {	
		
		if (chainModel) {

			session.etsModel = chainModel

			if (chainModel.serviceInstructionId) {
				def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

				session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
				/**
				 * 04252017 RM  4207 - Edit by Pat - Commented out this line so in view ETS, only ETS details will be retrieved,
				   regardless whether rest service threw back a map with tradeservice details
				 */
//				session.etsModel << tradeService?.details 
				session.etsModel << tradeService?.documentNumber
				session.etsModel << [approvers: tradeService?.ets?.approvers]
				session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
				
				// passes chain model if existing else passes session model
				String tradeServiceId = session.etsModel.tradeServiceId
				Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
				session.etsModel << [paymentsMade: paymentsMade.payments]
				session.etsModel << [loanCount: paymentsMade.loanCount]

				if(tradeService?.tradeServiceId?.tradeServiceId){
					List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

					println "EBP >>>>>>>>>>>>>>>>>>> charges = ${charges}"

					session.etsModel << [charges:charges]
					session.etsModel << [chargesString: parserService.listHashMapToString(charges)]
				}
			}
			
			//comment by robin for redmine 4122 item#3: Set Nego Currency default to USD
			println "test by rrr: " + chainModel.currency
			if(!chainModel.currency) {
				println "zxcvbnm 1 if chainmodel.currency: " + chainModel.currency
				println (session.etsModel?.documentType?.equals("FOREIGN") && session.etsModel?.serviceType?.equals("NEGOTIATION")
						&& session.etsModel?.documentClass?.equals("BP"))
				if (session.etsModel?.documentType?.equals("FOREIGN")) {
					println "zxcvbnm 2"
					chainModel.currency = "USD"
				}
			}else{
				println "zxcvbnm  else: " + chainModel.currency
			}
			//
			
			session.etsModel << [formName: chainModel.formName]
		}
		
		
		
		

		session.etsModel << [title: "Export Bills for Purchase - Negotiation (eTS)",
				tabs: ["basicDetails", "productPayment", "loanSetup", "charges", "chargesPayment", "settlementToBeneficiary", "instructionsAndRouting"],
				serviceType: "NEGOTIATION",
				documentClass: "BP",
				documentType: "FOREIGN",//session.etsModel.documentType,
				documentSubType1: "",
				documentSubType2: "",
				referenceType: "ETS"
		]

		// setup product labels
		session.etsModel << [totalAmountDueCurrencyLabel: "Amount Due (in Negotiation Currency)",
				totalAmountDueAmountLabel: "Remaining Balance",
				amountInPaymentInCurrencyLabel: "Amount of Negotiation Payment <br/> (in Settlement Currency)",
				amountInPaymentInDocumentCurrencyLabel: "Amount of Negotiation Payment <br/> (in Negotiation Currency)",
				totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Negotiation Currency)",
				excessAmountInCurrencyLabel: "Excess Amount <br/> (in Negotiation Currency)"
		]
		
		if ("LC".equals(session.etsModel.paymentMode)) {
			//comment by robin 4122 item 4: remove setup lc details when the transaction has EBC
			println "with or w/o EBC flag: " + session.etsModel.withBcFlag
			println "test boolean: " + (Integer.parseInt(session.etsModel.withBcFlag) == 0)
			if(Integer.parseInt(session.etsModel.withBcFlag) == 0 ){
				println "No outstanding EBC. Insert lc_details_tab."
				session.etsModel.tabs << "setupLcDetails"
			}else if(Integer.parseInt(session.etsModel.withBcFlag) == 1 ){
				println "with EBC. Do not insert setup lc details"			
			}
			//session.etsModel.tabs << "setupLcDetails"
		} else if (session.etsModel.paymentMode in ["DA", "DP", "OA", "DR"]) {
			if(Integer.parseInt(session.etsModel.withBcFlag) == 0 ){
				println "No outstanding EBC. Insert non lc_details_tab."
				session.etsModel.tabs << "setupNonLcDetails"
			}else if(Integer.parseInt(session.etsModel.withBcFlag) == 1 ){
				println "with EBC. Do not insert setup non lc details"
			}	
		}

		def exchange = []

		ratesService.getRatesEB(session.etsModel.currency).response.details.each {
			def text_pass_on_rate
			def text_special_rate
			def pass_on_rate_cash
			def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

			session.etsModel.each { ets ->

                if (it.description.toString().contains("URR")) {
                    if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate_urr")) {
                        text_pass_on_rate = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash_urr")) {
                        pass_on_rate_cash = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate_urr")) {
                        text_special_rate = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash_urr")) {
                        special_rate_cash = ets.value
                    }
                } else {
					if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate")) {
						text_pass_on_rate = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash")) {
						pass_on_rate_cash = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate")) {
						text_special_rate = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash")) {
						special_rate_cash = ets.value
					}
				}
			}

			exchange << [rates: it.rates,
					rate_description: it.description,
					rate_description_lbp: it.descriptionLbp,
					pass_on_rate: pass_on_rate,
					special_rate: special_rate,

					text_pass_on_rate: text_pass_on_rate,
					pass_on_rate_cash: pass_on_rate_cash,
					text_special_rate: text_special_rate,
					special_rate_cash: special_rate_cash
			]
		}

		session.etsModel << [exchange: exchange]
		// used to display rates - end

		// setup gsp to display in tabs
		session.etsModel << [basicDetailsTab: "../product/other/exports/export_bills/purchase/export/ets/negotiation/basic_details_tab"]

		session.etsModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.etsModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]

		session.etsModel << [loanSetupTab: "../product/other/exports/export_bills/purchase/export/ets/loan_setup_ets_tab"]
		session.etsModel << [proceedsDetailsTab: "../product/other/exports/export_bills/purchase/export/ets/settlement_to_ben_tab"]
		session.etsModel << [chargesTab: "../product/commons/tabs/charges_tab"]
		session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

		if (session.etsModel.tabs.contains("setupLcDetails")) {
			session.etsModel << [setupLcDetailsTab: "../product/other/exports/export_bills/purchase/export/ets/negotiation/setup_lc_details_foreign_tab"]
			session.etsModel << [setupLcDetailsAction: "saveNegotiationEts"]
		}
		
		if (session.etsModel.tabs.contains("setupNonLcDetails")) {
			session.etsModel << [setupNonLcDetailsTab: "../product/other/exports/export_bills/purchase/export/ets/negotiation/setup_nonlc_details_tab"]
			session.etsModel << [setupNonLcDetailsAction: "saveNegotiationEts"]
		}
		session.etsModel << [basicDetailsAction: "saveNegotiationEts"]
		session.etsModel << [productPaymentAction: "updateNegotiationEts"]
		session.etsModel << [loanSetupAction: "saveNegotiationEts"]
		session.etsModel << [settlementToBeneficiaryAction: "updateNegotiationEts"]
		session.etsModel << [chargesAction: "updateNegotiationEts"]
		session.etsModel << [chargesPaymentAction: "updateNegotiationEts"]
		session.etsModel << [routeAction: "updateEtsStatus"]

		// routing
		def documentServiceRoute = routingInformationService.getNextBranchApprover("BP", "FOREIGN", null, null, "ETS", "NEGOTIATION", session.username, session.userrole.id, session.unitcode, session.etsModel)
		session.nextRoute = documentServiceRoute
		session.etsModel << routingInformationService.getBranchApprovalMode("BP", "FOREIGN", null, null, "NEGOTIATION", session.etsModel.approvers)

		if(chainModel){
			session.etsModel << [viewMode:chainModel?.viewMode,onViewMode:chainModel?.onViewMode]
			session.viewMode=chainModel?.viewMode
			session.onViewMode=chainModel?.onViewMode
		}else if(params.viewMode){
			session.etsModel << [viewMode:params.viewMode,onViewMode:params.onViewMode]
			session.viewMode=params.viewMode
			session.onViewMode=params.onViewMode
		}else{
			session.etsModel << [viewMode:session.viewMode,onViewMode:session.onViewMode]
		}
		session.etsModel << [centavos: coreAPIService.dummySendQuery(
			[documentType: session.etsModel.documentType, documentClass: session.etsModel.documentClass,
				documentSubType1: session.etsModel.documentSubType1, documentSubType2: session.etsModel.documentSubType2,
				serviceType: 'NEGOTIATION'], 'getChargesParameter', 'chargesParameter/').result?.RATEAMOUNT]
		
		
		
		render(view: "../product/index", model: session.etsModel)
	}

	def saveNegotiationEts() {
		println"saveNegotiationEts"

		params.saveAs = ""
		params.unitcode = session.unitcode
		params.username = session.username

		params.cifNumber = params.cifNumberParam
		params.cifName = params.cifNameParam
		params.accountOfficer = params.accountOfficerParam
		params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
		params.allocationUnitCode = params.allocationUnitCodeParam

		params.each {
			if (it.key.toString().toLowerCase().contains("amount")) {
				it.value = it.value.replaceAll(",", "")
			}
		}
		
		//3739 comment by robin
		if(params?.paymentMode && params?.paymentMode != "LC" && params?.paymentMode != "lc"){
			def ebcDetails
			
			if(params?.negotiationNumber && params?.negotiationNumber != null && params?.negotiationNumber != ""){
				ebcDetails = coreAPIService.dummySendQuery([negotiationNumber : params?.negotiationNumber ], "getEbcDetailsByNegotiationNumber", "exportbills/")

				params.nonLcTenorTerm = ebcDetails?.details?.details?.nonLcTenorTerm
				params.collectingBankName = ebcDetails?.details?.details?.collectingBankName
			}
		}
		//3739 comment end

		Map returnedValues = coreAPIService.dummySendCommand(params, "save", "ets")
		println "save returnedValues: " + returnedValues

		String etsNumber = returnedValues["details"]["serviceInstructionId"]["serviceInstructionId"]

		// we get the eTS number from
		def sessionModel = [:]

		// copy the details returned from the Save call
		sessionModel << returnedValues["details"]["details"]

		// override etsNumber with the one we got from the Save
		sessionModel << ["serviceInstructionId": etsNumber]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]
		
		println "formName param" + tabUtilityService.getTabName(params.form)
		println "formName param form" + params.form

		chain(controller: "exportBillsPurchase", action: "viewNegotiationEts", model: sessionModel)
	}

	def updateNegotiationEts() {
		println"updateNegotiationEts"
		params.unitcode = session.unitcode
		params.username = session.username

		println "etsService update params: " + params
		Map<String, Object> map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))
		
		println "formName param" + tabUtilityService.getTabName(params.form)
		println "formName param form" + params.form

		chain(controller: "exportBillsPurchase", action: "viewNegotiationEts", model: map)
	}

	// NEGOTIATION - DATAENTRY

	def updateEtsStatus() {
		//println"updateEtsStatus"
		params.unitcode = session.unitcode
		params.username = session.username

		Map<String, Object> map = new HashMap<>()
		map = etsService.updateEts(params)

		redirect(controller: "unactedTransactions", action: "viewUnacted")
	}

	// DATA ENTRY
	def viewNegotiationDataEntry() {
		String tradeServiceId = chainModel?.tradeServiceId ?: session.dataEntryModel?.tradeServiceId
		println "tradeServiceId =" + tradeServiceId
		Map<String, Object> paymentsMade
		if (tradeServiceId){
			paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
		}
		if (chainModel) {
			println "before hasRoute: " + chainModel?.hasRoute
			session.dataEntryModel = chainModel

			if (chainModel.tradeServiceId) {
				def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

				session.dataEntryModel << tradeService?.details
				session.dataEntryModel << tradeService?.tradeServiceId
				session.dataEntryModel << tradeService?.serviceInstructionId
				session.dataEntryModel.approvers = tradeService?.approvers
				session.dataEntryModel << tradeService?.documentNumber

				session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

				session.dataEntryModel << [status: tradeService?.status]

				session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
				
				def negoPayments = chargesPaymentService.findNegotiationPayments(session.dataEntryModel?.tradeServiceId)

				session.dataEntryModel << [pddtsFlag: negoPayments.pddts.pddtsFlag]
				session.dataEntryModel << [mt103Flag: negoPayments.mt103.mt103Flag]
				
				def ebcDetails
					
				if(chainModel?.negotiationNumber || chainModel?.negotiationNumber != null || chainModel?.negotiationNumber != ""){
					ebcDetails = coreAPIService.dummySendQuery([negotiationNumber : chainModel?.negotiationNumber ], "getEbcDetailsByNegotiationNumber", "exportbills/")
				}
				
				//START MAX VALIDATION REDMINE 3700 AS OF 04/05/2016
				//Documents Enclosed Table
//               if (tradeService?.details.documentsEnclosed) {
//                   def listMap = documentEnclosedService.stringToListMap(tradeService?.details.documentsEnclosed.toString())
//                   session.dataEntryModel.documentsEnclosed = listMap
//                   session.dataEntryModel.documentsEnclosedList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
//               } else if(chainModel?.negotiationNumber || chainModel?.negotiationNumber != null || chainModel?.negotiationNumber != ""){
//					if (ebcDetails?.details?.details?.documentsEnclosed.toString() != "null"){
//						def listMap = documentEnclosedService.stringToListMap(ebcDetails?.details?.details?.documentsEnclosed.toString())
//						session.dataEntryModel.documentsEnclosed = listMap
//						session.dataEntryModel.documentsEnclosedList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
//					}
//               }else {
//                   session.dataEntryModel.documentsEnclosed = []
//               }

			if (tradeService?.details.documentsEnclosed && tradeService?.details.documentsEnclosed != "[[:]]") {
					println "tradeService?.details.documentsEnclosed >> " + tradeService?.details.documentsEnclosed
					def listMap = documentEnclosedService.stringToListMapDocEnclosed(tradeService?.details.documentsEnclosed.toString())
					session.dataEntryModel.documentsEnclosed = listMap
					session.dataEntryModel.documentsEnclosedList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
				} else if((chainModel?.negotiationNumber || chainModel?.negotiationNumber != null || chainModel?.negotiationNumber != "") && ebcDetails?.details?.details?.documentsEnclosed.toString() != "null"){
					def listMap = documentEnclosedService.stringToListMap(ebcDetails?.details?.details?.documentsEnclosed.toString())
					session.dataEntryModel.documentsEnclosed = listMap
					session.dataEntryModel.documentsEnclosedList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
				} else {
					session.dataEntryModel.documentsEnclosed = []
				}
				
				// Instruction Table below Documents Enclosed Table
				if (tradeService?.details.enclosedInstruction) {
					def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.enclosedInstruction.toString())
					session.dataEntryModel.enclosedInstruction = listMap
					session.dataEntryModel.enclosedInstructionList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
				} else if(chainModel?.negotiationNumber || chainModel?.negotiationNumber != null || chainModel?.negotiationNumber != ""){
					if (ebcDetails?.details?.details?.enclosedInstruction.toString() != "null"){
						def listMap = documentEnclosedService.stringToListMapAdditionalCondition(ebcDetails?.details?.details?.enclosedInstruction.toString())
						session.dataEntryModel.enclosedInstruction = listMap
						session.dataEntryModel.enclosedInstructionList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
					}
				} else {
					session.dataEntryModel.enclosedInstruction = []
				}
				 if (tradeService?.details.enclosedInstruction && tradeService?.details.enclosedInstruction != "[[:]]") {
					println "tradeService?.details.enclosedInstruction"
					println tradeService?.details.enclosedInstruction
					def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.enclosedInstruction.toString())
					session.dataEntryModel.enclosedInstruction = listMap
					session.dataEntryModel.enclosedInstructionList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
				} else if((chainModel?.negotiationNumber || chainModel?.negotiationNumber != null || chainModel?.negotiationNumber != "") && ebcDetails?.details?.details?.enclosedInstruction.toString() != "null"){
					def listMap = documentEnclosedService.stringToListMapAdditionalCondition(ebcDetails?.details?.details?.enclosedInstruction.toString())
					session.dataEntryModel.enclosedInstruction = listMap
					session.dataEntryModel.enclosedInstructionList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
				} else {
					session.dataEntryModel.enclosedInstruction = []
				}
				
				// Additional Instruction Table below Instruction Table
//                if (tradeService?.details.additionalInstruction) {
//                    def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.additionalInstruction.toString())
//                    session.dataEntryModel.additionalInstruction = listMap
//                } else if(chainModel?.negotiationNumber || chainModel?.negotiationNumber != null || chainModel?.negotiationNumber != ""){
//					if (ebcDetails?.details?.details?.additionalInstruction.toString() != "null"){
//						def listMap = documentEnclosedService.stringToListMapAdditionalCondition(ebcDetails?.details?.details?.additionalInstruction.toString())
//						session.dataEntryModel.additionalInstruction = listMap
//					}
//                } else {
//                    session.dataEntryModel.additionalInstruction = []
//                }

				//END OF MAX VALIDATION OF REDMINE 3700
				if (tradeService?.details.additionalInstruction && tradeService?.details.additionalInstruction != "[[:]]") {
					println "tradeService?.details.additionalInstruction"
					def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.additionalInstruction.toString())
					session.dataEntryModel.additionalInstruction = listMap
				} else if((chainModel?.negotiationNumber || chainModel?.negotiationNumber != null || chainModel?.negotiationNumber != "") && ebcDetails?.details?.details?.additionalInstruction.toString() != "null"){
					def listMap = documentEnclosedService.stringToListMapAdditionalCondition(ebcDetails?.details?.details?.additionalInstruction.toString())
					session.dataEntryModel.additionalInstruction = listMap
				} else {
					session.dataEntryModel.additionalInstruction = []
				}


				List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

				session.dataEntryModel << [charges:charges]
				session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

			}
			println "after hasRoute: " + chainModel?.hasRoute
			
			session.dataEntryModel << [formName: chainModel.formName]
		}
		if(tradeServiceId == session.dataEntryModel?.tradeServiceId){
			session.dataEntryModel << [paymentsMade: paymentsMade?.payments]
			session.dataEntryModel << [loanCount: paymentsMade?.loanCount]
		}

		session.dataEntryModel << [title: "Export Bills for Purchase - Negotiation (Data Entry)",
				tabs: ["basicDetails",
					   "productPayment",
					   "loanSetup",
					   "docEnclosedInstructions",
					   "charges",
					   "chargesPayment",
					   "settlementToBeneficiary",
					   "mt103",
					   "pddts",
					   "instructionsAndRouting"],

				serviceType: "NEGOTIATION",
				documentClass: "BP",
				documentType: "FOREIGN", //session.dataEntryModel.documentType,
				documentSubType1: "",
				documentSubType2: "",
				referenceType: "DATA_ENTRY"
		]

		// setup product labels
		session.dataEntryModel << [totalAmountDueCurrencyLabel: "Amount Due (in Negotiation Currency)",
				totalAmountDueAmountLabel: "Remaining Balance",
				amountInPaymentInCurrencyLabel: "Amount of Negotiation Payment <br/> (in Settlement Currency)",
				amountInPaymentInDocumentCurrencyLabel: "Amount of Negotiation Payment <br/> (in Negotiation Currency)",
				totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Negotiation Currency)",
				excessAmountInCurrencyLabel: "Excess Amount <br/> (in Negotiation Currency)"
		]
		
		if ("LC".equals(session.dataEntryModel.paymentMode)) {
			session.dataEntryModel.tabs = DEF_TABS
			session.dataEntryModel.tabs << "setupLcDetails"
		} else if (session.dataEntryModel.paymentMode in ["DA", "DP", "OA", "DR"]) {
			session.dataEntryModel.tabs = DEF_TABS
			println '??' + session.dataEntryModel.tabs
			session.dataEntryModel.tabs << "setupNonLcDetails"
		}

//        if ("LC".equals(session.dataEntryModel.paymentMode)) {
//            session.dataEntryModel.tabs = DEF_TABS
//            session.dataEntryModel.tabs << "setupLcDetails"
//        } else if (session.dataEntryModel.paymentMode in ["DA", "DP", "OA", "DR"]) {
//            session.dataEntryModel.tabs = DEF_TABS
//            session.dataEntryModel.tabs << "setupNonLcDetails"
//        }

		def exchange = []

		ratesService.getRatesEB(session.dataEntryModel.currency).response.details.each {
			def text_pass_on_rate
			def text_special_rate
			def pass_on_rate_cash
			def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

			session.dataEntryModel.each { ets ->

                if (it.description.toString().contains("URR")) {
                    if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate_urr")) {
                        text_pass_on_rate = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash_urr")) {
                        pass_on_rate_cash = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate_urr")) {
                        text_special_rate = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash_urr")) {
                        special_rate_cash = ets.value
                    }
                } else {
					if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate")) {
						text_pass_on_rate = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash")) {
						pass_on_rate_cash = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate")) {
						text_special_rate = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash")) {
						special_rate_cash = ets.value
					}
				}
			}

			exchange << [rates: it.rates,
					rate_description: it.description,
					rate_description_lbp: it.descriptionLbp,
					pass_on_rate: pass_on_rate,
					special_rate: special_rate,

					text_pass_on_rate: text_pass_on_rate,
					pass_on_rate_cash: pass_on_rate_cash,
					text_special_rate: text_special_rate,
					special_rate_cash: special_rate_cash
			]
		}

		session.dataEntryModel << [exchange: exchange]
		// used to display rates - end

		// setup gsp to display in tabs
		session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/purchase/export/dataentry/negotiation/basic_details_tab"]
		
		session.dataEntryModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.dataEntryModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]

		if (session.dataEntryModel.tabs.contains("setupLcDetails")) {
			println 'yes'
			session.dataEntryModel << [setupLcDetailsTab: "../product/other/exports/export_bills/purchase/export/dataentry/negotiation/setup_lc_details_foreign_tab"]
			session.dataEntryModel << [setupLcDetailsAction: "saveNegotiationDataEntry"]
		}
		
		if (session.dataEntryModel.tabs.contains("setupNonLcDetails")) {
			session.dataEntryModel << [setupNonLcDetailsTab: "../product/other/exports/export_bills/purchase/export/dataentry/negotiation/setup_nonlc_details_tab"]
			session.dataEntryModel << [setupNonLcDetailsAction: "saveNegotiationDataEntry"]
		}
		
		// comment below code, the pddts and mt103 tab used was the commons tab in lc and nonlc
		 session.dataEntryModel << [pddtsTab: "../product/other/exports/export_bills/purchase/export/dataentry/pddts_tab"]
		 session.dataEntryModel << [mt103Tab: "../product/other/exports/export_bills/purchase/export/dataentry/mt103_details_tab"]

//		session.dataEntryModel << [pddtsTab: "../commons/tabs/pddts_tab"]
//		session.dataEntryModel << [mt103Tab: "../commons/tabs/mt_103_tab"]

		session.dataEntryModel << [loanSetupTab: "../product/other/exports/export_bills/purchase/export/dataentry/loan_setup_dataentry_tab"]

		session.dataEntryModel << [docEnclosedInstructionsTab: "../product/other/exports/export_bills/purchase/export/dataentry/negotiation/documents_enclosed_instructions_tab"]

		session.dataEntryModel << [proceedsDetailsTab: "../product/other/exports/export_bills/purchase/export/dataentry/settlement_to_ben_tab"]

		session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
		session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

		session.dataEntryModel << [basicDetailsAction: "saveNegotiationDataEntry"]

		session.dataEntryModel << [docEnclosedInstructionsAction: "saveNegotiationDataEntry"]
		session.dataEntryModel << [loanSetupAction: "saveNegotiationDataEntry"]

		session.dataEntryModel << [settlementToBeneficiaryAction: "updateNegotiationDataEntry"]
		session.dataEntryModel << [pddtsAction: "updateNegotiationDataEntry"]
		session.dataEntryModel << [mt103Action: "updateNegotiationDataEntry"]

		session.dataEntryModel << [chargesAction: "updateNegotiationDataEntry"]
		session.dataEntryModel << [chargesPaymentAction: "updateNegotiationDataEntry"]
		session.dataEntryModel << [routeAction: "updateDataEntryStatus"]
		
		session.dataEntryModel << [productPaymentAction: "updateNegotiationDataEntry"]
		session.dataEntryModel << [settlementToBeneficiaryAction: "updateNegotiationDataEntry"]

		// routing
		def documentServiceRoute = routingInformationService.getNextMainApprover("BP", "FOREIGN", null, null, "DATA_ENTRY", "NEGOTIATION", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
		session.nextRoute = documentServiceRoute
		session.dataEntryModel << routingInformationService.getMainApprovalMode("BP", "FOREIGN", null, null, "NEGOTIATION", session.dataEntryModel.approvers)

		session.removeAttribute("financial")
		session.removeAttribute("postApprovalRequirement")
		session.removeAttribute("amountToCheck")
		session.removeAttribute("signingLimit")
		session.removeAttribute("postingAuthority")

		def productReference = routingInformationService.getProductReferences("BP", "FOREIGN", null, null, "NEGOTIATION", session.dataEntryModel, session.unitcode, session.username)

		session.financial = productReference.financial
		session.postApprovalRequirement = productReference.postApprovalRequirement
		session.amountToCheck = productReference.amountToCheck
		session.signingLimit = productReference.signingLimit
		session.postingAuthority = productReference.postingAuthority
		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
				if(chainModel?.hasRoute){
					session.hasRoute=chainModel?.hasRoute
				}
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
				if(params.hasRoute){
					session.hasRoute=params.hasRoute
				}
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
		 session.dataEntryModel << [hasRoute:session.hasRoute]
		 
		println "session.dataEntryModel.tabs " + session.dataEntryModel.tabs
		render(view: "../product/index", model: session.dataEntryModel)
	}

	def saveNegotiationDataEntry() {
		println"saveNegotiationDataEntry"

		params.saveAs = ""
		params.unitcode = session.unitcode
		params.username = session.username
		
		// enclosed document
		def paramDocEnclosed = []
		if (params.documentsEnclosedList) {
			params.documentsEnclosedList.split("\\|").each {
				paramDocEnclosed << JsonUtil.parseToMap(it)
			}
		}
		if (!paramDocEnclosed.isEmpty()) {
			params.documentsEnclosed = paramDocEnclosed.toString()
		}

		// enclosed instruction
		def paramEnclosedInstr = []
		if (params.enclosedInstructionList) {
			params.enclosedInstructionList.split("\\|").each {
				paramEnclosedInstr << JsonUtil.parseToMapNewLine(it)
			}
		}
		if(!paramEnclosedInstr.isEmpty()) {
			params.enclosedInstruction = paramEnclosedInstr.toString()
		}

		def paramAdditionalInstr = []
		session.dataEntryModel.additionalInstruction?.each {
			paramAdditionalInstr << [id: it.id, instruction: it.instruction]
		}
		if(!paramAdditionalInstr.isEmpty()) {
			params.additionalInstruction = paramAdditionalInstr.toString()
		}

		params.each {
			if (it.key.toString().toLowerCase().contains("amount")) {
				it.value = it.value.replaceAll(",", "")
			}
		}

		//3739 by ROBIN
		if(params?.paymentMode && params?.paymentMode != "LC" && params?.paymentMode != "lc"){
			def ebcDetails
			
			if(params?.negotiationNumber && params?.negotiationNumber != null && params?.negotiationNumber != "" && params?.negotiationNumber != params?.oldNegotiationNumber){
				ebcDetails = coreAPIService.dummySendQuery([negotiationNumber : params?.negotiationNumber ], "getEbcDetailsByNegotiationNumber", "exportbills/")

				params.nonLcTenorTerm = ebcDetails?.details?.details?.nonLcTenorTerm
				params.collectingBankName = ebcDetails?.details?.details?.collectingBankName
			}
		}
		//3739 end
		
		params.put("donotreset","Y")

		Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

		def sessionModel = returnedValues["details"]["details"]

		sessionModel << returnedValues["details"]["tradeServiceId"]
		//sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
		sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]
		
		chain(controller: "exportBillsPurchase", action: "viewNegotiationDataEntry", model: sessionModel)
	}

	def updateNegotiationDataEntry() {
		println"updateNegotiationDataEntry"
		params.unitcode = session.unitcode
		params.username = session.username
		
		println "updateNegotiationDataEntry params: " + params
		
		Map<String, Object> map = new HashMap<>()

		if ("charges".equals(params.form) && "DATA_ENTRY".equals(params.referenceType)) {
			map = exportBillsService.updateExportBillsDataEntry(params)
		} else {
			/*println "formName: " + params.form
			if (params.form == "lcPayment") {
				def jsonSlurper = new JsonSlurper()
				def obj = jsonSlurper.parseText(params.documentPaymentSummary)
				println "obj: " + obj
				println "obj size: " + obj.size()
				if (obj.size() > 0 && obj[0].status != 'Not Paid') {
					println "params documentPaymentSummary: " + obj
					println "params docuPayment status: " + obj[0].status
					params.documentPaymentSummary = []
				}
				println "params.documentPaymentSummary: " + params.documentPaymentSummary
			}*/
			map = dataEntryService.updateDataEntry(params)
		}
		
		println "updateNegotiationDataEntry map values: " + map
		map.put("formName",tabUtilityService.getTabName(params.form))

		chain(controller: "exportBillsPurchase", action: "viewNegotiationDataEntry", model: map)
	}
	
	// Added by Brian for tab validation
	def viewNegotiationTab() {
		Map<String, Object> map = new HashMap<>()
		String action = ""
		
		switch(params.toggle) {
			case "ETS" : action = "viewNegotiationEts"
				map = etsService.getEts(params.tradeServiceId)
				break
			default : action =  params.serviceType == "SETTLEMENT" ? "viewSettlementDataEntry" : "viewNegotiationDataEntry"
				map = dataEntryService.getDataEntry(params.tradeServiceId)
				break
		}
		
		map.put("formName", tabUtilityService.getTabName(params.formName))
		
		println "map formname: " + map.formName
		
		chain(controller: "exportBillsPurchase", action: action, model: map)
	}

	def updateDataEntryStatus() {
		//println"updateDataEntryStatus"
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

	// SETTLEMENT
	def viewSettlementDataEntry() {
		println "viewSettlementDataEntry"
		if (chainModel) {

			session.dataEntryModel = chainModel

			if (chainModel.documentNumber) {
				def exportBills = coreAPIService.dummySendQuery([:], "details/"+chainModel.documentNumber, "product/exportBills/").details

				exportBills.each {
					if (!"processDate".equals(it.key)) {
						session.dataEntryModel << it
					}
				}
				session.dataEntryModel << [pnNumber: exportBills?.loanDetails?.pnNumber]
				session.dataEntryModel << exportBills.documentNumber
				session.dataEntryModel << [currency: exportBills?.currency.currencyCode]
			}
			
			if (chainModel.tradeServiceId) {
				def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details
				
				session.dataEntryModel << tradeService?.details
				session.dataEntryModel << tradeService?.tradeServiceId
				session.dataEntryModel.approvers = tradeService?.approvers
				session.dataEntryModel << tradeService?.documentNumber
				session.dataEntryModel << tradeService?.tradeServiceReferenceNumber

				session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

				session.dataEntryModel << [status: tradeService?.status]

				session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1

				List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

				println "EBP >>>>>>>>>>>>>>>>>>> charges = ${charges}"

				session.dataEntryModel << [charges:charges]
				session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

			}

			if(params.tradeServiceId){
				List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(params.tradeServiceId)

				println "EBP >>>>>>>>>>>>>>>>>>> charges = ${charges}"

				session.dataEntryModel << [charges:charges]
				session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]
			}

			session.dataEntryModel << [formName: chainModel.formName]
		}

		session.dataEntryModel << [tsdInitiated:"true"]

		session.dataEntryModel << [title: "Export Bills for Purchase - Settlement (Data Entry)",
				tabs: ["basicDetails",
//                        "charges",
//                        "chargesPayment",
						"instructionsAndRouting"],

				serviceType: "SETTLEMENT",
				documentClass: "BP",
				documentType: "FOREIGN", //session.dataEntryModel.documentType,
				documentSubType1: "",
				documentSubType2: "",
				referenceType: "DATA_ENTRY"
		]

//		Redmine 4137 - Commented out this code because Charges Payment tab is requested to be removed in EBP Settlement
//		if(session.dataEntryModel.amountDue && session.dataEntryModel.amountDue != '0.00'){
//			session.dataEntryModel.tabs << "productPayment"
			
			// setup product labels
			session.dataEntryModel << [totalAmountDueCurrencyLabel: "Amount Due (in Negotiation Currency)",
					totalAmountDueAmountLabel: "Remaining Balance",
					amountInPaymentInCurrencyLabel: "Amount of Negotiation Payment <br/> (in Settlement Currency)",
					amountInPaymentInDocumentCurrencyLabel: "Amount of Negotiation Payment <br/> (in Negotiation Currency)",
					totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Negotiation Currency)",
					excessAmountInCurrencyLabel: "Excess Amount <br/> (in Negotiation Currency)"
			]
//		}
		def exchange = []

		ratesService.getRatesEB(session.dataEntryModel.currency).response.details.each {
			def text_pass_on_rate
			def text_special_rate
			def pass_on_rate_cash
			def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

			session.dataEntryModel.each { ets ->

                if (it.description.toString().contains("URR")) {
                    if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate_urr")) {
                        text_pass_on_rate = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash_urr")) {
                        pass_on_rate_cash = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate_urr")) {
                        text_special_rate = ets.value
                    }

                    if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash_urr")) {
                        special_rate_cash = ets.value
                    }
                } else {
					if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate")) {
						text_pass_on_rate = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash")) {
						pass_on_rate_cash = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate")) {
						text_special_rate = ets.value
					}

					if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash")) {
						special_rate_cash = ets.value
					}
				}
			}

			exchange << [rates: it.rates,
					rate_description: it.description,
					rate_description_lbp: it.descriptionLbp,
					pass_on_rate: pass_on_rate,
					special_rate: special_rate,

					text_pass_on_rate: text_pass_on_rate,
					pass_on_rate_cash: pass_on_rate_cash,
					text_special_rate: text_special_rate,
					special_rate_cash: special_rate_cash
			]
		}

		session.dataEntryModel << [exchange: exchange]
		// used to display rates - end

		// setup gsp to display in tabs
		session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/purchase/export/dataentry/settlement/basic_details_tab"]

//        session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
//        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]
		
		// 01162017 - Changed Negotiation Payment tab name to Charges Payments
		session.dataEntryModel << [productPaymentTabLabel: "Charges <br /> Payment"]
		session.dataEntryModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]

		session.dataEntryModel << [basicDetailsAction: "saveSettlementDataEntry"]
		session.dataEntryModel << [chargesAction: "updateSettlementDataEntry"]
		session.dataEntryModel << [chargesPaymentAction: "updateSettlementDataEntry"]
		session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

		session.dataEntryModel << [productPaymentAction: "updateSettlementDataEntry"]
		// routing
		def documentServiceRoute = routingInformationService.getNextMainApprover("BP", "FOREIGN", null, null, "DATA_ENTRY", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
		session.nextRoute = documentServiceRoute
		session.dataEntryModel << routingInformationService.getMainApprovalMode("BP", "FOREIGN", null, null, "SETTLEMENT", session.dataEntryModel.approvers)

		session.removeAttribute("financial")
		session.removeAttribute("postApprovalRequirement")
		session.removeAttribute("amountToCheck")
		session.removeAttribute("signingLimit")
		session.removeAttribute("postingAuthority")

		def productReference = routingInformationService.getProductReferences("BP", "FOREIGN", null, null, "SETTLEMENT", session.dataEntryModel, session.unitcode, session.username)

		session.financial = productReference.financial
		session.postApprovalRequirement = productReference.postApprovalRequirement
		session.amountToCheck = productReference.amountToCheck
		session.signingLimit = productReference.signingLimit
		session.postingAuthority = productReference.postingAuthority

		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
				if(chainModel?.hasRoute){
					session.hasRoute=chainModel?.hasRoute
				}
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
				if(params.hasRoute){
					session.hasRoute=params.hasRoute
				}
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
		 session.dataEntryModel << [hasRoute:session.hasRoute]
		
		render(view: "../product/index", model: session.dataEntryModel)
	}

	def saveSettlementDataEntry() {
		println "saveSettlementDataEntry"
		params.saveAs = ""
		params.unitcode = session.unitcode
		params.username = session.username

		params.cifNumber = params.cifNumberParam
		params.cifName = params.cifNameParam
		params.accountOfficer = params.accountOfficerParam
		params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
		params.allocationUnitCode = params.allocationUnitCodeParam
		
		params.each {
			if (it.key.toString().toLowerCase().contains("amount")) {
				it.value = it.value.replaceAll(",", "")
			}
		}


		def exchangeRate = foreignExchangeService.extractExchangeRateByBaseCurrency(ratesService.getRatesByBaseCurrency().display, params)
		def exchangeRateUrr = foreignExchangeService.extractExchangeRateUsdToPhpUrr(ratesService.getRatesByBaseCurrency().display, params)
		def usdToPHPSpecialRateExchangeRate = foreignExchangeService.extractUsdToPhpRate(ratesService.getRatesByBaseCurrency().display, ['currency':''])
		def baseCurrency = foreignExchangeService.extractCorrectCurrency(params)
		if(baseCurrency.toString().equalsIgnoreCase("USD")){
			params.put("creationExchangeRate",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
		} else {
			params.put("creationExchangeRate",exchangeRate.setScale(8,BigDecimal.ROUND_HALF_UP))
		}
		params.put("creationExchangeRateUsdToPHPSpecialRate",usdToPHPSpecialRateExchangeRate['USD-PHP'].setScale(8,BigDecimal.ROUND_HALF_UP))
		params.put("creationExchangeRateUsdToPHPUrr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
		params.put("urr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
		params.put("USD-PHP_urr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))


		println "baseCurrency:"+baseCurrency
		if(!baseCurrency.toString().equalsIgnoreCase("PHP") && !baseCurrency.toString().equalsIgnoreCase("USD")){
			def thirdToUsd = foreignExchangeService.extractExchangeRateByBaseCurrencyAngol(ratesService.getRatesByBaseCurrency().display,params)
			println "thirdToUsd:"+thirdToUsd
			params.put(baseCurrency+"-USD",thirdToUsd.setScale(8,BigDecimal.ROUND_UP))
		}

		params.put("donotreset","Y")


		Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

		def sessionModel = returnedValues["details"]["details"]
		sessionModel << returnedValues["details"]["tradeServiceId"]
		sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
		sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

		chain(controller: "exportBillsPurchase", action: "viewSettlementDataEntry", model: sessionModel)
	}

	def updateSettlementDataEntry() {
		println"updateSettlementNegotiationDataEntry"
		params.unitcode = session.unitcode
		params.username = session.username
		
		println "params: " + params
		
		Map<String, Object> map = new HashMap<>()

		if ("charges".equals(params.form) && "DATA_ENTRY".equals(params.referenceType)) {
			map = exportBillsService.updateExportBillsDataEntry(params)
		} else {
			map = dataEntryService.updateDataEntry(params)
		}
		map.put("formName",tabUtilityService.getTabName(params.form))

		chain(controller: "exportBillsPurchase", action: "viewSettlementDataEntry", model: map)
	}

	def getExportAdvising() {
		Map returnedValues = coreAPIService.dummySendQuery([exlcAdviseNumber: params.exlcNumber], "getExportAdvising", "exportAdvising/").details

		render returnedValues as JSON
	}
	
	def updatePassOnRates() {
		render coreAPIService.dummySendQuery([passOnRateConfirmedByCash: params.passOnRateConfirmedByCash, tradeServiceId: params.tradeServiceId], "updateTradeServicePost", "tradeservice/") as JSON
	}
}
