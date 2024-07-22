<%@ page import="net.ipc.utils.NumberUtils; net.ipc.utils.DateUtils" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>

	<g:javascript src="popups/ets_opening_header_utility.js" />
    <g:javascript src="utilities/commons/autocomplete_utility.js" />
    <g:javascript src="utilities/commons/taxAccountNumberValidation.js" />


    <script type="text/javascript">
		//Auto Complete
        var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
        var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
        var autoCompleteCountryIsoUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountryIso')}';
        var newDate = new Date('${DateUtils.shortDateFormat(new Date())}');

</script>
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

        <g:form id="refCustomerForm" name="refCustomerForm" class="inquiry_form" method="post">
            <input id="saveMode" name="saveMode" type="hidden" value="<g:if test="${params.u == null || params.u == ""}">add</g:if><g:else>edit</g:else>"/>
            <g:hiddenField name="customerId" value="${NumberUtils.wholeNumberFormat(refCustomer?.customerId)}" />
            <g:hiddenField name="clientType" value="${refCustomer?.clientType ?: '2'}" />
            <g:hiddenField name="customerNumber" value="${refCustomer?.customerId ? NumberUtils.wholeNumberFormat(refCustomer?.customerId) : ''}" id="customerNumber" />
        <table class="body_forms_table">
                <g:if test="${params.error != null && params.error != ""}">
                <tr>
                    <td colspan="3"><span class="errorMessage">An error occured: ${params.error}</span></td>
                </tr>
                </g:if>
                
                <tr>
                	%{--<td width="200"><span class="field_label"> Customer Number </span></td>--}%
                	%{--<td width="250"> <input type="text" class="input_field" name="customerNumber" value="${refCustomer?.customerId ? NumberUtils.wholeNumberFormat(refCustomer?.customerId) : ''}" id="customerNumber" readonly="readonly" /> </td>--}%


                    <td width="200"><span class="field_label"> CB Code <span class="asterisk">*</span></span></td>
                	<td> <input type="text" class="input_field numericWholeQuantity required" name="centralBankCode" id="centralBankCode" value="${refCustomer?.centralBankCode}"  /> </td>
                    %{--<td> <input class="tags_cbcode select2_dropdown bigdrop" name="centralBankCode" id="centralBankCode" /> </td>--}%
                </tr>
                <tr>
                	<td><span class="field_label"> Customer Type </span></td>
                	<td colspan="3"> <input type="text" class="input_field" name="customerType" id="customerType" value="${refCustomer?.customerType ?: '400'}" readonly="readonly" /> </td>
                </tr>

                %{--<tr>
                    <td><span class="field_label"> CIF Number </span></td>
                    <td colspan="3">
                        <input type="text" class="input_field" name="cifNumber" id="cifNumber" value="${refCustomer?.clientCifNumber}" />
                        <a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a>
                    </td>
                </tr>--}%

                %{--<tr>--}%
                	%{--<td><span class="field_label"> Name of Corporation <span class="asterisk">*</span></span></td>--}%
                	%{--<td colspan="3"> <input type="text" class="input_field" name="nameOfCorporation" id="nameOfCorporation" value="${refCustomer?.clientLongName}" maxlength="100"/> </td>--}%
                %{--</tr>--}%

                <tr>
                    <td><span class="field_label"> Name of Corporation <span class="asterisk">*</span></span></td>
                    <td> <input type="text" class="input_field required" name="nameOfCorporation" id="nameOfCorporation" value="${refCustomer?.cifLongNameB}" maxlength="40"/> </td>
                    <td>&nbsp;</td>
                </tr>
                %{--<tr>--}%
                    %{--<td></td>--}%
                    %{--<td colspan="3"> <input type="text" class="input_field" name="nameOfCorporation2" id="nameOfCorporation2" value="${refCustomer?.cifLongNameA}" maxlength="100"/> </td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                    %{--<td>&nbsp;</td>--}%
                    %{--<td colspan="3"> <input type="text" class="input_field" name="nameOfCorporation3" id="nameOfCorporation3" value="${refCustomer?.cifLongNameB}" maxlength="100"/> </td>--}%
                %{--</tr>--}%

                <tr>
                	<td><span class="field_label"> Date of Incorporation </span></td>
                	<td colspan="3"> <input type="text" class="datepicker_field" name="dateOfIncorporation" id="dateOfIncorporation" value="${refCustomer?.clientBirthday}" /> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Country </span></td>
                	<td colspan="3"> <input class="tags_country select2_dropdown bigdrop" name="country" id="country"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Address <span class="asterisk">*</span></span></td>
                	<td>
                        <input type="hidden" class="required" name="addressComplete" id="addressComplete" />
                        <input type="text" class="input_field" name="clientAddress1" id="clientAddress1" value="${refCustomer?.clientAddress1}" maxlength="25"/>
                    </td>
                	<td><span class="field_label"> Zip Code <span class="asterisk">*</span></span></td>
                	<td> <input type="text" class="input_field required" name="clientZipCode" id="clientZipCode" value="${refCustomer?.clientZipCode}" maxlength="10"/> </td>
                </tr>
                <tr>
                	<td> &nbsp; </td>
                	<td colspan="3"> <input type="text" class="input_field" name="clientAddress2" id="clientAddress2" value="${refCustomer?.clientAddress2}" maxlength="25"/> </td>
                </tr>
                <tr>
                	<td> &nbsp; </td>
                	<td colspan="3"> <input type="text" class="input_field" name="clientAddress3" id="clientAddress3" value="${refCustomer?.clientAddress3}" maxlength="25"/> </td>
                </tr>
                <tr>
                	<td> &nbsp; </td>
                	<td colspan="3"> <input type="text" class="input_field" name="clientAddress4" id="clientAddress4" value="${refCustomer?.clientAddress4}" maxlength="25"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Mobile Number </span></td>
                	<td> <input type="text" class="input_field" name="mobileNumber" id="mobileNumber" value="${refCustomer?.mobileNumber}" maxlength="15"/> </td>
                	<td><span class="field_label"> Office Phone Number </span></td>
                	<td> <input type="text" class="input_field" name="officePhoneNumber" id="officePhoneNumber" value="${refCustomer?.officePhoneNumber}" maxlength="15"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Nature of Business </span></td>
                	<td colspan="3"> <input type="text" class="input_field" name="natureOfBusiness" id="natureOfBusiness" value="${refCustomer?.natureOfBusiness}" maxlength="50"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Nature of Work </span></td>
                	<td colspan="3"> <input type="text" class="input_field" name="natureOfWork" id="natureOfWork" value="${refCustomer?.natureOfWork}" maxlength="10"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Nature of Self-Employment </span></td>
                	<td colspan="3"> <input type="text" class="input_field" name="natureOfSelfEmployment" id="natureOfSelfEmployment" value="${refCustomer?.natureOfSelfEmployment}" maxlength="10"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Source of Funds </span></td>
                	<td colspan="3"> <input type="text" class="input_field" name="sourceOfFunds" id="sourceOfFunds" value="${refCustomer?.sourceOfFunds}" maxlength="100"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Annual Income </span></td>
                	<td> <input type="text" class="input_field_right numericCurrency" name="annualIncome" id="annualIncome" value="${refCustomer?.annualIncome}" /> </td> <%-- maxlength: 16-digit number & 2 decimal places --%>
                	<td><span class="field_label"> Monthly Income </span></td>
                	<td> <input type="text" class="input_field_right" name="monthlyIncome" id="monthlyIncome" value="${refCustomer?.monthlyIncome}" readOnly="readOnly"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Financial Status (Total Assets) </span></td> <%-- maxlength: 16-digit number & 2 decimal places --%>
                	<td colspan="3"> <input type="text" class="input_field_right numericCurrency" name="financialStatus" id="financialStatus" value="${refCustomer?.financialStatus}" /> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Tax Account Number <span class="asterisk">*</span></span></td>
                	<td colspan="3"> <input type="text" class="input_field required" name="taxAccountNumber" id="taxAccountNumber" value="${refCustomer?.clientTaxAccountNumber}" maxlength="15" /> </td>
                </tr>
                <tr>
                    <td/>
                    <td><span class="field_label"> <i>e.g. 123-456-789-000</i></span></td>
                </tr>
%{--
                <tr>
                	<td><span class="field_label"> Account Type </span></td>
                	<td colspan="3"> <g:select name="accountType" value="${refCustomer?.accountType}" class="select_dropdown accountType" from="${['HEAD OFFICE', 'UNICHEM', 'OTHERS']}" keys="${["1", "2", "9"]}" noSelection="['':'SELECT ONE...']"/> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Account Officer Code </span></td>
                	<td colspan="3"> <input type="text" class="input_field numericWholeQuantity" name="accountOfficerCode" id="accountOfficerCode" value="${refCustomer?.accountOfficerCode}" maxlength="10" /> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Export Amount, Month-to-Date </span></td>
                	<td> <input type="text" class="input_field_right numericCurrency" name="exportAmountMonthToDate" id="exportAmountMonthToDate" value="${refCustomer?.monthToDateExportAmount}" /> </td>
                	<td><span class="field_label"> Export Amount, Year-to-Date </span></td>
                	<td> <input type="text" class="input_field_right numericCurrency" name="exportAmountYearToDate" id="exportAmountYearToDate" value="${refCustomer?.yearToDateExportAmount}" /> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Export Advance Balance </span></td>
                	<td colspan="3"> <input type="text" class="input_field_right numericCurrency" name="exportAdvanceBalance" id="exportAdvanceBalance" value="${refCustomer?.exportAdvanceBalance}" /> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> Red Clause Advance Balance </span></td>
                	<td colspan="3"> <input type="text" class="input_field_right numericCurrency" name="redClauseAdvanceBalance" id="redClauseAdvanceBalance" value="${refCustomer?.redClauseAdvanceBalance}" /> </td>
                </tr>
                <tr>
                	<td><span class="field_label"> EVAT Flag </span></td>
                	<td colspan="3"> 
                		<g:radioGroup name="evatFlag" labels="['Yes', 'No']" values="['Y','N']" value="${refCustomer?.evatFlag}">
							${it.radio} ${it.label} &#160;&#160;
						</g:radioGroup>
                	</td>
                </tr>
--}%
                <%-- <tr>
                	<td><span class="field_label"> Client Number </span></td>
                	<td colspan="3"> <input type="text" class="input_field" name="clientNumber" id="clientNumber" value="${refCustomer?.clientNumber}" /> </td>
                </tr> --%>
                %{--<tr>--}%
                	%{--<td><span class="field_label"> CIF Number </span></td>--}%
                	%{--<td colspan="3"> --}%
                		%{--<input type="text" class="input_field" name="clientCifNumber" id="clientCifNumber" value="" />--}%
                		%{--<a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a> --}%
                	%{--</td>--}%
                %{--</tr>--}%
                <%-- <tr>
                	<td><span class="field_label"> UCPB CIF Number </span></td>
                	<td colspan="3">  
                		<input type="text" class="input_field" name="ucpbCifNumber" id="ucpbCifNumber" value="${refCustomer?.ucpbCifNumber}" />
                		<a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a>
                	</td>
                </tr> --%>
                %{--<tr>--}%
                	%{--<td><span class="field_label"> CIF Long Name </span></td>--}%
                	%{--<td> <input type="text" class="input_field" name="cifLongName" id="cifLongName" value="${refCustomer?.cifLongName}" readonly="readonly" /> </td>--}%
                	%{--<td><span class="field_label"> CIF Short Name </span></td>--}%
                	%{--<td> <input type="text" class="input_field" name="cifShortName" id="cifShortName" value="${refCustomer?.cifShortName}" readonly="readonly" /> </td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                	%{--<td> &nbsp; </td>--}%
                	%{--<td colspan="3"> <input type="text" class="input_field" name="cifLongNameA" id="cifLongNameA" value="${refCustomer?.cifLongNameA}"readonly="readonly" /> </td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                	%{--<td> &nbsp; </td>--}%
                	%{--<td colspan="3"> <input type="text" class="input_field" name="cifLongNameB" id="cifLongNameB" value="${refCustomer?.cifLongNameB}" readonly="readonly" /> </td>--}%
                %{--</tr>--}%
                
                <tr>
                    <td colspan="4">
                        <table class="body_forms_table_btn_admin">


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
                                    <input type="button" class="input_button_negative" value="Cancel" onclick="javascript:window.location='/tfs-web/refCustomerAdmin/index'"/>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <br/>
                                    <g:if test="${params.u != null}">
                                        <input id="btnDeleteForm" type="button" class="input_button_negative" value="Delete"/>
                                    </g:if>

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
<%-- CIF Pop-up --%>
<g:render template="../commons/popups/cif_search_popup"/>

<%--Popup plugin--%>
<g:javascript src="pop_up.js"/>
<g:javascript src="popups/cif_main_search_popup.js" />

<script type="text/javascript">
    if (!window.console) {
        console = {
            log: function(){
                // do nothing
                // this is to avoid errors in ie7
            }
        };
    }

    function addressChange() {
        if ($("#clientAddress1").val() != "" ||
                $("#clientAddress2").val() != "" ||
                $("#clientAddress3").val() != "" ||
                $("#clientAddress4").val() != "") {
            $("#addressComplete").val("true");
        } else {
            $("#addressComplete").val("");
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

    $(document).ready(function() {

        $("#centralBankCode").autoNumeric({aSep: "", mDec: 0, vMax: '9999999999'});
        %{--
    	$("#centralBankCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${refCustomer?.centralBankCode}'});
    	$("#country").setCountryDropdown($(this).attr("id")).select2('data',{id: '${refCustomer?.nationOfBirth ?: '204'}'});
         --}%
        $("#country").setCountryIsoDropdown($(this).attr("id")).select2('data',{id: '${refCustomer?.nationOfBirth ?: 'PH'}'});

        $("#annualIncome").change(function() {
            var annualIncome = parseFloat($("#annualIncome").val().replace(/,/g,""));
            var monthlyIncome = annualIncome / 12;
            $("#monthlyIncome").val(formatCurrency(monthlyIncome));
        });
        var action = "";
        $("#btnSaveForm").click(function(e) {
            action="save";
			showConfirmAlertPopup();
        });

        $("#btnDeleteForm").click(function(e) {
            action="delete";
            showConfirmAlertPopup();
        });


        $("#btnAlertConfirm").click(function(e) {
            //close yes/no alert
        	mDisablePopup($("#popup_save_confirmation"),$("#confirmation_background"));
            if (action == "delete") {
                $("#refCustomerForm").attr("action", '${g.createLink(controller: "refCustomerAdmin", action: "delete")}')
                $("#refCustomerForm").submit()
            }

            if (action == "save") {
                if(validateSubmitForm()){
                    $("#refCustomerForm").attr("action", '${g.createLink(controller: "refCustomerAdmin", action: "save")}')
                    $("#refCustomerForm").submit()
                }
                else{
                    //span element in alert.gsp
                    $("#alertMessage").html("Please fill in the required fields.");
                    showAlertPopup();
                }
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
//			mCenterPopup($("#popup_save_confirmation"),$("#confirmation_background"));
//			mLoadPopup($("#popup_save_confirmation"),$("#confirmation_background"));
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

        $("#clientAddress1, #clientAddress2, #clientAddress3, #clientAddress4").change(addressChange);
        addressChange();
    });

    function resetFields()
    {
        $('#country').select2('data',{id: null});
        $('#monthlyIncome').val("");
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


        });
    }


</script>

</body>
</html>