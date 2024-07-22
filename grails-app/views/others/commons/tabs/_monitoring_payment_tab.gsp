<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="arPayment" />

<span class="title_label">Payment Details</span>
<table>
	<tr>
		<td class="label_width"><span class="field_label">Nature of Transaction</span></td>
		<g:if test="${serviceType?.equalsIgnoreCase('Monitoring Payment') ||
						serviceType?.equalsIgnoreCase('Monitoring Refund')}">
			<td><g:select name="natureOfTransaction" class="select_dropdown" from="${['FXLC Opening', 'FXLC Adjustment', 'FXLC Amendment', 'FXLC Negotiation']}" noSelection="['':'Select One...']"/></td>
		</g:if>
		<g:else>
			<td><g:textField name="natureOfTransaction" class="input_field" readonly="readonly"/></td>
		</g:else>
	</tr>
</table>
<br/>
<table class="charges_table">
	<g:if test="${serviceType?.equalsIgnoreCase('Monitoring Refund')}">
		<tr>
			<td><span class="field_label">AP Currency/Amount</span></td>
			<td><g:textField name="apCurrency" class="input_field_short" readonly="readonly"/></td>
			<td><g:textField name="apAmount" class="input_field_right" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Amount of Refund <span class="asterisk">*</span></span></td>
			<td><g:textField name="refundCurrency" class="input_field_short" readonly="readonly"/>
			<td class="editable"><g:textField name="amountOfRefund" class="input_field"/></td>	
		</tr>
	</g:if>
	<g:else>
		<tr>
			<td><span class="field_label">AR Currency/Amount</span></td>
			<td><g:textField name="arCurrency" class="input_field_short" readonly="readonly"/></td>
			<td><g:textField name="arAmount" class="input_field_right" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Amount of Payment <span class="asterisk">*</span><br/>(in Settlement Currency)</span></td>
			<td><g:textField name="settlementCurrency" class="input_field_short" readonly="readonly"/>
			<td class="editable"><g:textField name="amountOfPayment" class="input_field"/></td>	
		</tr>
	</g:else>
</table>
<br /><br />
	<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment" value="Add Settlement"/>
	<br /><br />
<g:if test="${documentType?.equalsIgnoreCase('AR')}">
	<span class="title_label">Payment Summary for AR Settlement</span>
</g:if>
<g:if test="${documentType?.equalsIgnoreCase('AP')}">
	<span class="title_label">Payment Summary for AP Settlement</span>
</g:if>
<div class="grid_wrapper">
	<table class="grid_list_payment_edit"></table>
</div>
<table>
<g:if test="${serviceType?.equalsIgnoreCase('Monitoring Refund')}">
	<tr>
		<td><span class="field_label"> Total Amount of Refund (in Refund Currency) </span></td>
		<td><g:textField class="input_field_right" readonly="readonly" name="totalAmountOfRefund" value="200.00"/></td>
	</tr>
</g:if>
<g:else>
	<tr>
		<td><span class="field_label"> Total Amount of Payment (in Settlement Currency)</span> </td>
		<td><g:textField name="totalAmountOfPaymentInSettlementCurrency" value="1,000.00" class="input_field_right" readonly="readonly"/></td>
	</tr>
	<tr>
		<td> <span class="field_label"> Excess Amount (in Settlement Currency) </span> </td>
		<td><g:textField name="excessAmountInSettlementCurrency" value="1,000.00" class="input_field_right" readonly="readonly"/></td>
	</tr>
</g:else>
</table>
<br />
<br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>