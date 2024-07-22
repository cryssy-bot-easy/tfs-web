<div id="popup_addNewInstruction" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="close_addNewInstruction" class="popup_close">x</a>
        <h2 id="popup_header_addCondition1"> Add New Instruction </h2>
    </div>
    <g:hiddenField name="newInstructionId" id="newInstructionId" value=""/>
    <div class="popup_divider">
        <div><g:textArea name="newInstruction" class="textarea_add_instructions_exports" disabled="disabled"></g:textArea></div>
        <br /><br />
        <table class="popup_buttons">
            <tr><td class="right_indent"><input type="button" class="input_button" value="Save" id="save_addNewInstruction" /></td></tr>
            <tr><td class="right_indent"><input type="button" class="input_button_negative" id="cancel_addNewInstruction" value="Close" /></td></tr>
        </table>
    </div>
</div>
<div id="addNewInstruction_bg" class="popup_bg_override"> </div>

<script>
    $(document).ready(function() {
        $("#save_addNewInstruction").click(function() {

            var params = {
                page: 1,
                postData: {
                    id: function () {
                        if ($("#newInstructionId").val() != "") {
                            return $("#newInstructionId").val();
                        } else {
                            return "";
                        }
                    },
                    instruction: function() {
                        if ($("#newInstruction").val() != "") {
                            return $("#newInstruction").val();
                        } else {
                            return "";
                        }
                    },
                    add: true
                }
            }

            $("#grid_list_additional_conditions").jqGrid('setGridParam', params).trigger("reloadGrid");

            disablePopup("popup_addNewInstruction", "addNewInstruction_bg");
        });

        $("#close_addNewInstruction, #cancel_addNewInstruction").click(function() {
            $("#newInstructionId, #newInstruction").val("");
            disablePopup("popup_addNewInstruction", "addNewInstruction_bg");
        });
    });
</script>