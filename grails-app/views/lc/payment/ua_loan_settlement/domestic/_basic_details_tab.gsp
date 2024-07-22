<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="branchUnitcode" value="${branchUnitcode}" />
<%@page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="valueDate" value="${valueDate}" />
<g:hiddenField name="reimbursingBank" value="${reimbursingBank}"/>
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" value="${etsNumber}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" class="input_field" value="${etsDate}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field input_twenty" value="${documentNumber}" readonly="readonly"/></td>
		<td><span class="field_label">Negotiation Number</span></td>
		<td><g:textField name="negotiationNumber" class="input_field" value="${negotiationNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Issue Date</span></td>
		<td><g:textField name="issueDate" value="${issueDate}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC-DUA Loan Currency</span></td>
		<td>
            %{--<g:textField name="uaLoanCurrency" class="input_field currency" value="${uaLoanCurrency}" readonly="readonly"/>--}%
            <g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/>
        </td>
		<td><span class="field_label">DMLC-DUA Loan Amount</span></td>
		<td>
            %{--<g:textField name="uaLoanAmount" class="input_field right lc_amount numericCurrency" value="${uaLoanAmount}" readonly="readonly"/>--}%
            <g:textField name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${amount}"/>
        </td>
	</tr>
	<%--
	<tr>
		<td><span class="field_label">O/S MD Balance</span></td>
		<td><g:textField name="outstandingMdBalance" class="input_field " value="${outstandingMdBalance}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td><span class="field_label">Negotiation Facility Type/ID</span></td>
		<td colspan="2">
			<g:select from="${['Option 1','Option 2','Option 3'] }" name="negotiationFaciltyType" value="${negotiationFaciltyType}" class="select_dropdown_medium" noSelection="[null:'Select...']"/>
			<g:textField name="negotiationFaciltyId" class="input_field_medium numberFormat-11"/>
			<a href="javascript:void(0)" class="search_btn popup_btn_facility"> Search/Look-up Button </a>
		</td>		
	</tr>
	--%>
</table>
<%--<table style="margin-left:50px">--%>
<%--	<tr>--%>
<%--		<td>Booking Currency</td>--%>
<%--		<td>--%>
<%--			 <g:select name="bookingCurrency" value="${bookingCurrency}" from="${['PHP','USD']}" class="select_dropdown_medium" noSelection="[null:'Select...']"/> --%>
<%--		--%>
<%--			 Auto Complete --%>
<%--			<input class="tags_currency select2_dropdown bigdrop" name="bookingCurrency" id="bookingCurrency" />	--%>
<%--		</td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td width="110px">Interest Rate</td>--%>
<%--		<td width="110px"><g:textField name="interestRate" value="${interestRate}" class="input_field_medium " readonly="readonly"/></td>--%>
<%--		<td width="110px">Interest Term</td>--%>
<%--		<td width="110px"><g:textField name="interestTerm" value="${interestTerm}" class="input_field_medium " readonly="readonly"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td>Repricing Term</td>--%>
<%--		<td><g:textField name="repricingTerm" value="${repricingTerm}" class="input_field_medium " readonly="readonly"/></td>--%>
<%--		<td>Repricing Term<br/>Code</td>--%>
<%--		<td><g:textField name="repricingTermCode" value="${repricingTermCode}" class="input_field_medium " readonly="readonly"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td>Loan Term</td>--%>
<%--		<td><g:textField name="loanTerm" value="${loanTerm}" class="input_field_medium " readonly="readonly"/></td>--%>
<%--		<td>Loan Maturity Date&#160; </td>--%>
<%--		<td><g:textField name="loanMaturityDate" value="${loanMaturityDate}" class="input_field_medium" readonly="readonly"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td>Doc Stamp Tagging</td>--%>
<%--		<td><g:textField name="docStampTagging" value="${docStampTagging}" class="input_field_medium " readonly="readonly"/></td>--%>
<%--	</tr>--%>
<%--</table>--%>
<%--<table class="tabs_forms_table">--%>
<%--	<tr>--%>
<%--		<td class="label_width">Payment Code</td>--%>
<%--		<td class="input_width"><g:select from="${['0','1','2','3','4','5','6'] }" name="paymentCode" value="${paymentCode}" class="select_dropdown " noSelection="[null:'SELECT ONE']"/></td>--%>
<%--		<td class="label_width">Agri-Agra BSP Tagging</td>--%>
<%--		<td class="input_width"><g:select from="${['Regular']}" name="agriAgraBspTagging" value="${agriAgraBspTagging}" class="select_dropdown " noSelection="[null:'SELECT ONE']"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td>PN Number</td>--%>
<%--		<td><g:textField name="pnNumber" value="${pnNumber}" class="input_field " readonly="readonly"/></td>--%>
<%--		<td></td>--%>
<%--		<td><input type="hidden" name="officer" value="${officer}"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td>Transaction Posting Status</td>--%>
<%--		<td><g:textField name="transactionPostingStatus" value="${transactionPostingStatus}" class="input_field " readonly="readonly"/></td>--%>
<%--	</tr>--%>
<%--</table>--%>
<%--<br/>--%>
<%--<g:render template="/layouts/buttons_for_grid_wrapper" />--%>
%{--<g:render template="../commons/popups/facility_id_popup" />--}%
<g:javascript src="popups/dialog_facility_id.js" />

<script>
    $(document).ready(function() {
        %{--$("#bookingCurrency").select2('data',{id: '${bookingCurrency}'});--}%
        $("#bookingCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${bookingCurrency}'});
    });
</script>