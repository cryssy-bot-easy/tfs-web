class UrlMappings {

	static mappings = {
		
		//unauthorized
		"/unauthorized"(controller:"unauthorized", action:"unauthorized")
		
		//unacted transactions
		"/unacted_transactions"(controller:"unactedTransactions", action:"viewUnacted")

        // ets inquiry
        "/inquiry/ets"(controller: "inquiry", action: "viewEtsInquiry")
        // lc inquiry
        "/inquiry/lc"(controller: "inquiry", action: "viewLcInquiry")
        // non lc inquiry
        "/inquiry/non_lc"(controller: "inquiry", action: "viewNonLcInquiry")
        // negotiation inquiry
        "/inquiry/lc/negotiation"(controller: "inquiry", action: "viewNegotiationInquiry")
        // md application inquiry
        "/inquiry/md/application"(controller: "inquiry", action: "viewMdApplicationInquiry")
        // md collection inquiry
        "/inquiry/md/collection"(controller: "inquiry", action: "viewMdCollectionInquiry")
        // bgbe inquiry
        "/inquiry/bgbe"(controller: "inquiry", action: "viewBgInquiry")
		
        // lc - ets - opening
        "/lc/ets/opening"(controller: "lcEtsOpening", action: "viewOpening")
		
		"/lc/dataentry/opening"(controller: "lcDataEntryOpening", action: "viewOpening")
		
		"/lc/payment/opening"(controller: "lcChargesOpening", action: "viewOpening")
		
		// lc - ets - cancellation
		"/lc/ets/cancellation"(controller: "lcEtsCancellation", action: "viewCancellation")
		
		// lc - dataentry - cancellation
		"/lc/dataentry/cancellation"(controller: "lcDataEntryCancellation", action: "viewCancellation")
		
		// lc - ets - indemnity_issuance
		"/lc/ets/indemnity_issuance"(controller: "lcEtsIndemnityIssuance", action: "viewIndemnityIssuance")
		
		// lc - dataentry - indemnity_issuance
		"/lc/dataentry/indemnity_issuance"(controller: "lcDataEntryIndemnityIssuance", action: "viewIndemnityIssuance")
		
		// lc - charges - indemnity_issuance
		"/lc/payment/indemnity_issuance"(controller: "lcChargesIndemnityIssuance", action: "viewIndemnityIssuance")
		
		// lc - ets - negotiation
		"/lc/ets/negotiation"(controller: "lcEtsNegotiation", action: "viewNegotiation")
	
		// lc - dataentry - negotiation
		"/lc/dataentry/negotiation"(controller: "lcDataEntryNegotiation", action: "viewNegotiation")
		
		// lc - charges - negotiation
		"/lc/payment/negotiation"(controller: "lcChargesNegotiation", action: "viewNegotiation")
		
		// lc - dataentry - indemnity_cancellation
		"/lc/dataentry/indemnity_cancellation"(controller: "lcDataEntryIndemnityCancellation", action: "viewIndemnityCancellation")
		
		// lc - charges - indemnity_cancellation
		"/lc/payment/indemnity_cancellation"(controller: "lcChargesIndemnityCancellation", action: "viewIndemnityCancellation")
		
		// lc - dataentry - negotiation_discrepancy
		"/lc/dataentry/negotiation_discrepancy"(controller: "lcDataEntryNegotiationDiscrepancy", action: "viewNegotiationDiscrepancy")
		
		// lc - ets - adjustment
		"/lc/ets/adjustment"(controller: "lcEtsAdjustment", action: "viewAdjustment")
		
		// lc - Data Entry - adjustment
		"/lc/dataentry/adjustment"(controller: "lcDataEntryAdjustment", action: "viewAdjustment")
		
		// lc - charges - adjustment
		"/lc/payment/adjustment"(controller: "lcChargesAdjustment", action: "viewAdjustment")
		
		// lc - ets - amendment
		"/lc/ets/amendment"(controller: "lcEtsAmendment", action: "viewAmendment")
		
		// lc - Data Entry - amendment
		"/lc/dataentry/amendment"(controller: "lcDataEntryAmendment", action: "viewAmendment")
		
		// lc - charges - adjustment
		"/lc/payment/amendment"(controller: "lcChargesAmendment", action: "viewAmendment")

		// lc - ets - UA Loan Settlement
		"/lc/ets/ua_loan_settlement"(controller: "lcEtsUaLoanSettlement", action: "viewUaLoanSettlement")
		
		// lc - Data Entry - UA Loan Settlement
		"/lc/dataentry/ua_loan_settlement"(controller: "lcDataEntryUaLoanSettlement", action: "viewSettlement")
		
		// lc - charges - UA Loan Settlement
		"/lc/payment/ua_loan_settlement"(controller: "lcChargesUaLoanSettlement", action: "viewSettlement")
		
		// lc - ets - UA Loan Maturity Adjustment
		"/lc/ets/ua_loan_maturity_adjustment"(controller: "lcEtsUaLoanMaturityAdjustment", action: "viewMaturityAdjustment")
		
		// lc - Data Entry - UA Loan Maturity Adjustment
		"/lc/dataentry/ua_loan_maturity_adjustment"(controller: "lcDataEntryUaLoanMaturityAdjustment", action: "viewMaturityAdjustment")
		
		// lc - charges - UA Loan Maturity Adjustment
		"/lc/payment/ua_loan_maturity_adjustment"(controller: "lcChargesUaLoanMaturityAdjustment", action: "viewMaturityAdjustment")
		
		
		
		/***OTHER IMPORTS***/
		
		//dataentry - AP Monitoring
		"/other_imports/dataentry/ap_monitoring"(controller:'dataentryApMonitoring', action:'viewApMonitoringDataentry')

        // setup ap
        "/ap/dataentry/setup"(controller: "apDataEntrySetup", action: "viewSetup")
		
		//dataentry - AR Monitoring
		"/other_imports/dataentry/ar_monitoring"(controller:'dataentryArMonitoring', action:'viewArMonitoringDataentry')
		
		//data entry - import advance
		"/other_imports/dataentry/import_advance"(controller:'dataentryImportAdvance', action:'viewImportAdvanceDataentry')
		
		//data entry - MD
		"/other_imports/dataentry/md"(controller:'dataentryMD', action:'viewMdDataentry')
		
		//data entry - Processing of Rebates 
		"/other_imports/dataentry/processing_rebates"(controller:'dataentryProcessingRebates', action:'viewProcessingRebatesDataentry')
		
		//data entry - Settlement of Actual Corres Charges
		"/other_imports/dataentry/settlement_actual_corres_charges"(controller:'dataentrySettlementActualCorresCharges', action:'viewSettlementActualCorresDataentry')
		
		//data entry - Payment of Other Import Charges
		"/other_imports/dataentry/other_import_charges"(controller:'dataentryPaymentOtherImportCharges', action:'viewPaymentOtherImportChargesDataentry')
		
		//data entry - Refund of Cash Lc
		"/other_imports/dataentry/refund_cash_lc"(controller:'dataentryRefundOfCashLc', action:'viewRefundOfCashLcDataentry')
		
		
		
		/** INQUIRY **/
		
		//inquiry - Settlement of Actual Corres Charges
		"/other_imports/main/inquiry/settlement_actual_corres_charges"(controller:'inquirySettlementActualCorresCharges', action:'viewSettlementActualCorresChargesInquiry')
		
		//inquiry - Payment of Other Import Charges
		"/other_imports/main/inquiry/other_import_charges"(controller:'inquiryPaymentOtherImportCharges', action:'viewPaymentOtherImportChargesInquiry')
		
		//inquiry - MT Message MT Monitoring
		"/other_imports/main/inquiry/mt_monitoring"(controller:'inquiryMtMonitoring', action:'viewMtMonitoringInquiry')
		
		//MT Monitoring page
		"/other_imports/main/outgoing_mt_messages"(controller:'mtMonitoringPage', action:'viewMtMonitoringPage')

        // non lc
        // ets
        "/da/ets/settlement"(controller: "daEtsSettlement", action: "viewSettlement")

        "/dp/ets/settlement"(controller: "dpEtsSettlement", action: "viewSettlement")

        "/dr/ets/settlement"(controller: "drEtsSettlement", action: "viewSettlement")

        "/oa/ets/cancellation"(controller: "oaEtsSettlement", action: "viewCancellation")

        // data entry
        "/da/dataentry/settlement"(controller: "daDataEntrySettlement", action: "viewSettlement")

        "/dp/dataentry/settlement"(controller: "dpDataEntrySettlement", action: "viewSettlement")

        "/dr/dataentry/settlement"(controller: "drDataEntrySettlement", action: "viewSettlement")

        "/oa/dataentry/cancellation"(controller: "oaDataEntryCancellation", action: "viewCancellation")

        // payment processing
        "/da/payment/settlement"(controller: "daChargesSettlement", action: "viewSettlement")

        "/dp/payment/settlement"(controller: "dpChargesSettlement", action: "viewSettlement")

        "/dr/payment/settlement"(controller: "drChargesSettlement", action: "viewSettlement")

        "/oa/payment/cancellation"(controller: "oaChargesSettlement", action: "viewCancellation")
				
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"login", action:"index")
		"500"(view:'/error')
	}
}
