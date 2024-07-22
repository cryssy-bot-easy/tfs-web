<script type="text/javascript">
    <%--var maturityAdjustmentUrl = '${g.createLink(controller: "lcEtsUaLoanMaturityAdjustment", action: "viewMaturityAdjustmentEts")}';--%>
    <%--var settlementUrl = '${g.createLink(controller: "lcEtsUaLoanSettlement", action: "viewUaLoanSettlementEts")}';--%>

    <%--var viewApprovedNegotiationLcUrl = '${g.createLink(controller: "documentClass", action: "viewApprovedLc")}';--%>
    var viewApprovedNegotiationLcUrl = '${g.createLink(controller: "documentClass", action: "viewApprovedLcNegotiation")}';
</script>
<g:javascript src="utilities/commons/create_ua_utility.js" />

<div id="create_ua_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="create_ua_popup_close" class="popup_close"> x </a>
        <h2 id="create_transaction_popup_header"> Create Transaction </h2>
    </div>
    <g:radioGroup values="${['maturityAdjustment',
                             'settlement']}"
                  labels="${['UA Loan Maturity Adjustment',
                             'UA Loan Settlement']}"
                  name="createUa" id="createUa">
        <label>${it.radio}&#160;${it.label}</label><br/>
    </g:radioGroup>
    <br/>
    <g:hiddenField name="id" value="" />
    <g:hiddenField name="documentType" value="" />
    <table class="popup_buttons">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="uaRedirectTo" value="Go" class="input_button" disabled="disabled"/></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="uaCancel" value="Cancel" class="input_button_negative" /></td>
        </tr>
    </table>
</div>
<div id="create_ua_popup_bg" class="popup_bg_override"> </div>