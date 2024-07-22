
<%@ page import="net.ipc.utils.NumberUtils; net.ipc.utils.DateUtils" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>
    <script type="text/javascript">
        var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
    </script>
    <g:javascript src="utilities/commons/autocomplete_utility.js"/>
</head>
<body>

<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="/layouts/header" model="${[title: "Bank Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Bank Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                        <li><a href="<g:createLink controller="refBankAdmin"/>">Bank Maintenance</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>

        <g:form  id="refBankForm" class="inquiry_form" method="post" controller="refBankAdmin" action="save">
            <g:hiddenField name="userId" value="${session.username}" />
            <input id="saveMode" name="saveMode" type="hidden" value="<g:if test="${params.u == null || params.u == ""}">add</g:if><g:else>edit</g:else>"/>
            <table class="body_forms_table">
                <g:if test="${params.error != null && params.error != ""}">
                <tr>
                    <td colspan="3"><span class="field_label">An error occured: ${params.error}</span></td>
                </tr>
                </g:if>
                <tr>
                    <td width="200"><span class="field_label">BIC<span class="asterisk">*</span></span></td>
                    <td colspan="2">
                        <input type="text" class="input_field required" name="bic" id="bic" value="${refBank?.bic}" maxlength="8" <g:if test="${params.u != null && params.u != ""}">readonly="readonly"</g:if>/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Branch Code<span class="asterisk">*</span></span></td>
                    <td colspan="2">
                        <input type="text" class="input_field required" name="branchCode" id="branchCode" value="${refBank?.branchCode}" maxlength="3" <g:if test="${params.u != null && params.u != ""}">readonly="readonly"</g:if>/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Institution Name</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="institutionName" id="institutionName" value="${refBank?.institutionName}" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Branch Info</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="branchInfo" id="branchInfo" value="${refBank?.branchInfo}" maxlength="255"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">City</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="city" id="city" value="${refBank?.city}" maxlength="50"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 1</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="address1" id="address1" value="${refBank?.address1}" maxlength="100"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 2</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="address2" id="address2" value="${refBank?.address2}" maxlength="100"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 3</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="address3" id="address3" value="${refBank?.address3}" maxlength="100"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 4</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="address4" id="address4" value="${refBank?.address4}" maxlength="100"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Location</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="location" id="location" value="${refBank?.location}" maxlength="100"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">RMA Flag</span></td>
                    <td colspan="2">
                        <g:select name="rmaFlag" value="${refBank?.rmaFlag}" class="select_dropdown rmaFlag" from="${['Yes', 'No']}" keys="${["Y", "N"]}" noSelection="['':'SELECT ONE...']"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Depository Flag</span></td>
                    <td colspan="2">
                        <g:select name="depositoryFlag" value="${refBank?.depositoryFlag}" class="select_dropdown depositoryFlag" from="${['Yes', 'No']}" keys="${["Y", "N"]}" noSelection="['':'SELECT ONE...']"/>
                    </td>
                </tr>
%{--
                <tr>
                    <td width="200"><span class="field_label">GL Bank Code</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="glBankCode" id="glBankCode" value="${refBank?.glBankCode}" maxlength="20"/>
                    </td>
                </tr>
--}%
                <tr>
                    <td width="200"><span class="field_label">RBU Account</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="rbuAccount" id="rbuAccount" value="${refBank?.rbuAccount}" maxlength="35"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">RBU GL Code</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="glCodeRbu" id="glCodeRbu" value="${refBank?.glCodeRbu}" maxlength="12"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">FCDU Account</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="fcduAccount" id="fcduAccount" value="${refBank?.fcduAccount}" maxlength="35"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">FCDU GL Code</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="glCodeFcdu" id="glCodeFcdu" value="${refBank?.glCodeFcdu}" maxlength="12"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">CB Creditor Code</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field numericWholeQuantity" name="cbCreditorCode" id="cbCreditorCode" value="${refBank?.cbCreditorCode}" maxlength="12"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Reimbursing Currency</span></td>
                    <td colspan="2">
                        <input class="tags_currency select2_dropdown bigdrop" name="reimbursingCurrency" id="reimbursingCurrency" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table class="body_forms_table_btn">

                            <tr>
                                <td>
                                    <input id="btnResetForm" type="button" class="input_button_negative" value="Reset" onclick="resetFields()"/>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <input id="btnSaveForm" type="button" class="input_button" value="Save"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="button" class="input_button_negative" value="Cancel" onclick="javascript:window.location='/tfs-web/refBankAdmin/index'"/>
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
    	$("#cbCreditorCode").autoNumeric({aSep: "", mDec: 0, vMax: '999999999999'});
        $("#reimbursingCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${refBank?.reimbursingCurrency?.currencyCode}'});

        $("#btnSaveForm").click(function(e) {

            showConfirmAlertPopup();
        });
        $("#bic").change(validateBIC);
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
    $("#btnAlertOk").click(disableAlertMessage);
    function validateBIC(){
        var bic = $("#bic").val();
        var validBic = /^.{8,8}$/;

        if (bic.match(validBic)){}
            //alert("OK");
        else   {
            triggerAlertMessage("Invalid BIC, must be eight characters long.");
             $("#bic").val("");
        }

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

    function resetFields()
    {

        $(".inquiry_form :input").each(function(){

            if($(this).attr("type")=="text"){
                if($(this).attr("class")&&$(this).attr("class").indexOf("select_dropdown")!=-1) {
                    $(this).select2('data',{id:""});
                }
                if($(this).attr("class")=='datepicker_field hasDatepicker'){
                    $(this).val("");
                }
                if($(this).attr("readonly") != "readonly"){
                    $(this).val("");
                }
            }else if($(this).attr("type")=="radio")    {
                $(this).removeAttr("checked");
            }
            $('#reimbursingCurrency').select2('data',{id: null});
            $('#rmaFlag').val("");
            $('#depositoryFlag').val("");




        });
        $('#cbCreditorCode').val(0);

    }
    //for bic validation
    function  triggerAlertMessage(text1){
        $("#alertMessage").text(text1);
        centerPopup("popup_alert_dv","popup_alert_bg");
        loadPopup("popup_alert_dv","popup_alert_bg");
    }

    function disableAlertMessage(){

        disablePopup("popup_alert_dv","popup_alert_bg");
    }


</script>

</body>
</html>