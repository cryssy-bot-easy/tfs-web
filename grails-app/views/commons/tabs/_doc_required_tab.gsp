<%@ page import="net.ipc.utils.DateUtils" %>
<%-- 
(revision)
[Modified by:] Rafael Ski Poblete
[Date Modified:] 8/28/2018
[Description: ] Added Special Payment Conditions for Beneficiary and Special Payment Conditions for Receiving Bank fields. --%>
<script type="text/javascript">
    var documentsRequiredUrl = '${g.createLink(controller: "requiredDocuments", action: "findAllRequiredDocuments")}';
    var savedDocumentsRequiredUrl = '${g.createLink(controller: "requiredDocuments", action: "findAllSavedRequiredDocuments")}';
    var addedDocumentsUrl = '${g.createLink(controller: "requiredDocuments", action: "findAllAddedDocuments")}';
    var getAllAddedDocumentsUrl = '${g.createLink(controller: "requiredDocuments", action: "getAllAddedDocuments")}';
</script>

<g:javascript src="grids/doc_required_jqgrid.js" />
<g:javascript src="grids/preview_doc_required_jqgrid.js" />

<%-- For Amendment --%>
<g:javascript src="utilities/dataentry/commons/documents_required_utility.js" />
<g:if test="${serviceType == 'Amendment' }">
    <g:javascript src="utilities/dataentry/commons/amendmentNarrative.js" />
</g:if>

<g:javascript src="grids/required_documents_jqgrid.js" />
<g:javascript src="popups/add_condition1_popup.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="documentsRequired" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<%-- For other serviceType --%>
	<div class="grid_wrapper">
		<table id="doc_required_list" class="jqgrid_uppercase"></table>
		<div id="doc_required_pager"></div>
        <g:hiddenField name="requiredDocumentsList" value="" />
	</div>
	
	<span class="right_indent">
		<input type="button" value="Add Documents" class="input_button_long" id="btnAddConditionRequiredDoc"/>
	</span>
	<br/>
	<br/>
	
	<div class="grid_wrapper">
		<table id="preview_doc_required_list"></table>
		<div id="preview_doc_required_pager"></div>
        <g:hiddenField name="addedDocumentsList" value="" />
	</div>
	<br />
	
	<g:if test="${(documentType?.equalsIgnoreCase('Domestic') && serviceType?.equalsIgnoreCase('Opening') && (documentSubType1?.equalsIgnoreCase('Regular') || documentSubType1?.equalsIgnoreCase('Cash')))}">
		<g:textArea name="otherDocumentsInstructions" class="textarea_other_instructions" value="${otherDocumentsInstructions ?: ("Other documents/instructions:\n\n"+
        "Drafts drawn under this credit must bear the clause “Drawn under UNITED COCONUT PLANTERS BANK” Letter of Credit no. " + documentNumber.toString().replaceAll("-","") + " dated "+(processDate ?: DateUtils.shortDateFormat(new Date()))+".\n\n"+
        "We hereby engage with you that all drafts drawn and in compliance with the terms and conditions of this Domestic Letter of Credit will be duly honored.\n\n"+
        "This Letter of Credit is issued subject to the Uniform Customs and Practices for Documentary Credit (Latest Version, International Chamber of Commerce Publication).")}"/>
		<br/>
		<br/>
	</g:if>	
	
	<%--<input type="button"  id="popup_btn_preview_req_doc1" value="Preview Required Documents in SWIFT" class="input_button_long2"/> Bug #3204
	--%>
<br/>
<br/>
	<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
		<p class="p_header" style="margin-top:20px">Special Payment Conditions for Beneficiary</p>
		<g:textArea name="specialPaymentConditionsForBeneficiary" value="${specialPaymentConditionsForBeneficiary}" class="textarea" readonly="readonly" rows="4" style="width:475px; height:10em;"/>
		<a href="javascript:void(0)" class="search_btn" id="popup_btn_special_payment_conditions_for_beneficiary">...</a>
		
		<p class="p_header" style="margin-top:20px">Special Payment Conditions for Receiving Bank</p>
		<g:textArea name="specialPaymentConditionsForReceivingBank" value="${specialPaymentConditionsForReceivingBank}" class="textarea" readonly="readonly" rows="4" style="width:475px; height:10em;"/>
		<a href="javascript:void(0)" class="search_btn" id="popup_btn_special_payment_conditions_for_receiving_bank">...</a>
    </g:if>	
<g:render template="../layouts/buttons_for_grid_wrapper" />


<%--<g:render template="../commons/popups/add_condition1_popup"/>--%>
<%--<g:render template="../commons/popups/doc-required/add_condition_requiredDocuments_popup"/>--%>
<g:render template="../commons/popups/required_documents1_popup"/>

<g:render template="../commons/popups/addedit_docs_required_popup"/>

