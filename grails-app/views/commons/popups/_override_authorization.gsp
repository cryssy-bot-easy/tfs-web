<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert2" id="${overrideAuthDivId}">
    <div class="popup_header">
        <h2 class="popup_title"> CASA Override </h2>
    </div>
    <span class="field_label"> This action needs to be confirmed by a ${session.group} officer</span>
    <table>
        <tr>
            <td class="field_label">Username:</td>
            %{--<td><input id="${overrideAuthUsernameId}" type="text" class="input_field_login_normal_case required1 name"/></td>--}%
            %{--temporarily removed--}%
            <td><input id="${overrideAuthUsernameId}" type="text" class="input_field_login_normal_case name"/></td>
        </tr>
        <tr>
            <td class="field_label">Password: </td>
            %{--<td><input id="${overrideAuthPasswordId}" type="password" class="input_field_login_normal_case required1 pass"/></td>--}%
            %{--temporarily removed--}%
            <td><input id="${overrideAuthPasswordId}" type="password" class="input_field_login_normal_case pass"/></td>
        </tr>
    </table>
    <ul class="popup_buttons_alert">
        <li>
            <input type="button" class="input_button_alert" value="Ok" id="${overrideAuthConfirmId}"/>
            <input type="button" class="input_button_negative_alert" value="Cancel" id="${overrideAuthCancelId}"/>
        </li>
    </ul>
    <input type="hidden" id="${overrideAuthCasaPaymentId}">
</div>
<div class="popup_bg_alert" id="${overrideAuthDivBg}"></div>
<%-- CONFIRMATION POPUP END --%>

<script>
    var validateCasaTransactionAmountUrl = '${g.createLink(controller:'payment', action:'validateCasaTransactionAmount')}';
    var authenticateOfficerUrl = '${g.createLink(controller:'payment', action:'loginOfficer')}';
    $(function(){
        $("#${overrideAuthUsernameId}").blur(function(){
            $(this).val($(this).val().toUpperCase());
        });
    });
</script>