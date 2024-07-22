%{--<g:javascript src="grids/cash_lc_payment_jqgrid.js" />--}%
<g:javascript src="new/import_advance/product_payment_grid.js" />
<g:javascript src="utilities/ets/commons/cash_lc_payment_tab_utility.js" />

<script type="text/javascript">
    var convertRatesUrl = '${g.createLink(controller:'foreignExchange', action:'convertCashRates')}';
    %{--var productChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';--}%
    var productChargeUrl = '${g.createLink(controller:'product', action:'displayProductPaymentsGrid')}';
    productChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    productChargeUrl += "&referenceType=" + $("#referenceType").val();
    productChargeUrl += "&serviceType="+$("#serviceType").val();
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

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:hiddenField name="setupProductPayment" class="required" value="${setupProductPayment}"/>

    <table class="charges_table">
    	<g:if test="${'BC'.equals(documentClass) && bpCurrency}">
        <tr>
            <td><span class="field_label"> ${bpLoanLabel}</span></td>
            <td>
                <span class="charges_currency" id="bookingCurrency">${bookingCurrency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${loanAmount}" name="loanAmount" readonly="readonly"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> ${proceedsReceivedlabel}</span></td>
            <td>
                <span class="charges_currency" id="proceedsReceivedCurrency">${bookingCurrency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${proceedsReceivedinBookingCurrency}" name="proceedsReceivedinBookingCurrency" readonly="readonly"/></td>
            <td class="space"/>
            <td>
                <span class="charges_currency" id="proceedsCurrency">${currency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${proceedsReceived ?: proceedsAmount}" name="proceedsReceived" readonly="readonly"/></td>
        </tr>
        <tr>
        	<td><br/></td>
        </tr>
        </g:if>
        <tr>
            <td><span class="field_label"> ${totalAmountDueCurrencyLabel}</span></td>
            <td>
                <span class="charges_currency" id="totalAmountDueLcCurrency">${bookingCurrency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${totalAmountDueLc}" name="totalAmountDueLc" readonly="readonly"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> ${totalAmountDueAmountLabel}</span></td>
            <td>
                <span class="charges_currency" id="remainingBalancLcCurrency">${bookingCurrency}</span>
            </td>
            <td><g:textField class="input_field_right" value="${remainingBalanceLc}" name="remainingBalanceLc" readonly="readonly"/></td>
        </tr>
    </table>
<br />
<span class="title_label"> Payment Details for Charges </span>
<table>
    <tr>
        <td width="235"><span class="field_label">&nbsp;Settlement Currency <br /></span></td>
        <td>
            <%-- Auto Complete --%>
            <input class="tags_currency select2_dropdown bigdrop" name="settlementCurrencyLc" id="settlementCurrencyLc" />
        </td>
    </tr>
</table>

<g:if test="${currency}">
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
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="rates">${temp.rates}</td>
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
                        <td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}"/>
                            <g:hiddenField name="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}"/></td>
                        <td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}"/>
                            <g:hiddenField name="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}"/></td>
                    </g:else>
                </tr>
            </g:each>
        </table>
    </div>
</g:if>
<table class="popup_full_width">
    <tr>
        <td width="240">Pass-on rates confirmed by: <g:if test="${exchange.size() > 1}"><span class="asterisk"> * </span></g:if></td>
        <td><g:textField name="passOnRateConfirmedByCash" class="input_field ${exchange.size() > 1 ? 'required' : ''}" value="${passOnRateConfirmedByCash}"/></td>
        %{--if foreign--}%
        <td>
            <input type="button" class="input_button_long" value="Recompute" name="recomputeChargeBtnCashLc" id="recomputeChargeBtnCashLc"/>
        </td>
    </tr>
</table>
<br />
<table class="charges_table">
    <tr>
        <td width="235">
            <span class="field_label" id="paymentDescription"> ${amountInPaymentInCurrencyLabel}</span>
        </td>
        <td>
            <span class="charges_currency" id="cashAmountInSettlementCurrency"></span>
        </td>
        <td class="editable"><g:textField class="input_field_right numericCurrency" name="cashAmountInSettlement" /></td>
    </tr>
    <tr>
        <td width="235">
            <span class="field_label"> ${amountInPaymentInDocumentCurrencyLabel}</span>
        </td>
        <td>
            <span class="charges_currency" id="cashAmountInLcCurrency">${currency}</span>
        </td>
        <td class="editable"><g:textField class="input_field_right numericCurrency" name="cashAmountInLc"/></td>
    </tr>
</table>
<br/>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_cash" value="Add Settlement" />
<br /><br/>


    <span class="title_label">Payment Summary for Cash LC</span>
<div class="grid_wrapper fix"> <%-- JQGRID --%>
    <table id="grid_list_cash_payment_summary"> </table>
    <div id="grid_pager_cash_payment_summary"></div>
    <g:hiddenField name="documentPaymentSummary" value="" />
</div>
<table class="charges_payment_table">
    <tr>
        <td width="235"><span class="field_label"> ${totalAmountInCurrencyLabel} </span></td>
        <td><g:textField class="input_field_right" value="" name="totalAmountOfPaymentLc" readonly="readonly"/></td>
    </tr>
    <tr>
        <td width="180"><span class="field_label"> ${excessAmountInCurrencyLabel} </span></td>
        <td><g:textField class="input_field_right" value="" name="excessAmountLc" readonly="readonly"/></td>
    </tr>
</table>
<br/>

%{--<g:if test="${!(documentClass?.equals("IMPORT_ADVANCE") && referenceType?.equals("DATA_ENTRY")) || referenceType == 'ETS'}">--}%
    %{--<g:render template="../product/commons/save_buttons" />--}%
    %{--<table class="buttons_for_grid_wrapper saveButtonsContainer">--}%
        %{--<tr>--}%
            %{--<%-- BUTTON --%>--}%
            %{--<td><input type="button" id="saveConfirmProductPayment" class="input_button" value="Save" /></td>--}%
        %{--</tr>--}%
        %{--<tr>--}%
            %{--<%-- BUTTON --%>--}%
            %{--<td><input type="button" id="cancelConfirmProductPayment" class="input_button_negative" value="Cancel" /></td>--}%
        %{--</tr>--}%
    %{--</table>--}%
%{--</g:if>--}%

<script>
	var autoCompleteUsdPhpOnlyCurrencyUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteUsdPhpOnlyCurrency")}';
    $(document).ready(function() {
        if($("#proceedsCurrency").text() == $("#proceedsReceivedCurrency").text()){
                $("#proceedsReceivedinBookingCurrency").val($("#proceedsReceived").val());
        } else {
            var convert_rate = 1;
            if($("#proceedsReceivedCurrency").text() == 'PHP'){
                if($("#proceedsCurrency").text() == 'USD'){
                    convert_rate = 1 / parseFloat($("#USD-PHP_special_rate_cash").val().replace(/,/g,""));
                } else {
                    convert_rate = 1 / parseFloat($("#"+$("#proceedsCurrency").text()+"-USD_special_rate_cash").val().replace(/,/g,"") * $("#USD-PHP_special_rate_cash").val().replace(/,/g,""));
                }
            } else if($("#proceedsReceivedCurrency").text() == 'USD'){
            	if($("#proceedsCurrency").text() == 'PHP'){
                    convert_rate = parseFloat($("#USD-PHP_special_rate_cash").val().replace(/,/g,""));
                } else {
                    convert_rate = parseFloat($("#"+$("#proceedsCurrency").text()+"-USD_special_rate_cash").val().replace(/,/g,""));
                }
            }

            $("#proceedsReceivedinBookingCurrency").val(parseFloat($("#proceedsReceived").val().replace(/,/g,"") * convert_rate));
        }
        $("#totalAmountDueLc").val(parseFloat($("#loanAmount").val().replace(/,/g,"") - $("#proceedsReceivedinBookingCurrency").val().replace(/,/g,"")));
		$("#settlementCurrencyLc").setSettlementCurrencyDropdown($(this).attr("id"));
        hideUnrelatedExchangeRates();
        onSettlementCurrencyCashChange();
        loadRelatedExchangeRates();
        if ($.isFunction(window.checkForOtherCurrency)) {
            checkForOtherCurrency();
        }

        if ($("#saveConfirmProductPayment").length > 0) {
            $("#saveConfirmProductPayment").click(function() {
            	if(validateExportTab("#productPaymentTabForm") > 0){
                    $("#alertMessage").text("Please fill in all the required fields.");
                    triggerAlert();
                } else {
	                var productSummaryData = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	                $("#documentPaymentSummary").val(JSON.stringify(productSummaryData));
	                mCenterPopup($("#loading_div"), $("#loading_bg"));
	            	mLoadPopup($("#loading_div"), $("#loading_bg"));
	                $("#productPaymentTabForm").submit();
                }
            })
        }

        if ($("#cancelConfirmProductPayment").length > 0) {
            $("#cancelConfirmProductPayment").click(function() {
                mDisablePopup($("#productPaymentDiv"), $("#productPaymentBg"));
                location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            })
        }

        if($("#forex_product tr").length >= 2) {
    		$(".passOnRatesConfirmedByAsterisk").addClass("asterisk");
    		$(".passOnRatesConfirmedByAsterisk").removeClass("clear_font");
		} else {
			$(".passOnRatesConfirmedByAsterisk").addClass("clear_font");
    		$(".passOnRatesConfirmedByAsterisk").removeClass("asterisk");
		}

        if($("#remainingBalanceLc").length == 0) $("#setupProductPayment").val(true);
        
        $("#remainingBalanceLc").change(function(event){
            if($(this).val() == "0.00"){
                $("#setupProductPayment").val(true);
            }else{
                $("#setupProductPayment").val("");
            }
        });
    });
</script>