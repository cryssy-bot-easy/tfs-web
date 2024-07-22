function setupAdvisingBankInquiryGrids(){
	var advisingBankInquiryGridUrl = '';
	
	if (serviceType.toLowerCase() == 'opening'){
		setupJqGridWidthPagerHidden('grid_list_advising_bank_inquiry', {width: 780, scrollOffset:0, loadui: "disable"},
			[['documentNumber', 'Document Number'],
			['cifNumber', 'CIF Number'], 
			['exporterName', 'Exporter Name'],
			['lcNumber', 'LC Number	'],
			['lcCurrency', 'LC Currency'],
			['lcAmount', 'LC Amount'],
			['issuingBank','Issuing Bank'],
			['secondAdvisingBank', '2nd Advising Bank'],
			['payCharges', 'Pay Charges'],
			['action', 'Action'],
			['dateOfCancellation','Date Of Cancellation',10,'left','hidden'],
			['amend', 'Amend',10,'left','hidden'],
			['cancel', 'Cancel',10,'left','hidden'],
			['lcIssueDate','LC Issue Date','left',10,'hidden'],
			['lcExpiryDate','LC Expiry Date','left',10,'hidden']], 'grid_pager_advising_bank_inquiry', advisingBankInquiryGridUrl);
	}else if(serviceType.toLowerCase() == 'amendment'){
		setupJqGridWidthPagerHidden('grid_list_advising_bank_inquiry', {width: 780, scrollOffset:0, loadui: "disable"},
			[['documentNumber', 'Document Number'],
			['exporterName', 'Exporter Name'],
			['lcNumber', 'LC Number	'],
			['lcCurrency', 'LC Currency'],
			['lcAmount', 'LC Amount'],
			['lcIssueDate','LC Issue Date'],
			['lcExpiryDate','LC Expiry Date'],
			['issuingBank','Issuing Bank'],
			['dateOfCancellation','Date Of Cancellation'],
//			['amend', 'Amend'],
			['payCharges', 'Pay Charges'],
			['cifNumber', 'CIF Number',10,'left','hidden'],
			['secondAdvisingBank', '2nd Advising Bank',10,'left','hidden'],
			['cancel', 'Cancel',10,'left','hidden']], 'grid_pager_advising_bank_inquiry', advisingBankInquiryGridUrl);
	}else if(serviceType.toLowerCase() == 'cancellation'){
		setupJqGridWidthPagerHidden('grid_list_advising_bank_inquiry', {width: 780, scrollOffset:0, loadui: "disable"},
			[['documentNumber', 'Document Number'],
			['exporterName', 'Exporter Name'],
			['lcNumber', 'LC Number	'],
			['lcCurrency', 'LC Currency'],
			['lcAmount', 'LC Amount'],
			['lcIssueDate','LC Issue Date'],
			['issuingBank','Issuing Bank'],
			['dateOfCancellation','Date Of Cancellation'],
//			['cancel', 'Cancel'],
			['payCharges', 'Pay Charges'],
			['cifNumber', 'CIF Number',10,'left','hidden'], 
			['lcExpiryDate','LC Expiry Date',10,'left','hidden'],
			['secondAdvisingBank', '2nd Advising Bank',10,'left','hidden'],
			['amend', 'Amend',10,'left','hidden']], 'grid_pager_advising_bank_inquiry', advisingBankInquiryGridUrl);
	}
}
function initAdvisingBankInquiryGrid(){
	setupAdvisingBankInquiryGrids();
	
    var advisingBankGrids = $("#grid_list_advising_bank_inquiry");
//	
	//static data
    if (serviceType.toLowerCase() == 'opening'){
	    advisingBankGrids.addRowData("1",{
//	    	documentNumber:'915-11-20231',
//	    	cifNumber: '',
//			exporterName:'Juliet Periabras',
//			lcNumber:'858900',
//			lcCurrency:'',
//			lcAmount: '',
////			lcIssueDate:'08/25/2012',
////			lcExpiryDate:'08/26/2012',
//			issuingBank:'UCPB',
//			secondAdvisingBank: '',
////			dateOfCancellation:'08/26/2012',
////			amend: '',
////			cancel: '',
//			payCharges: ''}
	    	action: '<a href="javascript:void()" onclick="openAdviseOnExportPopup()"> encode </a>'}
	    );
//    }else if(serviceType.toLowerCase() == 'amendment'){
//	    advisingBankGrids.addRowData("1",{
//	    	documentNumber:'915-11-20231',
////	    	cifNumber: '',
//			exporterName:'Juliet Periabras',
//			lcNumber:'858900',
//			lcCurrency:'',
//			lcAmount: '',
//			lcIssueDate:'08/25/2012',
//			lcExpiryDate:'08/26/2012',
//			issuingBank:'UCPB',
////			secondAdvisingBank: '',
//			dateOfCancellation:'08/26/2012',
//			amend: '',
////			cancel: '',
//			payCharges: ''}
//    }else if(serviceType.toLowerCase() == 'cancellation'){
//	    advisingBankGrids.addRowData("1",{
//	    	documentNumber:'915-11-20231',
////	    	cifNumber: '',
//			exporterName:'Juliet Periabras',
//			lcNumber:'858900',
//			lcCurrency:'',
//			lcAmount: '',
//			lcIssueDate:'08/25/2012',
////			lcExpiryDate:'08/26/2012',
//			issuingBank:'UCPB',
////			secondAdvisingBank: '',
//			dateOfCancellation:'08/26/2012',
////			amend: '',
//			cancel: '',
//			payCharges: ''}
    }
}

$(initAdvisingBankInquiryGrid);