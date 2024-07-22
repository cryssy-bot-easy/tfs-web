<div id="update_cash_popup" class="popup_div_update_charges">
    <div class="popup_header">
        <a href="javascript:void(0)" id="close_update_cash_popup_x" class="popup_close">x</a>

        <h2 id="popup_header_partialAmountRefund1" class="popup_title partialAmountRefundTitle">Foreign Exchange Rate</h2>
    </div>

    <table class="charges_table partial_amount_table">
        <tr>
            <td><span class="field_label">Amount for Refund (in LC Currency)</span></td>
            <td><g:textField name="amountForRefundCurrency" class="input_field_short partialRefundInput" readonly="readonly" value="${currency}"/></td>
            <td><g:textField name="amountForRefund" class="input_field_right partialRefundInput" readonly="readonly"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Amount for Refund (in Refund Currency)</span></td>
            <td><g:textField name="amountForRefundInPhpCurrency" class="input_field_short partialRefundInput" readonly="readonly" value="PHP"/></td>
            <td><g:textField name="amountForRefundInPhp" class="input_field_right partialRefundInput" readonly="readonly"/></td>
        </tr>
    </table>

    <div class="grid_wrapper">
        <table class="foreign_exchange" id="forex_product_popup">
            <tr>
                <th class="rates">Rates</th>
                <th class="rate_description">Rate Description</th>
                <th class="pass_on_rate">Pass-on Rate</th>
                <th class="special_rate">Special Rate</th>
            </tr>
            <g:each in="${exchange}" var="temp" status="i" >
                <tr>
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="rates">${temp.rates}<g:hiddenField name="URR" value="${temp.rates}" /></td>
                    </g:if>
                    <g:else>
                        <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}" value="${temp.rates}" /></td>
                    </g:else>
                    <td>${temp.rate_description}</td>
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="urr">${temp.pass_on_rate.toString()}</td>
                        <td class="urr">${temp.special_rate.toString()}<g:hiddenField name="${temp.rates+'_urr'}" value="${temp.special_rate.toString()}"/></td>
                    </g:if>
                    <g:else>
                        <td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_charges'}" value="${temp.pass_on_rate}"/>
                            <g:hiddenField name="${temp.rates+'_pass_on_rate_charges'}" value="${temp.pass_on_rate}"/></td>
                        <td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_charges'}" value="${temp.special_rate}"/>
                            <g:hiddenField name="${temp.rates+'_special_rate_charges'}" value="${temp.special_rate}"/></td>
                    </g:else>
                </tr>
            </g:each>
        </table>
    </div>
    <br />
    <input type="button" id="recomputeNewCash" class="input_button_long" value="Recompute" />
    <br /><br />
    <ul class="popup_buttons_center">
        <li>
            <input type="button" class="input_button_alert confirmYes" value="Yes" id="applyUpdateProductAmount"/>
            <input type="button" class="input_button_negative_alert confirmNo" value="No" id="cancel_updateProductAmount"/>
        </li>
    </ul>
</div>
<div id="update_cash_popup_bg" class="popup_bg"> </div>