<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/commons/casa_accounts.js" />
<%--
/**
 (revision)
SCR/ER Number:
SCR/ER Description: Set maxlength of field Importer's Email Address field
[Revised by:] Jonh Henry Alabin
[Date deployed:]
Program [Revision] Details: Set maxlength to 200 characters
PROJECT: CORE
MEMBER TYPE  : Grails

*/
 --%>

 <%--
 (revision)
SCR/ER Number:
SCR/ER Description:
[Revised by:] Cedrick Nungay
[Date revised:] 01/08/2018
Program [Revision] Details: Added validation for emails
PROJECT: CORE
MEMBER TYPE  : Grails
 --%>
<form id="basicDetailsTabForm" action="${cdtAction}" method="POST">
    <g:hiddenField name="documentClass" value="CDT" />`
    <g:hiddenField name="cifNumberParam" value="${cifNumber}" />
    <g:hiddenField name="cifNameParam" value="${cifName}" />
    <g:hiddenField name="accountOfficerParam" value="${accountOfficer}" />
    <g:hiddenField name="ccbdBranchUnitCodeParam"
                   value="${ccbdBranchUnitCode}" />


<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label"> Importer TIN </span></td>
        <td>
            <g:textField class="input_field" readonly="readonly" name="tin" value="${tin}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Registration (Importer) Name </span></td>
        <td>
            <g:textField class="input_field" readonly="readonly" name="clientName" value="${clientName}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Registration Date & Time </span></td>
        <td>
            <g:textField class="input_field" readonly="readonly" name="registrationDate" value="${registrationDate}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> AAB Ref Code </span></td>
        <td>
            <g:textField class="input_field" readonly="readonly" name="agentBankCode" value="${agentBankCode}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Customs Client Number </span></td>
        <td>
            <g:textField class="input_field" readonly="readonly" name="ccn" value="${ccn}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Bank Commission </span></td>
        <td>
            <g:textField class="input_field_right numericCurrency" name="defaultBankCharge" value="${defaultBankCharge}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Fee Sharing </span></td>
        <td>
            <g:radioGroup name="feeSharing" labels="['Yes','No']" values="['YES','NO']" value="${feeSharing == false ? "NO" : 'YES'}">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
        </td>
    </tr>
    <tr>
		<td class="label_width"><span class="field_label"> Importer's CASA-Account Number </span></td>
		<td><g:select name="accountNumberCheck" class="select_dropdown" from="['CIF','Others']" keys="['C','O']" optionValue="${accountNumberCheck}"/></td>
    </tr>
    <tr>
		<td/>
		<td><input class="tags_accountNumber select2_dropdown bigdrop" name="casaAccountNumber" id="casaAccountNumber" /></td>
        <td><input type="button" class="check_button" id="accountNameCheck" /></td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label"> If with CASA Number: <br/><span class="">&nbsp;&nbsp;With Auto-Debit / Blanket Authority</span></span></td>
        <td>
            <tfs:autoDebit name="autoDebitAuthority" class="select_dropdown" value="${autoDebitAuthority}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Importer's Contact Person </span></td>
        <td>
            <g:textField class="input_field" name="contactPerson" value="${contactPerson}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Importer's Email Address </span></td>
        <td>
            <g:textField class="input_field_normal_case" name="email" value="${email}" maxlength="200" 
                title="Importer's Email Address"
            />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Importer's Contact Number/s </span></td>
        <td>
            <g:textArea class="textarea" name="phoneNumber" rows="5" cols="40" value="${phoneNumber}"/>
        </td>
    </tr>
   	<tr>
		<td><span class="field_label">RM/BM Email Address</span></td>
		<td><g:textField name="rmbmEmail" class="input_field_normal_case" value="${rmbmEmail}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Branch Email Address</span></td>
		<td><g:textField name="branchEmail" class="input_field_normal_case" value="${branchEmail}"/></td>
	</tr>
</table>
%{--<g:render template="../product/commons/save_buttons" />--}%

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmCdt" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmCdt" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>


%{--<g:render template="../product/commons/popups/confirm_alert" model="[confirmId: 'cdtSave', cancelId: 'cdtCancel', confirmDivId: 'cdtDiv', confirmBgId: 'cdtBg']" />--}%

</form>

<script>
    var searchCasaAccountsUrl2 = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
    searchCasaAccountsUrl2 += "?cifNumber="+$("#cifNumber").val();

    $(document).ready(function() {
        $("#casaAccountNumber").setAccountNumberDropdown3($(this).attr("id")).select2('data',{id: '${casaAccountNumber}'});

        function showAlert(alertMessage){
            $("#alertMessage").html(alertMessage);

            mLoadPopup($("#popup_alert_dv"), $("#popup_alert_bg"));
            mCenterPopup($("#popup_alert_dv"), $("#popup_alert_bg"));

            $("#btnAlertOk").focus();
        }

        function validateEmailField(e) {
            // regex valid mail format
            var mailFormat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
                eSplit = e.val().split(';');

            for (i = 0; i < eSplit.length; i++) {
                if (!eSplit[i].trim().match(mailFormat)) {
                    return false;
                }
            }
            return true;
        }

        function validateEmailFields() {
            var emailFields = [$('#email'), $('#rmbmEmail'), $('#branchEmail')];
                hasInvalid = false, invalidFields = [], message = '';

            for (var i = 0; i < emailFields.length; i++) {
                var e = emailFields[i];
                // retrieve label value of this field and add to invalid fields array
                if (e.val() !== '' && !validateEmailField(e)) {
                    invalidFields.push(e.parent().siblings().children('span').html());
                    hasInvalid = true;
                }
            }

            if (hasInvalid) {
                for (j = 0; j < invalidFields.length; j++) {
                    message = message + ' ' + invalidFields[j] + '<br>'
                }
                message = 'Invalid email format on the following field/s:<br>' + message;
                showAlert(message);
            } else {
                $(".saveAction").show();
                $(".cancelAction").hide();
                $("#basicDetailsTabForm").submit();
            }
        }
        
        $("#saveConfirmCdt").click(function() {
            validateEmailFields();
        });

//        $("#cancelConfirmCdt").click(function() {
//        	$(".saveAction").hide();
//        	$(".cancelAction").show();
//            mCenterPopup($("#cdtDiv"), $("#cdtBg"));
//            mLoadPopup($("#cdtDiv"), $("#cdtBg"));
//        });

        onChangeAccountNumberCheck();
        $("#accountNumberCheck").change(onChangeAccountNumberCheck);
    });

    function onChangeAccountNumberCheck() {
    	if ($("#accountNumberCheck").val() == 'O') {
            $("#casaAccountNumber").toggleClass("select2_dropdown", false).toggleClass("input_field", true).val("").select2('destroy');
            $("#accountNameCheck").show();
        } else {
            $("#casaAccountNumber").toggleClass("select2_dropdown", true).toggleClass("input_field", false).val("").setAccountNumberDropdown3($(this).attr("id")).select2('data',{id: '${casaAccountNumber}'});
            $("#accountNameCheck").hide();
        }
	}
</script>