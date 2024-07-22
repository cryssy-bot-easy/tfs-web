<script type="text/javascript">
    function getPostUrl(formId) {
        switch (formId) {
            case "#basicDetailsTabForm":
                if (referenceType == "ETS") {
                    return '${g.createLink(controller:"product", action: "dummySave")}';
                } else if (referenceType == "CLIENT") {
                    return '${g.createLink(controller:"cdt", action: "dummySaveCdtClient")}';
                } else if (referenceType == "PAYMENT") {
                    if (documentClass == "CDT" && serviceType == "PAYMENT") { // this is cdt save
                        var documentPaymentSummaryData = $("#grid_list_payment_cdt").jqGrid("getRowData");
                        $("#documentPaymentSummary").val(JSON.stringify(documentPaymentSummaryData));
                        return '${g.createLink(controller:"cdt", action: "dummyCdtSave")}';
                    }  else if (documentClass == "CDT" && serviceType == "REMITTANCE") {
                        return '${g.createLink(controller:"product", action: "dummyTradeServiceSave")}'
                    } else {
                        return '${g.createLink(controller: "product", action: "dummyUpdate")}';
                    }
                } else if (referenceType == "DATA_ENTRY") {
                        return '${g.createLink(controller:"product", action: "dummyTradeServiceSave")}'
                }
            default :
                return '${g.createLink(controller: "product", action: "dummyUpdate")}';
        }
    }


    $(document).ready(function() {
        $("#confirmYes").click(function() {

            var postUrl = getPostUrl(formId);

            $(formId).attr("method", "POST");
            $(formId).attr("action", postUrl);

            $(formId).append($("#cifNumber"));
            $(formId).append($("#cifName"));
            $(formId).append($("#accountOfficer"));
            $(formId).append($("#ccbdBranchUnitCode"));

            $(formId).submit();
        });

        $("#confirmNo").click(function() {
            mDisablePopup($("#save_confirm"), $("#confirmation_background"));
        });
    });
</script>

<div class="popup_div_alert" id="save_confirm">
    <div class="popup_header">
        <h2 class="popup_title"> Alert! </h2>
    </div>
    <span class="are_you_sure"> Are you sure? </span>
    <ul class="popup_buttons_alert">
        <li>
            <input type="button" class="input_button_alert confirmYes" value="Yes" id="confirmYes"/>
            <input type="button" class="input_button_negative_alert confirmNo" value="No" id="confirmNo"/>
        </li>
    </ul>
</div>
<div class="popup_bg_alert" id="confirmation_background"></div>