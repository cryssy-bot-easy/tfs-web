<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>
<%--	<g:javascript src="grids/ap_monitoring_inquiry_jqgrid.js" />--%>
	<g:javascript src="grids/ar_monitoring_inquiry_jqgrid.js"/>
<%--	<g:javascript src="grids/cdt_client_inquiry_jqgrid.js" />--%>
<%--	<g:javascript src="grids/cdt_inquiry_jqgrid.js" />--%>
<%--	<g:javascript src="grids/import_advance_payment_inquiry_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/md_application_inquiry_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/mt_monitoring_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/rebate_inquiry_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/payment_other_import_charges_inquiry.js"/>--%>
<%--	<g:javascript src="grids/remittance_inquiry_grid.js"/>--%>
<%--	<g:javascript src="grids/settlement_actual_corres_charges_inquiry.js"/>--%>
<%--	<g:javascript src="grids/payment_jqgrid.js"/>--%>
<%--	<g:javascript src="grids/foreign_exchange_jqgrid.js" />--%>
<%--	<g:javascript src="grids/refund_cash_lc_charges_inquiry_jqgrid.js"/>--%>
<%--	--%>
<%--	<g:javascript src="popups/import_advance_create_ets_popup.js"/>--%>
<%--	<g:javascript src="popups/breakdown_popup.js" />--%>
<%--	<g:javascript src="popups/alert_utility.js" />--%>
<%--	--%>
<%--    <g:javascript src="utilities/other_imports/commons/initialize_forms.js" />--%>
        %{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
   <script type="text/javascript">
		var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${username}';
		var unitcode = '${session.unitcode}';

        var arMainInquiryGridUrl = '${g.createLink(controller: "inquiry", action: "searchMainArInquiryGrid")}';
        var arBranchInquiryGridUrl = '${g.createLink(controller: "inquiry", action: "searchBranchArInquiryGrid")}';
        %{--var apApplyUrl = '${g.createLink(controller: "apDataEntryApply", action: "viewApplyDataEntry")}';--}%
        var viewApprovedArUrl = '${g.createLink(controller: "documentClass", action: "viewApprovedAr")}';
        var multipleServiceInstructionUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleServiceInstruction")}';
	</script>
	
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>
	
	<div id="body_forms">
		<g:hiddenField name="referenceType" value="${referenceType}" />
		<g:hiddenField name="serviceType" value="${serviceType}" />
		<g:hiddenField name="documentType" value="${documentType}" />
		<g:hiddenField name="documentClass" value="${documentClass}" />
		<g:hiddenField name="username" value="${username}" />
		<form id="arInquiry" class="inquiry_form">
		<table class="body_forms_table">
			<tr>
				<td> <span class="field_label"> Reference Number </span> </td>
				<td> <g:textField class="input_field" name="referenceNumber" /> </td>
				<td> <span class="field_label"> Status </span> </td>
				<td> <g:select class="select_dropdown" name="status" from="${['OUTSTANDING', 'CLOSED', 'REFUNDED']}" noSelection="['':'Select One']" /> </td>
			</tr>
			<tr>
				<td> <span class="field_label"> CIF Name </span> </td>
				<td>
					<g:textField class="input_field" name="cifNameSearch" />
					<a href="javascript:void(0)" class="search_btn popup_btn_cif_normal"> Search/Look-up Button </a>
				</td>
				<td> <span class="field_label"> Document Number </span> </td>
				<td> <g:textField class="input_field" name="documentNumber" /> </td>
			</tr>
                <g:if test="${session['userrole']['id'].contains("TSD")}">
				<tr>
	            	<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
	            </tr>
	            </g:if>
			<tr>
				<td>&#160;</td>
			</tr>
			<tr> <%-- BUTTON --%>
				<td colspan="4"> 
					<table class="body_forms_table_btn">
						<tr><td> <input type="button" class="input_button" value="Search" id="searchArBtn"/> </td></tr>
						<tr><td> <input type="button" class="input_button_negative" value="Reset" id="resetArBtn"/> </td></tr>
					</table>
				</td>
			</tr>  
		</table>
		</form>
		<%-- JQGRID --%>
		<div class="grid_wrapper">
            <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
	  			<table id="grid_list_ar_inquiry_main"></table>
			</g:if>
            <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
				<table id="grid_list_ar_inquiry_branch"></table>
			</g:if>
			<div id="grid_pager_ar_monitoring_inquiry"></div>
		</div>	
	</div>
</div>			
<%--<g:render template="../layouts/confirm_alert" />--%>
<g:javascript src="popups/alert_utility.js"/>   
<g:render template="../layouts/alert" />
<%--<g:render template="../lc/commons/popups/ec_login" />--%>
<%--<g:render template="../lc/commons/popups/cif_search_popup" />--%>
<g:render template="../commons/popups/cif_search_normal"/>
<%--<g:render template="../others/commons/popups/monitoring_breakdown_popup" />--%>
<%--<g:render template="../others/commons/popups/import_advanced_inquiry_popup"/>--%>
<g:javascript src="popups/cif_normal_search_popup.js"/>
<%--<g:javascript src="popups/cif_search_popup.js"/>--%>

<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />

<g:render template="../commons/popups/create_ets_main_popup" />

<g:render template="../commons/popups/create_non_lc_popup" />
<g:render template="../commons/popups/view_transaction_main_popup"/>
</body>
</html>