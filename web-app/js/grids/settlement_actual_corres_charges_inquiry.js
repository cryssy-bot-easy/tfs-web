function searchActualCorresCharges() {
    var postUrl = corresChargesInquiryUrl;
    postUrl += "?"+$("#corresChargesInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    var grid = $("#grid_list_settlement_actual_corres_charges_inquiry_branch");

    if (grid.length < 1) {
        grid = $("#grid_list_settlement_actual_corres_charges_inquiry_tsd");
    }

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertActualCorresChargesCount}).trigger("reloadGrid");
}

function alertActualCorresChargesCount(grid){
    var grid = $("#grid_list_settlement_actual_corres_charges_inquiry_branch");

    if (grid.length < 1) {
        grid = $("#grid_list_settlement_actual_corres_charges_inquiry_tsd");
    }

    triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
    grid.jqGrid('setGridParam', {gridComplete: ""});
}

function resetActualCorresCharges() {
    var postUrl = corresChargesInquiryUrl;
    $("#documentNumber, #unitCode").val("");
    
    var grid = $("#grid_list_settlement_actual_corres_charges_inquiry_branch");

    if (grid.length < 1) {
        grid = $("#grid_list_settlement_actual_corres_charges_inquiry_tsd");
    }
    
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
}

function setUpActualCorresChargesInquiry(){
	
	var settlementInquiryUrl = corresChargesInquiryUrl;
    settlementInquiryUrl += "?"+$("#corresChargesInquiry").serialize();
    settlementInquiryUrl += "&unitcode="+unitcode;


    setupJqGridWidthPagerHidden('grid_list_settlement_actual_corres_charges_inquiry_branch', {width: 780, height: 410, loadui: "disable", scrollOffset:0, rowNum: 20},
				[['docNumber', 'Document Number', 150],
				['clientName','Client Name', 180],
				['datePaid','Date Paid', 100, 'center'],
				['advanceCorresCharges','O/S Advance Corresponding Charges (in PHP)', 120, 'right'],
				['actionEts', 'eTS', 80, 'center']], 'grid_pager_settlement_actual_corres_charges_inquiry', settlementInquiryUrl);
	
    setupJqGridWidthPagerHidden('grid_list_settlement_actual_corres_charges_inquiry_tsd', {width: 780, height: 410, loadui: "disable", scrollOffset:0, rowNum:20},
				[['unitCode', 'Unit Code', 80, 'center'],
				['docNumber', 'Document Number', 150],
				['clientName','Client Name', 180],
				['datePaid','Date Paid', 100, 'center'],
				['advanceCorresCharges','O/S Advance Corresponding Charges (in PHP)', 120, 'right'],
				['actionDataEntry', 'Data Entry', 80, 'center']], 'grid_pager_settlement_actual_corres_charges_inquiry', settlementInquiryUrl);
}

function setUpActualCorresChargesInquiryValidation(){
    var grid = $("#grid_list_settlement_actual_corres_charges_inquiry_branch");

    if (grid.length > 0) {
        grid = $("#grid_list_settlement_actual_corres_charges_inquiry_tsd");
    }

	if(grid && "BRM" != $("#userrole").val()){
        grid.jqGrid("hideCol","actionEts").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function onEtsClick(id){
    var grid = $("#grid_list_settlement_actual_corres_charges_inquiry_tsd")
	var grid = $("#grid_list_settlement_actual_corres_charges_inquiry").jqGrid("getRowData",id);
	var url = "";
	
	if(grid.documentType=="Settlement"){
		
		url = etsCorresChargesUrl;
		url += '?referenceType='+"eTS";
		url += '&documentType='+grid.documentType;
		url += '&serviceType='+"Actual%20Corres%20Charges";
		url += '&username='+$("#username").val();
		location.href = url;
	}

}


function onDataEntryClick(id){
	var grid = $("#grid_list_settlement_actual_corres_charges_inquiry_tsd").jqGrid("getRowData",id);
	var url = "";
	
	if(grid.documentType=="Settlement"){
		
		url = dataEntrySettlementActualCorresChargesUrl;
		url += '?referenceType='+"Data Entry";
		url += '&documentType='+grid.documentType;
		url += '&serviceType='+grid.serviceType;
		url += '&username='+$("#username").val();
		location.href = url;
	}
	
}

function createCorresEts(id) {
    var gotoUrl = corresChargesUrl;
    gotoUrl += "?referenceType=DATA_ENTRY"
    gotoUrl += "&documentType=Settlement"
    gotoUrl += "&documentNumber="+id;

    location.href = gotoUrl;
}


function initActualCorresChargesInquiry(){
	setUpActualCorresChargesInquiry();
	setUpActualCorresChargesInquiryValidation();
    $("#searchDocumentNumber").click(searchActualCorresCharges);
    $("#resetDocumentNumber").click(resetActualCorresCharges);
}

$(initActualCorresChargesInquiry);