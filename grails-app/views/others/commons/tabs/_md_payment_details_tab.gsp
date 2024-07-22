<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="applicationPaymentTabForm" />


<%--<g:javascript src="grids/mode_of_application_jqgrid.js"/>--%>
<%--<g:javascript src="popups/mode_of_application_popup.js"/>--%>
<%--<g:render template="../popups/otherImports/mode_of_application/mode_of_application_popup"/>--%>

<table>
	<g:if test="${serviceType?.equalsIgnoreCase('Application')}">
		<tr>
			<td><span class="field_label">O/S MD Currency</span></td>
			<td><g:textField name="mdCurrency" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label">O/S MD Balance</span></td>
			<td><g:textField name="mbBalance" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Amount of MD To Apply</span></td>
			<td><g:textField name="amountOfMdToApply" class="input_field"/></td>
		</tr>
	</g:if>
	<g:if test="${serviceType?.equalsIgnoreCase('Collection')}">
		<tr>
		<td class="label_width"><span class="field_label">MD Currency<span class="asterisk"> *</span></span></td>
		<td class="input_width"><g:select name="mdCurrency" from="${['PHP','USD','WON','YEN']}" class="select_dropdown" noSelection="['':'Select One...']"/></td>
		</tr>
		<tr>
			<td><span class="field_label">MD Collection Amount <span class="asterisk">*</span></span></td>
			<td><g:textField name="mdCollectionAmount" class="input_field" /></td>
		</tr>
	</g:if>
</table>
<br/>
<div class="center">
	<input type="button" id="popup_btn_mode_of_payment_charges" value="Add Mode of Application" class="input_button_long button_override"/>
	<br/>
	<br/>
<div class="grid_wrapper">
     <g:if test="${referenceType.equalsIgnoreCase('eTS') }">
	<table id="grid_list_mode_of_application"></table>
    </g:if>
    <g:if test="${referenceType.equalsIgnoreCase('Data Entry') }">
	<table class="grid_list_payment_edit"></table>
    </g:if>
</div>

</div>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>


