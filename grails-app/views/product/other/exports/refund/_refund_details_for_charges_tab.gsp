<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="refundDetailsServiceTabForm" />

<table class="tabs_forms_table">
	<tr>
		<td width="160"><span class="field_label">Refund Transaction Type</span></td>
		<td>
            <g:select name="transaction" from="${approvedTradeServices?.serviceType}"
                      keys="${approvedTradeServices?.tradeServiceId}" value="" noSelection="${['':"SELECT ONE..."]}" class="select_dropdown"/>
            <a href="javascript:void(0)" class="search_btn" id="update_charges"> Search/Look-up Button </a>
        </td>
	</tr>
</table>
<br/>
<br/>
<span class="field_label title_label">Refund Details Summary for Charges</span>
<br/>
<div class="grid_wrapper">
	<table id="grid_refund_details_summary_for_charges"></table>
</div>
<br/>
<div class="right_indent">
	<table class="charges_table">
		<tr>
			<td><span class="field_label p_header">Total Amount of Charges Due</span></td>
			<td><g:textField name="totalAmountOfChargesCurrency" class="input_field_short" readonly="readonly" value="PHP"/></td>
			<td><g:textField name="totalAmountOfCharges" class="input_field_right numericCurrency" readonly="readonly"/></td>
		</tr>
	</table>
</div>
<br />
<br />

<g:render template="../product/other/exports/refund/popups/update_charges_popup" />
<g:javascript src="new/export_refund/refund_charges_utils.js" />
<script>
    var recomputeNewChargesUrl = '${g.createLink(controller: "exportsRefund", action: "recomputeNewCharges")}';
    var getBookedRatesUrl = '${g.createLink(controller: "exportsRefund", action: "onChangeTransaction")}';
    var applyUpdatedChargesUrl = '${g.createLink(controller: "exportsRefund", action: "applyUpdatedCharges")}';

    var savedNewChargesUrl = '${g.createLink(controller: "exportsRefund", action: "getSavedNewCharges")}';

    $(document).ready(function() {
        $("#update_charges").hide();
        $("#update_charges").click(openUpdateChargesPopup);

        $("#close_update_charges_popup_x, #cancel_updateCharges").click(closeUpdateChargesPopup);

        $("#recomputeNewCharges").click(recomputeNewCharges);

        setupJqGridWidthNoPagerHidden("grid_refund_details_summary_for_charges", {
            width : 780, height: 100, loadui: "disable", scrollOffset : 0, userDataOnFooter:true,
            gridComplete: setTotalChargeRefundAmount
            }, [[ "transactionDate", "Transaction Date ", 80, "center" ],
                [ "transactionType", "Transaction Type", 80, "left"],
                [ "chargeType", "Charge Type", 80, "left"],
                [ "settlementCurrency", "Settlement Currency", 40, "left"],
                [ "oldAmount", "Old Amount", 100, "right" ],
                [ "newAmount", "New Amount", 100, "right" ],
                [ "refundAmount", "Refund Amount (in PHP)", 100, "right"]], savedNewChargesUrl);

        $("#applyUpdateCharges").click(applyUpdatedCharges);

        $("#transaction").change(onTransactionChange);
    });
</script>

