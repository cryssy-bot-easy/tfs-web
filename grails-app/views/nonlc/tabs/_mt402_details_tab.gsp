<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt402DetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">Sender's Correspondent</span></td>
		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="senderCorrespondent" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="1" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="senderIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCode" id="senderIdentifierCode" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="2" />&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="senderLocation" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="3" />&#160;&#160;Name and Address</span></td>
		<td><g:textArea class="textarea_long" name="senderNameAndAddress"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverType1 name="senderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea_long" name="senderToReceiverInformation" readonly="readonly"/>
			<input type="button" class="popup_btn_bottom" id="sender_info">
		</td>
	</tr>
	<tr>
		

	</tr>
	<tr>
		<td><span class="field_label">Ordering Bank</span></td>
		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="orderingBank" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="orderingBankFlag" class="orderingBankFlag" value="1" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="bankIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCode" id="bankIdentifierCode" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="orderingBankFlag" class="orderingBankFlag" value="2" />&#160;&#160;Name and Address</span></td>
		<td><g:textArea class="textarea_long" name="bankNameAndAddress"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Receiver's Correspondent</span></td>
		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="receiverCorrespondent" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="1" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="receiverIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCode" id="receiverIdentifierCode" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="2" />&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="receiverLocation" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="3" />&#160;&#160;Name and Address</span></td>
		<td><g:textArea class="textarea_long" name="receiverNameAndAddress"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Details of Charges(MT400)</span></td>
		<td><g:select value="${detailsOfCharges}" from="${['BEN','OUR','SHA']}" noSelection="['':'SELECT ONE']" name="receiverCorrespondent" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Details of Amount Added(MT400)</span></td>
		<td>
			<g:select from="${['INTEREST','RETCOMM','YOURCHAR']}" noSelection="['':'SELECT ONE']" name="detailsOfAmountDescription" class="select_dropdown"/>
			<g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="detailsOfAmountCurrency" class="select_dropdown"/>
			<g:textField class="input_field" name="detailsOfAmountTextField" />
		</td>
	</tr>
	<tr>
		<td></td>
		<td><g:textArea class="textarea_long" name="detailsOfAmountTextArea"/></td>
	</tr>
</table>
<br/><br/>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 402" onclick="goToViewMt(402)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />