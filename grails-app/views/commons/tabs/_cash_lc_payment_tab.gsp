<g:javascript src="grids/cash_lc_payment_jqgrid.js" />
<g:javascript src="utilities/ets/commons/cash_lc_payment_tab_utility.js" />
<g:javascript src="utilities/validation/validate_payment_tab.js" />


<script type="text/javascript">
	var convertRatesUrl = '${g.createLink(controller:'foreignExchange', action:'convertCashRates')}';
    var productChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';
    productChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    productChargeUrl += "&referenceType=" + $("#referenceType").val();

    productChargeUrl += "&serviceType="+$("#serviceType").val();
    productChargeUrl += "&documentType="+$("#documentType").val();
    productChargeUrl += "&documentClass="+$("#documentClass").val();
    productChargeUrl += "&form=product";

    var windowed = ${windowed ?: false};

    var recomputeCashPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';
</script>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="lcPayment" />

<g:hiddenField name="savedCurrency" value="${currency ?: originalCurrency ?: "PHP"}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="reverseDE" value="${reverseDE}"/>
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:hiddenField name="setupProductPayment" class="required" value="${setupProductPayment}"/>

<g:if test="${serviceType?.equalsIgnoreCase('Collection') && documentClass?.equalsIgnoreCase('MD')}">
    <g:render template="../commons/tabs/md_collection_payment_details_tab" />
</g:if>
<g:elseif test="${serviceType?.equalsIgnoreCase('Application') && documentClass?.equalsIgnoreCase('MD')}">

</g:elseif>
%{--<g:elseif test="${(serviceType?.equalsIgnoreCase("Negotiation") && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY"))) || ((serviceType?.equalsIgnoreCase("UA Loan Settlement") || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY")))}">--}%
    %{--<g:render template="../commons/tabs/proceeds_details_payment_tab" />--}%
%{--</g:elseif>--}%
<g:else>
<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase("FOREIGN") }">
	<span class="title_label">Payment Details for Negotiation</span>
</g:if>
<%--<g:if test="${serviceType?.equalsIgnoreCase('UA Loan Settlement') }">--%>
<%--	<g:if test="${ documentType?.equalsIgnoreCase('foreign') }" >--%>
<%--		<span class="title_label">Payment Details for UA Loan Settlement</span>--%>
<%--	</g:if>--%>
<%--	<g:if test="${ documentType?.equalsIgnoreCase('domestic') }">--%>
<%--		<span class="title_label">Payment Details for DUA Loan Settlement</span>--%>
<%--	</g:if>--%>
<%--</g:if>--%>

<g:if test="${!serviceType?.equalsIgnoreCase('Negotiation') && !(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT"))}">
	<g:if test="${documentClass in ['DA','DP','OA','DR']}">
	<span class="title_label">Settlement Details</span>
	</g:if>
	<table class="charges_table">
		<tr>
			<td width="230"><span class="field_label"> <g:if test="${documentClass in ['DA','DP','OA','DR']}">Negotiation</g:if><g:else>Cash LC</g:else> Currency/Amount</span></td>
			<td>
				<span class="charges_currency" id="totalAmountDueLcCurrency">${currency}</span>
			</td>
			<td>
                %{--<g:textField class="input_field_right numericCurrency" value="${totalAmountDueLc ?: (!documentClass?.equalsIgnoreCase('LC')) ? productAmount : cashAmount ?: amount}" name="totalAmountDueLc" readonly="readonly"/>--}%
                %{--<input type="hidden" value="${(totalAmountDueLc != "" && totalAmountDueLc != null) ? totalAmountDueLc : (amount != "" && amount != null) ? amount : negotiationAmount}" name="totalAmountDueLc" id="totalAmountDueLc" readonly="readonly"/>--}%
                %{--<input type="text" class="input_field_right numericCurrency" value="${(totalAmountDueLc != "" && totalAmountDueLc != null) ? totalAmountDueLc : (amount != "" && amount != null) ? amount : negotiationAmount}" readonly="readonly"/>--}%
                <g:hiddenField
						value="${(totalAmountDueLc != "" &&
                    totalAmountDueLc != null) ?
                    totalAmountDueLc :
                    (documentClass in ['DA', 'DP', 'OA', 'DR'] &&
                    productAmount != "" &&
                    productAmount != null) ?
                    productAmount :

                    ("LC".equals(documentClass) && ("ADJUSTMENT".equals(serviceType?.toUpperCase()) || "AMENDMENT".equals(serviceType?.toUpperCase())) && cashAmount != "") ?
                    cashAmount :
                    (amount != "" && amount != null) ?
                    amount :
                    negotiationAmount}"
						name="totalAmountDueLc" id="totalAmountDueLc" readonly="readonly" />

					<input type="text" id="totalAmountDueLcDisplay"
					name="totalAmountDueLcDisplay"
					class="input_field_right numericCurrency"
					value="${(totalAmountDueLc != "" &&
                    totalAmountDueLc != null) ?
                totalAmountDueLc :
                (documentClass in ['DA', 'DP', 'OA', 'DR'] &&
                        productAmount != "" &&
                        productAmount != null) ?
                    productAmount :

                    ("LC".equals(documentClass) && ("ADJUSTMENT".equals(serviceType?.toUpperCase()) || "AMENDMENT".equals(serviceType?.toUpperCase())) && cashAmount != "") ?
                        cashAmount :
                        (amount != "" && amount != null) ?
                            amount :
                            negotiationAmount }"
					readonly="readonly" />
				</td>
		</tr>
		<tr>
			<td><span class="field_label"> <g:if test="${documentClass in ['DA','DP','OA','DR']}">Negotiation</g:if><g:else>Cash LC</g:else> Currency/Amount Balance</span></td>
			<td>
				<span class="charges_currency" id="remainingBalancLcCurrency">${currency}</span>
			</td>
			<td>
<%--                <g:textField class="input_field_right" value="${remainingBalanceLc}" name="remainingBalanceLc" readonly="readonly"/>--%>
                <g:textField class="input_field_right numericCurrency" value="${remainingBalanceLc ?: cashAmount ?: negotiationAmount ?: amount}" name="remainingBalanceLc" id="remainingBalanceLc" readonly="readonly"/>
                <g:hiddenField name="remainingBalanceLcDisplay" class="input_field_right" value="${(totalAmountDueLc != "" && totalAmountDueLc != null) ? totalAmountDueLc : cashAmount ?: (amount != "" && amount != null) ? amount : negotiationAmount}" readonly="readonly" />
            </td>
		</tr>
	</table>
</g:if>
<g:else>
    <table class="charges_table">
        <tr>
            <td width="230">
                %{--<g:if test="${(serviceType?.equalsIgnoreCase("Negotiation") && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY"))) || ((serviceType?.equalsIgnoreCase("UA Loan Settlement") || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY")))}"><span class="field_label">Proceeds Amount</span></g:if>--}%
                %{--<g:else>--}%
                    <span class="field_label">Amount Due (in ${serviceType?.equalsIgnoreCase("Negotiation") ? 'Nego' : (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) ? (documentType?.equalsIgnoreCase("DOMESTIC") ? 'D' : '') + 'UA Loan' : ''} Currency)</span>
                %{--</g:else>--}%
            </td>
            <td>
                <span class="charges_currency" id="totalAmountDueLcCurrency">${currency ?: negotiationCurrency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${totalAmountDueLc ?: negotiationAmount ?: amount}" name="totalAmountDueLc" readonly="readonly"/>
                <input type="hidden" id="totalAmountDueLcDisplay" name="totalAmountDueLcDisplay" class="input_field_right numericCurrency" value="${(totalAmountDueLc != "" && totalAmountDueLc != null) ? totalAmountDueLc : (overdrawnAmount != "" && overdrawnAmount != null) ? overdrawnAmount : amount}" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td>
                %{--<g:if test="${(serviceType?.equalsIgnoreCase("Negotiation") && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY"))) || ((serviceType?.equalsIgnoreCase("UA Loan Settlement") || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY")))}"><span class="field_label">Remaining Balance</span></g:if>--}%
                %{--<g:else>--}%
                    <span class="field_label">Remaining Balance (in ${serviceType?.equalsIgnoreCase("Negotiation") ? 'Nego' : (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) ? (documentType?.equalsIgnoreCase("DOMESTIC") ? 'D' : '') + 'UA Loan' : ''} Currency)</span>
                %{--</g:else>--}%
            </td>
            <td>
                <span class="charges_currency" id="remainingBalancLcCurrency">${currency ?: negotiationCurrency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${remainingBalanceLc ?: negotiationAmount}" name="remainingBalanceLc" readonly="readonly"/>
                <input type="hidden" id="remainingBalanceLcDisplay" name="remainingBalanceLcDisplay" class="input_field_right numericCurrency" value="${remainingBalanceLc ?: negotiationAmount}" readonly="readonly"/>
                %{--<input type="text" class="input_field_right numericCurrency" value="${remainingBalanceLc ?: negotiationAmount}" id="remainingBalanceLcDisplay" name="remainingBalanceLcDisplay" readonly="readonly"/>--}%
                %{--<script type="text/javascript">--}%
                    %{--$("#remainingBalanceLc").change(function() {--}%
                        %{--$("#remainingBalanceLcDisplay").val($("#remainingBalanceLc").val())--}%
                    %{--});--}%
                %{--</script>--}%
            </td>
        </tr>
        %{--<g:if test="${(serviceType?.equalsIgnoreCase("Negotiation") && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY"))) || ((serviceType?.equalsIgnoreCase("UA Loan Settlement") || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY")))}">--}%
            %{--<tr>--}%
                %{--<td>--}%
                    %{--<span class="field_label">Amount of Payment</span>--}%
                %{--</td>--}%
                %{--<td>--}%
                    %{--<span class="charges_currency" id="settlementCurrencyLabel">${negotiationCurrency}</span>--}%
                    %{--<g:hiddenField name="settlementCurrencyLc" value="${negotiationCurrency}" />--}%
                %{--</td>--}%
                %{--<td class="editable">--}%
                    %{--<g:textField class="input_field_right numericCurrency" value="" name="cashAmountInSettlement" />--}%
                %{--</td>--}%
            %{--</tr>--}%
        %{--</g:if>--}%
    </table>
</g:else>
<br />
%{--<g:if test="${!((serviceType?.equalsIgnoreCase("Negotiation") && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY"))) || ((serviceType?.equalsIgnoreCase("UA Loan Settlement") || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && documentType?.equalsIgnoreCase("DOMESTIC") && (referenceType.equalsIgnoreCase("ETS") || referenceType.equalsIgnoreCase("DATA_ENTRY"))))}">--}%
<table>
	<tr>
		<td width="235"><span class="field_label">&nbsp;Settlement Currency <br /><g:if test="${documentClass in ['DA','DP','OA','DR']}"> - Negotiation Amount</g:if><g:elseif test="${!serviceType?.equalsIgnoreCase('Negotiation') && !(serviceType?.equalsIgnoreCase('ua loan settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT"))}"> - Cash ${documentClass}</g:elseif></span></td>
		<td>
			<%-- Auto Complete --%>
            <g:if test="${documentClass.equals("DP") && documentType.equals("DOMESTIC")}">
                %{--<input class="tags_currency select2_dropdown bigdrop" name="settlementCurrencyLc" id="settlementCurrencyLc" />--}%
                <input type="text" name="settlementCurrencyLc" id="settlementCurrencyLc" class="input_field" readonly="readonly" value="${currency}" currencyType="a" />
            </g:if>
            <g:elseif test="${documentClass.equals("LC") && serviceType?.equalsIgnoreCase("NEGOTIATION") && documentSubType1?.equalsIgnoreCase("REGULAR")  && documentSubType2?.equalsIgnoreCase("USANCE")}">
				<input type="text" name="settlementCurrencyLc" id="settlementCurrencyLc" class="input_field" readonly="readonly" value="${currency?:negotiationCurrency}" currencyType="b" />
            </g:elseif>
            <g:else>
                <input class="tags_currency select2_dropdown bigdrop" name="settlementCurrencyLc" id="settlementCurrencyLc" />
            </g:else>
		</td>
	</tr>
</table>
		<g:if test="${currency ?: negotiationCurrency}">
		<div class="grid_wrapper"> %{--JQGRID--}%
		<table class="foreign_exchange" id="forex_product">
			<tr>
				<th class="rates">Rates</th>
				<th class="rate_description">Rate Description</th>
				<th class="pass_on_rate">Pass-on Rate</th>
				<th class="special_rate">Special Rate</th>
			</tr>
			<g:each in="${exchange}" var="temp" status="i" >
				<tr>
                    <g:hiddenField name="RATE_NAME_${i}" value="${temp.rates}"/>
                    <g:hiddenField name="RATE_DESC_${i}" value="${temp.rate_description}"/>
					<g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="rates">${temp.rates}</td>
                    </g:if>
                    <g:elseif test="${temp.rate_description.contains('BUYING')}">
                        <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}_buying" value="${temp.rates}" /></td>
                    </g:elseif>
                    <g:else>
					   <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}" value="${temp.rates}" /></td>
                    </g:else>
					<td>${temp.rate_description_lbp}</td>
					<g:if test="${temp.rate_description.contains('BOOKING')}">
    					<td class="urr">
                            <g:textField name="${temp.rates+'_text_pass_on_rate_urr'}" id="${temp.rates+'_text_pass_on_rate_urr'}" class="${temp.rates+'_pass_on_rate'} numericRates product_rates" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}" />
                             <g:hiddenField name="${temp.rates+'_pass_on_rate_cash_urr'}" id="${temp.rates+'_pass_on_rate_cash_urr'}" class="${temp.rates+'_pass_on_rate'}" value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td>
                        </td>
                        <td class="urr">
                            <g:textField name="${temp.rates+'_text_special_rate_urr'}" id="${temp.rates+'_text_special_rate_urr'}" class="${temp.rates+'_special_rate'} numericRates product_rates" value="${temp.text_special_rate ?: temp.special_rate}" />
                            <g:hiddenField name="${temp.rates+'_special_rate_cash_urr'}" id="${temp.rates+'_special_rate_cash_urr'}" class="${temp.rates+'_special_rate'} " value="${temp.special_rate_cash ?: temp.special_rate}"/>
                            <g:hiddenField name="${temp.rates+'_urr'}" class="${temp.rates+'_urr'}" value="${temp.special_rate_cash ?: temp.special_rate}"/>
                        </td>
                    </g:if>
                    <g:elseif test="${temp.rate_description.contains('BUYING')}">
                        <td><g:textField name="${temp.rates+'_text_pass_on_rate_buying'}" id="${temp.rates+'_text_pass_on_rate_buying'}" class="${temp.rates+'_pass_on_rate'} numericRates product_rates" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}" />
                            <g:hiddenField name="${temp.rates+'_pass_on_rate_cash_buying'}" id="${temp.rates+'_pass_on_rate_cash_buying'}" class="${temp.rates+'_pass_on_rate'} " value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td>
                        <td><g:textField name="${temp.rates+'_text_special_rate_buying'}" id="${temp.rates+'_text_special_rate_buying'}" class="${temp.rates+'_special_rate'} numericRates product_rates" value="${temp.text_special_rate ?: temp.special_rate}" />
                            <g:hiddenField name="${temp.rates+'_special_rate_cash_buying'}" id="${temp.rates+'_special_rate_cash_buying'}" class="${temp.rates+'_special_rate'} " value="${temp.special_rate_cash ?: temp.special_rate}"/></td>
                    </g:elseif>
                    <g:else>
					<td><g:textField name="${temp.rates+'_text_pass_on_rate'}" id="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate'} numericRates product_rates" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}" />
					<g:hiddenField name="${temp.rates+'_pass_on_rate_cash'}" id="${temp.rates+'_pass_on_rate_cash'}" class="${temp.rates+'_pass_on_rate'} " value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td>
					<td><g:textField name="${temp.rates+'_text_special_rate'}" id="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate'} numericRates product_rates" value="${temp.text_special_rate ?: temp.special_rate}" />
					<g:hiddenField name="${temp.rates+'_special_rate_cash'}" id="${temp.rates+'_special_rate_cash'}" class="${temp.rates+'_special_rate'} " value="${temp.special_rate_cash ?: temp.special_rate}"/></td>
					</g:else>
				</tr>
			</g:each>
		</table>
		</div>
		</g:if>
		<table class="popup_full_width">
		    <tr>
		    		<td width="235" class="field_label"> Pass-on rates confirmed by: <span class="passOnRatesConfirmedByAsterisk">*</span></td>
		    		<td><g:textField name="passOnRateConfirmedByCash" value="${passOnRateConfirmedByCharges ?: passOnRateConfirmedByCash}" data-orig="${passOnRateConfirmedByCharges ?: passOnRateConfirmedByCash}" class="input_field"/></td>
	
		    	%{--if foreign--}%
					<td>
                        <input type="button" class="input_button_long actionWidget" value="Recompute Charge" name="recomputeChargeBtnCashLc" id="recomputeChargeBtnCashLc"/>
                    </td>
		    </tr>
		</table>
<br />
<table class="charges_table">
	<tr>
		<td width="230">
			<g:if test="${!serviceType?.equalsIgnoreCase('Negotiation') && !(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT"))}">
				<g:if test="${documentClass in ['DA','DP','OA','DR']}">
				<span class="field_label" id="paymentDescription"> Amount of Negotiation Payment <br />(in Settlement currency)</span>
				</g:if>
				<g:else>
				<span class="field_label" id="paymentDescription"> Amount of Cash ${documentClass} Payment <br />(in Settlement currency)</span>
				</g:else>
			</g:if>
			<g:if test="${serviceType?.equalsIgnoreCase('Negotiation')}">
				<span class="field_label"> Amount of Negotiation Payment <br />(in Settlement Currency) </span>
			</g:if>
			<g:if test="${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")}">
				<g:if test="${ documentType?.equalsIgnoreCase('foreign') }" >
					<span class="field_label"> Amount of UA Loan Payment <br />(in Settlement Currency) </span>
				</g:if>
				<g:if test="${ documentType?.equalsIgnoreCase('domestic') }" >
					<span class="field_label"> Amount of Payment <br />- DMLC-DUA Loan Amount <br />(in Settlement Currency) </span>
				</g:if>
			</g:if>
		</td>
		<td>
			
			<span class="charges_currency" id="cashAmountInSettlementCurrency" ></span>

		</td>
		<td class="editable"><g:textField class="input_field_right numericCurrency" name="cashAmountInSettlement"/></td>
	</tr>
	<tr>
		<td width="230"> 
			<g:if test="${!serviceType?.equalsIgnoreCase('Negotiation') && !(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) }">
				<g:if test="${documentClass in ['DA','DP','OA','DR']}">
				<span class="field_label"> Amount of Negotiation Payment <br />(in Negotiation currency)</span>
				</g:if>
				<g:else>
				<span class="field_label"> Amount of Cash ${documentClass} Payment <br />(in ${documentClass} currency)</span>
				</g:else>
			</g:if>
			<g:if test="${serviceType?.equalsIgnoreCase('Negotiation')}">
				<span class="field_label"> Amount of Negotiation Payment <br />(in Negotiation Currency) </span>
			</g:if>
			<g:if test="${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')}">
				<g:if test="${ documentType?.equalsIgnoreCase('foreign') }" >
					<span class="field_label"> Amount of UA Loan Payment <br />(in UA Loan Currency) </span>
				</g:if>
				<g:if test="${ documentType?.equalsIgnoreCase('domestic') }" >
					<span class="field_label"> Amount of Payment <br />- DMLC-DUA Loan Amount <br />(in DMLC-DUA Loan Currency) </span>
				</g:if>
			</g:if>
		</td>
		<td>
			<span class="charges_currency" id="cashAmountInLcCurrency">${currency ?: negotiationCurrency}</span>
		</td>
		<td class="editable"><g:textField class="input_field_right numericCurrency" name="cashAmountInLc"/></td>
	</tr>
</table>
%{--</g:if>--}%
<br/>
<input type="button" class="input_button_long actionWidget" id="popup_btn_mode_of_payment_cash" value="Add Settlement" />
<br /><br/>


<g:if test = "${!serviceType?.equalsIgnoreCase('Negotiation') && !(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT"))}">
	<span class="title_label">Payment Summary for <g:if test="${documentClass in ['DA','DP','OA','DR']}">${documentClass}</g:if><g:else>Cash LC</g:else></span>
</g:if>

<g:if test = "${serviceType?.equalsIgnoreCase('Negotiation') }">
	<span class="title_label">Payment Summary for Negotiation Payment</span>
</g:if>
<g:if test = "${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")}">
	<span class="title_label">Payment Summary for UA Loan Settlement</span>
</g:if>
<div class="grid_wrapper fix"> <%-- JQGRID --%>
	  <table id="grid_list_cash_payment_summary"> </table>
	  <div id="grid_pager_cash_payment_summary"></div>
	  <g:hiddenField name="documentPaymentSummary" value="" />
</div>
<table class="charges_payment_table">
	<tr>
		<g:if test = "${!serviceType?.equalsIgnoreCase('Negotiation') && !(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) }">
			<g:if test="${documentClass in ['DA','DP','OA','DR']}">
			<td width="235"><span class="field_label"> Total Amount of Payment <br />(in Negotiation currency) </span></td>
			</g:if>
			<g:else>
			<td width="235"><span class="field_label"> Total Amount of Payment - Cash <br />(in ${documentClass} currency) </span></td>
			</g:else>
		</g:if>
		<g:if test = "${serviceType?.equalsIgnoreCase('Negotiation') }">
			<td width="240">
                <g:if test="${documentType?.equalsIgnoreCase("DOMESTIC") && documentSubType1?.equalsIgnoreCase("REGULAR") && documentClass?.equalsIgnoreCase("LC")}">
                    <span class="field_label">Total Amount of Payment</span>
                </g:if>
                <g:else>
                    <span class="field_label">Total Amount of Payment - Negotiation Amount <br />(in Negotiation Currency)</span>
                </g:else>
            </td>
		</g:if>
		<g:if test = "${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT") }">
			<g:if test="${ documentType?.equalsIgnoreCase('foreign') }" >
				<td width="235"><span class="field_label">Total Amount of Payment - UA Loan Amount <br />(in UA Loan Currency)</span></td>
			</g:if>
			<g:if test="${ documentType?.equalsIgnoreCase('domestic') }" >
				<td width="235"><span class="field_label">Total Amount of Payment <br />- DMLC-DUA Loan Amount <br />(in DMLC-DUA Loan Currency)</span></td>
			</g:if>
		</g:if>
		<td><g:textField class="input_field_right" value="" name="totalAmountOfPaymentLc" readonly="readonly"/></td>
	</tr>
    <g:if test="${!(documentType?.equalsIgnoreCase("DOMESTIC") && documentSubType1?.equalsIgnoreCase("REGULAR") && documentClass?.equalsIgnoreCase("LC"))}">
	<tr>
		<g:if test = "${!serviceType?.equalsIgnoreCase('Negotiation') && !(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) }">
			<g:if test="${documentClass in ['DA','DP','OA','DR']}">
			<td width="180"><span class="field_label"> Excess Amount <br />(in Negotiation currency) </span></td>
			</g:if>
			<g:else>
			<td width="180"><span class="field_label"> Excess Amount - Cash <br />(in ${documentClass} currency) </span></td>
			</g:else>
		</g:if>
		<g:if test = "${serviceType?.equalsIgnoreCase('Negotiation') }">
			<td width="235"><span class="field_label">Excess Amount - Negotiation Amount <br />(in Negotiation Currency)</span></td>
		</g:if>
		<g:if test = "${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")}">
			<g:if test="${ documentType?.equalsIgnoreCase('foreign') }" >
				<td width="235"><span class="field_label">Excess Amount - UA Loan Amount <br />(in UA Loan Currency)</span></td>
			</g:if>
			<g:if test="${ documentType?.equalsIgnoreCase('domestic') }" >
				<td width="235"><span class="field_label">Excess Amount <br />- DMLC-DUA Loan Amount <br />(in DMLC-DUA Loan Currency)</span></td>
			</g:if>
		</g:if>
		<td><g:textField class="input_field_right" value="" name="excessAmountLc" readonly="readonly"/></td>
	</tr>
    </g:if>
    <g:if test="${serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentClass?.equalsIgnoreCase('LC') && documentType?.equalsIgnoreCase('DOMESTIC')}">
    <tr>
		<td width="235"><span class="field_label">Excess Amount <br />- DMLC-DUA Loan Amount <br />(in DMLC-DUA Loan Currency)</span></td>
		<td><g:textField class="input_field_right" value="" name="excessAmountLc" readonly="readonly"/></td>
	</tr>
	</g:if>
</table>
<br/>

</g:else>

<g:if test="${!(referenceType.equalsIgnoreCase('ETS') && session.userrole.id.contains('TSD')) && !(referenceType.equalsIgnoreCase("PAYMENT")) && !(referenceType.equalsIgnoreCase("DATA_ENTRY") && documentClass?.equalsIgnoreCase("MD"))}">
    <g:render template="../layouts/buttons_for_grid_wrapper" />
</g:if>

<script>
    $(document).ready(function() {
//        if (!(serviceType == "Negotiation" && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY")) || ((serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT") && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY"))) {
//            $("#settlementCurrencyLc").setCurrencyDropdown($(this).attr("id"));
        if (!(documentClass == "DP" && documentType == "DOMESTIC")
			&& !(documentClass == "LC" && $("#serviceType").val().toUpperCase() == "NEGOTIATION" && $("#documentSubType1").val().toUpperCase() == "REGULAR" && $("#documentSubType2").val().toUpperCase() == "USANCE")) {
            if(documentType == "DOMESTIC") {
            	$("#settlementCurrencyLc").setDomesticProductCurrencyDropdown($("#totalAmountDueLcCurrency").text()).select2('data',{id: '${settlementCurrencyLc}'});
            	$("#settlementCurrencyLc").val("${settlementCurrencyLc}");
            } else {
            	$("#settlementCurrencyLc").setSettlementCurrencyDropdown($(this).attr("id"));
            }
        }
//            hideUnrelatedExchangeRates();
            onSettlementCurrencyCashChange();
//            loadRelatedExchangeRates();
            if ($.isFunction(window.checkForOtherCurrency)) {
                checkForOtherCurrency();
            }
//        }

        $("#forex_product :input").change(function(event) {
            var className = $("#"+event.target.id).attr("class");
            $("."+className).val(event.target.value);
        });
        
        if($("#remainingBalanceLc").length == 0) $("#setupProductPayment").val(true);
                
        $("#remainingBalanceLc").change(function(event){
            if($(this).val() == "0.00"){
                $("#setupProductPayment").val(true);
            }else{
                $("#setupProductPayment").val("");
            }
        });

        $(".product_rates").each(function(){
            $(this).change(function(){
                $("#recomputeChargeBtnCashLc").click();
            });
        })

    	$(".passOnRatesConfirmedByAsterisk").addClass("asterisk");
        if($("#forex_product tr").length >= 3) {
    		$(".passOnRatesConfirmedByAsterisk").addClass("asterisk");
    		$(".passOnRatesConfirmedByAsterisk").removeClass("clear_font");
		} else {
			$(".passOnRatesConfirmedByAsterisk").addClass("clear_font");
    		$(".passOnRatesConfirmedByAsterisk").removeClass("asterisk");
		}
    });
</script>

