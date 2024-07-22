<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>

	<g:javascript src="grids/rebate_inquiry_jqgrid.js"/>
	<g:javascript src="popups/alert_utility.js"/>

   <script type="text/javascript">
        var rebate_inquiry_grid_url = '${g.createLink(controller: "inquiry", action: "searchRebates")}';

        function alertRebateCount() {
            triggerAlertMessage($("#grid_list_rebate_inquiry").jqGrid('getGridParam', 'records') + " record/s found.");
            $("#grid_list_rebate_inquiry").jqGrid('setGridParam', {gridComplete: ""});
        }

        $(document).ready(function() {
            $("#corresBankCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankCode}'});

            $("#rebateSearch").click(function() {

            	var postUrl = rebate_inquiry_grid_url;
                postUrl += "?"+$("#rebateInquiry").serialize();
                
                $("#grid_list_rebate_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertRebateCount}).trigger("reloadGrid");
            });

            $("#rebateReset").click(function() {
            	var postUrl = rebate_inquiry_grid_url;
                $("#corresBankCode").select2("data", null);
                $("#unitCode").val("");
                $("#grid_list_rebate_inquiry").jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
            });
        });
	</script>
	
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>
	
	<div id="body_forms">
		<form id="rebateInquiry" class="inquiry_form">
			<table>
				<tr>
					<td><span class="field_label">Corres Bank</span></td>
					<td>
	                    <input class="tags_cbcode select2_dropdown bigdrop required" name="corresBankCode" id="corresBankCode" />
	                </td>
				<g:if test="${session['userrole']['id'].contains("TSD")}">
					<td class="label_width"/>
	                	<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
	            </g:if>
				</tr>
			</table>
		</form>
		<br/>
		<table class="buttons">
			<tr>
				<td>
                    <input type="button" class="input_button" id="rebateSearch" value="Search" />
                </td>
			</tr>
			<tr>
				<td>
                    <input type="button" class="input_button_negative" id="rebateReset" value="Reset" />
                </td>
			</tr>
		</table>
		<br/><br/><br/><br/>
		<div class="grid_wrapper">
			<table id="grid_list_rebate_inquiry"></table>
			<div id="grid_pager_rebate_inquiry"></div>
		</div>
	</div>

</div>

<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_ets_main_popup" />

<g:render template="../commons/popups/create_non_lc_popup" />
<g:render template="../commons/popups/view_transaction_main_popup"/>
<g:render template="../layouts/reinstate_alert"/>
<g:render template="../layouts/alert" />
</body>
</html>