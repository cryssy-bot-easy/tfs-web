<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>

<g:hiddenField name="processingUnitCode" value="${session.unitcode}"/>
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
		<td class="label_width"><span class="field_label">BKE?</span></td>
		<td>
			<g:radioGroup name="bkeFlag" id="bkeFlag" labels="['Yes', 'No']" values="['Y','N']"  value="${bkeFlag ?: 'Y'}">
				${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td class="label_width"><span class="field_label"> Remitting Bank </span></td>
<%--		<td class="input_width">--%>
<%--            <g:select noSelection="['':'SELECT ONE...']" class="select_dropdown" name="remittingBank" from="${['ANY BANK IN','ANY BANK','REIMBURSING BANK','ISSUING BANK','ADVISING BANK']}"--%>
<%--                      keys="${['ANY_BANK_IN','ANY_BANK','REIMBURSING_BANK','ISSUING_BANK','ADVISING_BANK']}" value="${remittingBank}"/>--%>
<%--        </td>--%>
		<td class="input_width"><input class="tags_bank select2_dropdown bigdrop" name="remittingBank" id="remittingBank" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly"  name="documentNumber" value="${documentNumber}" /></td>
		<td class="label_width"><span class="field_label"> Remitting Bank<br/>(Ref No.) </span></td>
		<td class="input_width"><g:textField class="input_field length20" name="remittingBankReferenceNumber" value="${remittingBankReferenceNumber}" maxlength="25"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Main CIF Number</span></td>
		<td class="input_width">
			<g:textField class="input_field" readonly="readonly" name="mainCifNumber" value="${mainCifNumber}" />
			<a href="javascript:void(0)" id="main_cif_search" class="search_btn popup_btn_cif_main">Search/Look-up Button</a>
		</td>
		<td class="label_width"><span class="field_label"> Draft Currency <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:select noSelection="['':'SELECT ONE...']" class="select_dropdown" name="currency" value="${currency}" from="${['PHP','USD','EUR']}"/></td>--%>
		<td class="input_width"><input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" /></td>
	<tr>
		<td class="label_width"><span class="field_label"> Main CIF Name</span></td>
		<td class="input_width"><g:textField class="input_field" readonly="readonly" name="mainCifName" value="${mainCifName}" /></td>
		<td class="label_width"><span class="field_label"> Draft Amount <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency required" name="amount" value="${amount}" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CIF Number <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField class="input_field" name="importerCifNumber" value="${importerCifNumber}" readonly="readonly"/><a href="#" class="search_btn popup_btn_cif_normal">search button</a></td>
		<td class="label_width"><span class="field_label"> Date of BL/Airway Bill <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField class="datepicker_field required" name="dateOfBlAirwayBill" value="${dateOfBlAirwayBill}" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CB Code <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:select noSelection="['':'SELECT ONE...']" class="select_dropdown" name="importerCbCode" value="${importerCbCode}" from=""/></td>--%>
		<td class="input_width"><input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCode" id="importerCbCode" /></td>
		<td class="label_width"><span class="field_label"> Maturity Date </span></td>
		<td class="input_width"><g:textField class="datepicker_field" name="maturityDate" value="${maturityDate}" /></td>
	</tr>
	<tr>
	    <td class="label_width"> <span class="field_label">TIN<span class="asterisk">*</span> </span> </td>
        <td class="input_width"> <g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}" maxlength="20"/> </td>
		<td class="label_width"><span class="field_label"> Original Port <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:select class="select_dropdown" name="originalPort" value="${originalPort}" from="${['Option 1','Option 2','Option 3']}"/></td>--%>
		<td class="input_width"><input class="tags_country select2_dropdown bigdrop required" name="originalPort" id="originalPort" />
		<g:hiddenField name="originalPort_bspCode" value="${originalPort_bspCode}"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Importer Name <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:textField class="input_field required" name="importerName" value="${importerName}"/></td>--%>
		<td class="input_width"><g:textArea class="textarea required" name="importerName" value="${importerName}" rows="2" maxlength="60"/></td>
		<td class="label_width valign_top"><span class="field_label"> Beneficiary Name <span class="asterisk">*</span></span></td>
<%--		<td class="input_width"><g:textField class="input_field required" name="beneficiaryName" value="${beneficiaryName}" /></td>--%>
		<td class="input_width"><g:textArea class="textarea required" name="beneficiaryName" value="${beneficiaryName}"  rows="2" maxlength="50"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Importer Address </span></td>
		<td class="input_width">
			<g:textArea name="importerAddress" value="${importerAddress}" class="textarea" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a>
		</td>
		<td class="label_width valign_top"><span class="field_label"> Beneficiary Address <span class="asterisk">*</span></span></td>
		<td class="input_width">
			<g:textArea name="beneficiaryAddress" value="${beneficiaryAddress}" class="textarea required" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_beneficiary_address">...</a>
		</td>
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
		<td class="input_width">&#160;</td>
		<td class="input_width">
			<g:textArea name="senderToReceiverInformation" value="${senderToReceiverInformation}" class="textarea" readonly="readonly" rows="6"/>
			<a href="javascript:void(0)" class="search_btn" id="sender_info">...</a>
		</td>
	</tr>
	<tr>
		

	</tr>
</table>
<br /><br />
    <g:hiddenField name="cifCbComplete" id="cifCbComplete" class="required" value="${cifCbComplete}" />
<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:form>
<script>
    $(document).ready(function() {
    	var participantCode = $('#participantCode').val(),
        cifNumber = $('#cifNumber').val(),
        splittedCommodity;

        %{--$("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});--}%
        $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
        $("#remittingBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${remittingBank}'});
        $("#originalPort").setCountryIsoDropdown($(this).attr("id")).select2('data',{id: '${originalPort}'});
        $("#importerCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
        $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

        $('#cifNumber').change(function() {
            $('#tempTinNumber').val($('#tinNumber').val());

            $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $('#participantCode').val(data.results[0].id);
                }
            });
        });

        $("#commodity").change(function() {
            splittedCommodity = $(this).val().split("-");
            if(splittedCommodity.length > 0) {
                $('#commodityCode').val(splittedCommodity[0].toString().trim());
            }
        });

        $('#tempTinNumber').change(function() {
            $('#tinNumber').val($('#tempTinNumber').val().trim());
        });

		if($("input[type=radio][name=bkeFlag]:checked").val() == "Y") {
			$("#remittingBank").toggleClass("select2_dropdown", true).toggleClass("input_field", false).val("").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${remittingBank}'});
		} else {
			$("#remittingBank").toggleClass("select2_dropdown", false).toggleClass("input_field", true).val('${remittingBank}').select2('destroy');
		}
		$("input[type=radio][name=bkeFlag]").change(function() {
			if($("input[type=radio][name=bkeFlag]:checked").val() == "Y") {
    			$("#remittingBank").toggleClass("select2_dropdown", true).toggleClass("input_field", false).val("").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${remittingBank}'});
    		} else {
    			$("#remittingBank").toggleClass("select2_dropdown", false).toggleClass("input_field", true).val('${remittingBank}').select2('destroy');
    		}
		});  

        $("#importerCifNumber").change(function() {
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
        });
    });
</script>

<g:render template="../commons/popups/cif_search_main"/>
<g:javascript src="popups/cif_main_search_popup.js" />