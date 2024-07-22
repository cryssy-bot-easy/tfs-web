<%-- 
(revision)
SCR/ER Number: 20161121-097
SCR/ER Description: Failed to route because of following reason: TFS Web app allows user to input MORE THAN 50 characters on the screen. However, our database accepts only 50 characters. (Redmine# 5644)
[Revised by:] John Patrick C. Bautista
[Date deployed:] 1/10/2016
Program [Revision] Details: Adjusted the max length of textfields. As for textareas, LCs and Non LCs: Importer/Buyer 4x35, Exporter/Seller 2x35.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>
<%-- 
(revision)
    (revision)
    Reference Number: ITDJCH-2018-03-001
    Reference Description: Add new fields on screen of different modules to comply with the requirements of ITRS.
    [Revised by:] Jaivee Hipolito
    [Revised date:] 03/20/2018
    Program [Revision:] add new Fields TIN, Importer Code, Commodity code and their behavior.
    PROJECT: WEB
    MEMBER TYPE  : WEB
    Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="processingUnitCode" value="${session?.unitcode}"/>


<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
<%--        <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
<g:each in="${urrrates}" var="temp" status="i">
    <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
</g:each>
<table class="tabs_forms_table">
	<tr>
<%--		<td class="label_width"><span class="field_label">eTS Number</span></td>--%>
<%--		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly"/></td>--%>
		<td class="label_width"><span class="field_label"> TS Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="tsNumber" value="${tradeServiceReferenceNumber ?: tsNumber}"/></td>
<%--		<td class="label_width"><span class="field_label">Remitting Bank</span></td>--%>
<%--		<td><g:select name="remittingBank" class="select_dropdown" from="${[]}" noSelection="['':'SELECT ONE...']" disabled="true"/></td>--%>
		<td class="label_width"><span class="field_label"> Remitting Bank </span></td>
		<td class="input_width"><input class="tags_bank select2_dropdown bigdrop" name="remittingBank" id="remittingBank" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
<%--		<td class="label_width"><span class="field_label">Remitting Bank (Ref Number)</span></td>--%>
<%--		<td><g:textField name="remittingBankRefNumber" class="input_field" readonly="readonly"/></td>--%>
		<td class="label_width"><span class="field_label"> Remitting Bank (Ref No.) </span></td>
		<td class="input_width"><g:textField class="input_field length20" name="remittingBankReferenceNumber" value="${remittingBankReferenceNumber}" maxlength="16" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
<%--		<td><g:textField name="documentNumber" class="input_field" readonly="readonly"/></td>--%>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="documentNumber" value="${documentNumber}" /></td>
		<td class="label_width"><span class="field_label">Draft Currency</span></td>
<%--		<td><g:select name="currency" class="select_dropdown" from="${[]}" noSelection="['':'SELECT ONE...']" disabled="true"/></td>--%>
		<td class="input_width"><input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" readonly="readonly"/></td>
	</tr>
	<tr>
<%--		<td><span class="field_label">Main CIF Number</span></td>--%>
<%--		<td><g:textField name="mainCifNumber" class="input_field" readonly="readonly"/></td>--%>
		<td class="label_width"><span class="field_label"> Main CIF Number</span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="mainCifNumber" value="${mainCifNumber}" /></td>
<%--		<td><span class="field_label">Draft Amount</span></td>--%>
<%--		<td><g:textField name="amount" class="input_field" readonly="readonly"/></td>--%>
		<td class="label_width"><span class="field_label"> Draft Amount </span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" readonly="readonly"/></td>
	</tr>
	<tr>
<%--		<td><span class="field_label">Main CIF Name</span></td>--%>
<%--		<td><g:textField name="mainCifName" class="input_field" readonly="readonly"/></td>--%>
		<td class="label_width"><span class="field_label"> Main CIF Name</span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="mainCifName" value="${mainCifName}" /></td>
		<td><span class="field_label">Outstanding Draft Amount</span></td>
		<td><g:textField name="outstandingAmount" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingAmount}" /></td>
	</tr>
	<tr>
		<td class="label_width indent1"><span class="field_label"> Importer CIF Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="importerCifNumber" value="${importerCifNumber}" readonly="readonly"/></td>
		<td><span class="field_label">Maturity Date</span></td>
		<td><g:textField name="maturityDate" class="input_field" readonly="readonly" value="${maturityDate}"/></td>
		
	</tr>
	<tr>
<%--		<td class="single_indent"><span class="field_label">Importer CIF Number</span></td>--%>
<%--		<td><g:textField name="importerCifNumber" class="input_field" readonly="readonly"/><a href="#" class="search_btn popup_btn_cif_normal">search button</a></td>--%>
		<td class="label_width indent1"><span class="field_label"> Importer CB Code </span></td>
		<td class="input_width"><input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCode" id="importerCbCode" readonly="readonly"/></td>
		<td><span class="field_label">Will the <g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">FX</g:if><g:else>DM</g:else> Non-LC documents be transferred to another bank?</span></td>
		
		<td id="letterOfTransferFlag">
			<g:radioGroup name="willTheFxNonLcDocumentsBeTransferredToAnotherBankFlag" id="willTheFxNonLcDocumentsBeTransferredToAnotherBankFlag" labels="['Yes', 'No']" values="['Y','N']" value="${willTheFxNonLcDocumentsBeTransferredToAnotherBankFlag}">
				${it.radio} ${it.label} &#160;&#160;
			</g:radioGroup>
		</td>
	</tr>
	<tr>
<%--		<td class="single_indent"><span class="field_label">Importer CB Code</span></td>--%>
<%--		<td><g:select name="importerCbCode" class="select_dropdown" from="${[]}" noSelection="['':'SELECT ONE...']" disabled="true"/></td>--%>
	</tr>
	<tr>
<%--		<td class="single_indent"><span class="field_label">Importer Name</span></td>--%>
<%--		<td><g:textField name="importerName" class="input_field" readonly="readonly"/></td>--%>
		<td class="label_width indent1"><span class="field_label"> Importer Name </span></td>
		<td class="input_width"><g:textArea class="textarea" name="importerName" value="${importerName}" readonly="readonly" rows="2"/></td>
        <td> <span class="field_label">TIN <span class="asterisk">*</span></span> </td>
        <td><g:textField class="input_field required" name="tinNumber" value="${tinNumber}" maxLength="20"/> </td>
	</tr>
	<tr>
<%--		<td class="single_indent"><span class="field_label">Beneficiary Name</span></td>--%>
<%--		<td><g:textField name="beneficiaryName" class="input_field" readonly="readonly"/></td>--%>
		<td class="label_width indent1"><span class="field_label"> Beneficiary Name </span></td>
		<td class="input_width"><g:textArea class="textarea" name="beneficiaryName" value="${beneficiaryName}" readonly="readonly" rows="2" maxlength="50"/></td>
		<td> <span class="field_label">Importer Code</span></td>
        <td> <g:textField class="input_field" name="participantCode"id="participantCode" value="${participantCode}" data-orig="${participantCode}" maxlength="10"/> </td>
	</tr>
	<tr>
<%--		<td class="single_indent"><span class="field_label">Beneficiary Address</span></td>--%>
<%--		<td><g:textArea name="beneficiaryAddress" class="input_field" rows="3" readonly="readonly"/></td>--%>
		<td class="label_width indent1"><span class="field_label"> Beneficiary Address </span></td>
		<td class="input_width"><g:textArea name="beneficiaryAddress" value="${beneficiaryAddress}" class="textarea" readonly="readonly" rows="4"/></td>
		<td> <span class="field_label"> Commodity Code</span> </td>
		<td>
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="commodity" id="commodity" disabled="disabled"/>
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>
<script>
    $(document).ready(function() {
    	var participantCode = $('#participantCode').val(),
            cifNumber = $('#cifNumber').val(),
            commodityCode = $('#commodityCode').val(),
            splittedCommodity;

        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});
        $("#remittingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${remittingBank}'});
        $("#originalPort").setCountryIsoDropdown($(this).attr("id")).select2('data',{id: '${originalPort}'});
        $("#importerCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
        $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});
	
	    // If participantCode has no value, try to get the corresponding code on cif table based on CIF number
	    if (participantCode === null || participantCode === undefined || participantCode.length === 0) {
	        $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $('#participantCode').val(data.results[0].id);
	            }
	        });
	    }

	    if(commodityCode) {
	        $('#commodityCode').val(commodityCode.toString().trim());
	        $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
	            }
	        });
	    }
    });
</script>