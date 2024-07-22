<g:javascript src="grids/payment_details_for_charges_jqgrid.js"/>
<g:javascript src="popups/other_export_charges_payment_popup.js"/>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="paymentDetailsTabForm" />

<table class="tabs_forms_table">
	<g:if test="${!serviceType?.equalsIgnoreCase('refund of other export charges') }">
		<tr>
			<td width="160"><span class="field_label">Document Number</span></td>
			<td><g:textField name="documentNumber" class="input_field" /></td>
		</tr>
		<tr>
			<td><span class="field_label">With 2% CWT?</span></td>
			<td><g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}"> ${it.radio} ${it.label} &#160; &#160; </g:radioGroup></td>
		</tr>
	</g:if>
	<tr>
		<td><span class="field_label">Transaction Type</span></td>
		<td><g:select name="paymentTransactionType" class="select_dropdown" from="${['Advise on Opening','Advise on Amendment','Advise on Cancellation', 'Domestic Bills for Collection - Settlement','Domestic Bills for Purchase - Negotiation','Domestic Bills for Purchase - Settlement', 'Export Bills for Purchase - Negotiation','Export Bills for Collection - Settlement','Export Bills for Purchase - Settlement','Export Advance - Payment','Export Advance - Refund']}" noSelection="['':'Select One...']" /></td>
	</tr>
	<g:if test="${ subType1 == 'Type1' || serviceType?.equalsIgnoreCase('refund of other export charges')}">
		<tr class="temporary_for_testing_only_charges_payment">
			<td><span class="field_label">Transaction Date</span></td>
			<td><g:select name="transactionDate" class="select_dropdown" from="['July 7, 2012']" noSelection="['':'Select One...']" /></td>
			<td><input type="button" id="go" class="popup_btn"/></td>
		</tr>
	</g:if>
</table>

<br/>
<br/>

<g:if test="${ subType1 == 'Type2'  }">
	<span class="tab_titles"> Select Other Charge/s</span>
	<table class="charges_table">
		<tr>
			<td width="155"><span class="field_label">Bank Commission</span></td>
			<td><span class="charges_currency"></span></td>
			<td class="editable"><g:textField name="bankCommission" class="input_field" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Cable Fee</span></td>
			<td><span class="charges_currency"></span></td>
			<td class="editable"><g:textField name="cabkeFee" class="input_field" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Documentary Stamp</span></td>
			<td><span class="charges_currency"></span></td>
			<td class="editable"><g:textField name="documentaryStamp" class="input_field" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Other Local Bank's Charges</span></td>
			<td><span class="charges_currency"></span></td>
			<td class="editable"><g:textField name="otherLocalBankCharges" class="input_field" /></td>
		</tr>
	</table>
	<br/>
	<table class="charges_table">
		<tr>
			<td width="155"><span class="field_label">Total Amount Charges Due <br/> (in Settlement Currency()</span>
			<td><span class="charges_currency" id="totalAmountChargesCurrency"></span></td>
			<td><g:textField class="input_field" name="totalAmountCharges" readonly="readonly"/></td>
		</tr>
	</table>
	<br/>
</g:if>

<g:if test="${ subType1 == 'Type1' || serviceType?.equalsIgnoreCase('refund of other export charges') }">
	<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}">
		<span class="field_label title_label">Refund Details Summary for Charges</span>
	</g:if>
	<g:else>
		<span class="field_label title_label">Payment Summary of Other Charges Due</span>
	</g:else>
	<br/>
	<div class="grid_wrapper">
		<table id="grid_list_payment_details_for_charges"></table>
		<div id="grid_pager_payment_details_for_charges"></div>
	</div>
	<br/>
	<div class="">
		<table class="right_indent charges_table">
			<tr>
				<td><span class="field_label p_header">Total Amount of Charges Due</span></td>
				<td><g:textField name="totalAmountOfChargesDueCurrency1" class="input_field_short" readonly="readonly"/></td>
				<td><g:textField name="totalAmountOfChargesDue1" class="input_field" readonly="readonly"/></td>
			</tr>
			<tr>
				<td />
				<td><g:textField name="totalAmountOfChargesDueCurrency2" class="input_field_short" readonly="readonly"/></td>
				<td><g:textField name="totalAmountOfChargesDue2" class="input_field" readonly="readonly"/></td>
			</tr>
			<tr>
				<td />
				<td><g:textField name="totalAmountOfChargesDueCurrency3" class="input_field_short" readonly="readonly"/></td>
				<td><g:textField name="totalAmountOfChargesDue3" class="input_field" readonly="readonly"/></td>
			</tr>
		</table>
	</div>
	<br />
	<g:if test="${ !serviceType?.equalsIgnoreCase('refund of other export charges') }">
		<table class="clear-float tabs_forms_table">
			<tr>
				<td width="160"><span class="field_label">Additional Charges Currency</span></td>
				<td><g:select name="additionalChargesCurrency" class="select_dropdown"	from="${['PHP', 'USD', 'WON', 'YEN']}" /></td>
			</tr>
		</table>
	</g:if>
</g:if>
<g:if test="${ !serviceType?.equalsIgnoreCase('refund of other export charges') }">
	<table class="clear-float tabs_forms_table">
		<tr>
			<td width="160"><span class="field_label">Amount of Payment-Charges <br/> (in Additional Charges Currency)</span></td>
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
		<g:if test="${ subType1 == 'Type1' }">
			<table class="grid_list_payment_edit"></table>
		</g:if>
			
		<g:if test="${ subType1 == 'Type2' }">
			<table id="grid_list_payment_details_for_charges_main"></table>
		</g:if>
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

<g:render template="../others/commons/popups/other_export_charges_payment_popup" />
<g:render template="../layouts/buttons_for_grid_wrapper"/>
