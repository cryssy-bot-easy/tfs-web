<script>
    var gotoBillsForPurchaseUrl = '${g.createLink(controller: "product", action: "createBillsForPurchase")}';

    $(document).ready(function() {
        $("#createExportBillsGo").click(function() {
            var exportBills = $("input[name=createExportBills]:checked").val();

            var gotoUrl = gotoBillsForPurchaseUrl;

            if (exportBills == "dbpNegotiation") {
                gotoUrl += "?documentType=DOMESTIC";
            } else if (exportBills == "ebpNegotiation") {
                gotoUrl += "?documentType=FOREIGN";
            }

            location.href = gotoUrl;
        });

        $("#createExportBillsCancel, #create_export_bills_popup_close").click(function() {
            mDisablePopup($("#create_export_bills_transaction_popup"), $("#create_export_bills_transaction_popup_bg"));
            $("#createExportBillsGo").attr("disabled", "disabled");
        });

        $("input[name=createExportBills]").click(function(){
            if($("input[name=createExportBills]:checked").length > 0){
            	$("#createExportBillsGo").removeAttr("disabled");
            }
        });
    });
</script>

<div id="create_export_bills_transaction_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="create_export_bills_popup_close" class="popup_close"> x </a>
        <h2 id="create_transaction_popup_header"> Create Transaction </h2>
    </div>
    <g:radioGroup values="${['ebpNegotiation',
                             'dbpNegotiation']}"
                  labels="${['Export Bills for Purchase - Negotiation',
                             'Domestic Bills for Purchase - Negotiation']}"
        name="createExportBills" id="createExportBills">
    <label>${it.radio}&#160;${it.label}</label><br/>
    </g:radioGroup>
<br/>
<table class="popup_buttons">
    <tr>
        <td><input type="button" id="createExportBillsGo" value="Go" class="input_button" disabled="disabled"/></td>
    </tr>
    <tr>
        <td><input type="button" id="createExportBillsCancel" value="Cancel" class="input_button_negative" /></td>
    </tr>
</table>
</div>
<div id="create_export_bills_transaction_popup_bg" class="popup_bg_override"> </div>