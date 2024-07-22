function onEtsMainRedirectToClick() {
    var ets = $("input:[name=createEtsMain]:checked").val();

    //evaluateActionMain(ets);
    $.post(multipleTradeServiceUrl, {tradeProductNumber: $("#dnTsd").val(), serviceType: ets, isNotPrepared: true}, function (data) {

        if (data.success == "true") {
            evaluateActionMain(ets);
        } else {
            triggerAlertMessage(data.message);
        }
    });
}

function evaluateActionMain(action) {

    var gotoUrl = viewApprovedLcTsdUrl;

    gotoUrl += "?documentNumber="+$("#dnTsd").val();
    gotoUrl += "&documentClass="+"LC";


    if(action == "adjustment") {
        gotoUrl += "&serviceType="+"Adjustment";
    } else if(action == "amendment") {
        gotoUrl += "&serviceType="+"Amendment";
    } else if(action == "negotiationDiscrepancy") {
        gotoUrl += "&serviceType="+"NEGOTIATION_DISCREPANCY";
    }

    location.href = gotoUrl;
}

function initializeCreateEtsMain() {
    $("#etsMainRedirectTo").click(onEtsMainRedirectToClick);
}

$(initializeCreateEtsMain);
