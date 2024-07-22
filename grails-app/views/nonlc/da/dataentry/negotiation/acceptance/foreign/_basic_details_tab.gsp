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

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>

<g:hiddenField name="processingUnitCode" value="${session.unitcode}"/>

<g:hiddenField name="originalPort_bspCode" value="${originalPort_bspCode}"/>
<g:javascript src="utilities/nonlc/validation_nonlc.js" />
<g:form method="post">
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
		<td class="label_width"><span class="field_label"> TS Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="tsNumber" value="${tradeServiceReferenceNumber ?: tsNumber}"/></td>
		<td class="label_width"><span class="field_label"> Remitting Bank </span></td>
		<td class="input_width"><input class="tags_bank select2_dropdown bigdrop" name="remittingBank" id="remittingBank" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td class="label_width"><span class="field_label"> Remitting Bank (Ref No.) </span></td>
		<td class="input_width"><g:textField class="input_field length20" name="remittingBankReferenceNumber" value="${remittingBankReferenceNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly"  name="documentNumber" value="${documentNumber}" /></td>
		<td class="label_width"><span class="field_label"> Draft Currency </span></td>
		<td class="input_width"><input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Main CIF Number</span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="mainCifNumber" value="${mainCifNumber}" /></td>
		<td class="label_width"><span class="field_label"> Draft Amount </span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Main CIF Name</span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="mainCifName" value="${mainCifName}" /></td>
		<td class="label_width"><span class="field_label"> Date of BL/Airway Bill </span></td>
        %{--<g:if test="${dateOfBlAirwayBill != null && dateOfBlAirwayBill instanceof java.sql.Timestamp}">--}%
		%{--<td class="input_width"><g:textField class="input_field" name="dateOfBlAirwayBill" value="${(dateOfBlAirwayBill != null) ? (DateUtils.shortDateFormat((dateOfBlAirwayBill instanceof java.sql.Timestamp) ? dateOfBlAirwayBill : new Date(dateOfBlAirwayBill))) : ''}" readonly="readonly"/></td>--}%
        %{--</g:if>--}%
        %{--<g:else>--}%
        %{--<td class="input_width"><g:textField class="input_field" name="dateOfBlAirwayBill" value="" readonly="readonly"/></td>--}%
        %{--</g:else>--}%
        <td class="input_width"><g:textField class="input_field" name="dateOfBlAirwayBill" value="${(dateOfBlAirwayBill != null && dateOfBlAirwayBill instanceof java.sql.Timestamp) ?
            DateUtils.shortDateFormat(dateOfBlAirwayBill) :
            (dateOfBlAirwayBill != null && dateOfBlAirwayBill instanceof java.lang.String) ? dateOfBlAirwayBill : ''}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CIF Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="importerCifNumber" value="${importerCifNumber}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label"> Maturity Date <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField class="datepicker_field required" name="maturityDate" value="${maturityDate}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CB Code </span></td>
<%--		<td class="input_width"><g:select noSelection="['':'SELECT ONE...']" class="select_dropdown" name="importerCbCode" value="${importerCbCode}" from=""/></td>--%>
		<td class="input_width"><input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCode" id="importerCbCode" readonly="readonly"/></td>		
		<td class="label_width"><span class="field_label"> Original Port </span></td>
		<td class="input_width"><input class="tags_country select2_dropdown bigdrop" name="originalPort" id="originalPort" readonly="readonly"/></td>
	</tr>
	<tr>
	    <td class="label_width"> <span class="field_label">TIN<span class="asterisk">*</span> </span> </td>
        <td class="input_width"> <g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}" maxlength="20"/> </td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Importer Name </span></td>
<%--		<td class="input_width"><g:textField class="input_field" name="importerName" value="${importerName}" readonly="readonly"/></td>--%>
		<td class="input_width"><g:textArea class="textarea" name="importerName" value="${importerName}" readonly="readonly" rows="2"/></td>
		<td class="label_width valign_top"><span class="field_label"> Beneficiary Name </span></td>
<%--		<td class="input_width"><g:textField class="input_field" name="beneficiaryName" value="${beneficiaryName}" readonly="readonly"/></td>--%>
		<td class="input_width"><g:textArea class="textarea" name="beneficiaryName" value="${beneficiaryName}" readonly="readonly" rows="2" maxlength="50"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Importer Address </span></td>
		<td class="input_width"><g:textArea name="importerAddress" value="${importerAddress}" class="textarea" rows="4" readonly="readonly"/></td>
		<td class="label_width valign_top"><span class="field_label"> Beneficiary Address </span></td>
		<td class="input_width"><g:textArea name="beneficiaryAddress" value="${beneficiaryAddress}" class="textarea" readonly="readonly" rows="4"/></td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label">Importer Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Commodity Code <span class="asterisk">*</span></span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown required" name="commodity" id="commodity" />
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
    </tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Sender to Receiver </span><br /><span class="field_label"> Information</span> </td>
		<td class="input_width">
			<tfs:senderToReceiverType1 name="senderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td class="input_width valign_top">&#160;</td>
		<td class="input_width">
			<g:textArea name="senderToReceiverInformation" value="${senderToReceiverInformation}" class="textarea" rows="6"/>
		</td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:form>
<script>
    $(document).ready(function() {
    	var participantCode = $('#participantCode').val(),
    	    commodityCode = $('#commodityCode').val(),
	        splittedCommodity;

        $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
        $("#remittingBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${remittingBank}'});
        $("#originalPort").setCountryIsoDropdown($(this).attr("id")).select2('data',{id: '${originalPort}'});
        $("#importerCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
	    $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

	    $("#commodity").change(function() {
            splittedCommodity = $(this).val().split("-");
            if(splittedCommodity.length > 0) {
                $('#commodityCode').val(splittedCommodity[0].toString().trim());
            }
        });

	    if(commodityCode) {
	    	$.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
<%--	                $('#commodity').val(data.results[0].id);--%>
	                $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
	            }
	        });
	    }

	    $('#tempTinNumber').change(function() {
	        $('#tinNumber').val($('#tempTinNumber').val().trim());
	    });
    });
</script>