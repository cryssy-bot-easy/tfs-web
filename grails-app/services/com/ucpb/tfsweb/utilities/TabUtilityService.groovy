package com.ucpb.tfsweb.utilities

/**
 * (revision)
 *	SCR/ER Number:
 *	SCR/ER Description: Tab validation (Redmine# 4196)
 *	[Revised by:] Brian Harold A. Aquino
 *	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
 *	[Date deployed:] 06/16/2017
 *	Program [Revision] Details: Added another case for instructions and routing.
 *	Member Type: Groovy
 *	Project: WEB
 *	Project Name: TabUtilityService.groovy
 */
class TabUtilityService {

    String getTabName(formName) {
		println "formName: " + formName
        switch(formName) {
            case "basicDetails":
                return "basicDetailsTabForm"
            case "attachedDocuments":
                return "attachedDocumentsTabForm"
            case "charges":
                return "chargesTabForm"
            case "chargesPayment":
                return "chargesPaymentTabForm"
            case "lcPayment":
                return "cashLcPaymentTabForm"
            case "instructionsAndRouting":
                return "instructionsAndRoutingTabForm"
            case "natureOfAmendment":
                return "natureOfAmendmentTabForm"
            case "settlementToBeneficiary":
                return "settlementToBeneficiaryTabForm"
            case "ieDetails":
                return "importerExporterDetailsTabForm"
            case "shipmentsOfGoods":
                return "shipmentOfGoodsTabForm"
            case "documentsRequired":
                return "documentsRequiredTabForm"
            case "additionalConditions1":
                return "additionalCondition1TabForm"
            case "additionalConditions2":
                return "additionalCondition2TabForm"
            case "narrative":
                return "narrativeTabForm"
            case "otherDocumentsInstruction":
                return "otherDocumentsInstructionTabForm"
            case "detailsOfGuarantee":
                return "detailsOfGuaranteeTabForm"
            case "additionalDetails":
                return "additionalDetailsTabForm"
            case "mt752mt202":
                return "mt752202TabForm"
            case "loanDetails":
                return "loanDetailstabForm"
            case "mt103":
                return "mt103TabForm"
            case "pddts":
                return "pddtsTabForm"
            case "attachedDocuments":
                return "attachedDocumentsTabForm"
            case "discrepancy":
                return "discrepancyTabForm"
            case "detailsForTransmittalLetter":
                return "detailsTransmittalLetterTabForm"
			case "proceedsToTeller":
				return "proceedsToTellerTabForm"	
			case "mt400":
				return "mt400_DetailsTabForm"
			case "mt202":
				return "mt202_DetailsTabForm"
			case "proceeds":
				return "proceedsDetailsTabForm"
			case "mtDetails":
				return "mtDetailsTabForm"
			case "setupLcDetails":
				return "setupLcDetailsTabForm"
			case "setupNonLcDetails":
				return "setupNonLcDetailsTabForm"
			case "docEnclosedInstructions":
				return "docEnclosedInstructionsTabForm"
			// Added by Brian for Tab Validation, used by ExportBillsPurchaseController-viewNegotiationTab
			case "loanSetup":
				return "loanSetupTabForm"
			case "instructionsAndRouting":
				return "instructionsAndRoutingTabForm"
        }
    }
}
