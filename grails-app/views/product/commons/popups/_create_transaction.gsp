<script>
    var gotoUrl = '${g.createLink(controller: "product", action: "createExportAdvising")}';
    var validateMultipleTradeServiceUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleTradeService")}';

    $(document).ready(function() {
        $("#createTransactionGo").click(function() {
            var exportAdvising = $("input[type=radio][name=createExportAdvising]:checked").val();
            var tradeProductNumber = $("#exportDocumentNumber").val();

            $.post(validateMultipleTradeServiceUrl, {tradeServiceId: $("#tradeServiceId").val(),
                tradeProductNumber: tradeProductNumber,
                serviceType: exportAdvising+"_advising",
                isNotPrepared: true}, function(data) {

                if (data.success == "true") {
                    gotoUrl += "?documentNumber="+tradeProductNumber+
                            "&serviceType="+exportAdvising+
                            "&advisingBankType="+$("#exportDocumentSubType1").val();


                    location.href = gotoUrl;
                } else {
                    triggerAlertMessage(data.message);
                }
            });
        });

        $("#createTransactionCancel, #create_export_advising_popup_close").click(function() {
            $("#exportDocumentNumber").val("");
            $("#exportDocumentSubType1").val("");
            mDisablePopup($("#create_export_advising_popup"), $("#create_export_advising_popup_bg"));
            $("#createTransactionGo").attr("disabled", "disabled");
        });

        $("input[name=createExportAdvising]").click(function(){
            if($("input[name=createExportAdvising]:checked").length > 0){
            	$("#createTransactionGo").removeAttr("disabled");
            }
        });
    });
</script>

<div id="create_export_advising_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="create_export_advising_popup_close" class="popup_close"> x </a>
        <h2 id="create_transaction_popup_header"> Create Transaction </h2>
    </div>
    <g:radioGroup values="${['amendment',
                             'cancellation']}"
                  labels="${['Amendment',
                             'Cancellation']}"
        name="createExportAdvising" id="createExportAdvising">
    <label>${it.radio}&#160;${it.label}</label><br/>
    </g:radioGroup>
<br/>
    <g:hiddenField name="exportDocumentNumber" id="exportDocumentNumber" value="" />
    <g:hiddenField name="exportDocumentSubType1" id="exportDocumentSubType1" value="" />
<table class="popup_buttons">
    <tr>
        <td><input type="button" id="createTransactionGo" value="Go" class="input_button"/></td>
    </tr>
    <tr>
        <td><input type="button" id="createTransactionCancel" value="Cancel" class="input_button_negative" /></td>
    </tr>
</table>
</div>
<div id="create_export_advising_popup_bg" class="popup_bg_override"> </div>