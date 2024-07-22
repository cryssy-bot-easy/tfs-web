<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="loanSetup" />

<%--<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Facility type </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="facilityType" readonly="readonly" value="${facilityType ?: 'EB'}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Facility ID </span> </td>
		<td class="input_width"> <g:textField class="input_field input_eleven" name="facilityId" readonly="readonly" value="${facilityId}"/>
            <g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
			<a href="javascript:void(0)" class="search_btn popup_btn_facility"  id="facility_lookup"> Search/Look-up Button </a> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Booking Currency </span> </td>
		<td class="input_width">
            %{--<g:select class="select_dropdown" name="bookingCurrency" from="['PHP','USD','EUR']" noSelection="['':'Select One...']"/> --}%
            %{--<input class="tags_currency select2_dropdown bigdrop" name="bookingCurrency" id="bookingCurrency" />--}%
            <g:textField class="input_field" name="bookingCurrency" readonly="readonly" value="${bookingCurrency ?: 'USD'}"/>
        </td>
	</tr>
	%{--<tr>--}%
		%{--<td class="label_width"> <span class="field_label"> Loan Amount </span> </td>--}%
		%{--<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="loanAmount" value="${loanAmount ?: amount}"/> </td>--}%
	%{--</tr>--}%
	<tr>
		<td class="label_width"> <span class="field_label"> Interest Rate (in %)<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="interestRate" value="${interestRate}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Interest Term Code </span> </td>
		<td class="input_width">
			<g:radioGroup name="interestTermCode" values="['D', 'M']" labels="['D', 'M']" value="${interestTermCode ?: 'D'}" disabled="true">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		 </td>
		<td class="label_width"> <span class="field_label"> Interest Term<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="interestTerm" value="${interestTerm ?: 30}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Repricing Term Code </span> </td>
		<td class="input_width">
			<g:radioGroup name="repricingTermCode" values="['D', 'M']" labels="['D', 'M']" value="${repricingTermCode ?: 'D'}" disabled="true">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		 </td>
		<td class="label_width"> <span class="field_label"> Repricing Term </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="repricingTerm" value="${repricingTerm ?: 30}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Loan Term Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:radioGroup name="loanTermCode" values="['D', 'M']" labels="['D', 'M']" value="${loanTermCode ?: 'D'}" disabled="true">
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
			<g:hiddenField name="loanTermCodeCheck" class="required" value="${loanTermCodeCheck}" />
		 </td>
		<td class="label_width"> <span class="field_label"> Loan Term<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="loanTerm" value="${loanTerm ?: 30}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Loan Maturity Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="loanMaturityDate" value="${loanMaturityDate}" readonly="readonly"/> </td>
		<td class="label_width"> <span class="field_label"> Number of Free Float Days? </span> </td>
		<td class="input_width"> <g:textField class="input_field numericQuantity" name="numberOfFreeFloatDays" value="${numberOfFreeFloatDays ?: 0}"/> </td>
	</tr>
</table>

--%>
<g:each in="${paymentsMade}">
    <g:if test="${(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("DBP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("EBP"))}">

        <g:hiddenField name="withCramApproval" value="${withCramApproval ?: (it.WITHCRAMAPPROVAL == 1) ? true : false}" />

    <table class="tabs_forms_table">
        <tr>
            <td class="label_width"><span class="field_label">Type of Loan</span></td>
            <td class="input_width">
                <g:textField  name="typeOfLoan" class="input_field" readonly="readonly" value="${it.PAYMENTINSTRUMENTTYPE?.contains("LOAN") ? it.PAYMENTINSTRUMENTTYPE : it.PAYMENTINSTRUMENTTYPE + " LOAN"}"/>
            </td>
            <td class="label_width"><span class="field_label">Booking Currency </span></td>
            <td class="input_width">
                <g:textField  name="bookingCurrencyField" class="input_field" readonly="readonly" value="${it.BOOKINGCURRENCY}"/>
            </td>
        </tr>
        <tr>
            <td><span class="field_label"> Interest Rate (in %) </span></td>
            <td class="input_width"><g:textField name="interestRate" class="input_field" readonly="readonly" value="${it.INTERESTRATE}"/></td>
            <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
                <td class="label_width"> <span class="field_label"> Facility ID</span> </td>
                <td> <g:textField class="input_field" name="facilityId" readonly="readonly" value="${it.FACILITYID}"/></td>
            </g:if>
        </tr>
        <tr>
            <td><span class="field_label"> Interest Term </span></td>
            <td>
                <g:textField name="interestTerm" class="input_field" readonly="readonly" value="${it.INTERESTTERM}"/>
            </td>
            <td><span class="field_label"> Interest Code </span></td>
            <td><g:textField name="interestTermCode" class="input_field" readonly="readonly" value="${it.INTERESTTERMCODE}"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> Loan Term </span></td>
            <td>
                <g:textField name="loanTerm" class="input_field" value="${it.LOANTERM}" readonly="readonly"/>
            </td>
            <td><span class="field_label"> Loan Code </span></td>
            <td><g:textField name="loanTermCode" class="input_field" readonly="readonly" value="${it.LOANTERMCODE}"/></td>
        </tr>
        <tr>
            <td><span class="field_label"> Loan Maturity Date </span></td>
            <td><g:textField name="loanDetailsMaturityDate" class="input_field" value="${it.LOANMATURITYDATE}" readonly="readonly"/></td>
            <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
                <td><span class="field_label">PN Number</span></td>
                <td><g:textField name="pnNumber" class="input_field" readonly="readonly" value="${it.PNNUMBER}"/></td>
            </g:if>
        </tr>
        <tr>
            <td><span class="field_label">Payment Code</span></td>
            <td><g:textField name="paymentCode" class="input_field" readonly="readonly" value="${it.PAYMENTCODE}" /></td>
            <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
                <td><span class="field_label">Agri - Agra BSP Tagging</span></td>
                <td>
                    <g:textField name="agriAgraTagging" class="input_field" value="${it.AGRIAGRATAGGING}" readonly="readonly"/>
                </td>
            </g:if>
        </tr>
        <g:if test="${documentClass == 'BP'}">
	    <tr>
	    	<td><span class="field_label">Number of Free Float Days? </span></td>
	    	<td><g:textField class="input_field" name="numberOfFreeFloatDays" value="${it.NUMBEROFFREEFLOATDAYS}" readonly="readonly" /></td>
		</tr>
		</g:if>
    </table>
    <br />
    </g:if>
</g:each>

<%--<table class="buttons_for_grid_wrapper saveButtonsContainer">--%>
<%--    <tr>--%>
<%--        <td><input type="button" id="saveConfirmLoanSetup" class="input_button" value="Save" /></td>--%>
<%--    </tr>--%>
<%--    <tr>--%>
<%--        <td><input type="button" id="cancelConfirmLoanSetup" class="input_button_negative" value="Cancel" /></td>--%>
<%--    </tr>--%>
<%--</table>--%>

<script>
    var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';
    
    function checkLoanTermCode(){
        if($("input[name=loanTermCode]:checked").length > 0){
            $("#loanTermCodeCheck").val("true");
        } else {
        	$("#loanTermCodeCheck").val("");
        }
    }
    
    $(document).ready(function() {
        %{--$("#bookingCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});--}%
        %{--$("#bookingCurrency").select2("disable");--}%

        $("#saveConfirmLoanSetup").click(function() {
        	if(validateExportTab("#loanSetupTabForm") > 0){
        		$("#alertMessage").text("Please fill in all the required fields.");
        		triggerAlert();
        	} else {
        		$(".saveAction").show();
            	$(".cancelAction").hide();
	            $("#loanSetupTabForm").submit();
        	}
        });

        $("#cancelConfirmLoanSetup").click(function() {
        	$(".saveAction").hide();
        	$(".cancelAction").show();
            mCenterPopup($("#loanSetupDiv"), $("#loanSetupBg"));
            mLoadPopup($("#loanSetupDiv"), $("#loanSetupBg"));
        });

        $("input[name=loanTermCode]").click(checkLoanTermCode);
        checkLoanTermCode();
    });
</script>
<g:render template="../commons/popups/facility_id_popup" />