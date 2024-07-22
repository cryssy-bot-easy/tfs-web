function setupAddConditions3Grids(){
    var add_conditions3_url = instructionsToBankGridUrl;

    setupJqGridWidthNoPagerHiddenNotSortable('add_conditions3_list', {width: 780, multiselect: true, scrollOffset:0, height: "auto", loadui: "disable", loadComplete: setSelectedInstructions},
	    [['instruction', 'Instructions to the Paying / Accepting / Negotiating Bank'],
        ['edit', 'Edit', 10, 'center']], add_conditions3_url);
}

function setSelectedInstructions() {
    var postUrl = null;

//    if (serviceType != 'Amendment') {
    postUrl = savedInstructionsToBankUrl;
//    } else {
//        postUrl = savedLcInstructionsToBankUrl;
//    }

    $.post(postUrl, {}, function(data) {
        for(var i in data.instructionsToBankCode) {
       		$("#add_conditions3_list").jqGrid("setSelection", data.instructionsToBankCode[i]);
        }
    });
}

function closeEditInstructionToBankPopup() {
    disablePopup("popup_instructionsToBank", "add_instructionsToBank_bg");
    $("#instructionToBank").val("");
}

function onEditInstructionsToBank(id) {
	
	if($.inArray(id,$("#add_conditions3_list").jqGrid("getGridParam","selarrrow")) < 0){
		$("#alertMessage").text("This row is not selected");
		triggerAlert();
		return;
	}
	
    var data = $("#add_conditions3_list").jqGrid("getRowData", id);

    $("#instructionToBankId").val(id);
    $("#instructionToBank").val(data.instruction);

    loadPopup("popup_instructionsToBank", "add_instructionsToBank_bg");
    centeringPopup("popup_instructionsToBank", "add_instructionsToBank_bg")
}

function initAddConditions3Grid() {
    setupAddConditions3Grids();
    $("#close_instructionsToBank, #close_instructionsToBank_close").click(closeEditInstructionToBankPopup);
}


$(initAddConditions3Grid);
