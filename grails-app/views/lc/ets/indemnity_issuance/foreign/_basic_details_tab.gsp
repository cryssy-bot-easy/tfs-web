<g:javascript src="utilities/ets/commons/indemnity_issuance_utility.js" />
<g:javascript src="popups/indemnity_issuance_utility_popup.js"/>
<g:javascript src="js-temp/validation_indemnity_issuance.js"/>

<%@ page import="net.ipc.utils.DateUtils" %>
<%@ page import="net.ipc.utils.NumberUtils" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />

<g:hiddenField name="productAmount" value="${productAmount}" />

<div id="fxlc_indemnity_issuance_filter">
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
    <g:each in="${exchange}" var="temp" status="i">
        <br/>
        <g:if test="${temp.rate_description.contains('BOOKING')}">
            <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>
        </g:if>
        <g:else>
            <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
        </g:else>
    </g:each>


	<table class="tabs_forms_table">
        <g:if test="${reversalEtsNumber}">
            <tr>
                <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
                <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
            </tr>
        </g:if>
		<tr>
			<td class="label_width"><span class="field_label"> eTS Date </span></td>
			<td class="input_width"><g:textField class="input_field " readonly="readonly" name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
			<td class="label_width"><span class="field_label"> Processing Unit Code </span></td>
			<td><g:textField class="input_field length3" name="processingUnitCode" readonly="readonly" value="${processingUnitCode}" /></td>
		</tr>
		<tr>
			<td><span class="field_label"> eTS Number </span></td>
			<td><g:textField class="input_field length20" readonly="readonly" name="etsNumber" value="${serviceInstructionId}"/></td>
			<td><span class="field_label"> Document Number </span></td>
			<td>
                <g:textField class="input_field length20" readonly="readonly"  name="referenceNumber" value="${referenceNumber}" />
                %{--<g:textField class="input_field length20" readonly="readonly"  name="documentNumber" value="${documentNumber}" />--}%
            </td>
		</tr>
		<tr>
			<td><span class="field_label">Indemnity Type</span></td>
			<td>
			  <%-- <g:select name='indemnityType' value="${indemnityType}" class="select_dropdown" from="${['BANK GUARANTEE','BANK ENDORSEMENT']}" keys="${['BANK_GUARANTEE','BANK_ENDORSEMENT']}" noSelection="['':'SELECT ONE...']" /> --%>
			  <span class="input_span" id="indemnityTypeSpan">${indemnityType?.equalsIgnoreCase("BG") ? "BANK GUARANTEE" : indemnityType?.equalsIgnoreCase("BE") ? "BANK ENDORSEMENT" : ""}</span>
                          <g:hiddenField name="indemnityType" class="input_field" value="${indemnityType}" />

			</td>
            <td>
                <span class="field_label">BG/BE Number</span>
            </td>
            <td>
                <g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/>
            </td>
		</tr>
		<tr>
			<td><span class="field_label"> Original LC Amount </span></td>
			<td><g:textField class="input_field amountFormat numericCurrency" readonly="readonly" name="originalAmount" value="${originalAmount}"/></td>
			<td><span class="field_label"> Outstanding LC Amount </span></td>
			<td><g:textField class="input_field amountFormat numericCurrency" readonly="readonly" name="outstandingBalance" value="${outstandingBalance}" /></td>

		</tr>
		<tr>
			<td><span class="field_label"> Main CIF Number </span></td>
			<td><g:textField class="input_field length7" readonly="readonly" name="mainCifNumber"  value="${mainCifNumber}"/></td>
			<td><span class="field_label"> Main CIF Name </span></td>
			<td><g:textField class="input_field length20" readonly="readonly" name="mainCifName" value="${mainCifName}" /></td>
		</tr>
		<tr>
			<td><span class="field_label"> Transport Medium <span class="asterisk">*</span></span></td>
			<td>
			  <%-- <g:select class="select_dropdown -required" name="transportMedium" from="${['BY SEA','BY AIR']}" keys="${['BY_SEA','BY_AIR']}" noSelection="${['':'SELECT ONE...']}" value="${transportMedium}" /> --%>
			  <g:select class="select_dropdown required" name="transportMedium" from="${['BY SEA','BY AIR']}" keys="${['SEA','AIR']}" noSelection="${['':'SELECT ONE...']}" value="${transportMedium}" />
			</td>
			<td><span class="field_label"> Shipment Amount <span class="asterisk">*</span></span></td>
			<td>
			  <%-- <g:textField class="input_field numberFormat-15-2 -required" name="shipmentAmount" value="${shipmentAmount}" /> --%>
			  <g:textField class="input_field_right amountFormat numericCurrency required" name="shipmentAmount" value="${shipmentAmount}" />
			</td>
		</tr>
		<tr>
				<td class="indent1"><span class="field_label"> Type of BL presented </span></td>
				<td>
				<%-- <g:select class="select_dropdown" name="typeOfBlPresented" from="${['ORIGINAL','COPY']}" keys="${['ORIGINAL','COPY']}" noSelection="['':'SELECT ONE...']" value="${typeOfBlPresented}"/> --%>
				<%--<input type="hidden" name="typeBlPresented"/>--%>
                                <g:radioGroup name="blPresented" labels="['Original','Copy']" values="['ORIGINAL', 'COPY']" value="${blPresented}" >
                                    ${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
                                </g:radioGroup>

			</td>
			<td><span class="field_label"> Shipment Currency </span></td>
			<td><g:textField class="input_field " readonly="readonly length3" name="shipmentCurrency" value="${shipmentCurrency ?: currency}"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> Indemnity Issue Date </span></td>
			<td><g:textField class="datepicker_field" name="indemnityIssueDate" value="${indemnityIssueDate?:DateUtils.shortDateFormat(new Date())}"/></td>
			<td><span class="field_label"> Shipment Sequence Number </span></td>
			<td><g:textField class="input_field " readonly="readonly" name="shipmentSequenceNumber" value="${shipmentSequenceNumber ?: shipmentCount ? shipmentCount.intValue() + 1 : '1'}" /></td>
		</tr>
		<tr>
	<%--		<g:if test="${documentSubType1?.equalsIgnoreCase('REGULAR')}"> --%>
				<td><span class="field_label"> TR Line</span></td>
				<td><g:textField class="input_field " readonly="readonly" name="trLine" value="${trLine}" /></td>
	<%--		</g:if>--%>
	<%--		<g:if test="${documentSubType1?.equalsIgnoreCase('CASH')}"> --%>
	<%--			<td colspan="2"> &#160; </td>--%>
	<%--		</g:if>--%>
			<td><span class="field_label"> With 2% CWT? <span class="asterisk">*</span></span></td>
			<td>
				<g:radioGroup name="cwtFlag" class="required" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" >
			     ${it.radio}&#160;<g:message code="${it.label}" />
			  </g:radioGroup>
			</td>
		</tr>
	</table>
</div>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/indemnity_type_popup"/>

<script type="text/javascript">
    $(window).load(function() {
        var trLineUrl = '${g.createLink(controller: "facility", action: "searchTrLines")}';

        $.get(trLineUrl, {cifNumber: $("#cifNumber").val(), mainCifNumber: $("#mainCifNumber").val() }, function(data) {

            $("#trLine").val(data.trLines);
        })
    });
</script>