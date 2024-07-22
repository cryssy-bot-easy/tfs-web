<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>
<%--	<g:javascript src="grids/ap_monitoring_inquiry_jqgrid.js" />--%>
<%--	<g:javascript src="grids/ar_monitoring_inquiry_jqgrid.js"/>--%>
	<g:javascript src="grids/cdt_client_inquiry_jqgrid.js" />
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
   
   <g:javascript src="popups/alert_utility.js"/>
   <script type="text/javascript">
		var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${username}';
		var userrole = '${session.userrole.id}';

		var encodeClientDetailsUrl = '${g.createLink(controller:'encodeClientDetails', action:'viewEncodeClientDetailsCdt')}';

        var searchCdtClientUrl = '${g.createLink(controller:'inquiry', action:'cdtInquiryClientInquiry')}';

        var viewCdtClientUrl = '${g.createLink(controller:'product', action:'viewCdtClient')}';
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
        <form id="cdtClientInquiryForm" class="inquiry_form">
		<table class="body_forms_table">
			<tr>
				<td class="label_width"><span class="field_label"> Importer's Name </span> </td>
				<td><g:textField class="input_field" name="importerName" /></td>
				<td class="label_width"><span class="field_label"> AAB Ref Code </span> </td>
				<td><g:textField class="input_field" name="aabRefCode" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> Custom's Client Number </span> </td>
				<td><g:textField class="input_field" name="customsClientNumber" /></td>
				<td class="label_width"><span class="field_label"> Importer TIN </span> </td>
				<td><g:textField class="input_field" name="importerTin" /></td>
			</tr>
        <tr><%-- BUTTON --%>
            <td colspan="6">
                <table class="body_forms_table_btn">
                    <tr><td><input type="button" class="input_button" value="Search" id="searchCdtClientBtn"/></td></tr>
                    <tr><td><input type="button" class="input_button_negative" value="Reset" id="resetCdtClientBtn"/></td></tr>
                </table>
            </td>
        </tr>
		</table>
        </form>
		
		<%-- JQGRID --%>
		<div class="grid_wrapper">
			<table id="grid_list_client_file_inquiry"></table>
			<div id="grid_page_client_file_inquiry"></div>
		</div>	
		<br/><br />
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

<g:javascript src="new/cdt/cdt-client-inquiry.js"/>
</body>
</html>