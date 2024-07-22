<script type="text/javascript">
    $(document).ready(function() {
        // wires save confirm to display alert box
        $(".openConfirmation").click(function() {
            mCenterPopup($("#save_confirm"), $("#confirmation_background"));
            mLoadPopup($("#save_confirm"), $("#confirmation_background"));
        });
    });
</script>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="saveConfirm" class="input_button openConfirmation" value="Save" /></td>
    </tr>
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="cancelConfirm" class="input_button_negative cancelConfirm" value="Cancel" /></td>
    </tr>
</table>