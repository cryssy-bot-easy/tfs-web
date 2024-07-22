function setUpCdtClientInquiryGrid(){
	
	var client_file_inquiry_main_grid_url = searchCdtClientUrl;

    setupJqGridWidthPagerHidden('grid_list_client_file_inquiry', {width: 780, height: 425, loadui: "disable", scrollOffset:0, rowNum: 20},
			[['aabRefCode', 'AAB Ref Code', 100, 'left'],
			 ['customsClientNumber', 'Customs Client Number', 120, 'left'],
			 ['importerTIN', 'Importer TIN', 100, 'left'],
			 ['importerName', 'Registration (Importer) Name', 170, 'left'],
			 ['regNameDate', 'Registration Name &amp; Date', 170, 'left'],
			 ['action', 'Action', 60, 'center']],'grid_page_client_file_inquiry', client_file_inquiry_main_grid_url);


}

//function setUpCdtClientInquiryGridValidation(){
//	if($("#grid_list_client_file_inquiry") && "TSDM" != $("#userrole").val()){
//		$("#grid_list_client_file_inquiry").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
//	}
//}

//link to encode client details
function onEncodeClientDetails(){
	var url = ""
	
	url = encodeClientDetailsUrl;
	url += '?serviceType='+"Customs Duties and Taxes";
	url += '&documentType='+"Collection";
	url += '&referenceType='+"Encode Client Details";
//	url += '&username='+$("#username").val();
	location.href = url;
	
	
}


function viewCdtClientInquiryGrid(){
	setUpCdtClientInquiryGrid();
//	setUpCdtClientInquiryGridValidation();
//	var mainGrids = $("#grid_list_client_file_inquiry");
//
//	mainGrids.addRowData("1",
//				{aabRefCode:'000-000-000',
//				 customsClientNumber:'1234567',
//				 importerTIN:'3452617980',
//				 importerName:'Juliet Periabras',
//				 regNameDate:'Juliet Periabras 6/9/2012',
//				 action:'<a href=\"javascript:void(0)\" style=\"color: blue\" onClick=\"onEncodeClientDetails()\">View</a>',
//				 createEts:'<a href=\"javascript:void(0)\" style=\"color: blue\">create eTS</a>'});
}				

$(viewCdtClientInquiryGrid);