
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="messageType" value="799"/>
<g:hiddenField name="chainName" value="viewMT799"/><%--Used for chaining in saveOutgoingMt action --%>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%--Used for disabling tab/s in basic_details_utility--%>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label title_label"> Advising Bank<span class="asterisk">*</span> </span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop" name="advisingBank" id="advisingBank" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label title_label">20: Transaction Reference Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="documentNumberMt799" class="input_field_long" value="${details?.documentNumberMt799}" maxlength="16"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">21: Related Reference</span></td>
		<td><g:textField name="relatedReference" class="input_field_long" value="${details?.relatedReference}" maxlength="16"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label title_label">79: Narrative<span class="asterisk">*</span></span></td>
		<td><g:textArea name="mtNarrative" class="textarea_long" rows="10" value="${details?.mtNarrative}" maxlength="1750"/></td>
	</tr>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<g:if test="${tradeServiceId?.tradeServiceId != null}">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 799" onclick="viewOutgoingMt(799)"/>
			</td>
		</tr>	
	</g:if>
	<tr>
		<td><input type="button" id="saveOutgoingMt" class="input_button" value="Save" /></td>
	</tr>
	<tr>
		<td><input type="button" id="cancelOutgoingMtPopup" class="input_button_negative" value="Cancel" /></td>
	</tr>
</table>

<script>
$(function(){
	$("#advisingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.advisingBank}'});
	
});
</script>
