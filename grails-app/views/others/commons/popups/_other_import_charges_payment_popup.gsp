<g:javascript src="popups/bank_commission_utility.js"/>
<g:javascript src="popups/commitment_fee_utility.js"/>
<g:javascript src="popups/cilex_fee_utility.js"/>
<g:javascript src="popups/notarial_fee_utility.js"/>
<g:javascript src="popups/documentary_stamp_utility.js"/>
<g:javascript src="popups/cable_fee_utility.js"/>
<g:javascript src="popups/supplies_fee_utility.js"/>
<g:javascript src="popups/remittance_fee_utility.js"/>
<g:javascript src="popups/cancellation_fee_utility.js"/>
<g:javascript src="popups/advising_fee_utility.js"/>
<g:javascript src="popups/confirming_fee_utility.js"/>
<g:javascript src="popups/marine_insurance_utility.js"/>


<g:render template="../commons/popups/bank_commission_popup"/>
<g:render template="../commons/popups/commitment_fee_popup"/>
<g:render template="../commons/popups/cilex_popup"/>
<g:render template="../commons/popups/notarial_fee_popup"/>
<g:render template="../commons/popups/documentary_stamp_popup"/>
<g:render template="../commons/popups/cable_fee_popup"/>
<g:render template="../commons/popups/supplies_popup"/>
<g:render template="../commons/popups/remittance_fee_popup"/>
<g:render template="../commons/popups/cancellation_fee_popup"/>
<g:render template="../commons/popups/advising_fee_popup"/>
<g:render template="../commons/popups/confirming_fee_popup"/>
<g:render template="../commons/popups/marine_insurance_popup"/>


<div id="popup_updateChargesFxlcAmendment" class="popup_div">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_updateChargesFxlcAmendment1" class="popup_close">x</a>
		<h2 id="popup_header_updateChargesFxlcAmendment" class="popup_title">Update Charges</h2>
	</div>
	<br />
	<table id="charges_list">
		<tr>
			<td>
				<table class="charges_table">
					<tr class="oi-charges">
						<td><span class="field_label p_header">Charges<br />&#160;</span></td>
					</tr>
					<tr class="oi-bank-commission">
						<td><span class="">Bank Commission</span></td>
						<td>
                            %{--<g:textField name="bankCommissionCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="bankCommissionCurrency"></span>
                        </td>
						<td><g:textField name="bankCommission" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_bank_commission">edit</a></td>
						<td class="last_child editable"><g:textField name="bankCommission2" class="input_field_medium"/></td>
					</tr>
					<tr class="oi-commitment-fee">
						<td><span class="">Commitment Fee</span></td>
						<td>
                            %{--<g:textField name="commitmentFeeCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="commitmentFeeCurrency"></span>
                        </td>
						<td><g:textField name="commitmentFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_commitment_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="commitmentFee2" class="input_field_medium"/></td>
					</tr>
					<tr class="oi-cilex-fee">
						<td><span class="">CILEX</span></td>
						<td>
                            %{--<g:textField name="cilexCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="cilexCurrency"></span>
                        </td>
						<td><g:textField name="cilex" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_cilex_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="cilex2" class="input_field_medium"/></td>
					</tr>
					<tr class="oi-notarial-fee">
						<td><span class="field_label">Notarial Fee</span></td>
						<td>
                            %{--<g:textField name="notarialFeeCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="notarialFeeCurrency"></span>
                        </td>
						<td><g:textField name="notarialFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_notarial_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="notarialFee2" class="input_field_medium"/></td>
					</tr>
					<tr class="oi-documentary-stamp">
						<td><span class="field_label">Documentary Stamp</span></td>
						<td>
                            %{--<g:textField name="documentaryStampCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="documentaryStampCurrency"></span>
                        </td>
						<td><g:textField name="documentaryStamp" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_documentary_stamp">edit</a></td>
						<td class="last_child editable"><g:textField name="documentaryStamp2" class="input_field_medium"/></td>
					</tr>
					<tr class="oi-cable-fee">
						<td><span class="field_label">Cable Fee</span></td>
						<td>
                            %{--<g:textField name="cableFeeCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="cableFeeCurrency"></span>
                        </td>
						<td><g:textField name="cableFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_cable_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="cableFee2" class="input_field_medium"/></td>
					</tr>
					<tr class="oi-supplies-fee">
						<td><span class="field_label">Supplies</span></td>
						<td>
                            %{--<g:textField name="suppliesCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="suppliesCurrency"></span>
                        </td>
						<td><g:textField name="supplies" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_supplies_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="supplies2" class="input_field_medium" /></td>
					</tr>
					<tr class="oi-remittance-fee">
						<td><span class="field_label">Remittance Fee</span></td>
						<td>
                            %{--<g:textField name="remittanceFeeCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="remittanceFeeCurrency"></span>
                        </td>
						<td><g:textField name="remittanceFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_remittance_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="remittanceFee2" class="input_field_medium" /></td>
					</tr>
					<tr class="oi-cancellation-fee">
						<td><span class="field_label">Cancellation Fee</span></td>
						<td>
                            %{--<g:textField name="cancellationFeeCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="cancellationFeeCurrency"></span>
                        </td>
						<td><g:textField name="cancellationFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_cancellation_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="cancellationFee2" class="input_field_medium"/></td>
					</tr>
				</table>
			<td style="vertical-align:top;">
				<table class="charges_table">
					<tr class="oi-corres-charges">
						<td><span class="field_label p_header">Corres Charges<br />&#160;</span></td>
					</tr>
					<tr class="oi-advising-fee">
						<td><span class="field_label">Advising Fee</span></td>
						<td>
                            %{--<g:textField name="advisingFeeCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="advisingFeeCurrency"></span>
                        </td>
						<td><g:textField name="advisingFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_advising_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="advisingFee2" class="input_field_medium"/></td>
					</tr>
					<tr class="oi-confirming-fee">
						<td><span class="field_label">Confirming Fee</span></td>
						<td>
                            %{--<g:textField name="confirmingFeeCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="confirmingFeeCurrency"></span>
                        </td>
						<td><g:textField name="confirmingFee" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_confirming_fee">edit</a></td>
						<td class="last_child editable"><g:textField name="confirmingFee2" class="input_field_medium"/></td>
					</tr>	
					<tr class="oi-marine-insurance">
						<td><span class="field_label">Marine Insurance</span></td>
						<td>
                            %{--<g:textField name="marineInsuranceCurrency" class="input_field_short" readonly="readonly"/>--}%
                            <span class="charges_currency" id="marineInsuranceCurrency"></span>
                        </td>
						<td><g:textField name="marineInsurance" class="input_field" readonly="readonly"/></td>
						<td class="link"><a href="javascript:void(0)" id="edit_marine_insurance">edit</a></td>
						<td class="last_child editable"><g:textField name="marineInsurance2" class="input_field_medium"/></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<div class="grid_wrapper_full">
		<table class="grid_list_transaction_type"></table>
	</div>
	<br />
	<g:submitToRemote name="recomputeCharges" class="input_button_long" value="Recompute Charges"/>
	<br /><br />
	<input type="button" class="input_button_negative" id="close_updateChargesFxlcAmendment2" value="Cancel" />
	<input type="button" class="input_button" id="confirm_fxlc_amendment" value="OK" />
</div>
<div id="update_charges_fxlc_amendment_bg" class="popup_bg"> </div>