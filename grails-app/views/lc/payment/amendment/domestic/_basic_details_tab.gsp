<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<%@page import="net.ipc.utils.DateUtils" %>
<g:javascript src="js-temp/validation_Charges_Tab.js"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="expiryDate" value="${expiryDate}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> eTS Number<span class="asterisk">* </span></span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${etsNumber}" /></td>
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>	
		<g:if test="${documentSubType1?.equalsIgnoreCase('STANDBY')}">
			<td><span class="field_label"> Process Date </span></td>
			<td><g:textField class="input_field" name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		</g:if>				
		<g:else>
			<td><span class="field_label"> Process Date </span></td>
			<td><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
		</g:else>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> DMLC Type </span></td>					
		<td><g:textField class="input_field" name="type" value="${type}" readonly="readonly"/></td>
		<td><span class="field_label"> Tenor </span></td>
		<td><g:textField class="input_field" name="tenor" value="${tenor}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> DMLC Currency </span></td>
		<td><g:textField class="input_field" name="currency" value="${currency}" readonly="readonly"/></td>
		<td><span class="field_label"> DMLC Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="amount" value="${amount ?: productAmount}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> DMLC O/S Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> With 2% CWT? </span></td>
		<td>
            %{--<%--<g:textField class="input_field" name="cwtFlag" readonly="readonly"/>--%>--}%
            <g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="disabled">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
        </td>
	</tr>
</table>
<br /><br />
<%--<g:render template="../layouts/buttons_for_grid_wrapper" />--%>
