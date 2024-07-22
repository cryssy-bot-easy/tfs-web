<script type="text/javascript">
    var documentFormatUrl = '${g.createLink(controller: "documentFormat", action: "displayDocumentFormat")}';
</script>

<g:javascript src="utilities/dataentry/commons/detailsForGuarantee.js"/>
<g:javascript src="utilities/dataentry/commons/detailsForGuarantee2.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="detailsOfGuarantee" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<%-- For other serviceType --%>
<g:if test="${serviceType != 'Amendment' || serviceType != 'Opening'}">
	<table class="tabs_forms_table">
		<tr>
			<td class="label_width"><span class="field_label">Format Type</span></td>
			<td>
				<%--<tfs:formatType name="formatType" class="select_dropdown" value="${formatType}" tagging="${standbyTagging}" disabled="${serviceType?.equalsIgnoreCase('Opening') ? 'false' : 'true'}"/>--%>
                <g:select name="formatType" class="select_dropdown" value="${formatType}" noSelection="['':'SELECT ONE...']" disabled="${serviceType?.equalsIgnoreCase('Opening') ? 'false' : 'true'}"
                	from="${['FORMAT-1', 'FORMAT-2', 'BIDDING SECURITY A', 'BIDDING SECURITY B', 'BIDDING SECURITY C', 'BIDDING SECURITY D',
						'BIDDING SECURITY E', 'BIDDING SECURITY F', 'BIDDING SECURITY G', 'BIDDING SECURITY H', 'BIDDING SECURITY I',
						'BIDDING SECURITY J', 'BIDDING SECURITY K', 'BIDDING SECURITY L', 'BIDDING SECURITY M', 'BIDDING SECURITY N',
						'ADVANCE PAYMENT', 'ADVANCE PAYMENT 2', 'ADVANCE PAYMENT 3', 'FAITHFUL PERFORMANCE 2', 'FAITHFUL PERFORMANCE ADVANCE PAYMENT',
						'FP 3', 'FP 4 STANDARD FORMAT', 'FP 5', 'FP 6', 'FP 7', 'FP STANDARD FORMAT 2', 'OTHERS 5', 'OTHERS', 'OTHERS STANDBY 3',
						'PAYMENT GUARANTY', 'PAYMENT GUARANTY 2', 'PAYMENT GUARANTY 3', 'PAYMENT GUARANTY 4', 'PERFORMANCE BOND', 'PERFORMANCE SECURITY 1',
						'PERFORMANCE SECURITY 2', 'PS 2', 'PS 3', 'PS 4', 'PS 6', 'PS 7', 'PS 8', 'PS 10', 'RELEASE RETENTION', 'RETENTION', 'RETENTION 2',
						'RETENTION 3', 'RETENTION 4', 'RETENTION 5', 'RETENTION 6', 'RETENTION MONEY 3', 'SURETY BOND', 'SURETY BOND 2', 'SURETY BOND 3',
						'WARRANTY BOND', 'WARRANTY BOND 2', 'WARRANTY SECURITY']}" 
					keys="${['FORMAT-1', 'FORMAT-2', 'BIDDING SECURITY A', 'BIDDING SECURITY B', 'BIDDING SECURITY C', 'BIDDING SECURITY D',
						'BIDDING SECURITY E', 'BIDDING SECURITY F', 'BIDDING SECURITY G', 'BIDDING SECURITY H', 'BIDDING SECURITY I',
						'BIDDING SECURITY J', 'BIDDING SECURITY K', 'BIDDING SECURITY L', 'BIDDING SECURITY M', 'BIDDING SECURITY N',
						'ADVANCE PAYMENT', 'ADVANCE PAYMENT 2', 'ADVANCE PAYMENT 3', 'FAITHFUL PERFORMANCE 2', 'FAITHFUL PERFORMANCE ADVANCE PAYMENT',
						'FP 3', 'FP 4 STANDARD FORMAT', 'FP 5', 'FP 6', 'FP 7', 'FP STANDARD FORMAT 2', 'OTHERS 5', 'OTHERS', 'OTHERS STANDBY 3',
						'PAYMENT GUARANTY', 'PAYMENT GUARANTY 2', 'PAYMENT GUARANTY 3', 'PAYMENT GUARANTY 4', 'PERFORMANCE BOND', 'PERFORMANCE SECURITY 1',
						'PERFORMANCE SECURITY 2', 'PS 2', 'PS 3', 'PS 4', 'PS 6', 'PS 7', 'PS 8', 'PS 10', 'RELEASE RETENTION', 'RETENTION', 'RETENTION 2',
						'RETENTION 3', 'RETENTION 4', 'RETENTION 5', 'RETENTION 6', 'RETENTION MONEY 3', 'SURETY BOND', 'SURETY BOND 2', 'SURETY BOND 3',
						'WARRANTY BOND', 'WARRANTY BOND 2', 'WARRANTY SECURITY']}"/>
            </td>
		</tr>
		<g:if test="${documentType != 'DOMESTIC'}">
			<tr valign="top">
				<td> <span class="field_label">Details of Guarantee<span class="asterisk">*</span> </span> </td>
				<td id="test02">
					<g:textArea name="detailsOfGuaranteeDisplay2" id = "detailsOfGuaranteeDisplay2" class="textarea txtAreaDetailsOfGuarantee" value="${detailsOfGuarantee}"  contenteditable="${serviceType?.equalsIgnoreCase('Opening') ? 'true' : 'false'}" rows = "200" col = "300" style="width: 600px;height: 450px;font: 11px Calibri, Arial, Myriad Pro, Verdana, sans-serif;" ></g:textArea>
					<g:hiddenField name="detailsOfGuaranteeDisplay" id = "detailsOfGuaranteeDisplay" class="textarea" contenteditable="${serviceType?.equalsIgnoreCase('Opening') ? 'true' : 'false'}" rows = "200" col = "300" style="width: 600px;height: 200px;font: 11px Calibri, Arial, Myriad Pro, Verdana, sans-serif;">${detailsOfGuarantee}</g:hiddenField>
					<g:hiddenField name="detailsOfGuarantee" id="detailsOfGuarantee" value="${detailsOfGuarantee}" class="required" />
				</td>
			</tr>
			
			
		</g:if>
		<g:if test="${documentType != 'DOMESTIC' && !documentSubType1?.equalsIgnoreCase('STANDBY')}">
			<tr>
				<td class="label_width top" rowspan="2"><span class="field_label"> Sender to Receiver </span><br /><span class="field_label"> Information </span></td>
				<td class="input_width">
					<tfs:senderToReceiverType1 name="senderToReceiverInformation" value="${senderToReceiverInformation}"/>
				</td>
			</tr>
		</g:if>
		<g:if test="${documentType == 'DOMESTIC' && documentSubType1 == 'STANDBY' && serviceType == 'Opening'}">
			<tr class="showBiddingDate">
				<td class="label_width"><span class="field_label">Bidding Date</span></td>
				<td class="input_width"><g:textField name="biddingDate" class="datepicker_field" value="${biddingDate ?: ''}"/></td>
			</tr>
			<tr class="showBidInvitationNumber">
				<td class="label_width"><span class="field_label">Bid Invitation Number</span></td>
				<td class="input_width"><g:textField name="bidInvitationNumber" class="input_field" value="${bidInvitationNumber ?: ''}"/></td>
			</tr>
			<tr class="showBidInvitationDate">
				<td class="label_width"><span class="field_label">Bid Invitation Date</span></td>
				<td class="input_width"><g:textField name="bidInvitationDate" class="datepicker_field" value="${bidInvitationDate ?: ''}"/></td>
			</tr>
			<tr class="showContractLocation">
				<td class="label_width valign_top"><span class="field_label">Contract Location</span></td>
				<td class="input_width"><g:textArea name="contractLocation" class="textarea" value="${contractLocation ?: ''}" rows="4"/></td>
			</tr>
			<tr class="showAttentionName">
				<td class="label_width"><span class="field_label">Attention Name</span></td>
				<td class="input_width"><g:textField name="attentionName" class="input_field" value="${attentionName ?: ''}"/></td>
			</tr>
			<tr class="showAttentionNamePosition">
				<td class="label_width"><span class="field_label">Attention Name Position</span></td>
				<td class="input_width"><g:textField name="attentionNamePosition" class="input_field" value="${attentionNamePosition ?: ''}"/></td>
			</tr>
			<tr class="showBank">
				<td class="label_width"><span class="field_label">Bank</span></td>
				<td class="input_width"><g:textField name="bank" class="input_field" value="${bank ?: ''}"/></td>
			</tr>
			<tr class="showBankBranch">
				<td class="label_width"><span class="field_label">Bank Branch</span></td>
				<td class="input_width"><g:textField name="bankBranch" class="input_field" value="${bankBranch ?: ''}"/></td>
			</tr>
			<tr class="showBankAddress">
				<td class="label_width valign_top"><span class="field_label">Bank Address</span></td>
				<td class="input_width"><g:textArea name="bankAddress" class="textarea" value="${bankAddress ?: ''}" rows="4"/></td>
			</tr>
			<tr class="showCity">
				<td class="label_width"><span class="field_label">City</span></td>
				<td class="input_width"><g:textField name="city" class="input_field" value="${city ?: ''}"/></td>
			</tr>
			<tr class="showProprietor">
				<td class="label_width"><span class="field_label">Proprietor</span></td>
				<td class="input_width"><g:textField name="proprietor" class="input_field" value="${proprietor ?: ''}"/></td>
			</tr>
			<tr class="showProprietorPosition">
				<td class="label_width"><span class="field_label">Proprietor Position</span></td>
				<td class="input_width"><g:textField name="proprietorPosition" class="input_field" value="${proprietorPosition ?: ''}"/></td>
			</tr>
			<tr class="showAuthorizedSignatory1">
				<td class="label_width"><span class="field_label">Authorized Signatory 1</span></td>
				<td class="input_width"><g:textField name="authorizedSignatory1" class="input_field" value="${authorizedSignatory1 ?: ''}"/></td>
			</tr>
			<tr class="showAuthorizedSignatoryPosition1">
				<td class="label_width"><span class="field_label">Authorized Signatory Position 1</span></td>
				<td class="input_width"><g:textField name="authorizedSignatoryPosition1" class="input_field" value="${authorizedSignatoryPosition1 ?: ''}"/></td>
			</tr>
			<tr class="showAuthorizedSignatory2">
				<td class="label_width"><span class="field_label">Authorized Signatory 2</span></td>
				<td class="input_width"><g:textField name="authorizedSignatory2" class="input_field" value="${authorizedSignatory2 ?: ''}"/></td>
			</tr>
			<tr class="showAuthorizedSignatoryPosition2">
				<td class="label_width"><span class="field_label">Authorized Signatory Position 2</span></td>
				<td class="input_width"><g:textField name="authorizedSignatoryPosition2" class="input_field" value="${authorizedSignatoryPosition2 ?: ''}"/></td>
			</tr>
		</g:if>
	</table>
</g:if>

<%-- For serviceType Amendment--%>
<%--
<g:if test="${serviceType == 'Amendment'}">
	<table class="tabs_forms_table">
		<tr>
			<td class="td1">
                <g:checkBox name="detailsGuarantee"/>
            </td>
			<td> <span class="field_label"> Format Type </span> </td>
			<td width="195">                
                <g:textField name="formatTypeFrom" class="select_dropdown" value="${formatType}" readonly="readonly" />
            </td>
            <td colspan="3"> 
			  To: 
			  <tfs:formatType name="formatTypeTo" class="select_dropdown" value="${formatTypeTo}"/>
			</td>
		</tr>
		<tr>
			<td class="td1">%{--<g:checkBox name="detailsGuarantee"/>--}%</td>
			<td colspan="4"><span class="field_label">Details of Guarantee</span></td>
		</tr>		
		<tr>
			<td></td>
			<td valign="top"><span class="field_label">From:</span></td>
			<td><g:textArea name="detailsGuaranteeFrom" class="text_area3" readonly="readonly" value="${detailsGuaranteeFrom ?: detailsGuarantee}"/></td>
			<td class="col_span">&#160;</td>
			<td class="td1" valign="top"><span class="field_label">To:</span></td>
			<td><g:textArea name="detailsGuaranteeTo" class="text_area3" value="${detailsGuaranteeTo}"/></td>
		</tr>		
		<g:if test="${!(documentType?.equalsIgnoreCase('Foreign') && documentSubType1?.equalsIgnoreCase('Standby'))}">
			<tr>
				<td>
					<g:checkBox  name="senderToReceiverSwitchDisplay"/>
					<g:hiddenField name="senderToReceiverSwitch" value="${senderToReceiverSwitch ?: 'off'}"/>
				</td>
				<td><span class="field_label">Sender to Receiver Information</span></td>
				<td><g:select name="senderToReceiverFrom" value="${senderToReceiverFrom ?: senderToReceiver}" from="${['BENCON', 'PHONBEN', 'TELEBEN']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" disabled="true"/></td>
				<td colspan="3"> 
					To: 
					<g:select name="senderToReceiverTo" value="${senderToReceiverTo}" from="${['BENCON', 'PHONBEN', 'TELEBEN']}" noSelection="['':'SELECT ONE...']"  class="select_dropdown" />
				</td>
			</tr>	
			<tr>
				<td colspan="2">&#160;</td>
				<td><g:textArea name="senderToReceiverInformationFrom" value="${senderToReceiverInformationFrom ?: senderToReceiverInformation}" class="textarea" rows="4" readonly="readonly" /></td>
				<td colspan="3"> 
					&#160;&#160;&#160;&#160;&#160; 
					<g:textArea name="senderToReceiverInformationTo" class="textarea" rows="4" value="${senderToReceiverInformationTo}"/>
		            <input type="button" class="popup_btn_bottom" id="sender_info">
				</td>
			</tr>
		</g:if>	
	</table>
</g:if>
--%>
<br/>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/sender_receiver_popup" />
<g:javascript src="popups/sender_receiver_popup.js" />
<script type="text/javascript">
$(document).ready(function() {

	if(documentType == "DOMESTIC") {
		$("#formatType option[value='FORMAT-1']").each(function() {
			$(this).remove();
		});
		$("#formatType option[value='FORMAT-2']").each(function() {
			$(this).remove();
		});
	} if (documentType == "FOREIGN") {
		$("#formatType option[value!='']").each(function() {
			$(this).remove();
		});
		 $("#formatType").append("<option value='FORMAT-1'>FORMAT-1</option>");
		 $("#formatType").append("<option value='FORMAT-2'>FORMAT-2</option>");
	}
});
</script>