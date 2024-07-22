<g:javascript src="utilities/dataentry/commons/other_document_utility.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="otherDocumentsInstruction" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<div id="other_documents_instructions">
		<g:textArea name="otherDocumentsInstructions" class="textarea_add_instructions" readonly="readonly" >
            ${otherDocumentsInstructions ?: "\t\t\tDrafts drawn under this credit must bear the clause \"Drawn under UNITED COCONUT PLANTERS BANK\" Letter of Credit No. (extracted) dated (extracted).\n" +
                    "\t\t\t\t\n" +
                    "\t\t\tWe hereby engage with you that all drafts drawn and in compliance with the terms and conditions of this Domestic Letter of Credit will be duly honored.\n" +
                    "\t\n" +
                    "\t\t\tThis Letter of Credit is issued subject to the Uniform Customs and Practices for Documentary Credit (Latest Version, International Chamber of Commerce Publication)."}
		</g:textArea>
		<br />
		<br />

		<table class="buttons_for_grid_wrapper">
			<tr>
				<td><input type="button" id="edit_other_document" class="input_button" value="Edit" /></td>
			</tr>
			<tr>
				<td><input type="button" class="input_button openSaveConfirmation" value="Save" /></td>
			</tr>
		</table>
</div>