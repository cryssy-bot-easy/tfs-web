<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _basic_details_tab.gsp


>--%>


<%--
 	(revision)
	[Revised by:] Rafael T. Poblete
	[Date Modified:] March 6, 2018
	Program [Revision] Details: Added CDT Remittance amount correct format and required field.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _basic_details_tab.gsp


>--%>


<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="form" value="basicDetails"/>

<table>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<g:if test="${(!documentfor.equals("reportCDT"))}">
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField class="input_field" name="processingUnitCode" value="${processingUnitCode ?: session.unitcode}" readonly="readonly"/></td>
	</tr>
	</g:if>
    <tr>
        <td><span class="field_label">ADHOC?</span></td>
        <td>
            <g:checkBox name="adhoc" />
        </td>
    </tr>
    <g:if test="${(!documentfor.equals("reportCDT"))}">
	<tr>
		<td><span class="field_label">Type Of Report</span></td>
		<td>
            <tfs:typeOfReport name="reportType" value="${reportType}" class="select_dropdown" />
		</td>
	</tr>
	</g:if>
	<g:else>
	<tr>
		<td><span class="field_label">Type Of Report</span></td>
		<td>
            
            <select name="reportType" class="select_dropdown" id="reportType">
			<option value="">SELECT ONE...</option>
			<option value="FINAL_CDT">CDTOL</option>
			<option value="ADVANCE_CDT">DEPOSITS COLLECTED</option>		
			<option value="ALL">ALL</option>
</select>
		</td>
	</tr>
	</g:else>
	<g:if test="${(!documentfor.equals("reportCDT"))}">
	<tr>
		<td><span class="field_label">Transaction Code</span></td>
		<td><g:textField class="input_field" name="transactionCode" readonly="readonly" value="${transactionCode}"/></td>
	</tr>
	</g:if>
	<tr>
		<td><span class="field_label">Date of Remittance</span></td>
		<td><g:textField class="input_field" name="remittanceDate" value="${remittanceDate}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">PCHC Confirmation Date</span></td>
	</tr>
	<tr>
		<td><span class="float_right">From</span></td>
		<td><g:textField class="input_field" name="collectionPeriodFrom" value="${collectionPeriodFrom}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="float_right">To</span></td>
		<td><g:textField class="input_field" name="collectionPeriodTo" value="${collectionPeriodTo}" readonly="readonly"/></td>
	</tr>
	<g:if test="${(!documentfor.equals("reportCDT"))}">
	<tr>
		<td><span class="field_label">Total Amount for Remittance</span></td>
		<td><g:textField class="input_field_right" name="orgremittanceAmount" readonly="readonly" value="${orgremittanceAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Final Amount for Remittance</span></td>
		<td><g:textField class="input_field_right numericCurrency required" name="remittanceAmount" value="${remittanceAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">BOC Account</span></td>
		<td>
            <g:textField class="input_field" name="bocAccount" value="${bocAccount}" />
        </td>
        %{--<g:if test="${tradeServiceId}">--}%
            <td>
                <span><input type="button" class="check_button" id="accountNameCheckRemittance" /></span>
            </td>
        %{--</g:if>--}%
        <td>

            <input type="button" class="input_button2" value="Debit CASA" id="debitCasa" />
            <input type="button" class="input_button_negative" value="EC" id="errorCorrectCasaRemittance" />
        </td>
	</tr>
    <tr>
        <td>
            <span class="field_label">BOC Account Name</span>
        </td>
        <td>
            <g:textField name="bocAccountName" value="${bocAccountName}" class="input_field required" readonly="readonly" />
        </td>
    </tr>
    </g:if>
    %{--<tr>--}%
        %{--<td><span class="field_label">CASA Status</span></td>--}%
        %{--<td><g:textField class="input_field" name="casaStatus" value="${casaStatus}" readonly="readonly"  /></td>--}%
    %{--</tr>--}%
</table>
<br/>
<br/>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
   <g:if test="${(documentfor.equals("reportCDT"))}">
    <tr>
        <td>
            <input type="button" class="input_button left_indent" onclick="openCdtRemittanceReportAuthorizedSignatoryPopUp()" value="View" />
        </td>
    </tr>
     </g:if>
    <g:if test="${(!documentfor.equals("reportCDT"))}">
    <tr>
        <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
    </g:if>
</table>

<g:javascript src="new/cdt_remittance_override_authorization_utils.js" />
<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'payAuthorizeCdtRemittanceDiv',
                  overrideAuthDivBg: 'payAuthorizeCdtRemittanceBg',
                  overrideAuthUsernameId: 'payAuthorizeUsernameCdtRemittance',
                  overrideAuthPasswordId: 'payAuthorizePasswordCdtRemittance',
                  overrideAuthConfirmId: 'payAuthorizeConfirmCdtRemittance',
                  overrideAuthCancelId: 'payAuthorizeCancelCdtRemittance',
                  overrideAuthCasaPaymentId: 'payAuthorizeCasaIdCdtRemittance'
          ]"/>

<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'unpayAuthorizeCdtRemittanceDiv',
                  overrideAuthDivBg: 'unpayAuthorizeCdtRemittanceBg',
                  overrideAuthUsernameId: 'unpayAuthorizeUsernameCdtRemittance',
                  overrideAuthPasswordId: 'unpayAuthorizePasswordCdtRemittance',
                  overrideAuthConfirmId: 'unpayAuthorizeConfirmCdtRemittance',
                  overrideAuthCancelId: 'unpayAuthorizeCancelCdtRemittance',
                  overrideAuthCasaPaymentId: 'unpayAuthorizeCasaIdCdtRemittance'
          ]"/>

<script type="text/javascript">
    var computeTotalRemittance = '${g.createLink(controller: "cdt", action: "computeTotalRemittance")}';

    function onClickAdhoc() {
        var adhoc = $("#adhoc").attr("checked");

        if (adhoc == "checked" && ${!'PAID'.equals(paymentStatus)}) {
            $("#collectionPeriodFrom, #collectionPeriodTo").datepicker({
                showOn: 'both',
                buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
                changeMonth: true,
                changeYear: true,
                constrainInput:true,
                defaultDate:null,
                dateFormat:'mm/dd/yy'
            });
        } else {
            $("#collectionPeriodFrom, #collectionPeriodTo").datepicker("destroy");
        }
    }

    function getTransactionCode(typeOfReport) {
        if (typeOfReport == "FINAL_CDT") {
            return "073";
        } else if (typeOfReport == "ADVANCE_CDT") {
            return "072";
        } else if (typeOfReport == "IPF") {
            return "074";
        } else if (typeOfReport == "EXPORT") {
            return "078";
        } else {
            return "";
        }
    }

    function validateAccountNumberRemittance(accountNumber) {
        $.post("${g.createLink(controller: 'modeOfPayment', action: 'searchCasaAccountsByUser')}",
                {accountNumber: accountNumber, currency: "PHP"},
                function (data) {

                    if (data["status"] != "error") {
                        if (data['currency'] != "PHP") {
                            triggerAlertMessage('Currency of account did not match Settlement Currency.');

                            $("#bocAccount, #bocAccountName").val("");
                        } else {
                            $("#bocAccountName").val(data['accountName']);
                        }
                    } else {
                        triggerAlertMessage(data["error"]);
                        $("#accountNumber").val("");
                    }
                });
    }

    var debitRemittanceUrl = '${g.createLink(controller: "cdt", action: "debitFromRemittance")}';
    var ecRemittanceUrl = '${g.createLink(controller: "cdt", action: "errorCorrectFromRemittance")}';

    $(document).ready(function() {
        if (${"NO_PAYMENT_REQUIRED".equals(paymentStatus) || "UNPAID".equals(paymentStatus)}) {
            $("#debitCasa").show();
            $("#errorCorrectCasaRemittance").hide();
            $("#bocAccount").removeAttr("readonly");
            $("#remittanceDate").datepicker({
                showOn: 'both',
                buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
                changeMonth: true,
                changeYear: true,
                constrainInput:true,
                defaultDate:null,
                dateFormat:'mm/dd/yy'
            });

            $("#btnPrepare").attr("disabled", "disabled");
        } else if (${"PAID".equals(paymentStatus)}) {
            $("#debitCasa").hide();
            $("#errorCorrectCasaRemittance").show();

            $("#reportType, #adhoc").attr("disabled", "disabled");

            $("#remittanceDate, #collectionPeriodFrom, #collectionPeriodTo").datepicker("destroy");

            $("#btnPrepare").removeAttr("disabled");
            $("#bocAccount").attr("readonly", "readonly");
        } else {
            $("#debitCasa").hide();
            $("#errorCorrectCasaRemittance").hide();
            $("#bocAccount").removeAttr("readonly");
            $("#btnPrepare").attr("disabled", "disabled");

            $("#remittanceDate").datepicker({
                showOn: 'both',
                buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
                changeMonth: true,
                changeYear: true,
                constrainInput:true,
                defaultDate:null,
                dateFormat:'mm/dd/yy'
            });
        }

        $("#bocAccount").on("keydown", function(e) {
            return e.which !== 32;
        });

//        if ($("#tradeServiceId").val() == "") {
//            $("#bocAccount").attr("readonly", "readonly");
//            $("#debitCasa").attr("disabled", "disabled");
//        }

        $("#collectionPeriodFrom, #collectionPeriodTo").change(function() {
            $.get(computeTotalRemittance, {
                reportType: $("#reportType").val(),
                collectionPeriodFrom: $("#collectionPeriodFrom").val(),
                collectionPeriodTo: $("#collectionPeriodTo").val()
            }, function(data) {
                $("#remittanceAmount").val(data.remittanceAmount);
                $("#orgremittanceAmount").val(data.remittanceAmount);
            });
        });

        $("#debitCasa").click(function() {
            if ($("#bocAccountName").val()) {
                var params = {
                    amount: $("#remittanceAmount").val(),
                    currency: "PHP",
                    amountSettlement: $("#remittanceAmount").val()
                }

                $.post(validateCasaTransactionAmountUrl, params, function (validateCasaAmountResponse) {
                    if (validateCasaAmountResponse.success == true) {
                        onPayClickAuthenticateCdtRemittance($("#supervisorId").val());
                    } else {
                        if (validateCasaAmountResponse.requiresValidation == true) {
                            $("#payAuthorizeUsernameCdtRemittance, #payAuthorizePasswordCdtRemittance").val("");

                            mLoadPopup($("#payAuthorizeCdtRemittanceDiv"), $("#payAuthorizeCdtRemittanceBg"));
                            mCenterPopup($("#payAuthorizeCdtRemittanceDiv"), $("#payAuthorizeCdtRemittanceBg"));

                            $("#payAuthorizeCasaIdCdtRemittance").val(id);
                        } else {
                            triggerAlertMessage(validateCasaAmountResponse.errorMessage);
                        }
                    }
                });
            } else {
                triggerAlertMessage("Account Name must not be blank.");
            }
        });

        $("#reportType").change(function() {
            var reportType = $("#reportType").val();
            $("#transactionCode").val(getTransactionCode(reportType));
        })

        $("#remittanceDate, #reportType").change(function() {
            var remittanceDate = $("#remittanceDate").val();
            var reportType = $("#reportType").val();

            if (remittanceDate != "" && reportType != "") {
                $.post('${g.createLink(controller: "cdt", action: "computeCollectionDate")}',
                        {remittanceDate: remittanceDate, reportType: reportType},
                        function(data) {
                            $("#collectionPeriodFrom").val(data.collectionPeriodFrom);
                            $("#collectionPeriodTo").val(data.collectionPeriodTo);
                            $("#remittanceAmount").val(data.remittanceAmount);
                            $("#orgremittanceAmount").val(data.remittanceAmount);
                        });
            } else {
                $("#collectionPeriodFrom, #collectionPeriodTo, #remittanceAmount, #orgremittanceAmount").val("");
            }
        });

        $("#adhoc").click(onClickAdhoc);

        if (${"on".equals(adhoc)}) {
            $("#adhoc").attr("checked", "checked");
        }
        onClickAdhoc();

        $("#saveConfirmBasicDetails").click(function() {
            if(validateExportTab("#basicDetailsTabForm") > 0){
            	triggerAlertMessage(val_msg);
            } else {
                if ($("#remittanceAmount").val() == "0.00") {
                    triggerAlertMessage("Total Amount for Remittance cannot be 0.00");
                } else {
                	mCenterPopup($("#loading_div"), $("#loading_bg"));
                	mLoadPopup($("#loading_div"), $("#loading_bg"));
                    $("#basicDetailsTabForm").submit();
                }
            }
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });

//        if($("#remittanceDate").val() && $("#reportType").val() && $("#casaStatus").val() && $("#remittanceAmount").val() ){
//            $("#btnPrepare").removeAttr("disabled");
//        } else {
//            $("#btnPrepare").attr("disabled", "disabled");
//        }

        $("#accountNameCheckRemittance").click(function() {
            var accountNumber = $("#bocAccount").val();

            validateAccountNumberRemittance(accountNumber);
        });

        $("#errorCorrectCasaRemittance").click(function() {
            if ($("#bocAccountName").val()) {
                $("#unpayAuthorizeUsernameCdtRemittance, #unpayAuthorizePasswordCdtRemittance").val("");
                mLoadPopup($("#unpayAuthorizeCdtRemittanceDiv"), $("#unpayAuthorizeCdtRemittanceBg"));
                mCenterPopup($("#unpayAuthorizeCdtRemittanceDiv"), $("#unpayAuthorizeCdtRemittanceBg"));
            } else {
                triggerAlertMessage("Account Name must not be blank.");
            }
        });
    });
</script>