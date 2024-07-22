function setupCIFMainSearchGrids() {
	var main_Url = '';
	
	setupJqGridPager('grid_list_main_cif_popup', {width : 500, scrollOffset : 0},
					[ [ 'mainCIFNumber', 'Main CIF Numbers' ],
					[ 'mainCIFName', 'Main CIF Name' ] ], 'grid_pager_main_cif_popup', main_Url);

}

function onMainCifSearch() {
    var searchMainCifByCif = searchMainCifByCifUrl;
    var cifNumber = $("#cifNumber").val();

    if ($("#cifNumberTo").val()) {
        cifNumber = $("#cifNumberTo").val();
    } else if ($("#cifNumberFrom").val()) {
    	cifNumber = $("#cifNumberFrom").val();
    }

    searchMainCifByCif += "?cifNumber="+cifNumber;
    $("#grid_list_main_cif_popup").jqGrid("setGridParam", {url: searchMainCifByCif, page: 1}).trigger("reloadGrid");
}

function onMainCifSelect() {
    var id = $("#grid_list_main_cif_popup").jqGrid("getGridParam", "selrow");

    if(id == null) {
        $("#alertMessage").text("Please select a from grid.");

        triggerAlert();
    } else {
        var data = $("#grid_list_main_cif_popup").jqGrid("getRowData", id);
        $(($("#mainCifNumberTo").length > 0) ? "#mainCifNumberTo" : "#mainCifNumber").val(data.mainCIFNumber);
        $(($("#mainCifNameTo").length > 0) ? "#mainCifNameTo" : "#mainCifName").val(data.mainCIFName);
        //mDisablePopup("popup_cif_main", "popupBackground_cif_main");
        // clears facilty id if new main cif is selected
        if ($("#facilityIdTo").length > 0) {
            $("#facilityIdTo").val("");
        }
        closeCIFMain();
    }
}

function initCIFMainSearch() {
	setupCIFMainSearchGrids();
    $("#mainCifSearchBtn").click(onMainCifSearch);

    $("#mainCifSelectBtn").click(onMainCifSelect);
}

$(initCIFMainSearch);