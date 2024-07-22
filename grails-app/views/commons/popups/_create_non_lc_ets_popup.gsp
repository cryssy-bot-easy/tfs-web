<script type="text/javascript">
    var daSettlementUrl = '${g.createLink(controller: "daEtsSettlement", action: "viewSettlementEts")}';
    var dpSettlementUrl = '${g.createLink(controller: "dpEtsSettlement", action: "viewSettlementEts")}';
    var drSettlementUrl = '${g.createLink(controller: "drEtsSettlement", action: "viewSettlementEts")}';
    var oaSettlementUrl = '${g.createLink(controller: "oaEtsSettlement", action: "viewSettlementEts")}';
</script>
<g:javascript src="utilities/commons/create_non_lc_ets_utility.js" />

<div id="create_non_lc_ets_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="create_non_lc_ets_popup_close" class="popup_close"> x </a>
        <h2 id="create_transaction_popup_header"> Create Transaction </h2>
    </div>
    <g:radioGroup values="${['fxda',
                             'fxdp',
                             'dmdp',
                             'fxdr',
                             'fxoa']}"
                  labels="${['FX Non LC - DA Settlement',
                             'FX Non LC - DP Settlement',
                             'DM Non LC - DP Settlement',
                             'FX Non LC - DR Settlement',
                             'FX Non LC - OA Settlement']}"
                  name="createNonLcEts" id="createNonLcEts">
        <label>${it.radio}&#160;${it.label}</label><br/>
    </g:radioGroup>
    <br/>
    <g:hiddenField name="tradeServiceId" value="" />
    <table class="popup_buttons">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="nonLcEtsRedirect" value="Go" class="input_button"/></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="nonLcEtsCancel" value="Cancel" class="input_button_negative" /></td>
        </tr>
    </table>
</div>
<div id="create_non_lc_ets_popup_bg" class="popup_bg_override"> </div>