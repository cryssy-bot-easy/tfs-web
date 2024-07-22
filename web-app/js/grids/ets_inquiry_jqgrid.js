function setupBranchEtsInquiryGrid() {
    var ets_inquiry_branch_grid_url = branchEtsInquiryUrl;
    ets_inquiry_branch_grid_url += "?unitcode="+unitcode;
//    var pageUrl3 = '';

        setupJqGridPagerWithHidden('grid_list_ets_inquiry_branch', {width: 780, height: 290, loadui: "disable", scrollOffset:0, rowNum: 20},
            [['eTSCreateDateTime', 'eTS Created Date/Time'],
             ['eTSModifiedDateTime', 'eTS Modified Date/Time'],
             ['eTSApprovedDateTime', 'eTS Approved Date/Time'],
                ['etsNumber', 'eTS Number'],
                ['cifNumber', 'CIF Number'],
                ['cifName', 'CIF Name'],
                ['transactionType', 'Transaction Type'],
                ['createdBy', 'Created By'],
                ['approvedBy', 'Approved By'],
                ['lastUser', 'Last User'],
                ['status', 'Status'],
//                ['dateTime', 'Date/Time'],
                ['reroute', 'Reroute'],
                ['reverse', 'Reverse'],
                ['tradeServiceStatus', 'Trade Service Status'],
                ['tsdUser', 'TSD User'],
                ['serviceType', 'Service Type', 'center', 'hidden'],
                ['documentType', 'Document Type', 'center', 'hidden'],
                ['documentClass', 'Document Class', 'center', 'hidden'],
                ['documentSubType1', 'SubType1', 'center', 'hidden'],
                ['documentSubType2', 'SubType2', 'center', 'hidden'],
                ['currentOwner', 'Current Owner', 'center', 'hidden']], 'grid_pager_ets_inquiry_branch', ets_inquiry_branch_grid_url);

        setupJqGridPagerWithHidden('grid_list_ets_inquiry_main', {width: 780, height: 290, loadui: "disable", scrollOffset:0, rowNum: 20},
            [['unitCode', 'Unit Code', 'center'],
             	['eTSDateTime', 'eTS Date/Time'],
                ['etsNumber', 'eTS Number'],
                ['cifNumber', 'CIF Number'],
                ['cifName', 'CIF Name'],
                ['transactionType', 'Transaction Type'],
                ['lastUser', 'Last User'],
                ['status', 'Status'],
//                ['dateTime', 'Date/Time'],
                ['reroute', 'Reroute', 'center','hidden'],
                ['serviceType', 'Service Type', 'center', 'hidden'],
                ['documentType', 'Document Type', 'center', 'hidden'],
                ['documentClass', 'Document Class', 'center', 'hidden'],
                ['documentSubType1', 'SubType1', 'center', 'hidden'],
                ['documentSubType2', 'SubType2', 'center', 'hidden'],
                ['currentOwner', 'Current Owner', 'center', 'hidden']], 'grid_pager_ets_inquiry_main', ets_inquiry_branch_grid_url);
}

function setupBranchEtsInquiryGridValidation(){
	if($("#grid_list_ets_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_ets_inquiry_branch").jqGrid("hideCol","reverse").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function initEtsInquiryJqGrid() {
    setupBranchEtsInquiryGrid();
    setupBranchEtsInquiryGridValidation();
}

$(initEtsInquiryJqGrid);