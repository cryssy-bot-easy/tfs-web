function setupUnactedLetterOfCreditBranch(){
        var unactedLcBranch = unactedLcBranchUrl ;
        var _opt ={width: 780, loadui: "disable", scrollOffset:0};
        if(('undefined' !== typeof checkTsdTableId && '' == checkTsdTableId && "BRANCH" != sessionGroup) ||
        		('undefined' !== typeof setTsdGrid && '' != setTsdGrid)){
        	$.extend(_opt,{height:'565',scroll:true,forceFit:true,rowNum:1000000});
        }

        setupJqGridWidthPagerHidden('grid_list_letter_of_credit_unacted_branch',_opt ,
        		[['etsNumber', 'eTS Number', 150],
        		['temporaryName', 'Transaction Type', 190],
                ['applicantCifName', 'Applicant CIF Name', 200],
                ['currency', 'Original Currency', 30, 'center'],
                ['amount', 'Transaction Amount', 150, 'right'],
                ['status', 'Status', 90],
                ['action', 'Action', 35, 'center'],
//				['actionEts', 'Create eTS'],
                ['serviceType','Service Type', 10, 'left','hidden'],
                ['documentType','Document Type', 10, 'left', 'hidden'],
                ['documentClass','Document Class', 10, 'left', 'hidden'],
                ['documentSubType1','SubType1', 10, 'left', 'hidden'],
                ['documentSubType2','SubType2', 10, 'left', 'hidden'],
                ['documentNumber', 'Document Number', 10, 'left', 'hidden']], 'grid_pager_letter_of_credit_unacted_branch', unactedLcBranch);

        var unactedLcMain = unactedLcMainUrl;
        
        setupJqGridWidthPagerHidden('grid_list_letter_of_credit_unacted_main', _opt,
        		[['documentNumber', 'Document Number', 150],
        		['temporaryName', 'Transaction Type', 190],
                ['applicantCifName', 'Applicant CIF Name', 200],
                ['currency', 'Original Currency', 30, 'center'],
                ['amount', 'Transaction Amount', 150, 'right'],
                ['status', 'Status', 90],
                ['actionEts', 'eTS', 30, 'center'],
                ['actionDataEntry', 'Data Entry', 60, 'center'],
                ['actionCharges', 'Payment', 45, 'center'],
                ['serviceType','Service Type', 10, 'left','hidden'],
                ['documentType','Document Type', 10, 'left','hidden'],
                ['documentClass','Document Class', 10, 'left','hidden'],
                ['documentSubType1','SubType1', 10, 'left','hidden'],
                ['documentSubType2','SubType2', 10, 'left','hidden'],
                ['etsNumber', 'eTS Number', 10, 'left','hidden'],
                ['reversalEtsNumber', 'Reversal eTS Number', 10, 'left','hidden']], 'grid_pager_letter_of_credit_unacted_main', unactedLcMain);
}

function initUnactedLetterOfCreditBranch(){
    setupUnactedLetterOfCreditBranch();

//	insertToUnactedLc()
}

$(initUnactedLetterOfCreditBranch);

