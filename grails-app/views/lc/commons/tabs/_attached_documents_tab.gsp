<g:form name="attachedDocumentsTabForm" id="attachedDocumentsTabForm" method="POST" action="uploadDocument"   enctype="multipart/form-data" >                    
<g:javascript src="grids/attached_document_jqgrid.js" />
<g:javascript src="utilities/ets/commons/attached_documents_tab_utility.js" />

<g:hiddenField  name="etsNumber" id="etsNumber" readonly="readonly" value="${serviceInstructionId}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />

		<table class="tabs_forms_table">
			  <tr>
				<td width="90"> <span class="field_label"> Document Type </span> </td>
				<td>
                    <tfs:docType name="docType" class="select_dropdown" />
                </td>
			  </tr>
			  <tr>
				<td><span class="field_label"> File Location </span> </td>
				<td><input class="input_field_file" type="file" name="fileLocation" id="fileLocation" /> 
					<input type="hidden" name="fileDirectory"/>
				</td>
			  </tr>
			  <tr> <%-- BUTTON --%>			  	
				<td>
				<%-- <g:submitButton name="uploadDocument" value="uploadDocument" id="uploadDocument" class="input_button2 button_override" /> --%>
				<input type="submit" value="Upload" id="uploadDocument" class="input_button2 button_override" /> 
                <%-- <input type="button" value="Upload" id="uploadAttachedFile" class="input_button2 button_override" /> --%>
				</td>
			  </tr>
			</table> <%-- End of SEARCH Form--%>
			
			<div class="grid_wrapper"> <%-- JQGRID --%>
			  <table id="grid_list_attached_documents"> </table>
  			<div id="grid_pager_attached_documents"> </div>
			</div>
			<br/>
</g:form>