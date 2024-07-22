<script>
    var gotoBillsForCollectionUrl = '${g.createLink(controller: "product", action: "createBillsForCollection")}';


    $(document).ready(function() {
        $("#createExportBillsTsdCancel, #create_export_bills_tsd_popup_close").click(function() {
            mDisablePopup($("#create_export_bills_tsd_transaction_popup"), $("#create_export_bills_tsd_transaction_popup_bg"));
            $("#createExportBillsTsdGo").attr("disabled", "disabled");
        });

        $("#createExportBillsTsdGo").click(function() {
            var exportBills = $("input[name=createExportBillsCollection]:checked").val();

            var gotoUrl = gotoBillsForCollectionUrl;

            if (exportBills == "ebcNegotiation") {
                gotoUrl += "?documentType=FOREIGN";
            } else if (exportBills == "dbcNegotiation") {
                gotoUrl += "?documentType=DOMESTIC";
            }

            location.href = gotoUrl;
        });
        $("input[name=createExportBillsCollection]").click(function(){
            if($("input[name=createExportBillsCollection]:checked").length > 0){
            	$("#createExportBillsTsdGo").removeAttr("disabled");
            }
        });
    });
</script>

<div id="create_export_bills_tsd_transaction_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="create_export_bills_tsd_popup_close" class="popup_close"> x </a>
        <h2 id="create_transaction_popup_header"> Create Transaction </h2>
    </div>
    <g:radioGroup values="${['ebcNegotiation',
                             'dbcNegotiation']}"
                  labels="${['Export Bills for Collection - Negotiation',
                             'Domestic Bills for Collection - Negotiation']}"
        name="createExportBillsCollection" id="createExportBillsCollection">
    <label>${it.radio}&#160;${it.label}</label><br/>
    </g:radioGroup>
<br/>
<table class="popup_buttons">
    <tr>
        <td><input type="button" id="createExportBillsTsdGo" value="Go" class="input_button" disabled="disabled"/></td>
    </tr>
    <tr>
        <td><input type="button" id="createExportBillsTsdCancel" value="Cancel" class="input_button_negative" /></td>
    </tr>
</table>
    %{--<g:textField name="exportBillsDocNum" id="exportBillsDocNum" value="" />--}%
    %{--<g:textField name="exportBillsDocType" id="exportBillsDocType" value="" />--}%
    %{--<g:textField name="exportBillsDocClass" id="exportBillsDocClass" value="" />--}%
</div>
<div id="create_export_bills_tsd_transaction_popup_bg" class="popup_bg_override"> </div>