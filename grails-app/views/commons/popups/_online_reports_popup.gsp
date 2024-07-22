<%@ page import="net.ipc.utils.DateUtils" %>
<div id="onlineReportsPopup" class="popup_div_override">
	<div class="popup_header">
		<a href="javascript:void(0)" class="popup_close" onclick="closeOnlineReportsPopUp()">x</a>
		<h2 class="popup_title"> Online Report </h2>
	</div>
	<table class="popup_table_short_center">
		<tr class="viewClientName">
			<td><span class="field_label">Client Name <span class="asterisk">*</span></span></td>
			<td><g:textField class="input_field" name="clientName" value=""/></td>
		</tr>
		<tr class="viewDate">
			<td><span class="field_label">Date<span class="asterisk">*</span></span></td>
			<td><g:textField name="onlineReportDate" class="datepicker_field" value="${DateUtils.shortDateFormat(new Date())}"/></td>
		</tr>
		<tr class="viewDateTransaction">
			<td><span class="field_label">Date of Transaction From <span class="asterisk">*</span></span></td>
			<td><g:textField name="dateOfTransactionFrom" id="dateOfTransactionFrom" class="datepicker_field"/></td>
		</tr>
		<tr class="viewDateTransaction">
			<td><span class="field_label">Date of Transaction To <span class="asterisk">*</span></span></td>
			<td><g:textField name="dateOfTransactionTo" id="dateOfTransactionTo" class="datepicker_field"/></td>
		</tr>
		<tr class="viewOnlineReportPuc">
			<td><span class="field_label">Processing Unit Code <span class="asterisk">*</span></span></td>
			<td><g:textField name="onlineReportPuc" class="input_field"/></td>
		</tr>
		<tr class="viewOnlineReportTellerID">
			<td><span class="field_label">Teller ID <span class="asterisk">*</span></span></td>
			<td><g:select name="tellerID" class="select_dropdown" noSelection="['ALL':'ALL']"
				from="${['0001', '0002', '0003', '0004', '0005', '0006', '0007', '0008', '0009', '0010']}"
				keys="${['0001', '0002', '0003', '0004', '0005', '0006', '0007', '0008', '0009', '0010']}"/></td>
		</tr>
		<tr class="viewAuthorizedSignatory">
			<td><span class="field_label">Authorized Signatory <span class="asterisk">*</span></span></td>
			<td><input name="authorizedSignatoryOnline" id="authorizedSignatoryOnline" class="select2_dropdown bigdrop"/></td>
		</tr>
		<tr class="viewAuthorizedSignatory">
			<td><span class="field_label">Position</span></td>
			<td><g:textField class="input_field" name="authorizedSignatoryOnlinePosition" readonly="readonly" value=""/></td>
		</tr>
		
		<tr class="viewDocumentNumber">
			<td><span class="field_label">Document Number <span class="asterisk">*</span></span></td>
			<td><g:textField name="docNumber" id="docNumber" class="input_field"/></td>
		</tr>
		
		<tr class="viewNewApprover">
			<td><span class="field_label">Re-route Approver To <span class="asterisk">*</span></span></td>
			<td><g:textField name="newApprover" id="newApprover" class="input_field"/></td>
		</tr>
	</table>
	<br/>
	<table class="buttons"> 
		<tr>
		  <td><input type="button" class="input_button buttonPopupGenDocument" value="OK" /></td>
		</tr>
		<tr>
		  <td><input type="button" class="input_button_negative" onclick="closeOnlineReportsPopUp()" value="Cancel" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_online_reports" class="popup_bg_override"></div>

<g:javascript src="popups/online_reports_popup.js"/>

<script type="text/javascript">
$(function(){
	if('undefined' !== typeof autoCompleteDigitalSignatoriesUrl){
		$("#authorizedSignatoryOnline").setDigitalSignatoriesDropdown($(this).attr("id")).select2('data',{id: '${authorizedSignatoryOnline}'});
	}
	$("#authorizedSignatoryOnline").change(function(){
		if($(this).select2('data')){
			$("#authorizedSignatoryOnlinePosition").val($(this).select2('data').position);
		} else {
			$("#authorizedSignatoryOnlinePosition").val('');
		}
	});
});
</script>