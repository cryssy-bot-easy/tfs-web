

function setupCdtUploadPaymentHistoryGrids() {
	var cdtUploadPaymentHistoryUrl = '';
	
	setupJqGridPager('grid_list_cdt_upload_payment_history', {
		height : 150,
		width : 780,
		loadui: "disable", 
		scrollOffset : 0
	}, [ [ 'iedIeirdNo', 'IED/IEIRD No.' ],
			[ 'aabRefNo', 'AAB Ref No.' ], [ 'collectionDate', 'Collection Date' ],
			[ 'importersName', 'Importer\'s Name' ], [ 'cdtAmount', 'CDT Amount' ],
			[ 'requestType', 'Request Type' ], [ 'e2mStatus', 'e2m Status' ],
			[ 'tfsStatus', 'TFS Status' ],
			[ 'collectionDataEntry', 'Collection Data Entry' ] ],
			'grid_pager_cdt_upload_payment_history',
			cdtUploadPaymentHistoryUrl);

	

}

//link to pay duties and taxes page
function onPayDutiesAndTaxes(){
	var url = "";
	
	url = payDutiesAndTaxesUrl;
	url += '?serviceType='+"Customs Duties and Taxes";
	url += '&documentType='+"Collection";
	url += '&referenceType='+"Pay Duties and Taxes";
//	url += '&username='+$("#username").val();
	location.href = url;
	
}

function initCdtUploadPaymentHistoryGrid() {
	setupCdtUploadPaymentHistoryGrids();
	
//	// STATIC DATA
//	var cdtUploadPaymentHistoryGrid = $("#grid_list_cdt_upload_payment_history");
//
//	cdtUploadPaymentHistoryGrid.addRowData("1", {
//		iedIeirdNo : "&#160;",
//		aabRefNo : "&#160;",
//		collectionDate : "&#160;",
//		importersName : "&#160;",
//		cdtAmount : "&#160;",
//		requestType : "Advanced",
//		e2mStatus : "Confirmed",
//		tfsStatus : "Paid",
//		collectionDataEntry : "<a href='javascript:void(0)' style='color: blue;' onClick=\"onPayDutiesAndTaxes()\">view</a>"
//	});
}



$(initCdtUploadPaymentHistoryGrid);
