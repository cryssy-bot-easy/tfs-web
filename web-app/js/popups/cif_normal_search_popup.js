function openCIFNormal() {
    $("#cIFNumberSearchNormal, #cIFNameSearchNormal").val("");
    $("#grid_list_cif_popup").jqGrid("clearGridData", true);

    mCenterPopup($("#popup_cif_normal"), $("#popupBackground_cif_normal"));
    mLoadPopup($("#popup_cif_normal"), $("#popupBackground_cif_normal"));
}

function closeCIFNormal() {
//    disablePopup("popup_cif_normal", "popupBackground_cif_normal");
    mDisablePopup($("#popup_cif_normal"), $("#popupBackground_cif_normal"));
}

function onCifSearchNormalSelectClick() {

    var id = $("#grid_list_cif_popup").jqGrid("getGridParam", "selrow");

    if(id != null) {
        var data = $("#grid_list_cif_popup").jqGrid("getRowData", id);

//        if ($("#cifName").length > 0) { // Removed, as cifName must not be changed (especially in lc adjustment) until approved.

        if($("#importerCifNumber").length > 0) {
            $("#importerCifNumber").val(data.cifNumber);
            $("#importerName").val(function(){
//            	if (documentClass == 'DA'|| documentClass == 'DP'|| documentClass == 'OA'|| documentClass == 'DR'){
            		return data.fullName;
//            	} else {
//            		return data.cifName;
//            	}
            });
            $("#importerAddress").val(data.address);
            
            if ((documentClass == 'DA'|| documentClass == 'DP'|| documentClass == 'OA'|| documentClass == 'DR') && $("#importerCbCode").length > 0) {
            	$("#importerCbCode").select2('data',{id: ""});
            }
            
            //trigger change event to activate handler on fx dr settlement data entry basic details
            $("#importerCifNumber").change();
        }

        if($("#buyerCifNumber").length > 0) {
        	$("#buyerCifNumber").val(data.cifNumber);
        }

        if($("#applicantCifNumber").length > 0) {
            $("#applicantCifNumber").val(data.cifNumber);
            $("#applicantName").val(data.fullName);
        }

        if($("#cifNumberTo").length > 0){
            $("#cifNumberTo").val(data.cifNumber);
            $("#cifNameTo").val(data.cifName);
            
            if($("#mainCifNumberTo").length > 0){
            	$("#mainCifNumberTo").toggleClass("required", true);
            }
            
            if($("#facilityIdTo").length > 0){
            	$("#facilityIdTo").toggleClass("required", true);
            }

            if($("#accountOfficerTo").length > 0){
                $("#accountOfficerTo").val(data.officerName);
            }

            if($("#ccbdBranchUnitCodeTo").length > 0){
                $("#ccbdBranchUnitCodeTo").val(data.branchUnitCode);
                $("#allocationUnitCodeTo").val(data.allocationUnitCode);
                $("#officerCodeTo").val(data.officerCode);
            }
            
            if($("#longNameTo").length > 0){
            	$("#longNameTo").val(data.fullName);
            }
            
            if($("#address1To").length > 0){
            	$("#address1To").val(data.address1);
            }
            
            if($("#address2To").length > 0){
            	$("#address2To").val(data.address2);
            }
        }

        if($("#cifNameInquiry").length > 0){
        	$("#cifNameInquiry").val(data.fullName);
        }
        
        //alert(data.address);
        if ($("#applicantAddress").length > 0) {
            $("#applicantAddress").val(data.address);
        }

        // clears main cif number to if new cif is selected
        if ($("#mainCifNumberTo").length > 0) {
            $("#mainCifNumberTo").val("");
        }

        // clears facility id to if new cif is selected
        if ($("#facilityIdTo").length > 0) {
            $("#facilityIdTo").val("");
        }
        
        if ($("#cifNameSearch").length > 0) {
        	$("#cifNameSearch").val(data.fullName);
        }
        
        if($("#importerCifNumberTo").length > 0) {
        	$("#importerCifNumberTo").val(data.cifNumber);
        }
        
//        disablePopup("popup_cif_normal", "popupBackground_cif_normal");
        mDisablePopup($("#popup_cif_normal"), $("#popupBackground_cif_normal"));
    } else {
        $("#alertMessage").text("Please select a from grid.");

        triggerAlert();
    }
}

$(document).ready(function() {
//	var popup_div_cif_normal = $('#popup_cif_normal');
//	var popup_bg_cif_normal = $('#popupBackground_cif_normal');

	$('.popup_btn_cif_normal').click(openCIFNormal);
	$('#popupClose_cif_normal').click(closeCIFNormal);

    $("#cifSearchNormalSelect").click(onCifSearchNormalSelectClick);
    
    $("#cIFNumberSearchNormal, #cIFNameSearchNormal").keydown(function(e){
    	if(e.keyCode == 13){
    		onCifNormalSearchBtnClick();
    	}
    });
});