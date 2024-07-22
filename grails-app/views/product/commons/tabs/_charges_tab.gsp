<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _charges_tab.gsp
--%>
<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 03/20/2018
	Program [Revision] Details: Added centavosPopup hidden field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _charges_tab.gsp
--%>

%{--utilities--}%
<g:if test="${"EXPORT_ADVISING".equalsIgnoreCase(documentClass) && ("OPENING_ADVISING".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_exports_advising.js" />
</g:if>
<g:elseif test="${"EXPORT_ADVISING".equalsIgnoreCase(documentClass) && ("AMENDMENT_ADVISING".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_exports_advising.js" />
</g:elseif>
<g:elseif test="${"EXPORT_ADVISING".equalsIgnoreCase(documentClass) && ("CANCELLATION_ADVISING".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_exports_advising.js" />
</g:elseif>
<g:elseif test="${"EXPORT_ADVANCE".equalsIgnoreCase(documentClass) && ("PAYMENT".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_import_advance_payment.js" />
</g:elseif>
<g:elseif test="${"EXPORT_ADVANCE".equalsIgnoreCase(documentClass) && ("REFUND".equalsIgnoreCase(serviceType))}">
    <g:javascript src="utilities/ets/commons/charges/charges_tab_utility_export_advance_refund.js" />
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
<g:javascript src="popups/bank_commission_utility.js" />
<g:javascript src="popups/commitment_fee_utility.js" />
<g:javascript src="popups/cilex_fee_utility.js" />
<g:javascript src="popups/documentary_stamp_utility.js" />
<g:javascript src="popups/cable_fee_utility.js" />
<g:javascript src="popups/exports_advising_fee_utility.js" />
<g:javascript src="popups/other_local_bank_charges.js" />
<g:javascript src="popups/supplies_fee_utility.js" />
<g:javascript src="popups/interest_due_utility.js" />
<g:javascript src="popups/notarial_fee_utility.js" />
<g:javascript src="popups/advising_fee_utility.js" />
<g:javascript src="popups/confirming_fee_utility.js" />
<g:javascript src="popups/remittance_fee_utility.js" />
<g:javascript src="popups/cancellation_fee_utility.js" />
<g:javascript src="popups/postage_fee_utility.js" />
<g:javascript src="popups/corres_export_charge_utility.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:if test="${settlementMode}">
    <g:hiddenField name="settlementModeNonLc" value="${settlementMode}"/>
</g:if>

<g:if test="${'EXPORT_ADVISING'.equalsIgnoreCase(documentClass)}">
<g:hiddenField name="cwtFlag" value="${cwtFlag ?: 'N'}"/>
</g:if>
<g:hiddenField name="cilexFlag" value="${cilexFlag}"/>
<g:hiddenField name="form" value="charges" />

<script type="text/javascript">
    var chargesString = '${chargesString}';
    <%-- added for charges grid --%>
    var windowed = ${windowed ?: false};

    %{--var computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';--}%
    %{--var computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';--}%
    %{--var recomputeUrl = '${g.createLink(controller: "recompute", action: "recomputeCharge")}';--}%
    %{--//var recomputeUrl = '$'{g.createLink(controller: "recompute", action: "recompute")}';--}%
    %{--var recomputeCurrencyUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency')}';--}%

    var computeCwtUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCwt')}';
    var recomputeCurrency_EXPORTS_ADVISING_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_EXPORTS_ADVISING_Url')}';
    var recomputeCurrency_BC_FOREIGN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_FOREIGN_SETTLEMENT')}';
    var recomputeCurrency_BC_DOMESTIC_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_DOMESTIC_SETTLEMENT')}';
    var recomputeCurrency_BP_FOREIGN_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_FOREIGN_NEGOTIATION')}';
    var recomputeCurrency_BP_FOREIGN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_FOREIGN_SETTLEMENT')}';
    var recomputeCurrency_BP_DOMESTIC_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_DOMESTIC_NEGOTIATION')}';
    var recomputeCurrency_BP_DOMESTIC_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_DOMESTIC_SETTLEMENT')}';
    

    var recomputeChargesPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';

    var defaultValuesUrl = "${g.createLink(controller:'recompute', action: 'getDefaultValues')}";
</script>

<g:hiddenField name="etsNumber" value="${serviceInstructionId}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="savedCurrency" value="${currency?:'PHP'}"/>
<g:hiddenField name="bankCommissionPopupParamsHidden" value="${bankCommissionPopupParamsHidden}"/>
<g:hiddenField name="commitmentFeePopupParamsHidden" value="${commitmentFeePopupParamsHidden}"/>
<g:hiddenField name="cilexFeePopupParamsHidden" value="${cilexFeePopupParamsHidden}"/>
<g:hiddenField name="confirmingFeePopupParamsHidden" value="${confirmingFeePopupParamsHidden}"/>
<g:hiddenField name="documentaryStampPopupParamsHidden" value="${documentaryStampPopupParamsHidden}"/>
<g:hiddenField name="centavosPopup" value="${centavos}"/>


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
            %{--<g:select name="settlementCurrency" from="${["PHP","USD","EUR"]}" value="" data-orig="${settlementCurrency}" class="select_dropdown"/>--}%
            <g:if test="${documentClass.equals("EXPORT_ADVISING") || (documentClass.equals("IMPORT_ADVANCE") && serviceType.equals("REFUND"))}">
                <input type="text" name="settlementCurrency" id="settlementCurrency" data-orig="${settlementCurrency}" class="input_field" readonly="readonly" value="PHP" />
            </g:if>
            <g:else>
                <input class="tags_currency select2_dropdown bigdrop required" name="settlementCurrency" id="settlementCurrency" data-orig="${settlementCurrency}" />
            </g:else>
        </td>
    </tr>
</table>

%{--TODO: new approach to rates--}%
        <g:if test="${!documentClass.equals("EXPORT_ADVISING")}">
            <div class="grid_wrapper">
                <table class="foreign_exchange" id="forex_charges">
                    <tr>
                        <th class="rates">Rates</th>
                        <th class="rate_description">Rate Description</th>
                        <th class="pass_on_rate">Pass-on Rate</th>
                        <th class="special_rate">Special Rate</th>
                    </tr>
                    <g:each in="${exchange}" var="temp" status="i" ><tr>
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
                                     <g:hiddenField name="${temp.rates+'_pass_on_rate_settlement_urr'}" id="${temp.rates+'_pass_on_rate_settlement_urr'}" class="${temp.rates+'_pass_on_rate'}" value="${temp.pass_on_rate_settlement ?: temp.pass_on_rate}"/></td>
                                </td>
                                <td>
                                    <g:textField name="${temp.rates+'_text_special_rate_urr'}" id="${temp.rates+'_text_special_rate_urr'}" class="${temp.rates+'_special_rate'} numericRates product_rates" value="${temp.text_special_rate ?: temp.special_rate}" />
                                    <g:hiddenField name="${temp.rates+'_special_rate_settlement_urr'}" id="${temp.rates+'_special_rate_settlement_urr'}" class="${temp.rates+'_special_rate'} " value="${temp.text_special_rate ?: temp.special_rate}"/>
                                    <g:hiddenField name="${temp.rates+'_urr'}" class="${temp.rates+'_urr'}" value="${temp.text_special_rate ?: temp.special_rate}"/>
                                </td>
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
                                                   value="${temp.text_special_rate ?: special_rate_cash ?: temp.special_rate}"/></td>
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
                                                   value="${temp.text_special_rate ?: special_rate_cash ?: temp.special_rate}"/></td>
                            </g:else>
                        </tr>
                    </g:each>
                </table>
            </div>
        <table class="popup_full_width">
            <tr>
                <td class="label_width">Pass-on rates confirmed by:</td>
                <td><g:textField name="passOnRateConfirmedByCharges" value="${passOnRateConfirmedByCharges ?: passOnRateConfirmedBySettlement ?: passOnRateConfirmedByCash}" class="input_field"/></td>
                <td>
                    <input type="button" class="input_button_long actionWidget" value="Recompute Charge" name="recomputeChargeBtn" id="recomputeChargeBtn"/>
                </td>
            </tr>
        </table>
        </g:if>

<br/>

%{--TODO: new approach to charges--}%
    <span class="title_label">Charges</span>
    <br/>
    <br/>
    <table class="charges_table">
        <g:each in="${charges}">
           	<g:if test="${ ((it?.CHARGEID.toString().equalsIgnoreCase('REMITTANCE')) && (documentClass?.toString().equalsIgnoreCase('BC')))}">
            <%--ADDED BY MAX 7/4/2016 --%>
        			<tr>
	                    <td width="155"><span class="field_label">${it?.CHARGEDISPLAYVALUE ?: 'NOT_EXIST'}</span></td>
	                    <td><span class="charges_currency" id="${it?.CHARGECURRENCY ?: 'NOT_EXIST'}"></span></td>
	                    <td width="160"><g:textField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}" class="input_field_right" readonly="readonly" value="${it?.AMOUNT}" /></td>
	                    <g:if test="${(session.userrole.id.contains('BR') && referenceType.equalsIgnoreCase('ETS')) || (session.userrole.id.contains('TSD') && referenceType.equalsIgnoreCase('PAYMENT'))}">
	                        <td class="link"></td>
	                    </g:if>
	                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}overridenFlag" value="${it?.OVERRIDENFLAG}"/>
	                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}nocwtAmount" value="${it?.NOCWTAMOUNT}"/>
	                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}original" class="charges_original"/>
	                </tr>
        	</g:if>
        	<g:else>
	            <g:if test="${!(it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADVISING') || it?.CHARGEID.toString().equalsIgnoreCase('CORRES-CONFIRMING')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-EXPORT')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADDITIONAL'))}">
	                <tr>
	                    <td width="155"><span class="field_label">${it?.CHARGEDISPLAYVALUE ?: 'NOT_EXIST'}</span></td>
	                    <td><span class="charges_currency" id="${it?.CHARGECURRENCY ?: 'NOT_EXIST'}"></span></td>
	                    <td width="160"><g:textField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}" class="input_field_right" readonly="readonly" value="${it?.AMOUNT}" /></td>
	                    <g:if test="${((session.userrole.id.contains('BR') && referenceType.equalsIgnoreCase('ETS')) ||
	                            (session.userrole.id.contains('TSD') && referenceType.equalsIgnoreCase('PAYMENT')) ||
	                            (session.userrole.id.equals('TSDM') && referenceType.equalsIgnoreCase('DATA_ENTRY')))}">
	                         <td class="link"><a href="javascript:void(0)" id="${it?.EDITCHARGEID ?: 'NOT_EXIST'}">edit</a><g:hiddenField name="${it?.CHARGEHIDDEN ?: 'NOT_EXIST'}"/></td> 
	                    </g:if>
	                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}overridenFlag" value="${it?.OVERRIDENFLAG}"/>
	                    <g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}original" class="charges_original"/> 
	                </tr>
	            </g:if>
	        </g:else>
        </g:each>
    </table>
    <br/>
    <br/>
    
<g:each in="${charges}">
    <g:if test="${it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADVISING') || it?.CHARGEID.toString().equalsIgnoreCase('CORRES-CONFIRMING')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-EXPORT')|| it?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADDITIONAL')}">
        <span class="charges_title">Corres Charges</span>
        <br/><br/>
    </g:if>
</g:each>
    <table class="charges_table">
        %{--<g:each in="${charges}">--}%
            %{--<g:if test="${it?.CHARGEID?.toString().equalsIgnoreCase('CORRES-ADVISING') || it?.CHARGEID?.toString().equalsIgnoreCase('CORRES-CONFIRMING')|| it?.CHARGEID?.toString().equalsIgnoreCase('CORRES-EXPORT')|| it?.CHARGEID?.toString().equalsIgnoreCase('CORRES-ADDITIONAL')}">--}%
                %{--<tr>--}%
                    %{--<td width="155"><span class="field_label">${it?.CHARGEDISPLAYVALUE?: 'NOT_EXIST'}</span></td>--}%
                    %{--<td><span class="charges_currency" id="${it?.CHARGECURRENCY?: 'NOT_EXIST'}"></span></td>--}%
                    %{--<td width="160"><g:textField name="${it?.CHARGEFIELDID?: 'NOT_EXIST'}" class="input_field_right2" readonly="readonly"/></td>--}%
                    %{--<td class="link"><a href="javascript:void(0)" id="${it.EDITCHARGEID?: 'NOT_EXIST'}">edit</a><g:hiddenField name="${it.CHARGEHIDDEN?: 'NOT_EXIST'}" /></td>--}%
                    %{--<g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}overridenFlag" value="${it?.OVERRIDENFLAG?: 'NOT_EXIST'}"/>--}%
                    %{--<g:hiddenField name="${it?.CHARGEFIELDID ?: 'NOT_EXIST'}original" class="charges_original"/>--}%
                %{--</tr>--}%
            %{--</g:if>--}%
        %{--</g:each>--}%
        <g:each in="${charges}" var="aaa">
            <g:if test="${aaa?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADVISING') || aaa?.CHARGEID.toString().equalsIgnoreCase('CORRES-CONFIRMING')|| aaa?.CHARGEID.toString().equalsIgnoreCase('CORRES-EXPORT')|| aaa?.CHARGEID.toString().equalsIgnoreCase('CORRES-ADDITIONAL')}">
                <tr>
                	<g:if test="${documentClass.equals("BP")}">
                    	<td width="155"><span class="field_label">Advanced Corres Charge</span></td>
                    </g:if>
                    <g:else>
                    	<td width="155"><span class="field_label">${aaa?.CHARGEDISPLAYVALUE ?: 'NOT_EXIST'}</span></td>
                    </g:else>
                    <td><span class="charges_currency" id="${aaa?.CHARGECURRENCY ?: 'NOT_EXIST'}"></span></td>
                    <td width="160"><g:textField name="${aaa?.CHARGEFIELDID ?: 'NOT_EXIST'}" class="input_field_right" readonly="readonly" value="${aaa?.AMOUNT}"/></td>
                    <td class="link"><a href="javascript:void(0)" id="${aaa.EDITCHARGEID?: 'NOT_EXIST'}">edit</a><g:hiddenField name="${aaa.CHARGEHIDDEN?: 'NOT_EXIST'}" /></td>
                    <g:hiddenField name="${aaa?.CHARGEFIELDID ?: 'NOT_EXIST'}overridenFlag" value="${aaa?.OVERRIDENFLAG}"/>
                    <g:hiddenField name="${aaa?.CHARGEFIELDID ?: 'NOT_EXIST'}original"/>
                </tr>

            </g:if>
        </g:each>
    </table>    
<br/>
    <table class="charges_table">
        <tr>
            <td width="155"><span class="field_label">Total Amount Charges Due <br/> (in Settlement Currency)</span></td>
            <td><span class="charges_currency" id="totalAmountChargesCurrency"></span></td>
            <td><g:textField class="input_field_right" name="totalAmountCharges" readonly="readonly"/></td>
        </tr>
    </table>
    <input type="hidden" class="input_button_long actionWidget" value="Compute Total" name="recomputeSumBtn" id="recomputeSumBtn"/>
<br/>

<g:if test="${referenceType == 'ETS' || referenceType.equals("PAYMENT") || tsdInitiated ||
        ("DATA_ENTRY".equals(referenceType) && "BP".equals(documentClass))}">
<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="saveConfirmCharges" class="input_button actionWidget" value="Save" /></td>
    </tr>
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="cancelConfirmCharges" class="input_button_negative actionWidget" value="Cancel" /></td>
    </tr>
</table>
</g:if><g:else>
    <table class="buttons_for_grid_wrapper saveButtonsContainer">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="saveConfirmCharges" class="input_button actionWidget" value="Save" /></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="cancelConfirmCharges" class="input_button_negative actionWidget" value="Cancel" /></td>
        </tr>
    </table>
</g:else>

%{--popups--}%
<g:render template="../commons/popups/bank_commission_popup" />
<g:render template="../commons/popups/commitment_fee_popup" />
<g:render template="../commons/popups/cilex_popup" />
<g:render template="../commons/popups/documentary_stamp_popup" />
<g:render template="../commons/popups/documentary_stamp_negotiation_popup" />
<g:render template="../commons/popups/cancellation_fee_popup" />
<g:render template="../commons/popups/cable_fee_popup" />
<g:render template="../commons/popups/exports_advising_fee_popup" />
<g:render template="../commons/popups/other_local_bank_charges_popup" />
<g:render template="../commons/popups/supplies_popup" />
<g:render template="../commons/popups/interest_due_popup" />
<g:render template="../commons/popups/notarial_fee_popup" />
<g:render template="../commons/popups/advising_fee_popup" />
<g:render template="../commons/popups/confirming_fee_popup" />
<g:render template="../commons/popups/remittance_fee_popup" />
<g:render template="../commons/popups/postage_fee_popup" />
<g:render template="../commons/popups/corres_export_charge_popup" />

<script>

    $(document).ready(function () {
        if (documentClass != "EXPORT_ADVISING" && !(documentClass == "BP" && documentType == "FOREIGN") && !(documentClass == 'IMPORT_ADVANCE' && serviceType == 'REFUND')) {
            $("#settlementCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data', {id: '${settlementCurrency}'});
        }

		<%-- 03232017 - RM 4195 Edit by Pat - Included PHP, EUR and JPY that will be set as USDPHP only --%>
        if (documentClass == "BP" && documentType == "FOREIGN") {
        	if( '${currency}' == "USD" || '${currency}' == "PHP" || '${currency}' == "EUR" || '${currency}' == "JPY" ){
	            var autoCompleteUsdPhpOnlyCurrencyUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteUsdPhpOnlyCurrency")}';
    	        $("#settlementCurrency").setCurrencyDropdownUsdPhpOnly($(this).attr("id")).select2('data', {id: '${settlementCurrency}'});
            }
        }

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


<script>
    var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';

    function validateCharges() {
    	var error = 0;
    	$("#chargesTabForm :input").each(function(){
            if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
               if ($(this).val() == "") {
                   error ++;
               }
            }
        });
        //validation check for cifNumber
    	if ($("#cifNumber").attr("class") != undefined && $("#cifNumber").attr("class") != null && $("#cifNumber").attr("class").indexOf("required") != -1) {
            if ($("#cifNumber").val() == "") {
                error ++;
            }
         }
        return error;
    }

    $(document).ready(function() {
        if ($("#forex_product").length > 0 || $("#forex_settlement").length > 0) {
        	$("#forex_charges :input").attr("readonly", "readonly");
            $("#passOnRateConfirmedByCharges").attr("readonly", "readonly");
        }

        if ((documentClass == "IMPORT_ADVANCE" && serviceType != 'REFUND') || (documentType == "FOREIGN" && documentClass == "BC" && serviceType == "SETTLEMENT")) {
        	$("#settlementCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data', {id: '${settlementCurrency}'});
		} else if (documentClass != "EXPORT_ADVISING" && !(documentClass == "IMPORT_ADVANCE" && serviceType == 'REFUND')) {
            $("#settlementCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${settlementCurrency}'});
        }
//        loadForeignExchangeRates();

		/*
			added the if-condition documentClass!="BP" because it cause error on Export Bills, 
			verify the charges_tab_utility.js to be use for Export Bills.
		*/

        if (documentClass == "BP" && documentType == "FOREIGN") {
    	    if( '${currency}' == "USD" || '${currency}' == "PHP" || '${currency}' == "EUR" || '${currency}' == "JPY" ){
        	    var autoCompleteUsdPhpOnlyCurrencyUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteUsdPhpOnlyCurrency")}';
        	    $("#settlementCurrency").setCurrencyDropdownUsdPhpOnly($(this).attr("id")).select2('data', {id: '${settlementCurrency}'});
            }
        }

		if(documentClass != "BP" && documentClass != "BC" && documentClass != "CORRES_CHARGE" && documentClass != "IMPORT_ADVANCE") {
			onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
	        checkForOtherCurrency();
		}

        if ($("#saveConfirmCharges").length > 0) {
            $("#saveConfirmCharges").click(function() {
            	if(validateCharges() > 0){
            		$("#alertMessage").text("Please fill in all the required fields.");
            		triggerAlert();
            	} else if($("#documentClass").val() == "EXPORT_ADVISING" && $("#grid_list_charges_payment tr").length > 1) {
            		$("#alertMessage").text("Please remove payment before saving charges.");
            		triggerAlert();
            	} else {
            		mCenterPopup($("#loading_div"), $("#loading_bg"));
 	            	mLoadPopup($("#loading_div"), $("#loading_bg"));
                    $("#chargesTabForm").submit();
            	}
            })
        }
        if ($("#cancelConfirmCharges").length > 0) {
            $("#cancelConfirmCharges").click(function() {
                mDisablePopup($("#chargesDiv"), $("#chargesBg"));
                location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            });
        }
    });
</script>