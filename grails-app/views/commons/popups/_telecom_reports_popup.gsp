<%@ page import="net.ipc.utils.DateUtils" %>
<div id="telecomReportsPopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popup_close" onclick="closeOnlineReportsPopUp()">x</a>
		<h2 class="popup_title"> Online Report </h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td><span class="field_label">Date <span class="asterisk">*</span></span></td>
			<td><g:textField name="telecomReportDate" class="datepicker_field" value="${DateUtils.shortDateFormat(new Date())}"/></td>
		</tr>
	</table>
	<br/>
	<table class="buttons"> 
		<tr>
		  <td><input type="button" class="input_button buttonPopupGenDocument" id="generateOutgoingMt" value="OK" /></td>
		</tr>
		<tr>
		  <td><input type="button" class="input_button_negative" onclick="closeTelecomReportsPopUp()" value="Cancel" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_telecom_reports" class="popup_bg_override"></div>