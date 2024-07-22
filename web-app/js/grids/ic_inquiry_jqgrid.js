/**
 * PROLOGUE:
	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date created:] 08/16/2017
	Program [Revision] Details: IC Inquiry module
	Member Type: JS
	Project: tfs-web
	Project Name: ic_inquiry_jqgrid.js
 */

function setupIcInquiryGrid() {
        var icInquiryTsdUrl = tsdIcInquiryUrl;
        var unitcode = $('input[name=unitcode]').val();
        icInquiryTsdUrl += "?unitcode="+unitcode;

        setupJqGridPagerWithHidden('grid_list_ic_inquiry_main', {width: 780, height: 295, loadui: "disable", scrollOffset:0, rowNum: 20},
        		[['unitCode', 'Unit Code', 'center'],
             	['documentNumber', 'Document Number', 150],
                ['cifName', 'CIF Name', 300],
                ['currency', 'Currency'],
                ['lcAmountFrom', 'Original LC Amount'],
                ['icNumber', 'IC Number'],
                ['icAmount', 'IC Amount'],
                ['icDate', 'IC Date'],
                ['action','Cancel','center'],
                ['serviceType', 'Service Type', 'center', 'hidden'],
                ['documentType', 'Document Type', 'center', 'hidden'],
                ['documentClass', 'Document Class', 'center', 'hidden'],
                ['documentSubType1', 'SubType1', 'center', 'hidden'],
                ['documentSubType2', 'SubType2', 'center', 'hidden'],
             	['mainCifNumber', 'Main CIF Number', 'center', 'hidden']], 'grid_pager_ic_inquiry_main', icInquiryTsdUrl);
}

function setupIcInquiryGridValidation(){
	if($("#grid_list_ic_inquiry_main") && "TSDM" != $("#userrole").val()){
		$("#grid_list_ic_inquiry_main").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function initIcInquiryGrid() {
    setupIcInquiryGrid();
    setupIcInquiryGridValidation();
}

$(initIcInquiryGrid);
