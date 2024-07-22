 
/** PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: cdt_override_authorization_utils.js
 */

function authenticatePayingOfficerCdt() { // on pay click
    mDisablePopup($("#payAuthorizeCdtDiv"), $("#payAuthorizeCdtBg"));

    var params = {
        username: $("#payAuthorizeUsernameCdt").val(),
        password: $("#payAuthorizePasswordCdt").val()
    }

    $.post(authenticateOfficerUrl, params, function(payAuthenticationResponse) {
        if (payAuthenticationResponse.success == true) {
            onPayClickAuthenticateCdt($("#payAuthorizeUsernameCdt").val());
    		loadPopup("loading_cdt_upload_div", "loading_cdt_upload_bg");
            centerPopup("loading_cdt_upload_div", "loading_cdt_upload_bg");
        } else {
            triggerAlertMessage(payAuthenticationResponse.error);
        }
    });
}

function authenticateUnpayingOfficerCdt() {  // on error correct
    mDisablePopup($("#unpayAuthorizeCdtDiv"), $("#unpayAuthorizeCdtBg"));

    var params = {
        username: $("#unpayAuthorizeUsernameCdt").val(),
        password: $("#unpayAuthorizePasswordCdt").val()
    }

    $.post(authenticateOfficerUrl, params, function (unpayAuthenticationResponse) {
        if (unpayAuthenticationResponse.success == true) {
            onErrorCorrectMOBBOC($("#unpayAuthorizeUsernameCdt").val());
            mDisablePopup($("#unpayAuthorizeCdtDiv"), $("#unpayAuthorizeCdtBg"));
        } else {
            triggerAlertMessage(unpayAuthenticationResponse.error);
        }
    });
}

function onPayClickAuthenticateCdt(username) {
    loadPopup("loading_cdt_upload_div","loading_cdt_upload_bg");
    centerPopup("loading_cdt_upload_div", "loading_cdt_upload_bg");

    var params = {
        amount: $("#totalAmountCollectedTFS").val(),
        accountNumber: $("#mobBocAccountNumberSend").val(),
        accountName: $("#accountNameSend").val(),
        supervisorId: username,
        tradeServiceId: $("#tradeServiceId").val(),
        confDate: $("#sentBOCDate").val()
    }

    $.post(sendToMobBocUrl, params, function(data) {
        if (data.status == "ok") {
     
            $('input[id=confDate]').val($("#sentBOCDate").val());
            
        	disablePopup("loading_cdt_upload_div", "loading_cdt_upload_bg");
            triggerAlertMessage("Transaction Successful.");

            $("#cdt_list_upload_transactions").jqGrid('setGridParam', {url: searchCdtPaymentUrl, page: 1}).trigger("reloadGrid");

            $("#tradeServiceId").val(data.details.tradeServiceId);

            $("#mobBocAccountNumberSend, #accountNameSend").val("");

            hideTransactionTypes();

        } else {
        
            $('input[id=confDate]').val($("#sentBOCDate").val());
            
        	disablePopup("loading_cdt_upload_div", "loading_cdt_upload_bg");
            triggerAlertMessage(data.error);
        }
    });
}

function onErrorCorrectMOBBOC(username) {
    var params = {
        amount: $("#totalAmountCollectedTFS").val(),
        accountNumber: $("#mobBocAccountNumberEC").val(),
        accountName: $("#accountNameEC").val(),
        tradeServiceId: $("#tradeServiceId").val(),
        supervisorId: username
    }

    $.post(ecMobBocUrl, params, function(data) {
        if (data.status == "ok") {
            triggerAlertMessage("Transaction Successful.");

            

            $("#cdt_list_upload_transactions").jqGrid('setGridParam', {url: searchCdtPaymentUrl, page: 1}).trigger("reloadGrid");

            $("#mobBocAccountNumberEC, #accountNameEC").val("");
        } else {
            triggerAlertMessage(data.error);
        }
    });
}


$(document).ready(function() {
    // pay
    if ($("#payAuthorizeConfirmCdt").length > 0) {
        $("#payAuthorizeConfirmCdt").click(function() {
            authenticatePayingOfficerCdt();
        });
    }

    if ($("#payAuthorizeCancelCdt").length > 0) {
        $("#payAuthorizeCancelCdt").click(function() {
            mDisablePopup($("#payAuthorizeCdtDiv"), $("#payAuthorizeCdtBg"));
        });
    }

    // unpay
    if ($("#unpayAuthorizeConfirmCdt").length > 0) {
        $("#unpayAuthorizeConfirmCdt").click(function() {
            authenticateUnpayingOfficerCdt();
        });
    }

    if ($("#unpayAuthorizeCancelCdt").length > 0) {
        $("#unpayAuthorizeCancelCdt").click(function() {
            mDisablePopup($("#unpayAuthorizeCdtDiv"), $("#unpayAuthorizeCdtBg"));
        });
    }
});