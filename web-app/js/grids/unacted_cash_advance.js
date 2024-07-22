function setupUnactedCashAdv(){
	var username = sessionGroup;
	var cashAdvanceBranchUrl = unactedCashAdvanceBranchUrl;
    var cashAdvanceMainUrl = unactedCashAdvanceMainUrl;
    var _opt ={width: 780, loadui: "disable", scrollOffset:0};
    if('undefined' !== typeof setTsdGrid && '' != setTsdGrid){
    	$.extend(_opt,{height:'565',scroll:true,forceFit:true,rowNum:1000000});
    }
    
	if(username == "BRANCH") {
        setupJqGridPagerWithHidden('grid_list_cash_advance_unacted', _opt,
			[['etsNumber', 'eTS Number'],
			 ['applicantCifName', 'Applicant CIF Name'],
			 ['transactionType', 'Transaction Type'],
			 ['status', 'Status'],
			 ['viewEts', 'eTS'],
             ['serviceType','Service Type', 'left', 'hidden'],
             ['documentType','Document Type', 'left', 'hidden'],
             ['documentClass','Document Class', 'left', 'hidden'],
             ['documentSubType1','SubType1', 'left', 'hidden'],
             ['documentSubType2','SubType2', 'left', 'hidden'],
             ['documentNumber', 'Document Number', 'left', 'hidden']], 'grid_pager_cash_advance_unacted', cashAdvanceBranchUrl);
	}else if(username == "TSD") {
        setupJqGridPagerWithHidden('grid_list_cash_advance_unacted', _opt,
			[['documentNumber', 'Document Number'],
			 ['applicantCifName', 'Applicant CIF Name'],
			 ['transactionType', 'Transaction Type'],
			 ['status', 'Status'],
			 ['viewEts', 'eTS'],
			 ['dataEntry', 'Data-Entry'],
             ['serviceType','Service Type', 'left', 'hidden'],
             ['documentType','Document Type', 'left', 'hidden'],
             ['documentClass','Document Class', 'left', 'hidden'],
             ['documentSubType1','SubType1', 'left', 'hidden'],
             ['documentSubType2','SubType2', 'left', 'hidden'],
             ['documentNumber', 'Document Number', 'left', 'hidden']], 'grid_pager_cash_advance_unacted', cashAdvanceMainUrl);
	}
}

function onEtsCashAdvClick(id) {
	var grid = $("#grid_list_cash_advance_unacted").jqGrid("getRowData",id);
	var url = '';
	var referenceType = 'eTS'
		
	if (grid.serviceType.toLowerCase() == 'export advance payment'){
		url = etsExportAdvancePaymentUrl;
		url += '?serviceType='+grid.serviceType;
		url += '&referenceType='+referenceType;
		location.href = url;
	}else if(grid.serviceType.toLowerCase() == 'export advance refund'){
		url = etsExportAdvanceRefundUrl;
		url += '?serviceType='+grid.serviceType;
		url += '&referenceType='+referenceType;
		location.href = url;
	} else if(grid.transactionType.indexOf("Import Advance")>=0){
		url = etsImportAdvanceUrl;
		url += '?referenceType='+"eTS";
		url += '&documentType='+"Import%20Advance";
		url += '&serviceType='+grid.serviceType;
		url += '&username='+$("#username").val();
		location.href = url;
	}
	
	
}


function onDataEntryCashAdvClick(id) {
	var grid = $("#grid_list_cash_advance_unacted").jqGrid("getRowData",id);
	var url = '';
	var referenceType = 'Data Entry'
		
	if (grid.serviceType.toLowerCase() == 'export advance payment'){
		url = dataEntryExportAdvancePaymentUrl;
		url += '?serviceType='+grid.serviceType;
		url += '&referenceType='+referenceType;
		location.href = url;
	}else if(grid.serviceType.toLowerCase() == 'export advance refund'){
		url = dataEntryExportAdvanceRefundUrl;
		url += '?serviceType='+grid.serviceType;
		url += '&referenceType='+referenceType;
		location.href = url;
	}else if(grid.transactionType.indexOf('Import Advance')>=0){
		url = dataEntryImportAdvanceUrl;
		url += '?referenceType='+"Data Entry";
		url += '&documentType='+grid.documentType;
		url += '&serviceType='+grid.serviceType;
		url += '&username='+$("#username").val();
		location.href = url;
	}
	 
	
	
}

function initUnactedCashAdv(){
	setupUnactedCashAdv();
}

$(initUnactedCashAdv);


/*function setupUnactedCashAdvanceBranch(){
	var unactedCashAdvanceBranchUrl = '';
	
	setupJqGridPager('grid_list_cash_advance_unacted', {width: 780, scrollOffset:0},
					[['unactedCashAdvanceEtsNumber', 'eTS Number'],
					['unactedCashAdvanceApplicantCifName', 'Applicant CIF Name'],
					['unactedCashAdvanceTransactionType', 'Transaction Type'],
					['unactedCashAdvanceStatus', 'Status'],
					['unactedCashAdvanceAction', 'Action'],
					['unactedCashAdvanceCreateEts', 'Create eTS']], 'grid_pager_cash_advance_unacted', unactedCashAdvanceBranchUrl);
}

function initUnactedCashAdvanceBranch(){
	setupUnactedCashAdvanceBranch();
	
	var gridList = $('#grid_list_cash_advance_unacted');
	
	gridList.addRowData("1", {unactedCashAdvanceEtsNumber:"930-11-12345", unactedCashAdvanceApplicantCifName:"ABC COMPANY INC.",unactedCashAdvanceTransactionType:"Advance Payment",unactedCashAdvanceStatus:"PENDING",unactedCashAdvanceAction:"view",unactedCashAdvanceCreateEts:"<a href='javascript:void(0)'>create</a>"});
	
}

$(initUnactedCashAdvanceBranch);

*/