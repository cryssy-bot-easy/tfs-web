
<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: remittance_inquiry


>--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>
<%--	<g:javascript src="grids/ap_monitoring_inquiry_jqgrid.js" />--%>
<%--	<g:javascript src="grids/ar_monitoring_inquiry_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/cdt_client_inquiry_jqgrid.js" />--%>
<%--	<g:javascript src="grids/cdt_inquiry_jqgrid.js" />--%>
<%--	<g:javascript src="grids/import_advance_payment_inquiry_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/md_application_inquiry_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/mt_monitoring_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/rebate_inquiry_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/payment_other_import_charges_inquiry.js"/>--%>
	<g:javascript src="grids/remittance_inquiry_grid.js"/>
<%--	<g:javascript src="grids/settlement_actual_corres_charges_inquiry.js"/>--%>
<%--	<g:javascript src="grids/payment_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/foreign_exchange_jqgrid.js" />--%>
<%--	<g:javascript src="grids/refund_cash_lc_charges_inquiry_jqgrid.js"/>--%>
<%--	--%>
<%--	<g:javascript src="popups/import_advance_create_ets_popup.js"/>--%>
<%--	<g:javascript src="popups/breakdown_popup.js" />--%>
	<g:javascript src="popups/alert_utility.js" />
<%--	--%>
<%--    <g:javascript src="utilities/other_imports/commons/initialize_forms.js" />--%>
%{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
<%--   --%>
   <script type="text/javascript">
		var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${username}';
        var searchCdtRemittanceUrl = '${g.createLink(controller: "inquiry", action: "cdtInquiryRemittanceInquiry")}';

        function alertCdtRemittanceCount(){
            triggerAlertMessage($("#grid_list_remittance").jqGrid('getGridParam', 'records') + " record/s found.");
            $("#grid_list_remittance").jqGrid('setGridParam', {gridComplete: ""});
        }

        $(document).ready(function() {
            $("#searchRemittance").click(function() {
                var postUrl = searchCdtRemittanceUrl;
                postUrl += "?"+$("#cdtRemittanceInquiryForm").serialize();
                $("#grid_list_remittance").jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertCdtRemittanceCount}).trigger("reloadGrid");
            });

            $("#resetRemittance").click(function() {
                $("#reportType, #dateOfRemitanceFrom, #dateOfRemitanceTo, #collectionPeriodFrom, #collectionPeriodTo").val("");
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
    <form id="cdtRemittanceInquiryForm" class="inquiry_form">
	<table class="tabs_forms_table">
		<tr>
			<td> <span class="field_label"> Type of Report</span> </td>
			<td class="input_width">
                %{--<g:select class="select_dropdown" from="${['IPF','Final CDT','Advance CDT','Export Duties','All']}" name="x" noSelection="['':'Select One']"/> --}%
                <tfs:typeOfReport name="reportType" value="" class="select_dropdown" />
            </td>
		</tr>
		<tr>
			<td ><span class="field_label title_label"> Date Of Remittance </span></td>
			<td></td>
			<td ><span class="field_label title_label"> PCHC Confirmation Date</span></td>
			<td></td>
		</tr>
		<tr>
			<td align="right"> <span class="float_right">From</span></td>
			<td> <g:textField class="datepicker_field" name="dateOfRemitanceFrom"/> </td>
			<td  align="right">  <span class="float_right">From</span> </td>
			<td class="input_width"> <g:textField class="datepicker_field" name="collectionPeriodFrom"/> </td>
		</tr>
		<tr>
			<td align="right"> <span class="field_label float_right">To</span> </td>
			<td> <g:textField class="datepicker_field" name="dateOfRemitanceTo"/> </td>
			<td align="right"> <span class="field_label float_right">To</span> </td>
			<td> <g:textField class="datepicker_field" name="collectionPeriodTo"/> </td>
		</tr>
	</table>
	<table class="buttons">
		<tr>
			<td> <input type="button" id="searchRemittance" class="input_button" value="Search" /> </td>
		</tr>
		<tr>
			<td> <input type="button" id="resetRemittance" class="input_button_negative" value="Reset" /> </td>
		</tr>
	</table>
    </form>
	<br/><br/><br/><br/>
	<div class="grid_wrapper">
	  <%-- JQGRID --%>
	 <table id="grid_list_remittance"></table>
	  <div id="grid_pager_remittance"></div>
	</div>
</div>
</div>			
<%--<g:render template="../layouts/confirm_alert" />--%>
<g:render template="../layouts/alert" />
<%--<g:render template="../lc/commons/popups/ec_login" />--%>
<%--<g:render template="../lc/commons/popups/cif_search_popup" />--%>
<%--<g:render template="../lc/commons/popups/cif_search_normal"/>--%>
<%--<g:render template="../others/commons/popups/monitoring_breakdown_popup" />--%>
<%--<g:render template="../others/commons/popups/import_advanced_inquiry_popup"/>--%>
<%--<g:javascript src="popups/cif_normal_search_popup.js"/>--%>
<%--<g:javascript src="popups/cif_search_popup.js"/>--%>
</body>
</html>