function setupUploadClientFile(){
	var uploadClientFileUrl = searchCdtPaymentUrl;
	
	
	setupJqGridPager('cdt_list_upload_client_file', {width: 780, loadui: "disable", scrollOffset:0},
					[['aabRefCode', 'AAB Ref Code'],
					['customNumber', 'Customs Client Number'],
					['importerTin', 'Importer TIN'],
					['registrationName', 'Registration Importer Name'],
					['registrationDate', 'Registration Date & Time'],
					['uploadAction', 'Action']], 'cdt_pager_upload_client_file', uploadClientFileUrl);
}

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

function initUploadClientFile(){
	setupUploadClientFile();
	
//	var gridList = $('#cdt_list_upload_client_file');
//
//	gridList.addRowData("1", {uploadAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onEncodeClientDetails()\">encode</a>"});
//	gridList.addRowData("2", {uploadAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onEncodeClientDetails()\">encode</a>"});
//	gridList.addRowData("3", {uploadAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onEncodeClientDetails()\">encode</a>"});
//	gridList.addRowData("4", {uploadAction:"<a href='javascript:void(0)' style=\"color:blue\" onClick=\"onEncodeClientDetails()\">encode</a>"});
//	gridList.addRowData("5", {uploadAction:"<a href='javascript:void(0)' style=\"color:blue\">encode</a>"});
}

$(initUploadClientFile);

