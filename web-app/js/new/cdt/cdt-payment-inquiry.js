/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 1/2/13
 * Time: 10:52 AM
 * To change this template use File | Settings | File Templates.
 */

 /**
	PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: cdt-payment-inquiry.js
 */
function viewCdtPayment(id) {

    location.href = viewCdtPaymentUrl + "?iedieirdNumber="+id;

}

function refundCdtPayment(id, processingUnitCode) {
	if(processingUnitCode == '909'){
		$.post(validateMultipleCdtTradeServiceUrl, {iedieirdNumber: id}, function(data) {
	
	        if (data.success == "true") {
	        	location.href = viewCdtRefundUrl + "?iedieirdNumber="+id+"&serviceType=REFUND"+"&forViewing=false";
	        } else {
	            triggerAlertMessage(data.message);
	        }
	    });  
	} else {
		location.href = viewCdtRefundUrl + "?iedieirdNumber="+id+"&serviceType=REFUND"+"&forViewing=false";
	}
}

function viewApprovedCdtRefund(id) {
	var gotoUrl = viewCdtRefundUrl;
	gotoUrl += "?iedieirdNumber="+id;
	gotoUrl += "&serviceType=REFUND";
	gotoUrl += "&viewMode=viewMode";
    gotoUrl += "&hasRoute=false";
    gotoUrl += "&forViewing=true";
    
    location.href = gotoUrl;
}

function searchCdtPaymentInquiry() {
    var postUrl = searchCdtPaymentUrl;
    postUrl += "?"+$("#cdtPaymentInquiryForm").serialize();
    $("#grid_list_cdt_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertCdtPaymentCount}).trigger("reloadGrid");
}

function alertCdtPaymentCount(){
	triggerAlertMessage($("#grid_list_cdt_inquiry").jqGrid('getGridParam', 'records') + " record/s found.");
	$("#grid_list_cdt_inquiry").jqGrid('setGridParam', {gridComplete: ""});
}

function resetCdtPaymentInquiry() {
    $("#paymentReferenceNumber, #iedNumber, #importerName, #unitCode, #requestType, #status, #transactionDateFrom, #transactionDateTo, #aabRefCode").val("");
    
    var postUrl = searchCdtPaymentUrl;
    $("#grid_list_cdt_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1 }).trigger("reloadGrid");
}

$(document).ready(function() {

    $("#searchCdtPaymentBtn").click(searchCdtPaymentInquiry);
    $("#resetCdtPaymentBtn").click(resetCdtPaymentInquiry);
});
