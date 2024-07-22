function setupRelatedLCsGrids() {
	var relatedLCsGridUrl = "";

	setupJqGridPagerWithHidden('grid_list_related_lcs', {width : 500, height: 100, loadui: "disable", scrollOffset : 0},
					[[ 'documentType', 'Document Type' ],
					[ 'importerName', 'Importer Name' ],
					[ 'exporterName', 'Exporter Name' ],
					[ 'descriptionOfGoods', 'Description of Goods'],
                    [ 'lastTransaction', '', 'center', 'hidden']],
					'grid_pager_related_lcs', relatedLCsGridUrl);
}

function initRelatedLCsGrid() {
	setupRelatedLCsGrids();
}

$(initRelatedLCsGrid);
