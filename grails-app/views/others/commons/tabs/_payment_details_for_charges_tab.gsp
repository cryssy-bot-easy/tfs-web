
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="paymentDetailsTab" />


<%--<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Payment Transaction Type</span></td>
		<td><g:select name="paymentTransactionType" class="select_dropdown"	from="${['FXLC Opening', 'DMLC Opening', 'FXLC Adjustment', 
			'FXLC Amendment', 'DMLC Amendment', 'FXLC Negotiation', 
			'DMLC Negotiation', 'BG/BE Issuance Charges', 'BG Cancellation Charges',
			'FX Non - LC Settlement', 'DM Non - LC Settlement']}" noSelection="['':'Select One...']"/>
		</td>
		<td><input type="button" class="popup_btn" id="go"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr><td colspan="2"><span class="field_label p_header">Payment Summary of Other Charges Due</span></td></tr>
</table>
--%>
<span class="field_label">Payment Transaction Type</span>
<g:select name="paymentTransactionType" class="select_dropdown"	from="${['FXLC Opening', 'DMLC Opening', 'FXLC Adjustment', 
			'FXLC Amendment', 'DMLC Amendment', 'FXLC Negotiation', 
			'DMLC Negotiation', 'BG/BE Issuance Charges', 'BG Cancellation Charges',
			'FX Non - LC Settlement', 'DM Non - LC Settlement']}" noSelection="['':'Select One...']"/>
<input type="button" class="popup_btn" id="update_charges_processing_of_other_import_charges"/>
	
<br /><br />
<span class="field_label p_header">Payment Summary of Other Charges Due</span>			
<div class="grid_wrapper">
	<table id="grid_list_payment_details_for_charges"></table>
	<div id="grid_pager_payment_details_for_charges"></div>
</div>
<br />
<table class="charges_table">
	<tr>
		<td><span class="field_label title_label">Total Amount of Charges Due</span></td>
		<td><g:textField name="totalAmountOfChargesDueCurrency1" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="totalAmountOfChargesDue1" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td></td>
		<td><g:textField name="totalAmountOfChargesDueCurrency2" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="totalAmountOfChargesDue2" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td></td>
		<td><g:textField name="totalAmountOfChargesDueCurrency3" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="totalAmountOfChargesDue3" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br />
<g:if test="${serviceType?.equalsIgnoreCase('Other Import Charges')}">
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Additional Charges Currency</span></td>
		<td><g:select name="additionalChargesCurrency" class="select_dropdown"	from="${['PHP', 'USD', 'WON', 'YEN']}" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label p_header"><br/>Mode of Payment</span></td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of Payment - Charges<br/>(in Additional Charges Currency)</span></td>
		<td><g:textField name="amountOfPaymentChargesInAdditionalChargesCurrency" class="input_field"/></td>
	</tr>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<tr><td><g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges"/></td></tr>
</table>
<br /><br />
<span class="title_label">Payment Summary for Additional LC and Charges</span>
<div class="grid_wrapper">
	<table class="grid_list_payment_edit"></table>
</div>
<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">Total Amount of Payment - Charges (in Settlement Currency)</span></td>
		<td><g:textField name="totalAmountOfPaymentChargesInSettlementCurrrency" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Excess Amount - Charges (in Settlement Currency)</span></td>
		<td><g:textField name="excessAmountChargesInSettlementCurrrency" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
</g:if>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>