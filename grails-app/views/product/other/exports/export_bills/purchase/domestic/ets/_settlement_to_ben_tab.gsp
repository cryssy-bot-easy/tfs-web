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
            <input type="text" class="input_field_right numericCurrency" id="proceedsAmount" name="proceedsAmount" value="${proceedsAmount ?: amount}" readonly="readonly" />
        </td>
    </tr>
</table>
<table class="tabs_forms_table">
    <tr>
        <td width="165"><span class="field_label"> Proceeds Currency </span></td>
        <td><input class="tags_currency select2_dropdown bigdrop" name="newProceedsCurrency" id="newProceedsCurrency" /></td>
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
			<td>${temp.rate_description}</td>
			<g:if test="${temp.rate_description.contains('BOOKING')}">
				<td class="urr">${temp.pass_on_rate.toString()}</td>
				<td class="urr">${temp.special_rate.toString()}<g:hiddenField name="${temp.rates+'_urr'}" value="${temp.special_rate.toString()}"/></td>
			</g:if>
			<g:else>
				<td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_settlement'}" value="${temp.pass_on_rate}" /> <g:hiddenField name="${temp.rates+'_pass_on_rate_settlement'}" value="${temp.pass_on_rate}"/></td>
				<td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_settlement'}" value="${temp.special_rate}" /> <g:hiddenField name="${temp.rates+'_special_rate_settlement'}" value="${temp.special_rate}"/></td>
			</g:else>
		</tr>
		</g:each>
	</table>
</div>
<table class="popup_full_width">
    <tr>
        <td width="160">Pass-on rates confirmed by: <g:if test="${exchange.size() > 1}"><span class="asterisk"> * </span></g:if></td>
        <td><g:textField name="passOnRateConfirmedBySettlement" value="${passOnRateConfirmedBySettlement ?: passOnRateConfirmedByCash}" class="input_field ${exchange.size() > 1 ? 'required' : ''}"/></td>
        <td><input type="button" class="input_button_long actionWidget" value="Recompute Charge" name="recomputeChargeBtn" id="recomputeChargeBtn"/></td>
    </tr>
</table>
<br/>
<table class="charges_table">
    <tr>
        <td width="160"><span class="field_label">Proceeds Amount (in Proceeds Currency) </span></td>
        <td><g:textField class="input_field_short trans_currency center" name="proceedsCurrencyModified" readonly="readonly"/></td>
        <td><g:textField class="input_field_right numericCurrency" name="proceedsAmountModified" readonly="readonly"/></td>
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
        if('${exportViaPddtsFlag}' == '1'){
            $("#newProceedsCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${'USD'}'});
            $("#newProceedsCurrency").select2("disable");
            $("#proceedsCurrencyModified").val("USD");
            if($("#proceedsCurrency").val() == "USD"){
            	$("#proceedsAmountModified").val($("#proceedsAmount").val());
            } else {
            	if($("#proceedsCurrency").val() != 'PHP' && $("#proceedsCurrency").val() != 'USD'){
	               	params = {
						currency: $("#proceedsCurrency").val(),
						amount: stripCommas($("#proceedsAmount").val()),
						proceedsCurrency: 'USD',
						usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val()),
						thirdsToUsd: stripCommas($("#" + $("#proceedsCurrency").val() + "-USD_special_rate_settlement").val())
	               	}
	            } else {
	            	params = {
	  					currency: $("#proceedsCurrency").val(),
	  					amount: stripCommas($("#proceedsAmount").val()),
	  					proceedsCurrency: 'USD',
	  					usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val())
	            	}
	            }
	            $.post(convertSettlementRatesUrl, params, function (data) {
	                $("#proceedsAmountModified").val(data.proceedsAmount);
	            });
            }
        } else {
            $("#newProceedsCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${newProceedsCurrency}'});
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
            $("#passOnRateConfirmedBySettlement").attr("readonly", "readonly");
        }

        $("#newProceedsCurrency").change(function(){
            $("#proceedsCurrencyModified").val($(this).val());
            var params;
            if($(this).val() != $("#proceedsCurrency").val() && $(this).val() != ""){
	            if($("#proceedsCurrency").val() != 'PHP' && $("#proceedsCurrency").val() != 'USD'){
	               	params = {
						currency: $("#proceedsCurrency").val(),
						amount: stripCommas($("#proceedsAmount").val()),
						proceedsCurrency: $(this).val(),
						usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val()),
						thirdsToUsd: stripCommas($("#" + $("#proceedsCurrency").val() + "-USD_special_rate_settlement").val())
	               	}
	            } else {
	            	params = {
	  					currency: $("#proceedsCurrency").val(),
	  					amount: stripCommas($("#proceedsAmount").val()),
	  					proceedsCurrency: $(this).val(),
	  					usdToPhp: stripCommas($("#USD-PHP_special_rate_settlement").val() ? $("#USD-PHP_special_rate_settlement").val() : $("#USD-PHP_urr").val())
	            	}
	            }
	            $.post(convertSettlementRatesUrl, params, function (data) {
	                $("#proceedsAmountModified").val(data.proceedsAmount);
	            });
            } else if($(this).val() == ""){
            	$("#proceedsAmountModified").val("");
            } else {
                $("#proceedsAmountModified").val($("#proceedsAmount").val());
            }
        });

        $("#newProceedsCurrency").change();
    });
</script>