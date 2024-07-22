function setupRefundOtherExportChargesGrids(){
	var refundOtherExportChargesGridUrl = '';
	
	if (referenceType.toLowerCase() == 'ets'){
		setupJqGridPagerWithHidden('grid_list_refund_other_export_charges', {height: 100, width: 780, loadui: "disable", scrollOffset:0},
			[['accountNumber', 'Account Number'],
			['modeOfPayment', 'Mode of Payment'],
			['refundCurrency', 'Refund Currency'],
			['amount', 'Amount'],
//			['edit','Edit'],
			['deleteRefundOtherExportCharges','Delete'],
			['status','Status' ,'left', 'hidden'],
			['action',' ','left', 'hidden']], 'grid_pager_refund_other_export_charges', refundOtherExportChargesGridUrl);
		
	}else if( referenceType.toLowerCase() == 'data entry'){
		setupJqGridPagerWithHidden('grid_list_refund_other_export_charges', {height: 100, width: 780, loadui: "disable", scrollOffset:0},
			[['accountNumber', 'Account Number'],
			['modeOfPayment', 'Mode of Payment'],
			['refundCurrency', 'Refund Currency'],
			['amount', 'Amount'],
//			['edit','Edit'],
			['status','Status'],
			['action',' '],
			['deleteRefundOtherExportCharges','Delete','left','hidden']], 'grid_pager_refund_other_export_charges', refundOtherExportChargesGridUrl);
	}
}

function initRefundOtherExportChargesGrid(){
	setupRefundOtherExportChargesGrids();

//	var refundOtherExportChargesGrid=$("#grid_list_refund_other_export_charges");
//	refundOtherExportChargesGrid.addRowData("1",{
//		accountNumber:'100-000-000',
//		modeOfPayment:'CASA',
//		refundCurrency:'USD',
//		amount:'1,000,000.00',
////		edit:'<a href=\"#\">edit</a>',
//		deleteRefundOtherExportCharges:'<a href=\"#\">delete</a>',
//		status: "Unpaid",
//		action: '<a href=\"javascript:void(0)\">Settle</a>'
//	});

}

$(initRefundOtherExportChargesGrid);
