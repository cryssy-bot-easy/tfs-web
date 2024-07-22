function payOtherCharges(id) {
    location.href = gotoOtherExportChargesUrl +="?documentNumber="+id;
}

function refundExportCharge(id) {
    location.href = gotoOtherExportChargesUrl +="?documentNumber="+id;
}

function setUpPaymentOtherExportChargesInquiry(){

    var paymentInquiryUrl = searchAllExportsUrl;
    paymentInquiryUrl += "?unitcode="+unitcode;

    //Branch
    setupJqGridWidthPagerHidden('grid_list_payment_other_export_charges_inquiry', {width: 780, height: 340, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['unitCode', 'Unit Code'],
      		['cifName', 'CIF Name'],
            ['transaction', 'Transaction'],
            ['documentNumber', 'Document Number'],
            ['lcDraftAmount', 'LC/Draft Amount', 300, 'right'],
            ['importerName',' Importer Name'],
            ['exporterName', 'Exporter Name'],
            ['action', 'Action']], 'grid_pager_payment_other_export_charges_inquiry', paymentInquiryUrl);


    setupJqGridWidthPagerHidden('grid_list_payment_other_export_charges_inquiry_tsd', {width: 780, height: 340, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['unitCode', 'Unit Code'],
         	['cifName', 'CIF Name'],
            ['transaction', 'Transaction'],
            ['documentNumber', 'Document Number'],
            ['lcDraftAmount', 'LC/Draft Amount', 300, 'right'],
            ['importerName',' Importer Name'],
            ['exporterName', 'Exporter Name'],
            ['action', 'Action', 0, 'center', 'hidden']], 'grid_pager_payment_other_export_charges_inquiry', paymentInquiryUrl);
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
    setUpPaymentOtherExportChargesInquiry();

    $("#exportChargesSearch").click(function() {
        var searchUrl = searchAllExportsUrl;
        searchUrl += "?"+$("#otherExportChargesInquiry").serialize();
        searchUrl += "&unitcode="+unitcode;

        var grid;

        if ($("#grid_list_payment_other_export_charges_inquiry").length > 0) {
            grid = $("#grid_list_payment_other_export_charges_inquiry");
        } else {
            grid = $("#grid_list_payment_other_export_charges_inquiry_tsd");
        }
        grid.jqGrid('setGridParam', {page: 1, url: searchUrl, gridComplete: alertOtherExportsCount}).trigger("reloadGrid");
    });

    $("#exportChargesReset").click(function() {
        $("#cifName, #importerName, #exporterName, #transaction, #unitCode").val("");
        var searchUrl = searchAllExportsUrl;
        searchUrl += "?unitcode="+unitcode;

        var grid;

        if ($("#grid_list_payment_other_export_charges_inquiry").length > 0) {
            grid = $("#grid_list_payment_other_export_charges_inquiry");
        } else {
            grid = $("#grid_list_payment_other_export_charges_inquiry_tsd");
        }
        grid.jqGrid('setGridParam', {page: 1, url: searchUrl}).trigger("reloadGrid");
    });
}

function alertOtherExportsCount(){
	var grid;
	
	if ($("#grid_list_payment_other_export_charges_inquiry").length > 0) {
		grid = $("#grid_list_payment_other_export_charges_inquiry");
	} else {
		grid = $("#grid_list_payment_other_export_charges_inquiry_tsd");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

$(initPaymentOtherImportChargesInquiry);