

function setupBgInquiryGrids(){
	var bg_inquiry_grid_url = indemnityInquiryUrl;
	bg_inquiry_grid_url += "?unitcode="+unitcode;


//    setupJqGridWidthPagerHidden('grid_list_bg_inquiry_main', {width: 780, scrollOffset:0},
//        [['documentNumber', 'Document Number', 100, 'center'],
//            ['cifName', 'CIF Name', 200, 'left'],
//            ['originalAmount', 'Original LC Amount', 100, 'right'],
//            ['bgNumber', 'BG/BE Number', 100, 'center'],
//            ['status', 'Status', 80, 'center'],
//            ['shipmentNumber', 'Shipment Number', 100, 'center'],
//            ['shipmentAmount', 'Shipment Amount',100, 'right'],
//            ['bgCancel','Cancel',60,'center'],
//            ['shipmentCurrency', 'Shipment Currency', 60, 'center', 'hidden'],
//            ['indemnityIssueDate', 'Indemnity Issue Date', 60, 'center', 'hidden'],
//            ['processDate', 'Process Date', 60, 'center', 'hidden'],
//            ['blAirwayBillNumber', 'BL Airway Bill Number', 60, 'center', 'hidden'],
//            ['cwtFlag', 'CWT Flag', 60, 'center', 'hidden'],
//            ['documentType', 'Document Type', 60, 'center', 'hidden'],
//            ['documentClass', 'Document Class', 60, 'center', 'hidden'],
//            ['documentSubType1', 'Document SubType1', 60, 'center', 'hidden'],
//            ['documentSubType2', 'Document SubType2', 60, 'center', 'hidden'],
//            ['processingUnitCode', 'Processing Unit Code', 60, 'center', 'hidden'],
//            ['cifNumber', 'CIF Number', 60, 'center', 'hidden'],
//            ['ccbdBranchUnitCode', 'CCBD Branch Unit Code', 60, 'center', 'hidden'],
//            ['accountOfficer', 'Account Officer', 60, 'center', 'hidden']], 'grid_pager_bg_inquiry', bg_inquiry_grid_url);

	
    setupJqGridWidthPagerHidden('grid_list_bg_inquiry_main', {width: 780, height: 325, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['unitCode', 'Unit Code', 80, 'center'],
         	['documentNumber', 'Document Number', 100, 'center'],
            ['cifName', 'CIF Name', 200, 'left'],
            ['originalAmount', 'Original LC Amount', 100, 'right'],
            ['bgNumber', 'BG/BE Number', 100, 'center'],
            ['status', 'Status', 80, 'center'],
            ['shipmentNumber', 'Shipment Number', 100, 'center'],
            ['shipmentAmount', 'Shipment Amount',100, 'right'],
            ['bgCancel','Cancel',60,'center']], 'grid_pager_bg_inquiry', bg_inquiry_grid_url);

    setupJqGridWidthPagerHidden('grid_list_bg_inquiry_branch', {width: 780, height: 325, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['documentNumber', 'Document Number', 100, 'center'],
		    ['cifName', 'CIF Name', 200, 'left'],
			['originalAmount', 'Original LC Amount', 100, 'right'],
			['bgNumber', 'BG/BE Number', 100, 'center'],
			['status', 'Status', 80, 'center'],
			['shipmentNumber', 'Shipment Number', 100, 'center'],
			['shipmentAmount', 'Shipment Amount',100, 'right'],
            ['bgCancel','Cancel',60,'center','hidden'],
            ['shipmentCurrency', 'Shipment Currency', 60, 'center', 'hidden'],
            ['indemnityIssueDate', 'Indemnity Issue Date', 60, 'center', 'hidden'],
            ['processDate', 'Process Date', 60, 'center', 'hidden'],
            ['blAirwayBillNumber', 'BL Airway Bill Number', 60, 'center', 'hidden'],
            ['cwtFlag', 'CWT Flag', 60, 'center', 'hidden'],
            ['documentType', 'Document Type', 60, 'center', 'hidden'],
            ['documentClass', 'Document Class', 60, 'center', 'hidden'],
            ['documentSubType1', 'Document SubType1', 60, 'center', 'hidden'],
            ['documentSubType2', 'Document SubType2', 60, 'center', 'hidden'],
            ['processingUnitCode', 'Processing Unit Code', 60, 'center', 'hidden'],
            ['cifNumber', 'CIF Number', 60, 'center', 'hidden'],
            ['ccbdBranchUnitCode', 'CCBD Branch Unit Code', 60, 'center', 'hidden'],
            ['accountOfficer', 'Account Officer', 60, 'center', 'hidden']], 'grid_pager_bg_inquiry', bg_inquiry_grid_url);
}

function initializeBgInquiry(){
	setupBgInquiryGrids();
	setupBgInquiryGridsValidation();
}

function setupBgInquiryGridsValidation(){
	if($("#grid_list_bg_inquiry_main") && "TSDM" != $("#userrole").val()){
		$("#grid_list_bg_inquiry_main").jqGrid("hideCol","bgCancel").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function onBgCancel(id, indemnityNumber){
    var grid;

    if($("#grid_list_bg_inquiry_branch").length > 0) {
        grid = $("#grid_list_bg_inquiry_branch");
    } else {
        grid = $("#grid_list_bg_inquiry_main");
    }

    var gridData = grid.jqGrid("getRowData", id);

    $.post(multipleServiceInstructionUrl, {tradeProductNumber: gridData.documentNumber, serviceType: "Cancellation", isNotPrepared: true}, function (data) {

        if (data.success == "true") {
		    var gotoUrl = viewBgUrl;
		    gotoUrl += "?referenceNumber="+id;
		    gotoUrl += "&documentClass="+"INDEMNITY";
		    gotoUrl += "&serviceType="+"Cancellation";
		    gotoUrl += "&indemnityNumber="+indemnityNumber
		    
//    gotoUrl += "&processDate="+data.processDate;
//    gotoUrl += "&outstandingAmount="+data.originalAmount;
//    gotoUrl += "&blAirwayBillNumber="+data.blAirwayBillNumber;
//    gotoUrl += "&shipmentCurrency="+data.shipmentCurrency;
//    gotoUrl += "&shipmentSequenceNumber="+data.shipmentNumber;
//    gotoUrl += "&shipmentAmount="+data.shipmentAmount;
//    gotoUrl += "&indemnityIssueDate="+data.indemnityIssueDate;
//    gotoUrl += "&cwtFlag="+data.cwtFlag;
//    gotoUrl += "&documentType="+data.documentType;
//    gotoUrl += "&documentSubType1="+data.documentSubType1;
//    gotoUrl += "&documentSubType2="+data.documentSubType2;
//    gotoUrl += "&processingUnitCode="+data.processingUnitCode;
//    gotoUrl += "&cifNumber="+data.cifNumber;
//    gotoUrl += "&ccbdBranchUnitCode="+data.ccbdBranchUnitCode;
//    gotoUrl += "&accountOfficer="+data.accountOfficer;
//    gotoUrl += "&referenceNumber="+data.documentNumber;

		    location.href = gotoUrl;
        } else {
            triggerAlertMessage(data.message);
        }
    });
}

$(initializeBgInquiry);
	