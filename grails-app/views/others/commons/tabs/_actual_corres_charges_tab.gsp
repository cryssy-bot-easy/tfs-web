<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="chargesPayment" />
<g:javascript src="utilities/ets/commons/charges/charges_tab_utility.js" />
<g:javascript src="utilities/payment/advanced_corres_charges/actual_corres_charges_tab_utility.js" />

<script type="text/javascript">
    var chargesString = "";
    var recomputeChargesPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';
</script>

<g:if test="${title.contains('(TSD Initiated)')}">
<table>
	<tr>
		<td></td>
	</tr>
</table>
	<span class="title_label">O/S Advance Corres Charges (in PHP)</span>
	<g:textField name="advanceCorresCharges" class="input_field" readonly="readonly"/>
</g:if>
<br/>
<span class="title_label">Actual Corres Charges Due</span>
<table class="tabs_form_table">
	<tr>
		<td class="label_width"><span class="input_label">Total Billing Amount -<br/>Billing Currency</span></td>
		<td>
            %{--<g:select name="billingCurrency" from="${['PHP','USD','EUR'] }" class="select_dropdown_medium"/>--}%
            <input class="tags_currency select2_dropdown bigdrop" name="billingCurrency" id="billingCurrency" />
        </td>
		<td><g:textField name="billingAmount" class="input_field"/></td>
	</tr>
</table>
<span class="title_label">Payment Details for Charges</span>
<table>
	<tr>
		<td class="label_width"><span class="input_label">Total Billing Amount -<br/>Settlement Currency</span></td>
		<td>
            %{--<g:select name="settlementCurrency" from="${['PHP','USD','EUR'] }" class="select_dropdown"/>--}%
            <input class="tags_currency select2_dropdown bigdrop" name="settlementCurrency" id="settlementCurrency" />
        </td>
	</tr>
</table>
<br/>

%{--<div class="grid_wrapper"> <%-- JQGRID --%>--}%
	%{--<table id="grid_list_forex"> </table>--}%
%{--</div>--}%

<div class="grid_wrapper"> %{--JQGRID--}%
    <table class="foreign_exchange">
        <tr>
            <th class="rates">Rates</th>
            <th class="rate_description">Rate Description</th>
            <th class="pass_on_rate">Pass-on Rate</th>
            <th class="special_rate">Special Rate</th>
        </tr>
    %{--<g:each in="${exchange}" var="temp" status="i" >--}%
    %{--<tr>--}%
    %{--<td>${temp.rates}<g:hiddenField name="${currency + temp.id}" value="${temp.id}" /></td>--}%
    %{--<td>${temp.rate_description}</td>--}%
    %{--<g:if test="${temp.rate_description.contains('URR')}">--}%
    %{--<td class="urr">${temp.pass_on_rate.toString()}</td>--}%
    %{--<td class="urr">${temp.special_rate.toString()}</td>--}%
    %{--</g:if>--}%
    %{--<g:else>--}%
    %{--<td><g:textField name="${'text_pass_on_rate'+temp.id}" class="${'pass_on_rate'+temp.id}" value="${temp.pass_on_rate}"/>--}%
    %{--<g:hiddenField name="${'pass_on_rate'+temp.id}" value="${temp.pass_on_rate}"/></td>--}%
    %{--<td><g:textField name="${'text_special_rate'+temp.id}" class="${'special_rate'+temp.id}" value="${temp.special_rate}"/>--}%
    %{--<g:hiddenField name="${'special_rate'+temp.id}" value="${temp.special_rate}"/></td>--}%
    %{--</g:else>--}%
    %{--</tr>--}%
    %{--</g:each>--}%
        <g:each in="${exchange}" var="temp" status="i" >
            <tr>
                <g:if test="${temp.rate_description.contains('URR')}">
                    <td>${temp.rates}</td>
                </g:if>
                <g:else>
                    <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}" value="${temp.rates}" /></td>
                </g:else>
                <td>${temp.rate_description}</td>
                <g:if test="${temp.rate_description.contains('URR')}">
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

<table class="popup_full_width">
    <tr>
   		<td class="label_width">Pass-on rates confirmed by:</td>
   		<td><g:textField name="passOnRateConfirmedBy" class="input_field"/></td>
   		<%-- if foreign --%>
   		<td><input type="button" class="input_button2" value="Recompute"/></td>
    </tr>
</table>
<br/><br/>
	<table class="charges_table">
		<tr>
			<td class="title_label">Total Billing Amount (in PHP)</td>
			<td><g:textField class="input_field_short" name="totalBillingCurrency" value="PHP" readonly="readonly"/></td>
			<td><g:textField class="input_field_right no_border" name="totalBillingCurrency" readonly="readonly"/></td>
		</tr>
		<tr>
			<td class="title_label">Net Billing Amount (in PHP)</td>
			<td><g:textField class="input_field_short" name="netBillingCurrencyPhp" value="PHP" readonly="readonly"/></td>
			<td><g:textField class="input_field_right no_border" name="netBillingAmountPhp" readonly="readonly"/></td>
		</tr>
		<tr>
			<td class="title_label">Net Billing Amount (in Settlement Currency)</td>
			<td><g:textField class="input_field_short chargesCurrency" name="netBillingCurrencySettlement" readonly="readonly"/></td>
			<td><g:textField class="input_field_right no_border" name="netBillingAmountSettlement" readonly="readonly"/></td>
		</tr>
	</table>

<br/>
<span class="title_label">Charges Payment</span>
<table>
	<tr>
		<td width="210px">Amount of Payment - Net Billing Amount<br/>(in Settlement Currency)</td>
		<td><g:textField name="amountOfPaymentCharges" class="input_field_right numericCurrency" /></td>
	</tr>
</table>
<span class="buttons">
	%{--<g:submitToRemote id="popup_btn_mode_of_payment_charges" class="input_button_long" value="Add Settlement Charges"/>--}%
    <input type="button" id="popup_btn_mode_of_payment_charges" class="input_button_long" value="Add Settlement Charges" />
</span>
<br/>
<span class="title_label">Payment Summary for Charges</span>
<div class="grid_wrapper">
	<g:if test="${referenceType.equalsIgnoreCase('ETS')}">
		<table id="grid_list_charges_payment"></table>
	</g:if>
	<g:else>
		<table class="grid_list_payment_edit"></table>
	</g:else>
</div>
<br/>
<table>
	<tr>
		<td>Total Amount of Payment - Net Billing Amount (in Settlement Currency) </td>
		<td><g:textField name="totalAmountPayment" class="input_field_right" readonly="readonly"/></td>
	</tr>
	<tr>
		<td>Excess Amount (in Settlement Currency) </td>
		<td><g:textField name="excessAmount" class="input_field_right" readonly="readonly"/></td>
	</tr>
</table>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper"/>

<script>
    $(document).ready(function() {
        $("#billingCurrency").select2('data',{id: '${billingCurrency}'});
        $("#settlementCurrency").select2('data',{id: '${settlementCurrency}'});
        loadForeignExchangeRates();
        onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
    });
</script>