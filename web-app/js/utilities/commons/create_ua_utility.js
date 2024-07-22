function onUaRedirectToClick() {
    var ets = $("input:[name=createUa]:checked").val();

    evaluateActionUa(ets);
}

function evaluateActionUa(action) {
//    var gotoUrl = "";
    var gotoUrl = viewApprovedNegotiationLcUrl;


    if(action == "maturityAdjustment") {
//        gotoUrl = maturityAdjustmentUrl;
//        gotoUrl += "?id="+$("#id").val();
        gotoUrl += "?id="+$("#tradeServiceId").val();
        gotoUrl += "&documentClass="+"LC";
        gotoUrl += "&serviceType="+"UA_LOAN_MATURITY_ADJUSTMENT";
        gotoUrl += "&documentType="+$("#documentType").val();
    } else if(action == "settlement") {
//        gotoUrl = settlementUrl;
//        gotoUrl += "?id="+$("#id").val();
        gotoUrl += "?id="+$("#tradeServiceId").val();
        gotoUrl += "&documentClass="+"LC";
        gotoUrl += "&serviceType="+"UA_LOAN_SETTLEMENT";
        gotoUrl += "&documentType="+$("#documentType").val();
    }

    //alert(gotoUrl);
    location.href = gotoUrl;
}

function onCancelUa() {
    disablePopup("create_ua_popup", "create_ua_popup_bg");
    $("#uaRedirectTo").attr("disabled", "disabled");
}

function enableGoUa() {
	if ($("input[name=createUa]:checked").length > 0){
		$("#uaRedirectTo").removeAttr("disabled");
	}
}

function initializeCreateEts() {
	$("input[name=createUa]").click(enableGoUa);
    $("#uaRedirectTo").click(onUaRedirectToClick);
    $("#create_ua_popup_close, #uaCancel").click(onCancelUa);
}

$(initializeCreateEts);