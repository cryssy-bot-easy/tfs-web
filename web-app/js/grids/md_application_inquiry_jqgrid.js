
function setupDocumentTypeGrids() {
        var mdApplicationInquiryBranch = mdApplicationBranch;
        mdApplicationInquiryBranch += "?unitcode="+unitcode;
    // grid branch
        setupJqGridPagerWithHidden('grid_list_md_application_inquiry_branch', {width : 780, height: 390, loadui: "disable", scrollOffset : 0, rowNum: 20},
            [['documentNumber', 'Document Number'],
                ['dateCollected', 'Date Collected'],
                ['settlementCurrency', 'Settlement Currency'],
                ['outstandingAmount', 'O/S Amount'],
                ['clientName', 'Client Name', 'left'],
                ['action', 'Action', 'center'],
                ['pnSupportFlag', 'Use as PN Support', 'center', 'hidden'],
                ['serviceType', 'Service Type', 'center', 'hidden'],
                ['documentClass', 'Document Class', 'center', 'hidden']], 'grid_pager_md_application_inquiry_branch', mdApplicationInquiryBranch);

    // grid main
    var mdApplicationInquiryMain = mdApplicationMain;
    mdApplicationInquiryMain += "?unitcode="+unitcode;
    setupJqGridPagerWithHidden('grid_list_md_application_inquiry_main', {width : 780, height: 390, loadui: "disable", scrollOffset : 0, rowNum: 20},
        [['unitCode', 'Unit Code',],
      	 	['documentNumber', 'Document Number'],
            ['dateCollected', 'Date Collected'],
            ['settlementCurrency', 'Settlement Currency'],
            ['outstandingAmount', 'O/S Amount'],
            ['clientName', 'Client Name', 'left'],
            ['action', 'Action', 'center', (userrole.indexOf('TSDM') == -1) ? 'hidden' : ''],
            ['pnSupportFlag', 'Use as PN Support', 'center'],
            ['serviceType', 'Service Type', 'center', 'hidden'],
            ['documentClass', 'Document Class', 'center', 'hidden']], 'grid_pager_md_application_inquiry_main', mdApplicationInquiryMain);

////        var mdApplicationInquiryMain = mdApplicationInquiryGridMainUrl;
//    var mdApplicationInquiryMain = mdApplicationInquiryGridBranchUrl;
//        setupJqGridPagerWithHidden('grid_list_md_application_inquiry_main', {width : 780, scrollOffset : 0},
//            [['documentNumber', 'Document Number'],
////                ['clientName', 'Client Name'],
////                ['amount', 'LC Amount'],
//                ['dateCollected', 'Date Collected'],
//                ['settlementCurrency', 'Settlement Currency'],
////                ['amountCollected', 'Amount Collected'],
//                ['outstandingAmount', 'O/S Amount'],
//                ['clientName', 'Client Name', 'center'],
//                ['action', 'Action', 'center'],
//                ['pnSupportFlag', 'Use as PN Support', 'center'],
//                ['serviceType', 'Service Type', 'center', 'hidden'],
//                ['documentClass', 'Document Class', 'center', 'hidden']], 'grid_pager_md_application_inquiry_main',  mdApplicationInquiryMain);

}

function setupDocumentTypeGridsValidation(){
	if($("#grid_list_md_application_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_md_application_inquiry_branch").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
	if($("#grid_list_md_application_inquiry_main") && "TSDM" != $("#userrole").val()){
		$("#grid_list_md_application_inquiry_main").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function onApplyRefund(id) {
//    alert(id);
}

function onViewEts(){
    var url = '';

    url = etsMonitoringUrl;
    url += '?referenceType='+'eTS';
    url += '&documentType='+'MD';
    url += '&serviceType='+'Collection';
    location.href = url;

}

function initDocumentTypeGrid() {
    setupDocumentTypeGrids();
    setupDocumentTypeGridsValidation();

}

$(initDocumentTypeGrid);
