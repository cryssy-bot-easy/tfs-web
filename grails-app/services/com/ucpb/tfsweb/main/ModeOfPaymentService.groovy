package com.ucpb.tfsweb.main

import org.junit.After;
import org.springframework.transaction.annotation.Transactional

class ModeOfPaymentService {

	def mdService
	def apService

	@Transactional(readOnly=true)
	def constructModesOfPayment(params) {
		println params
		def modesOfPayment = [:]

		//println"SETTLEMENT CURRENCY >> " + params.settlementCurrency
		println "FORM MROF " +params.form

		if(params.form.equalsIgnoreCase("#chargesPaymentTabForm")) { // for service charges
			if(params.serviceType.equalsIgnoreCase("CANCELLATION") && params.documentClass.equalsIgnoreCase("INDEMNITY")) {
				modesOfPayment << ["CASA": "Debit from CASA"]
				modesOfPayment << ["AP": "Apply AP"]
				modesOfPayment << ["AR": "Setup AR"]
				modesOfPayment << ["REMITTANCE": "Remittance / IBT"]

				if (params.settlementCurrency.equals("PHP")) {
					modesOfPayment << ["CASH": "Cash"]
					modesOfPayment << ["CHECK": "Check"]
				}
//			} else if(params.serviceType.equalsIgnoreCase("SETTLEMENT") && params.documentClass.equalsIgnoreCase("BC") && params.documentType.equalsIgnoreCase("FOREIGN")){//max
//			modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
//			modesOfPayment.put("CASH","Cash") //max if requested
//				modesOfPayment.remove("AR")
			}else {
				if (params.noAr) {
					modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
					modesOfPayment.remove("AR")
				} else {
					modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
				}
			}
		} else if((params.form.equalsIgnoreCase("#cashLcPaymentTabForm")) || (params.form.equalsIgnoreCase("#paymentDetailsTabForm")) || (params.form.equalsIgnoreCase("#productPaymentTabForm"))) {
			if((params.documentClass.equalsIgnoreCase("AP") && params.serviceType.equalsIgnoreCase("REFUND"))||(params.serviceType.equalsIgnoreCase("APPLICATION") && params.documentType.equalsIgnoreCase("REFUND"))) {
				modesOfPayment << ["CASA": "Credit to CASA"]
				modesOfPayment << ["MC_ISSUANCE": "Issuance to MC"]				
			} else if(params.documentClass.equalsIgnoreCase("AR") && params.serviceType.equalsIgnoreCase("SETTLE")) {
				modesOfPayment << ["CASA": "Debit from CASA"]
			
				if (params.settlementCurrency.equals("PHP")) {
					modesOfPayment << ["CASH": "Cash"]
					modesOfPayment << ["CHECK": "Check"]
				}
				modesOfPayment << ["AP": "Apply AP"]
				modesOfPayment << ["REMITTANCE": "Remittance / IBT"]
			} else {
		
			modesOfPayment = setupProceeds(modesOfPayment, params) // setup proceeds if proceeds is available
			
			if(params.serviceType.equalsIgnoreCase("NEGOTIATION")) {
				
				// Apply MD, apply to all Negotiation, except Usance.
				if(!params.documentSubType2.equalsIgnoreCase("USANCE")) {
					modesOfPayment << ["MD": "Apply MD"]
				}
				
				if(params.documentType.equalsIgnoreCase("FOREIGN")) {
					if(params.documentSubType1.equalsIgnoreCase("REGULAR")) {
						if(params.documentSubType2.equalsIgnoreCase("SIGHT")) {
							modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
							if (params.settlementCurrency in ['PHP', 'USD']){
								modesOfPayment << ["TR_LOAN": "TR Loan"]
								modesOfPayment << ["IB_LOAN": "IB Loan"]
							}
//                            modesOfPayment << ["MD": "Apply MD"]
							if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null) {
								modesOfPayment << ["MD": "Apply MD"]
							}
						} else if(params.documentSubType2.equalsIgnoreCase("USANCE")) {

							/*modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber)*/
							if (!params.settlementCurrency.equals("PHP")) {
								modesOfPayment = ["UA_LOAN": "UA Loan"]
							}
						}
					} else if(params.documentSubType1.equalsIgnoreCase("STANDBY")) {
						setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
						if (params.settlementCurrency in ['PHP', 'USD']){
							modesOfPayment << ["TR_LOAN": "TR Loan"]
							modesOfPayment << ["IB_LOAN": "IB Loan"]
						}
						modesOfPayment << ["MD": "Apply MD"]
					} else if(params.documentClass.equalsIgnoreCase("BP")) {
						modesOfPayment = ["EBP": "EBP Loan"]
					} else {
						modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
//                        modesOfPayment << ["MD": "Apply MD"]
						if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null && params.documentType.equals("FOREIGN")) {
							//printlnmdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0]
							modesOfPayment << ["MD": "Apply MD"]
						}
					}

				} else if(params.documentType.equalsIgnoreCase("DOMESTIC")) {
					if(params.documentSubType1.equalsIgnoreCase("REGULAR")) {
						if(params.documentSubType2.equalsIgnoreCase("SIGHT")) {
							modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
							if (params.settlementCurrency in ['PHP', 'USD']){
								modesOfPayment << ["DTR_LOAN": "DTR Loan"]

								modesOfPayment << ["DBP": "DBP Loan"]
							}

							if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null) {
								modesOfPayment << ["MD": "Apply MD"]
							}
						} else if(params.documentSubType2.equalsIgnoreCase("USANCE")) {
//                            modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)

//                            if (!params.settlementCurrency.equals("PHP")) {
								modesOfPayment << ["UA_LOAN": "DUA Loan"]
//                            }

							if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null) {
								modesOfPayment << ["MD": "Apply MD"]
							}
						}
					} else if(params.documentSubType1.equalsIgnoreCase("STANDBY")) {
						setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
						println 'params.settlementCurrency' + params.settlementCurrency
						if (params.settlementCurrency in ['PHP', 'USD']){
//	                        modesOfPayment << ["DTR_LOAN": "DTR Loan"]
							modesOfPayment << ["DBP": "DBP Loan"]
						}
						if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null) {
								modesOfPayment << ["MD": "Apply MD"]
						}
					} else if(params.documentClass.equalsIgnoreCase("BP")) {
						modesOfPayment = ["DBP": "DBP Loan"]
					} else {
						modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
					}
				}
			} else if(params.serviceType.equalsIgnoreCase("COLLECTION")) {
				if(params.documentClass.equalsIgnoreCase("MD")) {
					modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
					
//                    modesOfPayment << ["IBT_BRANCH": "IBT-Branch"]
				}
			} else if(params.serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT") || params.serviceType.equalsIgnoreCase("UA LOAN SETTLEMENT")) {
				modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
				
				if(params.settlementCurrency.equalsIgnoreCase("PHP") || params.settlementCurrency.equalsIgnoreCase("USD")) {
					if(params.documentType.equals("FOREIGN")){
						modesOfPayment << ["TR_LOAN": "TR Loan"]
					} else {
						modesOfPayment << ["DTR_LOAN": "DTR Loan"]
					}
				}

//                modesOfPayment << ["MD": "Apply MD"]
				if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null/* && params.documentType.equals("FOREIGN")*/) {
					modesOfPayment << ["MD": "Apply MD"]
				}
			} else if(params.serviceType.equalsIgnoreCase("SETTLEMENT") && (params.documentClass.equalsIgnoreCase('DA') || params.documentClass.equalsIgnoreCase('DP') || params.documentClass.equalsIgnoreCase('OA') || params.documentClass.equalsIgnoreCase('DR'))) {
				modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
				/*if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null && params.documentType.equals("FOREIGN")) {
					modesOfPayment << ["MD": "Apply MD"]
				}*/
				if(params.settlementMode.equalsIgnoreCase("TR")){
					modesOfPayment << ["TR_LOAN": "TR Loan"]
				} else if(params.settlementMode.equalsIgnoreCase("DTR")){
					modesOfPayment = ["TR_LOAN": "DTR Loan"]
				}

				if (mdService.getTotalMd(params.settlementCurrency, params.documentNumber)[0] != null && params.documentType.equals("FOREIGN")) {
					modesOfPayment << ["MD": "Apply MD"]
				}
			} else if (params.serviceType.equals("REFUND")) {
				modesOfPayment << ["CASA": "Credit to CASA"]
				modesOfPayment << ["MC_ISSUANCE": "Issuance to MC"]
			} else if(params.serviceType.equalsIgnoreCase("SETTLEMENT") && params.documentClass.equalsIgnoreCase("BC")) {
				modesOfPayment << ["CASA": "Debit From CASA"]
				modesOfPayment << ["REMITTANCE": "Remittance / IBT"]
				modesOfPayment << ["CASH": "Cash"]
		
				if (params.settlementCurrency.equals("PHP")) {
					modesOfPayment << ["CHECK": "Check"]
				}
			} else {
				modesOfPayment = setupDefaultMap(modesOfPayment, params.cifNumber, params.settlementCurrency)
			}
			}
		} else if(params.form.equalsIgnoreCase("#basicDetailsTabForm")) {

			if (params.documentClass.equalsIgnoreCase("CDT")) {
				modesOfPayment << ["CASH": "Cash"]
				modesOfPayment << ["CASA": "Debit From CASA"]
//				modesOfPayment << ["MC_ISSUANCE": "Issuance to MC"]
				modesOfPayment << ["CHECK": "Check"]
			}
		} else if(params.form.equalsIgnoreCase("#proceedsDetailsTabForm")){

			if (params.exportViaPddtsFlag && params.exportViaPddtsFlag == "1") {
				modesOfPayment << ["PDDTS": "Remittance via PDDTS"]
			} else if (params.exportViaPddtsFlag == "0" || !params.exportViaPddtsFlag) {
				modesOfPayment << ["CASA": "Credit to CASA"]
				if (params.documentClass in ["EXPORT_ADVANCE", "EXPORT_ADVISING", "BP", "BC"]){
					switch (params.settlementCurrency){
						case "USD":
							if (params.documentClass in ["EXPORT_ADVISING", "BP", "BC"]){
								modesOfPayment << ["PDDTS": "Remittance via PDDTS"]
								modesOfPayment << ["IBT_BRANCH": "IBT-Branch"]
							}
							break;
						case "PHP":
							modesOfPayment << ["MC_ISSUANCE": "Issuance to MC"]
							break;
						default:
							/*modesOfPayment << ["PDDTS": "Remittance via PDDTS"]*/
							modesOfPayment << ["IBT_BRANCH": "IBT-Branch"]
						
	/*modesOfPayment << ["SWIFT": "Remittance via SWIFT"]*/
							break;
					}
				} else if (params.serviceType.equalsIgnoreCase("REFUND") && params.documentClass in ["LC", "EXPORT_CHARGES","DA","DP","DR","OA"]) {
					modesOfPayment << ["CASA": "Credit to CASA"]
					modesOfPayment << ["REMITTANCE": "Remittance / IBT"]
					modesOfPayment << ["MC_ISSUANCE": "Issuance to MC"]
				} else {
					modesOfPayment << ["CASA": "Credit to CASA"]
					modesOfPayment << ["REMITTANCE": "Remittance / IBT"]
					switch (params.settlementCurrency){
						case "PHP":
							modesOfPayment << ["MC_ISSUANCE": "Issuance to MC"]
							if ("BC".equals(params.documentClass) && "SETTLEMENT".equals(params.serviceType)) {
								modesOfPayment << ["IBT_BRANCH": "IBT-Branch"]
							} else {
								modesOfPayment << ["PDDTS": "Remittance via PDDTS"]
								modesOfPayment << ["SWIFT": "Remittance via SWIFT"]
							}
							break;
						default:
							if ("BC".equals(params.documentClass) && "SETTLEMENT".equals(params.serviceType)) {
								modesOfPayment << ["IBT_BRANCH": "IBT-Branch"]
							} else {
								if(params.settlementCurrency.equals("USD")) {
									modesOfPayment << ["PDDTS": "Remittance via PDDTS"]
								}
								modesOfPayment << ["SWIFT": "Remittance via SWIFT"]

							}
					}
				}
			}
		}
		return modesOfPayment.sort {it.value}
	}
	
	Map<String, Object> setupDefaultMap(modesOfPayment, cifNumber, currency) {
		modesOfPayment << ["CASA": "Debit From CASA"]
		modesOfPayment << ["AR": "Setup AR"]
		modesOfPayment << ["REMITTANCE": "Remittance / IBT"]

		//if settlement currency is PHP, Cash or Check Payment is allowed. According to Bug 1488.
		if (currency.equals("PHP")) {
			modesOfPayment << ["CASH": "Cash"]
			modesOfPayment << ["CHECK": "Check"]
		}

		if (cifNumber) {
			List<Map<String, Object>> apAvailable = apService.findAllAccountsPayableByCifNumber(cifNumber, currency)

			if(apAvailable?.size() > 0) {
				modesOfPayment << ["AP": "Apply AP"]
			}
		}

		return modesOfPayment
	}

	Map<String, Object> setupProceeds(modesOfPayment, params) {
		if (params.form.equals("#proceedsDetailsTabForm")) {
			if ((params.serviceType.equalsIgnoreCase("NEGOTIATION") && params.documentType.equalsIgnoreCase("DOMESTIC") && (params.referenceType.equalsIgnoreCase("ETS") || params.referenceType.equalsIgnoreCase("DATA_ENTRY"))) ||
					((params.serviceType.equalsIgnoreCase("UA LOAN SETTLEMENT") || params.serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && (params.referenceType.equalsIgnoreCase("ETS") || params.referenceType.equalsIgnoreCase("DATA_ENTRY")))) {
				modesOfPayment << ["CASA": "Credit to CASA"]
				modesOfPayment << ["MC_ISSUANCE": "Issuance to MC"]
				modesOfPayment << ["SWIFT": "Remittance via SWIFT"]
				
				if(params.currency.equals("PHP") || params.currency.equals("USD")) {
					modesOfPayment << ["PDDTS": "Remittance via PDDTS"]
				}
			}
		}

		return modesOfPayment
	}
	
	
}