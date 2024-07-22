<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt103" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:javascript src="utilities/commons/textarea_utility.js" />
<g:javascript src="utilities/nonlc/mt103_utils.js"/>
<g:javascript src="utilities/nonlc/textarea_popup_utilities.js"/>
<%--<g:javascript src="utilities/nonlc/mt103_validation.js"/>--%>

<%--<g:if test="${documentClass?.equalsIgnoreCase('DP')}">
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

--%><%--<g:elseif test="${documentClass?.equalsIgnoreCase('DR') || documentClass?.equalsIgnoreCase('OA')}">--%>

	<table class="tabs_forms_table">
		<tr>
			<td class="input_width"><span class="field_label">32A: Value Date/Currency/Interbank Settle Amount</span></td>
			<td>
				<g:textField name="valueDate" class="input_field" readonly="readonly" value="${valueDate ?: etsDate}"/>
				<g:textField name="currency" class="input_field_short" readonly="readonly" value="${currency}"/>
				<g:textField name="swiftAmount" class="input_field_right numericCurrency" readonly="readonly" value="${swiftAmount ?: productAmount ?: amount}"/>
			</td>
		</tr>
		<tr>
			<td><span class="field_label">33B: Settlement Currency/Settlement Amount</span></td>
			<td>
				<g:textField name="settlementCurrencyMT103" class="input_field" value="${settlementCurrencyMT103}" maxlength="3"/>
				<g:textField name="settlementAmountMT103" class="input_field_right numericCurrency" value="${settlementAmountMT103}"/>
			</td>
		</tr>
		<tr>
			<td><span class="title_label">59: Beneficiary Customer</span></td>
			<td></td>
		</tr>
		<tr>
			<td><span class="field_label">Beneficiary Account Number</span></td>
			<td><g:textField name="beneficiaryAccountNumber" class="input_field" readonly="readonly" value="${beneficiaryAccountNumber}"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Beneficiary Name</span></td>
			<td><g:textField name="beneficiaryName" class="input_field" readonly="readonly" value="${beneficiaryName}"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Beneficiary Address</span></td>
			<td><g:textArea name="beneficiaryAddress" class="textarea" readonly="readonly" value="${beneficiaryAddress}" rows="4"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> 20: Document Number </span></td>
			<td><g:textField class="input_field" name="documentNumberMT103" value="${documentNumber}" readonly="readonly"/></td>
		</tr>
<%--		<tr>--%>
<%--			<td><span class="field_label"> 33B: Settlement Amount </span></td>--%>
<%--			<td><g:textField class="input_field_right numericCurrency" name="settlementAmountMT103" value="${productAmount}" readonly="readonly"/></td>--%>
<%--		</tr>--%>
		<tr>
			<td><span class="field_label"> 13C: Time Indication </span></td>
			<td>
				<g:select from="${['CLSTIME','RNCTIME','SNDTIME']}" noSelection="['':'SELECT ONE']" name="timeIndication" class="select_dropdown" value="${timeIndication}"/>
				<g:textField class="input_field" name="timeIndicationField" value="${timeIndicationField}"/>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 23B: Bank Operation Code <span class="asterisk">*</span> </span></td>
			<td><g:select from="${['CRED','SPAY','SPRI','SSTD']}" noSelection="['':'SELECT ONE']" name="bankOperationCode" class="select_dropdown required" value="${bankOperationCode ?: 'CRED'}"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> 23E: Instruction Code </span></td>
			<td>
				<g:select from="${['SDVA','INTC','REPA','CORT','HOLP','CHQB','PHOB','TELB','PHON','TELE','PHOI','TELI']}" 
					noSelection="['':'SELECT ONE']" name="instructionCode" class="select_dropdown" value="${instructionCode}" disabled="${bankOperationCode in ['SPAY','SSTD']}"/> 
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<g:textArea class="textarea" name="bankOperationTextArea" value="${bankOperationTextArea}" rows="4" readonly="readonly"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_instruction_code">...</a>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 26T: Transaction Type Code </span></td>
			<td><input class="tags_currency select2_dropdown bigdrop" name="transactionTypeCode" id="transactionTypeCode" value="${transactionTypeCode}"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> 50K:Importer Account Number<span class="asterisk">*</span></span></td>
			<td>
                <g:textField name="importerAccountNumber" class="input_field required" value="${importerAccountNumber}" />
            </td>
		</tr>
		<tr>
			<td><span class="field_label">Importer Name </span></td>
			<td>
				<g:textArea class="textarea" name="importerNameMT103" value="${importerName}" rows="2" readonly="readonly" maxlength="60"/>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> Importer Address </span></td>
			<td><g:textArea class="textarea" name="importerAddressMT103" value="${importerAddress}" rows="4" readonly="readonly"/></td>
		</tr>
		<tr>
			<td colspan="2"> <span class="title_label">52<span class="orderingInstitutionMt103OptionLetter title_label"></span>: Ordering Institution </span></td>
		</tr>
<%--		<tr>--%>
<%--			<td>--%>
<%--				<span class="field_label small_margin_left">--%>
<%--					Party Identifier--%>
<%--				</span>--%>
<%--			</td>--%>
<%--			<td><g:textField class="input_field" name="orderingInstitutionPartyIdentifier" value="${orderingInstitutionPartyIdentifier}" /></td>--%>
<%--		</tr>--%>
		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="orderingBankFlag" class="orderingBankFlag" value="A" checked="${'A'.equals(orderingBankFlag)}" />
					&#160;&#160;Identifier Code
				</span>
			</td>
			<td><input class="tags_bank select2_dropdown bigdrop" name="orderInstIdentifierCode" id="orderInstIdentifierCode" value="${orderInstIdentifierCode}"/></td>
		</tr>
		<tr>
			<td class="valign_top">
				<span class="field_label small_margin_left">
					<g:radio name="orderingBankFlag" class="orderingBankFlag" value="D" checked="${'D'.equals(orderingBankFlag)}" />
					&#160;&#160;Name and Address
				</span>
			</td>
			<td>
				<g:textArea class="textarea" name="bankNameAndAddress" value="${bankNameAndAddress}" rows="4" readonly="readonly"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_ordering_bank">...</a> 
			</td>
		</tr>
		<tr>
			<td colspan="2"> <span class="title_label">53<span class="sendersCorrespondentMt103OptionLetter title_label"></span>: Sender's Correspondent <span class="asterisk">*</span> </span></td>
		</tr>
<!--		<tr>
			<td>
				<span class="field_label small_margin_left">
					Party Identifier
				</span>
			</td>
			<td><g:textField class="input_field" name="sendersPartyIdentifier" value="${sendersPartyIdentifier}" /></td>
		</tr>  -->

		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag sendersCorrespondentFlagA" value="A" checked="${'A'.equals(sendersCorrespondentFlag)}"/>
					&#160;&#160;Identifier Code
				</span>
			</td>
			<td><input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCode" id="senderIdentifierCode" value="${senderIdentifierCode ?: reimbursingBank}"/></td>
		</tr>
		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag sendersCorrespondentFlagB" value="B" checked="${sendersCorrespondentFlag!=null ? 'B'.equals(sendersCorrespondentFlag) : (reimbursingBank!=null ? true : false)}"/>
					&#160;&#160;Location
				</span>
			</td>
			<td><g:textField class="input_field" name="sendersLocation" value="${sendersLocation}"/></td>
		</tr>
		<tr>
			<td class="valign_top">
				<span class="field_label small_margin_left">
					<g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag sendersCorrespondentFlagD" value="D" checked="${'D'.equals(sendersCorrespondentFlag)}"/>
					&#160;&#160;Name and Address
				</span>
			</td>
			<td>
				<g:textArea class="textarea" name="senderNameAndAddress" value="${senderNameAndAddress}" readonly="readonly" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_sender_correspondent">...</a>
			</td>
		</tr>
		<tr>
			<td colspan="2"> <span class="title_label">54<span class="receiversCorrespondentMt103OptionLetter title_label"></span>: Receiver's Correspondent </span></td>
		</tr>
		<!-- 
		<tr>
			<td>
				<span class="field_label small_margin_left">
					Party Identifier
				</span>
			</td>
			<td><g:textField class="input_field" name="receiverPartyIdentifier" value="${receiverPartyIdentifier}" /></td>
		</tr> -->
		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="A" checked="${'A'.equals(receiversCorrespondentFlag)}" />
					&#160;&#160;Identifier Code
				</span>
			</td>
			<td><input class="tags_bank select2_dropdown bigdrop" name="receiverCorrIdentifierCode" id="receiverCorrIdentifierCode" value="${receiverCorrIdentifierCode}"/></td>
		</tr>
		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="B" checked="${'B'.equals(receiversCorrespondentFlag)}" />
					&#160;&#160;Location
				</span>
			</td>
			<td><g:textField class="input_field" name="receiverLocation" value="${receiverLocation}" /></td>
		</tr>
		<tr>
			<td class="valign_top">
				<span class="field_label small_margin_left">
					<g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="D" checked="${'D'.equals(receiversCorrespondentFlag)}" />
					&#160;&#160;Name and Address
				</span>
			</td>
			<td>
				<g:textArea class="textarea" name="receiverNameAndAddress" value="${receiverNameAndAddress}" readonly="readonly" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_receiver_correspondent">...</a>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 55a: Third Reimbursement Institution </span></td>
			<td><input class="tags_bank select2_dropdown bigdrop" name="thirdReimbursementInstitution" id="thirdReimbursementInstitution" value="${thirdReimbursementInstitution}"/></td>
		</tr>
		<tr><td>&#160;</td></tr>
		<tr>
			<td colspan="2"> <span class="title_label">56<span class="intermediaryMt103OptionLetter title_label"></span>: Intermediary </span></td>
		</tr>
		<!-- 
		<tr>
			<td>
				<span class="field_label small_margin_left">
					Party Identifier
				</span>
			</td>
			<td><g:textField class="input_field" name="intermediaryPartyIdentifier" value="${intermediaryPartyIdentifier}" /></td>
		</tr> -->
		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="intermediaryFlag" class="intermediaryFlag" value="A" checked="${'A'.equals(intermediaryFlag)}" />
					&#160;&#160;Identifier Code
				</span>
			</td>
			<td><input class="tags_bank select2_dropdown bigdrop" name="intermedIdentifierCode" id="intermedIdentifierCode" value="${intermedIdentifierCode}"/></td>
		</tr>
		<tr>
			<td class="valign_top">
				<span class="field_label small_margin_left">
					<g:radio name="intermediaryFlag" class="intermediaryFlag" value="D" checked="${'D'.equals(intermediaryFlag)}" />
					&#160;&#160;Name and Address
				</span>
			</td>
			<td>
				<g:textArea class="textarea" name="intermediaryNameAndAddressMt" value="${intermediaryNameAndAddressMt}" rows="4" readonly="readonly"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_intermediary">...</a>
				</td>
		</tr>
		<tr>
			<td colspan="2"> <span class="title_label">57<span class="accountWithInstitutionMt103OptionLetter title_label"></span>: Account with Institution </span></td>
		</tr>
		<!-- 
		<tr>
			<td>
				<span class="field_label small_margin_left">
					Party Identifier
				</span>
			</td>
			<td><g:textField class="input_field" name="acctWithInstPartyIdentifier" value="${acctWithInstPartyIdentifier}" /></td>
		</tr>
		 -->
		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="A" checked="${'A'.equals(accountWithBankFlag)}" />
					&#160;&#160;Identifier Code
				</span>
			</td>
			<td><input class="tags_bank select2_dropdown bigdrop" name="acctWithInstIdentifierCode" id="acctWithInstIdentifierCode" value="${acctWithInstIdentifierCode}"/></td>
		</tr>
		<tr>
			<td>
				<span class="field_label small_margin_left">
					<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="B" checked="${'B'.equals(accountWithBankFlag)}" />
					&#160;&#160;Location
				</span>
			</td>
			<td><g:textField class="input_field" name="accountLocation" value="${accountLocation}"/></td>	
		</tr>
		<tr>
			<td class="valign_top">
				<span class="field_label small_margin_left">
					<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="D" checked="${'D'.equals(accountWithBankFlag)}" />
					&#160;&#160;Name and Address
				</span>
			</td>
			<td>
				<g:textArea class="textarea" name="accountNameAndAddress" value="${accountNameAndAddress}" rows="4" readonly="readonly"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_account_with_bank">...</a>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 70: Remittance Information </span></td>
			<td><g:select from="${['INV','RFB','BU','IPI','ROC']}" noSelection="['':'SELECT ONE']" name="remittanceInformation" class="select_dropdown" value="${remittanceInformation}"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<g:textArea class="textarea" name="remittanceInformationTextArea" value="${remittanceInformationTextArea}" rows="4" readonly="readonly"/>
				<a href="javascript:void(0)" class="search_btn" id="popup_btn_remittanceInformation"> Search/Look-up Button </a>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 71A: Details of Charges <span class="asterisk">*</span> </span></td>
			<td><g:select name="detailsOfCharges" value="${detailsOfCharges}" from="${['BEN','OUR','SHA']}" class="select_dropdown required" noSelection="['':'SELECT ONE']"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> 71F: Sender's Charges </span></td>
			<td>
				<input class="tags_currency select2_dropdown bigdrop" name="senderChargesCurrency" id="senderChargesCurrency" />
				<%-- <g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="senderChargesCurrency" class="select_dropdown" value="${senderChargesCurrency}"/> --%>
				<g:textField class="input_field_right numericCurrency" name="senderCharges" value="${senderCharges}"/>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 71G: Receiver's Charges </span></td>
			<td>
				<g:textField class="input_field" name="receiverChargesCurrency" value="${currency}" readonly="readonly"/>
				<%-- <g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="receiverChargesCurrency" class="select_dropdown" value="${receiverChargesCurrency}"/> --%>
				<g:textField class="input_field_right numericCurrency" name="receiverCharges" value="${receiverCharges}"/>
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 72: Sender to Receiver Information </span></td>
			<td>
				<tfs:senderToReceiverType2 name="senderToReceiverInformation" value="${senderToReceiverInformation}"/>
			</td>
		</tr>
		<tr>
			<td/>
			<td>
				<g:textArea class="textarea" name="senderToReceiverInformationTextArea" value="${senderToReceiverInformationTextArea}" rows="6" readonly="readonly"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="sender_infoMt103"> ... </a>			
			</td>
		</tr>
		<tr>
			<td><span class="field_label"> 77B: Regulatory Reporting </span></td>			
			<td><g:select name="regulatoryReporting" value="${regulatoryReporting}" from="${['BENEFRES','ORDRRES']}" class="select_dropdown" noSelection="['':'SELECT ONE']"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<g:textArea class="textarea" name="regulatoryReportingTextArea" value="${regulatoryReportingTextArea}" rows="4" readonly="readonly"/>
				<a href="javascript:void(0)" class="search_btn" id="popup_btn_regulatoryReporting"> Search/Look-up Button </a>
			</td>
		</tr>
	</table>

<%--</g:elseif>--%>
<g:render template="../commons/popups/textarea_popup" />
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 103" onclick="goToViewMt(103)"/>
		</td>
	</tr>		
</table>
<g:if test="${documentClass.equalsIgnoreCase('IMPORT_ADVANCE')}">
	<table class="buttons_for_grid_wrapper saveButtonsContainer">
	    <tr>
	        <td><input type="button" id="saveConfirmMtDetails" class="input_button" value="Save" /></td>
	    </tr>
	    <tr>
	        <td><input type="button" id="cancelConfirmMtDetails" class="input_button_negative" value="Cancel" /></td>
	    </tr>
	</table>
</g:if>
<g:else>
	<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:else>

<script>
	var sendersCorrespondentFlag = "${sendersCorrespondentFlag}";
	jQuery.fn.setTransactionTypeCode = function() {
	
	    var elementName = '#'+this.attr("id");
	
	    $(elementName).select2({
	        minimumInputLength: 2,
	        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
	            url: transactionTypeCodeAutoCompleteUrl,
	            dataType: 'json',
	            data: function (term, page, type) {
	                return {
	                    //featureClass: "P",
	                    //q: term, // search term
	                    type: "FX",
	                    starts_with: term,
	                    page_limit: 10//,
	                    //apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
	                };
	            },
	            results: function (data, page) { // parse the results into the format expected by Select2.
	                //since we are using custom formatting functions we do not need to alter remote JSON data
	                var more = (page * 10) < data.total; // whether or not there are more results available
	
	                // notice we return the value of more so Select2 knows if more results can be loaded
	                return {results: data.results, more: more};
	
	            }
	        },
	        formatResult: formatResultTransactionTypeCode, // omitted for brevity, see the source of this page
	        formatSelection: formatSelectionTransactionTypeCode, // omitted for brevity, see the source of this page
	        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	    });
	
	    return this;
	}
	
	function formatResultTransactionTypeCode(result) {
	
	    var markup = '<table><tr><td>';
	    markup += '<div>' + result.label + '</div>';
	    markup += '<div class="autocomplete_id_below">' + result.id + '</div>';
	    markup += '</td></tr></table>';
	    return markup;
	}
	
	function formatSelectionTransactionTypeCode(result) {
	    return result.id;
	}
    
    var transactionTypeCodeAutoCompleteUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteTransactionTypeCode")}';
	
	$(document).ready(function(){
		$("#senderIdentifierCode").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCode}'});
		%{--$("#sendingInstitution").setBankDropdown($(this).attr("id")).select2('data',{id: '${sendingInstitution}'});--}%
		$("#thirdReimbursementInstitution").setBankDropdown($(this).attr("id")).select2('data',{id: '${thirdReimbursementInstitution}'});
		$("#orderInstIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${orderInstIdentifierCode}'});
		$("#receiverCorrIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverCorrIdentifierCode}'});
		$("#intermedIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${intermedIdentifierCode}'});
		$("#acctWithInstIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${acctWithInstIdentifierCode}'});
	
		$("#senderChargesCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${senderChargesCurrency}'});
		
		$("#transactionTypeCode").setTransactionTypeCode($(this).attr("id")).select2('data',{id: '${transactionTypeCode}'});
		
		$("#saveConfirmMtDetails").click(function() {
			if('undefined' !== typeof validateExportTab){
	            if(validateExportTab("#mtDetailsTabForm") > 0){
	                $("#alertMessage").text("Please fill in all the required fields.");
	                triggerAlert();
	            } else {
	                $(".saveAction").show();
	                $(".cancelAction").hide();
	                $("#mtDetailsTabForm").submit();
	            }
			}
        });



        $("#cancelConfirmMtDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#mtDetailsDiv"), $("#mtDetailsBg"));
            mLoadPopup($("#mtDetailsDiv"), $("#mtDetailsBg"));
        });


	});
</script>

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