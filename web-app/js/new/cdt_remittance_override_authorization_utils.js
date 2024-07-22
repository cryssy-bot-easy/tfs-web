function authenticatePayingOfficerCdtRemittance() { // on pay click
    mDisablePopup($("#payAuthorizeCdtRemittanceDiv"), $("#payAuthorizeCdtRemittanceBg"));

    var params = {
        username: $("#payAuthorizeUsernameCdtRemittance").val(),
        password: $("#payAuthorizePasswordCdtRemittance").val()
    }

    $.post(authenticateOfficerUrl, params, function(payAuthenticationResponse) {
        if (payAuthenticationResponse.success == true) {
            onPayClickAuthenticateCdtRemittance($("#payAuthorizeUsernameCdt").val());
        } else {
            triggerAlertMessage(payAuthenticationResponse.error);
        }
    });
}

function authenticateUnpayingOfficerCdtRemittance() {  // on error correct
    mDisablePopup($("#unpayAuthorizeCdtRemittanceDiv"), $("#unpayAuthorizeCdtRemittanceBg"));

    var params = {
        username: $("#unpayAuthorizeUsernameCdtRemittance").val(),
        password: $("#unpayAuthorizePasswordCdtRemittance").val()
    }

    $.post(authenticateOfficerUrl, params, function (unpayAuthenticationResponse) {
        if (unpayAuthenticationResponse.success == true) {
            onErrorCorrectRemittance($("#unpayAuthorizeUsernameCdtRemittance").val());
            mDisablePopup($("#unpayAuthorizeCdtRemittanceDiv"), $("#unpayAuthorizeCdtRemittanceBg"));
        } else {
            triggerAlertMessage(unpayAuthenticationResponse.error);
        }
    });
}

function onPayClickAuthenticateCdtRemittance(username) {
    mLoadPopup($("#loading_div"), $("#loading_bg"));
    mCenterPopup($("#loading_div"), $("#loading_bg"));

    var params = {
        amount: $("#remittanceAmount").val(),
        accountNumber: $("#bocAccount").val(),
        accountName: $("#bocAccountName").val(),
        supervisorId: username,
        tradeServiceId: $("#tradeServiceId").val(),
        collectionPeriodFrom: $("#collectionPeriodFrom").val(),
        collectionPeriodTo: $("#collectionPeriodTo").val(),
        paymentRequestType: $("#reportType").val()
    }

    $.post(debitRemittanceUrl, params, function(data) {
        if (data.status == "ok") {
            triggerAlertMessage("Transaction Successful.");
            $("#debitCasa").hide();
            $("#errorCorrectCasaRemittance").show();
//            alert('hi ' + $("#adhoc").attr("checked"));
            $("#reportType, #adhoc").attr("disabled", "disabled");
            $("#remittanceDate, #collectionPeriodFrom, #collectionPeriodTo").datepicker("destroy");

            $("#btnPrepare").removeAttr("disabled");

            $("#bocAccount").attr("readonly", "readonly");

    		$(".viewDebitMemo").attr('id', 'viewDebitMemoPayment');
    		$(".viewDebitMemo").removeClass("disableDebitMemo");
        } else {
            triggerAlertMessage(data.error);
        }
    });
}

function onErrorCorrectRemittance(username) {
    var params = {
        amount: $("#remittanceAmount").val(),
        accountNumber: $("#bocAccount").val(),
        accountName: $("#bocAccountName").val(),
        tradeServiceId: $("#tradeServiceId").val(),
        supervisorId: username,
        collectionPeriodFrom: $("#collectionPeriodFrom").val(),
        collectionPeriodTo: $("#collectionPeriodTo").val(),
        paymentRequestType: $("#reportType").val()
    }

    $.post(ecRemittanceUrl, params, function(data) {
        if (data.status == "ok") {
            triggerAlertMessage("Transaction Successful.");
            $("#debitCasa").show();
            $("#errorCorrectCasaRemittance").hide();

            $("#reportType, #adhoc").removeAttr("disabled");
            $("#bocAccount").removeAttr("readonly");

    		$(".viewDebitMemo").removeAttr('id');
    		$(".viewDebitMemo").addClass("disableDebitMemo");
//            alert('hello ' + $("#adhoc").attr("checked"));
            if ($("#adhoc").attr("checked") == "checked") {
                $("#collectionPeriodFrom, #collectionPeriodTo").datepicker({
                    showOn: 'both',
                    buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
                    changeMonth: true,
                    changeYear: true,
                    constrainInput:true,
                    defaultDate:null,
                    dateFormat:'mm/dd/yy'
                });
            }
            $("#remittanceDate").datepicker({
                showOn: 'both',
                buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
                changeMonth: true,
                changeYear: true,
                constrainInput:true,
                defaultDate:null,
                dateFormat:'mm/dd/yy'
            });

            $("#btnPrepare").attr("disabled", "disabled");
        } else {
            triggerAlertMessage(data.error);
        }
    });
}


$(document).ready(function() {
    // pay
    if ($("#payAuthorizeConfirmCdtRemittance").length > 0) {
        $("#payAuthorizeConfirmCdtRemittance").click(function() {
            authenticatePayingOfficerCdtRemittance();
        });
    }

    if ($("#payAuthorizeCancelCdtRemittance").length > 0) {
        $("#payAuthorizeCancelCdtRemittance").click(function() {
            mDisablePopup($("#payAuthorizeCdtRemittanceDiv"), $("#payAuthorizeCdtRemittanceBg"));
        });
    }

    // unpay
    if ($("#unpayAuthorizeConfirmCdtRemittance").length > 0) {
        $("#unpayAuthorizeConfirmCdtRemittance").click(function() {
            authenticateUnpayingOfficerCdtRemittance();
        });
    }

    if ($("#unpayAuthorizeCancelCdtRemittance").length > 0) {
        $("#unpayAuthorizeCancelCdtRemittance").click(function() {
            mDisablePopup($("#unpayAuthorizeCdtRemittanceDiv"), $("#unpayAuthorizeCdtRemittanceBg"));
        });
    }
});