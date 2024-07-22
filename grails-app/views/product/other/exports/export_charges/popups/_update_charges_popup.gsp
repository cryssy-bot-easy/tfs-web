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
<g:javascript src="popups/corres_export_charge_utility.js" />


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
<g:render template="../commons/popups/corres_export_charge_popup" />


<div id="update_charges_popup" class="popup_div_update_charges">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_update_charges_popup_x" class="popup_close">x</a>
		<h2 id="popup_header_updateChargesFxlcAmendment" class="popup_title">Update Charges</h2>
	</div>
	<br />
	<table id="charges_list">
		<tr>
			<td>
				<table class="charges_table" id="basic_charges_popup">
				</table>
            </td>
			<td style="vertical-align:top;">
				<table class="charges_table" id="corres_charge_popup">
				</table>
			</td>
		</tr>
	</table>
	<br />

    <div class="grid_wrapper">
        <table class="foreign_exchange" id="forex_update_charges_popup">
        </table>
    </div>

	<br />
    %{--<input type="button" id="recomputeNewCharges" class="input_button_long" value="Recompute Charges" />--}%
	<br /><br />
    <ul class="popup_buttons_center">
        <li>
            <input type="button" class="input_button_alert confirmYes" value="Yes" id="applyUpdateCharges"/>
            <input type="button" class="input_button_negative_alert confirmNo" value="No" id="cancel_updateCharges"/>
        </li>
    </ul>
</div>
<div id="update_charges_popup_bg" class="popup_bg"> </div>
