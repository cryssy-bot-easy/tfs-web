<%@ page import="net.ipc.utils.DateUtils" %>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="mt103" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<table class="tabs_forms_table">
	<tr>
		<td colspan="2"> <span class="title_label">53<span class="title_label sendersCorrespondentOptionLetter"></span>: Sender's Correspondent </span> </td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="A" checked="${'A'.equals(sendersCorrespondentFlag)}"/>&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCode" id="senderIdentifierCode" value="${senderIdentifierCode}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="B" checked="${'B'.equals(sendersCorrespondentFlag)}"/>&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="senderLocation" value="${senderLocation}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Receiving Bank <span class="asterisk"> * </span> </span></td>
		<td>
			<%-- <g:select name="receivingBank" from="${['BANK1','BANK2']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${receivingBank}"/> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop required" name="receivingBank" id="receivingBank" value="${receivingBank}"/>
		</td> 
	</tr>
	<tr>
		<td><span class="field_label"> 20: Sender's Reference </span></td>
		<td><g:textField class="input_field" name="senderReference" value="${senderReference ?: documentNumber}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> 23: Bank Operation Code <span class="asterisk"> * </span> </span></td>
		<td>
            %{--<g:select name="bankOperationCode" value="${bankOperationCode}" from="${['BOC-1','BOC-2']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" />--}%
            <tfs:operationBankCode name="bankOperationCode" value="${bankOperationCode}" class="select_dropdown required" />
        </td>
	</tr>
	<g:if test="${serviceType?.equalsIgnoreCase('export advance refund') }">
		<tr>
			<td><span class="field_label">Transaction Type Code</span></td>
			<td><input class="tags_currency select2_dropdown bigdrop" name="transactionTypeCode" id="transactionTypeCode" value="${transactionTypeCode}"/></td>
		</tr>
	</g:if>
	<g:if test="${documentType?.equalsIgnoreCase('export') || documentClass?.equalsIgnoreCase('Collection') || documentClass?.equalsIgnoreCase('Purchase')}">
	<tr>
		<td><span class="field_label"> Value Date </span></td>
		<td><g:textField class="datepicker_field" name="valueDate" value="${valueDate}" readonly="readonly" /></td>
	</tr>
	</g:if>
	<g:else>
		<tr>
			<td><span class="field_label"> 32A: Value Date </span></td>
			<td><g:textField class="input_field" name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly" /></td>
		</tr>
	</g:else>
	<tr>
		<td><span class="field_label"> 32A: Currency </span></td>
		<td><g:textField class="input_field" name="currency" value="${currency ?: negotiationCurrency}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> 32A: Amount </span></td>
		<td><g:textField class="input_field numericCurrency" name="swiftAmount" value="" readonly="readonly" /></td>
	</tr>
	<g:if test="${documentClass == 'LC' && documentType == 'DOMESTIC' && serviceType?.equalsIgnoreCase('Negotiation')}"> <%-- if-else: Naging Read-Only lang sya --%>
		<tr>
			<td colspan="2"> <span class="title_label"> 50K: Ordering Customer</span> </td>
		</tr>
		<tr>
			<td><span class="field_label"> Account Number </span></td>
			<td>
                <g:textField name="orderingAccountNumber" class="input_field" value="${orderingAccountNumber}" />
                %{--<input class="tags_accountNumber select2_dropdown bigdrop" name="orderingAccountNumber" id="orderingAccountNumber" value="${orderingAccountNumber}"/>--}%
            </td>
		</tr>
		<tr>
			<td><span class="field_label"> Name</span></td>
			<td><g:textField name="orderingName" class="input_field" value="${orderingName}" /></td>
		</tr>
		<tr>
			<td class="vtop"><span class="field_label">Address<span class="asterisk">*</span></span></td>
			<td><g:textArea name="orderingAddress" class="textarea required" rows="4" readonly="readonly" value="${orderingAddress}"/>
				<input type="button" class="popup_btn_bottom" id="popup_btn_ordering_customer"></td>
		</tr>	
	</g:if>
	<g:else>
		<tr>
			<td colspan="2"> <span class="title_label"> 50K: Ordering Customer</span> </td>
		</tr>
		<tr>
			<td><span class="field_label"> Account Number </span></td>
			<td>
                <g:textField name="orderingAccountNumber" class="input_field" value="${orderingAccountNumber}"/>
                %{--<input class="tags_accountNumber select2_dropdown bigdrop" name="orderingAccountNumber" id="orderingAccountNumber" value="${orderingAccountNumber}"/>--}%
            </td>
		</tr>
		<tr>
			<td><span class="field_label"> Name</span></td>
			<td><g:textField name="orderingName" class="input_field" value="${orderingName}" /></td>
		</tr>
		<tr>
			<td class="vtop"><span class="field_label">Address<span class="asterisk">*</span></span></td>
			<td><g:textArea name="orderingAddress" class="textarea required" rows="4" readonly="readonly" value="${orderingAddress}"/>
				<input type="button" class="popup_btn_bottom" id="popup_btn_ordering_customer"></td>
		</tr>
	</g:else>
	<g:if test="${serviceType?.equalsIgnoreCase('export advance refund')}">
		%{--<tr>--}%
			%{--<td><span class="field_label">Sending Institution</span></td>--}%
            %{--<td> <input class="tags_bank select2_dropdown bigdrop" name="sendingInstitution" id="sendingInstitution" value="${sendingInstitution}"/> </td>--}%
		%{--</tr>--}%
		<tr>
			<td><span class="field_label">Ordering Institution </span></td>
		</tr>
		<tr>
			<td><g:radio name="orderingInstitutionFlag" value="1" /> Option A - <span class="field_label">SWIFT Code</span></td>
			<td><g:textField name="orderInstIdentifierCode" class="input_field" readonly="readonly" /></td>
		</tr>
		<tr>
			<td><g:radio name="orderingInstitutionFlag" value="2" /> Option D - <span class="field_label">Name and Address</span></td>
			<td><g:textArea name="bankNameAndAddress" class="textarea" rows="4" readonly="readonly" value="${bankNameAndAddress}"></g:textArea></td>
		</tr>
		<tr>
			<td><span class="field_label">Sender's Correspondent</span></td>
		</tr>
		<tr>
			<td><g:radio name="senderCorrespondentFlag" value="1" /> Option A - <span class="field_label">SWIFT Code</span></td>
			<td><g:textField name="swiftCodeSenderCorrespondent" class="input_field" readonly="readonly" /></td>
		</tr>
		<tr>
			<td><g:radio name="senderCorrespondentFlag" value="2" /> Option B - <span class="field_label">Location</span></td>
			<td><g:textArea name="locationSenderCorrespondent" class="textarea" rows="4" readonly="readonly"></g:textArea></td>
		</tr>
		<tr>
			<td><g:radio name="senderCorrespondentFlag" value="3" /> Option D - <span class="field_label">Name and Address</span></td>
			<td><g:textArea name="nameAndAddressSenderCorrespondent" class="textarea" rows="4" readonly="readonly"></g:textArea></td>
		</tr>
		<tr>
			<td><span class="field_label">Receiver's Correspondent</span></td>
		</tr>
		<tr>
			<td><g:radio name="receiversCorrespondentFlag" value="1" /> Option A - <span class="field_label">SWIFT Code</span></td>
			<td><g:textField name="swiftCodeReceiverCorrespondent" class="input_field" readonly="readonly" /></td>
		</tr>
		<tr>
			<td><g:radio name="receiversCorrespondentFlag" value="2" /> Option B - <span class="field_label">Location</span></td>
			<td><g:textArea name="locationReceiverCorrespondent" class="textarea" rows="4" readonly="readonly"></g:textArea></td>
		</tr>
		<tr>
			<td><g:radio name="receiversCorrespondentFlag" value="3" /> Option D - <span class="field_label">Name and Address</span></td>
			<td><g:textArea name="nameAndAddressReceiverCorrespondent" class="textarea" rows="4" readonly="readonly"></g:textArea></td>
		</tr>
		<tr>
			<td><span class="field_label">Intermediary</span></td>
		</tr>
		<tr>
			<td><g:radio name="intermediaryFlag" value="1" /> Option A - <span class="field_label">Swift Code</span></td>
			<td><g:textField name="swiftCodeIntermediary" class="input_field" readonly="readonly" /></td>
		</tr>
		<tr>
			<td><g:radio name="intermediaryFlag" value="2" /> Option B - <span class="field_label">Location</span></td>
			<td><g:textArea name="locationIntermediary" class="textarea" rows="4" readonly="readonly"></g:textArea></td>
		</tr>
		<tr>
			<td><g:radio name="intermediaryFlag" value="3" /> Option D - <span class="field_label">Name and Address</span></td>
			<td><g:textArea name="nameAndAddressIntermediary" class="textarea" rows="4" readonly="readonly"></g:textArea></td>
		</tr>
	</g:if>

	<tr>
		<td colspan="2"> <span class="title_label"> 57D: Account with Institution</span> </td>
	</tr>
	<tr>
		<td><span class="field_label">Identifier Code <span class="accountWithInstitutionAsterisk"></span></span></td>
<%--		<td><g:select name="accountWithInstitution" value="${accountWithInstitution}" class="select_dropdown" from="${['ACC-1','ACC-2']}" noSelection="['':'SELECT ONE...']" /></td>--%>
		<td><input name="accountWithInstitution" id="accountWithInstitution" class="tags_accountNumber select2_dropdown bigdrop" value="${accountWithInstitution}"/></td>
	</tr>
	<tr>
		<td class="vtop"><span class="field_label">Name and Address <span class="accountWithInstitutionAsterisk"></span></span></td>
		<td><g:textArea name="accountNameAndAddress" value="${accountNameAndAddress}" class="textarea" rows="4" readonly="readonly"/>
			<input type="button" class="popup_btn_bottom" id="popup_btn_account_institution"></td>
	</tr>
	<tr>
		<td colspan="2"> <span class="title_label"> 59: Beneficiary Customer </span> </td>
	</tr>
	<tr>
		<td><span class="field_label">Account Number</span></td>
		<td>
            <g:textField name="beneficiaryAccountNumber" value="${beneficiaryAccountNumber}" class="input_field" />
            %{--<input class="tags_accountNumber select2_dropdown bigdrop" name="beneficiaryAccountNumber" id="beneficiaryAccountNumber" value="${beneficiaryAccountNumber}"/>--}%
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Name<span class="asterisk">*</span></span></td>
		<td><g:textField name="beneficiaryName" value="${beneficiaryName ?: documentClass == 'DP' ? sellerName : ''}" class="input_field required" maxlength="60"/></td>
	</tr>
	<tr>
		<td class="vtop"><span class="field_label">Customer Address<span class="asterisk">*</span></span></td>
		<td><g:textArea name="beneficiaryAddress" value="${beneficiaryAddress ?: documentClass == 'DP' ? sellerAddress : ''}" class="textarea required" rows="4" /></td>
	</tr>
	<tr>
		<td><br/></td>
	</tr>
	<tr>
		<td><span class="field_label">60: Seller's Account Number</span></td>
		<td><g:textField name="sellersAccountNumber" value="${sellersAccountNumber}" class="input_field" maxlength="10" /></td>
	</tr>
	<tr>
		<td><span class="field_label">71A: Details of Charges<span class="asterisk">*</span></span></td>
		<td><g:select name="detailsOfCharges" value="${detailsOfCharges ?: 'SHA'}" class="select_dropdown required" from="${['SHA', 'BEN', 'OUR']}" noSelection="['':'SELECT ONE...']" /></td>
	</tr>
    <tr>
        <td> <span class="field_label"> 72: Sender to Receiver Information </span> </td>
        <td> 
        	<tfs:senderToReceiverType2 name="senderToReceiverInformation" value="${senderToReceiverInformation  ?: 'REC'}"/>
        </td>
    </tr>
    <tr>
        <td/>
        <td>
            <g:textArea class="textarea" name="senderToReceiverInformationTextArea" rows="6" readonly="readonly">${senderToReceiverInformationTextArea ?: 
				'PROCEEDS OF DM' + documentClass == 'DP' ? 'DP' : 'LC' + ' NEGO UNDER DM ' + 
				(lcNumber != null ? lcNumber.toString().replaceAll('-','') : documentNumber.toString().replaceAll('-',''))}</g:textArea>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="sender_infoMt103"> ... </a>
        </td>
    </tr>
</table>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 103" onclick="goToViewMt(103)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
	var searchCasaAccountsUrl2 = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
	searchCasaAccountsUrl2 += "?cifNumber="+$("#cifNumber").val() + "&currency="+$("#currency").val();
	var casaUserSearchUrl = "${g.createLink(controller: 'modeOfPayment', action: 'searchCasaAccountsByUser')}";

	var sendersCorrespondentFlag = "${sendersCorrespondentFlag}";
	
    $(document).ready(function() {
		<%-- $("#receivingBank").select2('data',{id: '${receivingBank}'}); --%>
        
        $("#receivingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${receivingBank}'});
		<%-- $("#orderingAccountNumber").setAccountNumberDropdown2($(this).attr("id")).select2('data',{id: '${orderingAccountNumber}'}); --%>
        <%-- $("#beneficiaryAccountNumber").setAccountNumberDropdown2($(this).attr("id")).select2('data',{id: '${beneficiaryAccountNumber}'}); --%>
        $("#senderIdentifierCode").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCode}'});
        //added
        $("#accountWithInstitution").setBankDropdown($(this).attr("id")).select2('data',{id: '${accountWithInstitution}'});

        if($("#documentType").val() == "DOMESTIC") {
        	$(".accountWithInstitutionAsterisk").removeClass("asterisk").text("");
        	$("#accountWithInstitution, #accountNameAndAddress").removeClass("required");
        } else {
        	$(".accountWithInstitutionAsterisk").addClass("asterisk").text("*");
        	$("#accountWithInstitution, #accountNameAndAddress").addClass("required");
        }
		
        $("#senderIdentifierCode").attr("readonly", "readonly");
    	$("#senderLocation").attr("readonly", "readonly");
    	
    	if(sendersCorrespondentFlag == 'A'){
    		$("#senderIdentifierCode").removeAttr("readonly");
    		$("#senderLocation").attr("readonly", "readonly");
    		
    	} else if(sendersCorrespondentFlag == 'B'){
    		$("#senderIdentifierCode").attr("readonly", "readonly");
    		$("#senderLocation").removeAttr("readonly");
    		
    	}

        $(".sendersCorrespondentOptionLetter").text("a");
        $(".sendersCorrespondentFlag").change(function(){
    		if($(this).val() == 'A'){
    			$("#senderIdentifierCode").removeAttr("readonly").select2("enable");
    			$("#senderLocation").val("");
    			$("#senderLocation").attr("readonly", "readonly");
    	        $(".sendersCorrespondentOptionLetter").text("A");
    						
    		} else if($(this).val() == 'B'){
    			$("#senderIdentifierCode").attr("readonly", "readonly");
    			$("#senderIdentifierCode").select2('data',{id: ''});
    			$("#senderIdentifierCode").select2("disable");
    			$("#senderLocation").removeAttr("readonly");
    	        $(".sendersCorrespondentOptionLetter").text("D");
    		} 
    	});

        $("#orderingAccountNumber").change(function(){
       		$.post(casaUserSearchUrl, {accountNumber : $(this).val()}, function(data){
       			if (data['status'] != 'ACTIVE') {
       				triggerAlertMessage('Account is not active.');
       				$("#orderingAccountNumber").val("");
       			}
       		});
        });
    });
</script>
<g:render template="../nonlc/commons/popups/textarea_popup"
	model="${[textAreaPopupId: 'popup_div_ordering_customer',
		 closeTextAreaBtnPopup: 'popup_close_ordering_customer',
		 textAreaHeader: 'Ordering Customer Address',
		 textAreaName: 'orderingCustomerAddressComment',
		 saveTextAreaBtnPopupId: 'orderingCustomerAddressPopupSave',
		 saveTextAreaBtnPopup: 'popup_save_ordering_customer',
		 textAreaPopupbg: 'popup_bg_ordering_customer',
		 textAreaScript:'popups/ordering_customer_utility.js']}" />
<g:render template="../nonlc/commons/popups/textarea_popup"
	model="${[textAreaPopupId: 'popup_div_account_institution',
		 closeTextAreaBtnPopup: 'popup_close_account_institution',
		 textAreaHeader: 'Account With Institution Name and Address',
		 textAreaName: 'accountWithInstitutionComment',
		 saveTextAreaBtnPopupId: 'accountWithInstitutionPopupSave',
		 saveTextAreaBtnPopup: 'popup_save_account_institution',
		 textAreaPopupbg: 'popup_bg_account_institution',
		 textAreaScript:'popups/account_institution_utility.js']}" />
<g:render template="../nonlc/commons/popups/textarea_popup"
	model="${[textAreaPopupId: 'sender_receiver_mt103_popup',
		 closeTextAreaBtnPopup: 'sender_receiver_mt103_close',
		 textAreaHeader: 'Sender to Receiver Information',
		 textAreaName: 'senderToReceiverInformationMt103Comment',
		 remainCharsTextArea: 'remainingCharacterSenderToReceiverMt103',
		 remainLinesTextArea: 'remainingLineSenderToReceiverMt103',
		 saveTextAreaBtnPopupId: 'senderToReceiverInformationMt103PopupSave',
		 saveTextAreaBtnPopup: 'sender_receiver_mt103_save',
		 textAreaPopupbg: 'sender_receiver_mt103_bg',
		 textAreaScript:'popups/sender_receiver_mt103_popup.js']}" />