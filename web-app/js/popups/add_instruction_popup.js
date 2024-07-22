$(document).ready(function() {
    var popup_AddInstruction_div = $('#add_instructions_popup').attr("id");
    var popup_AddInstruction_bg = $('#add_instructions_bg').attr("id");

    $('#add_instruction').click(function() {
        $("#header_add_instruction").val("Add Instruction")
        $("#instructionId").val("")
        $("#addInstruction").val("");
        $("#message").val("");
        $("#instructionAction").val("addInstructions");

        //centering with css
        centerPopup(popup_AddInstruction_div, popup_AddInstruction_bg);
        //load popup
        loadPopup(popup_AddInstruction_div, popup_AddInstruction_bg);
        $("#message").limitCharAndLines(350);
        $("#message").focus();
    });

    $('.remark').bind('click',function() {
        $("#header_add_instruction").val("Edit Instruction")
        $("#addInstruction").val("");
        $("#instructionAction").val("editInstructions");
        //get jgrid data here
        var id = $("#grid_list_instruction_remarks").jqGrid('getGridParam','selrow');
        var row = $("#grid_list_instruction_remarks").jqGrid('getRowData',id);
        alert("ID: " + row.id + "COMMENT : " + id.comment);
        $("#message").val(id.comment);
        //centering with css
        centerPopup(popup_AddInstruction_div, popup_AddInstruction_bg);
        //load popup
        loadPopup(popup_AddInstruction_div, popup_AddInstruction_bg);
        $("#message").limitCharAndLines(350);
        $("#message").focus();
    });

    $('.add_instructions_close').click(function() {
        disablePopup(popup_AddInstruction_div, popup_AddInstruction_bg);
    });
    $('.add_instructions_confirm').click(function() {
        disablePopup(popup_AddInstruction_div, popup_AddInstruction_bg);
        //openPopupX();
    });
});
