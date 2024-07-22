<g:javascript src="popups/bank_commission_utility.js"/>
<g:javascript src="popups/cilex_fee_utility.js"/>
<g:javascript src="popups/documentary_stamp_utility.js"/>
<g:javascript src="popups/cable_fee_utility.js"/>
<g:javascript src="popups/remittance_fee_utility.js"/>

<g:render template="../commons/popups/bank_commission_popup"/>
<g:render template="../commons/popups/cilex_popup"/>
<g:render template="../commons/popups/documentary_stamp_popup"/>
<g:render template="../commons/popups/cable_fee_popup"/>
<g:render template="../commons/popups/remittance_fee_popup"/>

<g:javascript src="grids/other_exports_foreign_exchange_jqgrid.js"/>

<div id="popup_other_export_charges_payment" class="popup_div">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_other_export_charges_payment" class="popup_close">x</a>
		<h2 id="popup_header_other_export_charges_payment" class="popup_title">Update Charges</h2>
	</div>
	<br />
	<table id="charges_list">
		<tr>
			<td>
				<table class="charges_table">
					<tr class="oe-charges">
						<td><span class="field_label p_header">Charges<br />&#160;</span></td>
					</tr>
					<tr class="oe-export-fxlc-advising-fee">
						<td><span class="">Export - FXLC Advising Fee</span></td>
						<td><g:textField name="exportFxlcAdvisingFeeCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="exportFxlcAdvisingFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_export_fxlc_advising_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="exportFxlcAdvisingFee2" class="input_field_medium"/></td>
					</tr>
					<tr class="oe-bank-commission">
						<td><span class="">Bank Commission</span></td>
						<td><g:textField name="bankCommissionCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="bankCommission" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_bank_commission">edit</a></td>
						<td class="last_child editable"><g:textField name="bankCommission2" class="input_field_medium"/></td>
					</tr>
					<tr class="oe-cilex-fee">
						<td><span class="">CILEX</span></td>
						<td><g:textField name="cilexCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="cilex" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_cilex_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="cilex2" class="input_field_medium"/></td>
					</tr>
					<tr class="oe-documentary-stamp">
						<td><span class="field_label">Documentary Stamp</span></td>
						<td><g:textField name="documentaryStampCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="documentaryStamp" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_documentary_stamp">edit</a></td>
						<td class="last_child editable"><g:textField name="documentaryStamp2" class="input_field_medium"/></td>
					</tr>
					<tr class="oe-cable-fee">
						<td><span class="field_label">Cable Fee</span></td>
						<td><g:textField name="cableFeeCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="cableFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_cable_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="cableFee2" class="input_field_medium"/></td>
					</tr>
					<tr class="oe-postage">
						<td><span class="field_label">Postage</span></td>
						<td><g:textField name="postageCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="postage" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_postage">edit</a></td>
						<td class="last_child editable"><g:textField name="postage2" class="input_field_medium" /></td>
					</tr>
					<tr class="oe-remittance-fee">
						<td><span class="field_label">Remittance Fee</span></td>
						<td><g:textField name="remittanceFeeCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="remittanceFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_remittance_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="remittanceFee2" class="input_field_medium" /></td>
					</tr>
					<tr class="oe-advance-corres-charges">
						<td><span class="field_label">Advance Corres Charges</span></td>
						<td><g:textField name="advanceCorresChargesCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="advanceCorresCharges" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_advance_corres_charges">edit</a></td>
						<td class="last_child editable"><g:textField name="advanceCorresCharges2" class="input_field_medium" /></td>
					</tr>
					<tr class="oe-advance-interest">
						<td><span class="field_label">Advance Interest</span></td>
						<td><g:textField name="advanceInterestCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="advanceInterest" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_advance_interest">edit</a></td>
						<td class="last_child editable"><g:textField name="advanceInterest2" class="input_field_medium" /></td>
					</tr>
				</table>
			<td style="vertical-align:top;">
				<table class="charges_table">
					<tr class="oe-client-charges">
						<td><span class="field_label p_header">Charges Due from Client<br />&#160;</span></td>
					</tr>
					<tr class="oe-other-local-bank-charges">
						<td><span class="field_label">Other <span class="export-title"></span> Charges</span></td>
						<td><g:textField name="otherLocalBankChargesCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="otherLocalBankCharges" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_other_local_bank_charges">edit</a></td>
						<td class="last_child editable"><g:textField name="otherLocalBankCharges2" class="input_field_medium" /></td>
					</tr>
					<tr class="oe-additional-corres-charges">
						<td><span class="field_label">Additional Corres Changes</span></td>
						<td><g:textField name="additionalCorresChargesCurrency" class="input_field_short" readonly="readonly"/></td>
						<td><g:textField name="additionalCorresCharges" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_additional_corres_charges">edit</a></td>
						<td class="last_child editable"><g:textField name="additionalCorresCharges2" class="input_field_medium" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<div class="grid_wrapper_full">
		<table id="grid_list_transaction_type"></table>
	</div>
	<br />
	<g:submitToRemote name="recomputeCharges" class="input_button_long" value="Recompute Charges"/>
	<br /><br />
	<input type="button" class="input_button_negative" id="close_other_export_charges_payment2" value="Cancel" />
	<input type="button" class="input_button" id="confirm_other_export_charges_payment" value="OK" />
</div>
<div id="popup_bg_other_export_charges_payment" class="popup_bg"> </div>