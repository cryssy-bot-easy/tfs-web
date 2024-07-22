<div id="popup_enclosedInstruction" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="close_enclosedInstruction" class="popup_close">x</a>
        <h2 id="popup_header_addCondition1"> Add Instruction </h2>
    </div>
    <g:hiddenField name="enclosedInstructionId" id="enclosedInstructionId" value=""/>
    <div class="popup_divider">
        <g:textArea name="enclosedInstruction" class="textarea_add_instructions null_case" disabled="disabled"></g:textArea>
		<%--        
        <span class="label_width"><span id="remainingCharacterEnclosedInstructions"></span>&#160;Characters Left</span><br />
		<span class="label_width"><span id="remainingLineEnclosedInstructions"></span>&#160;Lines Left</span>
		--%>
        <br /><br />
        <table class="popup_buttons">
            <tr><td class="right_indent"><input type="button" class="input_button" value="Save" id="save_enclosedInstruction" /></td></tr>
            <tr><td class="right_indent"><input type="button" class="input_button_negative" id="cancel_enclosedInstruction" value="Close" /></td></tr>
        </table>
    </div>
</div>
<div id="enclosedInstruction_bg" class="popup_bg_override"> </div>

<script>
    $(document).ready(function() {
        $("#save_enclosedInstruction").click(function() {
            var id = $("#enclosedInstructionId").val();

            var editData = {
                instruction: $("#enclosedInstruction").val()
            }

            $("#grid_list_instructions").jqGrid('setRowData', id, editData);
            disablePopup("popup_enclosedInstruction", "enclosedInstruction_bg");
        });

        $("#close_enclosedInstruction, #cancel_enclosedInstruction").click(function() {
            $("#enclosedInstructionId, #enclosedInstruction").val("");
            disablePopup("popup_enclosedInstruction", "enclosedInstruction_bg");
        });
    });
</script>