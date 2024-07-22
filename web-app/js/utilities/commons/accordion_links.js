/**
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy
	[Revised by:] John Patrick C. Bautista
	[Date revised:] 09/21/2017
	Program [Revision] Details: Added script to show View Transaction AE link under certain conditions (for DM LC Regular(Usance/Sight) Nego Discrepancy & FX LC Cash Nego Discrepancy)
	Member Type: JavaScript file (JS)
	Project: WEB
	Project Name: accordion_links.js
 */

function viewApprovedEtsLink() {

	var documentType = $("#documentType").val();
	var documentClass = $("#documentClass").val();
	var serviceType = $("#serviceType").val();
	
	if(documentClass == "EXPORT_ADVISING") {
		$(".viewApprovedEtsLink").hide();
	}
	if((documentClass == "DA" || documentClass == "DP" || documentClass == 'INDEMNITY') && serviceType == "Cancellation") {
		$(".viewApprovedEtsLink").hide();
	}
	if((documentClass == "DA" || documentClass == "DP") && (serviceType == "Negotiation" || serviceType == "Negotiation Acknowledgement" || serviceType == "Negotiation Acceptance")) {
		$(".viewApprovedEtsLink").hide();
	}
	if(tsdInitiated == "true") {
		$(".viewApprovedEtsLink").hide();
	}
	if(documentType == "DOMESTIC" && documentClass == "BC" && serviceType == "NEGOTIATION") {
		$(".viewApprovedEtsLink").hide();
	}
	if((documentClass == "AR" && serviceType == "Setup") || (serviceType == "PAYMENT_OTHER")) {
		$(".viewApprovedEtsLink").hide();
	}
}


function viewPayTransactionLink() {
	var documentType = $("#documentType").val();
	var documentSubType1 = $("#documentSubType1").val();
	var documentClass = $("#documentClass").val();
	var serviceType = $("#serviceType").val();
	
	if(serviceType == "Cancellation" || serviceType == "Negotiation" || serviceType == "Negotiation Acknowledgement" || serviceType == "Negotiation Acceptance") {
		if(documentClass == "DA" || documentClass == "DP" || documentClass == "DR" || documentClass == "OA") {
			$(".viewPayTransactionLink").hide();
		}
	} 
	if(documentType == "DOMESTIC" && documentSubType1 == "STANDBY" && documentClass == "LC" && serviceType == "Adjustment") {	
		$(".viewPayTransactionLink").hide();
	}
	if(serviceType == "Negotiation") {		
		if(documentClass == "DP") {		
			$(".viewPayTransactionLink").hide();
		}
	}
	if(documentClass == "LC" && serviceType == "Adjustment" && $("input[name=partialCashSettlementFlagBox]").attr("checked") != "checked") {	
		$(".viewPayTransactionLink").hide();
	}
//	if(documentType == "DOMESTIC" && documentClass == "DP" && serviceType == "Settlement" &&  settleFlag == "Y") {
//		$(".viewPayTransactionLink").hide();
//	} 
	if (documentClass == "MD" && serviceType == "Collection") {
		$(".viewPayTransactionLink").hide();
	}
	if(tsdInitiated == "true" && serviceType == "Amendment") {
		$(".viewPayTransactionLink").hide();
	}
	if(serviceType == "Negotiation Discrepancy" || serviceType == "Negotiation_Discrepancy" || serviceType == "NEGOTIATION_DISCREPANCY") {
		$(".viewPayTransactionLink").hide();
	}
	if(documentType == "DOMESTIC" && documentClass == "BC" && serviceType == "NEGOTIATION") {
		$(".viewPayTransactionLink").hide();
	}
	if(documentClass != "INDEMNITY" && serviceType == "Cancellation") {
		$(".viewPayTransactionLink").hide();
	}
	if(documentClass == "EXPORT_ADVISING" && $("#documentNumber").val() == "") {
		$(".viewPayTransactionLink").hide();
	}
	if(documentClass == "EXPORT_ADVISING" && $("#userRoleId").val() == "TSDO" && (paymentStatus == "UNPAID" || paymentStatus == "NO_PAYMENT_REQUIRED")) {
		$(".viewPayTransactionLink").hide();
	}
	if(documentClass == "CORRES_CHARGE" && serviceType == "SETTLEMENT") {
		$(".viewPayTransactionLink").hide();
	}
	if(documentClass == "INDEMNITY" && serviceType == "Cancellation" && $("input[type=radio][name=clientInitiatedFlag]:checked").val() != "N") {
		$(".viewPayTransactionLink").hide();
	}
	if((documentClass == "AR" && (serviceType == "Setup" || serviceType == "SETTLE")) || (serviceType == "PAYMENT_OTHER")) {
		$(".viewPayTransactionLink").hide();
	}
	if(documentClass == "AP" && (serviceType == "Apply" || serviceType == "Setup" || serviceType == "Refund")) {
		$(".viewPayTransactionLink").hide();
	} 
	if((documentClass == "IMPORT_CHARGES" || documentClass == "EXPORT_CHARGES") && serviceType == "PAYMENT") {
		$(".viewPayTransactionLink").hide();
	}
}

function viewPaymentAccountingEntriesLink() {

	var documentType = $("#documentType").val();
	var documentClass = $("#documentClass").val();
	var documentSubType1 = $("#documentSubType1").val();
	var serviceType = $("#serviceType").val();
	
	if((documentClass == "LC" && (serviceType != "Negotiation Discrepancy" && serviceType != "Negotiation_Discrepancy" && serviceType != "NEGOTIATION_DISCREPANCY")) || documentClass == "MD") {
		$(".showPaymentAccountingEntriesLink").show();
//    } if((documentClass != 'LC' && serviceType == 'Settlement') && (documentType == "FOREIGN" || (documentType == "DOMESTIC" && settleFlag == "N"))) {
	} if((documentClass != 'LC' && serviceType == 'Settlement') && (documentType == "FOREIGN" || documentType == "DOMESTIC")) {
        $(".showPaymentAccountingEntriesLink").show();
//    } if(documentType == 'DOMESTIC' && documentClass == 'DP' && serviceType == 'Settlement' &&  settleFlag == 'Y') {
//    } if(documentType == 'DOMESTIC' && documentClass == 'DP' && serviceType == 'Settlement') {
//        $(".showPaymentAccountingEntriesLink").hide();
	} if(documentClass == 'LC' && serviceType == 'Cancellation') {
		$(".showPaymentAccountingEntriesLink").hide();
	} if(documentSubType1 == "STANDBY" && documentClass == "LC" && serviceType == "Adjustment") {	
		$(".showPaymentAccountingEntriesLink").hide();
	} if(documentSubType1 == "REGULAR" && documentClass == "LC" && serviceType == "Adjustment" && partialCashSettlementFlag != "partialCashSettlementEnabled") {	
		$(".showPaymentAccountingEntriesLink").hide();
	} if(documentClass == "EXPORT_ADVISING") {
		$(".showPaymentAccountingEntriesLink").show();
	} if(documentClass == "CORRES_CHARGE" && serviceType == "SETTLEMENT" && tsdInitiated != true) {
		$(".showPaymentAccountingEntriesLink").show();
	} if(documentClass == "INDEMNITY" && serviceType == "Issuance" && ($("#transportMedium").val() == "AIR" || $("#transportMedium").val() == "SEA")) {
		$(".showPaymentAccountingEntriesLink").show();
	} if(documentClass == "INDEMNITY" && serviceType == "Cancellation" && $("input[type=radio][name=clientInitiatedFlag]:checked").val() == "N") {
		$(".showPaymentAccountingEntriesLink").show();
	} if(documentType == "FOREIGN" && (documentClass == "BC" || documentClass == "BP") && serviceType != "CANCELLATION") {
		$(".showPaymentAccountingEntriesLink").show();
	} if(documentClass == "REBATE" && (serviceType == "PROCESS" || serviceType == "REBATE")) {
		$(".showPaymentAccountingEntriesLink").show();
	} if((documentClass == "IMPORT_ADVANCE" || documentClass == "CDT") && serviceType == "PAYMENT") {
		$(".showPaymentAccountingEntriesLink").show();
	} if((documentClass == "IMPORT_CHARGES" || documentClass == "EXPORT_CHARGES") && (serviceType == "PAYMENT" || serviceType == "PAYMENT_OTHER")) {
		$(".showPaymentAccountingEntriesLink").show();
	}if(documentClass == "AP" && (serviceType == "Apply" || serviceType == "Setup")) {
		$(".showPaymentAccountingEntriesLink").show();
	}  if((documentClass == "CDT" && serviceType == "REMITTANCE")) {
		$(".showPaymentAccountingEntriesLink").show();
		$(".viewDebitMemo").attr('id', 'viewDebitMemoPayment');
		$(".viewDebitMemo").removeClass("disableDebitMemo");
	} 
	
	if(reinstateFlag == "Y") {
		$(".showPaymentAccountingEntriesLink").show();
	}
}

function viewTransactionAccountingEntriesLink() {

	var documentClass = $("#documentClass").val();
	var documentType = $("#documentType").val();
	var documentSubType1 = $("#documentSubType1").val();
	
	if($("#serviceType").val() != undefined){
		var serviceType = $("#serviceType").val().toUpperCase();
	} else {
		var serviceType;
	}
	
	if(documentClass == 'LC' && documentSubType1 != 'CASH') {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentClass == 'LC' && (serviceType == 'UA LOAN SETTLEMENT')) {
		$(".showTransactionAccountingEntriesLink").hide();
	} if(documentClass == 'LC' && documentType == 'FOREIGN' && serviceType == 'OPENING') {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentClass == 'DP') {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentClass == 'DA' && (serviceType == 'NEGOTIATION ACCEPTANCE' || serviceType == 'SETTLEMENT')) {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentClass == 'DA' && serviceType == 'CANCELLATION' && productStatus != 'ACKNOWLEDGED') {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentClass == 'LC' && documentType == 'DOMESTIC' && documentSubType1 == 'CASH' && (serviceType == 'NEGOTIATION_DISCREPANCY' || serviceType == 'NEGOTIATION DISCREPANCY' || serviceType == 'NEGOTIATION_DISCREPANCY')) {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentSubType1 == "STANDBY" && documentClass == "LC" && serviceType == "ADJUSTMENT") {	
		$(".showTransactionAccountingEntriesLink").show();//for adjustment of tagging
	} if(documentSubType1 == "REGULAR" && documentClass == "LC" && serviceType == "ADJUSTMENT" && partialCashSettlementFlag != "partialCashSettlementEnabled") {	
		$(".showTransactionAccountingEntriesLink").hide();
	} if(documentSubType1 == "REGULAR" && documentClass == "LC" && serviceType == "UA LOAN MATURITY ADJUSTMENT") {	
		$(".showTransactionAccountingEntriesLink").hide();
	} /* if(documentClass == 'LC' && documentType == 'FOREIGN' && serviceType == 'CANCELLATION') {
		$(".showTransactionAccountingEntriesLink").show();
	} */
	if(documentClass == "INDEMNITY" && serviceType == "ISSUANCE" && $("#transportMedium").val() == "SEA") {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentClass == "INDEMNITY" && serviceType == "CANCELLATION") {
		$(".showTransactionAccountingEntriesLink").show();
	} if(documentClass == "BC" && (serviceType == "NEGOTIATION" || serviceType == "CANCELLATION")) {
		$(".showTransactionAccountingEntriesLink").show();
	}  if(documentClass == 'LC' && documentType == 'DOMESTIC' && documentSubType1 == 'REGULAR' && (serviceType == 'NEGOTIATION_DISCREPANCY' || serviceType == 'NEGOTIATION DISCREPANCY' || serviceType == 'NEGOTIATION_DISCREPANCY')) {
		$(".showTransactionAccountingEntriesLink").hide();
	} if(documentType == "FOREIGN" && (documentClass == "BC" || documentClass == "BP")) {
		$(".showTransactionAccountingEntriesLink").show();
	} if((documentClass == "IMPORT_ADVANCE" || documentClass == "CDT") && serviceType == "PAYMENT") {
		$(".showTransactionAccountingEntriesLink").show();
	} if( documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "REGULAR" && (serviceType == 'NEGOTIATION_DISCREPANCY' || serviceType == 'NEGOTIATION DISCREPANCY' || serviceType == 'NEGOTIATION_DISCREPANCY') ){
		$(".showTransactionAccountingEntriesLink").show();
	} if( documentClass == "LC" && documentType == "FOREIGN" && documentSubType1 == "CASH" && (serviceType == 'NEGOTIATION_DISCREPANCY' || serviceType == 'NEGOTIATION DISCREPANCY' || serviceType == 'NEGOTIATION_DISCREPANCY') ){
		$(".showTransactionAccountingEntriesLink").show();
	}
	
	if(reinstateFlag == "Y") {
		$(".showTransactionAccountingEntriesLink").show();
	}
}

function enableDisableAccountingentriesLink() {
	var count = 0;

    var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
    $.each(gridDataCashPayment,function(idx, data) {
		if(data.status == "Not Paid"){
			count = count + 1;			
		}
	});
    
    	
	var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
	$.each(gridDataChargesPayment,function(idx, data) {	
				
		if(data.status == "Not Paid"){
			count = count + 1;
		}
	});
	
	if($("#documentClass").val() == "CDT" && $("#serviceType").val() == "PAYMENT") {
		var gridDataCdtPayment = $("#grid_list_payment_cdt").jqGrid("getRowData");
		$.each(gridDataCdtPayment,function(idx, data) {	
			if(data.status == "Not Paid"){
				count = count + 1;
			}
		});
	}
	
	if(count >= 1){ 
		$(".enablePaymentAccountingEntries").removeAttr("id");
		$(".enablePaymentAccountingEntries").addClass("disableAccountingEntries");
		$(".enableTransactionAccountingEntries").removeAttr("id");
		$(".enableTransactionAccountingEntries").addClass("disableAccountingEntries");
		
	}
	
	else {
		$(".enablePaymentAccountingEntries").attr("id", "openAccountingEntries");
		$(".enablePaymentAccountingEntries").removeClass("disableAccountingEntries");
		$(".enableTransactionAccountingEntries").attr("id", "openTransactionAccountingEntries");
		$(".enableTransactionAccountingEntries").removeClass("disableAccountingEntries");
			validateAccountingEntries();
	}
	
	
}


$(document).ready(function() {
	$(".viewApprovedEtsLink").show();
	$(".viewPayTransactionLink").show();
	$(".showPaymentAccountingEntriesLink").hide();
	$(".showTransactionAccountingEntriesLink").hide();

	viewApprovedEtsLink();
	viewPayTransactionLink();
	viewPaymentAccountingEntriesLink();
	viewTransactionAccountingEntriesLink();
	
	if($("#referenceType").val() == "DATA_ENTRY") {
		enableDisableAccountingentriesLink();
	}
	
});
