package com.ucpb.tfsweb.main
import grails.converters.JSON
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils
import org.apache.commons.lang.WordUtils
import org.springframework.transaction.annotation.Transactional

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: UnactedService
 */

class UnactedService {

    def queryService

    def etsFinder = com.ucpb.tfs.application.query.instruction.IServiceInstructionFinder.class
    def unactedFinder = com.ucpb.tfs.application.query.task.ITaskFinder.class

    def coreAPIService

    // evaluates serviceType for ets and return corresponding controller
    @Transactional(readOnly=true)
    Map<String, Object> evaluateEtsParams(params) {
        String serviceType = params.serviceType
		
        switch(serviceType?.toUpperCase()) {
            case "OPENING":
            case "OPENING_REVERSAL":
                return [controller: "lcEtsOpening", action: "viewOpeningEts", params: params]
            case "ADJUSTMENT":
                return [controller: "lcEtsAdjustment", action: "viewAdjustmentEts", params: params]

            case "UA_LOAN_MATURITY_ADJUSTMENT":
            case "UA LOAN MATURITY ADJUSTMENT":
                return [controller: "lcEtsUaLoanMaturityAdjustment", action: "viewMaturityAdjustmentEts", params: params]

            case "UA LOAN SETTLEMENT":
            case "UA_LOAN_SETTLEMENT":
            case "UA_LOAN_SETTLEMENT_REVERSAL":
                return [controller: "lcEtsUaLoanSettlement", action: "viewUaLoanSettlementEts", params: params]

            case "AMENDMENT":
            case "AMENDMENT_REVERSAL":
                return [controller: "lcEtsAmendment", action: "viewAmendmentEts", params: params]
            case "CANCELLATION":
                return [controller: "lcEtsCancellation", action: "viewCancellationEts", params: params]
            case "NEGOTIATION":
            case "NEGOTIATION_REVERSAL":
                return [controller: "lcEtsNegotiation", action: "viewNegotiationEts", params: params]
            case "ISSUANCE":
                return [controller: "lcEtsIndemnityIssuance", action: "viewIndemnityIssuanceEts", params: params]

            case "COLLECTION":
                return [controller: "mdEtsCollection", action: "viewCollectionEts", params: params]

            case "APPLICATION":
                return [controller: "mdEtsApplicationRefund", action: "viewApplicationRefundEts", params: params]

            case "SETTLEMENT":
            case "SETTLEMENT_REVERSAL":
            case "SETTLEMENT REVERSAL":
                if(params.documentClass.equalsIgnoreCase("DA")) {
                    return [controller: "daEtsSettlement", action: "viewSettlementEts", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DP")) {
                    return [controller: "dpEtsSettlement", action: "viewSettlementEts", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DR")) {
                    return [controller: "drEtsSettlement", action: "viewSettlementEts", params: params]
                } else if(params.documentClass.equalsIgnoreCase("OA")) {
                    return [controller: "oaEtsSettlement", action: "viewSettlementEts", params: params]
                }

            case "REFUND":
                if(params.documentClass.equalsIgnoreCase("AP")) {
                    return [controller: "apEtsRefund", action: "viewRefundEts", params: params]
                } else if (params.documentClass.equalsIgnoreCase("CDT")) {
                    return [controller: "cdt", action: "viewCdtRefund", params: params]
                }

            case "SETTLE":
                if(params.documentClass.equalsIgnoreCase("AR")) {
                    return [controller: "arEtsSettle", action: "viewSettleEts", params: params]
                }

            case "PAYMENT":
                if(params.documentClass.equalsIgnoreCase("IMPORT_ADVANCE")) {
                    return [controller: "importAdvance", action: "viewPaymentEts", params: params]
                }
        }
    }

    // evaluates serviceType for data entry and return corresponding controller
    @Transactional(readOnly=true)
    Map<String, Object> evaluateDataEntryParams (params) {
        String serviceType = params.serviceType

        switch (serviceType.toUpperCase()) {
            case "OPENING":
            case "OPENING_REVERSAL":
                return [controller: "lcDataEntryOpening", action: "viewOpeningDataEntry", params: params]
            case "ADJUSTMENT":
                return [controller: "lcDataEntryAdjustment", action: "viewAdjustmentDataEntry", params: params]
				
            case "UA LOAN MATURITY ADJUSTMENT":
            case "UA_LOAN_MATURITY_ADJUSTMENT":
                return [controller: "lcDataEntryUaLoanMaturityAdjustment", action: "viewMaturityAdjustmentDataEntry", params: params]

            case "UA LOAN SETTLEMENT":
            case "UA_LOAN_SETTLEMENT":
            case "UA_LOAN_SETTLEMENT_REVERSAL":
                return [controller: "lcDataEntryUaLoanSettlement", action: "viewSettlementDataEntry", params: params]

            case "AMENDMENT":
            case "AMENDMENT_REVERSAL":
                return [controller: "lcDataEntryAmendment", action: "viewAmendmentDataEntry", params: params]

            case "CANCELLATION":
                if(params.documentClass.equalsIgnoreCase("LC")) {
                    return [controller: "lcDataEntryCancellation", action: "viewCancellationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DA")) {
				//change action from 'viewCancellationnDataEntry' to viewCancellationDataEntry'
                    return [controller: "daDataEntryCancellation", action: "viewCancellationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DP")) {
				//change action from 'viewNegotiationDataEntry' to viewCancellationDataEntry'
                    return [controller: "dpDataEntryCancellation", action: "viewCancellationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DR")) {
				//change action from 'viewNegotiationDataEntry' to viewCancellationDataEntry'
                    return [controller: "drDataEntryCancellation", action: "viewCancellationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("OA")) {
				//change action from 'viewNegotiationDataEntry' to viewCancellationDataEntry'
                    return [controller: "oaDataEntryCancellation", action: "viewCancellationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("INDEMNITY")) {
                    return [controller: "lcDataEntryIndemnityCancellation", action: "viewIndemnityCancellationDataEntry", params: params]
                }


            case "NEGOTIATION":
                if(params.documentClass.equalsIgnoreCase("LC")) {
                    return [controller: "lcDataEntryNegotiation", action: "viewNegotiationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DP")) {
                    return [controller: "dpDataEntryNegotiation", action: "viewNegotiationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DR")) {
                    return [controller: "drDataEntryNegotiation", action: "viewNegotiationDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("OA")) {
                    return [controller: "oaDataEntryNegotiation", action: "viewNegotiationDataEntry", params: params]
                }

            case "ISSUANCE":
                return [controller: "lcDataEntryIndemnityIssuance", action: "viewIndemnityIssuanceDataEntry", params: params]

//            case "INDEMNITY CANCELLATION":
//                return [controller: "lcDataEntryIndemnityCancellation", action: "viewIndemnityCancellationDataEntry", params: params]
            case "NEGOTIATION_DISCREPANCY":
            case "NEGOTIATION DISCREPANCY":
                return [controller: "lcDataEntryNegotiationDiscrepancy", action: "viewNegotiationDiscrepancyDataEntry", params: params]

            case "COLLECTION":
                return [controller: "mdDataEntryCollection", action: "viewCollectionDataEntry", params: params]

            case "APPLICATION":
                if(params.documentType.equalsIgnoreCase("REFUND")) {
                    return [controller: "mdDataEntryApplicationRefund", action: "viewApplicationRefundDataEntry", params: params]
                } else if(params.documentType.equalsIgnoreCase("APPLICATION")) {
                    return [controller: "mdDataEntryApplication", action: "viewApplicationDataEntry", params: params]
                }

            case "SETTLEMENT":
            case "SETTLEMENT_REVERSAL":
                if(params.documentClass.equalsIgnoreCase("DA")) {
                    return [controller: "daDataEntrySettlement", action: "viewSettlementDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DP")) {
                    return [controller: "dpDataEntrySettlement", action: "viewSettlementDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DR")) {
                    return [controller: "drDataEntrySettlement", action: "viewSettlementDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("OA")) {
                    return [controller: "oaDataEntrySettlement", action: "viewSettlementDataEntry", params: params]
                }

            case "NEGOTIATION_ACCEPTANCE":
            case "NEGOTIATION ACCEPTANCE":
                return [controller: "daDataEntryNegotiationAcceptance", action: "viewNegotiationAcceptanceDataEntry", params: params]

            case "NEGOTIATION_ACKNOWLEDGEMENT":
            case "NEGOTIATION ACKNOWLEDGEMENT":
                return [controller: "daDataEntryNegotiationAcknowledgement", action: "viewNegotiationAcknowledgementDataEntry", params: params]

            case "SETUP":
                if(params.documentClass.equalsIgnoreCase("AP")) {
                    return [controller: "apDataEntrySetup", action: "viewSetupDataEntry", params: params]
                } else if(params.documentClass.equalsIgnoreCase("AR")) {
                    return [controller: "arDataEntrySetup", action: "viewSetupDataEntry", params: params]
                }
            case "APPLY":
                if(params.documentClass.equalsIgnoreCase("AP")) {
                    return [controller: "apDataEntryApply", action: "viewApplyDataEntry", params: params]
                }
            case "REFUND":
                if(params.documentClass.equalsIgnoreCase("AP")) {
                    return [controller: "apDataEntryRefund", action: "viewRefundDataEntry", params: params]
                }

            case "SETTLE":
                if(params.documentClass.equalsIgnoreCase("AR")) {
                    return [controller: "arDataEntrySettle", action: "viewSettleDataEntry", params: params]
                }

            case "PAYMENT":
                if(params.documentClass.equalsIgnoreCase("IMPORT_ADVANCE")) {
                    return [controller: "importAdvance", action: "viewPaymentDataEntry", params: params]
                }
            case "CREATE":
                if(params.documentClass.equalsIgnoreCase("MT")) {
					params << [mtMessageType:params.documentType]
                    return [controller: "outgoingMt", action: "viewMt", params: params]
                }
        }
    }

    // evaluates serviceType for payment processing and return corresponding controller
    @Transactional(readOnly=true)
    Map<String, Object> evaluatePaymentProcessingParams(params) {
        String serviceType = params.serviceType
        		//println"serviceType ==== " + serviceType.toUpperCase()
        switch (serviceType.toUpperCase()) {
            case "OPENING":
            case "OPENING_REVERSAL":
                return [controller: "lcChargesOpening", action: "viewOpeningCharges", params: params]
            case "ADJUSTMENT":
                return [controller: "lcChargesAdjustment", action: "viewAdjustmentCharges", params: params]
            case "UA_LOAN_MATURITY_ADJUSTMENT": case "UA LOAN MATURITY ADJUSTMENT":
                return [controller: "lcChargesUaLoanMaturityAdjustment", action: "viewMaturityAdjustmentCharges", params: params]
            case "UA_LOAN_SETTLEMENT": case "UA LOAN SETTLEMENT":
                return [controller: "lcChargesUaLoanSettlement", action: "viewSettlementCharges", params: params]
            case "AMENDMENT":
            case "AMENDMENT_REVERSAL":
                return [controller: "lcChargesAmendment", action: "viewAmendmentCharges", params: params]
//            case "Cancellation":
//                return [controller: "lcChargesCancellation", action: "viewCancellationCharges", params: params]
            case "NEGOTIATION":
                return [controller: "lcChargesNegotiation", action: "viewNegotiationCharges", params: params]
            case "ISSUANCE":
                return [controller: "lcChargesIndemnityIssuance", action: "viewIndemnityIssuanceCharges", params: params]
//            case "Indemnity Cancellation":
//                return [controller: "lcChargesIndemnityCancellation", action: "viewIndemnityCancellationCharges", params: params]
//            case "Negotiation Discrepancy":
//                return [controller: "lcChargesNegotiationDiscrepancy", action: "viewNegotiationDiscrepancyCharges", params: params]

            case "SETTLEMENT":
            case "SETTLEMENT_REVERSAL":
                if(params.documentClass.equalsIgnoreCase("DA")) {
                    return [controller: "daChargesSettlement", action: "viewSettlementCharges", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DP")) {
                    return [controller: "dpChargesSettlement", action: "viewSettlementCharges", params: params]
                } else if(params.documentClass.equalsIgnoreCase("DR")) {
                    return [controller: "drChargesSettlement", action: "viewSettlementCharges", params: params]
                } else if(params.documentClass.equalsIgnoreCase("OA")) {
                    return [controller: "oaChargesSettlement", action: "viewSettlementCharges", params: params]
                }
                
            case "CANCELLATION":
                if(params.documentClass.equalsIgnoreCase("INDEMNITY")) {
                    return [controller: "lcChargesIndemnityCancellation", action: "viewIndemnityCancellationCharges", params: params]
                }

            case "REFUND":
                if (params.documentClass.equalsIgnoreCase("LC")) {
                    return [controller: "refund", action: "viewRefundPayment", params: params]
                }
        }
    }
    
    @Transactional(readOnly=true)
    Map<String, Object> evaluateMtParams(params) {
        switch(params.type.toUpperCase()) {
            case "INCOMING":
                return [controller: "incomingMt", action: "viewIncomingMtMessage"]
            case "OUTGOING":
                return [controller: "outgoingMt", action: "viewOutgoingMtMessage"]
        }
    }
    
    // lists all unacted tasks branch
    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedLcBranch(maxRows, rowOffset, currentPage) {
        String methodName = "findAllLcBranchTasks"
        Map<String, Object> param = [:]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // lists all unacted tasks branch by status(es)
    @Transactional(readOnly=true)
//    Map<String, Object> findAllUnactedLcBranchByUser(user, maxRows, rowOffset, currentPage) {
    Map<String, Object> findAllUnactedLcBranchByUser(user, maxRows, rowOffset, currentPage, userrole) {
//        String methodName = "findAllLcBranchTasksByStatus"
        String methodName = "findAllLcBranchTasksByUser"

        Map<String, Object> param = [userid: user, userrole: userrole]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // lists all unacted screen
    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedLcMain(maxRows, rowOffset, currentPage) {
        String methodName = "findAllLcMainTasks"
        Map<String, Object> param = [:]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedLcMainByUser(user, maxRows, rowOffset, currentPage, userrole) {
        String methodName = "findAllLcMainTasksByUser"

        Map<String, Object> param = [userid: user, userrole: userrole]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

		println "currentPage * maxRows: "+currentPage * maxRows
		println "queryResult?.size: "+queryResult?.size
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		println "toIndex: "+toIndex
		
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

	
	// lists all unacted tasks branch (non-lc)
	@Transactional(readOnly=true)
	Map<String, Object> findAllUnactedNonLcBranch(maxRows, rowOffset, currentPage) {
		String methodName = "findAllNonLcBranchTasks"
		Map<String, Object> param = [:]

		List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	// lists all unacted tasks branch by status(es) (non-lc)
	@Transactional(readOnly=true)
	Map<String, Object> findAllUnactedNonLcBranchByUser(user, maxRows, rowOffset, currentPage, userrole) {
//        String methodName = "findAllLcBranchTasksByStatus"
		String methodName = "findAllNonLcBranchTasksByUser"

		Map<String, Object> param = [userid: user, userrole: userrole]

		List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	// lists all unacted screen (non-lc)
	@Transactional(readOnly=true)
	Map<String, Object> findAllUnactedNonLcMain(maxRows, rowOffset, currentPage) {
		String methodName = "findAllNonLcMainTasks"
		Map<String, Object> param = [:]

		List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	@Transactional(readOnly=true)
	Map<String, Object> findAllUnactedNonLcMainByUser(user, maxRows, rowOffset, currentPage, userrole) {
		String methodName = "findAllNonLcMainTasksByUser"
        println userrole
        Map<String, Object> param = [userid: user, userrole: userrole]

		List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)
		////println"result:"+queryResult

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

    // unacted auxillary branch
    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedAuxillaryBranch(maxRows, rowOffset, currentPage) {
        String methodName = "findAllAuxillaryBranchTasks"
        Map<String, Object> param = [:]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedAuxillaryBranchByUser(user, maxRows, rowOffset, currentPage, userrole) {
//        String methodName = "findAllAuxillaryBranchTasks"
        String methodName = "findAllAuxillaryBranchTasksByUser"

        Map<String, Object> param = [userid: user, userrole: userrole]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // unacted auxillary main
    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedAuxillaryMain(maxRows, rowOffset, currentPage) {
        String methodName = "findAllAuxillaryMainTasks"
        Map<String, Object> param = [:]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedAuxillaryMainByUser(user, role, maxRows, rowOffset, currentPage) {
//        String methodName = "findAllAuxillaryMainTasks"
        String methodName = "findAllAuxillaryMainTasksByUser"

        Map<String, Object> param = [userid: user, userrole: role]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

//        //println"resultssssssss  + " + queryResult

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // find all cash advance
    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedCashAdvanceBranch(user, maxRows, rowOffset, currentPage, userrole) {
        String methodName = "findAllCashAdvanceBranchTasksByUser"

        Map<String, Object> param = [userid: user, userrole: userrole]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // find all cash advance
    @Transactional(readOnly=true)
    Map<String, Object> findAllUnactedCashAdvanceMain(user, role, maxRows, rowOffset, currentPage) {
        String methodName = "findAllCashAdvanceMainTasksByUser"

        Map<String, Object> param = [userid: user, userrole: role]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // find all incoming mts
    @Transactional(readOnly=true)
    Map<String, Object> findAllIncomingMtTsd(maxRows, rowOffset, currentPage) {
        String methodName = "findAllIncomingMtTsd"
        Map<String, Object> param = [:]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // find all incoming mts
    @Transactional(readOnly=true)
    Map<String, Object> findAllRoutedIncomingMt(maxRows, rowOffset, currentPage) {
        String methodName = "findAllIncomingMtRouted"
        Map<String, Object> param = [userActiveDirectoryId: ""] // TODO: add validation for userActiveDirectoryId

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly=true)
    Map<String, Object> findAllOutgoingMt(maxRows, rowOffset, currentPage) {
        String methodName = "findAllOutgoingMt"
        Map<String, Object> param = [:]

        List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // constructs unacted branch grid display
    @Transactional(readOnly=true)
    def constructLcBranchGrid(display) {
        def list = display.collect {
            Map<String, Object> map = JSON.parse(it.DETAILS)
			String currency=it.CURRENCY?:map.currency
			
//            def amount = map.amount ? map.amount : map.originalAmount ? map.originalAmount : map.outstandingAmount ? map.outstandingAmount : 0

            String tempName = ""
			String documentType = map.documentType.equalsIgnoreCase("FOREIGN") ? "FX" : "DM"
			String documentSubType1 = map.documentSubType1

            if(documentSubType1 == "CASH"){
				documentSubType1 = "Cash"
			} else if(documentSubType1 == "REGULAR"){
				documentSubType1 = "Regular"
			} else if(documentSubType1 == "STANDBY"){
				documentSubType1 = "Standby"
			} else {
                documentSubType1 = ""
            }

			////println"BOO"+map
//			it.each{
//				//println"Key:"+it.key+", Value:"+it.value
//			}
			
			
            if(map.documentClass == "INDEMNITY") {
                map.documentClass = "LC Indemnity"
            }

            String serviceType = map.serviceType

            if (map.serviceType?.equals("UA_LOAN_MATURITY_ADJUSTMENT")) {
                serviceType = "UA Loan Maturity Adjustment"
            } else if (map.serviceType?.equals("UA_LOAN_SETTLEMENT")) {
                serviceType = "UA Loan Settlement"
            } else if (map.serviceType?.equals("UA_LOAN_SETTLEMENT_REVERSAL")) {
            	serviceType = "UA Loan Settlement Reversal"
            } else if(map.serviceType.equalsIgnoreCase("OPENING_REVERSAL")) {
				serviceType = "Opening Reversal"
			} else if(map.serviceType.equalsIgnoreCase("AMENDMENT_REVERSAL")) {
				serviceType = "Amendment Reversal"
			} else if(map.serviceType.equalsIgnoreCase("NEGOTIATION_REVERSAL")) {
				serviceType = "Negotiation Reversal"
			} else if(map.serviceType.equalsIgnoreCase("SETTLEMENT_REVERSAL")) {
				serviceType = "Settlement Reversal"
			} /* else if (map.serviceType?.contains("REVERSAL")) {
                def serviceTypeParts = map.serviceType?.split("_")

                serviceType = ""

                serviceTypeParts.eachWithIndex { a, b ->
                    serviceType += WordUtils.capitalizeFully(a)

                    if ((b+1).compareTo(serviceTypeParts.size()) < 0) {
                        serviceType += " "
                    }
                }
            } */

//			println "it.AMOUNT " + it.AMOUNT
//			println "map.amount " + map.amount
			tempName = documentType + " " + documentSubType1 + " " + map.documentClass + " " + serviceType //map.serviceType


            def amount = it.AMOUNT ? NumberUtils.currencyFormat(new Double(it.AMOUNT)) : '0.00'

            if ("AMENDMENT".equals(map.serviceType.toUpperCase())) {
				if(map.amountTo) {
					amount = NumberUtils.currencyFormat(new Double(map.amountTo))
				} else if (map.amount) {
					amount = NumberUtils.currencyFormat(new Double(map.amount))
				}
            } /*else if ((map.serviceType && map.serviceType.toUpperCase() in ["CANCELLATION", "ADJUSTMENT"]) && map.outstandingBalance) {
            	amount = NumberUtils.currencyFormat(new Double(map.outstandingBalance))
            }*/ else if ((map.serviceType && map.serviceType.toUpperCase() in ["UA_LOAN_MATURITY_ADJUSTMENT", "UA LOAN MATURITY ADJUSTMENT", "UA_LOAN_SETTLEMENT", "UA LOAN SETTLEMENT"])) {
				amount = NumberUtils.currencyFormat(new Double(map.productAmount ?: map.amount ?: 0.00))
            } else if ((map.serviceType && map.serviceType.toUpperCase().equals("NEGOTIATION"))) {
                amount = map.negotiationAmount ? NumberUtils.currencyFormat(new Double(map.negotiationAmount)) : '0'
            } else if (map.serviceType && map.outstandingBalance) {
                if (map.serviceType.toUpperCase().equals("CANCELLATION")) {
                    amount = NumberUtils.currencyFormat(new Double(map.outstandingBalance.replaceAll(",", "")))
                } else if (map.serviceType.toUpperCase().equals("ADJUSTMENT")) {
                    if (map.cashAmount) {
                        amount = NumberUtils.currencyFormat(new Double(map.cashAmount))
                    } else {
                        amount = NumberUtils.currencyFormat(new Double(map.outstandingBalance))
                    }
                }
            }


            if (map.serviceType.equals("REFUND") && map.documentClass.equals("LC")) {
                amount = NumberUtils.currencyFormat(new Double(map.refundableAmount ?: '0'))
                currency = "PHP"
            }

//            map.each {
//                println it
//            }

            String etsNumberForId = (map.serviceType.contains("_REVERSAL")) ? map.etsNumber : it.SERVICEINSTRUCTIONID
            println it.SERVICEINSTRUCTIONID
            [id: it.SERVICEINSTRUCTIONID,
                    cell:[
                            (map.serviceType.contains("_REVERSAL")) ? map.etsNumber : it.SERVICEINSTRUCTIONID,
                            tempName,
                            map.cifName,
                            currency,
                            //it.AMOUNT ? NumberUtils.currencyFormat(new Double(it.AMOUNT)) : '0.00',
                            (map.serviceType.contains("_REVERSAL")) ? NumberUtils.currencyFormat(new Double(map.amount)) : amount,
                            it.TASKSTATUS,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; var grid_id='grid_list_letter_of_credit_unacted_branch'; onViewClick(id,grid_id);\">view</a>",
                            map.serviceType,
                            map.documentType,
                            map.documentClass,
                            map.documentSubType1,
                            map.documentSubType2,
                            map.documentNumber
                    ]
            ]
        }
        return list
    }

    // constructs unacted branch grid display
    @Transactional(readOnly=true)
    def constructLcMainGrid(display) {
        def list = display.collect {
            Map<String, Object> map = JSON.parse(it.SIDETAILS ?: it.TSDETAILS)
            def currency = it.CURRENCY ?: map.currency
            String payCharges = ""
            String tempName = ""
			String documentType = map.documentType.equalsIgnoreCase("FOREIGN") ? "FX" : "DM"
			String documentSubType1 = map.documentSubType1

            if(documentSubType1 == "CASH"){
				documentSubType1 = "Cash"
			} else if(documentSubType1 == "REGULAR"){
				documentSubType1 = "Regular"
			} else if(documentSubType1 == "STANDBY"){
				documentSubType1 = "Standby"
			} else {
                documentSubType1 = ""
            }

            if(map.serviceType.equalsIgnoreCase("NEGOTIATION_DISCREPANCY")) {
                map.serviceType = "Negotiation Discrepancy"
            }

            if(map.documentClass == "INDEMNITY") {
                map.documentClass = "LC Indemnity"
            }

            String serviceType = map.serviceType

            if (map.serviceType?.equals("UA_LOAN_MATURITY_ADJUSTMENT")) {
                serviceType = "UA Loan Maturity Adjustment"
            } else if (map.serviceType?.equals("UA_LOAN_SETTLEMENT")) {
                serviceType = "UA Loan Settlement"
            } else if (map.serviceType?.equals("UA_LOAN_SETTLEMENT_REVERSAL")) {
            	serviceType = "UA Loan Settlement Reversal"
            } else if(map.serviceType.equalsIgnoreCase("OPENING_REVERSAL")) {
				serviceType = "Opening Reversal"
			} else if(map.serviceType.equalsIgnoreCase("AMENDMENT_REVERSAL")) {
				serviceType = "Amendment Reversal"
			} else if(map.serviceType.equalsIgnoreCase("NEGOTIATION_REVERSAL")) {
				serviceType = "Negotiation Reversal"
			} else if(map.serviceType.equalsIgnoreCase("SETTLEMENT_REVERSAL")) {
				serviceType = "Settlement Reversal"
			} /* else if (serviceType?.contains("REVERSAL")) {
                def serviceTypeParts = serviceType?.split("_")

                serviceType = ""

                serviceTypeParts.eachWithIndex { a, b ->
                    serviceType += WordUtils.capitalizeFully(a)

                    if ((b+1).compareTo(serviceTypeParts.size()) < 0) {
                        serviceType += " "
                    }
                }
            } */
			
			tempName = documentType + " " + documentSubType1 + " " + map.documentClass + " " + serviceType//map.serviceType
			
            if(!(map.serviceType.equalsIgnoreCase("Cancellation") && map.documentClass.equalsIgnoreCase("lc")) &&
                    !map.serviceType.equalsIgnoreCase("Collection") &&
                    !(map.serviceType.equalsIgnoreCase("Adjustment") && (map.documentSubType1.equalsIgnoreCase("Cash") || map.documentSubType1.equalsIgnoreCase("Standby"))) &&
                    !(map.serviceType.equalsIgnoreCase("NEGOTIATION_DISCREPANCY") || map.serviceType.equalsIgnoreCase("Negotiation Discrepancy"))) {

                payCharges = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_letter_of_credit_unacted_main'; onViewChargesClick(id,grid_id);\">pay</a>"
            }

            if (map.serviceType?.equalsIgnoreCase("adjustment")) {
                if (map.documentSubType1?.equalsIgnoreCase("regular") && (map.documentSubType2?.equalsIgnoreCase("sight") || map.documentSubType2?.equalsIgnoreCase("usance")) && map.partialCashSettlementFlag?.equalsIgnoreCase("partialCashSettlementEnabled")) {
                    payCharges = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_letter_of_credit_unacted_main'; onViewChargesClick(id,grid_id);\">pay</a>"
                } else {
                    payCharges = ""
                }
            }

            if (map.serviceType?.equalsIgnoreCase("amendment") && !it.SERVICEINSTRUCTIONID) {
                payCharges = ""
            }
			
			if (map.serviceType?.equalsIgnoreCase("Cancellation") && map.documentClass?.equalsIgnoreCase("LC Indemnity") && map.clientInitiatedFlag != "N") {
				payCharges = ""
			}

            String viewEts = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_letter_of_credit_unacted_main'; onViewClick(id,grid_id);\">view</a>"
            
            if(!it.SERVICEINSTRUCTIONID) {
                viewEts = ""
            }

            def amount = it.AMOUNT ? NumberUtils.currencyFormat(new Double(it.AMOUNT)) : '0.00'
			

        	if ("AMENDMENT".equals(map.serviceType.toUpperCase())) {
                //amount = map.amountTo && new Double(map.amountTo?:'0') != 0.00 ? NumberUtils.currencyFormat(new Double(map.amountTo?:'0')) : NumberUtils.currencyFormat(new Double(map.outstandingBalance))
				if(map.amountTo == null){
					amount = 0
					} else {
					try{
						NumberUtils.currencyFormat(new Double(map.amountTo?:'0'))
						} catch(Exception e){
						amount = NumberUtils.currencyFormat(new Double(map.outstandingBalance))
						
						}
					}			
					
				if(amount==null){
					amount = 0
					}
            } /*else if ((map.serviceType && map.serviceType.toUpperCase() in ["CANCELLATION", "ADJUSTMENT"]) && map.outstandingBalance) {
            	amount = NumberUtils.currencyFormat(new Double(map.outstandingBalance))
            }*/ else if ((map.serviceType && map.serviceType.toUpperCase() in ["UA_LOAN_MATURITY_ADJUSTMENT", "UA LOAN MATURITY ADJUSTMENT", "UA_LOAN_SETTLEMENT", "UA LOAN SETTLEMENT"])) {
				amount = NumberUtils.currencyFormat(new Double(map.productAmount ?: map.amount ?: 0.00))
            }  else if ((map.serviceType && map.serviceType.toUpperCase().equals("NEGOTIATION"))) {
                amount = map.negotiationAmount ? NumberUtils.currencyFormat(new Double(map.negotiationAmount)) : '0'
            } else if (map.serviceType && map.outstandingBalance) {
                if (map.serviceType.toUpperCase().equals("CANCELLATION")) {
					if(map.documentClass.equalsIgnoreCase("LC Indemnity")) {
						amount = NumberUtils.currencyFormat(new Double(map.shipmentAmount))
					} else {
						amount = NumberUtils.currencyFormat(new Double(map.outstandingBalance))
					}       
                } else if (map.serviceType.toUpperCase().equals("ADJUSTMENT")) {
                    if (map.cashAmount) {
                        amount = NumberUtils.currencyFormat(new Double(map.cashAmount))
                    } else {
                        amount = NumberUtils.currencyFormat(new Double(map.outstandingBalance))
                    }
                }
            }

//            if ("DRAFT".equals(it.TASKSTATUS)) {
//                payCharges = ""
//            }

            if (map.serviceType.contains("_REVERSAL")){
                //println it
                amount = NumberUtils.currencyFormat(new Double(map.amount))
            }

            if (map.serviceType.equals("REFUND") && map.documentClass.equals("LC")) {
                amount = NumberUtils.currencyFormat(new Double(map.refundableAmount))
                currency = "PHP"
            }
			
			[id: it.TRADESERVICEID,
					cell:[
							it.DOCUMENTCLASS.equalsIgnoreCase("INDEMNITY") ? it.TRADEPRODUCTNUMBER : map.serviceType.equalsIgnoreCase("Negotiation") ? map.lcNumber : it.DOCUMENTNUMBER,
							tempName,
							it.CIFNAME,
							currency,
							//it.AMOUNT ? NumberUtils.currencyFormat(new Double(it.AMOUNT)) : '0.00',
							amount,
							it.TASKSTATUS.equals("PRE_APPROVED") ? "PRE APPROVED" : it.TASKSTATUS.equals("POST_APPROVED") ? "POST APPROVED" : it.TASKSTATUS.equals("MARV") ? "DRAFT" : it.TASKSTATUS,
							viewEts,
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_letter_of_credit_unacted_main'; onDataEntryClick(id,grid_id);\">view/edit</a>",
							it.TASKSTATUS.equals("MARV") ? " " : payCharges,
							map.serviceType,
							it.DOCUMENTTYPE,
							it.DOCUMENTCLASS,
							it.DOCUMENTSUBTYPE1,
							it.DOCUMENTSUBTYPE2,
							map.serviceType.contains("_REVERSAL") ? map.etsNumber : it.SERVICEINSTRUCTIONID,
							map.serviceType.contains("_REVERSAL") && map.reversalEtsNumber ? map.reversalEtsNumber : ''
					]
			]
        }

        return list
    }

	// constructs unacted branch grid display (Non-Lc)
	@Transactional(readOnly=true)
	def constructNonLcBranchGrid(display) {
		def list = display.collect {
			Map<String, Object> map = JSON.parse(it.DETAILS)

//            def amount = map.amount ? map.amount : map.originalAmount ? map.originalAmount : map.outstandingAmount ? map.outstandingAmount : 0

			String tempName = ""
			////println"DOCUMENTTYPE: "+map.documentType
			String documentType = map.documentType.equalsIgnoreCase("FOREIGN") ? "FX" : "DM"
//			String documentSubType1 = map.documentSubType1

			/*if(documentSubType1 == "CASH"){
				documentSubType1 = "Cash"
			} else if(documentSubType1 == "REGULAR"){
				documentSubType1 = "Regular"
			} else if(documentSubType1 == "STANDBY"){
				documentSubType1 = "Standby"
			} else {
				documentSubType1 = ""
			}

			if(map.documentClass == "INDEMNITY") {
				map.documentClass = "LC Indemnity"
			}*/

            //def serviceType

			if(map.serviceType.equalsIgnoreCase("OPENING_REVERSAL")) {
				map.serviceType = "Opening Reversal"
			} else if(map.serviceType.equalsIgnoreCase("AMENDMENT_REVERSAL")) {
				map.serviceType = "Amendment Reversal"
			} else if(map.serviceType.equalsIgnoreCase("NEGOTIATION_REVERSAL")) {
				map.serviceType = "Negotiation Reversal"
			} else if(map.serviceType.equalsIgnoreCase("SETTLEMENT_REVERSAL")) {
				map.serviceType = "Settlement Reversal"
			}

			tempName = documentType + " " + map.documentClass + " " + map.serviceType

			[id: it.SERVICEINSTRUCTIONID,
					cell:[							
							it.SERVICEINSTRUCTIONID,
							tempName?.replaceAll("_", " "),
							map.cifName,
							map.currency,
							it.AMOUNT ? NumberUtils.currencyFormat(new Double(it.AMOUNT)) : (map.amount) ? NumberUtils.currencyFormat(new Double(map.amount)) : '0.00',
							it.TASKSTATUS?.replaceAll("_", " "),
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; var grid_id='grid_list_non_letter_of_credit_unacted_branch'; onViewClick(id,grid_id);\">view</a>",
							map.serviceType,
							map.documentType,
							map.documentClass,
							map.documentSubType1,
							map.documentSubType2,
							map.documentNumber
					]
			]
		}

		return list
	}

	// constructs unacted branch grid display (Non-Lc)
	@Transactional(readOnly=true)
	def constructNonLcMainGrid(display) {
		def list = display.collect {
			Map<String, Object> map = (it.TSDETAILS) ? JSON.parse(it.TSDETAILS) : new HashMap<>()
			String payCharges = (!map.settleFlag || map.settleFlag == 'N') ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_non_letter_of_credit_unacted_main'; onViewChargesClick(id,grid_id);\">pay</a>" : ""
            String unpayCharges = (!map.settleFlag || map.settleFlag == 'N') ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_non_letter_of_credit_unacted_main'; onViewChargesClick(id,grid_id);\">reverse payment</a>" : ""
			String tempName = ""
			////println"DOCUMENTTYPE: "+map.documentType
			String documentType = map.documentType.equalsIgnoreCase("FOREIGN") ? "FX" : "DM"
			def serviceType
			
			if(map.serviceType.equalsIgnoreCase("NEGOTIATION_ACKNOWLEDGEMENT")) {
				serviceType = "Negotiation Acknowledgement"
			} else if(map.serviceType.equalsIgnoreCase("NEGOTIATION_ACCEPTANCE")) {
				serviceType = "Negotiation Acceptance"
			} else if(map.serviceType.equalsIgnoreCase("OPENING_REVERSAL")) {
				serviceType = "Opening Reversal"
			} else if(map.serviceType.equalsIgnoreCase("AMENDMENT_REVERSAL")) {
				serviceType = "Amendment Reversal"
			} else if(map.serviceType.equalsIgnoreCase("NEGOTIATION_REVERSAL")) {
				serviceType = "Negotiation Reversal"
			} else if(map.serviceType.equalsIgnoreCase("SETTLEMENT_REVERSAL")) {
				serviceType = "Settlement Reversal"
			} else if(map.serviceType.equalsIgnoreCase("SETTLEMENT")) {
				serviceType = "Settlement"
			} 
			
			tempName = documentType + " " + map.documentClass + " " + (serviceType ?: map.serviceType)

            //printlnmap

			String viewEts = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_non_letter_of_credit_unacted_main'; onViewClick(id,grid_id);\">view</a>"
			
			if(!it.SERVICEINSTRUCTIONID) {
				viewEts = ""
			}

            def amount = ""
            if (map.serviceType.equalsIgnoreCase("CANCELLATION")) {
                amount = NumberUtils.currencyFormat(new Double(map.outstandingAmount))
            } else {
                if (map.serviceType.equalsIgnoreCase("SETTLEMENT")) {
                    amount = NumberUtils.currencyFormat(new Double(map.productAmount))
                } else {
                    if (it.AMOUNT && it.AMOUNT != 0) {
                        amount = NumberUtils.currencyFormat(new Double(it.AMOUNT))
                    } else {
                        amount = NumberUtils.currencyFormat(new Double(map.amount))
                    }
                }
            }
			


			[id: it.TRADESERVICEID,
					cell:[
							it.DOCUMENTNUMBER,
							tempName?.replaceAll("_", " "),
							it.CIFNAME,
							map.currency,
							//(map.serviceType.equalsIgnoreCase("CANCELLATION")) ? NumberUtils.currencyFormat(new Double(map.outstandingAmount ?: '0')) : it.AMOUNT != 0 ? NumberUtils.currencyFormat(new Double(it.AMOUNT ?: '0')) : (map.amount) ? NumberUtils.currencyFormat(new Double(map.amount ?: '0')) : '0.00',
                            amount,
							it.TASKSTATUS?.replaceAll("_", " "),
							viewEts,
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_non_letter_of_credit_unacted_main'; onDataEntryClick(id,grid_id);\">view/edit</a>",
							map.serviceType.equalsIgnoreCase("SETTLEMENT") ? payCharges : map.reversalEtsNumber ? unpayCharges : "",
							map.serviceType,
							it.DOCUMENTTYPE,
							it.DOCUMENTCLASS,
//							it.DOCUMENTSUBTYPE1,
//							it.DOCUMENTSUBTYPE2,
							it.SERVICEINSTRUCTIONID,
							it.SERVICEINSTRUCTIONID ?: it.TRADESERVICEREFERENCENUMBER
					]
			]
		}

		return list
	}

    @Transactional(readOnly=true)
    def constructAuxillaryBranchGrid(display) {
        def list = display.collect {
            Map<String, Object> map = JSON.parse(it.DETAILS)

            def documentClass
            def serviceType

			if(map.documentClass.equalsIgnoreCase("CORRES_CHARGE")) {
				documentClass = "Corres Charge"
			} else if(map.documentClass.equalsIgnoreCase("REBATE")) {
				documentClass = "Rebate"
			}else if(map.documentClass.equalsIgnoreCase("IMPORT_CHARGES")) {
				documentClass = "Import Charges"
			}else if(map.documentClass.equalsIgnoreCase("EXPORT_CHARGES")) {
				documentClass = "Export Charges"
			} else {
                documentClass = map.documentClass
            }
			
			if(map.serviceType.equalsIgnoreCase("COLLECTION")) {
				serviceType = "Collection"
			} else if(map.serviceType.equalsIgnoreCase("APPLICATION")) {
                serviceType = "Application"

                if ("MD".equals(documentClass) && "REFUND".equals(map.documentType)) {
                    serviceType = "Application Refund"
                }
			} else if(map.serviceType.equalsIgnoreCase("SETTLEMENT")) {
				serviceType = "Settlement"
			} else if(map.serviceType.equalsIgnoreCase("PROCESS")) {
				serviceType = "Process"
			} else if(map.serviceType.equalsIgnoreCase("REFUND")) {
				serviceType = "Refund"
			} else if(map.serviceType.equalsIgnoreCase("REMITTANCE")) {
				serviceType = "Remittance"
			} else if(map.serviceType.equalsIgnoreCase("PAYMENT")) {
				serviceType = "Payment"
			} else if(map.serviceType.equalsIgnoreCase("PAYMENT_OTHER")) {
				serviceType = "Others Payment"
			} else if(map.serviceType.equalsIgnoreCase("SETUP")) {
				serviceType = "Setup"
			} else if(map.serviceType.equalsIgnoreCase("APPLY")) {
				serviceType = "Apply"
			} else if(map.serviceType.equalsIgnoreCase("SETTLE")) {
				serviceType = "Monitoring Settlement"
			}
            println it.SERVICETYPE
            [id: it.SERVICEINSTRUCTIONID,
                    cell:[
                            it.SERVICEINSTRUCTIONID,
                            map.cifName,
                            documentClass + " " + serviceType,
                            it.TASKSTATUS,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; var grid_id='grid_list_auxiliary_import_unacted_branch'; onViewClick(id,grid_id);\">view</a>",
                            map.serviceType,
                            //it.SERVICETYPE,
                            map.documentType,
                            map.documentClass,
                            map.documentSubType1,
                            map.documentSubType2,
                            map.documentNumber,
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
	def constructAuxillaryMainGrid(display) {
		
		
	
		
		def list = display.collect {
			Map<String, Object> map = JSON.parse(it.DETAILS)
		

			def documentClass
			def serviceType

			if(map.documentClass?.equalsIgnoreCase("CORRES_CHARGE")) {
				documentClass = "Corres Charge"
			} else if(map.documentClass?.equalsIgnoreCase("REBATE")) {
				documentClass = "Rebate"
			}else if(map.documentClass?.equalsIgnoreCase("IMPORT_CHARGES")) {
				documentClass = "Import Charges"
			}else if(map.documentClass?.equalsIgnoreCase("EXPORT_CHARGES")) {
				documentClass = "Export Charges"
			} else {
				documentClass = map.documentClass
			}
			
			if(map.serviceType?.equalsIgnoreCase("COLLECTION")) {
				serviceType = "Collection"
			} else if(map.serviceType?.equalsIgnoreCase("APPLICATION")) {
				serviceType = "Application"

				if ("MD".equals(documentClass) && "REFUND".equals(map.documentType)) {
					serviceType = "Application Refund"
				}
			} else if(map.serviceType?.equalsIgnoreCase("SETTLEMENT")) {
				serviceType = "Settlement"
			} else if(map.serviceType?.equalsIgnoreCase("SETTLE")) {
				serviceType = "Settle"
			} else if(map.serviceType?.equalsIgnoreCase("REBATE")) {
				serviceType = "Process"
			} else if(map.serviceType?.equalsIgnoreCase("REFUND")) {
				serviceType = "Refund"
			} else if(map.serviceType?.equalsIgnoreCase("REMITTANCE")) {
				serviceType = "Remittance"
			} else if(map.serviceType?.equalsIgnoreCase("PAYMENT")) {
				serviceType = "Payment"
			} else if(map.serviceType?.equalsIgnoreCase("PAYMENT_OTHER")) {
				serviceType = "Others Payment"
			} else if(map.serviceType?.equalsIgnoreCase("SETUP")) {
				serviceType = "Setup"
			} else if(map.serviceType?.equalsIgnoreCase("APPLY")) {
				serviceType = "Apply"
			}

			println documentClass + " - " + map.serviceType + " - " + map.documentType

			if(!map.documentClass?.equalsIgnoreCase("CDT")){
			[id: it.TRADESERVICEID,
					cell:[
							it.DOCUMENTNUMBER,
							it.CIFNAME ?: map.cifName,
							documentClass + " " + ("MT".equals(documentClass)? map.messageType : serviceType),
							it.TASKSTATUS,
							(it.TRADESERVICEREFERENCENUMBER || !it.SERVICEINSTRUCTIONID) ? "" : "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_auxiliary_import_unacted_main'; onViewClick(id,grid_id);\">view</a>",
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_auxiliary_import_unacted_main'; onDataEntryClick(id,grid_id);\">view/edit</a>",
							(!it.SERVICEINSTRUCTIONID || (documentClass == "MD" && ("refund".equalsIgnoreCase(map.documentType) || "collection".equalsIgnoreCase(map.serviceType))) ||  map.documentClass in["CORRES_CHARGE","IMPORT_CHARGES", "AP", "AR"] || ("payment".equalsIgnoreCase(map.serviceType) && map.documentClass?.equalsIgnoreCase("EXPORT_CHARGES"))) ? "" : "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_auxiliary_import_unacted_main'; onViewChargesClick(id,grid_id);\">Refund</a>",
//                            "view mt",
							map.serviceType,
							//it.SERVICETYPE,
							("MT".equals(documentClass)? map.messageType : it.DOCUMENTTYPE),
							it.DOCUMENTCLASS,
							it.DOCUMENTSUBTYPE1,
							it.DOCUMENTSUBTYPE2,
							it.etsNumber ?: map.etsNumber
					]
			]
			}

			
				
		}
		
		list.removeAll(Collections.singleton(null));

	
		return list
	}
    
	
	//for CDT
	@Transactional(readOnly=true)
	def constructAuxillaryMainGridcdt(display) {
		
		
	
		
		def list = display.collect {
			Map<String, Object> map = JSON.parse(it.DETAILS)
		

			def documentClass
			def serviceType

			if(map.documentClass?.equalsIgnoreCase("CORRES_CHARGE")) {
				documentClass = "Corres Charge"
			} else if(map.documentClass?.equalsIgnoreCase("REBATE")) {
				documentClass = "Rebate"
			}else if(map.documentClass?.equalsIgnoreCase("IMPORT_CHARGES")) {
				documentClass = "Import Charges"
			}else if(map.documentClass?.equalsIgnoreCase("EXPORT_CHARGES")) {
				documentClass = "Export Charges"
			} else {
				documentClass = map.documentClass
			}
			
			if(map.serviceType?.equalsIgnoreCase("COLLECTION")) {
				serviceType = "Collection"
			} else if(map.serviceType?.equalsIgnoreCase("APPLICATION")) {
				serviceType = "Application"

				if ("MD".equals(documentClass) && "REFUND".equals(map.documentType)) {
					serviceType = "Application Refund"
				}
			} else if(map.serviceType?.equalsIgnoreCase("SETTLEMENT")) {
				serviceType = "Settlement"
			} else if(map.serviceType?.equalsIgnoreCase("SETTLE")) {
				serviceType = "Settle"
			} else if(map.serviceType?.equalsIgnoreCase("REBATE")) {
				serviceType = "Process"
			} else if(map.serviceType?.equalsIgnoreCase("REFUND")) {
				serviceType = "Refund"
			} else if(map.serviceType?.equalsIgnoreCase("REMITTANCE")) {
				serviceType = "Remittance"
			} else if(map.serviceType?.equalsIgnoreCase("PAYMENT")) {
				serviceType = "Payment"
			} else if(map.serviceType?.equalsIgnoreCase("PAYMENT_OTHER")) {
				serviceType = "Others Payment"
			} else if(map.serviceType?.equalsIgnoreCase("SETUP")) {
				serviceType = "Setup"
			} else if(map.serviceType?.equalsIgnoreCase("APPLY")) {
				serviceType = "Apply"
			}

			println documentClass + " - " + map.serviceType + " - " + map.documentType

			
			def reportTypecdt = map.reportType
			def remittanceDate = map.remittanceDate
			def remittanceAmount = map.remittanceAmount
			def collectionPeriodTo = map.collectionPeriodTo
			def collectionPeriodFrom = map.collectionPeriodFrom
			def sType = map.serviceType.toUpperCase();
			println reportTypecdt + "its not okay"
			
	if(map.documentClass?.equalsIgnoreCase("CDT")){
			[id: it.TRADESERVICEID,
					cell:[
							documentClass + " " + ("MT".equals(documentClass)? map.messageType : serviceType),
							reportTypecdt,
							remittanceDate,
							remittanceAmount,
							collectionPeriodFrom,
							collectionPeriodTo,
							it.TASKSTATUS,
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_auxiliary_import_unacted_maincdt'; var sType='"+sType+"'; onDataEntrycdtClick(id,grid_id,sType);\">view/edit</a>",
							("MT".equals(documentClass)? map.messageType : it.DOCUMENTTYPE),
							it.DOCUMENTCLASS,
							it.DOCUMENTSUBTYPE1,
							it.DOCUMENTSUBTYPE2,
							it.etsNumber ?: map.etsNumber
					]
			]
			
			}
			

			
				
		}
		
		list.removeAll(Collections.singleton(null));

	
		return list
	}
	

	
	
	
    def constructIncomingMtTsd(display) {

        display.collect {

//            def user = coreAPIService.dummySendQuery([:], "user/" + it.USERACTIVEDIRECTORYID, "security/")?.details
//            println "user >> " + user
            [id: it.ID,
                    cell: [
                            DateUtils.shortDateFormat(it.DATERECEIVED),
                            DateUtils.timeFormat(it.DATERECEIVED),
                            it.MTTYPE,
                            it.FULLNAME, //it.USERACTIVEDIRECTORYID,
                            it.MTSTATUS,
                            it.MESSAGECLASS,
                            it.DOCUMENTNUMBER,
							"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"';var userType='APPROVER';  onViewMtTsd(id,userType);\">view</a>"
                            /*"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; var userType='MAKER'; onViewMtMaker(id,userType);\">view</a>"*/
                    ]
            ]
        }
    }

    def constructRoutedIncomingMt(display) {
        display.collect {
            [id: it.ID,
                    cell: [
							DateUtils.shortDateFormat(it.DATERECEIVED),
							DateUtils.timeFormat(it.DATERECEIVED),
							it.MTTYPE,
							it.INSTRUCTION,
                            it.MESSAGECLASS,
                            it.DOCUMENTNUMBER,
							"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; var userType='MAKER'; onViewMtMaker(id,userType);\">view</a>"
							/*"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"';var userType='APPROVER';  onViewMtTsd(id,userType);\">view</a>"*/                            
                    ]
            ]
        }
    }

    def constructOutgoingMt(display) {
        display.collect {
            [id: it.ID,
                    cell: [
                            it.TRADEPRODUCTNUMBER,
                            it.MTTYPE,
                            DateUtils.shortDateFormat(it.MODIFIEDDATE),
                            DateUtils.timeFormat(it.MODIFIEDDATE),
							it.MTSTATUS,
							/*
							"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; onTransmitMt(id);\">transmit</a>",
							"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; onViewOutgoingMt(id);\">view</a>"
							*/
							((it.MTSTATUS.equalsIgnoreCase("TRANSMITTED") || it.MTSTATUS.equalsIgnoreCase("DISCARDED")) ? "" :
                            ("<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; onTransmitMt(id);\">transmit</a>" + " | " +
							"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; onDiscardMt(id);\">discard</a>" + " | ")) +
							"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; onReverseMt(id);\">reverse</a>" + " | " +						
							"<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"'; onViewOutgoingMt(id);\">view</a>"							
                    ]
            ]
        }
    }

    def constructCashAdvanceBranch(display) {
        display.collect {
            Map<String, Object> map = JSON.parse(it.DETAILS)

            [id: it.SERVICEINSTRUCTIONID,
                    cell: [
                            it.SERVICEINSTRUCTIONID,
                            map.cifName,
                            //"Import Advance - " + WordUtils.capitalizeFully(it.SERVICETYPE),
                            ((map.documentClass.equals("IMPORT_ADVANCE")) ? "Import Advance - " : "Export Advance - ") + WordUtils.capitalizeFully(it.SERVICETYPE),
                            it.TASKSTATUS,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; var grid_id='grid_list_cash_advance_unacted'; onViewClick(id,grid_id);\">view</a>",
                            map.serviceType,
                            map.documentType,
                            map.documentClass,
                            map.documentSubType1,
                            map.documentSubType2,
                            map.documentNumber
                    ]
            ]
        }
    }

    def constructCashAdvanceMain(display) {
        display.collect {
            Map<String, Object> map = JSON.parse(it.DETAILS)
			
			

            [id: it.TRADESERVICEID,
                    cell: [
                            it.DOCUMENTNUMBER,
                            map.cifName,
                            (map.documentClass.equals("IMPORT_ADVANCE") ? "Import Advance - " : "Export Advance - ") + WordUtils.capitalizeFully(it.SERVICETYPE),
                            it.TASKSTATUS,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_cash_advance_unacted'; onViewClick(id,grid_id);\">view</a>",
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.TRADESERVICEID + "'; var grid_id='grid_list_cash_advance_unacted'; onDataEntryClick(id,grid_id);\">view/edit</a>",
                            map.serviceType,
                            map.documentType,
                            map.documentClass,
                            map.documentSubType1,
                            map.documentSubType2,
                            map.documentNumber
                    ]
            ]
        }
    }

    @Transactional(readOnly = true)
    Map<String, Object> findAllUnactedExportAdvising(username, userrole, maxRows, rowOffset, currentPage) {
        String methodName = "findAllExportAdvisingByUser"

        Map<String, Object> param = [userid: username,userrole: userrole]

        def queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly = true)
    Map<String, Object> findAllUnactedExportBillsBranch(username, maxRows, rowOffset, currentPage, userrole) {
        String methodName = "findAllExportBillsBranchByUser"

        Map<String, Object> param = [userid: username, userrole: userrole]
        def queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    @Transactional(readOnly = true)
    Map<String, Object> findAllUnactedExportBillsTsd(username, userrole, maxRows, rowOffset, currentPage) {
        String methodName = "findAllExportBillsTsdByUser"

        Map<String, Object> param = [userid: username, userrole: userrole]
        def queryResult = queryService.executeQuery(unactedFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
}
