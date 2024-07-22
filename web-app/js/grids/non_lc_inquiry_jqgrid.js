function setUpNonLcInquiry(){
	var lc_inquiry_main_grid_url = mainNonLcInquiryGridUrl;
	lc_inquiry_main_grid_url += "?unitcode="+unitcode

    setupJqGridWidthPagerHidden('grid_list_non_lc_inquiry_branch', {width: 780, height: 355, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['documentNumber', 'Document Number', 200],
            ['documentTypeFull', 'Document Type', 100],
            ['clientName', 'Client Name', 200],
            ['negoDate', 'Nego Date', 100],
            ['negoCurrency', 'Nego Currency', 100],
            ['outstandingAmount', 'Outstanding Amount', 100],
            ['negoAmount', 'Nego Amount', 100],
            ['createEts', 'Create eTS', 100, 'center', (userrole.indexOf('BRM') == -1) ? 'hidden' : ''],
            ['serviceType', 'Service Type', 4, 'left', 'hidden'],
            ['documentType', 'Document Type', 4, 'left', 'hidden'],
            ['documentClass', 'Document Class', 4, 'left', 'hidden']], 'grid_pager_non_lc_inquiry', lc_inquiry_main_grid_url);
	
	setupJqGridWidthPagerHidden('grid_list_non_lc_inquiry_main', {width: 780, height: 355, loadui: "disable", scrollOffset:0, rowNum: 20},
			[['unitCode', 'Unit Code', 80, 'center', ''],
			 ['documentNumber', 'Document Number', 150, 'left', ''],
	 		 ['documentTypeFull', 'Document Type', 100, 'left', ''],
	 		 ['status', 'Status', 100, 'center', ''],
	 		 ['clientName', 'Client Name', 150, 'left', ''],
	 		 ['maturityDate', 'Maturity Date', 100, 'center', ''],
	 		 ['negoDate', 'Nego Date', 100, 'center', ''],
	 		 ['settlementDate', 'Settlement Date', 100, 'center', ''],
	 		 ['settlementAmount', 'Settlement Amount', 150, 'right', ''], //added column, meron kc sa screenshot
	 		 ['negoCurrency', 'Nego Currency', 100, 'center', ''],
	 		 ['outstandingAmount', 'Outstanding Amount', 100, 'right', ''],
	 		 ['negoAmount', 'Nego Amount', 100, 'right', ''],
             ['cancelNegotiation', 'Action', 100, 'center', (userrole.indexOf('TSDM') == -1) ? 'hidden' : ''],
             ['serviceType', 'Service Type', 4, 'left', 'hidden'],
             ['documentType', 'Document Type', 4, 'left', 'hidden'],
             ['documentClass', 'Service Type', 4, 'left', 'hidden']], 'grid_pager_non_lc_inquiry', lc_inquiry_main_grid_url);
}

function setUpNonLcInquiryValidation(){
	if($("#grid_list_non_lc_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_non_lc_inquiry_branch").jqGrid("hideCol","createEts").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
//	if($("#grid_list_non_lc_inquiry_main") && "TSDM" != $("#userrole").val()){
//		$("#grid_list_non_lc_inquiry_main").jqGrid("hideCol","cancelNegotiation").jqGrid("setGridWidth",780).trigger("reloadGrid");
//	}
}

function initNonLcInquiry(){
    setUpNonLcInquiry();
    setUpNonLcInquiryValidation();
}

$(initNonLcInquiry);