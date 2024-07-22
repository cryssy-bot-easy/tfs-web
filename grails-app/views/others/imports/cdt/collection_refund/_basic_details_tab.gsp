<g:javascript src="utilities/other_imports/cdt/mode_of_refund.js"/>
<g:javascript src="utilities/other_imports/cdt/cdt_refund_utility.js"/>
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails"/>


<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td><span class="field_label">IED/IEIRD No.</span></td>
		<td><g:textField name="iedIeirdNo" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">AAB-Ref No.</span></td>
		<td><g:textField name="aabRefNo" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">CDT Reference No.</span></td>
		<td><g:textField name="cdtReferenceNo." class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document No.</span></td>
		<td><g:textField name="documentNo" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td><span class="field_label">Importer's Name</span></td>
		<td><g:textField name="importersName" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td><span class="field_label">Currency</span></td>
		<td><g:textField name="currencyTemp" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">CDT Amount</span></td>
		<td><g:textField name="cdtAmount" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">IPF</span></td>
		<td><g:textField name="ipf" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Total Amount to be Refunded</span></td>
		<td><g:textField name="totalAmountToBeRefunded" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">BOC Account Number</span></td>
		<td><g:textField name="bocAccountNumber" class="input_field" readonly="readonly"/></td>
		<td><g:submitToRemote name="debitCasa" class="input_button2 debitButton" value="Debit CASA"/></td>
		
	</tr>
	<tr>
		<td><span class="field_label">Mode of Refund</span></td>
		<td><g:select name="modeOfRefund" class="select_dropdown modeOfRefund" from="${['CASA', 'MC', 'IBT - Branch']}" noSelection="['':'Select One...']"/></td>
	</tr>
</table>
<table class="display-block-mode-of-refund">
	<tr>
		<td class="label_width"><span class="field_label">&#160;&#160;&#160;&#160;&#160;Account Number</span></td>
		<td><g:textField name="accountNumber" class="input_field" readonly='readonly' /></td>
	</tr>
	<tr>
		<td><span class="field_label">&#160;&#160;&#160;&#160;&#160;Account Name</span></td>
		<td><g:textField name="accountName" class="input_field" readonly="readonly"/></td>
		<td><g:submitToRemote name="creditCasa" class="input_button2 creditButton" value="Credit CASA"/></td>
		
	</tr>
<%--	<tr>--%>
<%--		<td><span class="field_label">&#160;&#160;&#160;&#160;&#160;Account Balance</span></td>--%>
<%--		<td>--%>
<%--			<g:textField name="accountBalance" class="input_field" readonly="readonly"/>--%>
<%--			--%>
<%--		</td>--%>
<%--	</tr>--%>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>