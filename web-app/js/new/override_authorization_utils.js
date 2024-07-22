//  PROLOGUE:
//* 	(revision)
//   SCR/ER Number:20160415-062
//   SCR/ER Description: a transaction with debti from account mode of payment was paid, but amount debited was deducted from account thrice...
//   [Revised by:] Allan Comboy Jr.
//   [Date Deployed:] 04/19/2016
//   Program [Revision] Details: Catch any key events on keyboard while paying CASA. 
//	 Any key press attempt while loading will result to an ALERT msg(Transaction on load. Please wait). (Available in CASA payment only)
//   PROJECT: WEB
//   MEMBER TYPE  : JAVASCRIPT
//   Project Name: override_authorization_utils.js


function payDebitToCasa(id) { // for non-settlement to ben

	 $("#"+id).attr("disabled","disabled");
	 
    $("#payAuthorizeCasaId").val("");
    var grid;
    if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
    	if($("#grid_list_refund_main").length > 0){
    		grid = $("#grid_list_refund_main");
	    }else{
	    	grid = $("#grid_list_cash_payment_summary");
	    }
    } else if (formId == "#proceedsDetailsTabForm") {
        grid = $("#grid_list_proceeds_payment_summary");
    } else if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    } else if (formId == "#basicDetailsTabForm" && $("#documentClass").val() == "CDT" && serviceType == "PAYMENT") {
        grid = $("#grid_list_payment_cdt");
    }
    
    if(($("#documentClass").val() == 'LC' && $("#serviceType").val() == 'UA Loan Settlement' && $("#documentType").val() == 'FOREIGN') || ($("#documentClass").val() in {DA:1, DP:1, DR:1, OA:1} && $("#serviceType").val() == 'Settlement' && $("#documentType").val() == 'FOREIGN')){
    	if($("#reimbursingBank").val() == ''){
    		triggerAlertMessage("Reimbursement details not yet completed.");
    	}
    }

    var gridData = grid.jqGrid("getRowData", id);

    //why are there two amount fields? because someone did not name the columns consistently.
    //a patch on a patch. sigh.
//    var params = {
//        amount: gridData.amount,
//        currency: gridData.settlementCurrency ? gridData.settlementCurrency : gridData.currency,
//        amountSettlement: gridData.amountSettlement
//    }

//    $.post(validateCasaTransactionAmountUrl, params, function (validateCasaAmountResponse) {
//        if (validateCasaAmountResponse.success == true) {
//            onPayClickAuthenticate(id, $("#payAuthorizeUsername").val());
//        } else {
//            if (validateCasaAmountResponse.requiresValidation == true) {
//                $("#payAuthorizeUsername, #payAuthorizePassword").val("");
//
//                loadPopup("payAuthorizeDiv", "payAuthorizeBg");
//                centerPopup("payAuthorizeDiv", "payAuthorizeBg");
//
//                $("#payAuthorizeCasaId").val(id);
//            } else {
//                triggerAlertMessage(validateCasaAmountResponse.errorMessage);
//            }
//        }
//    });

    onPayClickAuthenticate(id, $("#payAuthorizeUsername").val());
}

function payCreditToCasa(id) { // for settlement to ben
    $("#payAuthorizeCasaId").val("");
    var grid;
    if ((documentClass == 'AP' && serviceType.toUpperCase() == 'REFUND') || (documentType == 'REFUND' && serviceType == 'Application')) {
    	grid = $("#grid_list_refund_main");
	} else if ((formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() != 'REFUND') || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        grid = $("#grid_list_cash_payment_summary");
    } else if (formId == "#proceedsDetailsTabForm" || (formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() == 'REFUND')) {
        grid = $("#grid_list_proceeds_payment_summary");
    } else if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    } else if (formId == "#basicDetailsTabForm" && $("#documentClass").val() == "CDT" && serviceType == "PAYMENT") {
        grid = $("#grid_list_payment_cdt");
    }
    
    var gridData = grid.jqGrid("getRowData", id);

    //why are there two amount fields? because someone did not name the columns consistently.
    //a patch on a patch. sigh.
    var params = {
        amount: gridData.amount,
        currency: gridData.settlementCurrency != null ? gridData.settlementCurrency : gridData.currency,
        amountSettlement: gridData.amountSettlement
    }
    

//    $("#payAuthorizeUsername, #payAuthorizePassword").val("");
//
//    loadPopup("payAuthorizeDiv", "payAuthorizeBg");
//    centerPopup("payAuthorizeDiv", "payAuthorizeBg");
//
//    $("#payAuthorizeCasaId").val(id);

    $.post(validateCasaTransactionAmountUrl, params, function (validateCasaAmountResponse) {
        if (validateCasaAmountResponse.success == true) {
            onPayClickAuthenticate(id, $("#payAuthorizeUsername").val());
        } else {
            if (validateCasaAmountResponse.requiresValidation == true) {
                $("#payAuthorizeUsername, #payAuthorizePassword").val("");

                loadPopup("payAuthorizeDiv", "payAuthorizeBg");
                centerPopup("payAuthorizeDiv", "payAuthorizeBg");

                $("#payAuthorizeCasaId").val(id);
            } else {
                triggerAlertMessage(validateCasaAmountResponse.errorMessage);
            }
        }
    });
}

function authenticatePayingOfficer() { // on pay click
    disablePopup("payAuthorizeDiv", "payAuthorizeBg");

    var params = {
        username: $("#payAuthorizeUsername").val(),
        password: $("#payAuthorizePassword").val()
    }

    $.post(authenticateOfficerUrl, params, function(payAuthenticationResponse) {
        if (payAuthenticationResponse.success == true) {
            onPayClickAuthenticate($("#payAuthorizeCasaId").val(), $("#payAuthorizeUsername").val());
        } else {
            triggerAlertMessage(payAuthenticationResponse.error);
        }
    });
}

function errorCorrectCasaPayment(id) { // for settlement to ben
    $("#unpayAuthorizeCasaId").val("");
    var grid;
    if (documentClass == 'AP' && serviceType.toUpperCase() == 'REFUND') {
    	grid = $("#grid_list_refund_main");
	} else if ((formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() != 'REFUND') || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        grid = $("#grid_list_cash_payment_summary");
    } else if (formId == "#proceedsDetailsTabForm" || (formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() == 'REFUND')) {
        grid = $("#grid_list_proceeds_payment_summary");
    } else if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    } else if (formId == "#basicDetailsTabForm" && $("#documentClass").val() == "CDT" && serviceType == "PAYMENT") {
        grid = $("#grid_list_payment_cdt");
    }

    var gridData = grid.jqGrid("getRowData", id);

    //why are there two amount fields? because someone did not name the columns consistently.
    //a patch on a patch. sigh.
    var params = {
        amount: gridData.amount,
        currency: gridData.settlementCurrency != null ? gridData.settlementCurrency : gridData.currency,
        amountSettlement: gridData.amountSettlement
    }

    $("#unpayAuthorizeUsername, #unpayAuthorizePassword").val("");
    loadPopup("unpayAuthorizeDiv", "unpayAuthorizeBg");
    centerPopup("unpayAuthorizeDiv", "unpayAuthorizeBg");

    $("#unpayAuthorizeCasaId").val(id);
}

//FOR TIMED OUT CASA TRANSACTION
function errorCorrectTfsPayment(id){
    loadPopup("loading_div", "loading_bg");
    centerPopup("loading_div", "loading_bg");

    var grid;
    if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    } else if ((formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm") || formId == "#paymentDetailsTabForm") {
        grid = $("#grid_list_refund_main").length > 0 ? $("#grid_list_refund_main") : $("#grid_list_cash_payment_summary");
    } else if (formId == "#basicDetailsTabForm" && documentClass == "CDT" && serviceType == "PAYMENT") {
        grid = $("#grid_list_payment_cdt");
    } else if (formId == "#proceedsDetailsTabForm") {
        grid = $("#grid_list_proceeds_payment_summary");
    }

    var params = {
        paymentDetailId: id,
        reverseDE: $("#reverseDE").val(),
        reversalDENumber: $("#reversalDENumber").val(),
    }
    
    $.post(errorCorrectTfsUrl, params, function (reversePaymentResponse) {
        popupStatus = 1;
        if (reversePaymentResponse.success == true) {
            updateGrid(id, "unpay");

            if (documentClass == "MD" ||
                    (documentClass == "IMPORT_CHARGES" || (documentClass == "EXPORT_CHARGES") && serviceType != "REFUND") ||
                    (documentClass in {"IMPORT_ADVANCE":1, "EXPORT_ADVANCE":1, BP:1, CORRES_CHARGE:1, BC:1, AP:1, AR:1} && referenceType == "DATA_ENTRY") ) {
                $.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (reversePaymentStatusResponse) {
                    if (reversePaymentStatusResponse.paymentStatus == "PAID") {
                        $("#btnPrepare").removeAttr("disabled");
                    } else {
                        $("#btnPrepare").attr("disabled", "disabled");
                    }
                });
            }
        } else {
            if (reversePaymentResponse.errorMessage != null && reversePaymentResponse.errorMessage != "") {
                triggerAlertMessage(reversePaymentResponse.errorMessage);
            }
        }
    }).always(function () {
        disablePopup("loading_div", "loading_bg");
        grid.trigger("reloadGrid");
    });
}

function authenticateUnpayingOfficer() {  // on error correct
    disablePopup("unpayAuthorizeDiv", "unpayAuthorizeBg");
    var params = {
        username: $("#unpayAuthorizeUsername").val(),
        password: $("#unpayAuthorizePassword").val()
    }

    $.post(authenticateOfficerUrl, params, function (unpayAuthenticationResponse) {
        if (unpayAuthenticationResponse.success == true) {
            onReversePaymentClickAuthorize($("#unpayAuthorizeCasaId").val(), $("#unpayAuthorizeUsername").val());
            disablePopup("unpayAuthorizeDiv", "unpayAuthorizeBg");
        } else {
            triggerAlertMessage(unpayAuthenticationResponse.error);
        }
    });
}
var keyboarLocked = false;
function onPayClickAuthenticate(id, username) {
	keyboarLocked = true;
    loadPopup("loading_div", "loading_bg");
    centerPopup("loading_div", "loading_bg");

    var grid;
    if ((formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() != 'REFUND') || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        grid = $("#grid_list_refund_main").length > 0 ? $("#grid_list_refund_main") : $("#grid_list_cash_payment_summary");
    } else if (formId == "#proceedsDetailsTabForm" || (formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() == 'REFUND')) {
        grid = $("#grid_list_proceeds_payment_summary");
    } else if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    } else if (formId == "#basicDetailsTabForm" && $("#documentClass").val() == "CDT") {
        grid = $("#grid_list_payment_cdt");
    }

    var params = {
        paymentDetailId: id,
        supervisorId : username//$("#usernameConfirm").val()
    }

    var gridData = grid.jqGrid("getRowData", id);
    if (gridData.paymentMode == 'IB_LOAN' || gridData.paymentMode == 'TR_LOAN' || gridData.paymentMode == 'UA_LOAN') {
        params['facilityId'] = $("#selectionId").val();
        params['facilityType'] = $("#facilityType").val();
        params['facilityReferenceNumber'] = $("#facilityReferenceNumber").val();
        params['paymentCode'] = $("#loanPaymentCode").val();
        params['paymentTerm'] = $("#paymentTerm").val();
        params['withCramApproval'] = $("input[type=radio][name=cramApprovalFlag]:checked").val();
        params.push($.makeArray(gridData.setupString));
    }

    $.post(payUrl, params, function (payResponse) {
        loadPopup("loading_div", "loading_bg");
        centerPopup("loading_div", "loading_bg");
//        alert(JSON.stringify(payResponse));
        if(payResponse.deadma == true){
        	triggerAlertMessage(payResponse.errorMessage + " Please check BDS for the CASA posting status.");
        }else{
        	if (payResponse.success == true) {
        		if (documentClass == "MD" ||
        				(documentClass == "IMPORT_CHARGES" || (documentClass == "EXPORT_CHARGES") && serviceType != "REFUND") ||
        				(documentClass in {"IMPORT_ADVANCE":1, "EXPORT_ADVANCE":1, BP:1, CORRES_CHARGE:1, BC:1, AP:1, AR:1} && referenceType == "DATA_ENTRY") ) {
        			
        			$.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (paymentStatusResponse) {
        				
        				if (paymentStatusResponse.paymentStatus == "PAID") {
        					$("#btnPrepare").removeAttr("disabled");
        				} else {
        					$("#btnPrepare").attr("disabled", "disabled");
        				}
        			});
        		}
        		
        		if (documentClass == "CDT" && referenceType == "PAYMENT" && serviceType == "PAYMENT") {
        			$("#paymentReferenceNumber").val("");
        			
        			if (payResponse.paymentReferenceNumber) {
        				$("#paymentReferenceNumber").val(payResponse.paymentReferenceNumber)
        			}
        		}
        		
        	} else {
        		triggerAlertMessage(payResponse.errorMessage);
        	}
        }
        
    }).always(function () {
    	
        disablePopup("loading_div", "loading_bg");
        grid.trigger("reloadGrid");
        keyboarLocked = false;
        
    });
}

document.onkeydown = function (e) {
	if(keyboarLocked){
	triggerAlertMessage("Transaction onload. Please Wait.");	
	return false;}

}

function onReversePaymentClickAuthorize(id, username) {
    loadPopup("loading_div", "loading_bg");
    centerPopup("loading_div", "loading_bg");

    var grid;
    if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    } else if (((formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() != 'REFUND') || formId == "#productPaymentTabForm") || formId == "#paymentDetailsTabForm") {
        grid = $("#grid_list_refund_main").length > 0 ? $("#grid_list_refund_main") : $("#grid_list_cash_payment_summary");
    } else if (formId == "#basicDetailsTabForm" && documentClass == "CDT" && serviceType == "PAYMENT") {
        grid = $("#grid_list_payment_cdt");
    } else if (formId == "#proceedsDetailsTabForm" || (formId == "#cashLcPaymentTabForm" && serviceType.toUpperCase() == 'REFUND')) {
        grid = $("#grid_list_proceeds_payment_summary");
    }

    var params = {
        paymentDetailId: id,
        reverseDE: $("#reverseDE").val(),
        reversalDENumber: $("#reversalDENumber").val(),
        supervisorId: username
    }

    $.post(reversePaymentUrl, params, function (reversePaymentResponse) {
        popupStatus = 1;
//        alert(JSON.stringify(reversePaymentResponse));
        if (reversePaymentResponse.success == true) {
            updateGrid(id, "unpay");

            if (documentClass == "MD" ||
    				(documentClass == "IMPORT_CHARGES" || (documentClass == "EXPORT_CHARGES") && serviceType != "REFUND") ||
    				(documentClass in {"IMPORT_ADVANCE":1, "EXPORT_ADVANCE":1, BP:1, CORRES_CHARGE:1, BC:1, AP:1, AR:1} && referenceType == "DATA_ENTRY") ) {
                $.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (reversePaymentStatusResponse) {
                    if (reversePaymentStatusResponse.paymentStatus == "PAID") {
                        $("#btnPrepare").removeAttr("disabled");
                    } else {
                        $("#btnPrepare").attr("disabled", "disabled");
                    }
                });
            }

            if (documentClass == "CDT" && referenceType == "PAYMENT" && serviceType == "PAYMENT") {
                $("#paymentReferenceNumber").val("");
            }
        } else {
            if (reversePaymentResponse.errorMessage != null && reversePaymentResponse.errorMessage != "") {
                triggerAlertMessage(reversePaymentResponse.errorMessage);
            }else{
            	triggerAlertMessage("DB Error. Please try again.");
            }
        }
    }).always(function () {
        disablePopup("loading_div", "loading_bg");
        grid.trigger("reloadGrid");
    });
}


$(document).ready(function() {
    // pay
    if ($("#payAuthorizeConfirm").length > 0) {
        $("#payAuthorizeConfirm").click(function() {
            authenticatePayingOfficer();
        });
    }

    if ($("#payAuthorizeCancel").length > 0) {
        $("#payAuthorizeCancel").click(function() {
            disablePopup("payAuthorizeDiv", "payAuthorizeBg");
        });
    }

    // unpay
    if ($("#unpayAuthorizeConfirm").length > 0) {
        $("#unpayAuthorizeConfirm").click(function() {
            authenticateUnpayingOfficer();
        });
    }

    if ($("#unpayAuthorizeCancel").length > 0) {
        $("#unpayAuthorizeCancel").click(function() {
            disablePopup("unpayAuthorizeDiv", "unpayAuthorizeBg");
        });
    }
});