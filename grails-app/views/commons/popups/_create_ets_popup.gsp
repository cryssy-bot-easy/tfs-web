<script type="text/javascript">
    var viewApprovedLcUrl = '${g.createLink(controller: "documentClass", action: "viewApprovedLc")}';
    var searchTrLineUrl = '${g.createLink(controller: "facility", action: "searchTrLines")}';
    var multipleServiceInstructionUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleServiceInstruction")}';
</script>
<g:javascript src="popups/create_ets_utility.js" />

<div id="create_ets_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="create_ets_popup_close" class="popup_close"> x </a>
        <h2 id="create_transaction_popup_header"> Create Transaction </h2>
    </div>
	<div id="radioContainer">
	</div>
    <br/>
    
    <g:hiddenField name="tradeServiceId" value="" />
    <g:hiddenField name="lcNumber" value="" />
    <g:hiddenField name="dnBranch" value="" />
    <g:hiddenField name="reinstateFlag" value="" />
    <g:hiddenField name="cNumber" value="" />
    <g:hiddenField name="mcNumber" value="" />
    <g:hiddenField name="dsType1" value="" />
    <table class="popup_buttons">
        <tr>
            <td><input type="button" id="etsRedirectTo" value="Go" class="input_button" disabled="disabled"/></td>
        </tr>
        <tr>
            <td><input type="button" id="cancelRedirect" value="Cancel" class="input_button_negative" /></td>
        </tr>
    </table>
</div>
<div id="create_ets_popup_bg" class="popup_bg_override"> </div>