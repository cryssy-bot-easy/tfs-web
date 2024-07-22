<g:javascript src="utilities/commons/casa_accounts.js" />
<g:javascript src="utilities/validation/validate_pddts.js" />

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
		<td><g:textField class="input_field required" name="fundingReferenceNumber" value="${fundingReferenceNumber}" /></td>
	</tr>
	<tr>	
		<td><span class="field_label"> SWIFT <span class="asterisk"> * </span> </span></td>
		<td><g:textField class="select2_dropdown bigdrop required" name="swift" value="${swift}" /></td>
	</tr>
	<tr>		
		<td><span class="field_label"> Bank <span class="asterisk"> * </span> </span></td>
		<td><g:textField class="input_field required" name="bank" value="${bank}" /></td>
	</tr>
	<tr>		
		<td><span class="field_label"> Beneficiary <span class="asterisk"> * </span> </span></td>
		<td><g:textField class="input_field required" name="beneficiary" value="${beneficiary ?: beneficiaryName ?: documentClass == 'DP' ? sellerName : ''}" maxlength="60"/></td>
	</tr>
	<tr>	
		<td><span class="field_label"> Account Number </span></td>
		<td>
            <g:textField class="input_field" maxlength="12" name="pddtsAccountNumber" value="${pddtsAccountNumber}" style="float: left;"/>
<%--            <input class="tags_accountNumber select2_dropdown bigdrop" name="pddtsAccountNumber" id="pddtsAccountNumber" />--%>
<%--			<input type="button" class="check_button" id="pddtsAccountNumberCheck" style="float: left;"/>--%>
        </td>
	</tr>
	<tr>		
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly" /></td>
	</tr>
	<tr>		
		<td><span class="field_label"> By Order (BYO) </span></td>
		<td><g:textField class="input_field" name="byOrder" value="${byOrder ?: applicantName ?: importerName}" readonly="readonly" maxlength="60"/></td>
	</tr>
	<tr>	
		<td><span class="field_label"> Amount </span></td>
		<td><g:textField class="input_field numericCurrency" name="pddtsAmount" value="${pddtsAmount}" readonly="readonly" /></td>
	</tr>
    <tr>
        <td><span class="field_label"> Remittance Fee </span></td>
        <td>
            <g:textField name="remittanceFeeCurrency2" value="USD" class="input_field_short" readonly="readonly" />
            <%--<span class="charges_currency" id="remittanceFeeCurrency"></span>--%>
            <g:textField class="input_field numericCurrency" name="remittanceFee2" value="${remittanceFee2}" readonly="readonly" />
        </td>
    </tr>
	<tr>
		<td><span class="field_label"> Total Amount </span></td>
		<td>
            <g:textField name="totalAmountCurrency" class="input_field_short" value="USD" readonly="readonly"/>
            <g:textField class="input_field numericCurrency" name="totalAmount" value="${totalAmount}" readonly="readonly" />
        </td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<script>
    var searchCasaAccountsUrl2 = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
    searchCasaAccountsUrl2 += "?cifNumber="+$("#cifNumber").val() + "&currency="+$("#currency").val();
    var casaUserSearchUrl = "${g.createLink(controller: 'modeOfPayment', action: 'searchCasaAccountsByUser')}";

    $(document).ready(function () {
<%--        $("#pddtsAccountNumber").setAccountNumberDropdown2($(this).attr("id")).select2('data',{id: '${pddtsAccountNumber}'});--%>
<%--		$("#pddtsAccountNumberCheck").click(function(){--%>
<%--			var errorCheck = true;--%>
<%--			$.post(casaUserSearchUrl, {accountNumber : $("#pddtsAccountNumber").val(), currency : "${currency}"}, function(data){--%>
<%--				if (data['success'] != true) {--%>
<%--					triggerAlertMessage('Account does not exist.');--%>
<%--				} else {--%>
<%--					triggerAlertMessage('Account exists.');--%>
<%--				}--%>
<%--				errorCheck = false;--%>
<%--			});--%>
<%--			setTimeout(function() { --%>
<%--				if (errorCheck) {--%>
<%--					triggerAlertMessage('Account is invalid.');--%>
<%--				}--%>
<%--			}, 3500);--%>
<%--		});--%>
        $("#swift").setBankDropdown($(this).attr("id")).select2('data',{id: '${swift}'});
        $("#swift").change(function(){
            if($(this).select2('data').label){
                $("#bank").val($(this).select2('data').label)
            }
        })
    });
</script>