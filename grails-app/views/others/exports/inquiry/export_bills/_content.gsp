<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="grids/export_bills_inquiry_jqgrid.js" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="username" value="${username}" />

<table class="body_forms_table">

	<g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
     <tr>
			<td class="label_width"><span class="field_label">Negotiation Number</span> </td>
			<td class="input_width"><g:textField name="negotiationNumber" class="input_field"/></td>
			<td class="label_width"><span class="field_label">Transaction Type</span> </td>
			<td><g:select name="transactionType" class="select_dropdown" from="${['Domestic Bills for Collection','Domestic Bills for Purchase','Export Bills for Collection','Export Bills for Purchase']}"  noSelection="['':'Select One...']" /></td>
		</tr>
		<tr>
			<td><span class="field_field"> Client Name </span></td>
			<td><g:textField name="clientName" class="input_field" /></td>
			<td class="label_width"><span class="field_label">Status</span> </td>
			<td><g:select name="status" class="select_dropdown" from="${['Negotiated','Settled','Cancelled']}"  noSelection="['':'Select One...']" /></td>
		</tr>
	</g:if>
    <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
    <tr>
			<td class="label_width"><span class="field_label">Negotiation Number</span> </td>
			<td class="input_width"><g:textField name="negotiationNumber" class="input_field"/></td>
			<td class="label_width"><span class="field_label">Transaction</span> </td>
			<td><g:select name="transaction" class="select_dropdown" from="${['Domestic Bills','Export Bills']}"  noSelection="['':'Select One...']" /></td>
		</tr>
		<tr>
			<td><span class="field_field"> Client Name </span></td>
			<td><g:textField name="clientName" class="input_field" /></td>
			<td class="label_width"><span class="field_label">Transaction Type</span> </td>
			<td><g:select name="transactionType" class="select_dropdown" from="${['Collection','Purchase']}"  noSelection="['':'Select One...']" /></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Corres Bank</span> </td>
			<td><g:select name="corresBank" class="select_dropdown" from=""  noSelection="['':'Select One...']" /></td>
			<td class="label_width"><span class="field_label">Status</span> </td>
			<td><g:select name="status" class="select_dropdown" from="${['Negotiated','Settled','Cancelled']}"  noSelection="['':'Select One...']" /></td>
		</tr>
    </g:if>   
</table>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td><input type="button" id="btnSearch" class="input_button" value="Search" /></td>
	</tr>
	<tr>
		<td><input type="button" id="btnReset" class="input_button_negative" value="Reset" /></td>
	</tr>
</table>
<g:render template="/others/commons/popups/modify_export_bills_transaction_popup" />	
	<div class="grid_wrapper">
	<g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
		<table id="grid_list_export_bills_inquiry_main"></table>
	</g:if>
	<g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
		<table id="grid_list_export_bills_inquiry_branch"></table>
	</g:if>
	<div id="grid_pager_export_bills_inquiry"></div>
	</div>