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
    <g:render template="/layouts/header" model="${[title: "Customer Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Customer Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                        <li><a href="<g:createLink controller="refCustomerAdmin"/>">Customer Maintenance</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>

        <g:form id="refCustomerForm" class="inquiry_form" method="post" controller="refCustomerAdmin" action="save">
            <input id="saveMode" name="saveMode" type="hidden" value="<g:if test="${params.u == null || params.u == ""}">add</g:if><g:else>edit</g:else>"/>
            <g:hiddenField name="customerId" value="${NumberUtils.wholeNumberFormat(refCustomer?.customerId)}" />
            <table class="body_forms_table">
                <g:if test="${params.error != null && params.error != ""}">
                <tr>
                    <td colspan="3"><span class="field_label">An error occured: ${params.error}</span></td>
                </tr>
                </g:if>
                <tr>
                    <td width="200"><span class="field_label">CB Code</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="centralBankCode" id="centralBankCode" value="${refCustomer?.centralBankCode}" maxlength="10" <g:if test="${params.u != null && params.u != ""}">readonly="readonly"</g:if>/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Client Short Name</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientShortName" id="clientShortName" value="${refCustomer?.clientShortName}" maxlength="20"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Client Long Name</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientLongName" id="clientLongName" value="${refCustomer?.clientLongName}" maxlength="60"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Tax Account Number</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientTaxAccountNumber" id="clientTaxAccountNumber" value="${refCustomer?.clientTaxAccountNumber}" maxlength="15"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">CIF Number</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientCifNumber" id="clientCifNumber" value="${refCustomer?.clientCifNumber}" maxlength="7"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 1</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientAddress1" id="clientAddress1" value="${refCustomer?.clientAddress1}" maxlength="25"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 2</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientAddress2" id="clientAddress2" value="${refCustomer?.clientAddress2}" maxlength="25"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 3</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientAddress3" id="clientAddress3" value="${refCustomer?.clientAddress3}" maxlength="25"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Address 4</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="clientAddress4" id="clientAddress4" value="${refCustomer?.clientAddress4}" maxlength="25"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Account Type</span></td>
                    <td colspan="2">
                        %{--<input type="text" class="input_field" name="accountType" id="accountType" value="${refCustomer?.accountType}"/>--}%
                        <g:select name="accountType" value="${refCustomer?.accountType}" class="select_dropdown accountType" from="${['Head Office', 'Unichem', 'Others']}" keys="${["1", "2", "9"]}" noSelection="['':'SELECT ONE...']"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Account Officer Code</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field numericWholeQuantity" name="accountOfficerCode" id="accountOfficerCode" value="${refCustomer?.accountOfficerCode}" maxlength="10"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Export Amount, Month-to-Date</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field numericCurrency" name="monthToDateExportAmount" id="monthToDateExportAmount" value="${refCustomer?.monthToDateExportAmount}"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Export Amount, Year-to-Date</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field numericCurrency" name="yearToDateExportAmount" id="yearToDateExportAmount" value="${refCustomer?.yearToDateExportAmount}"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Export Advance Balance</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field numericCurrency" name="exportAdvanceBalance" id="exportAdvanceBalance" value="${refCustomer?.exportAdvanceBalance}"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Red Clause Advance Balance</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field numericCurrency" name="redClauseAdvanceBalance" id="redClauseAdvanceBalance" value="${refCustomer?.redClauseAdvanceBalance}"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">EVAT Flag</span></td>
                    <td colspan="2">
                        %{--<input type="text" class="input_field" name="evatFlag" id="evatFlag" value="${refCustomer?.evatFlag}"/>--}%
                        <g:select name="evatFlag" value="${refCustomer?.evatFlag}" class="select_dropdown evatFlag" from="${['Yes', 'No']}" keys="${["Y", "N"]}" noSelection="['':'SELECT ONE...']"/>
                    </td>
                </tr>
%{--
                <tr>
                    <td width="200"><span class="field_label">Resident Classification</span></td>
                    <td colspan="2">
                        <g:select name="residentClassification" value="${refCustomer?.residentClassification}" class="select_dropdown residentClassification" from="${['Resident', 'Non-Resident']}" keys="${["1", "2"]}" noSelection="['':'SELECT ONE...']"/>
                    </td>
                </tr>
--}%
                <tr>
                    <td width="200"><span class="field_label">Client Type</span></td>
                    <td colspan="2">
                        %{--<input type="text" class="input_field" name="clientType" id="clientType" value="${refCustomer?.clientType}"/>--}%
                        <g:select name="clientType" value="${refCustomer?.clientType}" class="select_dropdown clientType" from="${['Individual', 'Corporate']}" keys="${["1", "2"]}" noSelection="['':'SELECT ONE...']"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Birthday</span></td>
                    <td colspan="2">
                        <input type="text" class="datepicker_field" name="clientBirthday" id="clientBirthday" value="${refCustomer ? (refCustomer.clientBirthday ? DateUtils.shortDateFormat(new Date(refCustomer.clientBirthday)) : '') : ''}"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">Client Number</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field numericWholeQuantity" name="clientNumber" id="clientNumber" value="${refCustomer?.clientNumber}" maxlength="10"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">UCPB CIF Number</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="ucpbCifNumber" id="ucpbCifNumber" value="${refCustomer?.ucpbCifNumber}" maxlength="10"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">CIF Short Name</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="cifShortName" id="cifShortName" value="${refCustomer?.cifShortName}" maxlength="20"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">CIF Long Name</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="cifLongName" id="cifLongName" value="${refCustomer?.cifLongName}" maxlength="40"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">CIF Long Name A</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="cifLongNameA" id="cifLongNameA" value="${refCustomer?.cifLongNameA}" maxlength="40"/>
                    </td>
                </tr>
                <tr>
                    <td width="200"><span class="field_label">CIF Long Name B</span></td>
                    <td colspan="2">
                        <input type="text" class="input_field" name="cifLongNameB" id="cifLongNameB" value="${refCustomer?.cifLongNameB}" maxlength="40"/>
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
                                    <input type="button" class="input_button_negative" value="Cancel" onclick="javascript:window.location='/tfs-web/refCustomerAdmin/index'"/>
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
			
/*
			if("" == $.trim($("#centralBankCode").val())){
				validated=false;
			}
*/

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