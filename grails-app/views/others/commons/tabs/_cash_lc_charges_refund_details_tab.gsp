<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="importType" value="${importType}" />
<g:hiddenField name="form" value="refundDetailsChargesTabForm" />


<g:textField class="input_field_short" name="totalChargesCurrency1" value="PHP" readonly="readonly"/>
<table>
	<tr>
		<td><span class="field_label">Refund Transaction Type</span></td>
		<td><g:select name="paymentTransactionType" class="select_dropdown" noSelection="['':'Select One']"
			from="${['FXLC Opening','DMLC Opening','FXLC Adjustment','FXLC Amendment','DMLC Amendment','FXLC Negotiation'
					,'DMLC Negotiation','BG/BE Issuance Charges','BG Cancellation Charges','FX Non-Lc Settlement','DM Non-Lc Settlement'
					,'FXLC Opening Cash','FXLC Opening Regular','FXLC Opening Standby','DMLC Opening Cash','DMLC Opening Regular','DMLC Opening Standby'
					,'FX Non-LC Settlement DP','FX Non-LC Settlement DA','FX Non-LC Settlement OA','FX Non-LC Settlement DR']}"/></td>
		<td class="no-border editable"><input type="button" id="go" class="popup_btn"/></td>
	</tr>
</table>
<br/>
<h3 class="title_label">Refund Details Summary for Charges</h3><br/>
<div class="grid_wrapper">
	<table id="grid_list_refund_details_summary_charges"></table>
	<div id="grid_pager_refund_details_summary_charges"></div>
</div>
<br/>
<div class="right_indent">
	<table class="charges_table">
		<tr>
			<td><h3 class="title_label">Total Amount of Charges Due</h3></td>
			<td><g:textField class="input_field_short" name="totalChargesCurrency1" value="PHP" readonly="readonly"/></td>
			<td><g:textField name="totalChargesAmountPhp" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField class="input_field_short" name="totalChargesCurrency2" value="USD" readonly="readonly"/></td>
			<td><g:textField name="totalChargesAmountUsd" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField class="input_field_short" name="totalChargesCurrency3" value="EUR" readonly="readonly"/></td>
			<td><g:textField name="totalChargesAmountEur" class="input_field" readonly="readonly"/></td>
		</tr>
	</table>
</div>
