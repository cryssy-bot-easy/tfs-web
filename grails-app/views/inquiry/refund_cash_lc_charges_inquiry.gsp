<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>
    <g:javascript src="grids/refund_cash_lc_charges_inquiry_jqgrid.js"/>
    <g:javascript src="popups/alert_utility.js"/>
    <script type="text/javascript">
        var searchRefundUrl = '${g.createLink(controller: "inquiry", action: "searchRefundInquiry")}';
        var refundPaymentsUrl = '${g.createLink(controller: "product", action: "viewRefundProductServiceCharge")}';

        var searchImportProductsUrl = '${g.createLink(controller: "inquiry", action: "searchImportProducts")}';

        var unitcode = '${session.unitcode}';
    </script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>
	 
	<div id="body_forms">
        <form id="refundInquiry" class="inquiry_form">
            <table class="body_forms_table">
                <tr>
                    <td class=""> <span class="field_label"> Document Number</span> </td>
                    <td class="input_width"> <g:textField name="documentNumber" class="input_field"/> </td>
                    <td class=""><span class="field_label"> CIF Name </span></td>
                    <td class="input_width"> <g:textField name="cifName" class="input_field"/> </td>
                </tr>
            </table>
            <br/>
            <br/>
            <table class="buttons_for_grid_wrapper">
                <tr>
                    <td><input type="button" id="refundSearch" class="input_button" value="Search" /></td>
                </tr>
                <tr>
                    <td><input type="button" id="refundReset" class="input_button_negative" value="Reset" /></td>
                </tr>
            </table>
        </form>
		<br/>
		<div class="grid_wrapper">
			<%-- JQGRID --%>
			<table id="grid_list_refund_cash_lc_charges"></table>
			<div id="grid_pager_refund_cash_lc_charges"></div>
		</div>
	</div>
</div>

<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_ets_main_popup" />

<g:render template="../commons/popups/create_non_lc_popup" />
<g:render template="../commons/popups/view_transaction_main_popup"/>

<g:render template="../layouts/alert" />
</body>
</html>