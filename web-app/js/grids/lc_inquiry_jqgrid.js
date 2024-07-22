function setupLcInquiryGrid() {
        var lcInquiryBranchUrl = branchLcInquiryUrl;
        lcInquiryBranchUrl += "?unitcode="+unitcode;

        setupJqGridPagerWithHidden('grid_list_lc_inquiry_branch', {width: 780, height: 295, loadui: "disable", scrollOffset:0, rowNum: 20},
        		/*[['documentNumber', 'Document Number'],
                 ['transactionType', 'Transaction Type'],
                 ['cifName', 'CIF Name'],
                 ['amount', 'Original LC Amount'],
                 ['outstandingAmount', 'O/S LC Amount'],
                 ['expiryDate', 'LC Expiry Date'],
                 ['actionDataEntry', 'View LC'],
                 ['actionEts', 'Create eTS'],
                 ['serviceType', 'Service Type', 'center', 'hidden'],
                 ['documentType', 'Document Type', 'center', 'hidden'],
                 ['documentClass', 'Document Class', 'center', 'hidden'],
                 ['documentSubType1', 'SubType1', 'center', 'hidden'],
                 ['documentSubType2', 'SubType2', 'center', 'hidden']], 'grid_pager_lc_inquiry_branch', lcInquiryBranchUrl);
                 */
        	[['documentNumber', 'Document Number'],
             	['cifNumber', 'CIF Number'],
                ['cifName', 'CIF Name'],
                ['currency', 'Currency'],
                ['amount', 'Original LC Amount', 'right'],
                ['outstandingAmount', 'O/S LC Amount', 'right'],
                ['expiryDate', 'LC Expiry Date'],
                ['lastTransaction', 'Last Transaction'],
                ['status', 'Status', 'center'], //Pinabalik via Joyce
                ['actionEts', 'Create eTS', 'center', (userrole.indexOf('BRM') == -1) ? 'hidden' : ''],
                ['serviceType', 'Service Type', 'center', 'hidden'],
                ['documentType', 'Document Type', 'center', 'hidden'],
                ['documentClass', 'Document Class', 'center', 'hidden'],
                ['documentSubType1', 'SubType1', 'center', 'hidden'],
                ['documentSubType2', 'SubType2', 'center', 'hidden'],
             	['mainCifNumber', 'Main CIF Number', 'center', 'hidden']], 'grid_pager_lc_inquiry_branch', lcInquiryBranchUrl);
             	
        
//        var lcInquiryMainUrl = branchLcInquiryUrl;

        setupJqGridPagerWithHidden('grid_list_lc_inquiry_main', {width: 780, height: 295, loadui: "disable", scrollOffset:0, rowNum: 20},
        		/*[['documentNumber', 'Document Number'],
                 ['cifName', 'CIF Name'],
                 ['amount', 'Original LC Amount'],
                 ['outstandingAmount', 'O/S LC Amount'],
                 ['expiryDate', 'LC Expiry Date'],
                 ['lcAction', 'Action'],
                 ['serviceType', 'Service Type', 'center', 'hidden'],
                 ['documentType', 'Document Type', 'center', 'hidden'],
                 ['documentClass', 'Document Class', 'center', 'hidden'],
                 ['documentSubType1', 'SubType1', 'center', 'hidden'],
                 ['documentSubType2', 'SubType2', 'center', 'hidden']], 'grid_pager_lc_inquiry_main', lcInquiryMainUrl);
                 */
            [['unitCode', 'Unit Code', 'center'],
             	['documentNumber', 'Document Number'],
             	['cifNumber', 'CIF Number'],
                ['cifName', 'CIF Name'],
                ['currency', 'Currency'],
                ['amount', 'Original LC Amount'],
                ['outstandingAmount', 'O/S LC Amount'],
                ['expiryDate', 'LC Expiry Date'],
                ['lastTransaction', 'Last Transaction'],
                ['status', 'Status', 'center'],
                ['action','Create Data Entry','center', (userrole.indexOf('TSDM') == -1) ? 'hidden' : ''],
                ['serviceType', 'Service Type', 'center', 'hidden'],
                ['documentType', 'Document Type', 'center', 'hidden'],
                ['documentClass', 'Document Class', 'center', 'hidden'],
                ['documentSubType1', 'SubType1', 'center', 'hidden'],
                ['documentSubType2', 'SubType2', 'center', 'hidden'],
             	['mainCifNumber', 'Main CIF Number', 'center', 'hidden']], 'grid_pager_lc_inquiry_main', lcInquiryBranchUrl);
}

function setupLcInquiryGridValidation(){
	if($("#grid_list_lc_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_lc_inquiry_branch").jqGrid("hideCol","actionEts").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
	if($("#grid_list_lc_inquiry_main") && "TSDM" != $("#userrole").val()){
		$("#grid_list_lc_inquiry_main").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function initLcInquiryGrid() {
    setupLcInquiryGrid();
    setupLcInquiryGridValidation();
}

$(initLcInquiryGrid);
