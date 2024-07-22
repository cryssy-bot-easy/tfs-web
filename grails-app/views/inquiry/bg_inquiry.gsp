<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System </title>

    <script type="text/javascript">
    var multipleServiceInstructionUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleServiceInstruction")}';
        var viewBgUrl = '${g.createLink(controller: "documentClass", action: "viewApprovedIndemnity")}'
        var indemnityInquiryUrl = '${g.createLink(controller: "inquiry", action: "searchIndemnityInquiryGrid")}';
        var username = '${username}';
        var unitcode = '${session.unitcode}';

    </script>
    <g:javascript src="grids/bg_inquiry_jqgrid.js"/>
    <g:javascript src="utilities/commons/bg_inquiry_utility.js"/>
    <g:javascript src="popups/alert_utility.js"/>
</head>
<body style="visibility: hidden;" onload="js_Load()">

<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="../layouts/header"/>

    <%-- ACCORDION --%>
    <g:render template="../layouts/accordion"/>

    <div id="body_forms">
    <form action="" id="bgInquiry" class="inquiry_form">
        <table class="body_forms_table">
            <tr>
                <td class="label_width"> <span class="field_label"> Document Number </span> </td>
                <td class="input_width"> <g:textField class="input_field" name="documentNumber"/> </td>
                <td class="label_width"> <span class="field_label"> CIF Name </span> </td>
                <td class="input_width"> <g:textField class="input_field" name="cifName" /> </td>
            </tr>
            <tr>
                <td> <span class="field_label"> Original LC Amount </span> </td>
                <td><g:textField class="input_field" name="originalLcAmount" /></td>
                <td> <span class="field_label"> BG/BE Number </span> </td>
                <td> <g:textField class="input_field" name="bgNumber" /> </td>
            </tr>
            <tr>
                <td> <span class="field_label"> Shipment Number </span> </td>
                <td> <g:textField class="input_field" name="shipmentNumber"/> </td>
                <td> <span class="field_label"> Shipment Amount </span> </td>
                <td> <g:textField class="input_field_right" name="shipmentAmount" /></td>
            </tr>
            <tr>
                <td> <span class="field_label"> Status </span> </td>
                <td> <g:select name="status" from="${['OPEN','CLOSED']}" class="select_dropdown" noSelection="['':'SELECT ONE']"/> </td>
                <g:if test="${session['userrole']['id'].contains("TSD")}">
                	<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
                </g:if>
            </tr>
            <tr> <%-- BUTTON --%>
                <td colspan="4">
                    <table class="body_forms_table_btn">
                        <tr><td> <input type="button" class="input_button" id="searchBgInquiry" value="Search" /> </td></tr>
                        <tr><td> <input type="button" class="input_button_negative" id="resetBgInquiry" value="Reset" /> </td></tr>
                    </table>
                </td>
            </tr>
        </table> <%-- End of SEARCH Form--%>
    </form>
    <div class="grid_wrapper">
        <%-- JQGRID --%>
        <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                          <table id="grid_list_bg_inquiry_branch"></table>
                        </g:if>
                        <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                          <table id="grid_list_bg_inquiry_main"></table>
                        </g:if>
                        
        
        <div id="grid_pager_bg_inquiry"></div>
        
        <%--
        <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
            <table id="grid_list_bg_inquiry_branch"></table>
        </g:if>
        <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
            <table id="grid_list_bg_inquiry_main"></table>
        </g:if>
        <div id="grid_pager_bg_inquiry"></div>
        --%>


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