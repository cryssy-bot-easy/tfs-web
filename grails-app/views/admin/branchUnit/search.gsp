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
            <g:render template="/layouts/header" model="${[title: "Branch Unit File Parameter Maintenance"]}"/>

            <div id="navigation">
                <div id="Accordion1" class="Accordion">
                    <div class="AccordionPanel">
                        <div class="AccordionPanelTab panelHome" id="accordpanel_home">Branch Unit Maintenance Actions</div>
                        <div class="AccordionPanelContent">
                            <ul>
                                <li><a href="<g:createLink action="add"/>">Add</a></li>
                                <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div id="body_forms">

                <br/><br/><br/>

                <g:form id="branchUnit" class="inquiry_form" method="post" controller="branchUnitAdmin" action="search">
                    <table class="body_forms_table">
                        <tr>
                            <td colspan="2"><span class="field_label">Unit Code</span></td>
                            <td><input type="text" class="input_field_normal_case" name="unitCode" id="unitCode" value="" /></td>
                            <td colspan="2"><span class="field_label">Unit Name</span></td>
                            <td><input type="text" class="input_field_normal_case" name="unitName" id="unitName" value="" /></td>
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
                                            <input type="reset" class="input_button_negative" value="Reset" onclick="form.submit();" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </g:form>

                <div class="grid_wrapper">
                    <table id=branchUnitTable>
                        <thead>
                        <th>Unit Code</th>
                        <th>Unit Name</th>
                        <th>Action</th>
                        </thead>
                        <tbody>
                        <g:each in="${branchUnit}" var="bu">
                            <tr>
                                <td>${bu.unitCode?.toUpperCase()}</td>
                                <td>${bu.unitName?.toUpperCase()}</td>
                                <td><a href="<g:createLink controller="branchUnitAdmin" action="view" params="${[unitCode:bu.unitCode]}"/>">view</a></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <div id="pager"></div>
                </div>

                <br/><br/><br/><br/>

            </div>
        </div>
    <script type="text/javascript">
        $(document).ready(function() {
            tableToGrid('#branchUnitTable', {width : 780, height: 200, scrollOffset : 0, rowNum: 9,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
            jQuery("#branchUnitTable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");

            $("#resetButton").click(function(){
            	$("#unitCode, #unitName").val("");
			});
            
        });

        
    </script>
</body>
</html>