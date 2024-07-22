function setUpExportBillsGrids(){
	var exportBillsInquiryGridUrl = '';
	
	setupJqGridWidthPagerHidden('grid_list_export_bills_inquiry_main', {width: 780, loadui: "disable", scrollOffset:0},
					[['unitCoder', 'Unit Code', 10, 'center'],
					['negotiationNumber', 'Negotiation<br />Number', 9],
					['clientName', 'Client<br />Name', 12],
					['corresBank',' Corres Bank', 12],
					['transactionType', 'Transaction Type', 18],
					['status', 'Status', 7],
					['processDate','Process Date', 8],
					['negoAmount', 'Nego<br />Amount', 7, 'right'],
					['settlementDate','Settlement<br />Date', 8],
					['proceedsAmount', 'Proceeds<br />Amount', 7, 'right'],
					['generateNegoAdvise', 'Generate Nego<br />Advise', 10, 'center'],
					['serviceType','Service Type', 10, 'left','hidden'],
					['documentType','Document Type', 10, 'left', 'hidden'],
					['documentClass','Document Class', 10, 'left', 'hidden']], 'grid_pager_export_bills_inquiry', exportBillsInquiryGridUrl);

	setupJqGridWidthPagerHidden('grid_list_export_bills_inquiry_branch', {width: 780, loadui: "disable", scrollOffset:0},
			[['negotiationNumber', 'Negotiation Number', 12],
				['transactionType', 'Transaction Type', 16],
				['status', 'Status', 7],
				['importer','Importer', 18],
				['exporter', 'Exporter', 18],
				['paymentMode','Payment Mode', 9],
				['action', 'Action', 7, 'center'],
				['serviceType','Service Type', 10, 'left','hidden'],
				['documentType','Document Type', 10, 'left', 'hidden'],
				['documentClass','Document Class', 10, 'left', 'hidden']], 'grid_pager_cancellation_inquiry', exportBillsInquiryGridUrl);

}
function initExportBillsGrid(){
	setUpExportBillsGrids();
	setUpExportBillsGridsValidation();
	
//    var mainGrids = $("#grid_list_export_bills_inquiry_main");
//    var branchGrids = $("#grid_list_export_bills_inquiry_branch");
//
//
//	//static data
//    mainGrids.addRowData("1",
//			{negotiationNumber:'915-11-20231',
//		     clientName:'Juliet Periabras',
//		     corresBank:'Bank of New York',
//		     transactionType:'Domestic Bills for Collection',
//		     status:'Negotiated',
//		     processDate:'08/25/2012',
//		     negoAmount:'1,000.00',
//		     settlementDate:'08/26/2012',
//		     proceedsAmount:'1,000.00',
//		     generateNegoAdvise:'<a href=\"javascript:void(0)\" onclick=\"onExportBillsModifyClick(1);\" style=\"color: blue\">Generate</a>',
//			 serviceType:"Negotiation",
//			 documentType:"Domestic",
//			 documentClass:"Collection"});
//
//    mainGrids.addRowData("2",
//			{negotiationNumber:'915-11-20231',
//		     clientName:'Juliet Periabras',
//		     corresBank:'Bank of New York',
//		     transactionType:'Export Bills for Collection',
//		     status:'Negotiated',
//		     processDate:'08/25/2012',
//		     negoAmount:'1,000.00',
//		     settlementDate:'08/26/2012',
//		     proceedsAmount:'1,000.00',
//		     generateNegoAdvise:'<a href=\"javascript:void(0)\" onclick=\"onExportBillsModifyClick(2);\" style=\"color: blue\">Generate</a>',
//			 serviceType:"Negotiation",
//			 documentType:"Export",
//			 documentClass:"Collection"});
//
//
//    mainGrids.addRowData("3",
//			{negotiationNumber:'915-11-20231',
//		     clientName:'Juliet Periabras',
//		     corresBank:'Bank of New York',
//		     transactionType:'Domestic Bills for Purchase',
//		     status:'Settled',
//		     processDate:'08/25/2012',
//		     negoAmount:'1,000.00',
//		     settlementDate:'08/26/2012',
//		     proceedsAmount:'1,000.00',
//		     generateNegoAdvise:'',
//			 serviceType:"Settlement",
//			 documentType:"Domestic",
//			 documentClass:"Purchase"});
//
//
//    mainGrids.addRowData("4",
//			{negotiationNumber:'915-11-20231',
//		     clientName:'Juliet Periabras',
//		     corresBank:'Bank of New York',
//		     transactionType:'Export Bills for Purchase',
//		     status:'Settled',
//		     processDate:'08/25/2012',
//		     negoAmount:'1,000.00',
//		     settlementDate:'08/26/2012',
//		     proceedsAmount:'1,000.00',
//		     generateNegoAdvise:'',
//			 serviceType:"Settlement",
//			 documentType:"Export",
//			 documentClass:"Purchase"});
//
//    mainGrids.addRowData("5",
//			{negotiationNumber:'915-11-20231',
//		     clientName:'Juliet Periabras',
//		     corresBank:'Bank of New York',
//		     transactionType:'Export Bills for Collection',
//		     status:'Cancelled',
//		     processDate:'08/25/2012',
//		     negoAmount:'1,000.00',
//		     settlementDate:'08/26/2012',
//		     proceedsAmount:'1,000.00',
//		     generateNegoAdvise:'',
//			 serviceType:"Cancellation",
//			 documentType:"Export",
//			 documentClass:"Collection"});
//
//
//
//
//
//
//
//	//branch static data
//    branchGrids.addRowData("1",
//			{negotiationNumber:'915-11-20231',
//		     transactionType:'Domestic Bills for Purchase',
//		     status:'Negotiated',
//		     importer:'',
//		     exporter:'',
//		     paymentMode:'CASA',
//		     action:"<a href=\"javascript:void(0)\" onclick=\"onExportBillsCreateClick(1);\" style=\"color: blue\"> create eTS </a>",
//			 serviceType:"Negotiation",
//			 documentType:"Domestic",
//			 documentClass:"Purchase"});
//
//
//    branchGrids.addRowData("2",
//			{negotiationNumber:'915-11-20231',
//		     transactionType:'Domestic Bills for Purchase',
//		     status:'Negotiated',
//		     importer:'',
//		     exporter:'',
//		     paymentMode:'CHECK',
//		     action:'<a href=\"javascript:void(0)\" onclick=\"onExportBillsCreateClick(2);\" style=\"color: blue\">create eTS</a>',
//			 serviceType:"Negotiation",
//			 documentType:"Domestic",
//			 documentClass:"Purchase"});
//
//    branchGrids.addRowData("3",
//			{negotiationNumber:'915-11-20231',
//		     transactionType:'Export Bills for Purchase',
//		     status:'Negotiated',
//		     importer:'',
//		     exporter:'',
//		     paymentMode:'CASA',
//		     action:'<a href=\"javascript:void(0)\" onclick=\"onExportBillsCreateClick(3);\" style=\"color: blue\">create eTS</a>',
//			 serviceType:"Negotiation",
//			 documentType:"Export",
//			 documentClass:"Purchase"});
//
//    branchGrids.addRowData("4",
//			{negotiationNumber:'915-11-20231',
//		     transactionType:'Domestic Bills for Purchase',
//		     status:'Negotiated',
//		     importer:'',
//		     exporter:'',
//		     paymentMode:'CASH',
//		     action:'<a href=\"javascript:void(0)\" onclick=\"onExportBillsCreateClick(4);\" style=\"color: blue\">create eTS</a>',
//			 serviceType:"Negotiation",
//			 documentType:"Export",
//			 documentClass:"Purchase"});

    

}

$(initExportBillsGrid);

function onExportBillsCreateClick(id){
	var grid = $("#grid_list_export_bills_inquiry_branch").jqGrid("getRowData",id);
	if(grid.documentType != ""){
		var url = modifyEtsExportBillsTransactionUrl
		url += '?serviceType=Settlement';
		switch(grid.documentType){
		case "Domestic":
			url += '&documentType='+grid.documentType;
			break;
		case "Export":
			url += '&documentType='+grid.documentType;
			break;
		}
		url += '&documentClass=Collection';
		url += '&referenceType=eTS';
		url += '&etsNumber=000-00-000-00-000000';		//Static value
		location.href = url;
	}
}

function onExportBillsModifyClick(id){
	var grid = $("#grid_list_export_bills_inquiry_main").jqGrid("getRowData",id);
	if(grid.documentType != ""){
		switch(grid.documentType){
		case "Domestic":
			var url = modifyDataEntryExportBillsTransactionUrl
			url += '?serviceType=Settlement';
			url += '&documentType='+grid.documentType;
			url += '&documentClass=Purchase';
			url += '&referenceType=Data Entry';
			location.href = url;
			closeExportBillsPopup()
			break;
		case "Export":
			openExportBillsModifyPopup();
			break;
		}
	}
}

function setUpExportBillsGridsValidation(){
	if($("#grid_list_export_bills_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_export_bills_inquiry_branch").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}
