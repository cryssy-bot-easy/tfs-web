<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>

<g:hiddenField name="processingUnitCode" value="${session.unitcode}"/>
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>
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
<%--		<td class="label_width"><span class="field_label"> eTS Number </span></td>--%>
<%--		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="etsNumber" /></td>--%>
		<td class="label_width"><span class="field_label"> TS Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="tsNumber" value="${tradeServiceReferenceNumber ?: tsNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" value="${documentNumber}" name="documentNumber" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Buyer CIF Number <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField class="input_field required" name="importerCifNumber" value="${importerCifNumber}" readonly="readonly"/><a href="#" class="popup_btn_cif_normal search_btn vtop">search button</a></td>
	</tr>
	<%--
	<tr>
		<td class="label_width"><span class="field_label"> Client Code <span class="asterisk">*</span></span></td>
		<td class="input_width"><input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCode" id="importerCbCode" /></td>
	</tr>
	--%>
	<tr>
		<td class="label_width valign_top"><span class="field_label">Buyer Name</span></td>
		<td class="input_width"><g:textArea class="textarea swiftCharset" name="importerName" value="${importerName}" rows="2" maxlength="60"/></td>
		<td class="label_width valign_top"><span class="field_label"> Seller Name <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textArea class="textarea required" name="beneficiaryName" value="${beneficiaryName}" rows="2" maxlength="50"/></td>
		
	</tr>
	<%-- for rowspan --%>
<%--	<tr>--%>
<%--		<td class="td_height1" colspan="3">&#160;</td>--%>
<%--	</tr>--%>
	<tr>
		<td class="label_width valign_top"><span class="field_label">Buyer Address</span></td>
		<td class="input_width">
			<g:textArea class="textarea" name="importerAddress" value="${importerAddress}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a>
		</td>
		<td class="label_width valign_top"><span class="field_label"> Seller Address <span class="asterisk">*</span></span></td>
		<td class="input_width">
			<g:textArea name="beneficiaryAddress" rows="4" value="${beneficiaryAddress}" class="textarea required" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_beneficiary_address">...</a>
		</td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Draft Currency <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:select class="select_dropdown" name="remittingBank" from="${['PHP','USD','EUR']}"/></td>--%>
		<td class="input_width"><input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Draft Amount <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:textField class="input_field" name="amount" /></td>--%>
		<td class="input_width"><g:textField class="input_field_right numericCurrency required" name="amount" value="${amount}" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Delivery Date <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField class="datepicker_field required" name="dateOfBlAirwayBill" value="${dateOfBlAirwayBill}" /></td>
	</tr>
	<%--
	<tr>
		<td class="label_width"><span class="field_label"> With 2% CWT? <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:radioGroup class="required" name="cwtFlag" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}"> ${it.radio} ${it.label} &#160; &#160; </g:radioGroup></td>
	</tr>
	--%>
	<%-- for rowspan --%>
	<tr>
		<td class="td_height2" colspan="3">&#160;</td>
	</tr>
</table>
<br /><br />
<%--    <g:hiddenField name="cifCbComplete" id="cifCbComplete" class="required" value="${cifCbComplete}" />--%>
<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:form>
<script>
    $(document).ready(function() {
<%--        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});--%>
        $("#currency").setDomesticSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});
        $("#importerCbCode").setClientDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});

        /*$("#importerCifNumber").change(function() {
            if ($("#importerCifNumber").val() != "") {
                $("#cifCbComplete").val(true);
            } else {
                $("#cifCbComplete").val("");
            }
        });

        $("#importerCbCode").change(function() {
            if ($("#importerCbCode").val() != "") {
                $("#cifCbComplete").val(true);
            } else {
                $("#cifCbComplete").val("");
            }
        });*/
    });
</script>