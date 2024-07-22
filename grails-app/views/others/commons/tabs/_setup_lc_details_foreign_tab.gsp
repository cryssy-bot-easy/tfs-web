<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="setupLcDetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> EXLC Advise Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="exlcAdviseNumber" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Number<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="lcNumber" maxlength="16" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Issue Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field" name="lcIssueDate" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Type<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:radioGroup values="['REGULAR','STANDBY']" labels="['Regular','Standby']" name="lcType" value="REGULAR">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Tenor Term<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:radioGroup values="['SIGHT','USANCE']" labels="['Sight','Usance']" name="lcTenorTerm" value="SIGHT">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> If Usance: Usance Term </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="usanceTerm"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="lcCurrency" from="${['USD','PHP','EUR']}" noSelection="['':'Select One...']" value="USD"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="lcAmount" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field" name="lcExpiryDate" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Issuing Bank<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="issuingBank" from="" noSelection="['':'SWIFT']" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Issuing Bank Address<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="issuingBankAddress" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Reimbursing Bank </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="reimbursingBank" from="" noSelection="['':'SWIFT']" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Description of Goods<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="descriptionOfGoods" /> </td>
	</tr>
</table>

<g:render template="../layouts/buttons_for_grid_wrapper" />
<script>

$(function(){
	$("#lcNumber").keypress(function(e){
	    var charCheck = true;
	    if (e.charCode == 45){
	        charCheck = false;
	    }
	    return charCheck
	});
});
</script>