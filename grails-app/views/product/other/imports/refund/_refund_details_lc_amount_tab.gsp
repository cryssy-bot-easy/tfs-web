<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="refundDetailsLcAmountTab" />

<table class="charges_table">
	<tr>
		<td><label><g:radio name="refundOption" value="PARTIAL"/>Partial Amount for Refund (in LC Currency)</label></td>
		<td colspan="2">
            <g:textField class="input_field_short" name="partialRefundCurrency" value="${currency}" readonly="readonly"/>
        </td>
		<td class="editable">
            <g:textField name="partialAmountForRefund" class="input_field_right numericCurrency"  />
        </td>
        <td class="editable" style="border: none">
            &nbsp;<input type="button" id="update_cash" class="popup_btn"/>
        </td>
	</tr>

	<tr>
        <td><label><g:radio name="refundOption" value="OTHERS"/>Others</label></td>
        <td colspan="2" class="editable" style="border: none">
            &nbsp;
        </td>
        <td class="editable" style="border: none">
            <g:select name="productTransaction" from="${approvedTradeServices?.serviceType}"
                      keys="${approvedTradeServices?.tradeServiceId}" value="" noSelection="${['':"SELECT ONE..."]}" class="select_dropdown"/>
        </td>
        <td class="editable" style="border: none">
            &nbsp;<input type="button" id="update_product_amount" class="popup_btn"/>
        </td>
	</tr>
</table>
<br/>
<span class="buttons">
<input type="button" name="clearButton" class="input_button" id="clearButton" value="Clear"/>
</span>
<span class="title_label">Refund Details Summary for Cash LC</span>
<br/>
<br/>

<div class="grid_wrapper">
    <table id="grid_list_refund_details_summary_cash_lc"></table>
</div>

<br />
<table class="charges_table">
	<tr>
		<td><span class="field_label title_label">Total Amount of Charges Due</span></td>
		<td><g:textField name="refundCurrency" class="input_field_short" readonly="readonly" value="PHP"/></td>
		<td><g:textField name="totalRefundProductAmount" class="input_field_right" readonly="readonly"/></td>
	</tr>
</table>
<br /><br />

<g:render template="../product/other/imports/refund/popups/update_cash_popup" />
<g:render template="../product/other/imports/refund/popups/update_new_rate_cash_popup" />
<g:javascript src="../js/new/refund/refund_product_tab_utils.js" />

<script>
    var recomputeNewAmountUrl = '${g.createLink(controller: "refund", action: "recomputeNewProductAmount")}';
    var getProductPaymentsMadeUrl = '${g.createLink(controller: "refund", action: "getProductPaymentsMade")}';
    var recomputeNewRateAmountUrl = '${g.createLink(controller: "refund", action: "recomputeNewRateProductAmount")}';

    var applyNewRateAmountUrl = '${g.createLink(controller: "refund", action: "applyNewRateProductAmount")}';
    var savedNewRateProductPaymentUrl = '${g.createLink(controller: "refund", action: "savedNewRateProductPayment")}';

    var applyPartialRefundUrl = '${g.createLink(controller: "refund", action: "applyPartialRefund")}';

    var clearAllProductRefundUrl = '${g.createLink(controller: "refund", action: "clearAllProductRefund")}';

    $(document).ready(function() {
        $("input[name=refundOption]").click(onChangeRefundOption);
        $("#update_product_amount").hide();
        $("#update_product_amount").click(openNewRateProductAmountPopup);
        $("#cancel_newRateProductAmount, #close_update_new_rate_cash_popup_x").click(closeNewRateProductAmountPopup);

        $("#productTransaction").change(onProductTransactionChange);

        $("#clearButton").click(clearAll);

        $("#update_cash").click(openUpdateCashPopup);
        $("#close_update_cash_popup_x, #cancel_updateProductAmount").click(closeUpdateCashPopup);

        $("#recomputeNewCash").click(recomputeNewCash);

        $("#productTransaction").val("");
        $("#productTransaction").attr("disabled", "disabled");
        $("#partialAmountForRefund").val("");
        $("#update_cash").hide();

        $("#recomputeNewRateProductPayment").click(recomputeNewRateProductAmount);

        $("#applyNewRateProductAmountRefund").click(applyNewRateProductAmountRefund);

        setupJqGridWidthNoPagerHidden("grid_list_refund_details_summary_cash_lc", {
            width : 780, height: 100, loadui: "disable", scrollOffset : 0, userDataOnFooter:true,
            gridComplete: setTotalProductRefund
        }, [[ "transactionDate", "Transaction Date ", 80, "center" ],
            [ "transactionType", "Transaction Type", 80, "left"],
            [ "currency", "Currency", 40, "left"],
            [ "oldAmount", "Old Amount", 100, "right" ],
            [ "newAmount", "New Amount", 100, "right" ],
            [ "refundAmount", "Refund Amount", 100, "right"]], savedNewRateProductPaymentUrl);

        $("#applyUpdateProductAmount").click(applyUpdateProductAmount);
    });
</script>