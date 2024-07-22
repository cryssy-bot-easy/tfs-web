<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>
    %{--<g:javascript src="utilities/commons/lc_inquiry_utility.js"/>--}%
	<g:javascript src="grids/settlement_actual_corres_charges_inquiry.js"/>
    <g:javascript src="popups/view_transaction_main_popup.js"/>
    <g:javascript src="popups/alert_utility.js"/>
   <script type="text/javascript">
		var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${session.username}';
        var unitcode = '${session.unitcode}';

        var corresChargesInquiryUrl = '${g.createLink(controller: "inquiry", action: "searchActualCorresCharges")}';

        var corresChargesUrl = '${g.createLink(controller: "corresChargeEtsSettlement", action: "viewSettlementEts")}'

        var gotocorresChargeUrl = '${g.createLink(controller: "product", action: "gotoCorresCharge")}';
        %{--var gotocorresChargeUrl = '${g.createLink(controller: "corresCharges", action: "viewCorresChargeEts")}';--}%

        function createCorresEts(id) {
            //alert(id);
            var gotourl = gotocorresChargeUrl + "?documentNumber="+id+"&referenceType=ets";
            location.href = gotourl;
        }

        function createCorresDataEntry(id) {
            var gotourl = gotocorresChargeUrl + "?documentNumber="+id+"&referenceType=dataentry";
            location.href = gotourl;
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
        <form id="corresChargesInquiry" class="inquiry_form">
            <g:hiddenField name="referenceType" value="${referenceType}" />
            <g:hiddenField name="serviceType" value="${serviceType}" />
            <g:hiddenField name="documentType" value="${documentType}" />
            <g:hiddenField name="documentClass" value="${documentClass}" />
            <g:hiddenField name="username" value="${username}" />
            <table class="body_forms_table">
                <tr>
                    <td class="label_width"><span class="field_label">Document Number:</span></td>
                    <td><g:textField name="documentNumber" class="input_field" /> </td>
	                <g:if test="${session['userrole']['id'].contains("TSD")}">
	                	<td class="label_width"> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
	                </g:if>
                </tr>
                <tr>
                	<g:if test="${session['userrole']['id'].contains("TSD")}">
                    <td colspan="2"/>
                    </g:if>
                    <td/>
                    <td>
                        <table class="body_forms_table_btn">
                            <tr><td>
                                %{--<g:submitToRemote name="searchDocumentNumber" class="input_button" value="Search"/>--}%
                                <input type="button" name="searchDocumentNumber" id="searchDocumentNumber" class="input_button" value="Search" />
                            </td></tr>
                            <tr><td>
                                %{--<g:submitToRemote name="resetDocumentNumber" class="input_button_negative" value="Reset"/>--}%
                                <input type="button" name="resetDocumentNumber" id="resetDocumentNumber" class="input_button_negative" value="Reset" />
                            </td></tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br>
            <div class="grid_wrapper">
                <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                    <table id="grid_list_settlement_actual_corres_charges_inquiry_branch"></table>
                </g:if>
                <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                    <table id="grid_list_settlement_actual_corres_charges_inquiry_tsd"></table>
                </g:if>
                <div id="grid_pager_settlement_actual_corres_charges_inquiry"></div>
            </div>
        </form>
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