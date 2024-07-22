<%@ page import="net.ipc.utils.NumberUtils" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="user_admin" />
    <script type="text/javascript">

        function showAlert(alertMessage){
            $("#alertMessage").html(alertMessage);

            mLoadPopup($("#popup_alert_dv"), $("#popup_alert_bg"));
            mCenterPopup($("#popup_alert_dv"), $("#popup_alert_bg"));

            $("#btnAlertOk").focus();
        }

        $(document).ready(function() {
            $("#cancelDesignation").click(function() {
                location.href = '${g.createLink(controller: "designation", action: "index")}';
            });

            $("#btnSaveForm").click(function(e) {

                $("#changeAuthorizationUsername, #changeAuthorizationPassword").val("");

                var error = 0;

                $("#body_forms :input").each(function () {
                    if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {

                        if ($(this).val() == "") {
                            error ++;
                        }
                    }
                });

                if (error > 0) {
                    showAlert("Please fill-up all required fields.");
                } else {
                    loadPopup("changeAuthorizationDiv", "changeAuthorizationBg");
                    centerPopup("changeAuthorizationDiv", "changeAuthorizationBg");
                }
            });

            $("#changeAuthorizationConfirm").click(function() {
                $.post('${g.createLink(controller: "login", action: "authenticateChange")}',
                        {username: $("#changeAuthorizationUsername").val(), password: $("#changeAuthorizationPassword").val()},
                        function(data) {

                        if (data.success) {
                            $("form").submit();
                        } else {
                            showAlert(data.message);
                        }

                });
            });

            $("#changeAuthorizationCancel").click(function() {
                disablePopup("changeAuthorizationDiv", "changeAuthorizationBg");
            });

        });
    </script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
    <%-- HEADER --%>
    <g:render template="../layouts/header"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Designation Maintenance Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="position"/>">Back to Designation Maintenance</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

<div id="body_forms">
    <ul>
        <li>&nbsp;</li>
    </ul>

    <g:form id="designationForm" class="inquiry_form" method="post" controller="position" action="save">
        <table class="body_forms_table">
            <tr>
                <td colspan="2"><span class="field_label">Description<span class="asterisk">*</span></span></td>
                <td>
                    <g:textField name="description" value="${designation?.description}" class="input_field required"/>
                </td>
            </tr>

            <tr>
                <td colspan="2"><span class="field_label">Level<span class="asterisk">*</span></span></td>
                <td>
                    <g:textField name="level" value="${designation?.level}" class="input_field required"/>
                </td>
            </tr>

            <tr>
                <td colspan="6">
                    <table class="body_forms_table_btn">
                        <tr>
                            <td>
                                <input id="btnSaveForm" type="button" class="input_button" value="Save"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="button" class="input_button_negative" value="Cancel" id="cancelDesignation"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </g:form>

</div>
<%-- End of TABS --%>
</div>

<g:render template="/commons/popups/override_change_authorization"
          model="[overrideAuthDivId: 'changeAuthorizationDiv',
                  overrideAuthDivBg: 'changeAuthorizationBg',
                  overrideAuthUsernameId: 'changeAuthorizationUsername',
                  overrideAuthPasswordId: 'changeAuthorizationPassword',
                  overrideAuthConfirmId: 'changeAuthorizationConfirm',
                  overrideAuthCancelId: 'changeAuthorizationCancel'
          ]"/>

<g:render template="/layouts/loading" />
<g:render template="../admin/user/alert" />
</body>
</html>