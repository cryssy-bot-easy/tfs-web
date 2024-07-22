
function setupInstructionsRoutingGrids(){
	var pageUrl = getRemarks + "?referenceType=" + $("#referenceType").val();
	//var pageUrl2 = '';
	
	setupJqGridWidthPagerHidden('grid_list_instructions_routing_remarks', {width: 780, scrollOffset:1, loadui: "disable",
			gridComplete : function(){
			    		$(".jqgrow").mouseover(function() {
			    		     //set value for rowId to be use by alert_utility.js
							 rowId = $(this).attr("id");
						});
			    	}
		},
			[['currentUser', 'User (Current User)', 16],
			['dateAndTimeOfComment', 'Date and Time of Comment', 16],
			['comment', 'Comment', 63],
			['edit', 'Edit', 5]], 'grid_pager_instruction_remarks', pageUrl);

    var etsNumber = $("#etsNumber").val();
//    if(etsNumber) {
    var pageUrl2 = routingUrl;
//    }

	setupJqGridPager('grid_list_instructions_routing_information', {width: 780, scrollOffset:0, loadui: "disable"},
			[['senderActiveDirectoryId', 'Sender'],
			['dateSent', 'Date and Time Sent'],
			['status', 'Status'],
			['receiver','Receiver']], 'grid_pager_instructions_routing_information', pageUrl2);
}

	
function initInstructionsRoutingGrid(){
	setupInstructionsRoutingGrids();
	
//	var gridRowContentInstruction = $('#grid_list_instruction_remarks');
//
//	var gridRowContentRouting = $('#grid_list_routing_information');
//
//	gridRowContentInstruction.addRowData("1", {currentUser:"Juliet Pariabras", dateAndTimeOfComment:"05/15/12 14:30:26 PM",comment:"With Prior Approval In CRAM",edit:"<a href=\"javascript:void(0)\" onclick=\"var id='1'; onEditClick(id);\" style=\"color: blue\">Edit</a>" });
//	gridRowContentInstruction.addRowData("2", {currentUser:"Juliet Pariabras", dateAndTimeOfComment:"03/15/12 14:30:26 PM",comment:"With Prior Approval In CRAM",edit:"<a href=\"javascript:void(0)\" onclick=\"var id='2'; onEditClick(id);\" style=\"color: blue\">Edit</a>" });
//	gridRowContentInstruction.addRowData("3", {currentUser:"Juliet Pariabras", dateAndTimeOfComment:"11/16/11 14:30:26 PM",comment:"With Prior Approval In CRAM",edit:"<a href=\"javascript:void(0)\" onclick=\"var id='3'; onEditClick(id);\" style=\"color: blue\">Edit</a>" });
//	gridRowContentInstruction.addRowData("4", {currentUser:"Juliet Pariabras", dateAndTimeOfComment:"05/15/11 14:30:26 PM",comment:"With Prior Approval In CRAM",edit:"<a href=\"javascript:void(0)\" onclick=\"var id='4'; onEditClick(id);\" style=\"color: blue\">Edit</a>" });
//
//	gridRowContentRouting.addRowData("1", {currentUserSender:"Juliet Pariabras", dateAndTimeSent:"05/15/12 14:30:26 PM",statusSender:"Prepared" });
//	gridRowContentRouting.addRowData("2", {currentUserSender:"Juliet Pariabras", dateAndTimeSent:"03/15/12 14:30:26 PM",statusSender:"Prepared" });
//	gridRowContentRouting.addRowData("3", {currentUserSender:"Juliet Pariabras", dateAndTimeSent:"11/16/11 14:30:26 PM",statusSender:"Prepared" });
//	gridRowContentRouting.addRowData("4", {currentUserSender:"Juliet Pariabras", dateAndTimeSent:"05/15/11 14:30:26 PM",statusSender:"Prepared" });
}

function editRemark(selectedRow) {
    var popup_AddInstruction_div = $('#add_instructions_popup').attr("id");
    var popup_AddInstruction_bg = $('#add_instructions_bg').attr("id");
    $("#header_add_instruction").val('Edit Instruction');
    $("#addInstruction").val("");
    $("#instructionAction").val("editInstructions");
//    var id = $("#grid_list_instructions_routing_remarks").jqGrid('getGridParam','selrow');
    var row = $("#grid_list_instructions_routing_remarks").jqGrid('getRowData',selectedRow);
    $("#message").val(row.comment);
    //centering with css
    $("#message").limitCharAndLines(350);
    $("#message").focus();
    centerPopup(popup_AddInstruction_div, popup_AddInstruction_bg);
    //load popup
    loadPopup(popup_AddInstruction_div, popup_AddInstruction_bg);
}

$(initInstructionsRoutingGrid);