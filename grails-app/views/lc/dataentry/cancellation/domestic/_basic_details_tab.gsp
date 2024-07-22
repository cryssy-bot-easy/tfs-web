<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="standbyTagging" value="${standbyTagging}"/>
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
<%--    <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
%{--<g:each in="${urrrates}" var="temp" status="i">--}%
    %{--<g:hiddenField name="${temp.rates}_urr" value="${temp.pass_on_rate}"/>--}%
%{--</g:each>--}%
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> eTS Number </span></td>
		<td><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${etsNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Processing Unit Code </span></td>
		<td><g:textField class="input_field" name="processingUnitCode" readonly="readonly" value="${processingUnitCode}"/></td>
		
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Outstanding DMLC Amount</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="outstandingBalance" readonly="readonly" value="${outstandingBalance}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Outstanding DMLC Submitted? </span></td>
		<td>
			 <g:radioGroup name="originalLcSubmittedFlagDisplay" value="${originalLcSubmittedFlag}" labels="['Yes','No']" values="['Y', 'N']" disabled="true">
		     ${it.radio}<g:message code="${it.label}" />&#160;&#160;
		    </g:radioGroup>
		    <g:hiddenField name="originalLcSubmittedFlag" value="${originalLcSubmittedFlag}" />
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label"> Reason for Cancellation </span></td>
		<td><g:textArea name="reasonForCancellation" value="${reasonForCancellation}" class="textarea" rows="4" readonly="readonly"/></td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper" />