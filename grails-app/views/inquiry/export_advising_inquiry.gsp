<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main" />
<title>Trade Finance System - ${session.title}</title>
	<g:javascript src="popups/alert_utility.js"/>
    <script>

        var exportAdvisingInquiryUrl = '${g.createLink(controller: "inquiry", action: "searchExportAdvising")}';

        var viewExportAdvisingUrl = '${g.createLink(controller: "exportAdvising", action: "")}';

        function setupGrids() {
            setupJqGridPagerWithHidden('grid_list_export_advising', {width: 780, height: 390, scrollOffset:0, rowNum: 20},
                    [['unitCode', 'Unit Code'],
                  		['documentNumber', 'Document Number'],
                        ['lastTransaction', 'Last Transaction'],
                        ['lcNumber', 'LC Number'],
                        ['lcCurrency', 'LC Currency'],
                        ['lcAmount', 'LC Amount'],
                        ['exporterName', 'Exporter Name'],
                        ['issuingBank', 'Issuing Bank']], 'grid_pager_export_advising', exportAdvisingInquiryUrl);

            setupJqGridPagerWithHidden('grid_list_export_advising_maker', {width: 780, height: 390, scrollOffset:0, rowNum: 20},
                    [['unitCode', 'Unit Code'],
               			['documentNumber', 'Document Number'],
                        ['lastTransaction', 'Last Transaction'],
                        ['lcNumber', 'LC Number'],
                        ['lcCurrency', 'LC Currency'],
                        ['lcAmount', 'LC Amount'],
                        ['exporterName', 'Exporter Name'],
                        ['issuingBank', 'Issuing Bank'],
                        ['action', 'Create Transaction']], 'grid_pager_export_advising', exportAdvisingInquiryUrl);
        }

//        function setupExportAdvisingInquiryGridValidation(){
//        	if($("#grid_list_export_advising") && "TSDM" != $("#userrole").val()){
//        		$("#grid_list_export_advising").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
//        	}
//        }

        function createExportAdvising(id, advisingBankType) {
            $("#exportDocumentNumber").val(id);
            $("#exportDocumentSubType1").val(advisingBankType);

            $("input[type=radio][name=createExportAdvising]").attr("checked", false);

            mLoadPopup($("#create_export_advising_popup"), $("#create_export_advising_popup_bg"));
            mCenterPopup($("#create_export_advising_popup"), $("#create_export_advising_popup_bg"));
            if($("#createTransactionGo").attr("disabled") != "disabled"){
            	$("#createTransactionGo").attr("disabled", "disabled");
            }
        }

        $(document).ready(function() {
            setupGrids();
            //setupExportAdvisingInquiryGridValidation();
			
            $("#searchExportAdvising").click(function() {
                var postUrl = exportAdvisingInquiryUrl;
                //postUrl += "?"+$("#exportAdvisingInquiry").serialize();
                postUrl += "?documentNumber="+$("#documentNumber").val();
                postUrl += "&lcNumber="+$("#lcNumber").val();
                postUrl += "&exporterName="+$("#exporterName").val();
                postUrl += "&processDate="+$("#processDate").val();
                postUrl += "&unitCode="+$("#unitCode").val();

                var grid;

                if ($("#grid_list_export_advising_maker").length > 0) {
                    grid = $("#grid_list_export_advising_maker");
                } else if ($("#grid_list_export_advising").length > 0) {
                    grid = $("#grid_list_export_advising");
                }

                grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertExportAdvisingCount}).trigger("reloadGrid");
            });

            $("#resetExportAdvising").click(function() {
                $("#documentNumber, #lcNumber, #exporterName, #processDate, #unitCode").val("");
                var postUrl = exportAdvisingInquiryUrl;

                var grid;

                if ($("#grid_list_export_advising_maker").length > 0) {
                    grid = $("#grid_list_export_advising_maker");
                } else if ($("#grid_list_export_advising").length > 0) {
                    grid = $("#grid_list_export_advising");
                }

                grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
            });
        });

        function alertExportAdvisingCount(){
            var grid;

            if ($("#grid_list_export_advising_maker").length > 0) {
                grid = $("#grid_list_export_advising_maker");
            } else if ($("#grid_list_export_advising").length > 0) {
                grid = $("#grid_list_export_advising");
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
		<form id="exportAdvisingInquiry" class="inquiry_form">
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
                    <td colspan="2"><span class="field_label">Date of Transaction</span></td>
                    <td><g:textField class="datepicker_field" name="processDate" value=""/></td>
				</tr>
				<g:if test="${session['userrole']['id'].contains("TSD")}">
				<tr>
                	<td colspan="2"> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
                </tr>
                </g:if>
				<tr><%-- BUTTON --%>
					<td colspan="6">
						<table class="body_forms_table_btn">
							<tr><td><input type="button" class="input_button" value="Search" id="searchExportAdvising"/></td></tr>
							<tr><td><input type="button" class="input_button_negative" value="Reset" id="resetExportAdvising"/></td></tr>
						</table>
					</td>
				</tr>  
			</table><%-- End of SEARCH Form--%>
		</form>
		<div class="grid_wrapper">
            <g:if test="${session['userrole']['id']?.equalsIgnoreCase("TSDM")}">
                <table id="grid_list_export_advising_maker"></table>
            </g:if>
            <g:else>
                <table id="grid_list_export_advising"></table>
            </g:else>
            <div id="grid_pager_export_advising"></div>
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