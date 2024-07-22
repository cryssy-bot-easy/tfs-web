<script type="text/javascript">
    var viewApprovedLcTsdUrl = '${g.createLink(controller: "documentClass", action: "viewApprovedLcTsdInitiated")}';
    var multipleTradeServiceUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleTradeService")}';
</script>
<g:javascript src="popups/create_ets_main_utility.js" />

<div id="create_ets_main_popup" class="popup_div_override">
  <div class="popup_header">
    <a href="javascript:void(0)" id="create_ets_main_popup_close" class="popup_close"> x </a>
    <h2 id="create_transaction_popup_header"> Create Transaction </h2>
  </div>
    %{--<g:radioGroup values="${['adjustment',--}%
                             %{--'amendment',--}%
                             %{--'negotiationDiscrepancy']}"--}%
                  %{--labels="${['Adjustment',--}%
                             %{--'Amendment',--}%
                             %{--'Negotiation Discrepancy']}"--}%
                  %{--name="createEtsMain" id="createEtsMain">--}%
        %{--<label>${it.radio}&#160;${it.label}</label><br/>--}%
    %{--</g:radioGroup>--}%
    <div id="radioContainerTsd">
    </div>
    <br/>
    <g:hiddenField name="tradeServiceId" value="" />
    <g:hiddenField name="lcNumber" value="" />
    <g:hiddenField name="dnTsd" value="" />
    <table class="popup_buttons">
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="etsMainRedirectTo" value="Go" class="input_button" disabled="disabled"/></td>
        </tr>
        <tr>
            <%-- BUTTON --%>
            <td><input type="button" id="cancelMainRedirect" value="Cancel" class="input_button_negative" /></td>
        </tr>
    </table>
</div>
<div id="create_ets_main_popup_bg" class="popup_bg_override"> </div>