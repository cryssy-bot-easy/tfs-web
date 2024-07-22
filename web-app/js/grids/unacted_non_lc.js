function setupUnactedNonLetterOfCreditBranch(){
        var unactedNonLcBranch = unactedNonLcBranchUrl;
        var _opt ={width: 780, loadui: "disable", scrollOffset:0};
        if(('undefined' !== typeof checkTsdTableId && '' == checkTsdTableId && "BRANCH" != sessionGroup) ||
        	('undefined' !== typeof setTsdGrid && '' != setTsdGrid)){
        	$.extend(_opt,{height:'565',scroll:true,forceFit:true,rowNum:1000000});
        }

		setupJqGridWidthPagerHidden('grid_list_non_letter_of_credit_unacted_branch', _opt,
				[['etsNumber', 'eTS Number', 100],
				['temporaryName', 'Transaction Type', 120],
				['applicantCifName', 'Applicant CIF Name', 200],
				['currency', 'Original Currency', 30, 'center'],
				['amount', 'Transaction Amount', 100, 'right'],
				['status', 'Status', 100, 'center'],
				['actionEts', 'eTS', 80, 'center'],
				['serviceType','Service Type', 10, 'left', 'hidden'],
				['documentType','Document Type', 10, 'left', 'hidden'],
				['documentClass','Document Class', 10, 'left', 'hidden']], 'grid_pager_non_letter_of_credit_unacted_branch', unactedNonLcBranch);

        var unactedNonLcMain = unactedNonLcMainUrl;
		setupJqGridWidthPagerHidden('grid_list_non_letter_of_credit_unacted_main', _opt,
				[['documentNumber', 'Document Number', 100],
				['temporaryName', 'Transaction Type', 120],
				['applicantCifName', 'Applicant CIF Name', 200],
				['currency', 'Original Currency', 30, 'center'],
				['amount', 'Transaction Amount', 100, 'right'],
				['status', 'Status', 90],
				['actionEts', 'eTS', 35],
				['actionDataEntry', 'Data-Entry', 60],
				['actionCharges', 'Payment', 40],
				['serviceType','Service Type', 10, 'left', 'hidden'],
				['documentType','Document Type', 10, 'left', 'hidden'],
				['documentClass','Document Class', 10, 'left', 'hidden'],
				['etsNumber', 'eTS Number', 10, 'left', 'hidden'],
				['reversalEtsNumber','Reversal Ets Number', 10, 'left', 'hidden']], 'grid_pager_non_letter_of_credit_unacted_main', unactedNonLcMain);

}

function initUnactedNonLetterOfCreditBranch(){
	setupUnactedNonLetterOfCreditBranch();
}

$(initUnactedNonLetterOfCreditBranch);

