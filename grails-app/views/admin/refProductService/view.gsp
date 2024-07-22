<%@ page import="net.ipc.utils.NumberUtils; net.ipc.utils.DateUtils" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>
</head>
<body>

<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="/layouts/header" model="${[title: "Product Service Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Product Service Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                        <li><a href="<g:createLink controller="refProductServiceAdmin"/>">Product Service Maintenance</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>

        <g:form  id="refProductServiceForm" class="inquiry_form" method="post" controller="refProductServiceAdmin" action="save">
            <input id="productServiceId" name="productServiceId" type="hidden" value="${NumberUtils.wholeNumberFormat(refProductService?.productServiceId)}"/>
            <table class="body_forms_table">
                <g:if test="${params.error != null && params.error != ""}">
                    <tr>
                        <td colspan="3"><span class="field_label">An error occured: ${params.error}</span></td>
                    </tr>
                </g:if>
                <tr>
                    <td width="200"><span class="field_label">Product ID<span class="asterisk">*</span></span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="productId" id="productId" value="${refProductService?.productId?.productId}" maxlength="10" <g:if test="${params.u != null && params.u != ""}">readonly="readonly"</g:if>/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Service Type<span class="asterisk">*</span></span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="serviceType" id="serviceType" value="${refProductService?.serviceType}" maxlength="3" <g:if test="${params.u != null && params.u != ""}">readonly="readonly"</g:if>/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Financial</span></td>
                    <td colspan="2">
                        <g:select name="financial" value="${NumberUtils.booleanFormatYesNo(refProductService?.financial)}" class="select_dropdown financial" from="${['YES', 'NO']}" keys="${[true, false]}"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Branch Approval Requirement</span></td>
                    <td colspan="2">
                        <g:select name="branchApprovalRequiredCount" value="${NumberUtils.wholeNumberFormat(refProductService?.branchApprovalRequiredCount)}" class="select_dropdown branchApprovalRequiredCount" from="${['APPROVER ONLY', 'CHECKER AND APPROVER']}" keys="${["1", "2"]}"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Post Approval Required?</span></td>
                    <td colspan="2">
                        <g:select name="postApprovalRequirement" value="${refProductService?.postApprovalRequirement}" class="select_dropdown postApprovalRequirement" from="${['YES', 'YES IF BEYOND', 'NO']}" keys="${["YES", "YES_IF_BEYOND", "NO"]}"/>
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
                                    <input type="button" class="input_button_negative" value="Cancel" onclick="javascript:window.location='/tfs-web/refProductServiceAdmin/index'"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </g:form>
    </div>

    <%--GSP for triggering alert popups--%>
    <g:render template="../layouts/alert"/>
    <%--GSP for triggering yes/no alert popups--%>
    <g:render template="../layouts/confirm_alert"/>
    <%--Popup plugin--%>
    <g:javascript src="pop_up.js"/>
    <script type="text/javascript">

        $(document).ready(function() {

            $("#btnSaveForm").click(function(e) {
                showConfirmAlertPopup();
            });

            $("#btnAlertConfirm").click(function(e) {
                //close yes/no alert
                mDisablePopup($("#popup_save_confirmation"),$("#confirmation_background"));
                if(validateForm()){
                    $('form').submit();
                }else{
                    //span element in alert.gsp
                    $("#alertMessage").html("Please fill in the required fields.");
                    showAlertPopup();
                }
            });


            //validate form
            function validateForm(){
                var validated=true;

                if("" == $.trim($("#productId").val())){
                    validated=false;
                }

                if("" == $.trim($("#serviceType").val())){
                    validated=false;
                }

                return validated;
            }

            //display alert message popup
            function showAlertPopup(){
                mCenterPopup($("#popup_alert_dv"),$("#popup_alert_bg"));
                mLoadPopup($("#popup_alert_dv"),$("#popup_alert_bg"));
            }

            //close alert popup
            $("#btnAlertOk").click(function(){
                mDisablePopup($("#popup_alert_dv"),$("#popup_alert_bg"));
            });

            //display yes/no alert message popup
            function showConfirmAlertPopup(){
                mCenterPopup($("#popup_save_confirmation"),$("#confirmation_background"));
                mLoadPopup($("#popup_save_confirmation"),$("#confirmation_background"));
            }

            //close yes/no alert popup
            $("#btnAlertNo").click(function(){
                mDisablePopup($("#popup_save_confirmation"),$("#confirmation_background"));
            });
        });
    </script>

</body>
</html>