$(initializeOtherExportChargesInquiryGrids);

function initializeOtherExportChargesInquiryGrids(){
	setupOtherExportChargesInquiryGrid();

}

function setupOtherExportChargesInquiryGrid(){
	var otherExportChargesInquiryGridUrl
		setupJqGridWidthPagerHidden('grid_list_other_export_charges_inquiry', {width: 780, height: 340, loadui: "disable", scrollOffset:0, rowNum: 20},
			[['cifName', 'CIF Name'],
			['transaction', 'Transaction'], 
			['negotiationNumber', 'Nego Number'],
			['negotiationDate', 'Nego Date'],
			['settlementDate', 'Settlement Date'],
			['negotiationAmount','Nego Amount'],
			['lcDraftAmount', 'LC/Draft Amount'],
			['importerName',' Importer Name'],
			['exporterName', 'Exporter Name'],
			['action', 'Action']], 'grid_pager_other_export_charges_inquiry', otherExportChargesInquiryGridUrl);
}