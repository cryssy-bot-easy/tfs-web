s<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main" />
<title>Trade Finance System</title>
<g:javascript src="grids/payment_other_export_charges_inquiry.js" />
<g:javascript src="popups/alert_utility.js"/>
<script type="text/javascript">
    var username = '${username}';
	var userrole = '${session.userrole.id}';
	var unitcode = '${session.unitcode}';

    var searchAllExportsUrl = '${g.createLink(controller: "inquiry", action: "searchAllExportsForOtherCharges")}';
    var gotoOtherExportChargesUrl = '${g.createLink(controller: "product", action: "gotoOtherExportCharges")}';
</script>

</head>
<body style="visibility: hidden;" onload="js_Load()">
	<div id="outer_wrap">
		<%-- HEADER --%>
		<g:render template="../layouts/header" />

		<%-- ACCORDION --%>
		<g:render template="../layouts/accordion" />

		<div id="body_forms">
			<form id="otherExportChargesInquiry" class="inquiry_form">
                <table class="form_table_inquiry">
                    <tr>
                        <td class="label_width"><span class="field_label">Document Number</span> </td>
                        <td class="input_width"><g:textField name="documentNumber" class="input_field" /></td>
                        <td class="label_width"><span class="field_label">CIF Name</span> </td>
                        <td class="input_width"><g:textField name="cifName" class="input_field" /></td>
                    </tr>
                    <tr>
                         <td><span class="field_label">Transaction</span></td>
                        <td>
                            <tfs:exportTransactions name="transaction" class="select_dropdown" value="" />
                        </td>
                        <td><span class="field_label">Importer's Name</span></td>
                        <td><g:textField name="importerName" class="input_field" /></td>
                    </tr>
                    <tr>
                        <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
                        <td><span class="field_label">Exporter's Name</span></td>
                        <td><g:textField name="exporterName" class="input_field" /></td>
                    </tr>
                </table>
                <table class="body_forms_table_btn">
                    <tr>
                        <td>
                            <input type="button" id="exportChargesSearch" class="input_button" value="Search" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" id="exportChargesReset" class="input_button_negative" value="Reset" />
                        </td>
                    </tr>
                </table>
                <br/><br/><br/><br/><br/>
			</form>
			<div class="grid_wrapper">
                <g:if test="${session['group'].equals("BRANCH")}">
                    <table id="grid_list_payment_other_export_charges_inquiry"></table>
                </g:if>
                <g:if test="${session['group'].equals("TSD")}">
                    <table id="grid_list_payment_other_export_charges_inquiry_tsd"></table>
                </g:if>
                <div id="grid_pager_payment_other_export_charges_inquiry"></div>
			</div>

        <g:render template="../commons/popups/create_transaction_popup" />
        <g:render template="../commons/popups/create_ua_popup" />
        <g:render template="../commons/popups/create_ets_popup" />
        <g:render template="../commons/popups/create_ets_main_popup" />

        <g:render template="../commons/popups/create_non_lc_popup" />
        <g:render template="../commons/popups/view_transaction_main_popup"/>
        
		<g:render template="../layouts/alert" />
		</div>
	</div>
</body>
</html>
