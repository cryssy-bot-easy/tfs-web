<g:javascript src="utilities/other_imports/commons/mt_details_utility.js"/>
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mtDetails" />

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">Time Indication</span></td>
		<td><g:select name="timeIndicationDropDown" from="${['CLSTIME','RNCTIME','SNDTIME'] }" noSelection="['':'Select...']" class="select_dropdown_medium" /> <g:textField name="timeIndication" class="input_field_medium" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Bank Operation Code</span></td>
		<td><g:select name="bankOperationCode" from="${['CRED','SPAY','SPRI','SSTD']}" class="select_dropdown" noSelection="['':'Select One...']" />
	</tr>
	<tr>
		<td><span class="field_label">Instruction Code</span></td>
		<td><g:select name="instructionCode" from="${['SDVA','INTC','REPA','CORT']}" class="select_dropdown" noSelection="['':'Select One...']" />
	</tr>
	<tr>
		<td><span class="field_label">Transaction Type Code</span></td>
		<td><g:select name="transactionTypeCode" from="${['CRED']}" class="select_dropdown" noSelection="['':'Select One...']" />
	</tr>
	<tr>
		<td><span class="field_label">Exchange Rate</span></td>
		<td><g:textField name="exchangeRate" class="input_field_right" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Sending Institution</span></td>
		<td><g:select name="sendingInstitutionDropdown" from="${['Option 1','Option 2','Option N']}" noSelection="['':'Select...']" class="select_dropdown_medium" /> <g:textField name="sendingInstitutionTextfield" class="input_field_medium" /></td>
	</tr>
	<tr>
		<td><span class="title_label">Ordering Bank</span></td>
		<td></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="orderingOption" class="orderingOptionA" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeOrderingBank" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="orderingOption" class="orderingOptionD" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td><g:textArea name="nameAndAddressOrderingBank" rows="4" cols="37" readonly="readonly"></g:textArea></td>
		<td valign="bottom">	
			<span>&#160;<span id="remainingCharacterOrderingBank"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineOrderingBank"></span>&#160;Lines Left</span>
		</td>
	</tr>
	
	
	<tr>
		<td><span class="title_label">Sender's Correspondent<span class="asterisk">*</span></span></td>
		<td></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="senderOption" class="senderOptionA" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeSenders" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="senderOption" class="senderOptionA" value="B"/>
				<span>Option-B Location</span>
			</span>
		</td>
		<td><g:textField name="locationSenders" class="input_field" readonly="readonly" /></td>
			</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="senderOption" class="senderOptionD" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>		
		<td><g:textArea name="nameAndAddressSenders" rows="4" cols="37" readonly="readonly"></g:textArea></td>
		<td valign="bottom">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		</td>
	</tr>
	
	
	<tr>
		<td><span class="title_label">Receiver's Correspondent<span class="asterisk">*</span></span></td>
		<td></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="receiverOption" class="receiverOptionA" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeReceivers" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">
				<g:radio name="receiverOption" class="receiverOptionB" value="B"/>
				<span>Option-B Location</span>
			</span>
		</td>
		<td><g:textField name="locationReceivers" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="receiverOption" class="receiverOptionD" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>		
		<td><g:textArea name="nameAndAddressReceivers" rows="4" cols="37" readonly="readonly"></g:textArea></td>
		<td valign="bottom">	
			<span>&#160;<span id="remainingCharacterReceivers"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineReceivers"></span>&#160;Lines Left</span>
		</td>
	</tr>
	
	
	
	<tr>
		<td><span class="title_label">Third Reimbursment Institution</span></td>
		<td> </td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">
				<g:radio name="thirdOption" class="thirdOptionA" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeAccountThird" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">
				<g:radio name="thirdOption" class="thirdOptionB" value="B"/>
				<span>Option-B Location</span>
			</span>
		</td>
		<td><g:textField name="locationAccountThird" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="thirdOption" class="thirdOptionD" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>	
		<td ><g:textArea name="nameAndAddressAccountThird" rows="4" cols="37" readonly="readonly"></g:textArea></td>
		<td valign="bottom">	
			<span>&#160;<span id="remainingCharacterAccountThird"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineAccountThird"></span>&#160;Lines Left</span>
		</td>
	</tr>



	<tr>
		<td><span class="title_label">Intermediary</span></td>
		<td></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">
				<g:radio name="intermediaryOption" class="intermediaryOptionA" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeIntermediary" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="intermediaryOption" class="intermediaryOptionD" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td colspan="2"><div><g:textArea name="nameAndAddressIntermediary" rows="4" cols="37" readonly="readonly"></g:textArea></div>
		</td>
	</tr>
	
	<tr>
		<td class="label_width"><span class="title_label">Account with Bank <span class="asterisk">*</span></span></td>
		<td class="input_width"></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">
				<g:radio name="accountOption" class="accountOptionA" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeAccountWithBank" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">
				<g:radio name="accountOption" class="accountOptionB" value="B"/>
				<span>Option-B Location</span>
			</span>
		</td>
		<td><g:textField name="locationAccountWithBank" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="accountOption" class="accountOptionD" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td ><g:textArea name="nameAndAddressAccountWithBank" rows="4" cols="37" readonly="readonly"></g:textArea></td>
		<td valign="bottom">	
			<span>&#160;<span id="remainingCharacterAccountWithBank"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineAccountWithBank"></span>&#160;Lines Left</span>
		</td>
	</tr>
	
	
	<tr>
		<td><span class="field_label">Remittance Information</span></td>
		<td><g:select name="remittanceInformation" from="${['INV','IPI','RFB','ROC','TSU']}" noSelection="['':'Select One...']" class="select_dropdown" /></td>
	</tr>
	<tr>
		<td></td>
		<td><g:textArea name="remittanceInformationTextArea" rows="4" cols="37"></g:textArea></td>
	</tr>
	<tr>
		<td><span class="field_label">Details of Charges</span></td>
		<td><g:select value="${detailsOfCharges}" name="detailsOfCharges" from="${['BEN','OUR','SHA']}" class="select_dropdown" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Sender's Charges</span></td>
		<td><g:textField name="sendersChargesCurrency" class="input_field_short" />
			<g:textField name="sendersChargesAmount" class="input_field_medium2" />
		</td>
	</tr>
	<tr>
		<td class="label_width"><span>Receiver's Charges</span></td>
		<td><g:textField name="receiverChargesCurrency" class="input_field_short" /> 
			<g:textField name="receiversChargesAmount" class="input_field_medium2" />
		</td>	
	</tr>
	<tr>
		<td valign="top"><span>Sender to Receiver's Information</span></td>
		<td><g:textArea name="senderReceiverInformationIntermediary" rows="4" cols="37"></g:textArea></td>
	</tr>
	<tr>
		<td><span class="field_label">Regulatory Reporting</span></td>
		<td><g:select name="regulatoryDropdown" from="${['BENEFRES','ORDERRES']}" noSelection="['':'Select One...']" class="select_dropdown" /> </td>
	<tr/>
	<tr>
		<td/>
		<td><g:textArea name="regulartoryReport" rows="4" cols="37"></g:textArea></td>
	</tr>
	<tr>
		<td><span class="field_label">Envelope Contents</span></td>
		<td><g:select name="envelopeContents" from="${['ANSI','NARR','SWIF','UEDI']}" class="select_dropdown" noSelection="['':'Select One...']" />
	</tr>
	<tr>
		<td/>
		<td>
			<g:textField name="envelopContentsText" class="input_field"/>
		</td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />