function redirectNonLc() {
    var ets = $("input:[name=createNonLc]:checked").val();

    evaluateNonLc(ets);
}

function evaluateNonLc(action) {
    var gotoUrl = "";
    var documentType = "";

    if(action.substring(0,2) == "fx") {
        documentType = "FOREIGN";
    } else if(action.substring(0,2) == "dm") {
        documentType = "DOMESTIC"
    }

    var documentClass = action.substring(2,4);

    if(documentClass == "da") {
        gotoUrl = daDataEntryUrl;
    } else if(documentClass == "dp") {
        gotoUrl = dpDataEntryUrl;
        gotoUrl += "?documentType="+documentType;
    } else if(documentClass == "dr") {
        gotoUrl = drDataEntryUrl;
    } else if(documentClass == "oa") {
        gotoUrl = oaDataEntryUrl;
    }

    location.href = gotoUrl;
}

function onCancelNonLc() {
    disablePopup("create_non_lc_popup", "create_non_lc_popup_bg");
    $("#nonLcRedirect").attr("disabled", "disabled");
}

function onCreateNonLcClick() {
	if($("input[name=createNonLc]:checked").length > 0){
		$("#nonLcRedirect").removeAttr("disabled");
	}
}

function initializeNonLc() {
	$("input[name=createNonLc]").click(onCreateNonLcClick);
    $("#nonLcRedirect").click(redirectNonLc);
    $("#create_non_popup_close, #nonLcCancel").click(onCancelNonLc);
}

$(initializeNonLc);