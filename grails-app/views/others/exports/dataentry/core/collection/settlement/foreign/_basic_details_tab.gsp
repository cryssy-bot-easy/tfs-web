<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsNumber" readonly="readonly"/> </td>
		<td class="label_width"> <span class="field_label"> Corres Bank </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="corresBank" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsDate" readonly="readonly"/> </td>
		<td class="label_width"> <span class="field_label"> Corres Bank's Account Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="corresBankAccountNumber" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly"/> </td>
		<td class="label_width"> <span class="field_label"> Type of Account </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="typeOfAccount" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> EBC Details </span> </td>
		<td />
		<td class="label_width"> <span class="field_label"> Currency Code </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="currencyCode" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="ebcNegotiationNumber" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="ebcNegotiationCurrency" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right" name="ebcNegotiationAmount" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> EBP Details </span> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBP Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="ebpNegotiationCurrency" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBP Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right" name="ebpNegotiationAmount" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Proceeds Amount (in Negotiation Currency)<span class="asterisk"> * </span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="proceedsAmount" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Amount for Credit </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="amountOfCredit" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> With 2% CWT? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}">
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Export proceeds to be </span> <br />
			<span class="field_label"> remitted via PDDTS? </span>
		</td>
		<td class="input_width">
		  	<g:radioGroup name="exportProceedsFlag" labels="['Yes','No']" values="['Y','N']" value="N">
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
		</td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />