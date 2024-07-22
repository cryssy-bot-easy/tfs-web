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
        <td><g:textField class="input_field" name="fundingReferenceNumber" value="${fundingReferenceNumber}" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> SWIFT <span class="asterisk"> * </span> </span></td>
        <td><g:textField class="input_field" name="swift" value="${swift}" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> Bank <span class="asterisk"> * </span> </span></td>
        <td><g:textField class="input_field" name="bank" value="${bank}" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> Beneficiary <span class="asterisk"> * </span> </span></td>
        <td><g:textField class="input_field" name="beneficiary" value="${beneficiary}" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> Account Number </span></td>
        <td>
            %{--<g:textField class="input_field" name="accountNumber" value="${accountNumber}" />--}%
            <input class="tags_accountNumber select2_dropdown bigdrop" name="pddtsAccountNumber" id="pddtsAccountNumber" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label"> Document Number </span></td>
        <td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> By Order (BYO) </span></td>
        <td><g:textField class="input_field" name="byOrder" value="${byOrder}" readonly="readonly" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> Amount </span></td>
        <td><g:textField class="input_field numericCurrency" name="pddtsAmount" value="" readonly="readonly" /></td>
    </tr>
    <g:if test="${!documentClass?.equals("DP")}">
        <tr>
            <td><span class="field_label"> Remittance Fee </span></td>
            <td>
                <g:textField name="remittanceFeeCurrency2" value="${remittanceFeeCurrency}" class="input_field_short" />
                <%--<span class="charges_currency" id="remittanceFeeCurrency"></span>--%>
                <g:textField class="input_field numericCurrency" name="remittanceFee2" value="" readonly="readonly" />
            </td>
        </tr>
    </g:if>
    <tr>
        <td><span class="field_label"> Total Amount </span></td>
        <td>
            <g:textField name="totalAmountCurrency" class="input_field_short" value="${totalAmountCurrency ?: currency ?: negotiationCurrency}" readonly="readonly"/>
            <g:textField class="input_field numericCurrency" name="totalAmount" value="" readonly="readonly" />
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
        $("#pddtsAccountNumber").setAccountNumberDropdown2($(this).attr("id")).select2('data',{id: '${pddtsAccountNumber}'});

        if ($("#saveConfirmPddts").length > 0) {
            $("#saveConfirmPddts").click(function() {
            	$(".saveAction").show();
            	$(".cancelAction").hide();
                $("#pddtsTabForm").submit();
            })
        }

        if ($("#cancelConfirmPddts").length > 0) {
            $("#cancelConfirmPddts").click(function() {
                mDisablePopup($("#pddtsDiv"), $("#pddtsBg"));
            })
        }
    });
</script>