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
<g:render template="/layouts/header" model="${[title: "Country Maintenance"]}"/>

<div id="navigation">
    <div id="Accordion1" class="Accordion">
        <div class="AccordionPanel">
            <div class="AccordionPanelTab panelHome" id="accordpanel_home">Country Administration Actions</div>
            <div class="AccordionPanelContent">
                <ul>

                    <li><a href="<g:createLink controller="refCountryAdmin"/>">Country Maintenance</a></li>
                    <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id="body_forms">

    <br/><br/><br/>

    <g:form id="refCountryForm" class="inquiry_form" method="post" controller="refCountryAdmin" action="save">
        <input id="saveMode" name="saveMode" type="hidden" value="<g:if test="${params.u == null || params.u == ""}">add</g:if><g:else>edit</g:else>"/>
        %{--<g:hiddenField name="countryCode" value="${NumberUtils.wholeNumberFormat(refCountry?.countryCode)}" />--}%
        <table class="body_forms_table">
            <g:if test="${params.error != null && params.error != ""}">
                <tr>
                    <td colspan="3"><span class="field_label">An error occured: ${params.error}</span></td>
                </tr>
            </g:if>
            <tr>
                <td width="200"><span class="field_label">Country Code<span class="asterisk">*</span></span></td>
                <td colspan="2">
                    <input type="text" class="input_field required" name="countryCode" id="countryCode" value="${refCountry?.countryCode}" maxlength="3" <g:if test="${params.u != null && params.u != ""}">readonly="readonly"</g:if> />
                </td>
            </tr>
            <tr>
                <td width="200"><span class="field_label">Country Name<span class="asterisk">*</span></span></td>
                <td colspan="2">
                    <input type="text" class="input_field required" name="countryName" id="countryName" value="${refCountry?.countryName}" maxlength="25"/>
                </td>
            </tr>
            <tr>
                <td width="200"><span class="field_label">Country ISO</span></td>
                <td colspan="2">
                    <input type="text" class="input_field" name="countryISO" id="countryISO" value="${refCountry?.countryISO}" maxlength="2"/>
                </td>
            </tr>

            <tr>
                <td colspan="6">
                    <table class="body_forms_table_btn">
                        <tr>
                            <td>
                                <input id="btnResetForm" type="button" class="input_button" value="Reset" onclick="resetFields()"/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input id="btnSaveForm" type="button" class="input_button" value="Save"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="button" class="input_button_negative" value="Cancel" onclick="javascript:window.location='/tfs-web/refCountryAdmin/index'"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

    %{--<g:render template="../layouts/buttons_for_grid_wrapper" />--}%

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
            if(validateSubmitForm()){
                $('form').submit();
            }else{
                //span element in alert.gsp
                $("#alertMessage").html("Please fill in the required fields.");
                showAlertPopup();
            }
        });



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

            var validated = validateSubmitForm();

            if (validateSubmitForm() == 'success') {
                mCenterPopup($("#popup_save_confirmation"),$("#confirmation_background"));
                mLoadPopup($("#popup_save_confirmation"),$("#confirmation_background"));
            } else {
                $("#alertMessage").text("Please fill in all the required fields.");
                var mSave_div = $("#popup_alert_dv");
                var mBg = $("#popup_alert_bg");

                mLoadPopup(mSave_div, mBg);
                mCenterPopup(mSave_div, mBg);
                return true;
            }
        }

        //close yes/no alert popup
        $("#btnAlertNo").click(function(){
            mDisablePopup($("#popup_save_confirmation"),$("#confirmation_background"));
        });
    });

    function resetFields()
    {
        $(".inquiry_form :input").each(function(){

            if($(this).attr("type")=="text"){
                if($(this).attr("class")&&$(this).attr("class").indexOf("select_dropdown")!=-1) {
                    $(this).select2('data',{id:""});
                }
                if($(this).attr("readonly") != "readonly"){

                    $(this).val("");
                }

            }else if($(this).attr("type")=="radio")    {
                $(this).removeAttr("checked");
            }


        });
    }



    function validateSubmitForm() {
        var error = 0;

        $("#body_forms :input").each(function(){
            if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
                if ($(this).val() == "") {
                    error ++;
                    console.log("required\nid : " + $(this).attr("id") + "\nname : " + $(this).attr("name"));
//                console.log("hello");
                }
            }
        });

        if (error > 0) {
            return 'failed';
        }

        return 'success';
    }

</script>

</body>
</html>