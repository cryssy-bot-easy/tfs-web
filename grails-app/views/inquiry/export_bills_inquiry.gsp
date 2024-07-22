<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main" />
<title>Trade Finance System - ${session.title}</title>
	<g:javascript src="popups/alert_utility.js"/>
    <script>

        var exportBillsInquiryUrl = '${g.createLink(controller: "inquiry", action: "searchExportBills")}';
        var transactBillsForPurchaseUrl = '${g.createLink(controller: "product", action: "transactBillsForPurchase")}';
        var cancelBillsForCollection = '${g.createLink(controller: "product", action: "cancelBillsForCollection")}';
        var unitcode = '${session.unitcode}';

        //var viewExportAdvisingUrl = '${g.createLink(controller: "exportAdvising", action: "")}';
       
        function setupGrids() {
            
        	var createAction;
            if(user.indexOf("Officer") != -1) {
            	createActionBranch = ['action', 'Create eTS', '', 'hidden'];
            	createActionTsd = ['action', 'Create Data Entry', '', 'hidden'];
            } else {
            	createActionBranch = ['action', 'Create eTS'];
            	createActionTsd = ['action', 'Create Data Entry'];
    		}
    		
        	setupJqGridPagerWithHidden('grid_list_export_bills_branch', {width: 780, height: 360, scrollOffset:0, rowNum: 20},
                    [['documentNumber', 'Document Number'],
                        ['clientName', 'Client Name'],
                        ['transactionType', 'Transaction Type'],
                        ['status', 'Status'],
                        ['currency', 'Currency'],
                        ['outstandingAmount','O/S Amount'],
                        ['amount', 'Amount'],
                        createActionBranch], 'grid_pager_export_bills', exportBillsInquiryUrl+"?unitcode="+unitcode);

            setupJqGridPagerWithHidden('grid_list_export_bills_tsd', {width: 780, height: 360, scrollOffset:0, rowNum: 20},
                    [['unitCoder', 'Unit Code'],
                     	['documentNumber', 'Negotiation Number'],
                        ['clientName', 'Client Name'],
                        ['corresBank', 'Corres Bank'],
                        ['transactionType', 'Transaction Type'],
                        ['status', 'Status'],
                        ['processDate', 'Process Date'],
                        ['outstandingAmount','O/S Amount'],
                        ['negoAmount', 'Nego Amount'],
                        ['settlementDate', 'Settlement Date'],
                        ['proceedsAmount', 'Proceeds Amount'],
                        createActionTsd], 'grid_pager_export_bills', exportBillsInquiryUrl+"?unitcode="+unitcode);
        }

        function transactBC(id, documentType, documentClass) {
            $("#exportBillsDocNum").val(id);
            $("#exportBillsDocType").val(documentType);
            $("#exportBillsDocClass").val(documentClass);

            cancelBillsForCollection += "?documentNumber="+id;
            <%-- added by henry alabin --%>
            cancelBillsForCollection += "&documentClass="+documentClass;
            cancelBillsForCollection += "&documentType="+documentType;
            location.href = cancelBillsForCollection
        }

        function transactBP(id, documentType, documentClass) {
            var gotourl = transactBillsForPurchaseUrl;

            gotourl += "?documentNumber="+id;
            gotourl += "&documentClass="+documentClass;
            gotourl += "&documentType="+documentType;

            location.href = gotourl;
        }

        $(document).ready(function() {
            $("#currency").setCurrencyDropdownInquiry();
			
            setupGrids();

            if ($("#corresBankCode").length > 0) {
                $("#corresBankCode").setDepositoryBankDropdown($(this).attr("id"));
            }

            $("#searchExportBills").click(function() {
                var postUrl = exportBillsInquiryUrl;
                postUrl += "?"+$("#exportBillsInquiry").serialize();
                postUrl += "&unitcode="+unitcode;

                var grid = null;

                if ($("#grid_list_export_bills_branch").length > 0) {
                    grid = $("#grid_list_export_bills_branch");
                } else {
                    grid = $("#grid_list_export_bills_tsd");
                }
                grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertExportBillsCount}).trigger("reloadGrid");
            });

            $("#resetExportBills").click(function() {

            	 $("#cifName, #documentNumber, #amountFrom, #amountTo").val("");
            	 var resetUrl = exportBillsInquiryUrl;
            	 resetUrl += "?unitcode="+unitcode;

                 var grid;

                 if ($("#grid_list_export_bills_branch").length > 0) {
                     grid = $("#grid_list_export_bills_branch");
                 } else {
                     grid = $("#grid_list_export_bills_tsd");
                 }
                 grid.jqGrid('setGridParam', {url: resetUrl, page: 1}).trigger("reloadGrid");
                 grid.jqGrid('setGridParam', {gridComplete: ""});

                 $("#currency").select2("data", null);
                 $("#corresBankCode").select2("data",null);
             });

                
        });

        function settleExportBills(id, documentType) {
            location.href = '${g.createLink(controller: "product", action: "settleBillsForCollection")}' + "?documentNumber=" + id + "&documentType="+documentType;
        }

        function alertExportBillsCount(){
            var grid = null;

            if ($("#grid_list_export_bills_branch").length > 0) {
                grid = $("#grid_list_export_bills_branch");
            } else {
                grid = $("#grid_list_export_bills_tsd");
            }

        	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
        	grid.jqGrid('setGridParam', {gridComplete: ""});
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
		<form id="exportBillsInquiry" class="inquiry_form">
            <g:if test="${"BRANCH".equals(session.group)}">
                <table class="body_forms_table">
                    <tr>
                        <td colspan="2"><span class="field_label">CIF Name</span></td>
                        <td><g:textField class="input_field" name="cifName" value=""/></td>
                        <td colspan="2"><span class="field_label">Currency</span></td>
                        <td>
                            <input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><span class="field_label">Document Number</span></td>
                        <td><g:textField class="input_field" name="documentNumber" value=""/></td>
                        <td><span class="field_label">Amount</span></td>
                        <td>From</td>
                        <td><g:textField class="input_field numericCurrency" name="amountFrom" value=""/></td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                        <td>To:</td>
                        <td><g:textField class="input_field numericCurrency" name="amountTo" value=""/></td>
                    </tr>
                    <tr><%-- BUTTON --%>
                        <td colspan="6">
                            <table class="body_forms_table_btn">
                                <tr><td><input type="button" class="input_button" value="Search" id="searchExportBills"/></td></tr>
                                <tr><td><input type="reset" class="input_button_negative" value="Reset" id="resetExportBills"/></td></tr>
                            </table>
                        </td>
                    </tr>
                </table><%-- End of SEARCH Form--%>
            </g:if>
            <g:if test="${"TSD".equals(session.group)}">
                <table class="body_forms_table">
                    <tr>
                        <td colspan="2"><span class="field_label">Negotiation Number</span></td>
                        <td><g:textField class="input_field" name="documentNumber" value=""/></td>
                        <td colspan="2"><span class="field_label">Transaction</span></td>
                        <td>
                            <g:select name="transaction" from="${[]}" class="select_dropdown" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><span class="field_label">Client Name</span></td>
                        <td><g:textField class="input_field" name="cifName" value=""/></td>
                        <td colspan="2"><span class="field_label">Transaction Type</span></td>
                        <td>
                            <g:select name="transactionType"
                                      from="${['Export Bills for Purchase', 'Domestic Bills for Purchase', 'Export Bills for Collection', 'Domestic Bills for Collection']}"
                                      keys="${['EBP', 'DBP', 'EBC', 'DBC']}" class="select_dropdown"
                                      noSelection="${['':'SELECT ONE...']}"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><span class="field_label">Corres Bank</span></td>
                        <td>
                            <input class="tags_cbcode select2_dropdown bigdrop required" name="corresBankCode" id="corresBankCode" />
                        </td>
                        <td colspan="2"><span class="field_label">Status</span></td>
                        <td>
                            <g:select name="status" from="${['NEGOTIATED', 'SETTLED', 'CANCELLED']}" class="select_dropdown" noSelection="${['':'SELECT ONE...']}"/>
                        </td>
                    </tr>
                    <tr>
	                	<td colspan="2"> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
	                </tr>
                    <tr><%-- BUTTON --%>
                        <td colspan="6">
                            <table class="body_forms_table_btn">
                                <tr><td><input type="button" class="input_button" value="Search" id="searchExportBills"/></td></tr>
                                <tr><td><input type="reset" class="input_button_negative" value="Reset" id="resetExportBills"/></td></tr>
                            </table>
                        </td>
                    </tr>
                </table><%-- End of SEARCH Form--%>
            </g:if>
		</form>
		<div class="grid_wrapper">
            <g:if test="${session.group.equals("BRANCH")}">
                <table id="grid_list_export_bills_branch"></table>
            </g:if>
            <g:if test="${session.group.equals("TSD")}">
                <table id="grid_list_export_bills_tsd"></table>
            </g:if>
            <div id="grid_pager_export_bills"></div>
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
<g:render template="../product/commons/popups/create_export_bills_transaction_tsd"/>

<g:render template="../layouts/alert" />
</div>
</body>
</html>