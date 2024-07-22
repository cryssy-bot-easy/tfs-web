
<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: cdt_inquiry.gsp


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
	<g:javascript src="grids/cdt_inquiry_jqgrid.js" />
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
	<g:javascript src="popups/alert_utility.js" />
<%--	--%>
<%--    <g:javascript src="utilities/other_imports/commons/initialize_forms.js" />--%>
%{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
	<g:javascript src="report/generateBatchDebitMemo.js"/>
   
	<script type="text/javascript">
		var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${username}';
		var userrole = '${session.userrole.id}';
		var unitcode = '${session.unitcode}';

		<%-- pay duties and taxes page  --%>
		var payDutiesAndTaxesUrl = '${g.createLink(controller:'payDutiesTaxes', action:'viewPayDutiesTaxesCdt')}';
		//refund page
		var collectionRefundUrl = '${g.createLink(controller:'collectionRefund', action:'viewRefundCdt')}';
<%--		var batchDebitMemoUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBatchDebitMemoReport")}';
		var batchDebitMemoUrl = '${g.createLink(controller:"genericReports", action:"runBatchDebitMemoReport")}';--%>
        var searchCdtPaymentUrl = '${g.createLink(controller: "inquiry", action: "cdtInquiryPaymentInquiry")}';
        var viewCdtPaymentUrl = '${g.createLink(controller: "product", action: "viewCdtPayment")}';
		var viewCdtRefundUrl = '${g.createLink(controller: "product", action: "viewCdtRefund")}';
		var validateMultipleCdtTradeServiceUrl = '${g.createLink(controller: "cdt", action: "validateMultipleCdtTradeService")}';
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
        <form id="cdtPaymentInquiryForm" class="inquiry_form">
		<table class="body_forms_table">
		
		<g:if test="${(session.unitcode.equals("909"))}">
			<tr>
				<td> <span class="field_label"> Branch </span> </td>
				
                      <td>
                        <tfs:branchListCode class="select_dropdown" name="branchListCode" id="branchListCode" />
                        
                        
                      
                    </td>
				
			
			</tr>
			
			</g:if>
			
			<tr>
				<td> <span class="field_label"> CDT Payment Ref No. </span> </td>
				<td><g:textField name="paymentReferenceNumber" class="input_field"/></td>
				<td> <span class="field_label"> Request Type </span> </td>
				<td></td>
				<td>
					%{--<g:select name="requestType" from="${['Advance','Final','IPF'] }" class="select_dropdown" noSelection="['':'Select One']"/>--}%
                    <g:select name="requestType" from="${['Advance','Final','IPF', 'Export']}" keys="${['ADVANCE','FINAL','IPF', 'EXPORT']}" class="select_dropdown" noSelection="['':'Select One']"/>
				</td>
			</tr>
			<tr>
				<td> <span class="field_label"> IED/IEIRD No. </span> </td>
				<td><g:textField class="input_field" name="iedNumber" /></td>
				<td> <span class="field_label"> Status </span> </td>
				<td></td>
				<td>
					<g:select name="status" from="${['New', 'Pending','Paid','For Refund', 'Remitted', 'Refunded', 'Sent to BOC'] }"
                              keys="${['NEW', 'PENDING', 'PAID', 'FORREFUND', 'REMITTED', 'REFUNDED', 'SENTTOBOC']}" class="select_dropdown" noSelection="['':'Select One']"/>
				</td>
			</tr>	
			<tr>
				<td> <span class="field_label"> Importer's Name </span> </td>
				<td><g:textField class="input_field" name="importerName" /></td>
				<td> <span class="field_label"> Date of Transaction </span> </td>
				<td> <span class="field_label"> From </span> </td>
				<td><g:textField class="datepicker_field" name="transactionDateFrom" /></td>
			</tr>
			<tr>
				<td> <span class="field_label"> AAB REF Code</span></td>
				<td><g:textField class="input_field" name="aabRefCode" /></td>
				<td> <span class="field_label"> </span> </td>
				<td> <span class="field_label"> To </span> </td>
				<td><g:textField class="datepicker_field" name="transactionDateTo" /></td>
			</tr>

            <tr><%-- BUTTON --%>
                <td colspan="6">
                    <table class="body_forms_table_btn">
                        <tr><td><input type="button" class="input_button" value="Search" id="searchCdtPaymentBtn"/></td></tr>
                        <tr><td><input type="button" class="input_button_negative" value="Reset" id="resetCdtPaymentBtn"/></td></tr>
                        <tr><td>&nbsp;</td></tr>
                        	<%-- JQGRID --%>
                        	<tr><td>
		<div class="grid_wrapper">
	  		<table id="grid_list_cdt_inquiry"></table>
			<div id="grid_pager_cdt_inquiry"></div>
		</div>
		</td></tr>	
                        <tr><td><input type="button" class="input_button_long" value="Batch Debit Memo" onclick="openBatchDebitMemoPopUp()"/></td></tr>
                    </table>
                </td>
            </tr>
    </table>
    </form>
	
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
<g:javascript src="new/cdt/cdt-payment-inquiry.js" />
</body>
</html>