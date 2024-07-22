<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="popups/description_of_goods_popup.js" />
<g:javascript src="popups/view_related_lc_popup.js" />
<g:javascript src="popups/cif_normal_search_popup.js"/>

<g:javascript src="js-temp/validation_DMLC_Opening_dataentry.js"/>

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
<g:hiddenField name="overAvailment" value="${overAvailment}" />
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="column_width"><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${etsNumber}"/></td>
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/></td>
		
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Main CIF Number </span></td>
		<td class="input_width"><g:textField name="mainCifNumber" class="input_field" readonly="readonly" value="${mainCifNumber}"/></td>
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td class="input_width"><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Main CIF Name </span></td>
		<td class="input_width"><g:textField name="mainCifName" class="input_field" readonly="readonly" value="${mainCifName}"/></td>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> DMLC Issue Date </span></td>
		<td class="input_width"><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
		<td class="label_width"><span class="field_label"> DMLC Expiry Date </span></td>
		<td class="input_width"><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Expiry Place </span></td>
		<td class="input_width"><g:textField name="expiryPlace" class="input_field" readonly="readonly" value="Makati City"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> DMLC Type </span></td>
		<td class="input_width"><g:textField name="type" class="input_field" readonly="readonly" value="${documentSubType1}"/></td>
		<td class="label_width"><span class="field_label"> DMLC Currency </span></td>
		<td class="input_width"><g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Tagging "P" or "F"<span class="asterisk">*</span> </span></td>
		<td class="input_width">
            <g:radioGroup class="required" name="standbyTagging" labels="['Performance','Financial']" values="['PERFORMANCE','FINANCIAL']" value="${standbyTagging ?: 'PERFORMANCE'}" >
                ${it.radio}<g:message code="${it.label}" />&#160;&#160;</g:radioGroup>
        </td>
		<td class="label_width"><span class="field_label"> DMLC Amount </span></td>
		<td class="input_width"><g:textField name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${amount}"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Purpose (Narrative) <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textArea name="purposeOfStandby" value="${purposeOfStandby}" rows="4" class="textarea required" maxlength="400"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Facility Type </span></td>
		<td class="input_width"><g:textField name="facilityType" value="${facilityType}" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label"> Facility ID </span></td>
		<td class="input_width"><g:textField name="facilityId" value="${facilityId}" class="input_field textFormat-11" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Form of Documentary <br/>Credit <span class="asterisk">*</span></span></td>
		<td class="input_width">
            %{--<tfs:formOfDocumentaryCredit name="formOfDocumentaryCredit" class="select_dropdown" value="${formOfDocumentaryCredit}" />--}%
<%--            <g:select name="formOfDocumentaryCredit" from="${['IRREVOCABLE', 'REVOCABLE', 'IRREVOCABLE TRANSFERABLE', 'REVOCABLE TRANSFERABLE']}" keys="${['I', 'R', 'IT', 'RT']}" noSelection="['':'SELECT ONE...']" value="${formOfDocumentaryCredit ?: 'I'}" class="select_dropdown required" />--%>
            <g:select name="formOfDocumentaryCredit" from="${['IRREVOCABLE STANDBY', 'REVOCABLE STANDBY', 'IRREVOCABLE TRANSFERABLE STANDBY']}" keys="${['IS', 'RS', 'ITS']}" noSelection="['':'SELECT ONE...']" value="${formOfDocumentaryCredit ?: 'IS'}" class="select_dropdown required" />
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Buyer CIF Number </span></td>
		<td colspan="2"> <g:textField name="applicantCifNumber" value="${applicantCifNumber}" class="input_field" />
			<span class="field_label"><a href="javascript:void(0)" class="search_btn popup_btn_cif_normal"> Search/Look-up Button </a> <br />
			%{--fix for issue#459--}%
			%{--<a href="javascript:void(0)" id="popup_btn_view_related_lc">View Related LC's</a>--}%
        </span>
		</td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Buyer Name<span class="asterisk">*</span> </span></td>
		<td class="input_width"><g:textArea name="applicantName" value="${applicantName}" class="textarea required" rows="2" maxlength="120"/></td>
		<td class="label_width valign_top"><span class="field_label"> Seller Name <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textArea name="beneficiaryName" value="${beneficiaryName}" class="textarea required" rows="2" maxlength="60"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Buyer Address<span class="asterisk">*</span> </span></td>
		<td valign="top"><g:textArea name="applicantAddress" value="${applicantAddress}" rows="4" class="textarea required" maxlength="160"/></td>
		<td class="label_width valign_top"><span class="field_label"> Seller Address <span class="asterisk">*</span></span></td>
		<td><g:textArea name="beneficiaryAddress" value="${beneficiaryAddress}" rows="4" class="textarea required" maxlength="160"/></td>
	</tr>
	<%--<tr>
		<td class="label_width"><span class="field_label"> Narrative <span class="asterisk">*</span></span> </td>
		<td colspan="2"><g:select name="narrative" value="${narrative}" from="${['FORMAT 1', 'FORMAT 2', 'FORMAT 3']}" keys="${['FORMAT1', 'FORMAT2', 'FORMAT3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" /> &#160; <a href="javascript:void(0)" class="popup_btn"></a></td>
	</tr>
	<tr>
		<td><br/>&#160;</td>
	</tr>
	--%><tr valign="top">
		<td class="label_width"><span class="field_label"> Description of Goods and/or Services%{--<span class="asterisk">*</span>--}% </span></td>
		<td colspan="3"><g:textArea name="descriptionOfGoodsServices" value="${descriptionOfGoodsServices}" rows="4" class="textarea" readonly="readonly" maxlength="6500"/><span class="vbottom"><a href="javascript:void(0)" class="popup_btn" id="popup_btn_description_of_goods"></a></span></td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper" />

<g:render template="../commons/popups/view_related_lc_popup" />
<g:render template="../commons/popups/description_goods_popup" />

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
