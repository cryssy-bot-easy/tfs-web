<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />


<%--<g:javascript src="popups/mode_of_payment_ar_monitoring_popup.js"/>--%>


<table>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">Document Number/<br />Reference Number</span></td>
		<td><g:textField name="documentReferenceNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date</span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><p class="p_header"><br />Payment Details</p></td>
	</tr>
</table>
<br/>
<table class="charges_table">
	<tr>
		<td><span class="field_label">Nature of Transaction</span></td>
		<td colspan="2"><g:textField name="natureOfTransaction" class="input_field" readonly="readonly"/></td>
<%--		<td><g:select name="natureOfTransaction" class="select_dropdown" from="${['FXLC Opening', 'FXLC Adjustment', 'FXLC Amendment', 'FXLC Negotiation']}" noSelection="['':'Select One...']"/></td>--%>
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td>AR Currency/Amount</td>
		<td><g:textField name="arCurrency" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="arAmount" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td>Amount of Payment<br/> (in Settlement Currency)<span class="asterisk">*</span></td>
		<td><g:textField name="settlementCurrency" class="input_field_short" readonly="readonly"/></td>
		<td class="editable"><g:textField name="amountOfPayment" class="input_field"/></td>
	</tr>
</table>

<br /><br />
<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add AR Settlement"/>
<br /><br />
<p class="p_header">Payment Summary for AR Settlement</p>
<div class="grid_wrapper">
	<table id="grid_list_charges_payment"></table>
	<div id="grid_pager_charges_payment"></div>
</div>
<table>
	<tr>
		<td><span class="field_label">Total Amount of Payment (in Settlement Currency)</span> </td>
		<td><g:textField name="totalAmountOfPaymentInSettlementCurrency" value="1,000.00" class="input_field right" readonly="readonly"/></td>
	</tr>
	<tr>
		<td> <span class="field_label">Excess Amount (in Settlement Currency)</span> </td>
		<td><g:textField name="excessAmountInSettlementCurrency" value="1,000.00" class="input_field right" readonly="readonly"/></td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>

<%--<g:render template="../popups/mode_of_payment/mode_of_payment_popup" />--%>