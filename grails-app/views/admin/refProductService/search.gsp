<%@ page import="net.ipc.utils.NumberUtils; java.text.DecimalFormat" %>
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
    <g:render template="/layouts/header" model="${[title: "Product Service Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Product Service Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        %{--<li><a href="<g:createLink action="add"/>">Add</a></li>--}%
                        %{--<li>&nbsp;</li>--}%
                        <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>

        <g:form id="refProductServiceInquiry" class="inquiry_form" method="post" controller="refProductServiceAdmin" action="search">
            <table class="body_forms_table">
                <tr>
                    <td colspan="2"><span class="field_label">Product ID</span></td>
                    <td>
                        <input type="text" class="input_field" name="productId" id="productId" value="" />
                    </td>
                    <td colspan="2"><span class="field_label">Service Type</span></td>
                    <td>
                        <input type="text" class="input_field" name="serviceType" id="serviceType" value="" />
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
                                    <input type="reset" class="input_button_negative" onclick="clearParameters(); form.submit();" value="Reset"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <div class="grid_wrapper">
                <table id="refproductservicesearchtable">
                    <thead>
                    <th>Product ID</th>
                    <th>Service Type</th>
                    <th>Financial</th>
                    <th>Branch Approval Requirement</th>
                    <th>Post Approval Required?</th>
                    <th>Action</th>
                    </thead>
                    <tbody>
                    <g:each in="${refProductServices}" var="refProductService">
                        <tr>
                        <td>${refProductService?.productId?.productId}</td>
                        <td>${refProductService?.serviceType.replace('_', ' ')}</td>
                        <td>${NumberUtils.booleanFormatYesNo(refProductService?.financial)}</td>
                        <g:if test="${(NumberUtils.wholeNumberFormat(refProductService?.branchApprovalRequiredCount) == "1")}">
                            <td>APPROVER ONLY</td>
                        </g:if>
                        <g:elseif test="${(NumberUtils.wholeNumberFormat(refProductService?.branchApprovalRequiredCount) == "2")}">
                            <td>CHECKER AND APPROVER</td>
                        </g:elseif>
                        <g:else>
                            <td></td>
                        </g:else>
                        <td>${refProductService?.postApprovalRequirement.replace('_', ' ')}</td>
                        <td><a href="<g:createLink controller="refProductServiceAdmin" action="view" params="${[u:NumberUtils.wholeNumberFormat(refProductService?.productServiceId)]}"/>">view</a></td>
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
        tableToGrid('#refproductservicesearchtable', {width : 780, height: 200, scrollOffset : 0, rowNum: 9,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
        jQuery("#refproductservicesearchtable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
    });

    function clearParameters(){
        $("#productId").val("");
        $("#serviceType").val("");

    }
</script>
</body>
</html>