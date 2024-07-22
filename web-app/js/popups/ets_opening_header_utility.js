// open cif lookup
function onCifLookup() {
    $("#cIFNumberSearch, #mainCIFNumberMainSearch, #cIFNameSearch, #mainCIFNameMainSearch").val("");

    $("#grid_list_cif").jqGrid("clearGridData", true);
    $("#grid_list_main_cif").jqGrid("clearGridData", true);

    $("#cIFNumberSearch, #cIFNameSearch").removeAttr("readonly");
    $("#mainCIFNumberMainSearch, #mainCIFNameMainSearch").removeAttr("readonly");
	mLoadPopup($("#popup_cif"), $("#popupBackground_cif"));
	mCenterPopup($("#popup_cif"), $("#popupBackground_cif"));
}

// closes cif lookup
function onCloseCifLookup() {
	mDisablePopup($("#popup_cif"), $("#popupBackground_cif"));
}

function initializeEtsOpeningHeader() {
	$("#popup_btn_cif").click(onCifLookup);
	$("#popupClose_cif").click(onCloseCifLookup);
}

$(initializeEtsOpeningHeader);