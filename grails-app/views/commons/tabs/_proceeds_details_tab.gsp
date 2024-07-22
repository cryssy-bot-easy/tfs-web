<g:javascript src="grids/proceeds_summary.js" />
<%--<g:javascript src="utilities/commons/proceeds_details_utility.js" />--%>

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

<script type="text/javascript">
    %{--var proceedsChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';--}%
    var proceedsChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProceedsPayments')}';
    proceedsChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    proceedsChargeUrl += "&referenceType=" + $("#referenceType").val();
    proceedsChargeUrl += "&form=proceedsDetails";

    var settleFlag = '${settleFlag}';

    $(document).ready(function() {
        if ((serviceType.toUpperCase() == "AMENDMENT" && documentSubType1.toUpperCase() == "CASH") ||
                (serviceType.toUpperCase() == "ADJUSTMENT" && documentSubType1.toUpperCase() == "REGULAR" && partialCashSettlementFlag.toUpperCase() == "PARTIALCASHSETTLEMENTENABLED") ||
                (serviceType.toUpperCase() == "OPENING" && documentSubType1.toUpperCase() == "CASH") ||
                serviceType.toUpperCase() == "NEGOTIATION" ||
                (serviceType.toUpperCase() == "UA LOAN SETTLEMENT" || serviceType.toUpperCase() == "UA_LOAN_SETTLEMENT") ||

                // for non-lc
                (documentType.toUpperCase() == "DOMESTIC" && settleFlag != 'Y')) {

//            $("#containsProductPayment").val("");
            if ($("#containsProductPayment").length > 0) {
                if ($(".cash_lc_payment_tab").length > 0 && !($(".cash_lc_payment_tab").is(":hidden"))) {
                    $("#containsProductPayment").val("true");
                } else {
                    $("#containsProductPayment").val("");
                }
            }
        }
    });
</script>


	<table class="charges_table">
		<tr>
			<td width="160"><span class="field_label"> Proceeds Amount </span></td>
			<td><g:textField class="input_field_short trans_currency center" name="proceedsCurrency" value="${currency ?: negotiationCurrency}" readonly="readonly"/></td>
			<td>
                <g:textField class="input_field_right numericCurrency" name="proceedsAmount" value="${documentClass in ['DA', 'DR', 'DP', 'OA'] ? productAmount : negotiationAmount}" readonly="readonly"/>
            </td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>
<%--		<tr>--%>
<%--			<td width="160"><span class="field_label"> Remaining Balance </span></td>--%>
<%--			<td><g:textField class="input_field_short trans_currency center" name="remainingCurrencyBalance" value="${currency ?: negotiationCurrency}" readonly="readonly"/></td>--%>
<%--			<td><g:textField class="input_field_right" name="remainingAmountBalance" value="" readonly="readonly"/></td>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td>&#160;</td>--%>
<%--		</tr>--%>
<%--		<tr>--%>
<%--			<td width="160"><span class="field_label">Amount of Payment</span></td>--%>
<%--			<td>--%>
<%--                <g:textField value="${currency ?: negotiationCurrency}" name="amountOfPaymentCurrencyProceedBeneficiary" class="input_field_short" readonly="readonly" />--%>
<%--            </td>--%>
<%--			<td class="editable"><g:textField name="amountOfPaymentProceedBeneficiary" class="input_field_right numericCurrency" /></td>--%>
<%--		</tr>--%>
	</table>
<br/>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_proceeds" value="Add Settlement Mode" />
<br /><br/>
<span class="title_label">Proceeds Summary</span>
<div class="grid_wrapper fix"> <%-- JQGRID --%>
    <table id="grid_list_proceeds_payment_summary"> </table>
    <%--<div id="grid_pager_proceeds_payment_summary"></div>--%>
    <g:hiddenField name="proceedsPaymentSummary" value="" />
</div>
<table>
  	<tr>
		<td>
		<table>
		 <tr>
			<td><span class="field_label"> Total Amount of Payment </span> </td>
			<td><g:textField name="totalProceedsPayment" value="${totalProceedsPayment}" class="input_field_right" readonly="readonly"/></td>
		 </tr>
		</table>
		</td>
	</tr>
</table>
<br/>
<br/>

<g:hiddenField name="containsProductPayment" value="${containsProductPayment}" />

<%-- for Payment Summary report --%>
<g:hiddenField name="noChargesPaymentSummary"/>

<g:if test="${!referenceType?.equals("PAYMENT")}">
    <g:render template="../layouts/buttons_for_grid_wrapper" />
</g:if>
<script type="text/javascript">
var validateSavedChargesPaymentsUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedChargesPayments')}';
var hideToRemove = 0;
function proceedsSummaryViewChargesTab(event) {
	var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	var gridDataProceedsTeller = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");

	if(documentType == "DOMESTIC" && documentSubType1 == "CASH" && documentClass == "LC" && serviceType == "Negotiation") {
		if (gridDataProceedsTeller.length == 0){
			$(".charges_tab").remove();
			$(".charges_payment_tab").remove();
			$("#noChargesPaymentSummary").val("");
		} else {
			$.each(gridDataProceedsTeller,function(idx, data) {
				if(data.modeOfPayment == "Issuance to MC" || data.modeOfPayment == "Credit to CASA") {
					$(".charges_tab").remove();
					$(".charges_payment_tab").remove();
					$("#noChargesPaymentSummary").val("true");
					$(".showBillingStatement").remove();
	<%--			} else {--%>
	<%--				$(".charges_tab").show();--%>
	<%--				$(".charges_payment_tab").show();--%>
				}
			});
		}
	}

	var count = 0;
	if(serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT" ||
			(documentType == "DOMESTIC" && documentClass == "LC" && (serviceType == "Negotiation" || serviceType == "NEGOTIATION") &&
			 (documentSubType1 == "STANDBY" || (documentSubType1 == "REGULAR" && documentSubType2 == "SIGHT")))) {
		if (gridDataProceedsTeller.length == 0 && gridDataCashPayment.length == 0){
			hideToRemove++;
		} else {
			$.each(gridDataCashPayment,function(idx, data) {
				if(data.modeOfPayment == "DTR Loan") {
					count++;
				} 
			});

			$.each(gridDataProceedsTeller,function(idx, data) {
				if(data.modeOfPayment == "Remittance via PDDTS" || data.modeOfPayment == "Remittance via SWIFT") {
					count++;
				}
			});	
	
			if(count == 0) {
				hideToRemove++;
			}
		}
		if ($("#grid_list_cash_payment_summary").length + $("#grid_list_proceeds_payment_summary").length == hideToRemove){
			$(".charges_tab").remove();
			$(".charges_payment_tab").remove();
			hideToRemove = 0;
		}
	}
}
</script>