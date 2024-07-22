
%{--CONFIRMATION POPUP--}%
<div class="popup_div_alert" id="popup_reinstate_div">
	<h2 class="popup_title"> Alert! </h2>
    <span class="field_label"> Do you want to reinstate? </span>
    %{--<g:textField name="statusAction" value=""/>--}%
    <br/><br/>
    <table class="reinstate_buttons">
      <tr>
      	<td> <input type="button" class="input_button_alert" value="Yes" id="reinstateConfirm"/> </td>
      	<td> <input type="button" class="input_button_negative_alert" value="No" id="reinstateNo"/> </td>
<%--      	<td> <input type="button" class="input_button_negative_alert" value="Cancel" id="reinstateCancel"/> </td>--%>
      </tr>
    </table>
</div>
<div class="popup_bg_alert" id="confirmation_background"></div>
%{--CONFIRMATION POPUP END--}%