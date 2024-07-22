function setupExporterCodeGrids(){

	var exporter_cb_code_url = '';
	
	setupJqGridPager('grid_list_exporter_cb_code_type', {width: 500, height: 150, loadui: "disable", scrollOffset:0},
			[['exporterCbCode', 'Exporter CB Code'],
			['exporterName', 'Exporter Name']],'grid_pager_exporter_cb_code_type', exporter_cb_code_url);
}

function initExporterCodeGrid(){
	setupExporterCodeGrids();
}

$(initExporterCodeGrid);

