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
            <g:render template="/layouts/header" model="${[title: "User Maintenance"]}"/>


            <div id="navigation">
                <div id="Accordion1" class="Accordion">
                    <div class="AccordionPanel">
                        <div class="AccordionPanelTab panelHome" id="accordpanel_home">User Administration Actions</div>
                        <div class="AccordionPanelContent">
                            <ul>
                                <li><a href="<g:createLink action="add"/>">Add</a></li>
                                %{--<li>&nbsp;</li>--}%
                                %{--<li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>--}%
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div id="body_forms">

                <br/><br/><br/>

                <g:form id="lcInquiry" class="inquiry_form" method="post" controller="userAdmin" action="search">
                    <table class="body_forms_table">
                        <tr>
                            <td colspan="2"><span class="field_label">User ID</span></td>
                            <td><input type="text" class="input_field_normal_case" name="userid" id="userid" value="" /></td>
                            <td colspan="2"><span class="field_label">User Name</span></td>
                            <td>
                                <input type="text" class="input_field_normal_case" name="username" id="username" value="" />
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
                                            <input type="button" class="input_button_negative" value="Reset" id="resetLcBtn" onclick="clearParameters();form.submit();"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </g:form>

                <div class="grid_wrapper">
                    <table id="usersearchtablex">
                        <thead>
                        <th>User ID</th>
                        <th>User Name</th>
                        <th>Last Login</th>
                        <th>Action</th>
                        </thead>
                        <tbody>
                        ${allRoles}
                        <g:each in="${users}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.name}</td>
                                <td>${user.lastLogin}</td>
                                <td><a href="<g:createLink controller="userAdmin" action="view" params="${[u:user.id]}"/>">view</a></td>
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
//            setupJqGridWidthNoPagerHidden('usersearchtable', {width : 780, height: 100, scrollOffset : 0, loadComplete: updateTotals},
//                    [['userid', 'User Id', 120, 'left'],
//                        ['name', 'Full Name', 100, 'center']], userSearchUrl);

            tableToGrid('#usersearchtablex', {width : 780, height: 200, scrollOffset : 0, rowNum: 9,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
            jQuery("#usersearchtablex").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
        });

        function clearParameters()
        {

            $("#userid, #username").val("");

        }

    </script>
</body>
</html>