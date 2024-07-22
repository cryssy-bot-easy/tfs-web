function createTransaction() {
    var documentType = $("#documentTypeEts").val();
    var documentClass = $("#documentClassEts").val();
    var documentSubType1 = $("#documentSubType1Ets").val();

    var locationUrl = createTransactionUrl;
    locationUrl += "?documentType="+documentType;
    locationUrl += "&documentClass="+documentClass;
    locationUrl += "&documentSubType1="+documentSubType1;

    //location.href = locationUrl;
    if(documentType != "" && documentClass != "" && documentSubType1 != "") {
        location.href = locationUrl;
    }
}

function cancelTransaction() {
    disablePopup("create_transaction_popup", "popupBackground_create_transaction");
    $("#createEtsRedirect").attr("disabled", "disabled");
}

function onCreateTransactionClick() {
	var thisvalue = $("input[name=createTransaction]:checked").val(); //this.value.substring(0,2);

	if(thisvalue){
		$("#createEtsRedirect").removeAttr("disabled")
	}
	//var documentType = "";
    var documentType = "";

	if(thisvalue.substring(0,2) == "fx") {
        documentType = "FOREIGN";
	} else if(thisvalue.substring(0,2) == "dm") {
        documentType = "DOMESTIC"
	}

	var documentClass = thisvalue.substring(2,4);
	var documentSubType1 = thisvalue.substring(4,thisvalue.length);
	
	$("#documentTypeEts").val(documentType);
	$("#documentClassEts").val(documentClass);
	$("#documentSubType1Ets").val(documentSubType1);
}

function initializeCreateTransaction() {
	$("input[name=createTransaction]").change(onCreateTransactionClick);

    $("#createEtsRedirect").click(createTransaction);

    $("#createEtsCancel").click(cancelTransaction);
    $("#create_transaction_popup_close").click(cancelTransaction);
}

$(initializeCreateTransaction);