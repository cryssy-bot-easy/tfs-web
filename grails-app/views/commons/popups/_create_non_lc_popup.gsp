<script type="text/javascript">
    var daDataEntryUrl = '${g.createLink(controller: "daDataEntryNegotiationAcknowledgement", action: "viewNegotiationAcknowledgementDataEntry")}';
    var dpDataEntryUrl = '${g.createLink(controller: "dpDataEntryNegotiation", action: "viewNegotiationDataEntry")}';
    var drDataEntryUrl = '${g.createLink(controller: "drDataEntryNegotiation", action: "viewNegotiationDataEntry")}';
    var oaDataEntryUrl = '${g.createLink(controller: "oaDataEntryNegotiation", action: "viewNegotiationDataEntry")}';
</script>
<g:javascript src="utilities/commons/create_non_lc_utility.js" />

<div id="create_non_lc_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="create_non_popup_close" class="popup_close"> x </a>
        <h2 id="create_transaction_popup_header"> Create Transaction </h2>
    </div>
    <g:radioGroup values="${['fxda',
                             'fxdp',
                             'dmdp',
                             'fxoa',
                             'fxdr']}"
                  labels="${['FX Non LC - DA Negotiation',
                             'FX Non LC - DP Negotiation',
                             'DM Non LC - DP Negotiation',
                             'FX Non LC - OA Negotiation',
                             'FX Non LC - DR Negotiation']}"
                  name="createNonLc" id="createNonLc">
        <label>${it.radio}&#160;${it.label}</label><br/>
    </g:radioGroup>
    <br/>
    <g:hiddenField name="tradeServiceId" value="" />
    <table class="popup_buttons">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="nonLcRedirect" value="Go" class="input_button" disabled="disabled"/></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="nonLcCancel" value="Cancel" class="input_button_negative" /></td>
        </tr>
    </table>
</div>
<div id="create_non_lc_popup_bg" class="popup_bg_override"> </div>