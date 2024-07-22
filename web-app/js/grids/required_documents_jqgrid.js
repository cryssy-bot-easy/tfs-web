function initializeRequiredDocumentsImports() {
	var jqgrid_src = document.createElement('script');
	jqgrid_src.src = 'js/jqgrid-utils.js';
}

function setupRequiredDocumentsTypeGrids() {
	var requiredDocumentsUrl = '';
	var additionalRequiredDocumentsUrl = '';

	setupJqGridPager('grid_list_required_documents', {
		width : 780, height: "auto", loadui: "disable", 
		multiselect: true, scrollOffset : 0
	}, [ [ 'clientsDocuments', 'Client\'s Documents ' ],
			[ 'originalCopy', 'Original Copy' ],
			[ 'duplicateCopy', 'Duplicate Copy' ], [ 'edit', 'Edit' ] ],
			'grid_pager_required_documents', requiredDocumentsUrl);
	
	setupJqGridPager('grid_list_additional_required_documents', {
		width : 780, height: "auto", loadui: "disable", 
		scrollOffset : 0
	}, [ [ 'description', 'Description ' ],
			[ 'original', 'Original' ],
			[ 'duplicate', 'Duplicate' ], [ 'edit2', 'Edit' ],
			[ 'delete1', 'Delete' ] ],
			'grid_pager_additional_required_documents', additionalRequiredDocumentsUrl);

	// STATIC DATA
//	var requiredDocumentsGrid = $("#grid_list_required_documents");
//	var additionalRequiredDocumentsGrid = $("#grid_list_additional_required_documents");
//
//	requiredDocumentsGrid.addRowData("1", {clientsDocuments : "Commercial Invoice", originalCopy : "1", duplicateCopy : "1", edit : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	requiredDocumentsGrid.addRowData("2", {clientsDocuments : "Packing List", originalCopy : "&nbsp;", duplicateCopy : "&nbsp;", edit : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	requiredDocumentsGrid.addRowData("3", {clientsDocuments : "Bill of Lading", originalCopy : "&nbsp;", duplicateCopy : "&nbsp;", edit : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	requiredDocumentsGrid.addRowData("4", {clientsDocuments : "Airway Bill", originalCopy : "&nbsp;", duplicateCopy : "&nbsp;", edit : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	requiredDocumentsGrid.addRowData("5", {clientsDocuments : "Certificate of Insurance", originalCopy : "&nbsp;", duplicateCopy : "&nbsp;", edit : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	requiredDocumentsGrid.addRowData("6", {clientsDocuments : "Certificate of Analysis", originalCopy : "&nbsp;", duplicateCopy : "&nbsp;", edit : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	requiredDocumentsGrid.addRowData("7", {clientsDocuments : "Certificate of Origin", originalCopy : "&nbsp;", duplicateCopy : "&nbsp;", edit : "<a href='javascript:void(0)'>&nbsp;</a>"});
//
//	additionalRequiredDocumentsGrid.addRowData("1", {description : "Additional", original : "&nbsp;", duplicate : "&nbsp;", edit2 : "<a href='javascript:void(0)'>&nbsp;</a>", delete1 : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	additionalRequiredDocumentsGrid.addRowData("2", {description : "Additional", original : "&nbsp;", duplicate : "&nbsp;", edit2 : "<a href='javascript:void(0)'>&nbsp;</a>", delete1 : "<a href='javascript:void(0)'>&nbsp;</a>"});
//	additionalRequiredDocumentsGrid.addRowData("3", {description : "&nbsp;", original : "&nbsp;", duplicate : "&nbsp;", edit2 : "<a href='javascript:void(0)'>&nbsp;</a>", delete1 : "<a href='javascript:void(0)'>&nbsp;</a>"});
}

function initRequiredDocumentsTypeGrid() {
	initializeRequiredDocumentsImports();
	setupRequiredDocumentsTypeGrids();
}

$(initRequiredDocumentsTypeGrid);
