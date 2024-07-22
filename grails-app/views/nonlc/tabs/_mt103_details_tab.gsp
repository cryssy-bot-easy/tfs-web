<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt103DetailsTab" />

<g:if test="${documentClass == 'Document Against Payment'}">
	<table class="tabs_forms_table">
		<tr>
			<td><span class="field_label">Value Date</span></td>
			<td><g:textField class="input_field" name="valueDate" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Receiving Bank</span></td>
			<td><g:select from="${[]}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="receivingBank"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Bank Operation Code</span></td>
			<td><g:select from="${['CRTST','CREDIT','SPAY']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="bankOperationCode"/></td>
		</tr>
		<tr>
			<td><h3 class="title_label">Ordering Customer Details</h3></td>
		</tr>
		<tr>
			<td><span class="field_label">Buyer's CASA Number</span></td>
			<td><g:textField class="input_field" name="buyerCasaNumber"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Buyer's Name</span></td>
			<td><g:textField class="input_field" name="buyerName"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Buyer's Address</span></td>
			<td><g:textArea class="textarea_long" name="buyerAddress" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Account with Institution</span></td>
			<td><g:select from="${[]}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="accountWithInstitution"/></td>
		</tr>
		<tr>
			<td><h3 class="title_label">Seller Details</h3></td>
		</tr>
		<tr>
			<td><span class="field_label">Seller's Account Number</span></td>
			<td><g:textField class="input_field" name="sellerAccountNumber"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Seller's Name</span></td>
			<td><g:textField class="input_field" name="sellerName"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Seller's Address</span></td>
			<td><g:textArea class="textarea_long" name="sellerAddress" /></td>
		</tr>
		<tr>
			<td><h3 class="title_label">Details of Charges</h3></td>
			<td><g:select value="${detailsOfCharges}" from="${['SHA','BEN','OUR']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="detailsOfCharges"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Sender's Charges</span></td>
			<td>
				<g:select from="${['PHP']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="senderChargesCurrency"/>
				<g:textField class="input_field" name="senderCharges"/>
			</td>
		</tr>
		<tr>
			<td><span class="field_label">Receiver's Charges</span></td>
			<td>
				<g:select from="${['PHP']}" class="select_dropdown" noSelection="['':'SELECT ONE']" name="receiverChargesCurrency"/>
				<g:textField class="input_field" name="receiverCharges"/>
			</td>
		</tr>
	</table>
</g:if>

<g:elseif test="${documentClass == 'Direct Remittance' || documentClass == 'Open Account'}">
	<table class="tabs_forms_table">
		<tr>
			<td><span class="field_label">Bank Operation Code</span></td>
			<td><g:select from="${['CREDIT','SPAY']}" noSelection="['':'SELECT ONE']" name="bankOperationCode" class="select_dropdown"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Instruction Code</span></td>
			<td><g:select from="${['SDVA','INTC','REPA','CORT','HOLD','CHQB','PHOB','TELB','PHON','TELE','PHOI','TELI']}" noSelection="['':'SELECT ONE']" name="bankOperationCode" class="select_dropdown"/></td>
	<%--		<td><span class="field_label small_margin_left">Identifier Code</span></td>--%>
	<%--		<td><g:textField class="input_field" name="senderIdentifierCode" /></td>--%>
		</tr>
		<tr>
			<td></td>
			<td><g:textArea class="textarea_long" name="bankOperationTextArea"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Transaction Type Code</span></td>
			<td><g:select from="${[]}" noSelection="['':'SELECT ONE']" name="transactionTypeCode" class="select_dropdown"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Exchange Rate</span></td>
			<td><g:textField class="input_field" name="exchangeRate" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Sending Institution</span></td>
			<td><g:textField class="input_field" name="sendingInstitution" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Third Reimbursement Institution</span></td>
			<td><g:textField class="input_field" name="thirdReimbursementInstitution" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Sender's Charges</span></td>
			<td>
				<g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="senderChargesCurrency" class="select_dropdown"/>
				<g:textField class="input_field" name="senderCharges" />
			</td>
		</tr>
		<tr>
			<td><span class="field_label">Receiver's Charges</span></td>
			<td>
				<g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="receiverChargesCurrency" class="select_dropdown"/>
				<g:textField class="input_field" name="receiverCharges" />
			</td>
		</tr>
		<tr>
			<td><span class="field_label">Regulatory Reporting</span></td>
			<td><g:textArea class="textarea_long" name="regulatoryReporting"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Envelope Contents</span></td>
			<td><g:select from="${['ANSI','NARR','SWIF','UEDI']}" noSelection="['':'SELECT ONE']" name="envelopeContents" class="select_dropdown"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textArea class="textarea_long" name="envelopeContentsTextArea"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Remittance Information</span></td>
			<td><g:select from="${['INV','IPI','RFB','ROC','TSU']}" noSelection="['':'SELECT ONE']" name="remittanceInformation" class="select_dropdown"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textArea class="textarea_long" name="remittanceInformationTextArea"/></td>
		</tr>
	</table>
</g:elseif>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 103" onclick="goToViewMt(103)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />