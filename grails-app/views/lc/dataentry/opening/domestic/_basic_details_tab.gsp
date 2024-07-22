<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="popups/cif_normal_search_popup.js"/>

<g:javascript src="js-temp/validation_DMLC_Opening_dataentry.js"/>

<g:javascript src="popups/cif_normal_search_popup.js" />
<g:javascript src="popups/view_related_lc_popup.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<g:hiddenField name="processingUnitCode" value="${processingUnitCode}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="oldDescriptionOfGoods" value="${oldDescriptionOfGoods ?: generalDescriptionOfGoods}"/>
<g:hiddenField name="relatedLcDescriptionOfGoods" value="${relatedLcDescriptionOfGoods}"/>

<g:hiddenField name="reversalTradeServiceId" value="${reversalTradeServiceId}"/>
<g:hiddenField name="overAvailment" value="${overAvailment}" />
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>

<g:hiddenField name="relatedRequiredDocumentsList" value="${relatedRequiredDocumentsList }" />
<g:hiddenField name="relatedAddedDocumentsList" value="${relatedAddedDocumentsList }" />

<%--for AMLA--%>
<g:if test="${documentSubType1?.equalsIgnoreCase('CASH')}">
	<g:hiddenField name="amlaRemittanceFlag" value="${amlaRemittanceFlag}" />
	<g:hiddenField name="amlaCheckFlag" value="${amlaCheckFlag}" />
	<g:hiddenField name="amlaCashFlag" value="${amlaCashFlag}" />
	<g:hiddenField name="amlaCasaFlag" value="${amlaCasaFlag}" />
	<g:hiddenField name="amlaRemittanceFlagPhp" value="${amlaRemittanceFlagPhp}" />
	<g:hiddenField name="amlaCheckFlagPhp" value="${amlaCheckFlagPhp}" />
	<g:hiddenField name="amlaCashFlagPhp" value="${amlaCashFlagPhp}" />
	<g:hiddenField name="amlaCasaFlagPhp" value="${amlaCasaFlagPhp}" />
	<g:hiddenField name="amlaRemittanceFlagFx" value="${amlaRemittanceFlagFx}"/>
	<g:hiddenField name="amlaCheckFlagFx" value="${amlaCheckFlagFx}"/>
	<g:hiddenField name="amlaCashFlagFx" value="${amlaCashFlagFx}"/>
	<g:hiddenField name="amlaCasaFlagFx" value="${amlaCasaFlagFx}"/>
	<g:hiddenField name="amlaRemittanceFlagAmount" value="${amlaRemittanceFlagAmount}"/>
	<g:hiddenField name="amlaCheckFlagAmount" value="${amlaCheckFlagAmount}"/>
	<g:hiddenField name="amlaCashFlagAmount" value="${amlaCashFlagAmount}"/>
	<g:hiddenField name="amlaCasaFlagAmount" value="${amlaCasaFlagAmount}"/>
<%--	<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagAccountNo}"/>--%>
	<g:hiddenField name="amlaCasaFlagFxCurrency" value="${amlaCasaFlagFxCurrency}"/>
	<g:hiddenField name="amlaRemittanceFlagFxCurrency" value="${amlaRemittanceFlagFxCurrency}"/>
</g:if>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> eTS Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${etsNumber}"/></td>
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>					
		<td class="label_width"><span class="field_label"> Main CIF Number </span></td>
		<td class="input_width"><g:textField class="input_field numericString" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/></td>
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Main CIF Name </span></td>
		<td class="input_width"><g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/></td>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> DMLC Issue Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="issueDate" readonly="readonly" value="${issueDate}"/></td>
		<td class="label_width"><span class="field_label"> DMLC Expiry Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="expiryDate" readonly="readonly" value="${expiryDate}"/></td>
	</tr>	
	<tr>
		<td class="label_width"><span class="field_label"> Expiry Place </span></td>
		<td class="input_width"><g:textField name="expiryPlace" class="input_field" readonly="readonly" value="Makati City"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> DMLC Currency </span></td>
		<td class="input_width"><g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/></td>
		<td class="label_width"><span class="field_label"> DMLC Type </span></td>					
		<td class="input_width"><g:textField class="input_field" name="type" value ="${documentSubType1}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> DMLC Amount </span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/></td>
	</tr>
	<g:if test="${documentSubType1 == 'REGULAR'}">
		<tr>
			<td class="label_width"><span class="field_label"> Facility Type </span></td>
			<td class="input_width"><g:textField class="input_field" name="facilityType" readonly="readonly" value="${facilityType}"/></td>
			<td class="label_width"><span class="field_label"> Facility ID </span></td>
			<td>
			    <g:textField class="input_field" name="facilityId" readonly="readonly" value="${facilityId}"/>
			</td>
		</tr>
	</g:if>
	<tr>
		<td class="label_width"><span class="field_label"> Buyer CIF Number </span></td>
		<td class="input_width"><g:textField value="${applicantCifNumber}" class="input_field" name="applicantCifNumber" maxlength="10"/>&#160;
            <span class="field_label"><a href="javascript:void(0)" class="search_btn popup_btn_cif_normal"> Search/Look-up Button </a> <br /> <a href="javascript:void(0)" id="popup_btn_view_related_lc">View Related LC's</a></span>
        </td>
        <td></td>
		<td>
			<g:radioGroup name="individualCorporateFlag" id="individualCorporateFlag" labels="['Individual', 'Corporate']" values="['I','C']" value="${individualCorporateFlag?:'C'}">
				<label>${it.radio} ${it.label} &#160;&#160;</label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Buyer Name <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textArea class="textarea required" name="applicantName" value="${applicantName}" rows="2" maxlength="50"/></td>
		<td class="label_width valign_top"><span class="field_label"> Seller Name <span class="asterisk">* </span></span></td>
		<td class="input_width"><g:textArea class="textarea required" name="beneficiaryName" value="${beneficiaryName}" rows="2" maxlength="60"/></td>
	</tr>
	<tr><td><br /></td></tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Buyer Address <span class="asterisk">* </span></span></td>
		<td><div><g:textArea class="input_field required" name="applicantAddress" value="${applicantAddress}" rows="4" maxlength="160"/></td>
		<td class="label_width valign_top"><span class="field_label"> Seller Address <span class="asterisk">* </span></span></td>
		<td><g:textArea class="input_field required" name="beneficiaryAddress" value="${beneficiaryAddress}" rows="4" maxlength="160"/></td>
	</tr>
</table>

<g:render template="../layouts/buttons_for_grid_wrapper" />

<g:render template="../commons/popups/view_related_lc_popup" />

<script type="text/javascript">
$(document).ready(function() {
	if($("#overAvailment").val() == "NOTE: Transaction has been rejected."){
    	$("#overAvailment").val(" ");
    	$(".overAvailment").html(" ");
    }
	if($("#applicantCifNumber").val() == "" && $("#applicantName").val() == "" && $("#applicantAddress").val() == "") {
		$("#applicantCifNumber").val($("#cifNumber").val());
		$("#applicantName").val($("#longName").val());
		$("#applicantAddress").val($("#address1").val() + " " + $("#address2").val());
	}
});
</script>