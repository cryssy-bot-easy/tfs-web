function setupUnactedAuxiliaryImportBranch(){

/*PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: unacted_auxiliary_import.js
	 *
	 */

    var unactedAuxillaryBranch = unactedAuxillaryBranchUrl;
    var _opt ={width: 780, loadui: "disable", scrollOffset:0};
    if('undefined' !== typeof setTsdGrid && '' != setTsdGrid){
    	$.extend(_opt,{height:'565',scroll:true,forceFit:true,rowNum:1000000});
    }
    
    setupJqGridPagerWithHidden('grid_list_auxiliary_import_unacted_branch', _opt,
        [['etsNumber', 'eTS Number'],
            ['applicantCifName', 'Applicant CIF Name'],
            ['transactionType', 'Transaction Type'],
            ['status', 'Status'],
            ['etsAction', 'eTS'],
            ['serviceType','Service Type', 'left', 'hidden'],
            ['documentType','Document Type', 'left', 'hidden'],
            ['documentClass','Document Class', 'left', 'hidden'],
            ['documentSubType1','SubType1', 'left', 'hidden'],
            ['documentSubType2','SubType2', 'left', 'hidden'],
            ['documentNumber', 'Document Number', 'left', 'hidden']], 'grid_pager_auxiliary_import_unacted_branch', unactedAuxillaryBranch);

    var unactedAuxillaryMain = unactedAuxillaryMainUrl;

    setupJqGridPagerWithHidden('grid_list_auxiliary_import_unacted_main', _opt,
        [['documentNumber', 'Document Number'],
            ['applicantCifName', 'Applicant CIF Name'],
            ['transactionType', 'Transaction Type'],
            ['status', 'Status'],
            ['etsAction', 'eTS'],
            ['dataEntryAction', 'Data Entry'],
            ['actionCharges', 'Payment'],
            ['serviceType','Service Type', 'left', 'hidden'],
            ['documentType','Document Type', 'left', 'hidden'],
            ['documentClass','Document Class', 'left', 'hidden'],
            ['documentSubType1','SubType1', 'left', 'hidden'],
            ['documentSubType2','SubType2', 'left', 'hidden'],
            ['etsNumber','eTS Number','left', 'hidden']], 'grid_pager_auxiliary_import_unacted_main', unactedAuxillaryMain);
    
    
    
    var unactedAuxillaryMaincdt = unactedAuxillaryMainUrlcdt;		
	
    setupJqGridPagerWithHidden('grid_list_auxiliary_import_unacted_maincdt', _opt,		
            [['documentNumber', 'Transaction Type'],		
                ['applicantCifName', 'Type of Report'],		
                ['transactionType', 'Date of Remittance'],		
                ['status', 'Amount Remitted'],		
                ['etsAction', 'PCHC Confirmation Date(From)'],		
                ['actionCharges', 'PCHC Confirmation Date(To)'],		
                ['actionCharges', 'Status'],		
                ['dataEntryAction', 'Action'],		
                ['serviceType','Service Type', 'left', 'hidden'],		
                ['documentType','Document Type', 'left', 'hidden'],		
                ['documentClass','Document Class', 'left', 'hidden'],		
                ['documentSubType1','SubType1', 'left', 'hidden'],		
                ['documentSubType2','SubType2', 'left', 'hidden'],		
                ['etsNumber','eTS Number','left', 'hidden']], 'grid_pager_auxiliary_import_unacted_maincdt', unactedAuxillaryMaincdt);		
    
        		
   
}

function initUnactedAuxiliaryImportBranch(){
    setupUnactedAuxiliaryImportBranch();
}

$(initUnactedAuxiliaryImportBranch);
