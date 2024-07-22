function onSearchMdCollectionBtnClick() {
    var postUrl = "";

    var grid = null;

    if($('#grid_list_md_collection_inquiry_main').length > 0) {
        postUrl = mdApplicationMain;
        grid = $("#grid_list_md_collection_inquiry_main");
    } else if($('#grid_list_md_collection_inquiry_branch').length > 0) {
        postUrl = mdApplicationBranch;
        grid = $("#grid_list_md_collection_inquiry_branch");
    }

    postUrl += "?"+$("#mdCollectionInquiry").serialize();
    postUrl += "&unitcode="+unitcode;
    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertMdCollectionCount}).trigger("reloadGrid");
}

function alertMdCollectionCount(){
	var grid;
	
	if ($("#grid_list_md_collection_inquiry_branch").length > 0) {
		grid = $("#grid_list_md_collection_inquiry_branch");
	} else {
		grid = $("#grid_list_md_collection_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function onResetMdCollectionBtnClick() {
	var postUrl = "";
    var grid = null;

    if($('#grid_list_md_collection_inquiry_main').length > 0) {
        postUrl = mdApplicationMain;

        grid = $("#grid_list_md_collection_inquiry_main");
    } else if($('#grid_list_md_collection_inquiry_branch').length > 0) {
        postUrl = mdApplicationBranch;

        grid = $("#grid_list_md_collection_inquiry_branch");
    }

    postUrl += "?unitcode="+unitcode;
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
    $("#documentNumber, #cifName, #unitCode").val("");
}

function onSearchMdApplicationBtnClick() {
    var postUrl = "";
    var grid = null;

    if($('#grid_list_md_application_inquiry_main').length > 0) {
        postUrl = mdApplicationMain;

        grid = $("#grid_list_md_application_inquiry_main");
    } else if($('#grid_list_md_application_inquiry_branch').length > 0) {
        postUrl = mdApplicationBranch;

        grid = $("#grid_list_md_application_inquiry_branch");
    }

    postUrl += "?"+$("#mdApplicationInquiry").serialize();
    postUrl += "&unitcode="+unitcode;
    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertMdApplicationCount}).trigger("reloadGrid");
}

function alertMdApplicationCount(){
	var grid;
	
	if ($("#grid_list_md_application_inquiry_branch").length > 0) {
		grid = $("#grid_list_md_application_inquiry_branch");
	} else {
		grid = $("#grid_list_md_application_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function onResetMdApplicationBtnClick() {
	var postUrl = "";
    var grid = null;

    if($('#grid_list_md_application_inquiry_main').length > 0) {
        postUrl = mdApplicationMain;

        grid = $("#grid_list_md_application_inquiry_main");
    } else if($('#grid_list_md_application_inquiry_branch').length > 0) {
        postUrl = mdApplicationBranch;

        grid = $("#grid_list_md_application_inquiry_branch");
    }
    postUrl += "?unitcode="+unitcode;
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
    $("#documentNumber, #clientName, #expiryDate, #status, #unitCode").val("");
}

function createMdApplication(documentNumber, mdCurrency, outstandingAmount,action) {
    var gotoUrl = "";

    if (action == "refund") {
        gotoUrl = createMdApplicationRefundEtsUrl;
    } else if(action == "applyrefund") {
        gotoUrl = createMdApplicationApplyRefundDataEntryUrl;
    }

    gotoUrl += "?documentNumber="+documentNumber;
    gotoUrl += "&mdCurrency="+mdCurrency;
    gotoUrl += "&outstandingAmount="+outstandingAmount;

    location.href = gotoUrl;
}

function onTogglePnSupport(id) {
    //alert($("#pnSupportFlag").attr("checked"))
    var postUrl = togglePnSupportUrl;

    var rowData = $("#grid_list_md_application_inquiry_main").jqGrid("getRowData", id);

    var pnSupportFlag = "N";

    if($("#pnSupportFlag").attr("checked")) {
        pnSupportFlag = "Y";
    }

    var params = {
        documentNumber: rowData.documentNumber,
        dateCollected: rowData.dateCollected,
        settlementCurrency: rowData.settlementCurrency,
        outstandingAmount: rowData.outstandingAmount,
        clientName: rowData.clientName,
        serviceType: rowData.serviceType,
        documentClass: rowData.documentClass,
        pnSupport: pnSupportFlag
    }

    $.post(postUrl, params, function(data) {
        //alert(data.success);
    })
}

function initializeMdInquiry() {
    $("#searchMdCollectionBtn").click(onSearchMdCollectionBtnClick);
    $("#resetMdCollectionBtn").click(onResetMdCollectionBtnClick);

    $("#searchMdApplicationBtn").click(onSearchMdApplicationBtnClick);
    $("#resetMdApplicationBtn").click(onResetMdApplicationBtnClick);


}

$(initializeMdInquiry);