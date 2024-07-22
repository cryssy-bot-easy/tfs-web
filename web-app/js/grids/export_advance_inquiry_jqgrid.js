$(initializeImportAdvanceInquiryGrids);

function initializeImportAdvanceInquiryGrids(){
	setupImportAdvanceInquiryGrid();
	
//	var exportAdvanceInquiryGrid=$("#grid_list_export_advance_inquiry");
//	exportAdvanceInquiryGrid.addRowData("1",{
//		documentNumber:'100-000-000',
//		clientName:'AaBbCcDdEe',
//		currency: 'USD',
//		amount: '2,000.00',
//		createEts:'<a href=\"javascript:void(0)\" class=\"goToRefund\">Create-eTS</a>',
//		refundedAmount:'1,000,000.00'
//	});
}

function setupImportAdvanceInquiryGrid(){
	var exportAdvanceInquiryGridUrl
	
//	if (username.toLowerCase() == 'branch'){
		setupJqGridWidthPagerHidden('grid_list_export_advance_inquiry', {width: 780, loadui: "disable", scrollOffset:0},
			[['documentNumber', 'Document Number'],
			['clientName', 'Client Name'], 
			['currency', 'Currency'],
			['amount', 'Amount'],
			['createEts', 'Create'],
			['refundedAmount','Refunded Amount','left',10,'hidden']], 'grid_pager_export_advance_inquiry', exportAdvanceInquiryGridUrl);
	/*}else{
		setupJqGridWidthPagerHidden('grid_list_export_advance_inquiry', {width: 780, scrollOffset:0},
			[['documentNumber', 'Document Number'],
			['clientName', 'Client Name'], 
			['currency', 'Currency'],
			['amount', 'Amount'],
			['refundedAmount','Refunded Amount'],
			['refund', 'Refund','left',10,'hidden']], 'grid_pager_export_advance_inquiry', exportAdvanceInquiryGridUrl);		
	} */
}


$(document).ready(function(){
	$(".goToRefund").click(function(){
		var url = '';
		var referenceType = 'eTS'
			
		url = etsExportAdvanceRefundUrl;
		url += '?serviceType='+"Export Advance Refund"
		url += '&referenceType='+referenceType;
		location.href = url;
	});
});