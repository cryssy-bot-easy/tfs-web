
function setupDocumentTypeGrids() {

        var mdCollectionInquiryBranch = mdApplicationBranch;
        mdCollectionInquiryBranch += "?unitcode="+unitcode;
        setupJqGridPagerWithHidden('grid_list_md_collection_inquiry_branch', {width : 780, height: 425, loadui: "disable", scrollOffset : 0, rowNum: 20},
            [['documentNumber', 'Document Number'],
             ['clientName', 'Client Name'],
             ['amount', 'LC Amount'],
             ['action', 'Action'],
             ['dateCollected', 'Date Collected', 110, 'center', 'hidden'],
             ['amountCollected', 'Amount Collected', 120, 'right', 'hidden'],
             ['serviceType', 'Service Type', 'center', 'hidden'],
             ['documentClass', 'Document Class', 'center', 'hidden']], 'grid_pager_md_collection_inquiry_branch', mdCollectionInquiryBranch);

        var mdCollectionInquiryMain = mdApplicationMain;
        mdCollectionInquiryMain += "?unitcode="+unitcode
        setupJqGridPagerWithHidden('grid_list_md_collection_inquiry_main', {width : 780, height: 425, loadui: "disable", scrollOffset : 0, rowNum: 20},
            [['unitCode', 'Unit Code',],
          	 ['documentNumber', 'Document Number'],
             ['clientName', 'Client Name'],
             ['amount', 'LC Amount'],
             ['dateCollected', 'Date Collected'],
             ['amountCollected', 'Amount Collected'],
             ['serviceType', 'Service Type', 'center', 'hidden'],
             ['documentClass', 'Document Class', 'center', 'hidden']], 'grid_pager_md_collection_inquiry_main',  mdCollectionInquiryMain);

}

function createMdEts(id) {
    var gotoUrl = createMdCollectionUrl;

    gotoUrl  += "?tradeServiceId="+id;

    location.href = gotoUrl;
}

function onViewEts(){
    var url = '';

    url = etsMonitoringUrl;
    url += '?referenceType='+'eTS';
    url += '&documentType='+'MD';
    url += '&serviceType='+'Collection';
    location.href = url;

}

function setupMdCollectionGridsValidation(){
	if($("#grid_list_md_collection_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_md_collection_inquiry_branch").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

function initDocumentTypeGrid() {
    setupDocumentTypeGrids();
    setupMdCollectionGridsValidation();

}

$(initDocumentTypeGrid);
