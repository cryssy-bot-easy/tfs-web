<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="branchUnitcode" value="${branchUnitcode ?: session.unitcode}" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />

<script type="text/javascript">
    var outstandingBalanceGridUrl = '${g.createLink(controller: "mdEtsCollection", action: "displayOutstandingBalance")}';
    outstandingBalanceGridUrl += "?documentNumber="+'${documentNumber}';
</script>
<g:javascript src="grids/md_balance_jqgrid.js" />
<g:javascript src="utilities/commons/ets_index_utility.js" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="saveAs" value=""/>

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />

<g:hiddenField name="cifNumber" value="${cifNumber}" />
<g:hiddenField name="cifName" value="${cifName}" />
<g:hiddenField name="accountOfficer" value="${accountOfficer}" />
<g:hiddenField name="ccbdBranchUnitCode" value="${ccbdBranchUnitCode}" />

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
<%--    <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
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
		<td class="label_width"><span class="field_label"> eTS Number </span></td>
		<td class="label_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${referenceType?.equalsIgnoreCase('ETS') ? serviceInstructionId : etsNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:select from="${['909']}" class="select_dropdown" name="processingUnitCode" value="${processingUnitCode}" noSelection="['':'SELECT ONE']"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> LC/Non-LC Currency </span></td>
		<td><g:textField class="input_field" name="currency" value="${currency}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> LC/Non-LC Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" readonly="readonly"/></td>
	</tr>	
	<tr>
		<td><span class="field_label"> O/S MD Balance </span></td>
		<td>
			<div class="grid_wrapper_apply_ap">
				<table id="grid_list_md_application"></table>
			</div>
		</td>
	</tr>
</table>

<g:hiddenField name="mdSettlementCurrency" value="" />
<g:hiddenField name="mdAmountPaid" value="" />

<g:render template="../layouts/buttons_for_grid_wrapper" />
