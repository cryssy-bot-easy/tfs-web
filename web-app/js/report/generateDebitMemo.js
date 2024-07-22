	//@js/gsp
	
	 
/** PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: generateDebitMemoReport.js
 */
/** 	(revision)
		[Created by:] Rafael T. Poblete
		[Date Modified:] March 6, 2018
		Program [Revision] Details: Added handling of null or no decimal remittance amount value.
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: generateDebitMemoReport.js
 */

function generateDebitMemoReport(){
			
	var tmpDebitMemoUrl = debitMemoUrl;
	
	if($("#documentClass").val() == "CDT" && $("#serviceType").val() == "PAYMENT") {
		tmpDebitMemoUrl += "?debitMemoType=debitMemoCdtPayment";
		tmpDebitMemoUrl += "&cdtPaymentClientName=" + $("#cdtPaymentClientName").val().split('\.').join('').split(',').join('').split('&').join('ampersand');
		tmpDebitMemoUrl += "&defaultBankCharge=" + $("#defaultBankCharge").val();
		tmpDebitMemoUrl += "&transactionReferenceNumber=" + $("#transactionReferenceNumber").val();
		tmpDebitMemoUrl += "&paymentReferenceNumber=" + $("#paymentReferenceNumber").val();
		tmpDebitMemoUrl += "&cdtPaymentPaidDate=" + $("#cdtPaymentPaidDate").val();
	} else if($("#documentClass").val() == "CDT" && $("#serviceType").val() == "REMITTANCE") {
		var remittanceAmount = $("#remittanceAmount").val();
		if ($("#remittanceAmount").val() === '') { remittanceAmount = "0.00"; }
		tmpDebitMemoUrl += "?debitMemoType=debitMemoCdtRemittance";
		tmpDebitMemoUrl += "&processDate=" + $("#processDate").val();
		tmpDebitMemoUrl += "&remittanceAmount=" + remittanceAmount;
		tmpDebitMemoUrl += "&bocAccount=" + $("#bocAccount").val();
		tmpDebitMemoUrl += "&bocAccountName=" + $("#bocAccountName").val();
	} else if($("#documentClass").val() == "CDT" && $("#serviceType").val() == "REFUND") {
		tmpDebitMemoUrl += "?debitMemoType=debitMemoCdtRefund";
		tmpDebitMemoUrl += "&processDate=" + $("#processDate").val();
		tmpDebitMemoUrl += "&transactionReferenceNumber=" + $("#transactionReferenceNumber").val();
		tmpDebitMemoUrl += "&bocAccountName=" + $("#bocAccountName").val();
		tmpDebitMemoUrl += "&currency=" + $("#currency").val();
		tmpDebitMemoUrl += "&totalAmountOfPayment=" + $("#totalAmountOfPayment").val();
		tmpDebitMemoUrl += "&bocAccountNumber=" + $("#bocAccountNumber").val();
	} else {
		tmpDebitMemoUrl += "?debitMemoType=debitMemo";
		tmpDebitMemoUrl += "&importerLongNameDebit=" + $("#importerLongNameDebit").val();
		if($("#debitNameProduct1").val() != "") {
			tmpDebitMemoUrl += "&debitNameProduct1=" + $("#debitNameProduct1").val();
			tmpDebitMemoUrl += "&debitNameCheck1=" + $("input[name=debitNameCheck1]").attr("checked");
		} if($("#debitNameProduct1").val() != "") {
			tmpDebitMemoUrl += "&debitNameProduct2=" + $("#debitNameProduct2").val();
			tmpDebitMemoUrl += "&debitNameCheck2=" + $("input[name=debitNameCheck2]").attr("checked");
		} if($("#debitNameProduct1").val() != "") {
			tmpDebitMemoUrl += "&debitNameProduct3=" + $("#debitNameProduct3").val();
			tmpDebitMemoUrl += "&debitNameCheck3=" + $("input[name=debitNameCheck3]").attr("checked");
		} if($("#debitNameCharges1").val() != "") {
			tmpDebitMemoUrl += "&debitNameCharges1=" + $("#debitNameCharges1").val();
			tmpDebitMemoUrl += "&debitNameCheck4=" + $("input[name=debitNameCheck4]").attr("checked");
		} if($("#debitNameCharges2").val() != "") {
			tmpDebitMemoUrl += "&debitNameCharges2=" + $("#debitNameCharges2").val();
			tmpDebitMemoUrl += "&debitNameCheck5=" + $("input[name=debitNameCheck5]").attr("checked");
		} if($("#debitNameCharges3").val() != "") {
			tmpDebitMemoUrl += "&debitNameCharges3=" + $("#debitNameCharges3").val();
			tmpDebitMemoUrl += "&debitNameCheck6=" + $("input[name=debitNameCheck6]").attr("checked");
		}
	}
	
	tmpDebitMemoUrl += "&documentNumber=" + $("#documentNumber").val();
	tmpDebitMemoUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpDebitMemoUrl += "&preparedByFirstName=" + $("#preparedByFirstName").val();
	tmpDebitMemoUrl += "&preparedByLastName=" + $("#preparedByLastName").val();
	tmpDebitMemoUrl += "&userRoleId=" + $("#userRoleId").val();

	window.open(tmpDebitMemoUrl);
}

function debitMemoNameCheck() {
	$(".debitNameRow1").show();
	$(".debitNameRow2").show();
	$(".debitNameRow3").show();
	$(".debitNameRow4").show();
	$(".debitNameRow5").show();
	$(".debitNameRow6").show();
	
	if($("#debitNameProduct1").val() == "") {
		$(".debitNameRow1").hide();
	} if($("#debitNameProduct2").val() == "") {
		$(".debitNameRow2").hide();
	} if($("#debitNameProduct3").val() == "") {
		$(".debitNameRow3").hide();
	} if($("#debitNameCharges1").val() == "") {
		$(".debitNameRow4").hide();
	} if($("#debitNameCharges2").val() == "") {
		$(".debitNameRow5").hide();
	} if($("#debitNameCharges3").val() == "") {
		$(".debitNameRow6").hide();
	}
}

function showDebitMemo() {
//	var cashLCPayment = false;
//	var chargesPayment = false;
	
	var count = 0;

	var debitNameProductCount = 0;
	var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	$.each(gridDataCashPayment,function(idx, data) {
		if(data.modeOfPayment.indexOf("CASA") != -1 && data.status == "Paid"){
			count = count + 1;
		} 
		
		if(data.modeOfPayment.indexOf("CASA") != -1){
			debitNameProductCount = debitNameProductCount + 1;
			if(data.status == "Paid") {
				$("#debitNameProduct" + debitNameProductCount).val(data.accountName);
			} else {
				$("#debitNameProduct" + debitNameProductCount).val("");
			}
			debitMemoNameCheck();
		}
	});

	var debitNameChargesCount = 0;
	var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
	$.each(gridDataChargesPayment,function(idx, data) {	
		if(data.modeOfPayment.indexOf("CASA") != -1 && data.status == "Paid"){
			count = count + 1;
		} 
		
		if(data.modeOfPayment.indexOf("CASA") != -1){
			debitNameChargesCount = debitNameChargesCount + 1;
			if(data.status == "Paid") {
				$("#debitNameCharges" + debitNameChargesCount).val(data.accountName);
			} else {
				$("#debitNameCharges" + debitNameChargesCount).val("");
			}
			debitMemoNameCheck();
		}
	});
	
	var gridDataCdtPayment = $("#grid_list_payment_cdt").jqGrid("getRowData");
	$.each(gridDataCdtPayment,function(idx, data) {	
		if(data.modeOfPayment.indexOf("CASA") != -1 && (data.status == "Paid" || data.status == "Accepted")){
			count = count + 1;
		}
		$("#cdtPaymentPaidDate").val(data.paidDate);
	});
	
	if(count >= 1){ 
		$(".viewDebitMemo").attr('id', 'viewDebitMemoPayment');
		$(".viewDebitMemo").removeClass("disableDebitMemo");
	}
	
	else {
		$(".viewDebitMemo").removeAttr('id');
		$(".viewDebitMemo").addClass("disableDebitMemo");
	}
}

$(document).ready(function() {
//	$("#grid_list_cash_payment_summary").mouseover(showDebitMemo);
//	$("#grid_list_charges_payment").mouseover(showDebitMemo);
	
//	$("#viewDebitMemoPayment").live("click",function(){
	if($("#documentClass").val() == "CDT") {
		$("#viewDebitMemoPayment").live("click",function(){
			generateDebitMemoReport();
		});
	} else {
		$(".generateDebitMemo").live("click",function(){
			generateDebitMemoReport();
		});
	}
});
