/**
 * PROLOGUE:
 * (revision)
 * SCR/ER Number:
 * SCR/ER Description: (Redmine #4134) Exporter CB Code field should be disabled and extracted from sibs LNSCOD base on CIF Number.
 * [Revised by:] Ludovico Anton Apilado
 * [Date revised:] 5/25/2017
 * Program [Revision] Details: on setupCIFNormalSearchGrids() function, added 'cbCode' in setupJqGridPagerWithHidden();
 * Date deployment: 6/16/2017
 * Member Type: JS
 * Project: WEB
 * Project Name: cif_search_normal_jqgrid.js
 */

function setupCIFNormalSearchGrids() {
	var cif_Url = '';
	
	setupJqGridPagerWithHidden('grid_list_cif_popup', {width : 500, scrollOffset : 0},
					[['cifNumber', 'CIF Number'],
					 ['cifName', 'CIF Name'],
                     ['branchUnitCode', 'Branch Unit Code','center','hidden'],
                     ['address', 'Address','center','hidden'],
                     ['fullName', 'Full Name','center','hidden'],
                     ['officerCode', 'Officer Code','center','hidden'],
                     ['officerName', 'Officer Name','center','hidden'],
                     ['allocationUnitCode', 'Allocation Unit Code','center','hidden'],
                     ['firstName', 'First Name','center','hidden'],
                     ['middleName', 'Middle Name','center','hidden'],
                     ['lastName', 'Last Name','center','hidden'],
                     ['tinNumber', 'TIN Number','center','hidden'],
                     ['address1', 'Address 1','center','hidden'],
                     ['address2', 'Address 2','center','hidden'],
                     ['exceptionCode', 'Exception Code','center','hidden'],
                     ['cbCode', 'Exporter CB Code','center','hidden']], 'grid_pager_cif_popup', cif_Url);


}

function onCifNormalSearchBtnClick() {
    var normalSearchCifUrl = cifNormalSearchUrl;
    normalSearchCifUrl += "?cifName="+$("#cIFNameSearchNormal").val();
    normalSearchCifUrl += "&cifNumber="+$("#cIFNumberSearchNormal").val();
    normalSearchCifUrl += "&normal=true";
    $("#grid_list_cif_popup").jqGrid("setGridParam", {url: normalSearchCifUrl, page: 1}).trigger("reloadGrid");
}

function initCIFNormalSearch() {
	setupCIFNormalSearchGrids();

    $("#cifNormalSearchBtn").click(onCifNormalSearchBtnClick);
}

$(initCIFNormalSearch);