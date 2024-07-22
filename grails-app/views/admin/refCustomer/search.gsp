<%@ page import="net.ipc.utils.NumberUtils" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>


</head>
<body style="visibility: hidden;">

<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="/layouts/header" model="${[title: "Customer Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Customer Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                    	<li><a href="<g:createLink controller="refCustomerAdmin" action="addIndividual"/>"> Add Individual </a></li>
                    	<li><a href="<g:createLink controller="refCustomerAdmin" action="addCorporate"/>"> Add Corporate </a></li>
                        <%-- <li><a href="<g:createLink action="add"/>">Add</a></li> --%> 
                        <li>&nbsp;</li>
                        <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>

        <g:form id="refCustomerInquiry" class="inquiry_form" method="post" controller="refCustomerAdmin" action="search">
            <table class="body_forms_table">
                <tr>
                    <td colspan="2"><span class="field_label">CB Code</span></td>
                    <td>
                        <input type="text" class="input_field" name="centralBankCode" id="centralBankCode" value="" />
                    </td>
                    <td colspan="2"><span class="field_label">Last Name / Name of Corporation</span></td>
                    <td>
                        <input type="text" class="input_field" name="cifLongNameB" id="cifLongNameB" value="" />
                    </td>
                </tr>
                    <tr>
                        <td colspan="2"><span class="field_label">Tax Account Number</span></td>
                        <td>
                            <input type="text" class="input_field" name="clientTaxAccountNumber" id="clientTaxAccountNumber" value="" />
                        </td>
                        <td colspan="2"><span class="field_label">First Name</span></td>
                        <td>
                            <input type="text" class="input_field" name="cifLongName" id="cifLongName" value="" />
                        </td>
                    </tr>
                <tr>
                    <td colspan="6">
                        <table class="body_forms_table_btn">
                            <tr>
                                <td>
                                    <input type="button" class="input_button" value="Search" onclick="form.submit();"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="button" class="input_button_negative" value="Reset" onclick="clearParameters(); form.submit();"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            %{--refCustomers = ${refCustomers}--}%

            <div class="grid_wrapper">
                <table id="refcustomersearchtable">
                    <thead>
                    <th width="120">CB Code</th>
                    <th>Tax Account Number</th>
                    <th width="270">Last Name / Name of Corporation</th>
                    <th width="170">First Name</th>
                    <th>Action</th>
                    </thead>
                    <tbody>
                    <g:each in="${refCustomers}" var="refCustomer">
                        <tr>
                            <td>${refCustomer.centralBankCode}</td>
                            <td>${refCustomer.clientTaxAccountNumber}</td>
                            <td>${refCustomer.cifLongNameB}</td>
                            <td>${refCustomer.cifLongName}</td>
                            <td><a href="<g:createLink controller="refCustomerAdmin" action="view" params="${[u:NumberUtils.wholeNumberFormat(refCustomer.customerId)]}"/>">view</a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div id="pager"></div>
            </div>
        </g:form>

        <br/><br/><br/><br/>

    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
//            setupJqGridWidthNoPagerHidden('usersearchtable', {width : 780, height: 100, scrollOffset : 0, loadComplete: updateTotals},
//                    [['userid', 'User Id', 120, 'left'],
//                        ['name', 'Full Name', 100, 'center']], userSearchUrl);

        tableToGrid('#refcustomersearchtable', {width : 780, height: 200, scrollOffset : 0, rowNum: 9,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
        jQuery("#refcustomersearchtable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
    });

    function clearParameters()
    {

        $("#centralBankCode, #clientTaxAccountNumber, #cifLongNameB, #cifLongName").val("");
    }

</script>
</body>
</html>