<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _pddts_tab.gsp
--%>

<g:javascript src="utilities/commons/casa_accounts.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="pddts" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<%--<g:hiddenField name="documentNumber" value="${documentNumber}"/>--%>


<table class="tabs_forms_table">
    <tr>
        <td><span class="field_label"> Funding Reference Number <span class="asterisk"> * </span> </span></td>
        <td><g:textField class="input_field" name="fundingReferenceNumber" value="${fundingReferenceNumber}" data-orig="${fundingReferenceNumber}" /></td>
    </tr>
	<tr>	
		<td><span class="field_label"> SWIFT <span class="asterisk"> * </span> </span></td>
		<td><g:textField class="select2_dropdown bigdrop required bankDd" name="swift" value="${swift}" data-orig="${swift}" /></td>
	</tr>
    <tr>
        <td><span class="field_label"> Bank <span class="asterisk"> * </span> </span></td>
        <td><g:textField class="input_field" name="bank" value="${bank}" data-orig="${bank}" /></td>
    </tr>
	<tr>		
		<td><span class="field_label"> Beneficiary <span class="asterisk"> * </span> </span></td>
		<td><g:textField class="input_field required" name="beneficiary" value="${beneficiary ?: sellerName}" data-orig="${beneficiary ?: sellerName}" maxlength="60"/></td>
	</tr>
    <tr>	
		<td><span class="field_label"> Account Number </span></td>
		<td>
            <g:textField class="input_field" maxlength="12" name="pddtsAccountNumber" value="${pddtsAccountNumber}" data-orig="${pddtsAccountNumber}" style="float: left;"/>
        </td>
    </tr>
    <tr>
        <td><span class="field_label"> Document Number </span></td>
        <td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" data-orig="${documentNumber}" readonly="readonly" /></td>
    </tr>
	<tr>		
		<td><span class="field_label"> By Order (BYO) </span></td>
		<td><g:textField class="input_field" name="byOrder" value="${byOrder ?: sellerName}" data-orig="${byOrder ?: sellerName}" readonly="readonly" /></td>
	</tr>
	<tr>	
		<td><span class="field_label"> Account Number (UCPB) </span></td>
		<td>
            <g:textField class="input_field" maxlength="12" name="ucpbAccountNumber" value="${ucpbAccountNumber}" data-orig="${ucpbAccountNumber}" style="float: left;"/>
            <input type="button" class="check_button" id="ucpbAccountNumberCheck" style="float: left;"/>
        </td>
    </tr>
    <tr>	
		<td><span class="field_label"> Amount </span></td>
		<td><g:textField class="input_field numericCurrency" name="pddtsAmount" value="${pddtsAmount}" data-orig="${pddtsAmount}" readonly="readonly" /></td>
	</tr>
    <tr>
        <td><span class="field_label"> Remittance Fee </span></td>
        <td>
            <g:textField name="remittanceFeeCurrency2" value="USD" class="input_field_short" readonly="readonly" />
            <%--<span class="charges_currency" id="remittanceFeeCurrency"></span>--%>
            <%--<g:textField class="input_field numericCurrency" name="remittanceFee2" value="${remittanceFee2}" readonly="readonly" />--%>
            <g:textField class="input_field numericCurrency" name="remittanceFee2" value="${remittanceFee2}" data-orig="${remittanceFee2}" />
        </td>
    </tr>
	<tr>
		<td><span class="field_label"> Total Amount </span></td>
		<td>
            <g:textField name="totalAmountCurrency" class="input_field_short" value="USD" readonly="readonly"/>
            <g:textField class="input_field numericCurrency" name="totalAmount" value="${totalAmount}" data-orig="${totalAmount}" readonly="readonly" />
        </td>
	</tr>
</table>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="saveConfirmPddts" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="cancelConfirmPddts" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>
    var searchCasaAccountsUrl2 = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
    searchCasaAccountsUrl2 += "?cifNumber="+$("#cifNumber").val() + "&currency="+$("#currency").val();

    $(document).ready(function () {
        $("#swift").setBankDropdown($(this).attr("id")).select2('data',{id: '${swift}'});
        $("#swift").change(function(){
            if($(this).select2('data').label){
                $("#bank").val($(this).select2('data').label)
            }
        })
        
        $("#ucpbAccountNumberCheck").click(function(){
        	$.post(casaUserSearchUrl, {accountNumber : $("#ucpbAccountNumber").val(), currency : "${currency}"}, function(data){
				if (data['success'] != true) {
					triggerAlertMessage('Account does not exist.');
				} else {
					triggerAlertMessage('Account exists.');
				}
        	});
        });

        if ($("#saveConfirmPddts").length > 0) {
            $("#saveConfirmPddts").click(function() {
            	if(validateExportTab("#pddtsTabForm") > 0){
                    $("#alertMessage").text("Please fill in all the required fields.");
                    triggerAlert();
                } else {
                	$("#pddtsTabForm").submit();
                }
            })
        }

        if ($("#cancelConfirmPddts").length > 0) {
            $("#cancelConfirmPddts").click(function() {
                mDisablePopup($("#pddtsDiv"), $("#pddtsBg"));
            })
        }
    });
</script>