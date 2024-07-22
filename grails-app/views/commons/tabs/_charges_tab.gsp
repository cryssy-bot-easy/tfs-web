<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 04/13/2018
	Program [Revision] Details: Added conditions on choosing edit documentary stamps popup.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _charges_tab.gsp
--%>
%{--utilities--}%
<g:if test="${(documentClass?.equalsIgnoreCase("DA") || documentClass?.equalsIgnoreCase("DP") || documentClass?.equalsIgnoreCase("OA") || documentClass?.equalsIgnoreCase("DR"))}">
    <g:javascript src="/utilities/ets/commons/charges/charges_tab_utility_non_lc.js"/>
</g:if>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "DOMESTIC".equalsIgnoreCase(documentType) && ("OPENING".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_lc_opening.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "DOMESTIC".equalsIgnoreCase(documentType) && ("AMENDMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_lc_amendment.js"/>
</g:elseif>
%{--<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "DOMESTIC".equalsIgnoreCase(documentType) && ("ADJUSTMENT".equalsIgnoreCase(serviceType))}">--}%
    %{--<g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_lc_adjustment.js"/>--}%
%{--</g:elseif>--}%
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "DOMESTIC".equalsIgnoreCase(documentType) && ("NEGOTIATION".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_lc_negotiation.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "DOMESTIC".equalsIgnoreCase(documentType) && ("UA_LOAN_MATURITY_ADJUSTMENT".equalsIgnoreCase(serviceType) || "UA LOAN MATURITY ADJUSTMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_lc_ua_loan_maturity_adjustment.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "DOMESTIC".equalsIgnoreCase(documentType) && ("UA_LOAN_SETTLEMENT".equalsIgnoreCase(serviceType) || "UA LOAN SETTLEMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_lc_ua_loan_settlement.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("OPENING".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_opening.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("AMENDMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_amendment.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("ADJUSTMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_adjustment.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("NEGOTIATION".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_negotiation.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("UA_LOAN_MATURITY_ADJUSTMENT".equalsIgnoreCase(serviceType) || "UA LOAN MATURITY ADJUSTMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_ua_loan_maturity_adjustment.js"/>
</g:elseif>
<g:elseif test="${"LC".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("UA_LOAN_SETTLEMENT".equalsIgnoreCase(serviceType) || "UA LOAN SETTLEMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_ua_loan_settlement.js"/>
</g:elseif>
<g:elseif test="${"INDEMNITY".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("ISSUANCE".equalsIgnoreCase(serviceType) || "ISSUANCE".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_indemnity_issuance.js"/>
</g:elseif>
<g:elseif test="${"INDEMNITY".equalsIgnoreCase(documentClass) && "FOREIGN".equalsIgnoreCase(documentType) && ("CANCELLATION".equalsIgnoreCase(serviceType) || "CANCELLATION".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_foreign_lc_indemnity_cancellation.js"/>
</g:elseif>
<g:elseif test="${"IMPORT_ADVANCE".equalsIgnoreCase(documentClass) && ("PAYMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_import_advance_payment.js"/>
</g:elseif>
<g:elseif test="${"IMPORT_ADVANCE".equalsIgnoreCase(documentClass) && ("REFUND".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_import_advance_refund.js"/>
</g:elseif>
<g:elseif test="${"BC".equalsIgnoreCase(documentClass) && ("SETTLEMENT".equalsIgnoreCase(serviceType))&& "DOMESTIC".equalsIgnoreCase(documentType) }">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_domestic_bc_settlement.js"/>
</g:elseif>
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
<g:javascript src="popups/chargeIdConversionFunction.js"/>
<g:javascript src="popups/bank_commission_utility.js"/>
<g:javascript src="popups/booking_commission_utility.js"/>
<g:javascript src="popups/commitment_fee_utility.js"/>
<g:javascript src="popups/cilex_fee_utility.js"/>
<g:javascript src="popups/documentary_stamp_utility.js"/>
<g:javascript src="popups/cable_fee_utility.js"/>
<g:javascript src="popups/supplies_fee_utility.js"/>
<g:javascript src="popups/interest_due_utility.js"/>
<g:javascript src="popups/notarial_fee_utility.js"/>
<g:javascript src="popups/advising_fee_utility.js"/>
<g:javascript src="popups/confirming_fee_utility.js"/>
<g:javascript src="popups/remittance_fee_utility.js"/>
<g:javascript src="popups/cancellation_fee_utility.js"/>
<g:javascript src="popups/bsp_registration_fee_popup.js"/>

<g:hiddenField name="referenceType" value="${referenceType}"/>
<g:hiddenField name="serviceType" value="${serviceType}"/>
<g:hiddenField name="documentType" value="${documentType}"/>
<g:hiddenField name="documentClass" value="${documentClass}"/>
<g:hiddenField name="documentSubType1" value="${documentSubType1}"/>
<g:hiddenField name="documentSubType2" value="${documentSubType2}"/>
<g:hiddenField name="bankCommissionPopupParamsHidden" value="${bankCommissionPopupParamsHidden}"/>
<g:hiddenField name="commitmentFeePopupParamsHidden" value="${commitmentFeePopupParamsHidden}"/>
<g:hiddenField name="cilexFeePopupParamsHidden" value="${cilexFeePopupParamsHidden}"/>
<g:hiddenField name="confirmingFeePopupParamsHidden" value="${confirmingFeePopupParamsHidden}"/>
<g:hiddenField name="documentaryStampPopupParamsHidden" value="${documentaryStampPopupParamsHidden}"/>
<g:hiddenField name="centavosPopup" value="${centavos}"/>
<g:if test="${settlementMode}">
    <g:hiddenField name="settlementModeNonLc" value="${settlementMode}"/>
</g:if>

<g:hiddenField name="cilexFlag" value="${cilexFlag}"/>
<g:hiddenField name="form" value="charges"/>

<script type="text/javascript">
    var chargesString = '${chargesString}';
    <%-- added for charges grid --%>
    var windowed = ${windowed ?: false};

    var recomputeChargesPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';

    var defaultValuesUrl = "${g.createLink(controller:'recompute', action: 'getDefaultValues')}";

    //Charges Recompute URLS
    var recomputeCurrency_BC_DOMESTIC_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_DOMESTIC_SETTLEMENT')}';
    var recomputeCurrency_BC_FOREIGN_CANCELLATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_FOREIGN_CANCELLATION')}';
    var recomputeCurrency_BC_FOREIGN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_FOREIGN_SETTLEMENT')}';

    var recomputeCurrency_BP_DOMESTIC_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_DOMESTIC_NEGOTIATION')}';
    var recomputeCurrency_BP_DOMESTIC_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_DOMESTIC_SETTLEMENT')}';
    var recomputeCurrency_BP_FOREIGN_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_FOREIGN_NEGOTIATION')}';
    var recomputeCurrency_BP_FOREIGN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_FOREIGN_SETTLEMENT')}';
</script>

<g:javascript src="js-temp/validation_Charges_Tab.js"/>

<g:hiddenField name="etsNumber" value="${serviceInstructionId}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="savedCurrency" value="${currency ?: originalCurrency ?: 'PHP'}"/>

<%-- TEST 
!@# <g:textField name="indemnityType" value="${indemnityType}"/> --%>

<g:if test="${!documentClass?.equalsIgnoreCase('PURCHASE') && !documentClass?.equalsIgnoreCase('COLLECTION')}">
    <span class="title_label">Payment Details for Charges</span>
</g:if>
<g:if test="${documentClass?.equalsIgnoreCase('PURCHASE') && serviceType?.equalsIgnoreCase('SETTLEMENT')}">
    <table class="charges_table">
        <tr>
            <td class="label_width">Amount Due (in Negotiation Currency)</td>
            <td><span class="charges_currency" id="negoCurrency"></span></td>
            <td width="160"><g:textField class="input_field_right2" name="negoAmount" readonly="readonly"/></td>
        </tr>
    </table>
    <br/>
</g:if>

<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label">Settlement Currency <span class="asterisk">*</span></span>
        </td>

        <td>
        %{--if foreign or service type != to indemnity issuance--}%
            <g:if test="${documentType?.equalsIgnoreCase('FOREIGN') || documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION') || serviceType?.equalsIgnoreCase('Export Advance Payment') || serviceType?.equalsIgnoreCase('Export Advance Refund')}">

                <g:if test="${!(serviceType?.equalsIgnoreCase('issuance') && documentClass?.equalsIgnoreCase('indemnity')) && !(serviceType?.equalsIgnoreCase('cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
                <%-- Auto Complete --%>
                    <input class="tags_currency select2_dropdown bigdrop " name="settlementCurrency"
                           id="settlementCurrency"/>
                </g:if>
            </g:if>
        %{--if domestic or service type = indemnity issuance--}%
            <g:if test="${(documentType?.equalsIgnoreCase('DOMESTIC') && !(documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION'))) || (serviceType?.equalsIgnoreCase('Issuance') && documentClass?.equalsIgnoreCase('INDEMNITY')) || (serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
                <input class="tags_currency input_field " name="settlementCurrency" id="settlementCurrency"
                       value="PHP" readonly="readonly"/>
            </g:if>
            <g:if test="${documentClass.equals("IMPORT_ADVANCE")}">
                <input class="tags_currency select2_dropdown bigdrop " name="settlementCurrency"
                       id="settlementCurrency"/>
            </g:if>
        </td>
    </tr>
</table>

%{--if foreign--}%
<g:if test="${(serviceType?.equalsIgnoreCase('settlement') && documentClass?.equalsIgnoreCase('da')) || !(documentClass?.equalsIgnoreCase('INDEMNITY'))}">
    <g:if test="${(!(documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION')))}">
        <g:if test="${currency ?: negotiationCurrency}">
            <div class="grid_wrapper">
                <table class="foreign_exchange" id="forex_charges">
                    <tr>
                        <th class="rates">Rates</th>
                        <th class="rate_description">Rate Description</th>
                        <th class="pass_on_rate">Pass-on Rate</th>
                        <th class="special_rate">Special Rate</th>
                    </tr>
                    <g:each in="${exchange}" var="temp" status="i">
                        <tr>
                            <g:if test="${temp.rate_description.contains('BOOKING')}">
                                <td class="rates">${temp.rates}<g:hiddenField name="URR" value="${temp.rates}"/></td>
                            </g:if>
                            <g:elseif test="${temp.rate_description.contains('BUYING')}">
                                <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}_buying"
                                                                              value="${temp.rates}"/></td>
                            </g:elseif>
                            <g:else>
                                <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}"
                                                                              value="${temp.rates}"/></td>
                            </g:else>
                            <td>${temp.rate_description_lbp}</td>
                            <g:if test="${temp.rate_description.contains('BOOKING')}">
                                <td>
                                    <g:textField name="${temp.rates+'_text_pass_on_rate_urr'}" id="${temp.rates+'_text_pass_on_rate_urr'}" class="${temp.rates+'_pass_on_rate'} numericRates product_rates" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}" />
                                    <g:hiddenField name="${temp.rates+'_pass_on_rate_charges_urr'}" class="${temp.rates+'_pass_on_rate'}" value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td></td>
                                <td>
                                    <g:textField name="${temp.rates+'_text_special_rate_urr'}" id="${temp.rates+'_text_special_rate_urr'}" class="${temp.rates+'_special_rate'} numericRates product_rates" value="${temp.text_special_rate ?: temp.special_rate}" />
                                    <g:hiddenField name="${temp.rates+'_special_rate_charges_urr'}" class="${temp.rates+'_special_rate'} " value="${temp.special_rate_cash ?: temp.special_rate}"/>
                                    <g:hiddenField name="${temp.rates+'_urr'}" class="${temp.rates+'_urr'}" value="${temp.special_rate_cash ?: temp.special_rate}"/>
                                </td>

<!-- 
                                <td class="urr">${temp.pass_on_rate.toString()}</td>
                                <td class="urr">${temp.special_rate.toString()}<g:hiddenField
                                        name="${temp.rates + '_urr'}" value="${temp.special_rate.toString()}"/></td> -->
                            </g:if>
                            <g:elseif test="${temp.rate_description.contains('BUYING')}">
                                <td><g:textField name="${temp.rates + '_text_pass_on_rate_buying'}"
                                                 class="${temp.rates + '_pass_on_rate'} numericRates service_rates"
                                                 value="${temp.text_pass_on_rate ?: temp.pass_on_rate}"/>
                                    <g:hiddenField name="${temp.rates + '_pass_on_rate_charges_buying'}"
                                                   class="${temp.rates + '_pass_on_rate'}"
                                                   value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td>
                                <td><g:textField name="${temp.rates + '_text_special_rate_buying'}"
                                                 class="${temp.rates + '_special_rate'} numericRates service_rates"
                                                 value="${temp.text_special_rate ?: temp.special_rate}"/>
                                    <g:hiddenField name="${temp.rates + '_special_rate_charges_buying'}"
                                                   class="${temp.rates + '_special_rate'}"
                                                   value="${temp.special_rate_cash ?: temp.special_rate}"/></td>
                            </g:elseif>
                            <g:else>
                                <td><g:textField name="${temp.rates + '_text_pass_on_rate'}"
                                                 class="${temp.rates + '_pass_on_rate'} numericRates service_rates"
                                                 value="${temp.text_pass_on_rate ?: temp.pass_on_rate}"/>
                                    <g:hiddenField name="${temp.rates + '_pass_on_rate_charges'}"
                                                   class="${temp.rates + '_pass_on_rate'}"
                                                   value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td>
                                <td><g:textField name="${temp.rates + '_text_special_rate'}"
                                                 class="${temp.rates + '_special_rate'} numericRates service_rates"
                                                 value="${temp.text_special_rate ?: temp.special_rate}"/>
                                    <g:hiddenField name="${temp.rates + '_special_rate_charges'}"
                                                   class="${temp.rates + '_special_rate'}"
                                                   value="${temp.special_rate_cash ?: temp.special_rate}"/></td>
                            </g:else>
                        </tr>
                    </g:each>
                </table>
            </div>
        </g:if>
        <table class="popup_full_width">
            <tr>
                <td class="label_width">Pass-on rates confirmed by: <span class="passOnRatesConfirmedByChargesAsterisk">*</span></td>
                <td><g:textField name="passOnRateConfirmedByCharges"
                                 value="${passOnRateConfirmedByCharges ?: passOnRateConfirmedByCash ?: passOnRateConfirmedBySettlement}"
                                 class="input_field"/></td>
                <td>
                    <input type="button" class="input_button_long actionWidget" value="Recompute Charge"
                           name="recomputeChargeBtn" id="recomputeChargeBtn"/>
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
        <g:each in="${charges}" >
            <g:if test="${!(it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADVISING') || it?.CHARGEID.toString().equalsIgnoreCase('CORRES-CONFIRMING')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-EXPORT')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADDITIONAL'))}">
                <tr>
                    <td width="155"><span class="field_label">${it?.CHARGEDISPLAYVALUE ?: 'NOT_EXIST'}</span></td>
                    <td><span class="charges_currency" id="${it?.CHARGECURRENCY ?: 'NOT_EXIST'}"></span></td>
                    <td width="160"><g:textField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}" class="input_field_right" readonly="readonly" value="${it?.AMOUNT}"/></td>
                    <g:if test="${(session.userrole.id.contains('BR') && referenceType.equalsIgnoreCase('ETS')) || (session.userrole.id.contains('TSD') && referenceType.equalsIgnoreCase('PAYMENT')) && !paymentStatus.toString().equalsIgnoreCase('PAID')}">
                        <td class="link"><a href="javascript:void(0)" id="${it?.EDITCHARGEID ?: 'NOT_EXIST'}">edit</a><g:hiddenField name="${it?.CHARGEHIDDEN ?: 'NOT_EXIST'}"/></td>
                    </g:if>
                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}overridenFlag" value="${it?.OVERRIDENFLAG}"/>
                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}nocwtAmount" value="${it?.NOCWTAMOUNT}"/>
                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}original" class="charges_original"/>
                </tr>
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
        <g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
            <tr class="other_local_banks_charges">
                <td width="155"><span class="field_label">Other Local Bank's Charges</span></td>
                <td><span class="charges_currency" id="otherLocalBanksChargesCurrency"></span></td>
                <td width="160"><g:textField class="input_field_right2" name="otherLocalBanksCharges"
                                             readonly="readonly"/></td>
            </tr>
        </g:if>
        <g:if test="${documentType?.equalsIgnoreCase('EXPORT')}">
            <tr class="additional_corres_charges">
                <td width="155"><span class="field_label">Additional Corres Charges</span></td>
                <td><span class="charges_currency" id="additionalCorresChargesCurrency"></span></td>
                <td width="160"><g:textField class="input_field_right2" name="additionalCorresCharges"
                                             readonly="readonly"/></td>
            </tr>
        </g:if>
    </table>
    <br/>
</g:else>

<g:if test="${(charges?.contains([CHARGEID: 'CORRES-ADVISING']) || [CHARGEID: 'CORRES-CONFIRMING']||[CHARGEID: 'CORRES-EXPORT']||[CHARGEID: 'CORRES-ADDITIONAL']) && (advanceCorresChargesFlag == 'Y')}">
    <span class="charges_title">Corres Charges</span>
    <br/><br/>
    <table class="charges_table">
        <g:each in="${charges}">
            <g:if test="${it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADVISING') || it?.CHARGEID.toString().equalsIgnoreCase('CORRES-CONFIRMING')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-EXPORT')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADDITIONAL')}">
                <tr>
                    <td width="155"><span class="field_label">${it?.CHARGEDISPLAYVALUE ?: 'NOT_EXIST'}</span></td>
                    <td><span class="charges_currency" id="${it?.CHARGECURRENCY ?: 'NOT_EXIST'}"></span></td>
                    <td width="160"><g:textField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}" class="input_field_right" readonly="readonly" value="${it?.AMOUNT}"/></td>
                    <g:if test="${(session.userrole.id.contains('BR') && referenceType.equalsIgnoreCase('ETS')) || (session.userrole.id.contains('TSD') && referenceType.equalsIgnoreCase('PAYMENT')) && !paymentStatus.toString().equalsIgnoreCase('PAID')}">
                        <td class="link"><a href="javascript:void(0)" id="${it?.EDITCHARGEID ?: 'NOT_EXIST'}">edit</a><g:hiddenField name="${it?.CHARGEHIDDEN ?: 'NOT_EXIST'}"/></td>
                    </g:if>
                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}original" class="charges_original"/>
                </tr>
            </g:if>
        </g:each>
    </table>
</g:if>


<br/>
<g:if test="${!(serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
    <table class="charges_table">
        <tr>
            <td width="155">Total Amount Charges Due <br/> (in Settlement Currency)</td>
            <td><span class="charges_currency" id="totalAmountChargesCurrency"></span></td>
            <td><g:textField class="input_field_right" name="totalAmountCharges" readonly="readonly"/></td>
        </tr>
    </table>
    <input type="button" class="input_button_long actionWidget" value="Compute Total" name="recomputeSumBtn"
           id="recomputeSumBtn"/>
</g:if>
<g:elseif test="${documentType?.equalsIgnoreCase('FOREIGN') && documentClass?.equalsIgnoreCase('INDEMNITY') && serviceType?.equalsIgnoreCase('Cancellation')}">
	<table class="charges_table">
		<tr>
			<td width="155">Total Amount Charges Due <br/> (in Settlement Currency)</td>
			<td><span class="charges_currency" id="totalAmountChargesCurrency"></span></td>
			<td><g:textField class="input_field_right" name="totalAmountCharges" readonly="readonly"/></td>
		</tr>
	</table>
	<input type="button" class="input_button_long actionWidget" value="Compute Total" name="recomputeSumBtn" id="recomputeSumBtn"/>
</g:elseif>
<br/>
%{--buttons--}%
<g:render template="../layouts/buttons_for_grid_wrapper"/>

%{--popups--}%
<g:render template="../commons/popups/bank_commission_popup"/>
<g:render template="../commons/popups/bsp_registration_fee_popup"/>
<g:render template="../commons/popups/booking_commission_popup"/>
<g:render template="../commons/popups/commitment_fee_popup"/>
<g:render template="../commons/popups/cilex_popup"/>
<g:if test="${isForEvery?.equalsIgnoreCase('n') || (
		serviceType?.equalsIgnoreCase('Settlement') && !documentClass?.equalsIgnoreCase('BC') && !documentClass?.equalsIgnoreCase('BP') && (settlementMode?.equalsIgnoreCase('TR') || settlementMode?.equalsIgnoreCase('DTR'))
	) || serviceType?.equalsIgnoreCase('Negotiation')}">
    <g:render template="../commons/popups/documentary_stamp_negotiation_popup"/>
</g:if>
<g:else>
    <g:render template="../commons/popups/documentary_stamp_popup"/>
</g:else>
<g:if test="${(serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
    <g:render template="../commons/popups/cancellation_fee_popup"/>
</g:if>
<g:render template="../commons/popups/cable_fee_popup"/>
<g:render template="../commons/popups/supplies_popup"/>
<g:render template="../commons/popups/interest_due_popup"/>
<g:render template="../commons/popups/notarial_fee_popup"/>
<g:render template="../commons/popups/advising_fee_popup"/>
<g:render template="../commons/popups/confirming_fee_popup"/>
<g:render template="../commons/popups/remittance_fee_popup"/>

<g:javascript src="utilities/validation/validate_payment_tab.js" />

<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') || (documentClass?.equalsIgnoreCase('PURCHASE') || documentClass?.equalsIgnoreCase('COLLECTION')) || (serviceType?.equalsIgnoreCase('Export Advance Payment') || serviceType?.equalsIgnoreCase('Export Advance Refund'))}">
    <g:if test="${!(serviceType?.equalsIgnoreCase('issuance') && documentClass?.equalsIgnoreCase('indemnity')) && !(serviceType?.equalsIgnoreCase('cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
        <script>


            $(document).ready(function () {
                $("#settlementCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data', {id: '${settlementCurrency}'});
                onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
                checkForOtherCurrency();
                onRecomputeChargeBtnClick();  //this is called to produce the correct totals on load
                $("#chargesTab").click(onRecomputeChargeBtnClick);
                $("#chargesPaymentTab").click(onRecomputeChargeBtnClick);
                if ($("#forex_settlement").length > 0) {
                	$("#forex_charges :input").attr("readonly", "readonly");
                    $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                } else if ($("#forex_product").length > 0) {
                    if ($("#overdrawnAmount").length > 0) {
                        var overdrawnAmount = $("#overdrawnAmount").val();
//
                        if (overdrawnAmount != "0.00") {
                            $("#forex_charges :input").attr("readonly", "readonly");
                            $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                        } else {
                            $("#forex_charges :input").removeAttr("readonly");
                            $("#passOnRateConfirmedByCharges").removeAttr("readonly");
                        }
                    } else {
                        if (!($(".cash_lc_payment_tab").is(":hidden"))) {
                            $("#forex_charges :input").attr("readonly", "readonly");
                            $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                        }
                    }
                }
            });
        </script>
    </g:if>
</g:if>
    <g:if test="${documentType?.equalsIgnoreCase("DOMESTIC")}">
    <script>
        $(document).ready(function () {
            onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
            checkForOtherCurrency();
            onRecomputeChargeBtnClick();  //this is called to produce the correct totals on load
            $("#chargesTab").click(onRecomputeChargeBtnClick);
            $("#chargesPaymentTab").click(onRecomputeChargeBtnClick);
            if ($("#forex_settlement").length > 0) {
            	$("#forex_charges :input").attr("readonly", "readonly");
                $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
            } else if ($("#forex_product").length > 0) {
                if ($("#overdrawnAmount").length > 0) {
                    var overdrawnAmount = $("#overdrawnAmount").val();

                    if (overdrawnAmount != "0.00") {
                        $("#forex_charges :input").attr("readonly", "readonly");
                        $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                    } else {
                        $("#forex_charges :input").removeAttr("readonly");
                        $("#passOnRateConfirmedByCharges").removeAttr("readonly");
                    }
                } else {
                    if (!($(".cash_lc_payment_tab").is(":hidden"))) {
                        $("#forex_charges :input").attr("readonly", "readonly");
                        $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                    }
                }
            }

            $(".service_rates").each(function(){
                $(this).change(function(){
                    $("#recomputeChargeBtn").click();
                });
            })
        });
    </script>
</g:if>

<g:if test="${serviceType?.equalsIgnoreCase('cancellation') && documentClass?.equalsIgnoreCase('indemnity')}">
    <script>
        $(document).ready(function () {
            onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
            checkForOtherCurrency();
            onRecomputeChargeBtnClick();  //this is called to produce the correct totals on load
            $("#chargesTab").click(onRecomputeChargeBtnClick);
            $("#chargesPaymentTab").click(onRecomputeChargeBtnClick);
            if ($("#forex_settlement").length > 0) {
                $("#forex_charges :input").attr("readonly", "readonly");
                $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
            } else if ($("#forex_product").length > 0) {
                if ($("#overdrawnAmount").length > 0) {
                    var overdrawnAmount = $("#overdrawnAmount").val();

                    if (overdrawnAmount != "0.00") {
                        $("#forex_charges :input").attr("readonly", "readonly");
                        $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                    } else {
                        $("#forex_charges :input").removeAttr("readonly");
                        $("#passOnRateConfirmedByCharges").removeAttr("readonly");
                    }
                } else {
                    if (!($(".cash_lc_payment_tab").is(":hidden"))) {
                        $("#forex_charges :input").attr("readonly", "readonly");
                        $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                    }
                }
            }

            $(".service_rates").each(function(){
                $(this).change(function(){
                    $("#recomputeChargeBtn").click();
                });
            })
        });
    </script>
</g:if>

<g:if test="${serviceType?.equalsIgnoreCase('issuance') && documentClass?.equalsIgnoreCase('indemnity') }">
    <script>
        $(document).ready(function () {
            onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
            checkForOtherCurrency();
            onRecomputeChargeBtnClick();  //this is called to produce the correct totals on load
            $("#chargesTab").click(onRecomputeChargeBtnClick);
            $("#chargesPaymentTab").click(onRecomputeChargeBtnClick);
            if ($("#forex_settlement").length > 0) {
                $("#forex_charges :input").attr("readonly", "readonly");
                $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
            } else if ($("#forex_product").length > 0) {
                if ($("#overdrawnAmount").length > 0) {
                    var overdrawnAmount = $("#overdrawnAmount").val();

                    if (overdrawnAmount != "0.00") {
                        $("#forex_charges :input").attr("readonly", "readonly");
                        $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                    } else {
                        $("#forex_charges :input").removeAttr("readonly");
                        $("#passOnRateConfirmedByCharges").removeAttr("readonly");
                    }
                } else {
                    if (!($(".cash_lc_payment_tab").is(":hidden"))) {
                        $("#forex_charges :input").attr("readonly", "readonly");
                        $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
                    }
                }
            }

            $(".service_rates").each(function(){
                $(this).change(function(){
                    $("#recomputeChargeBtn").click();
                });
            })
        });
    </script>
</g:if>
<script type="text/javascript">
$(document).ready(function() {
	if($("#forex_charges tr").length >= 3) {
		$(".passOnRatesConfirmedByChargesAsterisk").addClass("asterisk");
		$(".passOnRatesConfirmedByChargesAsterisk").removeClass("clear_font");
	} else {
		$(".passOnRatesConfirmedByChargesAsterisk").addClass("clear_font");
		$(".passOnRatesConfirmedByChargesAsterisk").removeClass("asterisk");
	}
});
</script>