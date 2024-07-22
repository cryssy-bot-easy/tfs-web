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
    %{--<g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>--}%
%{--</g:each>--}%

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${etsNumber}"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label">TIN<span class="asterisk">*</span> </span> </td>
        <td class="input_width"> <g:textField class="input_field required" name="tinNumber" value="${tinNumber}" maxlength="20"/> </td>
        <td class="label_width"> <span class="field_label">Importer Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
    </tr>
	<tr>
		<td><span class="field_label">FXLC Type</span></td>
		<td><g:textField class="input_field" name="type" readonly="readonly" value="${type}"/></td>
		<td class="label_width"> <span class="field_label"> Commodity Code</span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="commodity" id="commodity" disabled="disabled"/>
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Issue Date </span></td>
		<td><g:textField class="input_field" name="issueDate" readonly="readonly" value="${issueDate}"/></td>
		<td><span class="field_label">FXLC Expiry Date </span></td>
		<td><g:textField class="input_field" name="expiryDate" readonly="readonly" value="${expiryDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Currency</span></td>
		<td><g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/></td>
		<td><span class="field_label">FXLC Amount</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="originalAmount" readonly="readonly" value="${originalAmount ?: productAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Outstanding FXLC Amount</span></td>
		<td><g:textField class="input_field numericCurrency" name="outstandingBalance" readonly="readonly" value="${outstandingBalance}"/></td>
		<td><span class="field_label">Related References<span class="asterisk">*</span></span></td>
		<td><g:textField class="input_field required" name="relatedReferences" value="${relatedReferences}" maxlength="16"/></td>
	</tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    $(document).ready(function() {
        var commodityCode = $('#commodityCode').val(),
            splittedCommodity;

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
                    $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                }
            });
        }

    });
</script>

