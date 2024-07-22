<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title>Trade Finance System </title>
    <script type="text/javascript">
        var referenceType = '${referenceType}';
        var serviceType = '${serviceType}';
        var documentType = '${documentType}';
        var documentClass = '${documentClass}';
        var username = '${username}'
       	var userrole = '${session.userrole.id}';
       	var unitcode = '${session.unitcode}';

        //ets - monitoring
        var mdApplicationBranch = '${g.createLink(controller:'inquiry', action:'searchBranchMdApplicationInquiryGrid')}';
        var mdApplicationMain = '${g.createLink(controller:'inquiry', action:'searchMainMdApplicationInquiryGrid')}';

        var createMdApplicationRefundEtsUrl = '${g.createLink(controller:'mdEtsApplicationRefund', action:'viewApplicationRefundEts')}';
        var createMdApplicationApplyRefundDataEntryUrl = '${g.createLink(controller:'mdDataEntryApplication', action:'viewApplicationDataEntry')}';

        var togglePnSupportUrl = '${g.createLink(controller: "inquiry", action: "togglePnSupport")}';
    </script>
    <g:javascript src="grids/md_application_inquiry_jqgrid.js"/>
    <g:javascript src="utilities/inquiry/md_inquiry_utility.js"/>
    <g:javascript src="popups/alert_utility.js"/>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
    <%-- HEADER --%>
    <g:render template="../layouts/header"/>

    <%-- ACCORDION --%>
    <g:render template="../layouts/accordion"/>

    <div id="body_forms">
        <form id="mdApplicationInquiry" class="inquiry_form">
            <table class="body_forms_table">
                <tr>
                    <td> <span class="field_label"> Document Number </span> </td>
                    <td> <g:textField class="input_field" name="documentNumber" /> </td>
                    <td> <span class="field_label"> LC Expiry Date </span> </td>
                    <td> <g:textField class="datepicker_field" name="expiryDate" /> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> Client Name </span> </td>
                    <td><g:textField class="input_field" name="clientName" /></td>
                    <td> <span class="field_label"> Status </span> </td>
                    <td>
                        <g:select from="${['Outstanding', 'Paid']}" keys="${['OUTSTANDING', 'PAID']}" noSelection="['': 'Select One...']" class="select_dropdown" name="status" />
                    </td>
                </tr>
                <g:if test="${session['userrole']['id'].contains("TSD")}">
				<tr>
	            	<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
	            </tr>
	            </g:if>
                <tr>
                    <td colspan="4">
                        <table class="body_forms_table_btn">
                            <tr><td> <input type="button" class="input_button" id="searchMdApplicationBtn" value="Search" /> </td></tr>
                            <tr><td> <input type="button" class="input_button_negative" id="resetMdApplicationBtn" value="Reset" /> </td></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <%-- JQGRID --%>
        <div class="grid_wrapper">

            <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                <table id="grid_list_md_application_inquiry_branch"></table>
                <div id="grid_pager_md_application_inquiry_branch"></div>
            </g:if>

        	<g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                <table id="grid_list_md_application_inquiry_main"></table>
                <div id="grid_pager_md_application_inquiry_main"></div>
            </g:if>
        </div>
    </div>
</div>

<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_non_lc_popup" />
<g:render template="../layouts/alert" />
</body>
</html>