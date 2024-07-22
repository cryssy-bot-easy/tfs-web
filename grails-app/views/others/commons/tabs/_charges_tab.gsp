%{--utilities--}%
<g:if test="${"BC".equalsIgnoreCase(documentClass) && ("SETTLEMENT".equalsIgnoreCase(serviceType))&& "DOMESTIC".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_bc_settlement.js"/>
</g:if>
<g:elseif test="${"BP".equalsIgnoreCase(documentClass) && ("NEGOTIATION".equalsIgnoreCase(serviceType))&& "DOMESTIC".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_bp_negotiation.js"/>
</g:elseif>
<g:elseif test="${"BP".equalsIgnoreCase(documentClass) && ("SETTLEMENT".equalsIgnoreCase(serviceType))&& "DOMESTIC".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_bp_settlement.js"/>
</g:elseif>
<g:elseif test="${"BC".equalsIgnoreCase(documentClass) && ("SETTLEMENT".equalsIgnoreCase(serviceType))&& "FOREIGN".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_bc_settlement.js"/>
</g:elseif>
<g:elseif test="${"BC".equalsIgnoreCase(documentClass) && ("CANCELLATION".equalsIgnoreCase(serviceType))&& "FOREIGN".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_bc_cancellation.js"/>
</g:elseif>
<g:elseif test="${"BP".equalsIgnoreCase(documentClass) && ("NEGOTIATION".equalsIgnoreCase(serviceType))&& "FOREIGN".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_bp_negotiation.js"/>
</g:elseif>
<g:elseif test="${"BP".equalsIgnoreCase(documentClass) && ("SETTLEMENT".equalsIgnoreCase(serviceType))&& "FOREIGN".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_bp_settlement.js"/>
</g:elseif>
<g:else>
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility.js"/>
</g:else>

%{--popups--}%
<g:javascript src="popups/bank_commission_utility.js" />
<g:javascript src="popups/commitment_fee_utility.js" />
<g:javascript src="popups/cilex_fee_utility.js" />
<g:javascript src="popups/documentary_stamp_utility.js" />
<g:javascript src="popups/cable_fee_utility.js" />
<g:javascript src="popups/supplies_fee_utility.js" />
<g:javascript src="popups/interest_due_utility.js" />
<g:javascript src="popups/notarial_fee_utility.js" />
<g:javascript src="popups/advising_fee_utility.js" />
<g:javascript src="popups/confirming_fee_utility.js" />
<g:javascript src="popups/remittance_fee_utility.js" />
<g:javascript src="popups/cancellation_fee_utility.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:if test="${settlementMode}">
    <g:hiddenField name="settlementModeNonLc" value="${settlementMode}"/>
</g:if>

<g:hiddenField name="cilexFlag" value="${cilexFlag}"/>
<g:hiddenField name="form" value="charges" />


<script type="text/javascript">
    var chargesString = '${chargesString}';
    <%-- added for charges grid --%>
    var windowed = ${windowed ?: false};

    var recomputeChargesPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';
</script>

<g:hiddenField name="etsNumber" value="${serviceInstructionId}"/>
<g:hiddenField name="tradeServiceId" value="${  tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="savedCurrency" value="${currency?:'PHP'}"/>

<%-- <span class="title_label"> Payment Details for Charges </span> --%>
<g:if test="${!documentClass?.equalsIgnoreCase('PURCHASE') && !documentClass?.equalsIgnoreCase('COLLECTION')}">
    <span class="title_label"> Payment Details for Charges </span>
</g:if>
<g:if test="${documentClass?.equalsIgnoreCase('PURCHASE') && serviceType?.equalsIgnoreCase('SETTLEMENT')}">
    <table class="charges_table">
        <tr>
            <td class="label_width"> Amount Due (in Negotiation Currency) </td>
            <td> <span class="charges_currency" id="negoCurrency"> </span> </td>
            <td width="160"> <g:textField class="input_field_right2" name="negoAmount" readonly="readonly"/> </td>
        </tr>
    </table>
    <br />
</g:if>

<table class="tabs_forms_table">
    <tr>
        <td class="label_width"> Settlement Currency <span class="asterisk"> * </span></td>

        <td>
        %{--if foreign or service type != to indemnity issuance--}%
            <g:if test = "${documentType?.equalsIgnoreCase('FOREIGN') || documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION') || serviceType?.equalsIgnoreCase('Export Advance Payment') || serviceType?.equalsIgnoreCase('Export Advance Refund')}">

                <g:if test="${!(serviceType?.equalsIgnoreCase('issuance') && documentClass?.equalsIgnoreCase('indemnity')) && !(serviceType?.equalsIgnoreCase('cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
                <%-- Auto Complete --%>
                    <input class="tags_currency select2_dropdown bigdrop" name="settlementCurrency" id="settlementCurrency" />
                </g:if>
            </g:if>
        %{--if domestic or service type = indemnity issuance--}%
            <g:if test = "${(documentType?.equalsIgnoreCase('DOMESTIC') && !(documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION'))) || (serviceType?.equalsIgnoreCase('Issuance') && documentClass?.equalsIgnoreCase('INDEMNITY')) || (serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
                <input class="input_field" name="settlementCurrency" id="settlementCurrency" value="PHP" readonly="readonly"/>
            </g:if>
        </td>
    </tr>
</table>

%{--if foreign--}%
<g:if test="${!(serviceType?.equalsIgnoreCase('issuance') && documentClass?.equalsIgnoreCase('INDEMNITY')) || !(serviceType?.equalsIgnoreCase('cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY')) || (serviceType?.equalsIgnoreCase('settlement') && documentClass?.equalsIgnoreCase('da'))}">
    <g:if test = "${(!documentType?.equalsIgnoreCase('DOMESTIC') && !(documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION')))} ">
        <g:if test="${currency}">
            <div class="grid_wrapper">
                <table class="foreign_exchange">
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
        </g:if>
        <table class="popup_full_width">
            <tr>
                <td class="label_width">Pass-on rates confirmed by:</td>
                <td><g:textField name="passOnRateConfirmedBy" value="${passOnRateConfirmedBy}" class="input_field"/></td>
                <td>
                    <input type="button" class="input_button_long actionWidget" value="Recompute Charge" name="recomputeChargeBtn" id="recomputeChargeBtn"/>
                </td>
            </tr>
        </table>
    </g:if>
</g:if>
<br/>
<g:if test="${!documentClass?.equalsIgnoreCase('PURCHASE') || !serviceType?.equalsIgnoreCase('SETTLEMENT')}">
    <span class="title_label">Charges</span>
    <br/>
    <br/>
    <table class="charges_table">
        <g:each in="${charges}">
            <g:if test="${!(it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADVISING') || it?.CHARGEID.toString().equalsIgnoreCase('CORRES-CONFIRMING'))}">
                <g:if test="${it?.AMOUNT>0}">
                    <tr>
                        <td width="155"><span class="field_label">${it?.CHARGEDISPLAYVALUE ?: 'NOT_EXIST'}</span></td>
                        <td><span class="charges_currency" id="${it?.CHARGECURRENCY ?: 'NOT_EXIST'}"></span></td>
                        <td width="160"><g:textField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}" class="input_field_right numericCurrency " readonly="readonly" value="${it?.AMOUNT}"/></td>
                        <td class="link"><a href="javascript:void(0)" id="${it?.EDITCHARGEID ?: 'NOT_EXIST'}">edit</a><g:hiddenField name="${it?.CHARGEHIDDEN ?: 'NOT_EXIST'}" /></td>
                    </tr>
                </g:if>
            </g:if>
        </g:each>
    </table>
    <br/>
    <br/>
</g:if>
<g:else>
    <span class="title_label">Charges Due from Client</span>
    <br/>
    <br/>
    <table class="charges_table">
        <g:if test="${ documentType?.equalsIgnoreCase('DOMESTIC') }">
            <tr class="other_local_banks_charges">
                <td width="155"> <span class="field_label">Other Local Bank's Charges</span> </td>
                <td> <span class="charges_currency" id="otherLocalBanksChargesCurrency"> </span> </td>
                <td width="160"> <g:textField class="input_field_right2" name="otherLocalBanksCharges" readonly="readonly"/> </td>
            </tr>
        </g:if>
        <g:if test="${ documentType?.equalsIgnoreCase('EXPORT') }">
            <tr class="additional_corres_charges">
                <td width="155"> <span class="field_label">Additional Corres Charges</span> </td>
                <td> <span class="charges_currency" id="additionalCorresChargesCurrency"> </span> </td>
                <td width="160"> <g:textField class="input_field_right2" name="additionalCorresCharges" readonly="readonly"/> </td>
            </tr>
        </g:if>
    </table>
    <br />
</g:else>

<g:if test="${(charges?.contains([CHARGEID:'CORRES-ADVISING']) || [CHARGEID: 'CORRES-CONFIRMING']) && (advanceCorresChargesFlag == 'Y')}">
    <span class="charges_title">Corres Charges</span>
    <br/><br/>
    <table class="charges_table">
        <g:each in="${charges}">
            <g:if test="${it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADVISING') || it?.CHARGEID.toString().equalsIgnoreCase('CORRES-CONFIRMING')}">
                <tr>
                    <td width="155"><span class="field_label">${it.CHARGEDISPLAYVALUE}</span></td>
                    <td><span class="charges_currency" id="${it.CHARGECURRENCY}"></span></td>
                    <td width="160"><g:textField name="${it.CHARGEFIELDID}" class="input_field_right2" readonly="readonly"/></td>
                    <td class="link"><a href="javascript:void(0)" id="${it.EDITCHARGEID}">edit</a><g:hiddenField name="${it.CHARGEHIDDEN}" /></td>
                </tr>
            </g:if>
        </g:each>
    </table>
</g:if>


<br/>
<g:if test="${ !(serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('Regular') && documentSubType2.equalsIgnoreCase('Sight')) || (serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY')) }">
    <table class="charges_table">
        <tr>
            <td width="155"><span class="field_label">Total Amount Charges Due <br/> (in Settlement Currency)</span></td>
            <td><span class="charges_currency" id="totalAmountChargesCurrency"></span></td>
            <td><g:textField class="input_field_right" name="totalAmountCharges" readonly="readonly"/></td>
        </tr>
    </table>
    <input type="button" class="input_button_long actionWidget" value="Compute Total" name="recomputeSumBtn" id="recomputeSumBtn"/>
</g:if>
<br/>
%{--buttons--}%
<g:render template="../layouts/buttons_for_grid_wrapper" />

%{--popups--}%
<g:render template="../commons/popups/bank_commission_popup" />
<g:render template="../commons/popups/commitment_fee_popup" />
<g:render template="../commons/popups/cilex_popup" />
<g:if test="${ !serviceType?.equalsIgnoreCase('Negotiation') }">
    <g:render template="../commons/popups/documentary_stamp_popup" />
</g:if>
<g:if test="${ serviceType?.equalsIgnoreCase('Negotiation') }">
    <g:render template="../commons/popups/documentary_stamp_negotiation_popup" />
</g:if>
<g:if test="${ (serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY')) }">
    <g:render template="../commons/popups/cancellation_fee_popup" />
</g:if>
<g:render template="../commons/popups/cable_fee_popup" />
<g:render template="../commons/popups/supplies_popup" />
<g:render template="../commons/popups/interest_due_popup" />
<g:render template="../commons/popups/notarial_fee_popup" />
<g:render template="../commons/popups/advising_fee_popup" />
<g:render template="../commons/popups/confirming_fee_popup" />
<g:render template="../commons/popups/remittance_fee_popup" />

<g:if test = "${documentType?.equalsIgnoreCase('FOREIGN') || documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION') || serviceType?.equalsIgnoreCase('Export Advance Payment') || serviceType?.equalsIgnoreCase('Export Advance Refund')}">
    <g:if test="${!(serviceType?.equalsIgnoreCase('issuance') && documentClass?.equalsIgnoreCase('indemnity')) && !(serviceType?.equalsIgnoreCase('cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
        <script>
            var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';

            $(document).ready(function() {
                $("#settlementCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${settlementCurrency}'});
                loadForeignExchangeRates();
                onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
                checkForOtherCurrency();
            });
        </script>
    </g:if>
</g:if>