package com.ucpb.tfsweb.main
import grails.converters.JSON
import net.ipc.utils.DateUtils
import org.springframework.transaction.annotation.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.List;
import java.util.Map;

/*	PROLOGUE:
 *	(revision)
	SCR/ER Number: 20161128-114
	SCR/ER Description: Income not found in Allocation File for September 2016.
	[Revised by:] Lymuel Arrome Saul
	[Date revised:] 11/14/2016
	Program [Revision] Details: Included allocation unit code from the data/information to be retrieved from BG/BE Issuance upon creation of BG/BE Cancellation.
	Date deployment: 11/29/2016 
	Member Type: GROOVY
	Project: WEB
	Project Name: DocumentClassService.groovy
*/
/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: DocumentClassService
 */
/**  PROLOGUE:
 * 	(revision)
	Reference Number: ITDJCH-2018-03-001
	Reference Description: Add new fields on screen of different modules to comply with the requirements of ITRS.
	[Revised by:] Jaivee Hipolito
	Program [Revision:] add tinNumber, commodityCode and participantCode in Map(getLetterOfCredit & constructDocumentaryCredit methods).
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: DocumentClassService
 */



class DocumentClassService {

    def queryService

    def finder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class
    def apFinder = com.ucpb.tfs.application.query.settlementaccount.IAccountsPayableFinder.class
    def arFinder = com.ucpb.tfs.application.query.settlementaccount.IAccountsReceivableFinder.class

    def coreAPIService

    // evaluates parameters and returns controller and action
    Map<String,String> evaluateParameters(params) {
        switch (params.documentClass.toUpperCase()) {
            case "LC":
                if(params.serviceType.equalsIgnoreCase("NEGOTIATION")) {
                    return [controller:"lcEtsNegotiation", action: "viewNegotiation"]
                } else if(params.serviceType.equalsIgnoreCase("ADJUSTMENT")) {
                    return [controller:"lcEtsAdjustment", action: "viewAdjustment"]
                } else if(params.serviceType.equalsIgnoreCase("AMENDMENT")) {
                    return [controller:"lcEtsAmendment", action: "viewAmendment"]
                } else if(params.serviceType.equalsIgnoreCase("CANCELLATION")) {
                    return [controller:"lcEtsCancellation", action: "viewCancellation"]
                } else if(params.serviceType.equalsIgnoreCase("UA_LOAN_MATURITY_ADJUSTMENT")) {
                    return [controller:"lcEtsUaLoanMaturityAdjustment", action: "viewMaturityAdjustment"]
                } else if(params.serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) {
                    return [controller:"lcEtsUaLoanSettlement", action: "viewUaLoanSettlement"]
                }
            case "INDEMNITY":
                if(params.serviceType.equalsIgnoreCase("ISSUANCE")) {
                    return [controller:"lcEtsIndemnityIssuance", action: "viewIndemnityIssuance"]
                } else if(params.serviceType.equalsIgnoreCase("CANCELLATION")) {
                    return [controller: "lcDataEntryIndemnityCancellation", action: "viewIndemnityCancellation"]
                }
                break
            case "AP":
                if(params.serviceType.equalsIgnoreCase("SETUP")) {
                    return [controller:"apDataEntrySetup", action: "viewSetup"]
                } else if(params.serviceType.equalsIgnoreCase("APPLY")) {
                    return [controller:"apDataEntryApply", action: "viewApply"]
                } else if(params.serviceType.equalsIgnoreCase("REFUND")) {
                    return [controller:"apEtsRefund", action: "viewRefund"]
                }
            case "AR":
                if(params.serviceType.equalsIgnoreCase("SETTLE")) {
                    return [controller: "arEtsSettle", action: "viewSettle"]
                }
				break
			case "DA":
				if(params.serviceType.equalsIgnoreCase("SETTLEMENT")) {
					return [controller: "daEtsSettlement", action: "viewSettlement"]
				}
				break
			case "DP":
				if(params.serviceType.equalsIgnoreCase("SETTLEMENT")) {
					return [controller: "dpEtsSettlement", action: "viewSettlement"]
				}
				break
			case "OA":
				if(params.serviceType.equalsIgnoreCase("SETTLEMENT")) {
					return [controller: "oaEtsSettlement", action: "viewSettlement"]
				}
				break
			case "DR":
				if(params.serviceType.equalsIgnoreCase("SETTLEMENT")) {
					return [controller: "drEtsSettlement", action: "viewSettlement"]
				}
				break
				
        }
    }

    Map<String,String> evaluateParametersTsdInitiated(params) {
        switch (params.documentClass.toUpperCase()) {
            case "LC":
                if(params.serviceType?.equalsIgnoreCase("ADJUSTMENT")) {
                    return [controller:"lcDataEntryAdjustment", action: "viewAdjustment"]
                } else if(params.serviceType?.equalsIgnoreCase("AMENDMENT")) {
                    return [controller:"lcDataEntryAmendment", action: "viewAmendment"]
                } else if(params.serviceType?.equalsIgnoreCase("NEGOTIATION_DISCREPANCY")){
                     return [controller:"lcDataEntryNegotiationDiscrepancy", action: "viewNegotiationDiscrepancy"]
                }
				break;
			case "DA":
				if(params.serviceType.equalsIgnoreCase("NEGOTIATION ACCEPTANCE")) {
					return [controller:"daDataEntryNegotiationAcceptance", action: "viewNegotiationAcceptance"]
				} else if(params.serviceType.equalsIgnoreCase("CANCELLATION")) {
					return [controller:"daDataEntryCancellation", action:"viewCancellation"]
				}
				break;
			case "DP":
				if(params.serviceType.equalsIgnoreCase("CANCELLATION")) {
					return [controller:"dpDataEntryCancellation", action:"viewCancellation"]
					break;
				}
			case "OA":
				if(params.serviceType.equalsIgnoreCase("CANCELLATION")) {
					return [controller:"oaDataEntryCancellation", action:"viewCancellation"]
				}
				break;
			case "DR":
				if(params.serviceType.equalsIgnoreCase("CANCELLATION")) {
					return [controller:"drDataEntryCancellation", action:"viewCancellation"]
				}
				break;
        }
    }

    Map<String, Object> getLetterOfCreditCriteria(documentNumber) {
        // sets method name and parameters
            String methodName = "findLetterOfCreditCriteria"

        Map<String, Object> param = [documentNumber: documentNumber]

        // refactored to use new webservice
        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
        return constructLetterOfCreditCriteria(queryResult[0])

//        Map<String, Object> queryResult = coreAPIService.dummySendQuery(null, (String) documentNumber, "product/", "lc/", "details/")
//
//        if(((String)(queryResult["status"])).equalsIgnoreCase("ok")) {
//
//            Map lcMap = queryResult["details"]
//            // we don't store the subtypes in the details but it is in type
//            lcMap.put("documentSubType1", lcMap["type"])
//
//            return queryResult["details"]
//
//        } else {
//            return []
//        }

    } 
    
    Map<String, Object> constructLetterOfCreditCriteria(Map<String, Object> queryResult) {
        ////println'constructing letter of credit criteria...'
        Map<String, Object> lcCriteria = new HashMap<String, Object>()
        
        lcCriteria.put("tradeServiceId", queryResult.TRADESERVICEID)
        lcCriteria.put("documentClass", queryResult.DOCUMENTCLASS)
        lcCriteria.put("documentType", queryResult.DOCUMENTTYPE)
        lcCriteria.put("documentSubType1", queryResult.DOCUMENTSUBTYPE1)
        lcCriteria.put("documentSubType2", queryResult.DOCUMENTSUBTYPE2)
        lcCriteria.put("documentNumber", queryResult.DOCUMENTNUMBER)
        lcCriteria.put("productAmount", queryResult.PRODUCTAMOUNT)
        lcCriteria.put("productStatus", queryResult.PRODUCTSTATUS)
        lcCriteria.put("outstandingBalance", queryResult.OUTSTANDINGBALANCE)
        lcCriteria.put("bgCount", queryResult.BGCOUNT)
        lcCriteria.put("icCount", queryResult.ICCOUNT)

        return lcCriteria
    }

    // find approved letter of credit
    Map<String, Object> getLetterOfCredit(documentNumber, documentClass) {
        println "getLetterOfCredit"
        // sets method name and parameters
        String methodName = "findLetterOfCredit"

//        Map<String, Object> param = [tradeServiceId: tradeServiceId]
//        Map<String, Object> param = [documentNumber: documentNumber]
//        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
//        return constructLetterOfCredit(queryResult[0])

        Map<String, Object> queryResult = coreAPIService.dummySendQuery(null, (String) documentNumber, "product/", "lc/", "details/")

        if(((String)(queryResult["status"])).equalsIgnoreCase("ok")) {

            Map lcMap = queryResult["details"]
			println "lcMap: "+lcMap
            DateFormat df = new SimpleDateFormat("M/dd/yyyy")
            // some fields are embedded classes so we have to get the values from the inner class property
            lcMap.put("documentSubType1", lcMap["type"])
            lcMap.put("documentSubType2", lcMap["tenor"])
			//added by Henry -Start
			lcMap.put("expiredStatus", lcMap["status"])
			//end
			println lcMap.get("expiredStatus");
            if (lcMap["documentNumber"] != null) {
                lcMap.put("documentNumber", lcMap["documentNumber"]["documentNumber"])
            } else {
                lcMap.put("documentNumber", null)
            }
			
			if (lcMap["destinationBank"] != null) {
				lcMap.put("defaultNegotiationBankForNegoDiscrepancy", lcMap["destinationBank"])
			} else {
                lcMap.put("defaultNegotiationBankForNegoDiscrepancy", null)
            }
//            if (lcMap["documentNumber"] != null) {
//                lcMap.put("tradeProductNumber", lcMap["documentNumber"]["documentNumber"])
//            } else {
//                lcMap.put("tradeProductNumber", null)
//            }

            if (lcMap["currency"] != null) {
                lcMap.put("currency", lcMap["currency"]["currencyCode"])
            } else {
                lcMap.put("currency", null)
            }

            if (lcMap["reimbursingCurrency"] != null) {
                lcMap.put("reimbursingCurrency", lcMap["reimbursingCurrency"]["currencyCode"])
            } else {
                lcMap.put("reimbursingCurrency", null)
            }

            lcMap.put("expiryDate", lcMap["expiryDate"] ? df.format(new Date(lcMap["expiryDate"])) : null)
            lcMap.put("latestShipmentDate", lcMap["latestShipmentDate"] ? df.format(new Date(lcMap["latestShipmentDate"])) : null)

            if (lcMap["processingUnitCode"] == null) {  // For migrated data
                lcMap.put("processingUnitCode", "909")
            }

            lcMap.put("originalAmount", lcMap["amount"])
            lcMap.put("amountNegotiated", lcMap["totalNegotiatedAmount"])

            BigDecimal productAmount00 = lcMap["amount"] ?: 0
            lcMap.put("productAmount", productAmount00.setScale(2,BigDecimal.ROUND_FLOOR))

            if (documentClass?.equals("INDEMNITY")) {
                lcMap.put("referenceNumber", lcMap["documentNumber"])
            } else {
                lcMap.put("documentNumber", lcMap["documentNumber"])
            }

            lcMap.put("advanceCorresChargesFlag", lcMap["advanceCorresChargesFlag"] ? lcMap["advanceCorresChargesFlag"] == 1 ? "Y" : "N" : null)
            lcMap.put("adviseThroughBank", lcMap["adviseThroughBank"] ? lcMap["adviseThroughBank"] == 1 ? "Y" : "N" : null)

            lcMap.put("cancellationDate", lcMap["cancellationDate"] ? df.format(new Date(lcMap["cancellationDate"])) : null)

            BigDecimal cashAmount = lcMap["cashAmount"] ?: 0
            BigDecimal totalNegotiatedCashAmount = lcMap["totalNegotiatedCashAmount"] ?: 0
            println "############"
            println "CASH AMOUNT : " + cashAmount
            println "TOTAL NEGOTIATED CASH AMOUNT : " + totalNegotiatedCashAmount
            println "############"
            println "CASH AMOUNT ANGOL:::"+(cashAmount == 0) ? 0 : (cashAmount - totalNegotiatedCashAmount)
            BigDecimal cashAmount00 = (cashAmount == 0) ? 0 : (cashAmount - totalNegotiatedCashAmount)
            println "CASH AMOUNT 00 : ROUND_HALF_UP" + cashAmount00.setScale(2,BigDecimal.ROUND_HALF_UP)
            println "CASH AMOUNT 00 : ROUND_FLOOR" + cashAmount00.setScale(2,BigDecimal.ROUND_FLOOR)
            println "###########"
            lcMap.put("cashAmount", cashAmount00.setScale(2,BigDecimal.ROUND_HALF_UP))

            lcMap.put("cashAmount00", cashAmount00)
            lcMap.put("cashAmount00ROUNDFLOOR", cashAmount00.setScale(2,BigDecimal.ROUND_HALF_UP))

            lcMap.put("cashAmountORIG", lcMap["cashAmount"] ?: 0)
            lcMap.put("totalNegotiatedCashAmountORIG", lcMap["totalNegotiatedCashAmount"] ?: 0)

            lcMap.put("totalNegotiatedCashAmount", lcMap["totalNegotiatedCashAmount"])

            lcMap.put("irrevocable", lcMap["irrevocable"] ? lcMap["irrevocable"] == 1 ? "Y" : "N" : null)
            lcMap.put("issueDate", lcMap["issueDate"] ? df.format(new Date(lcMap["issueDate"])) : null)
            lcMap.put("latestDateShipment", lcMap["latestDateShipment"] ? df.format(new Date(lcMap["latestDateShipment"])): null)

//            lcMap.put("confirmationInstructionsFlag", lcMap["confirmationInstructionsFlag"] ? lcMap["confirmationInstructionsFlag"] == 1 ? "Y" : "N" : null)
            lcMap.put("confirmationInstructionsFlag", lcMap["confirmationInstructionsFlag"] ?: null)
            lcMap.put("cumulative", lcMap["cumulative"] ? lcMap["cumulative"] == 1 ? "Y" : "N" : null)
            lcMap.put("cwtFlag", lcMap["cwtFlag"] ? lcMap["cwtFlag"] == 1 || true == lcMap["cwtFlag"] ? "Y" : "N" : null)

            lcMap.put("negotiationRestriction", lcMap["negotiationRestriction"] ? lcMap["negotiationRestriction"] == 1 ? "Y" : "N" : null)

            println "outstanding balance angol:::" +lcMap["outstandingBalance"]
            println "outstanding balance angol:::" +lcMap["outstandingBalance"].toString()
            BigDecimal outstandingBalance = new BigDecimal(lcMap["outstandingBalance"].toString())
            println "outstandingBalance object angol :::"+outstandingBalance
            lcMap.put("outstandingBalance", outstandingBalance)
            lcMap.put("numberOfAmendments", lcMap["numberOfAmendments"] ? lcMap["numberOfAmendments"].intValue() + 1 : 1)
			lcMap.put("narrative", lcMap["narrative"])
            //printlnlcMap.numberOfAmendments
			
			
			if(lcMap["expiryDate"]){
				lcMap.put("remainingDays", (new Date(lcMap["expiryDate"]) - new Date()))
			}
			
            lcMap.put("tinNumber", lcMap["tinNumber"] ? lcMap["tinNumber"].toString().trim() : null)
            lcMap.put("commodityCode", lcMap["commodityCode"])
            lcMap.put("participantCode", lcMap["participantCode"])
				
            return lcMap

        } else {
            return [:]
        }

/*
        Map<String, Object> param = [documentNumber: documentNumber]
        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
        return constructLetterOfCredit(queryResult[0], documentClass)
*/
    }
    
    // constructs letter of credit field values
    Map<String, Object> constructLetterOfCredit(Map<String, Object> queryResult, String documentClass) {
        ////println'constructing letter of credit...'
        Map<String, Object> letterOfCredit = new HashMap<String, Object>()

        Map<String, Object> details = JSON.parse(queryResult.DETAILS)

        details.each {
            if (!it.key.equalsIgnoreCase("etsDate") && !it.key.equalsIgnoreCase("processDate")) {
                ////printlnit.key + " >> " + it.value

                letterOfCredit.put(it.key, it.value)
            }
        }

        BigDecimal productAmount = queryResult.CURRENTAMOUNT ?:0
        letterOfCredit.put("productAmount", productAmount)

        letterOfCredit.put("icCount", queryResult.ICCOUNT)
//        letterOfCredit.put("tradeServiceId", queryResult.TRADESERVICEID)
        //println"documentClass >> " + documentClass
        letterOfCredit.put("etsNumber", queryResult.SERVICEINSTRUCTIONID)
        if (documentClass?.equals("INDEMNITY")) {
            letterOfCredit.put("referenceNumber", queryResult.DOCUMENTNUMBER)
        } else {
            letterOfCredit.put("documentNumber", queryResult.DOCUMENTNUMBER)
        }

        letterOfCredit.put("status", queryResult.STATUS)

        letterOfCredit.put("serviceType", queryResult.SERVICETYPE)
        letterOfCredit.put("documentClass", queryResult.DOCUMENTCLASS)
        letterOfCredit.put("documentSubType1", queryResult.DOCUMENTSUBTYPE1)
        letterOfCredit.put("documentSubType2", queryResult.DOCUMENTSUBTYPE2)

        letterOfCredit.put("additionalAmountsCovered", queryResult.ADDITIONALAMOUNTSCOVERED)
        letterOfCredit.put("advanceCorresChargesFlag", queryResult.ADVANCECORRESCHARGESFLAG ? queryResult.ADVANCECORRESCHARGESFLAG == 1 ? "Y" : "N" : null)
        letterOfCredit.put("adviseMedium", queryResult.ADVISEMEDIUM)
        letterOfCredit.put("adviseThroughBank", queryResult.ADVISETHROUGHBANK ? queryResult.ADVISETHROUGHBANK == 1 ? "Y" : "N" : null)
        letterOfCredit.put("adviseThroughBankFlag", queryResult.ADVISETHROUGHBANKFLAG)
        letterOfCredit.put("adviseThroughBankIdentifierCode", queryResult.ADVISETHROUGHBANKIDENTIFIERCODE)
        letterOfCredit.put("adviseThroughBankLocation", queryResult.ADVISETHROUGHBANKLOCATION)
        letterOfCredit.put("adviseThroughBankNameAndAddress", queryResult.ADVISETHROUGHBANKNAMEANDADDRESS)
        letterOfCredit.put("advisingBankCode", queryResult.ADVISINGBANKCODE)
        letterOfCredit.put("aggregateAmount", queryResult.AGGREGATEAMOUNT)

//        letterOfCredit.put("amountNegotiated", queryResult.AMOUNTNEGOTIATED)
        letterOfCredit.put("amountNegotiated", queryResult.TOTALNEGOTIATEDAMOUNT)

        letterOfCredit.put("applicableRules", queryResult.APPLICABLERULES)
        letterOfCredit.put("applicantAddress", queryResult.APPLICANTADDRESS)
        letterOfCredit.put("applicantName", queryResult.APPLICANTNAME)
        letterOfCredit.put("availableBy", queryResult.AVAILABLEBY)
        letterOfCredit.put("availableWith", queryResult.AVAILABLEWITH)
        letterOfCredit.put("availableWithFlag", queryResult.AVAILABLEWITHFLAG)
        letterOfCredit.put("beneficiaryAddress", queryResult.BENEFICIARYADDRESS)
        letterOfCredit.put("beneficiaryName", queryResult.BENEFICIARYNAME)
        letterOfCredit.put("bspCountryCode", queryResult.BSPCOUNTRYCODE)
        letterOfCredit.put("cancellationDate", DateUtils.shortDateFormat(queryResult.CANCELLATIONDATE))

        BigDecimal cashAmount = queryResult.CASHAMOUNT ?: 0
        BigDecimal totalNegotiatedCashAmount = queryResult.TOTALNEGOTIATEDCASHAMOUNT ?: 0

        BigDecimal cashAmount00 = (cashAmount == 0) ? 0 : (cashAmount - totalNegotiatedCashAmount)
        letterOfCredit.put("cashAmount", cashAmount00.toPlainString())
        letterOfCredit.put("cashFlag", queryResult.CASHFLAG)
        letterOfCredit.put("totalNegotiatedCashAmount", queryResult.TOTALNEGOTIATEDCASHAMOUNT)

        letterOfCredit.put("confirmationInstructionsFlag", queryResult.CONFIRMATIONINSTRUCTIONSFLAG ? queryResult.CONFIRMATIONINSTRUCTIONSFLAG == 1 ? "Y" : "N" : null)
        letterOfCredit.put("confirmingBankCode", queryResult.CONFIRMINGBANKCODE)
        letterOfCredit.put("cumulative", queryResult.CUMULATIVE ? queryResult.CUMULATIVE == 1 ? "Y" : "N" : null)
        letterOfCredit.put("cwtFlag", queryResult.CWTFLAG ? queryResult.CWTFLAG == 1 ? "Y" : "N" : null)
        letterOfCredit.put("daysRevolving", queryResult.DAYSREVOLVING)
        letterOfCredit.put("deferredPaymentDetails", queryResult.DEFERREDPAYMENTDETAILS)
        letterOfCredit.put("destinationBank", queryResult.DESTINATIONBANK)
        letterOfCredit.put("detailsOfGuarantee", queryResult.DETAILSOFGUARANTEE)
        letterOfCredit.put("dispatchPlace", queryResult.DISPATCHPLACE)
        letterOfCredit.put("documentType", queryResult.DOCUMENTTYPE)
        letterOfCredit.put("drawee", queryResult.DRAWEE)
        letterOfCredit.put("expiryCountryCode", queryResult.EXPIRYCOUNTRYCODE)
        letterOfCredit.put("expiryDate", DateUtils.shortDateFormat(queryResult.EXPIRYDATE))
        letterOfCredit.put("exporterAddress", queryResult.EXPORTERADDRESS)
        letterOfCredit.put("exporterCbCode", queryResult.EXPORTERCBCODE)
        letterOfCredit.put("exporterName", queryResult.EXPORTERNAME)
        letterOfCredit.put("finalDestinationPlace", queryResult.FINALDESTINATIONPLACE)
        letterOfCredit.put("formatType", queryResult.FORMATTYPE)
        letterOfCredit.put("formOfDocumentaryCredit", queryResult.FORMOFDOCUMENTARYCREDIT)
        letterOfCredit.put("furtherIdentification", queryResult.FURTHERIDENTIFICATION)
        letterOfCredit.put("generalDescriptionOfGoods", queryResult.GENERALDESCRIPTIONOFGOODS)
        letterOfCredit.put("identifierCode", queryResult.IDENTIFIERCODE)
        letterOfCredit.put("importerAddress", queryResult.IMPORTERADDRESS)
        letterOfCredit.put("importerCbCode", queryResult.IMPORTERCBCODE)
        letterOfCredit.put("importerCifNumber", queryResult.IMPORTERCIFNUMBER)
        letterOfCredit.put("importerName", queryResult.IMPORTERNAME)
        letterOfCredit.put("irrevocable", queryResult.IRREVOCABLE ? queryResult.IRREVOCABLE == 1 ? "Y" : "N" : null)
        letterOfCredit.put("issueDate", DateUtils.shortDateFormat(queryResult.ISSUEDATE))
        letterOfCredit.put("latestDateShipment", DateUtils.shortDateFormat(queryResult.LATESTDATESHIPMENT))
        letterOfCredit.put("latestShipmentDate", DateUtils.shortDateFormat(queryResult.LATESTSHIPMENTDATE))
        letterOfCredit.put("marineInsurance", queryResult.MARINEINSURANCE)
        letterOfCredit.put("maximumCreditAmount", queryResult.MAXIMUMCREDITAMOUNT)
        letterOfCredit.put("mixedPaymentDetails", queryResult.MIXEDPAYMENTDETAILS)
        letterOfCredit.put("nameAndAddress", queryResult.NAMEANDADDRESS)
        letterOfCredit.put("negativeToleranceLimit", queryResult.NEGATIVETOLERANCELIMIT)
        letterOfCredit.put("negotiationRestriction", queryResult.NEGOTIATIONRESTRICTION ? queryResult.NEGOTIATIONRESTRICTION == 1 ? "Y" : "N" : null)
        letterOfCredit.put("otherDocumentsInstructions", queryResult.OTHERDOCUMENTSINSTRUCTIONS)
        letterOfCredit.put("otherPriceTerm", queryResult.OTHERPRICETERM)

        // this is the lc amount for all other service types except opening
        BigDecimal outstandingBalance = queryResult.OUTSTANDINGBALANCE ?:0
        letterOfCredit.put("outstandingBalance", outstandingBalance)

        letterOfCredit.put("partialDelivery", queryResult.PARTIALDELIVERY)
        letterOfCredit.put("partialShipment", queryResult.PARTIALSHIPMENT)
        letterOfCredit.put("paymentMode", queryResult.PAYMENTMODE)
        letterOfCredit.put("periodForPresentation", queryResult.PERIODFORPRESENTATION)
        letterOfCredit.put("placeOfDelivery", queryResult.PLACEOFDELIVERY)
        letterOfCredit.put("placeOfFinalDestination", queryResult.PLACEOFFINALDESTINATION)
        letterOfCredit.put("placeOfReceipt", queryResult.PLACEOFRECEIPT)
        letterOfCredit.put("placeOfTakingDispatchOrReceipt", queryResult.PLACEOFTAKINGDISPATCHORRECEIPT)
        letterOfCredit.put("portOfDestination", queryResult.PORTOFDESTINATION)
        letterOfCredit.put("portOfDischargeOrDestination", queryResult.PORTOFDISCHARGEORDESTINATION)
        letterOfCredit.put("portOfLoadingOrDeparture", queryResult.PORTOFLOADINGORDEPARTURE)
        letterOfCredit.put("portOfOriginCountryCode", queryResult.PORTOFORIGINCOUNTRYCODE)
        letterOfCredit.put("portOfOrigination", queryResult.PORTOFORIGINATION)
        letterOfCredit.put("positiveToleranceLimit", queryResult.POSITIVETOLERANCELIMIT)
        letterOfCredit.put("priceTerm", queryResult.PRICETERM)
        letterOfCredit.put("priceTermNarrative", queryResult.PRICETERMNARRATIVE)
        letterOfCredit.put("processDate", DateUtils.shortDateFormat(queryResult.PROCESSDATE))
        letterOfCredit.put("purpose", queryResult.PURPOSE)
        letterOfCredit.put("purposeOfStandby", queryResult.PURPOSEOFSTANDBY)
        letterOfCredit.put("reasonForCancellation", queryResult.REASONFORCANCELLATION)
        letterOfCredit.put("reimbursingAccountType", queryResult.REIMBURSINGACCOUNTTYPE)
        letterOfCredit.put("reimbursingBankAccountNumber", queryResult.REIMBURSINGBANKACCOUNTNUMBER)
        letterOfCredit.put("reimbursingBankFlag", queryResult.REIMBURSINGBANKFLAG)
        letterOfCredit.put("reimbursingBankIdentifierCode", queryResult.REIMBURSINGBANKIDENTIFIERCODE)
        letterOfCredit.put("reimbursingBankNameAndAddress", queryResult.REIMBURSINGBANKNAMEANDADDRESS)
        letterOfCredit.put("reimbursingCurrency", queryResult.REIMBURSINGCURRENCY)
        letterOfCredit.put("revolvingAmount", queryResult.REVOLVINGAMOUNT)
        letterOfCredit.put("revolvingPeriod", queryResult.REVOLVINGPERIOD)
        letterOfCredit.put("senderToReceiverInformation", queryResult.SENDERTORECEIVERINFORMATION)
        letterOfCredit.put("senderToReceiverInformationNarrative", queryResult.SENDERTORECEIVERINFORMATIONNARRATIVE)
        letterOfCredit.put("shipmentSequenceNumber", queryResult.SHIPMENTCOUNT)
        letterOfCredit.put("shipmentPeriod", queryResult.SHIPMENTPERIOD)
        letterOfCredit.put("standbyTagging", queryResult.STANDBYTAGGING)
        letterOfCredit.put("tenor", queryResult.TENOR)
        letterOfCredit.put("tenorOfDraftNarrative", queryResult.TENOROFDRAFTNARRATIVE)
        letterOfCredit.put("transShipment", queryResult.TRANSSHIPMENT)
        letterOfCredit.put("type", queryResult.TYPE)
        letterOfCredit.put("usancePeriod", queryResult.USANCEPERIOD)
        letterOfCredit.put("usancePeriodStart", queryResult.USANCEPERIODSTART)

        letterOfCredit.put("productStatus", queryResult.PRODUCTSTATUS)
        letterOfCredit.put("tradeServiceReferenceNumber", queryResult.TRADESERVICEREFERENCENUMBER)
        letterOfCredit.put("originalAmount", queryResult.ORIGINALAMOUNT)

        letterOfCredit.put("numberOfAmendments", queryResult.NUMBEROFAMENDMENTS ?: "0")

        letterOfCredit.put("cifNumber", queryResult.CIFNUMBER)
        letterOfCredit.put("cifName", queryResult.CIFNAME)
        letterOfCredit.put("accountOfficer", queryResult.ACCOUNTOFFICER)
        letterOfCredit.put("ccbdBranchUnitCode", queryResult.CCBDBRANCHUNITCODE)
        letterOfCredit.put("allocationUnitCode", queryResult.ALLOCATIONUNITCODE)
        letterOfCredit.put("longName", queryResult.LONGNAME)
        letterOfCredit.put("address1", queryResult.ADDRESS1)
        letterOfCredit.put("address2", queryResult.ADDRESS2)
        letterOfCredit.put("facilityId", queryResult.FACILITYID)
        letterOfCredit.put("facilityType", queryResult.FACILITYTYPE)

        letterOfCredit.put("narrative", queryResult.NARRATIVE)

        return letterOfCredit
    }

    // find approved non letter of credit
    Map<String, Object> getDocumentaryCredit(documentNumber, documentClass, serviceType) {
        // sets method name and parameters
        //printlndocumentClass
        String methodName = ""
		//println"THIS IS " + documentClass + " " + documentNumber
		switch(documentClass){
			case "DA":
				methodName = "findDocumentAgainstAcceptance"
			break;
			case "DP":
				methodName = "findDocumentAgainstPayment"
			break;
			case "OA":
				methodName = "findOpenAccount"
			break;
			case "DR":
				methodName = "findDirectRemittance"
			break;
		}
		//printlnmethodName
        Map<String, Object> param = [documentNumber: documentNumber]
		//printlnparam
        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
        return constructDocumentaryCredit(queryResult[0])
    }
    
    // constructs nom letter of credit field values
    Map<String, Object> constructDocumentaryCredit(Map<String, Object> queryResult) {
        ////println'constructing letter of credit...'
        Map<String, Object> documentaryCredit = new HashMap<String, Object>()
		////println"query map = " +queryResult
        /*Map<String, Object> details = JSON.parse(queryResult.DETAILS)

        details.each {
            if (!it.key.equalsIgnoreCase("processDate")) {
                //printlnit.key + " >> " + it.value

                documentaryCredit.put(it.key, it.value)
            }
        }*/
		
		documentaryCredit.put("documentNumber", queryResult.DOCUMENTNUMBER)
		documentaryCredit.put("remittingBank", queryResult.REMITTINGBANK)
        documentaryCredit.put("reimbursingBank", queryResult.REIMBURSINGBANK)
		documentaryCredit.put("processDate", queryResult.PROCESSDATE)
		documentaryCredit.put("remittingBankReferenceNumber", queryResult.REMITTINGBANKREFERENCENUMBER)
		documentaryCredit.put("currency", queryResult.CURRENCY)
        // added key negotiationCurrency for the basic details in ets non-lc settlement
        documentaryCredit.put("negotiationCurrency", queryResult.CURRENCY)
		documentaryCredit.put("amount", queryResult.AMOUNT)
		documentaryCredit.put("outstandingAmount", queryResult.OUTSTANDINGAMOUNT)
		documentaryCredit.put("mainCifNumber", queryResult.MAINCIFNUMBER)
		documentaryCredit.put("mainCifName", queryResult.MAINCIFNAME)
		documentaryCredit.put("dateOfBlAirwayBill", queryResult.DATEOFBLAIRWAYBILL)
		documentaryCredit.put("maturityDate", queryResult.MATURITYDATE ? DateUtils.shortDateFormat(queryResult.MATURITYDATE) : '')
		documentaryCredit.put("importerCifNumber", queryResult.IMPORTERCIFNUMBER)
		documentaryCredit.put("originalPort", queryResult.ORIGINALPORT)
		documentaryCredit.put("importerCbCode", queryResult.IMPORTERCBCODE)
		documentaryCredit.put("importerName", queryResult.IMPORTERNAME)
		documentaryCredit.put("importerAddress", queryResult.IMPORTERADDRESS)
		documentaryCredit.put("senderToReceiverInformation", queryResult.SENDERTORECEIVERINFORMATION)
		documentaryCredit.put("beneficiaryName", queryResult.BENEFICIARYNAME)
		documentaryCredit.put("beneficiaryAddress", queryResult.BENEFICIARYADDRESS)
		documentaryCredit.put("lastTransaction", queryResult.LASTTRANSACTION)
		documentaryCredit.put("productAmount", queryResult.PRODUCTAMOUNT)
		documentaryCredit.put("productStatus", queryResult.PRODUCTSTATUS)
		documentaryCredit.put("originalAmount", queryResult.ORIGINALAMOUNT)
		documentaryCredit.put("cifNumber", queryResult.CIFNUMBER)
		documentaryCredit.put("cifName", queryResult.CIFNAME)
		documentaryCredit.put("accountOfficer", queryResult.ACCOUNTOFFICER)
		documentaryCredit.put("ccbdBranchUnitCode", queryResult.CCBDBRANCHUNITCODE)
		documentaryCredit.put("allocationUnitCode", queryResult.ALLOCATIONUNITCODE)
		documentaryCredit.put("longName", queryResult.LONGNAME)
		documentaryCredit.put("address1", queryResult.ADDRESS1)
		documentaryCredit.put("address2", queryResult.ADDRESS2)
		documentaryCredit.put("documentClass", queryResult.DOCUMENTCLASS)
		documentaryCredit.put("documentType", queryResult.DOCUMENTTYPE)
		documentaryCredit.put("serviceType", queryResult.SERVICETYPE)
		documentaryCredit.put("tsNumber", queryResult.TRADESERVICEREFERENCENUMBER)
		documentaryCredit.put("status", queryResult.STATUS)
		documentaryCredit.put("processingUnitCode", queryResult.PROCESSINGUNITCODE)
        
        documentaryCredit.put("firstName", queryResult.FIRSTNAME)
        documentaryCredit.put("middleName", queryResult.MIDDLENAME)
        documentaryCredit.put("lastName", queryResult.LASTNAME)
        documentaryCredit.put("tinNumber", queryResult.TINNUMBER)
        documentaryCredit.put("officerCode", queryResult.OFFICERCODE)
        documentaryCredit.put("exceptionCode", queryResult.EXCEPTIONCODE)
		
        documentaryCredit.put("tinNumber", queryResult.TINNUMBER)
        documentaryCredit.put("commodityCode", queryResult.COMMODITYCODE)
        documentaryCredit.put("participantCode", queryResult.PARTICIPANTCODE)
		
		//println"documentary credit = " +documentaryCredit
		return documentaryCredit
    }

    // find approved indemnity
    Map<String, Object> getIndemnity(referenceNumber, indemnityNumber) {
        // sets method name and parameters
        String methodName = "findIndemnity"

        Map<String, Object> param = [referenceNumber: referenceNumber,
			indemnityNumber: indemnityNumber]
		println "param: " + param
        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

        return constructIndemnity(queryResult[0])
    }
    
    // constructs indemnity field values
    Map<String, Object> constructIndemnity(Map<String, Object> queryResult) {
        ////println'constructing indemnity...'
        Map<String, Object> indemnity = new HashMap<String, Object>()

//        Map<String, Object> details = JSON.parse(queryResult.DETAILS)

        /*details.each {
            if(!it.key.equalsIgnoreCase("tradeServiceId") && !it.key.equalsIgnoreCase("etsDate") && !it.key.equalsIgnoreCase("processDate")) {
                indemnity.put(it.key, it.value)
            }
        }*/

//        indemnity.put("tradeServiceId", queryResult.TRADESERVICEID)
        indemnity.put("documentNumber", queryResult.DOCUMENTNUMBER)
        indemnity.put("serviceType", queryResult.SERVICETYPE)
        indemnity.put("documentType", queryResult.DOCUMENTTYPE)
        indemnity.put("documentClass", queryResult.DOCUMENTCLASS)
        indemnity.put("documentSubType1", queryResult.DOCUMENTSUBTYPE1)
        indemnity.put("documentSubType2", queryResult.DOCUMENTSUBTYPE2)
        indemnity.put("cifName", queryResult.CIFNAME)
        indemnity.put("cifNumber", queryResult.CIFNUMBER)
        indemnity.put("ccbdBranchUnitCode", queryResult.CCBDBRANCHUNITCODE)
        indemnity.put("accountOfficer", queryResult.ACCOUNTOFFICER)
        indemnity.put("status", queryResult.STATUS)
        indemnity.put("longName", queryResult.LONGNAME)
        indemnity.put("address1", queryResult.ADDRESS1)
        indemnity.put("address2", queryResult.ADDRESS2)

        indemnity.put("indemnityNumber", queryResult.INDEMNITYNUMBER)

        indemnity.put("blAirwayBillNumber", queryResult.BLAIRWAYBILLNUMBER)
        indemnity.put("blPresented", queryResult.BLPRESENTED)
        indemnity.put("cancellationDate", DateUtils.shortDateFormat(queryResult.CANCELLATIONDATE))
        indemnity.put("cwtFlag", queryResult.CWTFLAG ? queryResult.CWTFLAG == 1 ? "Y" : "N" : null)
        indemnity.put("documentReleaseDate", DateUtils.shortDateFormat(queryResult.DOCUMENTRELEASEDATE))
        indemnity.put("facilityId", queryResult.FACILITYID)
        indemnity.put("indemnityIssueDate", DateUtils.shortDateFormat(queryResult.INDEMNITYISSUEDATE))
        indemnity.put("processDate", DateUtils.shortDateFormat(queryResult.PROCESSDATE))
        indemnity.put("referenceNumber", queryResult.REFERENCENUMBER)
        indemnity.put("shipmentAmount", queryResult.SHIPMENTAMOUNT)
        indemnity.put("shipmentCurrency", queryResult.SHIPMENTCURRENCY)
        indemnity.put("shipmentSequenceNumber", queryResult.SHIPMENTSEQUENCENUMBER)
        indemnity.put("transportMedium", queryResult.TRANSPORTMEDIUM)
        indemnity.put("indemnityType", queryResult.INDEMNITYTYPE)
        indemnity.put("outstandingBalance", queryResult.OUTSTANDINGBALANCE)
        
        indemnity.put("firstName", queryResult.FIRSTNAME)
        indemnity.put("middleName", queryResult.MIDDLENAME)
        indemnity.put("lastName", queryResult.LASTNAME)
        indemnity.put("tinNumber", queryResult.TINNUMBER)
        indemnity.put("officerCode", queryResult.OFFICERCODE)
        indemnity.put("exceptionCode", queryResult.EXCEPTIONCODE)
		indemnity.put("allocationUnitCode", queryResult.ALLOCATIONUNITCODE)

//        indemnity.each{
//            ////printlnit
//        }

        return indemnity
    }
    
    List<String> findAllNegotiationNumbers(documentNumber) {
        // sets method name and parameters
        String methodName = "findAllNegotiationNumbers"

        Map<String, Object> param = [documentNumber: documentNumber]

        List<String> queryResult = queryService.executeQuery(finder, methodName, param)

        return queryResult
    }

// find approved negotiation
    Map<String, Object> getLcNegotiation(id) {
        // sets method name and parameters
        String methodName = "findLcNegotiation"

        Map<String, Object> param = [id: id]

        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

        return constructLcNegotiation(queryResult[0])
    }

    // constructs negotiation field values
    Map<String, Object> constructLcNegotiation(Map<String, Object> queryResult) {
        Map<String, Object> negotiation = new HashMap<String, Object>()
//println"OHYEAH!"
        negotiation.put("negotiationNumber", queryResult.NEGOTIATIONNUMBER)
        negotiation.put("accountWithInstitution", queryResult.ACCOUNTWITHINSTITUTION)
        negotiation.put("accountWithInstitutionIdentifierCode", queryResult.ACCOUNTWITHINSTITUTIONIDENTIFIERCODE)
        negotiation.put("accountWithInstitutionLocation", queryResult.ACCOUNTWITHINSTITUTIONLOCATION)
        negotiation.put("accountWithInstitutionNameAndAddress", queryResult.ACCOUNTWITHINSTITUTIONNAMEANDADDRESS)
        negotiation.put("agriAgraTagging", queryResult.AGRIAGRATAGGING)
        negotiation.put("apCashAmountInNegotiationCurrency", queryResult.APCASHAMOUNTINNEGOTIATIONCURRENCY)
        negotiation.put("bank", queryResult.BANK)
        negotiation.put("bankOperationCode", queryResult.BANKOPERATIONCODE)
        negotiation.put("beneficiary", queryResult.BENEFICIARY)
        negotiation.put("beneficiaryCustomerAddress", queryResult.BENEFICIARYCUSTOMERADDRESS)
        negotiation.put("beneficiaryCustomerName", queryResult.BENEFICIARYCUSTOMERNAME)
        negotiation.put("beneficiarysAccountNumber", queryResult.BENEFICIARYSACCOUNTNUMBER)
        negotiation.put("beneficiarysInstitution", queryResult.BENEFICIARYSINSTITUTION)
        negotiation.put("beneficiarysInstitutionIdentifierCode", queryResult.BENEFICIARYSINSTITUTIONIDENTIFIERCODE)
        negotiation.put("beneficiarysInstitutionNameAndAddress", queryResult.BENEFICIARYSINSTITUTIONNAMEANDADDRESS)
        negotiation.put("bookingCurrency", queryResult.BOOKINGCURRENCY)
        negotiation.put("byOrder", queryResult.BYORDER)
        negotiation.put("cramFlag", queryResult.CRAMFLAG)
        negotiation.put("cwtFlag", queryResult.CWTFLAG)
        negotiation.put("detailsOfCharges", queryResult.DETAILSOFCHARGES)
        negotiation.put("discrepancyFeeCharge", queryResult.DISCREPANCYFEECHARGE)
        negotiation.put("documentNumber", queryResult.DOCUMENTNUMBER)
        negotiation.put("expiryDate", DateUtils.shortDateFormat(queryResult.EXPIRYDATE))
        negotiation.put("fundingReferenceNumber", queryResult.FUNDINGREFERENCENUMBER)
        negotiation.put("furtherIdentification", queryResult.FURTHERIDENTIFICATION)
        negotiation.put("generateMt", queryResult.GENERATEMT)
        negotiation.put("icNumber", queryResult.ICNUMBER)
        negotiation.put("instructionAction", queryResult.INSTRUCTIONACTION)
        negotiation.put("interestRate", queryResult.INSTERESTRATE)
        negotiation.put("interestTerm", queryResult.INTERESTTERM)
        negotiation.put("interestTermCode", queryResult.INTERESTTERMCODE)
        negotiation.put("intermediary", queryResult.INTERMEDIARY)
        negotiation.put("intermediaryIdentifierCode", queryResult.INTERMEDIARYIDENTIFIERCODE)
        negotiation.put("intermediaryNameAndAddress", queryResult.INTERMEDIARYNAMEANDADDRESS)
        negotiation.put("issueDate", DateUtils.shortDateFormat(queryResult.ISSUEDATE))
        negotiation.put("lcNegotiationStatus", queryResult.LCNEGOTIATIONSTATUS)
//        negotiation.put("loanMaturityDate", DateUtils.shortDateFormat(queryResult.LOANMATURITYDATE))

        negotiation.put("loanMaturityDate", DateUtils.shortDateFormat(queryResult.MATURITYDATE))

        negotiation.put("loanTerm", queryResult.LOANTERM)
        negotiation.put("loanTermCode", queryResult.LOANTERMCODE)
        negotiation.put("nameAndAddress", queryResult.NAMEANDADDRESS)
        negotiation.put("negotiatingBank", queryResult.NEGOTIATINGBANK)
        negotiation.put("negotiatingBanksReferenceNumber", queryResult.NEGOTIATINGBANKSREFERENCENUMBER)
        negotiation.put("negotiationAmount", queryResult.NEGOTIATIONAMOUNT)
        negotiation.put("negotiationAmountInReimbursingCurrency", queryResult.NEGOTIATIONAMOUNTINREIMBURSINGCURRENCY)
        negotiation.put("negotiationCurrency", queryResult.NEGOTIATIONCURRENCY)
        negotiation.put("negotiationFacilityId", queryResult.NEGOTIATIONFACILITYID)
        negotiation.put("negotiationFacilityType", queryResult.NEGOTIATIONFACILITYTYPE)
        negotiation.put("negotiationType", queryResult.NEGOTIATIONTYPE)
        negotiation.put("negotiationValueDate", DateUtils.shortDateFormat(queryResult.NEGOTIATIONVALUEDATE))
        negotiation.put("netAmount", queryResult.NETAMOUNT)
        negotiation.put("orderingCustomerAddress", queryResult.ORDERINGCUSTOMERADDRESS)
        negotiation.put("orderingCustomerName", queryResult.ORDERINGCUSTOMERNAME)
        negotiation.put("orderingInstitution", queryResult.ORDERINGINSTITUTION)
        negotiation.put("orderingInstitutionIdentifierCode", queryResult.ORDERINGINSTITUTIONIDENTIFIERCODE)
        negotiation.put("orderingInstitutionNameAndAddress", queryResult.ORDERINGINSTITUTIONNAMEANDADDRESS)
        negotiation.put("originalAmount", queryResult.ORIGINALAMOUNT)
        negotiation.put("originalCurrency", queryResult.ORIGINALCURRENCY)
        negotiation.put("outstandingAmount", queryResult.OUTSTANDINGAMOUNT)
        negotiation.put("outstandingBalance", queryResult.OUTSTANDINGBALANCE)
        negotiation.put("overdrawnAmount", queryResult.OVERDRAWNAMOUNT)
        negotiation.put("overdrawnNegotiationAmountInNegotiationCurrency", queryResult.OVERDRAWNNEGOTIATIONAMOUNTINNEGOTIATIONCURRENCY)
        negotiation.put("processDate", DateUtils.shortDateFormat(queryResult.PROCESSDATE))
        negotiation.put("receiversCorrespondent", queryResult.RECEIVERSCORRESPONDENT)
        negotiation.put("receiversCorrespondentIdentifierCode", queryResult.RECEIVERSCORRESPONDENTIDENTIFIERCODE)
        negotiation.put("receiversCorrespondentLocation", queryResult.RECEIVERSCORRESPONDENTLOCATION)
        negotiation.put("receiversCorrespondentNameAndAddress", queryResult.RECEIVERSCORRESPONDENTNAMEANDADDRESS)
        negotiation.put("receivingBank", queryResult.RECEIVINGBANK)
        negotiation.put("reimbursingBank", queryResult.REIMBURSINGBANK)
        negotiation.put("reimbursingBankSpecialRate", queryResult.REIMBURSINGBANKSPECIALRATE)
        negotiation.put("reimbursingBankIdentifierCode", queryResult.REIMBURSINGBANKIDENTIFIERCODE)
        negotiation.put("reimbursingBankNameAndAddress", queryResult.REIMBURSINGBANKNAMEANDADDRESS)
        negotiation.put("reimbursingAccountType", queryResult.REIMBURSINGACCOUNTTYPE)
        negotiation.put("reimbursingBankAccountNumber", queryResult.REIMBURSINGBANKACCOUNTNUMBER)
        negotiation.put("reimbursingCurrency", queryResult.REIMBURSINGCURRENCY)
        negotiation.put("remittanceFee", queryResult.REMITTANCEFEE)
        negotiation.put("remittanceFeeCurrency", queryResult.REMITTANCEFEECURRENCY)
        negotiation.put("senderCorrespondentIdentifierCode", queryResult.SENDERCORRESPONDENTIDENTIFIERCODE)
        negotiation.put("senderReference", queryResult.SENDERREFERENCE)
//        negotiation.put("senderToReceiverInformation", queryResult.SENDERSCORRESPONDENT)
        negotiation.put("sendersCorrespondent", queryResult.SENDERSCORRESPONDENT)
        negotiation.put("sendersCorrespondentLocation", queryResult.SENDERSCORRESPONDENTLOCATION)
        negotiation.put("sendersCorrespondentNameAndAddress", queryResult.SENDERSCORRESPONDENTNAMEANDADDRESS)
        negotiation.put("senderToReceiverInformation", queryResult.SENDERTORECEIVERINFORMATION)
        negotiation.put("shipmentNumber", queryResult.SHIPMENTCOUNT)
        negotiation.put("swift", queryResult.SWIFT)
        negotiation.put("totalAmount", queryResult.TOTALAMOUNT)
        negotiation.put("totalAmountCurrency", queryResult.TOTALAMOUNTCURRENCY)
        negotiation.put("typeOfLoan", queryResult.TYPEOFLOAN)
        negotiation.put("valueDate", DateUtils.shortDateFormat(queryResult.VALUEDATE))
        
        negotiation.put("documentType", queryResult.DOCUMENTTYPE)
        negotiation.put("documentSubType1", queryResult.DOCUMENTSUBTYPE1)
        negotiation.put("documentSubType2", queryResult.DOCUMENTSUBTYPE2)
        
        negotiation.put("referenceNumber", queryResult.REFERENCENUMBER)
        // retrieve previous negotiation trade service id for payment
        negotiation.put("negoTradeServiceId", queryResult.NEGOTRADESERVICEID)
        
        negotiation.put("processingUnitCode", queryResult.PROCESSINGUNITCODE)
        
        negotiation.put("amount", queryResult.UALOANAMOUNT)
        negotiation.put("currency", queryResult.UALOANCURRENCY)

        negotiation.put("lcAmount", queryResult.LCAMOUNT)
        negotiation.put("lcCurrency", queryResult.LCCURRENCY)
        
        negotiation.put("cifNumber", queryResult.CIFNUMBER)
        negotiation.put("cifName", queryResult.CIFNAME)
        negotiation.put("mainCifNumber", queryResult.MAINCIFNUMBER)
        negotiation.put("mainCifName", queryResult.MAINCIFNAME)
        negotiation.put("facilityType", queryResult.FACILITYTYPE)
        negotiation.put("facilityId", queryResult.FACILITYID)

        negotiation.put("accountOfficer", queryResult.ACCOUNTOFFICER)
        negotiation.put("ccbdBranchUnitCode", queryResult.CCBDBRANCHUNITCODE)
        negotiation.put("allocationUnitCode", queryResult.ALLOCATIONUNITCODE)
		
        negotiation.put("applicantName", queryResult.APPLICANTNAME)
        negotiation.put("longName", queryResult.LONGNAME)
        negotiation.put("address1", queryResult.ADDRESS1)
        negotiation.put("address2", queryResult.ADDRESS2)
        
        negotiation.put("firstName", queryResult.FIRSTNAME)
        negotiation.put("middleName", queryResult.MIDDLENAME)
        negotiation.put("lastName", queryResult.LASTNAME)
        negotiation.put("tinNumber", queryResult.TINNUMBER)
        negotiation.put("officerCode", queryResult.OFFICERCODE)
        negotiation.put("exceptionCode", queryResult.EXCEPTIONCODE)
        negotiation.put("commodityCode", queryResult.COMMODITYCODE)
        negotiation.put("participantCode", queryResult.PARTICIPANTCODE)

        return negotiation
    }

    // find approved negotiation
    Map<String, Object> getAccountsPayable(id) {
        // sets method name and parameters
        String methodName = "findAccountsPayable"

        Map<String, Object> param = [id: id]

        List<Map<String, Object>> queryResult = queryService.executeQuery(apFinder, methodName, param)

        return constructAp(queryResult[0])
    }
    
    Map<String, Object> constructAp(queryResult) {
        Map<String, Object> ap = new HashMap<String, Object>()

        ap.put("id", queryResult.ID)
        ap.put("cifNumber", queryResult.CIFNUMBER)
        ap.put("modifiedDate", queryResult.MODIFIEDDATE ? DateUtils.shortDateFormat(queryResult.MODIFIEDDATE) : "")
        ap.put("settlementAccountNumber", queryResult.SETTLEMENTACCOUNTNUMBER)
        ap.put("settlementAccountType", queryResult.SETTLEMENTACCOUNTTYPE)
        ap.put("status", queryResult.STATUS)
        ap.put("referenceNumber", queryResult.REFERENCENUMBER)
        ap.put("originalAmount", queryResult.ORIGINALAMOUNT)
        ap.put("currency", queryResult.CURRENCY)
        ap.put("bookingDate", queryResult.BOOKINGDATE ? DateUtils.shortDateFormat(queryResult.BOOKINGDATE) : "")
        //ap.put("setupApplicationReferenceNumber", queryResult.SETUPAPPLICATIONREFERENCENUMBER)
        ap.put("natureOfTransaction", "Setup AP")
        
        ap.put("apOutstandingBalance", queryResult.APOUTSTANDINGBALANCE)
        
        ap.put("cifName", queryResult.CIFNAME)
        ap.put("accountOfficer", queryResult.ACCOUNTOFFICER)
        ap.put("ccbdBranchUnitCode", queryResult.CCBDBRANCHUNITCODE)
        ap.put("allocationUnitCode", queryResult.ALLOCATIONUNITCODE)
        //ap.put("processingUnitCode", queryResult.PROCESSINGUNITCODE)


        return ap
    }

// find approved negotiation
    Map<String, Object> getAccountsReceivable(id) {
        // sets method name and parameters
        String methodName = "findAccountsReceivable"

        Map<String, Object> param = [id: id]
        //printlnid
        List<Map<String, Object>> queryResult = queryService.executeQuery(arFinder, methodName, param)
//        //printlnqueryResult
        return constructAr(queryResult[0])
    }

    Map<String, Object> constructAr(queryResult) {
        Map<String, Object> ar = new HashMap<String, Object>()

        ar.put("id", queryResult.ID)
        ar.put("cifNumber", queryResult.CIFNUMBER)
        ar.put("cifName", queryResult.CIFNAME)
        ar.put("accountOfficer", queryResult.ACCOUNTOFFICER)
        ar.put("ccbdBranchUnitCode", queryResult.CCBDBRANCHUNITCODE)
        ar.put("modifiedDate", queryResult.MODIFIEDDATE ? DateUtils.shortDateFormat(queryResult.MODIFIEDDATE) : "")
        ar.put("settlementAccountNumber", queryResult.SETTLEMENTACCOUNTNUMBER)
        ar.put("settlementAccountType", queryResult.SETTLEMENTACCOUNTTYPE)
        ar.put("status", queryResult.STATUS)
        ar.put("referenceNumber", queryResult.REFERENCENUMBER)
        ar.put("originalAmount", queryResult.ORIGINALAMOUNT)
        ar.put("currency", queryResult.CURRENCY)
        ar.put("bookingDate", queryResult.BOOKINGDATE ? DateUtils.shortDateFormat(queryResult.BOOKINGDATE) : "")
//        ar.put("setupApplicationReferenceNumber", queryResult.SETUPAPPLICATIONREFERENCENUMBER)
        ar.put("natureOfTransaction", "Setup AR")

        ar.put("arOutstandingBalance", queryResult.AROUTSTANDINGBALANCE)

//        ap.put("cifName", queryResult.CIFNAME)
//        ap.put("accountOfficer", queryResult.ACCOUNTOFFICER)
//        ap.put("ccbdBranchUnitCode", queryResult.CCBDBRANCHUNITCODE)
//        ap.put("processingUnitCode", queryResult.PROCESSINGUNITCODE)


        return ar
    }

    // find all related LCs
    Map<String, Object> findAllRelatedLc(maxRows, rowOffset, currentPage, cifNumber) {
        String methodName = "findAllRelatedLc"
        Map<String, Object> param = [cifNumber: cifNumber]
        ////println"cifNumber " + cifNumber
        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
        ////println"queryResult " + queryResult
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly=true)
    def constructRelatedLc(display) {
        def list = display.collect {
            [id: it.DOCUMENTNUMBER,
                    cell:[
							it.DOCUMENTTYPE,
                            it.IMPORTERNAME ?: it.APPLICANTNAME,
                            it.EXPORTERNAME ?: it.BENEFICIARYNAME,
                            it.GENERALDESCRIPTIONOFGOODS,
                            it.LASTTRANSACTION
                    ]
            ]
        }

        return list
    }

    List<Map<String,Object>> findAllIcNumbers(documentNumber) {
        String methodName = "findAllIcNumbers"

        Map<String, Object> param = [documentNumber: documentNumber]

        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

        return queryResult
    }

    Map<String, Object> findNegotiationDiscrepancyByIcNumber(icNumber) {
        // sets method name and parameters
        String methodName = "findNegotiationDiscrepancyByIcNumber"

        Map<String, Object> param = [icNumber: icNumber]

        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

        return queryResult[0]
    }
	
	@Transactional(readOnly=true)
	List<String> getAllSavedRequiredDocuments(documentNumber, tradeServiceId) {
		String methodName = "findAllSavedRequiredDocuments"

		Map<String, Object> param = [documentNumber: documentNumber,
									 tradeServiceId: tradeServiceId]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		if(queryResult) {
			if(queryResult.size() == 0) return []
		}else{
			return []
		}

		return queryResult['DOCUMENTCODE']
	}

	@Transactional(readOnly=true)
	Map<String, Object> getAllSavedNewDocuments(documentNumber, tradeServiceId) {
		String methodName = "findAllNewDocuments"

		Map<String, Object> param = [documentNumber: documentNumber,
									 tradeServiceId: tradeServiceId]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		def list = []
		
		queryResult.each {
			Map<String,Object> m = new HashMap<String, Object>()
			m.put("id", it.ID)
			m.put("description", it.DESCRIPTION)

			list << m
		}


		return [display: list]
	}

	def constructAddedRequiredDocuments(display) {
		display.collect {
			[id: it.id,
					cell: [
							it.description?.toUpperCase(),
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + it.id + "\'; editAddedDocsRequired(id);\">edit</a>",
							"<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + it.id + "\'; deleteAddedDocsRequired(id);\">delete</a>"
					]
			]
		}
	}
	
	@Transactional(readOnly=true)
	List<String> getAllSavedAdditionalConditions(documentNumber, tradeServiceId) {
		String methodName = "findAllSavedAdditionalCondition"

		Map<String, Object> param = [documentNumber: documentNumber,
									 tradeServiceId: tradeServiceId]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		if(queryResult) {
			if(queryResult.size() == 0) return []
		}else{
			return []
		}

		return queryResult['CONDITIONCODE']
	}
	
	def constructAddedAdditionalConditions(display) {
		display.collect {
			[id: it.id,
					cell: [
							it.condition.toUpperCase(),
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + it.id + "\'; editAddedAdditionalCondition(id);\">edit</a>",
							"<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + it.id + "\'; deleteAddedAdditionalCondition(id);\">delete</a>"
					]
			]
		}
	}

	@Transactional(readOnly=true)
	Map<String, Object> getAllSavedNewCondition(documentNumber, tradeServiceId) {
		String methodName = "findAllNewAdditionalCondition"

		Map<String, Object> param = [documentNumber: documentNumber,
									 tradeServiceId: tradeServiceId]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		def list = []

		queryResult.each {
			Map<String,Object> m = new HashMap<String, Object>()
			m.put("id", it.ID)
			m.put("condition", it.CONDITION)

			list << m
		}
		return [display: list]
	}
	
	@Transactional(readOnly=true)
	Map<String, Object> getAllRequiredDocuments(dataEntryModel, relatedLcNumber, maxRows, rowOffset, currentPage) {
		String methodName = "findAllDefaultDocuments"

		Map<String, Object> param = [tradeServiceId: dataEntryModel.tradeServiceId,
									 documentType: dataEntryModel.documentType,
									 documentNumber: relatedLcNumber ?: '']

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	def constructRequiredDocumentsGridDisplay(display) {
		display.collect {
			[ id: it.DOCUMENTCODE,
					cell:[
							it.DESCRIPTION?.toUpperCase(),
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links jqgrid_lowercase\" onclick=\"var id='" + it.DOCUMENTCODE + "'; editDocsRequired(id);\">edit</a>"
					]
			]
		}
	}
	
	Map<String, Object> findTotalIcAmount(documentNumber) {
		String methodName = "findTotalIcAmount"

		Map<String, Object> param = [documentNumber: documentNumber]

		List<Map<String,Object>> queryResult = queryService.executeQuery(finder, methodName, param)
		println "queryResult : " + queryResult
		Map<String,Object> queryMap = queryResult[0]
		println "queryMap : " + queryMap		
		
		if (queryMap != null) {			
			println "totalIcAmount : " + queryMap.get("TOTALICAMOUNT")
			println "totalIcCashAmount : " + queryMap.get("TOTALICCASHAMOUNT")
		}
		
		
		return queryMap
	}
	
	Map<String, Object> findRegualarAndCashIcAmount(documentNumber) {
		String methodName = "findRegualarAndCashIcAmount"

		Map<String, Object> param = [documentNumber: documentNumber]

		List<Map<String,Object>> queryResult = queryService.executeQuery(finder, methodName, param)
		println "queryResult : " + queryResult
		Map<String,Object> queryMap = queryResult[0]
		println "queryMap : " + queryMap		
		
		if (queryMap != null) {
			println "TOTALREGULARAMOUNT : " + queryMap.get("TOTALREGULARAMOUNT")
			println "TOTALCASHAMOUNT : " + queryMap.get("TOTALCASHAMOUNT")			
		}	
		
		return queryMap
	}

}
