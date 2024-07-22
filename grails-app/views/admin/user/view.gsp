
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>

</head>
<body>

<body>

<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="/layouts/header" model="${[title: "User Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">User Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="userAdmin"/>">Back to User Admin</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>

        <g:form  id="userForm" class="inquiry_form" method="post" controller="userAdmin" action="save">
            <input id="valid" type="hidden" value="<g:if test="${params.u == null}">false</g:if><g:else>true</g:else>"/>
            <table class="body_forms_table">
                <tr>
                    <td colspan="2"><span class="field_label">User Id</span></td>
                    <td>
                        <input type="text" class="input_field" name="userId" id="userId" value="${user?.userId?.id}" <g:if test="${params.u != null}">readonly="readonly"</g:if>/>
                        <g:if test="${params.u == null}">
                            <input id="btnValidate" type="button" value="Validate"/>
                        </g:if>
                    </td>

                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">User Name</span></td>
                    <td>
                        <input type="text" class="input_field" name="fullName" id="fullName" value="${user?.employeeDetails?.fullName!=null ? user?.employeeDetails?.fullName : user?.employeeDetails?.firstName + " " + user?.employeeDetails?.lastName}" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">Email</span></td>
                    <td>
                        <input type="text" class="input_field" name="email" id="email" value="${user?.employeeDetails?.email}" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">Unit Code</span></td>
                    <td>
                        <input type="text" class="input_field" name="unitCode" id="unitCode" value="${user?.employeeDetails?.unitCode}" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">Position</span></td>
                    <td>
                        <input type="text" class="input_field_normal_case" name="position" id="position" value="${user?.employeeDetails?.position}"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">Posting Limit</span></td>
                    <td>
                        <input type="text" class="input_field" name="postingLimit" id="postingLimit" value="<g:formatNumber number="${user?.employeeDetails?.postingLimit}" format="###,##0.00" />"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">Posting Authority</span></td>
                    <td>
                        <input type="checkbox" name="postingAuthority" id="postingAuthority" ${user?.employeeDetails?.postingAuthority ? "checked" : ""}/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span class="field_label">User Roles</span></td>
                    <td>
                        <table border="0">
                            <tr>
                                <td>
                                    <select multiple="true" id="userRoles" name="userRoles">
                                        <g:if test="${params.u != null}">
                                            <g:each in="${user.roles}" var="role">
                                                <option value="${role.roleId.roleId}">${role.description}</option>
                                            </g:each>
                                        </g:if>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table class="body_forms_table_btn">
                            <tr>
                                <td>
                                    <input id="btnSaveForm" type="button" class="input_button" value="Save""/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="button" class="input_button_negative" value="Cancel" id="resetLcBtn"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </g:form>
</div>

<script type="text/javascript">

    $(document).ready(function() {

        $("#userId").change(function() {
            $("#valid").val("false");
        });

        $("#btnValidate").click(function() {

            if($("#userId").val() != "") {
                $.ajax({
                    url:"${g.createLink(controller:'userAdmin',action:'validateUser')}",
                    dataType: 'json',
                    data: {
                        userId: $("#userId").val()
                    },
                    success: function(data) {
                        if(data.status == "ok") {
                            //$("#fullName").removeAttr('readonly');
                            //$("#unitCode").removeAttr('readonly');
                            $("#fullName").val(data.user.fullName);
                            $("#unitCode").val(data.user.unitCode);
                            $("#valid").val("true");

                            if($("#unitCode") == "") {

                            };

                            $('#userRoles')[0].options.length = 0;

                            if(data.user.roles) {
                                var roles = data.user.roles;
                                for(var x=0; x < data.user.roles.length; x++) {
                                    $('#userRoles').append(
                                        $('<option></option>').val(roles[x].roleId.roleId).html(roles[x].description)
                                    );
                                }
                            }

                        } else if (data.status == "not found") {
                            alert('User does not exist in Active Directory');
                        } else {
                            alert('Unable to retrieve details from Active Directory');
                        };
                    },
                    error: function(request, status, error) {
                        alert(error);
                    },
                    complete: function() {
                    }
                });
            }
        });

        $("#btnSaveForm").click(function(e) {

            if($("#valid").val() == 'true') {
                $('#userRoles option').attr('selected', 'selected');
                $('form').submit();
            } else {
                alert('Please validate userid before saving')
            }
        });

    });
</script>

</body>

</body>
</html>