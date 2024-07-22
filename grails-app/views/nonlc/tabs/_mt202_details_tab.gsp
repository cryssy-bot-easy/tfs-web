<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt202DetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">Time Indication</span></td>
		<td>
			<g:select from="${['SNDTIME','CLSTIME','RNCTIME']}" noSelection="['':'SELECT ONE']" name="timeIndicationMt202" class="select_dropdown"/>
			<g:textField class="input_field" name="timeIndicationFieldMt202" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Intermediary</span></td>
		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="intermediary" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="intermediaryFlag" class="intermediaryFlag" value="1" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="intermediaryIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="intermediaryIdentifierCode" id="intermediaryIdentifierCode" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="intermediaryFlag" class="intermediaryFlag" value="2" />&#160;&#160;Name and Address</span></td>
		<td><g:textArea class="textarea_long" name="intermediaryNameAndAddress"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Account with Bank</span></td>
		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="accountWithBank" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="1" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="accountIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCode" id="accountIdentifierCode" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="2" />&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="accountLocation" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="3" />&#160;&#160;Name and Address</span></td>
		<td><g:textArea class="textarea_long" name="accountNameAndAddress"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Beneficiary Bank</span></td>
		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="beneficiaryBank" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlag" class="beneficiaryBankFlag" value="1" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="beneficiaryIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCode" id="beneficiaryIdentifierCode" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlag" class="beneficiaryBankFlag" value="2" />&#160;&#160;Name and Address</span></td>
		<td><g:textArea class="textarea_long" name="beneficiaryNameAndAddress"/></td>
	</tr>
</table>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />