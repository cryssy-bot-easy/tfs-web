<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="loanSetupTab" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Facility type </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="facilityType" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Facility ID </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="facilityId" from="" noSelection="['':'Select One...']" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Booking Currency </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="bookingCurrency" from="['PHP','USD','EUR']" noSelection="['':'Select One...']"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Loan Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="loanAmount"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Interest Rate (in %)<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="interestRate"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Interest Term Code </span> </td>
		<td class="input_width">
			<g:radioGroup name="interestTermCode" values="['D', 'M']" labels="['D', 'M']">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		 </td>
		<td class="label_width"> <span class="field_label"> Interest Term<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="interestTerm"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Repricing Term Code </span> </td>
		<td class="input_width">
			<g:radioGroup name="repricingTermCode" values="['D', 'M']" labels="['D', 'M']">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		 </td>
		<td class="label_width"> <span class="field_label"> Repricing Term </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="repricingTerm"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Loan Term Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:radioGroup name="loanTermCode" values="['D', 'M']" labels="['D', 'M']">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		 </td>
		<td class="label_width"> <span class="field_label"> Loan Term<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="loanTerm"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Loan Maturity Date </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field" name="loanMaturityDate"/> </td>
		<td class="label_width"> <span class="field_label"> Number of Free Float Days? </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="numberOfFreeFloatDays"/> </td>
	</tr>
	
</table>

<g:render template="../layouts/buttons_for_grid_wrapper" />