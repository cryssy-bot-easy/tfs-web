function viewExportBillsEts(id, tsid) {
    var grid = $("#grid_list_export_bills_unacted_branch");

    if ($("#grid_list_export_bills_unacted_tsd").length > 0) {
        grid = $("#grid_list_export_bills_unacted_tsd");
    }

    var data = grid.jqGrid("getRowData", tsid);

    var gotourl = viewExportBillsEtsUrl;
    gotourl += "?etsNumber="+id;
    gotourl += "&serviceType="+data.serviceType;
    gotourl += "&documentClass="+data.documentClass;
    gotourl += "&documentType="+data.documentType;
    if ('undefined' != typeof sessionGroup && sessionGroup != 'BRANCH'){
    	gotourl += "&viewMode=viewMode";    	
    }

    location.href = gotourl;
}

function viewExportBillsDataEntry(id) {
    var grid = $("#grid_list_export_bills_unacted_branch");

    if ($("#grid_list_export_bills_unacted_tsd").length > 0) {
        grid = $("#grid_list_export_bills_unacted_tsd");
    }

    var data = grid.jqGrid("getRowData", id);
    

    var gotourl = viewExportBillsDataEntryUrl;
    gotourl += "?tradeServiceId="+id;
    gotourl += "&serviceType="+data.serviceType;
    gotourl += "&documentClass="+data.documentClass;
    gotourl += "&documentType="+data.documentType;
    if ('undefined' != typeof acc_userRole){
    	if (acc_userRole == 'TSDO'){
    		gotourl += "&hasRoute=true";
    	} else {
    		gotourl += "&hasRoute=false";
    	}
    }
    location.href = gotourl;
}

$(document).ready(function () {
    var gridurl = unactedExportBillsUrl;

    var _opt ={width: 780, loadui: "disable", scrollOffset:0};
    if(('undefined' !== typeof checkTsdTableId && '' == checkTsdTableId && "BRANCH" != sessionGroup) ||
    	('undefined' !== typeof setTsdGrid && '' != setTsdGrid)){
        $.extend(_opt,{height:'565',scroll:true,forceFit:true,rowNum:1000000});
    }

    setupJqGridWidthPagerHidden('grid_list_export_bills_unacted_branch',_opt,
        [['negoNumber', 'Negotiation Number', 10, 'left'],
            ['cifName', 'CIF Name', 8, 'left'],
            ['exporterName', 'Exporter\'s Name', 10, 'left'],
            ['transType', 'Transaction Type', 20, 'left'],
            ['negoCur', 'Negotiation Currency', 10, 'left'],
            ['negoAmt', 'Negotiation Amount', 10, 'right'],
            ['ets', 'e-TS', 3, 'center'],
            ['dataEntry', 'Data Entry', 5, 'center', 'hidden'],
            ['serviceType','Service Type', 1, 'left', 'hidden'],
            ['documentType','Document Type', 1, 'left', 'hidden'],
            ['documentClass','Document Class', 1, 'left', 'hidden']], 'grid_pager_export_bills_unacted', gridurl);

    setupJqGridWidthPagerHidden('grid_list_export_bills_unacted_tsd', _opt,
        [['negoNumber', 'Negotiation Number', 9, 'left'],
            ['cifName', 'CIF Name', 7, 'left'],
            ['exporterName', 'Exporter\'s Name', 9, 'left'],
            ['transType', 'Transaction Type', 20, 'left'],
            ['negoCur', 'Negotiation Currency', 9, 'left'],
            ['negoAmt', 'Negotiation Amount', 9, 'right'],
            ['ets', 'e-TS', 3, 'center'],
            ['dataEntry', 'Data Entry', 5, 'center'],
            ['serviceType','Service Type', 10, 'left', 'hidden'],
            ['documentType','Document Type', 10, 'left', 'hidden'],
            ['documentClass','Document Class', 10, 'left', 'hidden']], 'grid_pager_export_bills_unacted', gridurl);
});