/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/9/12
 * Time: 4:32 PM
 * To change this template use File | Settings | File Templates.
 */

function onNonLcEtsRedirectClick() {
    var nonLcEts = $("input:[name=createNonLcEts]:checked").val();
    evaluateNonLcEts(nonLcEts);
}

function evaluateNonLcEts(action) {
    var gotoUrl = "";
    var documentType = "";

    if(action.substring(0,2) == "fx") {
        documentType = "FOREIGN";
    } else if(action.substring(0,2) == "dm") {
        documentType = "DOMESTIC"
    }

    var documentClass = action.substring(2,4);

    if(documentClass == "da") {
        gotoUrl = daSettlementUrl;
    } else if(documentClass == "dp") {
        gotoUrl = dpSettlementUrl;
        gotoUrl += "?documentType="+documentType;
    } else if(documentClass == "dr") {
        gotoUrl = drSettlementUrl;
    } else if(documentClass == "oa") {
        gotoUrl = oaSettlementUrl;
    }

    location.href = gotoUrl;
}

function onNonLcEtsCancelClick() {
    disablePopup("create_non_lc_ets_popup", "create_non_lc_ets_popup_bg");
}

function initializeCreateNonLcEts() {
    $("#nonLcEtsRedirect").click(onNonLcEtsRedirectClick);
    $("#nonLcEtsCancel, #create_non_lc_ets_popup_close").click(onNonLcEtsCancelClick);
}

$(initializeCreateNonLcEts);
