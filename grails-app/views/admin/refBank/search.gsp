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
    <g:render template="/layouts/header" model="${[title: "Bank Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Bank Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink action="add"/>">Add</a></li>
                        <li>&nbsp;</li>
                        <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>

        <g:form id="refBankInquiry" class="inquiry_form" method="post" controller="refBankAdmin" action="search">
            <table class="body_forms_table">
                <tr>
%{--
                    <td colspan="2"><span class="field_label">SWIFT Code</span></td>
                    <td>
                        <input type="text" class="input_field" name="swiftCode" id="swiftCode" value="" />
                    </td>
--}%
                    <td colspan="2"><span class="field_label">BIC</span></td>
                    <td>
                        <input type="text" class="input_field" name="bic" id="bic" value="" />
                    </td>
                    <td colspan="2"><span class="field_label">Branch Code</span></td>
                    <td>
                        <input type="text" class="input_field" name="branchCode" id="branchCode" value="" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">Institution Name</span></td>
                    %{--<td colspan="3">--}%
                    <td>
                        <input type="text" class="input_field" name="institutionName" id="institutionName" value="" />
                    </td>
                    <td colspan="2"><span class="field_label">Depository Bank (NOSTRO)?</span></td>
                    <td>
                        %{--<input type="" class="select_dropdown depositoryFlag" name="branchCode" id="branchCode" value="" />--}%
                        <select class="select_dropdown depositoryFlag" name="depositoryFlag" id="depositoryFlag">
                            <option value=""></option>
                            <option value="Y">Yes</option>
                            <option value="N">No</option>
                        </select>
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
                <table id="refbanksearchtable">
                    <thead>
                    <th width="100">SWIFT Code</th>
                    <th width="70">BIC</th>
                    <th width="70">Branch Code</th>
                    <th width="300">Institution Name</th>
                    <th>Location</th>
                    <th width="60">Action</th>
                    </thead>
                    <tbody>
                    <g:each in="${refBanks}" var="refBank">
                        <tr>
                            <td>${refBank.bic}${refBank.branchCode}</td>
                            <td>${refBank.bic}</td>
                            <td>${refBank.branchCode}</td>
                            <td>${refBank.institutionName}</td>
                            <td>${refBank.location}</td>
                            <td><a href="<g:createLink controller="refBankAdmin" action="view" params="${[u:refBank.bic+refBank.branchCode]}"/>">view</a></td>
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

        tableToGrid('#refbanksearchtable', {width : 780, height: 200, scrollOffset : 0, rowNum: 9,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
        jQuery("#refbanksearchtable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
    });

    function clearParameters()
    {

        $("#bic, #institutionName, #branchCode, #depositoryFlag").val("");
    }
</script>
</body>
</html>