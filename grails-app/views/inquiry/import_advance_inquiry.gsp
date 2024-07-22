<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>
	<g:javascript src="grids/import_advance_payment_inquiry_jqgrid.js"/>
	<g:javascript src="popups/alert_utility.js"/>
   <script type="text/javascript">
		var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${username}';
		var unitcode = '${session.unitcode}';

        var refundImportAdvanceUrl = '${g.createLink(controller: "product", action: "viewImportAdvanceRefund")}';
        var searchImportAdvanceInquiry = '${g.createLink(controller: "inquiry", action: "searchImportAdvanceInquiry")}';

	</script>
	
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>
	
	<div id="body_forms">
        <form id="importAdvanceInquiry" class="inquiry_form">
            <table class="body_forms_table">
                <tr>
                    <td> <span class="field_label"> CIF Name </span> </td>
                    <td>
                        <g:textField class="input_field" name="cifName" />
                        <a href="javascript:void(0)" class="search_btn popup_btn_cif_normal"> Search/Look-up Button </a>
                    </td>
                    <td> <span class="field_label">Currency</span> </td>
                    <td>
                        <input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" />
                    </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> Document Number </span> </td>
                    <td> <g:textField class="input_field" name="documentNumber" /> </td>
                    <td> <span class="field_label">Amount</span><span class="right_indent">From</span> </td>
                    <td><g:textField class="input_field numericCurrency" name="amountFrom" /></td>
                </tr>
                <tr>
	                <g:if test="${session['userrole']['id'].contains("TSD")}">
	                	<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
	                </g:if>
	                <g:else>
                    	<td colspan="2" />
                   	</g:else>
                    <td><span class="right_indent">To</span></td>
                    <td><g:textField class="input_field numericCurrency" name="amountTo" /></td>
                </tr>
                <tr>
                    <td>&#160;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table class="body_forms_table_btn">
                            <tr><td> <input type="button" class="input_button" value="Search" id="searchImportAdvance"/> </td></tr>
                            <tr><td> <input type="button" class="input_button_negative" value="Reset" id="resetImportAdvance" /> </td></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
		
		<%-- JQGRID --%>
		<div class="grid_wrapper">
			<g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
				<table id="grid_list_import_advanced_payment_main"></table>
			</g:if>
		    <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
				<table id="grid_list_import_advanced_payment_branch"></table>
 		 	</g:if>
			<div id="grid_pager_import_advanced_payment"></div>
		</div>	
		<br/><br />
	</div>
</div>			
<%--<g:render template="../layouts/confirm_alert" />--%>
<g:render template="../layouts/alert" />
<%--<g:render template="../commons/popups/ec_login" />--%>
<g:render template="../commons/popups/cif_search_popup" />
<g:render template="../commons/popups/cif_search_normal"/>
<%--<g:render template="../others/commons/popups/monitoring_breakdown_popup" />--%>
<%--<g:render template="../others/commons/popups/import_advanced_inquiry_popup"/>--%>
<g:javascript src="popups/cif_normal_search_popup.js"/>
<%--<g:javascript src="popups/cif_search_popup.js"/>--%>

<script>
    function onResetClick() {
        $("#cifName, #documentNumber, #amountFrom, #amountTo").val("");
    }

    $(document).ready(function() {
        $("#reset").click(onResetClick);
        $("#currency").setCurrencyDropdown($(this).attr("id"));
    });
</script>

</body>
</html>

%{--<script>--}%
    %{--$(document).ready(function() {--}%
        %{--$("#currency").select2('data',{id: '${currency}'});--}%
        %{--$("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});--}%
    %{--});--}%
%{--</script>--}%

