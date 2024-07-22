<%--USED BY ETS IMPORT ADVANCE REFUND--%>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="importAdvanceAmountDetailsTabForm" />

<%--<g:javascript src="popups/mode_of_payment_to_importer_popup.js" />--%>



<table>
	<tr>
		<td class=""><span class="field_label">Import Advance Currency</span></td>
		<td><g:textField name="importAdvanceRefundCurrency" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class=""><span class="field_label"> Import Advance Refund Amount</span></td>
		<td><g:textField name="importAdvanceRefundAmount" class="input_field"/></td>
	</tr>
	<tr>
		<td class=""><span class="field_label">Refund Currency</span></td>
		<td><g:select name="refundCurrency" class="select_dropdown" from="${['PHP']}"/></td>
	</tr>
</table>
<div class="grid_wrapper"> <%-- JQGRID --%>
	  <table id="grid_list_cash_forex"> </table>
</div>
<table class="popup_full_width">
    <tr>
    		<td class="label_width">Pass-on rates confirmed by:</td>
    		<td><g:textField name="passOnRateConfirmedBy" class="input_field"/></td>
    	<%-- if foreign --%>
    		<td><input type="button" class="input_button_long" value="Recompute Charge"/></td>
    </tr>
</table>
<br/>
<br/>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Refund Amount</span></td>
		<td class="input_width"><g:textField name="importAdvanceRefundAmount" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br />
<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement"/>
<br /><br/>
<span class="title_label">Payment Summary for Import Advanced Refund</span>
<div class="grid_wrapper">
	<g:if test="${referenceType?.equalsIgnoreCase('eTS') }">
		<table id="grid_list_import_advance_refund"></table>
	</g:if>
	<g:else>
		<table class="grid_list_payment_edit"></table>
	</g:else>
</div>

<%--<g:render template="../popups/mode_of_payment/mode_of_payment_to_importer_popup"/>--%>