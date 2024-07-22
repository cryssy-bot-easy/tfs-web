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
		Project Name: generateCreditMemoReport.js
 */
function generateCreditMemoReport(){
	
	var tmpCreditMemoUrl = creditMemoUrl;
	
	if(referenceType == "TRANSACTIONS" ) {
		tmpCreditMemoUrl += "?creditMemoType=creditMemoCdtSendToBoc";
		//transaction checking on values per id
		if(!$("#mobBocAccountNumberSend").val() == "" || !$("#mobBocAccountNumberSend").val() == null)
		tmpCreditMemoUrl += "&mobBocAccountNumberSend=" + $("#mobBocAccountNumberSend").val();
		else
		tmpCreditMemoUrl += "&mobBocAccountNumberSend=" + $("#lastAccountNumberUploadHistory").val();
		if(!$("#accountNameSend").val() == "" || !$("#accountNameSend").val() == null)		
		tmpCreditMemoUrl += "&accountNameSend=" + $("#accountNameSend").val();
		else
		tmpCreditMemoUrl += "&accountNameSend=" + $("#lastAccountNameUploadHistory").val();
		//transaction checking on values per id
		tmpCreditMemoUrl += "&totalAmountCollectedTFS=" + $("#totalAmountCollectedTFS").val();
		
	} else if($("#documentClass").val() == "CDT" && $("#serviceType").val() == "REFUND") {
		tmpCreditMemoUrl += "?creditMemoType=creditMemoCdtRefund";
		tmpCreditMemoUrl += "&processDate=" + $("#processDate").val();
		tmpCreditMemoUrl += "&transactionReferenceNumber=" + $("#transactionReferenceNumber").val();
		tmpCreditMemoUrl += "&totalAmountOfPayment=" + $("#totalAmountOfPayment").val();
		tmpCreditMemoUrl += "&cdtRefundAccountNumber=" + $("#cdtRefundAccountNumber").val();
		tmpCreditMemoUrl += "&accountNameCdtRefund=" + $("#accountNameCdtRefund").val();
	} else {
		tmpCreditMemoUrl += "?creditMemoType=creditMemo";
	}
	
	tmpCreditMemoUrl += "&documentNumber=" + $("#documentNumber").val();
	tmpCreditMemoUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpCreditMemoUrl += "&documentSubType1=" + $("#documentSubType1").val();
	tmpCreditMemoUrl += "&documentClass=" + $("#documentClass").val();
	tmpCreditMemoUrl += "&referenceType=" + referenceType;
	tmpCreditMemoUrl += "&preparedByFirstName=" + $("#preparedByFirstName").val();
	tmpCreditMemoUrl += "&preparedByLastName=" + $("#preparedByLastName").val();
	tmpCreditMemoUrl += "&userRoleId=" + $("#userRoleId").val();
	
	window.open(tmpCreditMemoUrl);

}

function showCreditMemo() {
	var proceeds = false;
	
	var gridDataProceedsTeller = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
	$.each(gridDataProceedsTeller,function(idx, data) {
		if(data.modeOfPayment.indexOf("CASA") != -1 && data.status == "Paid"){
			$(".viewCreditMemo").attr("id", "viewCreditMemo");
			$(".viewCreditMemo").removeClass("disableCreditMemo");
			proceeds = true;
			
		}
		else if(data.modeOfPayment.indexOf("CASA") != -1 && data.status == "Not Paid"){
			proceeds = false;
		}
	});
	
	var gridDataApRefund = $("#grid_list_refund_main").jqGrid("getRowData");
	$.each(gridDataApRefund,function(idx, data) {
		if(data.modeOfPayment.indexOf("CASA") != -1 && data.status == "Paid"){
			$(".viewCreditMemo").attr("id", "viewCreditMemo");
			$(".viewCreditMemo").removeClass("disableCreditMemo");
			proceeds = true;
			
		}
		else if(data.modeOfPayment.indexOf("CASA") != -1 && data.status == "Not Paid"){
			proceeds = false;
		}
	});
		
	if (proceeds == false){
		$(".viewCreditMemo").removeAttr("id");
		$(".viewCreditMemo").addClass("disableCreditMemo");
	}
}

$(document).ready(function() {
	$("#viewCreditMemo").live("click",function(){	
		generateCreditMemoReport();
	});
});