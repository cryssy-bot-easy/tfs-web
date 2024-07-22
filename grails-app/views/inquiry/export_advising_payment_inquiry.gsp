<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title>Trade Finance System - ${session.title}</title>
    <g:javascript src="popups/alert_utility.js"/>
    <script>

        var exportAdvisingForPaymentInquiryUrl = '${g.createLink(controller: "inquiry", action: "searchExportAdvisingPayment")}';
        var payTransactionUrl = '${g.createLink(controller: "inquiry", action: "payExportAdvisingTransaction")}';

        function setupGrids() {
            setupJqGridPagerWithHidden('grid_list_export_advising_for_payment_maker', {width: 780, height: 390, scrollOffset:0, rowNum: 20},
                    [['unitCode', 'Unit Code'],
               			['documentNumber', 'Document Number'],
                        ['transaction', 'Transaction'],
                        ['lcNumber', 'LC Number'],
                        ['exporterName', 'Exporter Name'],
                        ['issuingBank', 'Issuing Bank'],
//                        ['paymentStatus', 'Payment Status'],
                        ['action', 'Create Transaction']], 'grid_pager_export_advising_for_payment', exportAdvisingForPaymentInquiryUrl);

            setupJqGridPagerWithHidden('grid_list_export_advising_for_payment', {width: 780, height: 390, scrollOffset:0, rowNum: 20},
                    [['unitCode', 'Unit Code'],
               			['documentNumber', 'Document Number'],
                        ['transaction', 'Transaction'],
                        ['lcNumber', 'LC Number'],
                        ['exporterName', 'Exporter Name'],
                        ['issuingBank', 'Issuing Bank']], 'grid_pager_export_advising_for_payment', exportAdvisingForPaymentInquiryUrl);
        }

        function payExportAdvising(id) {
            var gotourl = payTransactionUrl+"?tradeServiceId="+id;

            location.href = gotourl;
        }

        $(document).ready(function() {
            setupGrids();

            $("#searchExportAdvisingForPayment").click(function() {
                var postUrl = exportAdvisingForPaymentInquiryUrl;
                postUrl += "?"+$("#exportAdvisingForPaymentInquiry").serialize();

                var grid;

                if ($("#grid_list_export_advising_for_payment_maker").length > 0) {
                    grid = $("#grid_list_export_advising_for_payment_maker");
                } else if ($("#grid_list_export_advising_for_payment").length > 0) {
                    grid = $("#grid_list_export_advising_for_payment");
                }

                grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertExportAdvisingForPaymentCount}).trigger("reloadGrid");
            });

            $("#resetExportAdvisingForPayment").click(function() {
                var postUrl = exportAdvisingForPaymentInquiryUrl;

                $("#documentNumber, #lcNumber, #exporterName, #processDate, #unitCode").val("");

                var grid

                if ($("#grid_list_export_advising_for_payment_maker").length > 0) {
                    grid = $("#grid_list_export_advising_for_payment_maker");
                } else if ($("#grid_list_export_advising_for_payment").length > 0) {
                    grid = $("#grid_list_export_advising_for_payment");
                }

                grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
            });
        });

        function alertExportAdvisingForPaymentCount(){
            var grid
            if ($("#grid_list_export_advising_for_payment_maker").length > 0) {
                grid = $("#grid_list_export_advising_for_payment_maker");
            } else if ($("#grid_list_export_advising_for_payment").length > 0) {
                grid = $("#grid_list_export_advising_for_payment");
            }

        	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
        	grid.jqGrid('setGridParam', {gridComplete: ''});
        }
    </script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="../layouts/header"/>

    <%-- ACCORDION --%>
    <g:render template="../layouts/accordion"/>

    <div id="body_forms">
        <form id="exportAdvisingForPaymentInquiry" class="inquiry_form">
            <table class="body_forms_table">
                <tr>
                    <td colspan="2"><span class="field_label">Document Number</span></td>
                    <td><g:textField class="input_field" name="documentNumber" value=""/></td>
                    <td colspan="2"><span class="field_label">Exporter Name</span></td>
                    <td>
                        <g:textField class="input_field" name="exporterName" value=""/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">LC Number</span></td>
                    <td><g:textField class="input_field" name="lcNumber" value=""/></td>
                	<td colspan="2"> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
                <tr><%-- BUTTON --%>
                    <td colspan="6">
                        <table class="body_forms_table_btn">
                            <tr><td><input type="button" class="input_button" value="Search" id="searchExportAdvisingForPayment"/></td></tr>
                            <tr><td><input type="button" class="input_button_negative" value="Reset" id="resetExportAdvisingForPayment"/></td></tr>
                        </table>
                    </td>
                </tr>
            </table><%-- End of SEARCH Form--%>
        </form>
        <div class="grid_wrapper">
            <g:if test="${session['userrole']['id']?.equalsIgnoreCase("TSDM")}">
                <table id="grid_list_export_advising_for_payment_maker"></table>
            </g:if>
            <g:else>
                <table id="grid_list_export_advising_for_payment"></table>
            </g:else>
            <div id="grid_pager_export_advising_for_payment"></div>
        </div>
    </div>
    <g:render template="../commons/popups/create_transaction_popup" />
    <g:render template="../commons/popups/create_ua_popup" />
    <g:render template="../commons/popups/create_ets_popup" />
    <g:render template="../commons/popups/create_ets_main_popup" />

    <g:render template="../commons/popups/create_non_lc_popup" />
    <g:render template="../commons/popups/view_transaction_main_popup"/>
    <g:render template="../layouts/reinstate_alert"/>

    <g:render template="../product/commons/popups/create_transaction"/>

    <g:render template="../layouts/alert" />
</div>
</body>
</html>