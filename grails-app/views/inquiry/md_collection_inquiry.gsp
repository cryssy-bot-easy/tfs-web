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

        //ets - monitoring
        var mdApplicationBranch = '${g.createLink(controller:'inquiry', action:'searchBranchMdCollectionInquiryGrid')}';
        var mdApplicationMain = '${g.createLink(controller:'inquiry', action:'searchMainMdCollectionInquiryGrid')}';
        var etsMonitoringUrl = '${g.createLink(controller:'etsMonitoring', action:'viewMonitoringAction')}';

        var createMdCollectionUrl = '${g.createLink(controller:'mdEtsCollection', action:'viewCollectionEts')}';

        var unitcode = '${session.unitcode}';
    </script>
    <g:javascript src="grids/md_collection_inquiry_jqgrid.js"/>
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
        <form id="mdCollectionInquiry" class="inquiry_form">
        <table class="body_forms_table">
            <tr>
                <td> <span class="field_label"> Document Number </span> </td>
                <td> <g:textField class="input_field" name="documentNumber" /> </td>
                <td> <span class="field_label"> Client Name </span> </td>
                <td><g:textField class="input_field" name="cifName" /></td>
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
                        <tr><td> <input type="button" class="input_button" id="searchMdCollectionBtn" value="Search" /> </td></tr>
                        <tr><td> <input type="button" class="input_button_negative" id="resetMdCollectionBtn" value="Reset" /> </td></tr>
                    </table>

                </td>
            </tr>
        </table>
        </form>
        <%-- JQGRID --%>
        <div class="grid_wrapper">
        <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                <table id="grid_list_md_collection_inquiry_main"></table>
                <div id="grid_pager_md_collection_inquiry_main"></div>
            </g:if>
            <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                <table id="grid_list_md_collection_inquiry_branch"></table>
                <div id="grid_pager_md_collection_inquiry_branch"></div>
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