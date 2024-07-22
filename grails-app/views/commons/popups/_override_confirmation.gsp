<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert2" id="overrideConfirmation">
    <div class="popup_header">
        <h2 class="popup_title"> This transaction will exceed the maximum credit limit for your branch. </h2>
    </div>
    <span class="field_label"> This action needs to be confirmed by a TSD officer</span>
    <table>
        <tr>
            <td class="field_label">Username: </td>
            <td><input id="usernameConfirm" type="text" class="input_field_login required1 name"/></td>
        </tr>
        <tr>
            <td class="field_label">Password: </td>
            <td><input id="passwordConfirm" type="password" class="input_field_login required1 pass"/></td>
        </tr>
    </table>
    <ul class="popup_buttons_alert">
        <li>
            <input type="button" class="input_button_alert" value="Ok" id="overrideYes"/>
            <input type="button" class="input_button_negative_alert" value="Cancel" id="overrideNo"/>
        </li>
    </ul>
    <input type="hidden" id="casaPaymentId">
</div>
<div class="popup_bg_alert" id="override_confirmation_bg"></div>
<%-- CONFIRMATION POPUP END --%>

<script>
$(function(){
	$("#usernameConfirm").blur(function(){
		$(this).val($(this).val().toUpperCase());
	});
});
</script>