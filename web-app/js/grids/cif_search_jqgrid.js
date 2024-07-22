/**
 * PROLOGUE:
 * (revision)
 * SCR/ER Number:
 * SCR/ER Description: (Redmine #4134) Exporter CB Code field should be disabled and extracted from sibs LNSCOD base on CIF Number.
 * [Revised by:] Ludovico Anton Apilado
 * [Date revised:] 5/25/2017
 * Program [Revision] Details: on setupCIFSearchGrids() function, added 'cbCode' in setupJqGridPagerWithHiddenTest();
 * Date deployment: 6/16/2017
 * Member Type: JS
 * Project: WEB
 * Project Name: cif_search_jqgrid.js
 */

function setupCIFSearchGrids() {
//	var cifUrl = '';
//	var mainCifUrl = '';

    setupJqGridPagerWithHiddenTest('grid_list_cif', {width : 500, height: 100, scrollOffset : 0, onSelectRow: selectCif},
					[['cifNumber', 'CIF Number'],
					 ['cifName', 'CIF Name'],
                     ['branchUnitCode', 'Branch Unit Code','center'],
                     ['fullAddress', 'Full Address','center'],
                     ['fullName', 'Full Name','center','hidden'],
                     ['officerCode', 'Officer Code','center','hidden'],
                     ['officerName', 'Officer Name','center','hidden'],
                     ['allocationUnitCode', 'Allocation Unit Code','center','hidden'],
                     ['firstName', 'First Name','center','hidden'],
                     ['middleName', 'Middle Name','center','hidden'],
                     ['lastName', 'Last Name','center','hidden'],
                     ['tinNumber', 'TIN Number','center','hidden'],
                     ['addressLine1', 'Address Line1','center','hidden'],
                     ['addressLine2', 'Address Line2','center','hidden'],
                     ['addressLine3', 'Address Line3','center','hidden'],
                     ['exceptionCode', 'Exception Code','center','hidden'],
                     ['cbCode', 'Exporter CB Code','center','hidden']
                    ], 'grid_pager_cif');

    setupJqGridPagerWithHiddenTest('grid_list_main_cif', {width : 500, height: 100, scrollOffset : 0,  onSelectRow: selectMainCif},
					[[ 'mainCifNumber', 'Main CIF Number'],
					 ['mainCifName', 'Main CIF Name'],
                     ['fullAddress', 'Full Address','center'],
                     ['fullName', 'Full Name','center','hidden'],
                     ['officerCode', 'Officer Code','center','hidden'],
                     ['officerName', 'Officer Name','center','hidden'],
                     ['firstName', 'First Name','center','hidden'],
                     ['middleName', 'Middle Name','center','hidden'],
                     ['lastName', 'Last Name','center','hidden'],
                     ['tinNumber', 'TIN Number','center','hidden'],
                     ['address1', 'Address 1','center','hidden'],
                     ['address2', 'Address 2','center','hidden']], 'grid_pager_main_cif');

}

function selectCif() {
    var id = $("#grid_list_cif").jqGrid("getGridParam", "selrow");

    var mainId = $("#grid_list_main_cif").jqGrid("getGridParam", "selrow");

    if(mainId == null) {
        var searchUrl = mainCifByCifSearchUrl;

//        searchUrl += "?cifNumber="+id;
        searchUrl += "?cifNumber="+$("#grid_list_cif").jqGrid("getRowData", id).cifNumber;

        // main cif grid
        $('#grid_list_main_cif').jqGrid('setGridParam', {url: searchUrl, page: 1, datatype: "json"}).trigger("reloadGrid");
    }
}

function selectMainCif() {
    var mainId = $("#grid_list_main_cif").jqGrid("getGridParam", "selrow");

    var id = $("#grid_list_cif").jqGrid("getGridParam", "selrow");

    if(id == null) {
        var searchUrl = cifByMainCifSearchUrl;

//        searchUrl += "?cifNumber="+mainId;
        searchUrl += "?cifNumber="+$("#grid_list_main_cif").jqGrid("getRowData", mainId).mainCifNumber;

        // main cif grid
        $('#grid_list_cif').jqGrid('setGridParam', {url: searchUrl, page: 1, datatype: "json"}).trigger("reloadGrid");
    }
}

function onCifSearchClick() {
    var searchUrl = cifSearchUrl;

    var cifNumber = $("#cIFNumberSearch").val();
    var cifName = $("#cIFNameSearch").val();

    var mainCifNumber = $("#mainCIFNumberMainSearch").val();
    var mainCifName = $("#mainCIFNameMainSearch").val();
    
    if((cifNumber != '' && cifNumber.length < 3) || (cifName != '' && cifName.length < 3) || (mainCifNumber != '' && mainCifNumber.length < 3) || (mainCifName != '' && mainCifName.length < 3)) {
    	$("#alertMessage").text("Minimum of 3 characters for wild card search.");
    	triggerAlert();
    } else {
	    if(cifNumber != "" || cifName != "") {
	        searchUrl += "?cifName="+cifName;
	        searchUrl += "&cifNumber="+cifNumber;
	
	        $('#grid_list_cif').jqGrid('setGridParam', {url: searchUrl, page: 1, gridComplete: alertCif, datatype: "json"}).trigger("reloadGrid");
	    } else if(mainCifNumber != "" || mainCifName != "") {
	        searchUrl += "?cifName="+mainCifName;
	        searchUrl += "&cifNumber="+mainCifNumber;
	
	        $('#grid_list_main_cif').jqGrid('setGridParam', {url: searchUrl, page: 1, gridComplete: alertMainCif, datatype: "json"}).trigger("reloadGrid");
	    }
    }
}

function alertCif(){
	var grid = $("#grid_list_cif");
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function alertMainCif(){
	var grid = $("#grid_list_main_cif");
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function onCifSearchSelectClick() {
	var postUrl = cifResetUrl
    $.post(postUrl, {}, function(data0){
    	if(data0.success){
		    var id =  $("#grid_list_cif").jqGrid("getGridParam", "selrow");
		    var mainId = $("#grid_list_main_cif").jqGrid("getGridParam", "selrow");
		    var data = $("#grid_list_cif").jqGrid("getRowData", id);
		    var mainData = $("#grid_list_main_cif").jqGrid("getRowData", mainId);
		       
		//    if("" == data.branchUnitCode ||
		//    		(documentClass == 'LC' && documentSubType1 != 'CASH' && "" == mainData.branchUnitCode)){
		    if("" == data.branchUnitCode.trim()){
		    	$("#alertMessage").text("This entry has no branch unit code. Please select another entry");
		    	triggerAlert();
		    	return;
		    } else if ("000" == data.branchUnitCode){
		    	triggerAlertMessage("Cannot create transaction if branch unit code is 000.")
		    	return;
		    }
		    
		    if(id == null || (documentClass == 'LC' && documentSubType1 != 'CASH' && mainId == null)) {
		        $("#alertMessage").text("Please select an entry from grid.");
		        triggerAlert();
		    } else {
		        $("#cifNumber").val(data.cifNumber);
		        $("#cifName").val(data.cifName);
		
		        if (mainData.officerName) {
		            $("#accountOfficer").val(mainData.officerName);
		        } else {
		            $("#accountOfficer").val(data.officerName);
		        }
		
		
		
		        if ($("#cifNumberParam").length > 0) {
		            $("#cifNumberParam").val(data.cifNumber);
		        }
		        if ($("#cifNameParam").length > 0) {
		            $("#cifNameParam").val(data.cifName);
		        }
		        if ($("#accountOfficerParam").length > 0) {
		            $("#accountOfficerParam").val(data.officerName);
		        }
		
		        if (mainId != null) {
		            $("#mainCifNumber").val(mainData.mainCifNumber);
		            $("#mainCifName").val(mainData.mainCifName);
		        }
		        $("#firstName").val(data.firstName);
		        $("#middleName").val(data.middleName);
		        $("#lastName").val(data.lastName);

		        if(data.tinNumber !== null && data.tinNumber !== undefined && data.tinNumber !== '')
		        	$("#tinNumber").val(data.tinNumber.toString().trim());

		        $("#allocationUnitCode").val(data.allocationUnitCode);
		        $("#allocationUnitCodeParam").val(data.allocationUnitCode.trim().toString());
		        if ($("#ccbdBranchUnitCodeParam").length > 0) {
//		        	$("#ccbdBranchUnitCodeParam").val(pad (data.branchUnitCode.trim(),"0",3));
		            $("#ccbdBranchUnitCodeParam").val(data.branchUnitCode.trim().toString());
		        }
//		        $("#ccbdBranchUnitCode").val(pad (data.branchUnitCode.trim(),"0",3));
		        $("#ccbdBranchUnitCode").val(data.branchUnitCode.trim().toString());
		        $("#officerCode").val(data.officerCode);
		        $("#exceptionCode").val(data.exceptionCode);
		
		        if ($("#facilityId").length > 0) {
		            // clears facility Id on change of CIF
		            $("#facilityId").val("");
		        }
		
		        $("#longNameDisplay").text(data.fullName);
		        $("#address1Display").text(data.addressLine1);
		        $("#address2Display").text(data.addressLine2);
		
		        $("#longName").val(data.fullName);
		        $("#address1").val(data.addressLine1);
		        $("#address2").val(data.addressLine2);
		
		        $("#cifNumber").change();
		        
		        if (documentClass == 'DA'|| documentClass == 'DP'|| documentClass == 'OA'|| documentClass == 'DR'){
		        	$("#importerCifNumber").val($("#cifNumber").val());
		//	        if(documentType == 'DOMESTIC'){
		//	        	$("#importerName").val($("#cifName").val());
		//	        } else if (documentType == 'FOREIGN'){
			        	$("#importerName").val(data.fullName);
		//	        }
			        $("#importerAddress").val(data.addressLine1+"\n"+data.addressLine2+"\n"+data.addressLine3);
			        
			        var postUrl = importerCbCodeUrl;
			        $.post(postUrl, {cifNumber: data.cifNumber}, function(data2){
			        	if(data2.CBCODE){
			        		$("#importerCbCode").select2('data', {id: data2.CBCODE});
			        	}
			        });
			        
			      //trigger change event to activate handler on fx dr settlement data entry basic details
		            $("#importerCifNumber").change();
		
		            // executes if no main cif number is selected
		            if(!$("#mainCifNumber").val()){
			            $("#mainCifNumber").val($("#cifNumber").val());
			            $("#mainCifName").val($("#cifName").val());
		            }
		        }
		
		        if (documentClass == "EXPORT_ADVISING") {
		            var cifName = mainData.fullName;
		
		            if (cifName == undefined) {
		                cifName = data.fullName;
		            }
		
		            $("#exporterName").val(cifName);
		            $("#exporterAddress").val(data.addressLine1+"\n"+data.addressLine2);
		
		            if ($("#exporterCbCode").length > 0 && $("#exporterCbCode").val() != "") {
		                $("#exporterCbCode").select2('data',null);
		            }
		        }
		        
		        if (documentClass in {BC:1, BP:1}){
		        	if (documentType == "FOREIGN" && $("#exporterCbCode").length > 0) {
			        	var postUrl = exporterCbCodeUrl;
				        $.post(postUrl, {cifNumber: data.cifNumber}, function(data2){
				        	if(data2.CBCODE){
				        		$("#exporterCbCode").select2('data', {id: data2.CBCODE});
			        		} else {
		    	                $("#exporterCbCode").select2('data', null);
				        	}
				        });
			        }
		        	$("#sellerName").val(data.fullName);
		        	$("#sellerAddress").val(data.addressLine1+"\n"+data.addressLine2+"\n"+data.addressLine3);
		        }
		
		        // facility grid
		        var searchFacilityUrl = facilitySearchUrl;
		        searchFacilityUrl += "?cifNumber="+data.cifNumber;
		        searchFacilityUrl += "&mainCifNumber="+data.mainCifNumber;
		
		        $("#grid_list_facility_type").jqGrid("setGridParam", {url: searchFacilityUrl, page: 1}).trigger("reloadGrid");
		
		        mDisablePopup($("#popup_cif"), $("#popupBackground_cif"));
		
		        $.get(trLineFromCifChangeUrl, {cifNumber: data.cifNumber, mainCifNumber: data.mainCifNumber}, function(data) {
		            $("#trLine").val(data.trLines);
		        })
		    }
    	}
    });
}

function onPrepareCifSearch() {
    var cifNumber = $("#cIFNumberSearch").val();
    var cifName = $("#cIFNameSearch").val();

    if(cifNumber != "" || cifName != "") {
        $("#mainCIFNumberMainSearch, #mainCIFNameMainSearch").attr("readonly", "readonly");
    } else {
        $("#mainCIFNumberMainSearch, #mainCIFNameMainSearch").removeAttr("readonly");
    }
}

function onPrepareMainCifSearch() {
    var mainCifNumber = $("#mainCIFNumberMainSearch").val();
    var mainCifName = $("#mainCIFNameMainSearch").val();

    if(mainCifNumber != "" || mainCifName != "") {
        $("#cIFNumberSearch, #cIFNameSearch").attr("readonly", "readonly");
    } else {
        $("#cIFNumberSearch, #cIFNameSearch").removeAttr("readonly");
    }
}

function onCifResetClick() {
	var postUrl = cifResetUrl
	$.post(postUrl, {}, function(data){
		if(data.success){
		    $("#cIFNumberSearch, #cIFNameSearch, #mainCIFNumberMainSearch, #mainCIFNameMainSearch").val("");
		    onPrepareCifSearch();
		    onPrepareMainCifSearch();
		
		    $("#grid_list_cif").jqGrid("clearGridData", true);
		    $("#grid_list_main_cif").jqGrid("clearGridData", true);
		    //alert(1)
		    if ($("#grid_list_main_cif_popup").length > 0) {
		        $("#grid_list_main_cif_popup").jqGrid("clearGridData", true);
		    }
		}
	});
}

function initCIFSearch() {
	setupCIFSearchGrids();

    $("#cifSearchBtn").click(onCifSearchClick);
    $("#cifResetBtn").click(onCifResetClick);

    $("#cifSearchSelect").click(onCifSearchSelectClick);

    $("#cIFNumberSearch, #cIFNameSearch").change(onPrepareCifSearch);

    $("#mainCIFNumberMainSearch, #mainCIFNameMainSearch").change(onPrepareMainCifSearch);
    
    $("#cIFNumberSearch, #cIFNameSearch, #mainCIFNumberMainSearch, #mainCIFNameMainSearch").keydown(function(e){
    	if(e.keyCode == 13){
    		onCifSearchClick();
    	}
    });
}

$(initCIFSearch);