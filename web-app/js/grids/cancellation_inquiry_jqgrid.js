function setupcancellationInquiryGrids(){
	var cancellationInquiryGridUrl = '';
	
	setupJqGridWidthPagerHidden('grid_list_cancellation_inquiry', {width: 780, loadui: "disable", scrollOffset:0},
					[['documentNumber', 'Document Number'],
					['exporterName', 'exporterName'],
					['lcNumber', 'LC Number	'],
					['lcCurrencyAndAmount', 'LC Currency And Amount'],
					['lcIssueDate','LC Issue Date'],
					['lcExpiryDate','LC Expiry Date'],
					['issuingBank','Issuing Bank'],
					['dateOfCancellation','Date Of Cancellation']], 'grid_pager_cancellation_inquiry', cancellationInquiryGridUrl);
}
function initCancellationInquiryGrid(){
	setupcancellationInquiryGrids();
	
//    var cancellationGrids = $("#grid_list_cancellation_inquiry");
//
//	//static data
//	cancellationGrids.addRowData("1",
//			{documentNumber:'915-11-20231',
//		     exporterName:'Juliet Periabras',
//		     lcNumber:'858900',
//		     lcCurrencyAndAmount:'1,000.00',
//		     lcIssueDate:'08/25/2012',
//		     lcExpiryDate:'08/26/2012',
//		     issuingBank:'UCPB',
//		     dateOfCancellation:'08/26/2012' });
}

$(initCancellationInquiryGrid);

