function payOtherCharges(id) {
    location.href = gotoOtherImportChargesUrl +="?documentNumber="+id;
}

function setUpPaymentOtherImportChargesInquiry(){
	
	var paymentInquiryUrl = searchAllImportsUrl;
	paymentInquiryUrl += "?unitcode="+unitcode;
	
	//Main
//	setupJqGridWidthPagerHidden('grid_list_payment_other_import_charges_inquiry', {width: 780, scrollOffset:0},
//			[['cifNumber', 'CIF NUMBER', 100],
//			['cifName','CIF Name', 200],
//			['viewAction', 'eTS', 60, 'center'],
//			['actionDataEntry', 'Data-Entry', 60, 'center'],
//			['referenceType', 'Import Type',10, 'left', 'hidden'],
//			['documentType','Document Type', 10,'left', 'hidden'],
//			['serviceType','Service Type',10, 'left', 'hidden']], 'grid_pager_letter_of_credit_unacted', paymentInquiryUrl);

	//Branch
	setupJqGridWidthPagerHidden('grid_list_payment_other_import_charges_inquiry', {width: 780, height: 425, loadui: "disable", scrollOffset:0, rowNum: 20},
			[['documentNumber' , 'Document Number', 60],
			['transactionType', 'Transaction Type', 60],
			['unitCode', 'Unit Code', 60],
         	['cifNumber', 'CIF Number', 60],
			['cifName','CIF Name', 200],
			['viewAction', 'Action', 60, 'center'],
			['actionDataEntry', 'Data-Entry', 60, 'center', 'hidden'],
			['referenceType', 'Import Type',10, 'left', 'hidden'],
			['documentType','Document Type', 10,'left', 'hidden'],
			['serviceType','Service Type',10, 'left', 'hidden']], 'grid_pager_payment_other_import_charges_inquiry', paymentInquiryUrl);


    setupJqGridWidthPagerHidden('grid_list_payment_other_import_charges_inquiry_tsd', {width: 780, height: 425, loadui: "disable", scrollOffset:0, rowNum: 20},
    		[['documentNumber' , 'Document Number', 60],
			['transactionType', 'Transaction Type', 60],
			['unitCode', 'Unit Code', 100],
      		['cifNumber', 'CIF Number', 100],
            ['cifName','CIF Name', 200]], 'grid_pager_payment_other_import_charges_inquiry', paymentInquiryUrl);
}

function onDataEntryClick(id){
	var grid = $("#grid_list_payment_other_import_charges_inquiry").jqGrid("getRowData",id);
	var url = "";
	
	if(grid.referenceType=="Data Entry" && grid.documentType=="Payment"){
		
		url = dataEntryPaymentOtherImportChargesTSDUrl;
		url += '?referenceType='+grid.referenceType;
		url += '&documentType='+grid.documentType;
		url += '&serviceType='+grid.serviceType;
//		url += '&username='+$("#username").val();
		location.href = url;
	}
}

function onDataEntryClick(){
	
	var url="";
	
	url = dataEntryPaymentOtherImportChargesUrl;
	url += '?referenceType='+"Data Entry";
	url += '&documentType='+"Payment";
	url += '&serviceType='+"Other Import Charges(Others)";
//	url += '&username='+$("#username").val();
	location.href = url;
	
}

function initPaymentOtherImportChargesInquiry(){
	setUpPaymentOtherImportChargesInquiry();
    $("#importChargesSearch").click(function() {
        var searchUrl = searchAllImportsUrl;
        searchUrl += "?"+$("#otherImportChargesInquiry").serialize();
        searchUrl += "&unitcode="+unitcode;

        var grid;

        if ($("#grid_list_payment_other_import_charges_inquiry").length > 0) {
            grid = $("#grid_list_payment_other_import_charges_inquiry");
        } else {
            grid = $("#grid_list_payment_other_import_charges_inquiry_tsd");
        }
        grid.jqGrid('setGridParam', {page: 1, url: searchUrl, gridComplete: alertOtherImportsCount}).trigger("reloadGrid");
    });

    $("#importChargesReset").click(function() {
        $("#documentNumber, #cifNumber, #cifName, #unitCode").val("");
        var searchUrl = searchAllImportsUrl;
        searchUrl += "?unitcode="+unitcode;

        var grid;

        if ($("#grid_list_payment_other_import_charges_inquiry").length > 0) {
            grid = $("#grid_list_payment_other_import_charges_inquiry");
        } else {
            grid = $("#grid_list_payment_other_import_charges_inquiry_tsd");
        }
        grid.jqGrid('setGridParam', {page: 1, url: searchUrl}).trigger("reloadGrid");
    });
}

function alertOtherImportsCount(){
	var grid;
	
	if ($("#grid_list_payment_other_import_charges_inquiry").length > 0) {
		grid = $("#grid_list_payment_other_import_charges_inquiry");
	} else {
		grid = $("#grid_list_payment_other_import_charges_inquiry_tsd");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

$(initPaymentOtherImportChargesInquiry);