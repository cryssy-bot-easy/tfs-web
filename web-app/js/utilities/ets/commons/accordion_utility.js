 
/** PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: accordion_utility.js
 */

/** PROLOGUE:
	 * 	(revision)
		SCR/ER Number: 
		SCR/ER Description: 
		[Revised by:] John Patrick C. Bautista
		[Date Revised:] 08/16/2017
		Program [Revision] Details: Added scripts to pass url onclick of link.
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: accordion_utility.js
 */

if (!window.console) {
    console = {
        log: function(){
            // do nothing
            // this is to avoid errors in ie7
        }
    };
}

function onCdtUploadTransactionsClick() {
    location.href = cdtUploadTransactionUrl;
}

function onCdtUploadClientsClick() {
    location.href = cdtUploadClientsUrl;
}

function onCdtUploadPaymentHistoryClick() {
    location.href = cdtUploadPaymentHistoryUrl;
}

function openTransactionSelection() {
    $("input[name=createTransaction]").attr("checked", false);

    loadPopup("create_transaction_popup", "popupBackground_create_transaction");
    centerPopup("create_transaction_popup", "popupBackground_create_transaction");
    if($("#createEtsRedirect").attr("disabled") != "disabled"){
    	$("#createEtsRedirect").attr("disabled", "disabled");
    }
}

function viewMt700() {
    var formData = getFormInput('#importerExporterDetailsTabForm');
    $.extend(formData,getFormInput('#basicDetailsTabForm'));
    $.extend(formData,getFormInput('#chargesPaymentTabForm'));
    $.extend(formData,getFormInput('#additionalCondition1TabForm'));
    $.extend(formData,getFormInput('#shipmentOfGoodsTabForm'));

//    var formData = getFormData("#importerExporterDetailsTabForm","#basicDetailsTabForm","#additionalCondition1TabForm","#shipmentOfGoodsTabForm");
//    alert(formData);

    $.post(generateMtUrl, buildRequestString(formData), function(data) {
        $("#mt_message").val(data);
    });

    loadPopup("view_mt_popup", "view_mt_popup_bg");
    centerPopup("view_mt_popup", "view_mt_popup_bg");
}

function showMtPopup(){
    loadPopup("view_mt_popup", "view_mt_popup_bg");
    centerPopup("view_mt_popup", "view_mt_popup_bg");
}

function mtPreviewGenerationFailed(){
    triggerAlertMessage("Failed to generate swift message.");
}

function validateMtMessage(){
    $.post(generateMtUrl, {messageType : $("#mtType").val()}, function(data) {
        $("#mt_errors").val(data);
    });
}

function viewMt700(){
    $("#mt_message").val('');
    $.post(generateMt700Url, {mtType : '700'}, function(data) {
        $("#mt_message").val(data);
    });
    loadPopup("view_mt_popup", "view_mt_popup_bg");
    centerPopup("view_mt_popup", "view_mt_popup_bg");
}

function viewMt701(){
    $("#mt_message").val('');
    $.post(generateMt701Url, {mtType : '700'}, function(data) {
        $("#mt_message").val(data);
    });

    loadPopup("view_mt_popup", "view_mt_popup_bg");
    centerPopup("view_mt_popup", "view_mt_popup_bg");
}

function viewAmendmentUrl(type){
    $.post(generateAmendmentMtUrl, {mtType : type, documentNumber: $("#documentNumber").val()}, function(data) {
        $("#mt_message").val(data);
    });

    loadPopup("view_mt_popup", "view_mt_popup_bg");
    centerPopup("view_mt_popup", "view_mt_popup_bg");
}

function buildRequestString(collection){
    var requestString = "&";
    for (var prop in collection) {
        if (collection.hasOwnProperty(prop)) {
            requestString = requestString + prop + "=" + collection[prop] + "&"
        }
    }
    return requestString;
}

function getFormData(){
    var formData = "";
    for (var i = 0; i < arguments.length; i++) {
        formData = formData + $(arguments[i]).serialize();
    }
    return formData;
}

function getFormInput(formId){
    var form = $(formId);
    var postData = {};

    form.find(':input').each(function()
    {
        postData[$(this).attr('name')] = $(this).val();
    });
    return postData;
}

function createTransaction() {
    var dType = $("#documentType").val();
    var documentClass = $("#documentClass").val();
    var subType1 = $("#subType1").val();

    var locationUrl = etsOpeningUrl;
    locationUrl += "?documentType="+dType;
    locationUrl += "&documentClass="+documentClass;
    locationUrl += "&subType1="+subType1;
    location.href = locationUrl;
}

function cancelTransaction() {
    disablePopup("create_transaction_popup", "popupBackground_create_transaction");

}

//for accordion function
function accordionFunction(){

    var getSubTitle = $("#subtitle").text();

    $(".billingStatement").hide();
    $(".dataEntry").hide();
    $(".paymentProcess").hide();
    $(".viewApprovedEts").hide();
    $(".rebateInquiry").hide();

    
    


    
    if('undefined' !== typeof $(".unactedLink") && getSubTitle.indexOf("Unacted") != -1){
        $(".unactedLink").hide();
    }else{
        $(".unactedLink").show();
    }

//    if(username == "main"){
//    if(loggedInUser == "TSD") {
        $(".rebateInquiry").show();
        $(".panelSwift").show();
        $(".refund_export").hide();

//    }else{
//    } else if(loggedInUser == "BRANCH"){
        $(".rebateInquiry").hide();
        $(".panelSwift").hide();
        $(".refund_export").show();
//    }



    if(getSubTitle.indexOf("eTS") != -1){
    	$(".swift").hide();
    	$(".actions").show();
        //for other imports
        if(getSubTitle.indexOf("eTS - Data Entry") != -1){
            $(".dataEntry").show();
            $(".viewApprovedEts").hide();
            $("#paymentProcessingBtn").hide();
        }else{
            //for lc
            $("#etsPopup").attr("disabled","disabled");
            $(".billingStatement").show();
        }


        //for Data Entry
    }else if (getSubTitle.indexOf("Data Entry") != -1){

        $(".viewApprovedEts").show();
        $(".dataEntry").show();
        $("#etsPopup").removeAttr("disabled","disabled");
        $(".swift").show();
        $(".actions").show();
        //for Payment Processing
    }else if (getSubTitle.indexOf("Payment Processing") != -1){

        $(".paymentProcess").show();
        $(".viewApprovedEts").show();
        $("#etsPopup").removeAttr("disabled","disabled");
        $(".swift").hide();
        $(".actions").show();
    }else{
        $(".panelAction").hide();
        $("#etsPopup").attr("disabled","disabled");
        $(".swift").hide();
        $(".actions").hide();
    }

    //for inquiry
    if ((getSubTitle.indexOf("Inquiry") != -1) || (getSubTitle.indexOf("Custom Duties and Taxes") != -1)){
        $(".panelAction").hide();
        $("#etsPopup").attr("disabled","disabled");
    }

    if(getSubTitle.indexOf("Monitoring") != -1){
        $(".viewApprovedEts").hide();
        $(".payTransaction").hide();
        $(".transmittalLetter").hide();
        $(".paymentAccounting").hide();

    }

}


//go to ETS PAGE
function openApprovedEts(){
    var url = "";
    //var etsPopup = document.getElementById("etsPopup");


    if(serviceType == "Opening") {
        url = etsOpeningUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val();
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup



        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);



    }else if(serviceType == "Adjustment") {
        url = etsAdjustmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val();
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup


        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);


    }else if(serviceType == "UA Loan Maturity Adjustment" || serviceType == 'UA_LOAN_MATURITY_ADJUSTMENT') {
        url = etsMaturityAdjustmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val();
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup

        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);


    }else if(serviceType == "UA Loan Settlement" || serviceType == 'UA_LOAN_SETTLEMENT') {
        url = etsSettlementUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val();
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup

        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);


    }else if(serviceType == "Amendment") {
        url = etsAmendmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val();
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup

        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);


    }else if(serviceType == "Cancellation") {
        url = etsCancellationUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val();
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup

        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);


    }else if(serviceType == "Negotiation") {
        url = etsNegotiationUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val();
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup

        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);


    }else if(serviceType == "Indemnity Issuance") {
        url = etsIndemnityIssuanceUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();
        url += '&etsPopup='+$("#etsPopup").val(); // for view approved ets popup

        window.open(url, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);

    }

}

// go to payment processing page

function openPaymentProcessing(){

    //TODO here
    var url = "";

    if(serviceType == "Opening") {
        url = chargesOpeningUrl;
        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Adjustment") {
        url = chargesAdjustmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "UA Loan Maturity Adjustment" || serviceType == 'UA_LOAN_MATURITY_ADJUSTMENT') {
        url = chargesMAturityAdjustmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "UA Loan Settlement" || serviceType == 'UA_LOAN_SETTLEMENT') {
        url = chargesSettlementUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Amendment") {
        url = chargesAmendmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Negotiation") {
        url = chargesNegotiationUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Indemnity Issuance") {
        url = chargesIndemnityIssuanceUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "INDEMNITY Cancellation") {
        url = chargesIndemnityCancellationUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();



        location.href = url;
    }
}

// go to Data Entry Page 

function openDataEntry(){
    //TODO here
    var url = "";

    if(serviceType == "Opening") {
        url = dataEntryOpeningUrl;
        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Adjustment") {
        url = dataEntryAdjustmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "UA Loan Maturity Adjustment" || serviceType == 'UA_LOAN_MATURITY_ADJUSTMENT') {
        url = dataEntryMAturityAdjustmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "UA Loan Settlement" || serviceType == 'UA_LOAN_SETTLEMENT') {
        url = dataEntrySettlementUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Amendment") {
        url = dataEntryAmendmentUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Cancellation") {
        url = dataEntryCancellationUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Negotiation") {
        url = dataEntryNegotiationUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "Indemnity Issuance") {
        url = dataEntryIndemnityIssuanceUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();

        location.href = url;

    }else if(serviceType == "INDEMNITY Cancellation") {
        url = dataEntryIndemnityCancellationUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();



        location.href = url;

    }else if(serviceType == "Negotiation DISCREPANCY") {
        url = dataEntryNegotiationDiscrepancyUrl;

        url += '?serviceType='+$("#serviceType").val();
        url += '&documentType='+$("#documentType").val();
        url += '&documentClass='+$("#documentClass").val()
        url += '&subType1='+$("#subType1").val();
        url += '&subType2='+$("#subType2").val();



        location.href = url;
    }
}

//link to inquiry payment page
function otherImportChargesInquiry(){
    var url = "";

    url = paymentOtherImportChargesInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+'Inquiry';
    url += '&documentType='+'Payment';
    url += '&serviceType='+'Other%20Import%20Charges';
    location.href = url;
}

//link to inquiry settlement page
function actualCorresChargesInquiry(){
    var url = "";

    url = settlementActualCorresChargesInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+'Inquiry';
    url += '&documentType='+'Settlement';
    url += '&serviceType='+'Actual%20Corres%20Charges';
    location.href = url;
}

//link to inquiry advance payment
function importAdvancePaymentInquiry(){
    var url = "";

    url = importAdvancePaymentInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+'Inquiry';
    url += '&documentType='+'';
    url += '&serviceType='+'Import%20Advance%20Payment';
    location.href = url;

}

//link to inquiry cdt client
function cdtClientInquiry(){
    var url = "";

    url = cdtClientInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+'Inquiry%20Client';
    url += '&documentType='+'Collection';
    url += '&serviceType='+'Custom%20Duties%20and%20Taxes';
    location.href = url;

}

//link to inquiry cdt
function cdtInquiry(){
    var url = "";
    
    url = cdtInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+'Inquiry%20Payment';
    url += '&documentType='+'Collection';
    url += '&serviceType='+'Custom%20Duties%20and%20Taxes';
    location.href = url;
}

//link to AP Monitoring SetUp
//function setUpAccountsPayable(){
//    var url = "";
//
//    url = dataEntryApMonitoringUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+'Data Entry';
//    url += '&documentType='+'AP';
//    url += '&serviceType='+'Monitoring%20Setup';
//    location.href = url;
//}

//link to AR Monitoring SetUp
//function setUpAccountsRecievable(){
//    var url = "";
//
//    url = dataEntryArMonitoringUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+'Data Entry';
//    url += '&documentType='+'AR';
//    url += '&serviceType='+'Monitoring%20Setup';
//    location.href = url;
//}

// link to ap monitoring inquiry
//function apMonitoringInquiry(){
//    var url = "";
//
//    url = apMonitoringInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+'Inquiry';
//    url += '&documentType='+'AP';
//    url += '&serviceType='+'Monitoring';
//    location.href = url;
//}

//link to ar monitoring inquiry
//function arMonitoringInquiry(){
//    var url = "";
//
//    url = arMonitoringInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+'Inquiry';
//    url += '&documentType='+'AR';
//    url += '&serviceType='+'Monitoring';
//    location.href = url;
//}

//link to create rabate
function createRebate(){
    var gotourl = rebateUrl;

    location.href = gotourl;
}

//link to md collection inquiry
//function mdCollectionInquiry(){
//    var url = "";
//
//    url = mdCollectionInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+'Inquiry';
//    url += '&documentType='+'MD';
//    url += '&serviceType='+'Collection';
//    location.href = url;
//}

//link to md collection inquiry
//function mdApplicationInquiry(){
//    var url = "";
//
//    url = mdApplicationInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+'Inquiry';
//    url += '&documentType='+'MD';
//    url += '&serviceType='+'Application';
//
//    location.href = url;
//}

//link to remittance inquiry
function remittanceInquiry(){
    var url = "";

    url = remittanceInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+"Inquiry";
    url += '&documentType='+"Remittance";
    url += '&serviceType='+"Customs Duties and Taxes";
    location.href = url;
}

//link to remittance cdt 
function remittanceCdt(){
//    var url = "";
//
//    url = remittanceCdtUrl;
////    url += '?username='+$("#username").val();
//    url += '?serviceType='+"Customs Duties and Taxes";
//    url += '&documentType='+"Remittance";
//    url += '&referenceType='+"CDT";
//    location.href = url;
    location.href = cdtRemittance;
}


function remittanceCdtreport(){
	//    var url = "";
	//
	//    url = remittanceCdtUrl;
	////    url += '?username='+$("#username").val();
	//    url += '?serviceType='+"Customs Duties and Taxes";
	//    url += '&documentType='+"Remittance";
	//    url += '&referenceType='+"CDT";
	//    location.href = url;
	    location.href = viewReportcdtRemit;
	}

//link to upload client file cdt 
function uploadClientFileCdt(){
    var url = "";
   
    url = uploadClientFileCdtUrl;
//    url += '?username='+$("#username").val();
    url += '?serviceType='+"Customs Duties and Taxes";
    url += '&documentType='+"Collection";
    url += '&referenceType='+"Upload Client File";
    location.href = url;

}

//link to upload transaction cdt 
function uploadTransactionCdt(){
    var url = "";

    url = uploadTransactionsCdtUrl;
//    url += '?username='+$("#username").val();
//    url += '?serviceType='+"Customs Duties and Taxes";
//    url += '&documentType='+"Collection";
//    url += '&referenceType='+"Upload Transactions";
    //alert(url)
    //return true;
    location.href = url;

}

//link to upload payment history 
function uploadPaymentHistoryCdt(){
    var url = "";

    url = uploadPaymentHistoryCdtUrl;
//    url += '?username='+$("#username").val();
    url += '?serviceType='+"Customs Duties and Taxes";
    url += '&documentType='+"Collection";
    url += '&referenceType='+"Upload Payment History";
    location.href = url;

}

function onViewMt(mt){
    var url = "";

    if(mt == "103"){
    	
        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 103";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if(mt == "199"){

        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 199";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if(mt == "202"){

        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 202";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if(mt == "299"){

        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 299";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if(mt == "499"){


        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 499";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if(mt == "742"){

        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 742";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if(mt == "752"){

        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 752";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if (mt == "799"){

        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 799";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }

    else if (mt == "999"){

        url = mtMessagePageUrl;
//        url += '?username='+$("#username").val();
        url += '?referenceType='+"MT 999";
        url += '&documentType='+"Processing";
        url += '&serviceType='+"Other Outgoing MT";

        location.href = url;
    }
}

//link to ets inquiry
//function onEtsInquiry(){
//    var url="";
//
//    url = etsInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+"Inquiry";
//    url += '&documentType='+"eTS";
//    url += '&serviceType='+"";
//
//
//    location.href = url;
//}

//link to lc inquiry
//function onLcInquiry(){
//    var url="";
//
//    url = lcInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+"Inquiry";
//    url += '&documentType='+"LC";
//    url += '&serviceType='+"Document";
//    location.href = url;
//}

//function onNonLcInquiry(){
//    var url="";
//
//    url = nonLcInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+"Inquiry";
//    url += '&documentType='+"Non LC";
//    url += '&serviceType='+"Document";
//    location.href = url;
//}



//function onBgInquiry(){
//    var url ="";
//
//    url = bgInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+"Inquiry";
//    url += '&documentType='+"BG";
//    url += '&serviceType='+"";
//    location.href = url;
//}

//function onNegotiationInquiry(){
//    var url ="";
//
//    url = negotiationInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+"Inquiry";
//    url += '&documentType='+"Negotiation";
//    url += '&serviceType='+"";
//    location.href = url;
//}

//function onCancellationInquiry(){
//    var url ="";
//
//    url = cancellationInquiryUrl;
//    url += '?username='+$("#username").val();
//    url += '&referenceType='+"Inquiry";
//    url += '&documentType='+"Cancellation";
//    url += '&serviceType='+"";
//    location.href = url;
//}

function onRebateInquiry(){
    var url="";    
    url = rebateUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+"TSD";
    url += '&documentType='+"Rebate";
    url += '&serviceType='+"Inquiry";
    location.href = url;
}

//export bills inquiry
//link to inquiry cdt
function exportBillsInquiry(){
//    var url = "";
//    url = exportBillsUrl;
////    url += '?username='+username;
//    url += '?referenceType='+'Inquiry';
//    url += '&documentType='+'Export Bills';
//    url += '&serviceType='+'';
//    location.href = url;
    location.href = gotoSearchExportBillsUrl;
}

//
//
//
//
//
////go back to unacted
//function gotoUnacted(){
//    //unacted screen
//    var url ="";
//
//    url = unactedScreenUrl
//    url += '?username='+"main";
//
//    location.href = url;
//
//}

function onFirstAdvisingBankOpeningClick(){
    var url='';
    var serviceType = 'Opening';
    var subType1 = 'First';
    var referenceType = 'Data Entry'
    var documentClass = "Advise"
    url = dataEntryAdvisingBankOpeningUrl;
//    url += '?username='+username;
    url += '?referenceType='+referenceType;
    url += '&serviceType='+serviceType;
    url += '&documentClass=' +documentClass;
    url += '&subType1='+subType1;
    location.href = url;
}

function onSecondAdvisingBankOpeningClick(){
    var url='';
    var serviceType = 'Opening';
    var subType1 = 'Second';
    var referenceType = 'Data Entry'
    var documentClass = "Advise"
    url = dataEntryAdvisingBankOpeningUrl;
//    url += '?username='+username;
    url += '?referenceType='+referenceType;
    url += '&serviceType='+serviceType;
    url += '&documentClass=' + documentClass;
    url += '&subType1='+subType1;
    location.href = url;
}

function onAdvisingBankOpeningInquiryClick(){
    var url='';
    var serviceType = 'Opening';
    var referenceType = 'Inquiry';
    var documentType = 'Advising Bank';

    url = advisingBankInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+referenceType;
    url += '&serviceType='+serviceType;

    url += '&documentType='+documentType;
    location.href = url;
}

function onAdvisingBankAmendmentInquiryClick(){
    var url='';
    var serviceType = 'Amendment';
    var referenceType = 'Inquiry';
    var documentType = 'Advising Bank';
    url = advisingBankInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+referenceType;
    url += '&serviceType='+serviceType;
    url += '&documentType='+documentType;
    location.href = url;
}

function onAdvisingBankCancellationInquiryClick(){
    var url='';
    var serviceType = 'Cancellation';
    var referenceType = 'Inquiry';
    var documentType = 'Advising Bank';
    url = advisingBankInquiryUrl;
//    url += '?username='+$("#username").val();
    url += '?referenceType='+referenceType;
    url += '&serviceType='+serviceType;
    url += '&documentType='+documentType;
    location.href = url;
}

function onExportAdvanceInquiryClick(){
//    var url='';
//    var serviceType = 'Export Advance';
//    var referenceType = 'Inquiry';
//    var documentType = '';
//    url = exportAdvanceInquiryUrl;
////    url += '?username='+username;
//    url += '?referenceType='+referenceType;
//    url += '&serviceType='+serviceType;
//    url += '&documentType='+documentType;
//    location.href = url;
    location.href = exportAdvanceInquiryUrl;
}

function onRefundOtherExportChargesInquiryClick(){
    var url='';
    var serviceType = 'Refund';
    var referenceType = 'Inquiry';
    var documentType = 'Other Export Charges';
    url = OtherOfExportChargesInquiryUrl;
//    url += '?username='+username;
    url += '?referenceType='+referenceType;
    url += '&serviceType='+serviceType;
    url += '&documentType='+documentType;
    location.href = url;
}

function onProcessingOtherExportChargesInquiryClick(){
    var url='';
    var serviceType = 'Processing';
    var referenceType = 'Inquiry';
    var documentType = 'Other Export Charges';
    url = OtherOfExportChargesInquiryUrl;
//    url += '?username='+username;
    url += '?referenceType='+referenceType;
    url += '&serviceType='+serviceType;
    url += '&documentType='+documentType;
    location.href = url;
}

function onEtsInquiryClick() {
    var gotoUrl = etsInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onDataEntryInquiryClick() {
    var gotoUrl = dataEntryInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onUnactedTransactionsClick() {
    var gotoUrl = unactedTransactionsUrl;
//    //     gotoUrl += "?username=branch";

    location.href = gotoUrl;
}

function onLcInquiryClick() {
    var gotoUrl = lcInquiryUrl;
//    gotoUrl += "?username=branch"
    location.href = gotoUrl;
}

function onIcInquiryClick() {
    var gotoUrl = icInquiryUrl;
    location.href = gotoUrl;
}

function onMdCollectionInquiryClick() {
    var gotoUrl = mdCollectionInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onMdApplicationInquiryClick() {
    var gotoUrl = mdApplicationInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onSetupApClick() {
    var gotoUrl = setupApUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onSetupArClick() {
    var gotoUrl = setupArUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onBgInquiryClick() {
    var gotoUrl = bgInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onNegotiationInquiryClick() {
    var gotoUrl = negotiationInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onImportAdvanceInquiryClick() {
    var gotoUrl = importAdvanceInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onActualCorresTransactionInquiryClick() {
    var gotoUrl = actualCorresTransactionInquiryUrl;
//    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onArMonitoringInquiryClick() {
    var gotoUrl = arMonitoringInquiryUrl;
    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onApMonitoringInquiryClick() {
    var gotoUrl = apMonitoringInquiryUrl;
    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onClientFileInquiryClick() {

    var gotoUrl = clientFileInquiryUrl;
    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onCdtInquiryClick() {
	
    var gotoUrl = cdtInquiryUrl;
    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onRemittanceInquiryClick() {
    var gotoUrl = remittanceInquiryUrl;
    //gotoUrl += "?username=main";
    location.href = gotoUrl;
}

function onOtherImportChargesInquiryClick() {
    var gotoUrl = otherImportChargesInquiryUrl;
    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onRebateInquiryClick() {
    var gotoUrl = rebateInquiryUrl;
    //gotoUrl += "?username=main";
    location.href = gotoUrl;
}

function onRefundCashLcChargesInquiryClick() {
    var gotoUrl = refundCashLcChargesInquiryUrl;
    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}

function onMtMonitoringInquiryClick() {
    var gotoUrl = mtMonitoringInquiryUrl;
    //     gotoUrl += "?username=branch";
    location.href = gotoUrl;
}
function otherOutgoingMtClick(mtType) {
    location.href = otherOutgoingMtUrl + '?mtType=' + mtType;
}

function onApInquiryClick() {
    var gotoUrl = apInquiryUrl;

    location.href = gotoUrl;
}

function onArInquiryClick() {
    var gotoUrl = arInquiryUrl;

    location.href = gotoUrl;
}

function onCreateNonLc() {
    $("input[name=createNonLc]").attr("checked", false);

    loadPopup("create_non_lc_popup", "create_non_lc_popup_bg");
    centerPopup("create_non_lc_popup", "create_non_lc_popup_bg");
    
    if($("#nonLcRedirect").attr("disabled") != "disabled"){
    	$("#nonLcRedirect").attr("disabled", "disabled");
    }
}

function onNonLcInquiryClick() {
    var gotoUrl = nonLcInquiryUrl;
//    gotoUrl += "?username=branch"
    location.href = gotoUrl;
}

function onViewApprovedEtsClick() {
    var serviceType = $("#serviceType").val();
    var documentType = $("#documentType").val();
    var documentClass = $("#documentClass").val();
    var documentSubType1 = $("#documentSubType1").val();
    var documentSubType2 = $("#documentSubType2").val();
    var etsNumber = $("#etsNumber").val();
    
    var gotoUrl = viewEtsAccordionUrl;
 
    //for reversal
    if ('undefined' !== typeof reversalDataEntry && reversalDataEntry == 'true') {
    	gotoUrl += "?etsNumber=" + etsNumber;    	
    	gotoUrl += "&reversalEtsNumber=" + $("#reversalEtsNumber").val();
    }else{
    	gotoUrl += "?etsNumber=" + etsNumber;
    }
    
    gotoUrl += "&serviceType=" + serviceType;
    gotoUrl += "&documentType=" + documentType;
    gotoUrl += "&documentClass=" + documentClass;
    gotoUrl += "&documentSubType1=" + documentSubType1;
    gotoUrl += "&documentSubType2=" + documentSubType2;
    gotoUrl += "&windowed=true";

    //location.href = gotoUrl;
    window.open(gotoUrl, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);
}

function onViewApprovedEtsChargesAndPaymentsClick() {
	var gotoUrl = viewApprovedEtsChargesAndPaymentsAccordionUrl;

	gotoUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
	gotoUrl += "&etsNumber=" + $("#etsNumber").val();
	gotoUrl += "&documentType=" + $("#documentType").val();
	gotoUrl += "&documentClass=" + $("#documentClass").val();
	gotoUrl += "&documentSubType1=" + $("#documentSubType1").val();
	gotoUrl += "&serviceType=" + $("#serviceType").val();
	gotoUrl += "&documentSubType2=" + $("#documentSubType2").val();
	gotoUrl += "&windowed=true";

    window.open(gotoUrl, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);
}

function onViewOriginalReversedEtsClick() {
    var serviceType = $("#serviceType").val();
    var documentType = $("#documentType").val();
    var documentClass = $("#documentClass").val();
    var documentSubType1 = $("#documentSubType1").val();
    var documentSubType2 = $("#documentSubType2").val();
    var etsNumber = $("#etsNumber").val();

    var gotoUrl = viewEtsAccordionUrl;
    gotoUrl += "?etsNumber=" + etsNumber;
    gotoUrl += "&serviceType=" + serviceType;
    gotoUrl += "&documentType=" + documentType;
    gotoUrl += "&documentClass=" + documentClass;
    gotoUrl += "&documentSubType1=" + documentSubType1;
    gotoUrl += "&documentSubType2=" + documentSubType2;
    gotoUrl += "&windowed=true";

    //location.href = gotoUrl;
    window.open(gotoUrl, "etsWindow", "scrollbars=yes, status=yes, width=950, height=630").moveTo(30,30);
}

function onPrepareDataEntryClick() {
	if ($("#chargesTab").length > 0 && $("#chargesTab").is(":hidden") == false) {
		var postUrl = chargesSavedValidationUrl;
		var rates;
		switch ($("#settlementCurrency").val()){
		case "PHP":
			rates = 1
			break;
		case "USD":
			rates = parseFloat($("#USD-PHP_urr").val());
			break;
		default:
			rates = parseFloat($("#USD-PHP_urr").val() * $("#" + $("#settlementCurrency").val() + "-USD_special_rate_charges").val());
			break;
		}
		var params = {tradeServiceId: $("#tradeServiceId").val(),
					  rates: rates};

	    $("#chargesTabForm :input").each(function(){
	        if($(this).attr("type") == "text" && $(this).parents("table").hasClass("charges_table") && $(this).attr("id") != "totalAmountCharges"){
	            params[$(this).attr("id")] = $(this).val();
	        }
	    });
	    
        $.post(postUrl, params, function(data){
            var error = 0
            for(var key in data){
                console.log(data[key]);
                error++;
            }
            if(error > 0) {
                triggerAlertMessage("Charges do not match. Please save.");
            } else {
                continuePrepareDataEntry();
            }
        });
    } else {
        continuePrepareDataEntry();
    }
}

function continuePrepareDataEntry() {
	if(!validateExcessChargesAccordionUtils()){
		return;
	}
	
    var tradeServiceId = $("#tradeServiceId").val();
    var serviceType = $("#serviceType").val().replace("_ADVISING","");
    var documentType = $("#documentType").val();
    var documentClass = $("#documentClass").val();
    var documentSubType1 = $("#documentSubType1").val();
    var documentSubType2 = $("#documentSubType2").val();

    // bugging in chrome and firefox    
    // dirty work around
    //if (typeof reversalDENumber != "undefined" && reversalDENumber.length > 0) {
//    if (typeof reversalDENumber != "undefined" && $('#reversalDENumber').val().length > 0) {
    /*if (typeof reversalDENumber != "undefined" && $('#reversalDENumber').val().length > 0) {
        serviceType = serviceType + '_Reversal';
        tradeServiceId = $("#reversalDENumber").val();
    }*/

    var prepareDataEntryUrl = viewDataEntryAccordionUrl;
    //prepareDataEntryUrl += '?serviceType='+serviceType;
    prepareDataEntryUrl += '?documentType='+documentType;
    prepareDataEntryUrl += '&documentClass='+documentClass;
    prepareDataEntryUrl += '&documentSubType1='+documentSubType1;
    prepareDataEntryUrl += '&documentSubType2='+documentSubType2;
//    prepareDataEntryUrl += '&tradeServiceId='+tradeServiceId;
    prepareDataEntryUrl += '&dataEntryButtonCaption='+ $("#prepareDataEntryBtn").text();

    if (fromReverse) {
        prepareDataEntryUrl += '&serviceType='+serviceType+'_REVERSAL';
        prepareDataEntryUrl += "&serviceInstructionId="+$("#etsNumber").val();
        tradeServiceId = $("#reversalDENumber").val();
    } else {
        prepareDataEntryUrl += '&serviceType='+serviceType;
    }

    prepareDataEntryUrl += '&tradeServiceId='+tradeServiceId;
    location.href = prepareDataEntryUrl;
}

function validateExcessChargesAccordionUtils(){
	var excessChargesError=0;
	var hasRemittanceOrCheckCash=false;
	var hasRemittanceOrCheckCharges=false;
	 
    //validate excess charges in cash lc payment tab
    if('undefined' !== typeof $("#grid_list_cash_payment_summary")){
    	$.each($("#grid_list_cash_payment_summary").jqGrid("getRowData"),function(idx,val){
    		if((val.modeOfPayment.toUpperCase().indexOf("REMITTANCE") >= 0 || 
    			val.modeOfPayment.toUpperCase().indexOf("CHECK") >= 0)){
    			hasRemittanceOrCheckCash=true;
    		}
    	});
    }
    
    //validate excess charges in charges payment tab
    if('undefined' !== typeof $("#grid_list_charges_payment")){
    	$.each($("#grid_list_charges_payment").jqGrid("getRowData"),function(idx,val){
    		if((val.modeOfPayment.toUpperCase().indexOf("REMITTANCE") >= 0 || 
    				val.modeOfPayment.toUpperCase().indexOf("CHECK") >= 0)){
    			hasRemittanceOrCheckCharges=true;
    		}
    	});
    }
    
    if(!hasRemittanceOrCheckCash && 'undefined' !== typeof $("#excessAmountLc")){
    	if(parseInt($("#excessAmountLc").val(),10) > 0){
    		triggerAlertMessage("Excess amount cannot be greater than zero if mode of payment does not include Remittance or Check");
    		excessChargesError++;
    	}
    }

    if(!hasRemittanceOrCheckCharges && 'undefined' !== typeof $("#excessAmountCharges")){
    	if(parseInt($("#excessAmountCharges").val(),10) > 0){
    		triggerAlertMessage("Excess amount cannot be greater than zero if mode of payment does not include Remittance or Check");
    		excessChargesError++;
    	}
    }

    if(excessChargesError > 0){
    	return false;
    }else{
    	return true;
    }
}

function onPayTransactionClick() {
    var tradeServiceId = $("#tradeServiceId").val();
    var serviceType = $("#serviceType").val();
    var documentType = $("#documentType").val();
    var documentClass = $("#documentClass").val();
    var documentSubType1 = $("#documentSubType1").val();
    var documentSubType2 = $("#documentSubType2").val();

    // bugging in chrome and firefox
    /*// copy from continuePrepareDataEntry()
    if (typeof reversalDENumber != "undefined" && $('#reversalDENumber').val().length > 0) {
        serviceType = serviceType + '_Reversal';
        tradeServiceId = $("#reversalDENumber").val();
    }*/
    
    var payTransactionUrl = viewPaymentProcessingAccordionUrl;

    //payTransactionUrl += '?serviceType='+serviceType;
    payTransactionUrl += '?documentType='+documentType;
    payTransactionUrl += '&documentClass='+documentClass;
    payTransactionUrl += '&documentSubType1='+documentSubType1;
    payTransactionUrl += '&documentSubType2='+documentSubType2;
//    payTransactionUrl += '&tradeServiceId='+tradeServiceId;
    
    //check if user is in view mode. acc_userRole in _accordion_url.gsp
    if('undefined' !== typeof acc_userRole && acc_userRole.indexOf("TSD") != -1 && "TSDM" != acc_userRole
    		|| ('undefined' !== _viewMode && '' != _viewMode)){
    	payTransactionUrl += '&viewMode=viewMode';
    }
    payTransactionUrl += '&onViewMode='+ ('undefined' !== _viewMode ? _viewMode : '') ;

    if (fromReverse) {
        payTransactionUrl += '&serviceType='+serviceType.toUpperCase()+"_REVERSAL";
        payTransactionUrl += "&serviceInstructionId="+$("#etsNumber").val();
        tradeServiceId = $("#reversalDENumber").val();
    } else {
        payTransactionUrl += '&serviceType='+serviceType;
    }

    payTransactionUrl += '&tradeServiceId='+tradeServiceId;
    location.href = payTransactionUrl;
}

function onImportAdvancePaymentClick() {
    var url = importAdvanceUrl+"?referenceType=ets";
    location.href = url;//importAdvanceUrl+"?referenceType=ets";
}

function onImportChargesPaymentClick() {
    var url = importChargesUrl+"?referenceType=ets";
    location.href = url;//importChargesUrl+"?referenceType=ets";
}

function exportAdvising2ndClick() {
    var url = exportAdvisingOpeningSecondUrl + "?referenceType=DATAENTRY";

    location.href = url;
}

function exportAdvising1stClick() {
    var url = exportAdvisingOpeningFirstUrl +"?referenceType=DATAENTRY";

    location.href = url;
}

function exportAdvisingInquiryClick() {
    var url = gotoSearchExportAdvisingUrl;

    location.href = url;
}

function exportAdvisingPaymentClick() {
    var url = gotoSearchExportAdvisingPaymentUrl;

    location.href = url;
}

function tsdLetterOfCreditClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Letter Of Credit";
	url +="&tsdTableId=grid_list_letter_of_credit_unacted_main";
	
	location.href=url;
}

function tsdNonLcClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Non - Letter Of Credit";
	url +="&tsdTableId=grid_list_non_letter_of_credit_unacted_main";
	
	location.href=url;
}

function tsdAdviseOnExportClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Advice on Export";
	url +="&tsdTableId=grid_list_advise_on_export_unacted";
	
	location.href=url;
}

function tsdExportBillsClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Export Bills";
	url +="&tsdTableId=grid_list_export_bills_unacted_tsd";
	
	location.href=url;
}

function tsdIncomingTsdClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Incoming MT - TSD";
	url +="&tsdTableId=grid_list_incoming_mt_unacted_tsd";
	
	location.href=url;
}

function tsdIncomingMakerClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Incoming MT - Maker";
	url +="&tsdTableId=grid_list_incoming_mt_unacted";
	
	location.href=url;
}

function tsdCashAdvanceClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Cash Advance";
	url +="&tsdTableId=grid_list_cash_advance_unacted";
	
	location.href=url;
}

function tsdAuxiliaryProductsClick(){
	var url=unactedTransactionTsdUrl;
	
	url +="?tsdLabelText=Auxiliary Products";
	url +="&tsdTableId=grid_list_auxiliary_import_unacted_main";
	
	
	
	location.href=url;
	
}



function createExportBillsTransaction() {
    $("input[name=createExportBills]:checked").removeAttr("checked");
    mLoadPopup($("#create_export_bills_transaction_popup"), $("#create_export_bills_transaction_popup_bg"));
    mCenterPopup($("#create_export_bills_transaction_popup"), $("#create_export_bills_transaction_popup_bg"));
    if($("#createExportBillsGo").attr("disabled") != "disabled"){
    	$("#createExportBillsGo").attr("disabled", "disabled");
    }
}

function goToViewMt(messageType, sequenceNumber){
	var url=goToMtUrl;
	url+="?messageType=" + messageType;
	url+="&newWindow=true";
	if(!sequenceNumber !== undefined){
		url += "&sequenceNumber=" + sequenceNumber;
	}
	window.open(url, "_blank", "scrollbars=yes, status=yes, width=550, height=350");
}

function goToViewMt701(){
	var url=goToMt701Url;
	url+="?newWindow=true";
	window.open(url, "_blank", "scrollbars=yes, status=yes, width=550, height=350");
}

function initializeAccordion() {
   $("#viewOriginalEts").click(onViewOriginalReversedEtsClick);

    if('undefined' !== acc_userRole && acc_userRole.indexOf("TSD") >= 0){
    	getTotalUnactedEntries();    	
    }
    
    $(accordionFunction);

    $("#paymentProcessingBtn").click(openPaymentProcessing);
    $("#dataEntryBtn").click(openDataEntry);
    $("#approvedEtsBtn").click(openApprovedEts);
    
    // live function, for mt103 links that enable/disable through settlement beneficiary tab
    $("#goToViewMt103").live("click", function() {
    	goToViewMt("103");
    });

    //$("#btnCreateTransaction").click(openTransactionSelection);

//    $("#btnViewMt700").click(viewMt700);

    $("#redirectTo").click(createTransaction);

    $("#cancelRedirect").click(cancelTransaction);
    $("#create_transaction_popup_close").click(cancelTransaction);


    $("#btnCreateTransaction").click(openTransactionSelection);
    $("#etsInquiryBtn").click(onEtsInquiryClick);
    $("#dataEntryInquiryBtn").click(onDataEntryInquiryClick);
    $("#lcInquiryBtn").click(onLcInquiryClick);
    $("#icInquiryBtn").click(onIcInquiryClick);
    $("#unactedTransactionsBtn").click(onUnactedTransactionsClick);
    $("#mdCollectionInquiryBtn").click(onMdCollectionInquiryClick);
    $("#mdApplicationInquiryBtn").click(onMdApplicationInquiryClick);

    $("#setupApBtn").click(onSetupApClick);
    $("#importAdvanceInquiryBtn").click(onImportAdvanceInquiryClick);
    $("#actualCorresTransactionInquiryBtn").click(onActualCorresTransactionInquiryClick);
    $("#arMonitoringInquiryBtn").click(onArMonitoringInquiryClick);
    $("#apMonitoringInquiryBtn").click(onApMonitoringInquiryClick);
    $("#clientFileInquiryBtn").click(onClientFileInquiryClick);
    $("#cdtInquiryBtn").click(onCdtInquiryClick);
    $("#remittanceInquiryBtn").click(onRemittanceInquiryClick);
    $("#otherImportChargesInquiryBtn").click(onOtherImportChargesInquiryClick);
    $("#rebateInquiryBtn").click(onRebateInquiryClick);
    $("#refundCashLcChargesInquiryBtn").click(onRefundCashLcChargesInquiryClick);
    $("#mtMonitoringInquiryBtn").click(onMtMonitoringInquiryClick);
//    $("#outgoingMtBtn").click(otherOutgoingMtClick);

    $("#setupApBtn").click(onSetupApClick);
    $("#apInquiryBtn").click(onApInquiryClick);

    $("#setupArBtn").click(onSetupArClick);
    $("#arInquiryBtn").click(onArInquiryClick);

    $("#bgInquiryBtn").click(onBgInquiryClick);
    $("#negotiationInquiryBtn").click(onNegotiationInquiryClick);

    $("#btnCreateNonLc").click(onCreateNonLc);
    $("#nonLcInquiryBtn").click(onNonLcInquiryClick);
    $("#viewApprovedEts").click(onViewApprovedEtsClick);
    $("#viewApprovedEtsChargesAndPayments").click(onViewApprovedEtsChargesAndPaymentsClick);

    $("#close_mt700_popup").live("click", function(){ disablePopup('view_mt_popup', 'view_mt_popup_bg'); });

    $("#prepareDataEntryBtn").click(onPrepareDataEntryClick);
    $("#payTransactionBtn").click(onPayTransactionClick);


    if ($("#importAdvancePaymentBtn").length > 0) {
        $("#importAdvancePaymentBtn").click(onImportAdvancePaymentClick);
    }

    if ($("#cdtUploadTransactions").length > 0) {
        $("#cdtUploadTransactions").click(onCdtUploadTransactionsClick);
    }

    if ($("#cdtUploadClients").length > 0) {
        $("#cdtUploadClients").click(onCdtUploadClientsClick);
    }

    if ($("#cdtUploadPaymentHistory").length > 0) {
        $("#cdtUploadPaymentHistory").click(onCdtUploadPaymentHistoryClick);
    }

    if ($("#exportAdvising2nd").length > 0) {
        $("#exportAdvising2nd").click(exportAdvising2ndClick);
    }

    if ($("#exportAdvising1st").length > 0) {
        $("#exportAdvising1st").click(exportAdvising1stClick);
    }

    if ($("#exportAdvisingInquiry").length > 0) {
        $("#exportAdvisingInquiry").click(exportAdvisingInquiryClick);
    }

    if ($("#exportAdvisingPaymentInquiry").length > 0) {
        $("#exportAdvisingPaymentInquiry").click(exportAdvisingPaymentClick);
    }

    if ($("#createExportBillsTransaction").length > 0) {
        $("#createExportBillsTransaction").click(createExportBillsTransaction);
    }

    if ($("#createExportBillsForCollection").length > 0) {
        $("#createExportBillsForCollection").click(function() {
            $("input[name=createExportBillsCollection]:checked").removeAttr("checked");
            mLoadPopup($("#create_export_bills_tsd_transaction_popup"), $("#create_export_bills_tsd_transaction_popup_bg"));
            mCenterPopup($("#create_export_bills_tsd_transaction_popup"), $("#create_export_bills_tsd_transaction_popup_bg"));
            if($("#createExportBillsTsdGo").attr("disabled") != "disabled"){
            	$("#createExportBillsTsdGo").attr("disabled", "disabled");
            }
        });
    }

//    if ($("#importChargesPaymentBtn").length > 0) {
//        $("#importChargesPaymentBtn").click(onImportChargesPaymentClick);
//    }
    
    $("#tsdLetterOfCredit").click(tsdLetterOfCreditClick);
    $("#tsdNonLc").click(tsdNonLcClick);
    $("#tsdAdviseOnExport").click(tsdAdviseOnExportClick);
    $("#tsdExportBills").click(tsdExportBillsClick);
    $("#tsdIncomingTsd").click(tsdIncomingTsdClick);
    $("#tsdIncomingMaker").click(tsdIncomingMakerClick);
    $("#tsdCashAdvance").click(tsdCashAdvanceClick);
    $("#tsdAuxiliaryProducts").click(tsdAuxiliaryProductsClick);


    if ($("#actualCorresChargeSettlement").length > 0) {
        $("#actualCorresChargeSettlement").click(function() {
            location.href = corresChargeActualUrl+"?referenceType=dataentry&withoutReference=true";
        });
    }

    if ($("#importChargesOthers").length > 0) {
        $("#importChargesOthers").click(function() {
            location.href = importChargesOthersUrl+"?referenceType=dataentry";
        });
    }

    if ($("#exportChargesOthers").length > 0) {
        $("#exportChargesOthers").click(function() {
            location.href = exportChargesOthersUrl+"?referenceType=dataentry";
        });
    }

    if ($("#paymentOfOtherExportChargesInquiry").length > 0) {
        $("#paymentOfOtherExportChargesInquiry").click(function() {
            location.href = viewOtherExportChargesInquiryUrl;
        });
    }

    if ($("#refundOfOtherExportChargesInquiry").length > 0) {
        $("#refundOfOtherExportChargesInquiry").click(function() {
            location.href = viewRefundOfOtherExportChargesInquiryUrl;
        });
    }

}

function getTotalUnactedEntries() {
	//initialize text first in case the ajax takes too long to load
	$("a#tsdLetterOfCredit").text("Letter Of Credit(...)");
	$("a#tsdNonLc").text("Non-LC(...)");
	$("a#tsdAdviseOnExport").text("Advise On Export(...)");
	$("a#tsdExportBills").text("Export Bills(...)");
	$("a#tsdIncomingMaker").text("Incoming MT - Maker(...)");
	$("a#tsdIncomingTsd").text("Incoming MT - TSD(...)");
	$("a#tsdCashAdvance").text("Cash Advance(...)");
	$("a#tsdAuxiliaryProducts").text("Auxiliary Products(...)");
	
	$.post(totalUnactedEntriesUrl,function(unactedEntries){
		$("a#tsdLetterOfCredit").text(unactedEntries.totalLc && '0' != unactedEntries.totalLc ? "Letter Of Credit ("+ unactedEntries.totalLc + ")" : "Letter Of Credit" );
		$("a#tsdNonLc").text(unactedEntries.totalNonLc && '0' != unactedEntries.totalNonLc ? "Non-LC ("+ unactedEntries.totalNonLc + ")" : "Non-LC" );
		$("a#tsdAdviseOnExport").text(unactedEntries.totalExportAdvising && '0' != unactedEntries.totalExportAdvising ? "Advise On Export ("+ unactedEntries.totalExportAdvising + ")" : "Advise On Export" );
		$("a#tsdExportBills").text(unactedEntries.totalExportBills && '0' != unactedEntries.totalExportBills ? "Export Bills ("+ unactedEntries.totalExportBills + ")" : "Export Bills" );
		$("a#tsdIncomingMaker").text(unactedEntries.totalMt && '0' != unactedEntries.totalMt ? "Incoming MT - Maker ("+ unactedEntries.totalMt + ")" : "Incoming MT - Maker" );
		$("a#tsdIncomingTsd").text(unactedEntries.totalMt && '0' != unactedEntries.totalMt ? "Incoming MT -TSD ("+ unactedEntries.totalMt + ")" : "Incoming MT - TSD"  );
		$("a#tsdCashAdvance").text(unactedEntries.totalCashAdvance && '0' != unactedEntries.totalCashAdvance ? "Cash Advance ("+ unactedEntries.totalCashAdvance + ")" : "Cash Advance" );
		$("a#tsdAuxiliaryProducts").text(unactedEntries.totalAuxiliary && '0' != unactedEntries.totalAuxiliary ? "Auxiliary Products ("+ unactedEntries.totalAuxiliary + ")" : "Auxiliary Products" );
		},'json').fail(function(){
			$("a#tsdLetterOfCredit").text("Letter Of Credit");
			$("a#tsdNonLc").text("Non-LC");
			$("a#tsdAdviseOnExport").text("Advise On Export");
			$("a#tsdExportBills").text("Export Bills");
			$("a#tsdIncomingMaker").text("Incoming MT - Maker");
			$("a#tsdIncomingTsd").text("Incoming MT - TSD");
			$("a#tsdCashAdvance").text("Cash Advance");
			$("a#tsdAuxiliaryProducts").text("Auxiliary Products");
		});
}


$(initializeAccordion);

