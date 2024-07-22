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
	Project Name: _settlement_to_ben_tab.gsp
--%>

<%-- 
(revision)
SCR/ER Number:
SCR/ER Description:
[Revised by:] Cedrick C. Nungay
[Date revised:] 03/21/2017
Program [Revision] Details: Update id of Recompute Charge button to avoid conflict on Recompute Charge button on charges tab.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _settlement_to_ben_tab.gsp
--%>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="proceeds" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:hiddenField name="chargeType" value="SETTLEMENT" />

<table class="charges_table">
    <tr>
        <td width="160"><span class="field_label">Proceeds Amount </span></td>
        <td><g:textField class="input_field_short trans_currency center" name="proceedsCurrency" value="${currency ?: negotiationCurrency}" readonly="readonly"/></td>
        <td>
            <g:if test="${tradeServiceId==null}">
                <input type="text" class="input_field_right numericCurrency" id="amountForCredit" name="amountForCredit" value="${amountForCredit ?: proceedsAmount ?: amount }" readonly="readonly" />
            </g:if>
            <g:else>
                <input type="text" class="input_field_right numericCurrency" id="amountForCredit" name="amountForCredit" value="${amountForCredit ?: proceedsAmount ?: new BigDecimal(amount?.replace(',','')) - new BigDecimal(advanceInterest?.replace(',','')) }" readonly="readonly" />
            </g:else>
        </td>
    </tr>
</table>
<table class="tabs_forms_table">
    <tr>
        <td width="165"><span class="field_label"> Proceeds Currency </span></td>
        <td><input class="tags_currency select2_dropdown bigdrop settleCurrDd" name="newProceedsCurrency" id="newProceedsCurrency" data-orig="${newProceedsCurrency}" data-condition="${exportViaPddtsFlag == '1'}" /></td>
    </tr>
</table>
<div class="grid_wrapper">
	<table class="foreign_exchange" id="forex_settlement">
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
			<g:else>
				<td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}" value="${temp.rates}"/></td>
			</g:else>
			<td>${temp.rate_description_lbp}</td>
			<g:if test="${temp.rate_description.contains('BOOKING')}">
				<td class="urr">${temp.text_pass_on_rate ?: temp.pass_on_rate}</td>
				<td class="urr">${temp.text_special_rate ?: temp.special_rate}<g:hiddenField name="${temp.rates+'_urr'}" value="${temp.special_rate.toString()}"/></td>
			</g:if>
			<g:else>
				<td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_settlement'}" value="${temp.pass_on_rate}" /> <g:hiddenField name="${temp.rates+'_pass_on_rate_settlement'}" value="${temp.pass_on_rate}"/></td>
<%--				<td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_settlement'}" value="${temp.special_rate}" /> <g:hiddenField name="${temp.rates+'_special_rate_settlement'}" value="${temp.special_rate}"/></td>--%>
				<td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_settlement'}" value="${temp.text_special_rate ?: temp.special_rate}" /> <g:hiddenField name="${temp.rates+'_special_rate_settlement'}" value="${temp.special_rate}"/></td>
			</g:else>
		</tr>
		</g:each>
	</table>
</div>
<table class="popup_full_width">
    <tr>
        <td class="field_label">Pass-on rates confirmed by: 
<%--        	<g:if test="${exchange.size() > 1}"><span class="asterisk"> * </span></g:if>--%>
       	</td>
<%--        <td><g:textField name="passOnRateConfirmedBySettlement" value="${passOnRateConfirmedBySettlement ?: passOnRateConfirmedByCash}" data-orig="${passOnRateConfirmedByCash ?: passOnRateConfirmedBySettlement ?: ''}" class="input_field ${exchange.size() > 1 ? 'required' : ''}"/></td>--%>
        <td><g:textField name="passOnRateConfirmedBySettlement" value="${passOnRateConfirmedBySettlement ?: passOnRateConfirmedByCash}" data-orig="${passOnRateConfirmedByCash ?: passOnRateConfirmedBySettlement ?: ''}" class="input_field" readonly="readonly"/></td>
        <td><input type="button" class="input_button_long actionWidget" value="Recompute Charge" name="recomputeChargeBtn" id="recomputeChargeBtnSettlement"/></td>
    </tr>
</table>
<br/>
<table class="charges_table">
    <tr>
        <td width="160"><span class="field_label">Proceeds Amount (in Proceeds Currency) </span></td>
        <td><g:textField class="input_field_short trans_currency center" name="proceedsCurrencyModified" value="${proceedsCurrencyModified}" readonly="readonly"/></td>
        <td><g:textField class="input_field_right numericCurrency" name="proceedsAmountModified" value="${proceedsAmountModified}" readonly="readonly"/></td>
    </tr>
</table>

<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_proceeds" value="Add Settlement Mode" />

<br /><br/>
<h3 id="tab_titles">Proceeds Summary </h3>

<div class="grid_wrapper fix"> <%-- JQGRID --%>
    <table id="grid_list_proceeds_payment_summary"> </table>
    <g:hiddenField name="proceedsPaymentSummary" value="" />
</div>
<table>
  	<tr>
		<td>
		<table>
		 <tr>
			<td><span class="field_label"> Total Amount of Payment </span> </td>
			<td><g:textField name="totalProceedsPayment" value="${totalProceedsPayment}" class="input_field_right numericCurrency" readonly="readonly"/></td>
		 </tr>
		</table>
		</td>
	</tr>
</table>
<br/>

<g:if test="${referenceType == 'ETS'}">
    <table class="buttons_for_grid_wrapper saveButtonsContainer">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="saveConfirmSettlementToBen" class="input_button" value="Save" /></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="cancelConfirmSettlementToBen" class="input_button_negative" value="Cancel" /></td>
        </tr>
    </table>
</g:if>

<g:hiddenField name="containsProductPayment" value="${containsProductPayment}" />

<g:javascript src="new/export_advance/settlement_to_ben_tab.js" />
<script type="text/javascript">
    var settlementToBenGridUrl = '${g.createLink(controller: "exportAdvance", action: (referenceType == 'DATA_ENTRY') ? "displaySettlementToBenDataEntryGrid" : "displaySettlementToBenEtsGrid")}';
    var convertSettlementRatesUrl = '${g.createLink(controller:'foreignExchange', action:'convertSettlementRates')}';

    $(document).ready(function() {

    	<%-- 04192017 - Onload function to call recompute - Added by Pat --%>
    	$("#recomputeChargeBtnSettlement").click();
        
        if('${exportViaPddtsFlag}' == '1'){
            $("#newProceedsCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${'USD'}'});
            $("#newProceedsCurrency").select2("disable");
            $("#proceedsCurrencyModified").val("USD");
            if($("#proceedsCurrency").val() == "USD"){
            	$("#proceedsAmountModified").val($("#amountForCredit").val());
            } else {
            	if($("#proceedsCurrency").val() != 'PHP' && $("#proceedsCurrency").val() != 'USD'){
	               	params = {
						currency: $("#proceedsCurrency").val(),
						amount: stripCommas($("#amountForCredit").val()),
						proceedsCurrency: 'USD',
						usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val()),
						thirdsToUsd: stripCommas($("#" + $("#proceedsCurrency").val() + "-USD_special_rate_settlement").val())
	               	}
	            } else {
	            	params = {
	  					currency: $("#proceedsCurrency").val(),
	  					amount: stripCommas($("#amountForCredit").val()),
	  					proceedsCurrency: 'USD',
	  					usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val())
	  					
	            	}
	            }
	            $.post(convertSettlementRatesUrl, params, function (data) {
	                $("#proceedsAmountModified").val(data.proceedsAmount);
	            });
            }
        } else {
			<%--  03232017 - RM 4195 Edit by Pat - Used a different method in autocompleteutility js to use only USD and PHP in settlement currency--%>
			<%--  $("#newProceedsCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${newProceedsCurrency}'});--%>
            $("#newProceedsCurrency").setNewSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${newProceedsCurrency}'});
        }
		if (referenceType == "DATA_ENTRY"){
			setupSettlementToBenDataEntryGrid();
		} else { 
        	setupSettlementToBenEtsGrid();
		}
        if ($("#saveConfirmSettlementToBen").length > 0) {
            $("#saveConfirmSettlementToBen").click(function() {
            	if(validateExportTab("#proceedsDetailsTabForm") > 0){
            		$("#alertMessage").text("Please fill in all the required fields.");
            		triggerAlert();
             	} else if($("#grid_list_proceeds_payment_summary").jqGrid("getRowData").length == 0){
                 	triggerAlertMessage("Please Complete Settlement Payment.");
             	} else {
	                var productSummaryData = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
	                $("#proceedsPaymentSummary").val(JSON.stringify(productSummaryData));
	                mCenterPopup($("#loading_div"), $("#loading_bg"));
	            	mLoadPopup($("#loading_div"), $("#loading_bg"));
	                $("#proceedsDetailsTabForm").submit();
               	}
            })
        }

        if ($("#cancelConfirmSettlementToBen").length > 0) {
            $("#cancelConfirmSettlementToBen").click(function() {
                mDisablePopup($("#settlementToBenDiv"), $("#settlementToBenBg"));
                location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            })
        }
        if ($("#forex_product").length > 0) {
        	$("#forex_settlement :input").attr("readonly", "readonly");
        	<%-- 03282017 - RM #4198 - Interim fix by Pat to make 'Pass-on rate confirmed by' editable (but this field is being extracted from Nego Payment) --%>
			<%-- $("#passOnRateConfirmedBySettlement").attr("readonly", "readonly");--%>
        }

        $("#newProceedsCurrency").change(function(){
            $("#proceedsCurrencyModified").val($(this).val());
            var params;
            if($(this).val() != $("#proceedsCurrency").val() && $(this).val() != ""){
	            if($("#proceedsCurrency").val() != 'PHP' && $("#proceedsCurrency").val() != 'USD'){
	               	params = {
						currency: $("#proceedsCurrency").val(),
						amount: stripCommas($("#amountForCredit").val()),
						proceedsCurrency: $(this).val(),
<%--						usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val()),--%>
<%--						thirdsToUsd: stripCommas($("#" + $("#proceedsCurrency").val() + "-USD_special_rate_settlement").val())--%>
						usdToPhp: stripCommas($("#USD-PHP_text_special_rate").val() ? $("#USD-PHP_text_special_rate").val() : $("#USD-PHP_urr").val()),
						thirdsToUsd: stripCommas($("#" + $("#proceedsCurrency").val() + "-USD_text_special_rate").val())
	               	}
	            } else {
	            	params = {
	  					currency: $("#proceedsCurrency").val(),
	  					amount: stripCommas($("#amountForCredit").val()),
	  					proceedsCurrency: $(this).val(),
<%--	  					usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val())--%>
	  					usdToPhp: stripCommas($("#USD-PHP_text_special_rate").val() ? $("#USD-PHP_text_special_rate").val() : $("#USD-PHP_urr").val())
	            	}
	            }
	            $.post(convertSettlementRatesUrl, params, function (data) {
	                $("#proceedsAmountModified").val(data.proceedsAmount);
	            });
            } else if($(this).val() == ""){
            	$("#proceedsAmountModified").val("");
            } else {
                $("#proceedsAmountModified").val($("#amountForCredit").val());
            }
        });

        if ($("#containsProductPayment").length > 0) {
            $("#containsProductPayment").val("true");
        }

        $("#recomputeChargeBtnSettlement").click(function() { 
            $("#newProceedsCurrency").trigger("change");
        });

        $("#newProceedsCurrency").change();
    });
</script>