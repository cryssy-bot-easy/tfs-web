<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="actualCorresMt202" />

<g:javascript src="temp/utilities/actual_corres_mt202_utilities.js"/>

<span class="title_label">MT202</span>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Related Reference</span></td>
		<td class="input_width"><g:textField name="relatedReference" class="input_field disableThis"/></td>
		<td class="label_width"></td>
		<td class="input_width"></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Ordering Institution <span class="asterisk">*</span></span></td>
		<td><g:textField name="orderingInstitution" class="input_field disableThis" value="${grailsApplication.config.tfs.constants.sender.address + grailsApplication.config.tfs.constants.sender.suffix}"/></td>
		<td class="label_width"></td>
		<td></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">Account with Insitution</span></td>
		<td class="label_width"></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="accountWithInstitutionOption" class="senderOptionA disableThis2" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeAccountInstitution" class="input_field disableMe" readonly="readonly"/></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="accountWithInstitutionOption" class="senderOptionA disableThis2" value="B"/>
				<span>Option-B Location</span>
			</span>
		</td>
		<td><g:textField name="locationAccountInstitution" class="input_field disableMe" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="accountWithInstitutionOption" class="senderOptionD disableThis2" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td colspan="2"><div><g:textArea name="nameAndAddressAccountInstitution" class="disableMe" rows="4" cols="37" readonly="readonly"></g:textArea></div>
		</td>
	</tr>
	
	
	<tr>
		<td><span class="field_label title_label">Sender's Correspondent <span class="asterisk">*</span></span></td>
		<td class="label_width"></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="sendersCorrespondentOption" class="senderOptionA disableThis2" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeSenderCorrespond" class="input_field disableMe" readonly="readonly"/></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="sendersCorrespondentOption" class="senderOptionA disableThis2" value="B"/>
				<span>Option-B Location</span>
			</span>
		</td>
		<td><g:textField name="locationSenderCorrespond" class="input_field disableMe" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="sendersCorrespondentOption" class="senderOptionD disableThis2" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td colspan="2"><div><g:textArea name="nameAndAddressSenderCorrespond" class="disableMe" rows="4" cols="37" readonly="readonly"></g:textArea></div>
		</td>
	</tr>
	
	
	<tr>
		<td><span class="field_label title_label">Receiver's Correspondent</span></td>
		<td></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="receiverCorrespondentOption" class="senderOptionA disableThis2" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeReceiverCorrespond" class="input_field disableMe" readonly="readonly"/></td>	
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="receiverCorrespondentOption" class="senderOptionA disableThis2" value="B"/>
				<span>Option-B Location</span>
			</span>
		</td>
		<td><g:textField name="locationReceiverCorrespond" class="input_field disableMe" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="receiverCorrespondentOption" class="senderOptionD disableThis2" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td colspan="2"><div><g:textArea name="nameAndAddressReceiverCorrespond" class="disableMe" rows="4" cols="37" readonly="readonly"></g:textArea></div>
		</td>
	</tr>
	
	
	<tr>
		<td><span class="field_label title_label">Beneficiary's Institution <span class="asterisk">*</span></span></td>
		<td></td>
	</tr>	
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="benificiaryInstitutionOption" class="senderOptionA disableThis2" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeBeneficiaryInstitution" class="input_field disableMe" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="benificiaryInstitutionOption" class="senderOptionD disableThis2" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td valign="top" colspan="2">
			<div><g:textArea name="nameAndAddressBeneficiaryInstitution" class="disableMe" rows="4" cols="37" readonly="readonly"/></div>
		</td>
	</tr>
	
	
	<tr>
		<td><span class="field_label title_label">Intermediary</span></td>
		<td></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="intermediaryOption" class="senderOptionA disableThis2" value="A"/>
				<span>Option-A Swift Code</span>
			</span>
		</td>
		<td><g:textField name="identifierCodeIntermediary" class="input_field disableMe" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label small_margin_left">
				<g:radio name="intermediaryOption" class="senderOptionD disableThis2" value="D"/>
				<span>Option-D<br/>
					<span class="margin_left">Name and Address</span>
				</span>
			</span>
		</td>
		<td colspan="2"><div><g:textArea name="nameAndAddressIntermediary" class="disableMe" rows="4" cols="37" readonly="readonly"/></div>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<span class="field_label title_label">Sender to Receiver </span><br/>
			<span class="field_label title_label">Information </span>
		</td>
		<td><g:textArea name="senderReceiverInformation" class="disableMe" rows="6" cols="37" readonly="readonly"></g:textArea></td>
		<td valign="bottom">&#160;<input type="button" class="popup_btn" id="sender_info"/></td>
		
	</tr>
</table>
<br/>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />