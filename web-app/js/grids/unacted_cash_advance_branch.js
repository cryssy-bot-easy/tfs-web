function setupUnactedCashAdvanceBranch(){
	var unactedCashAdvanceBranchUrl = '';
	
	setupJqGridPager('grid_list_cash_advance_unacted', {width: 780, loadui: "disable", scrollOffset:0},
					[['unactedCashAdvanceEtsNumber', 'eTS Number'],
					['unactedCashAdvanceApplicantCifName', 'Applicant CIF Name'],
					['unactedCashAdvanceTransactionType', 'Transaction Type'],
					['unactedCashAdvanceStatus', 'Status'],
					['unactedCashAdvanceAction', 'Action'],
					['unactedCashAdvanceCreateEts', 'Create eTS']], 'grid_pager_cash_advance_unacted', unactedCashAdvanceBranchUrl);
}

function initUnactedCashAdvanceBranch(){
	setupUnactedCashAdvanceBranch();
	
//	var gridList = $('#grid_list_cash_advance_unacted');
//
//	gridList.addRowData("1", {unactedCashAdvanceEtsNumber:"930-11-12345", unactedCashAdvanceApplicantCifName:"ABC COMPANY INC.",unactedCashAdvanceTransactionType:"Advance Payment",unactedCashAdvanceStatus:"PENDING",unactedCashAdvanceAction:"view",unactedCashAdvanceCreateEts:"<a href='javascript:void(0)'>create</a>"});
	
}

$(initUnactedCashAdvanceBranch);

