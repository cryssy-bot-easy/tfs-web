function setupEtsTabs() {
    var etsNumber = $("#etsNumber").val();
    var tradeServiceId = $("#tradeServiceId").val();

    // count number of tabs
    var numOftabs = $("#tabs li").length;
    var tabsToDisable = new Array();

    // lists all tabs to disable
    for(var ctr = 1; ctr < numOftabs; ctr++) {
        tabsToDisable.push(ctr)
    }

    if(referenceType == "ETS") {
        // enables other tabs if ets number exist
        if(!etsNumber){
            $("#tab_container").tabs({disabled: tabsToDisable})
        }
        disableElementsIfUserIsBro();
    } else if(referenceType == "DATA_ENTRY") {
        if(!tradeServiceId){
            // todo: temp fix DO NOT COMMIT THIS
            $("#tab_container").tabs({disabled: tabsToDisable})
        }
    }
}



function disableElementsIfUserIsBro(){
	var lRole=typeof userRole!=='undefined' ? userRole:"";
	
	//remove some elements if user is BRO
	if(lRole=="BRO"){
		if(documentClass != 'DA' && documentClass != 'DP' && documentClass != 'OA' && documentClass != 'DR'){
			$("a#popup_btn_cif").remove();
		}
		$("a#facility_lookup").remove();
		$("input#amount").attr("readonly","readonly");
	}
}

function initEtsIndexUtility(){
	setupEtsTabs();
	disableElementsIfUserIsBro();
}

$(initEtsIndexUtility);