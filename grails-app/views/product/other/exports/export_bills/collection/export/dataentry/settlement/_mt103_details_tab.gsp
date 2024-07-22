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
        <td><span class="field_label">Sender's Correspondent</span></td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="A" checked="${sendersCorrespondentFlag.equals('A')}"/>&#160;&#160;Identifier Code</span></td>
        <td>
            <input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCode" id="senderIdentifierCode" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="B" checked="${sendersCorrespondentFlag.equals('B')}"/>&#160;&#160;Location</span></td>
        <td><g:textField class="input_field" name="senderLocation" value="${senderLocation}"/></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Receiving Bank <span class="asterisk"> * </span> </span></td>
        <td>
            <input class="tags_bank select2_dropdown bigdrop" name="receivingBank" id="receivingBank" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label"> Sender's Reference </span></td>
        <td><g:textField class="input_field" name="senderReference" value="${senderReference}" readonly="readonly" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> Bank Operation Code <span class="asterisk"> * </span> </span></td>
        <td>
            <tfs:operationBankCode name="bankOperationCode" value="${bankOperationCode}" class="select_dropdown" />
        </td>
    </tr>
    <g:if test="${serviceType?.equalsIgnoreCase('export advance refund') }">
        <tr>
            <td><span class="field_label">Transaction Type Code</span></td>
            <td><g:select name="transactionTypeCode" class="select_dropdown" from="" noSelection="['':'SELECT ONE...']" /></td>
        </tr>
    </g:if>
    <g:if test="${documentType?.equalsIgnoreCase('export') || documentClass?.equalsIgnoreCase('Collection') || documentClass?.equalsIgnoreCase('Purchase')}">

        <tr>
            <td><span class="field_label"> Value Date </span></td>
            <td><g:textField class="datepicker_field" name="valueDate" value="${valueDate}" readonly="readonly" /></td>
        </tr>
    </g:if>

    <tr>
        <td><span class="field_label"> Currency </span></td>
        <td><g:textField class="input_field" name="currency" value="${currency ?: negotiationCurrency}" readonly="readonly" /></td>
    </tr>
    <tr>
        <td><span class="field_label"> Amount </span></td>
        <td><g:textField class="input_field numericCurrency" name="swiftAmount" value="" readonly="readonly" /></td>
    </tr>
    <g:if test="${documentClass == 'LC' && documentType == 'DOMESTIC' && serviceType?.equalsIgnoreCase('Negotiation')}"> <%-- if-else: Naging Read-Only lang sya --%>
        <tr>
            <td><span class="field_label">Ordering Customer <br /> Account No. </span></td>
            <td>
                %{--<g:textField name="orderingAccountNumber" class="input_field" value="" readonly="readonly"/>--}%
                <input class="tags_accountNumber select2_dropdown bigdrop" name="orderingAccountNumber" id="orderingAccountNumber" />
            </td>
        </tr>
    <%--
        <tr>
            <td><span class="field_label">Ordering Customer Name <span class="asterisk">*</span></span></td>
            <td><g:textField name="orderingCustomerName" class="input_field" value="" readonly="readonly" /></td>
        </tr>
    --%>
        <tr>
            <td class="vtop"><span class="field_label">Ordering Customer<span class="asterisk">*</span><br/> Address</span></td>
            <td><g:textArea name="orderingAddress" class="textarea_long" rows="4" readonly="readonly"/></td>
        </tr>
    </g:if>
    <g:else>
        <tr>
            <td><span class="field_label">Ordering Customer Account No.<span class="asterisk"> *</span></span></td>
            <td>
                %{--<g:select name="orderingAccountNumber" from="${[]}" class="select_dropdown" noSelection="['':'SELECT ONE...']" />--}%
                <input class="tags_accountNumber select2_dropdown bigdrop" name="orderingAccountNumber" id="orderingAccountNumber" />
            </td>
        </tr>
    <%--


<tr>
    <td><span class="field_label">Ordering Customer Name <span class="asterisk">*</span></span></td>
    <td><g:textField name="orderingCustomerName" class="input_field" value="${orderingCustomerName}" /></td>
</tr>
--%>
        <tr>
            <td class="vtop"><span class="field_label">Ordering Customer<span class="asterisk">*</span><br/> Address</span></td>
            <td><g:textArea name="orderingAddress" value="${orderingAddress}" class="textarea_long" rows="4"/></td>
        </tr>
    </g:else>
    <g:if test="${serviceType?.equalsIgnoreCase('export advance refund')}">
        <tr>
            <td><span class="field_label">Sending Institution</span></td>
            <td><g:select name="sendingInstitution" class="select_dropdown" from="${[]}" noSelection="['':'SELECT ONE...']" /></td>
        </tr>
        <tr>
            <td><span class="field_label">Ordering Institution </span></td>
        </tr>
        <tr>
            <td><g:radio name="orderingInstitutionFlag" value="1" /> Option A - <span class="field_label">SWIFT Code</span></td>
            <td><g:textField name="swiftCodeOrderingInstitution" class="input_field" readonly="readonly" /></td>
        </tr>
        <tr>
            <td><g:radio name="orderingInstitutionFlag" value="2" /> Option D - <span class="field_label">Name and Address</span></td>
            <td><g:textArea name="nameAndAddressOrderingInstitution" class="textarea_long" rows="4" readonly="readonly"></g:textArea></td>
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
            <td><g:textArea name="locationSenderCorrespondent" class="textarea_long" rows="4" readonly="readonly"></g:textArea></td>
        </tr>
        <tr>
            <td><g:radio name="senderCorrespondentFlag" value="3" /> Option D - <span class="field_label">Name and Address</span></td>
            <td><g:textArea name="nameAndAddressSenderCorrespondent" class="textarea_long" rows="4" readonly="readonly"></g:textArea></td>
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
            <td><g:textArea name="locationReceiverCorrespondent" class="textarea_long" rows="4" readonly="readonly"></g:textArea></td>
        </tr>
        <tr>
            <td><g:radio name="receiversCorrespondentFlag" value="3" /> Option D - <span class="field_label">Name and Address</span></td>
            <td><g:textArea name="nameAndAddressReceiverCorrespondent" class="textarea_long" rows="4" readonly="readonly"></g:textArea></td>
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
            <td><g:textArea name="locationIntermediary" class="textarea_long" rows="4" readonly="readonly"></g:textArea></td>
        </tr>
        <tr>
            <td><g:radio name="intermediaryFlag" value="3" /> Option D - <span class="field_label">Name and Address</span></td>
            <td><g:textArea name="nameAndAddressIntermediary" class="textarea_long" rows="4" readonly="readonly"></g:textArea></td>
        </tr>
    </g:if>


    <tr>
        <td><span class="field_label">Account with Institution <span class="asterisk">*</span></span></td>
        <td><g:select name="accountWithInstitution" value="${accountWithInstitution}" class="select_dropdown" from="${['ACC-1','ACC-2']}" noSelection="['':'SELECT ONE...']" /></td>
    </tr>
    <tr>
        <td class="vtop"><span class="field_label">Account with Institution - Name and Address</span></td>
        <td><g:textArea name="nameAndAddress" value="${nameAndAddress}" class="textarea_long" rows="4" /></td>
    </tr>
    <tr>
        <td><span class="field_label">Beneficiary Customer<span class="asterisk">*</span><br/>Name</span></td>
        <td><g:textField name="beneficiaryName" value="${beneficiaryName}" class="input_field" maxlength="10" /></td>
    </tr>
    <tr>
        <td class="vtop"><span class="field_label">Beneficiary Customer<span class="asterisk">*</span><br/>Address</span></td>
        <td><g:textArea name="beneficiaryAddress" value="${beneficiaryAddress}" class="textarea_long" rows="4" /></td>
    </tr>
    <tr>
        <td><span class="field_label">Beneficiary's Account Number</span></td>
        <td>
            %{--<g:textField name="beneficiaryAccountNumber" value="${beneficiaryAccountNumber}" class="input_field" />--}%
            <input class="tags_accountNumber select2_dropdown bigdrop" name="beneficiaryAccountNumber" id="beneficiaryAccountNumber" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label">Details of Charges<span class="asterisk">*</span></span></td>
        <td><g:select name="detailsOfCharges" value="${detailsOfCharges}" class="select_dropdown" from="${['SHA']}" noSelection="['':'SELECT ONE...']" /></td>
    </tr>
    <tr>
        <td valign="top"><span class="field_label"> Sender to Receiver *MUST HAVE CODE* <span class="asterisk"> * </span> <br />Information</span></td>
        <td><g:textArea name="senderToReceiverInformation" value="${senderToReceiverInformation}" class="textarea_long" rows="4"/></td>
    </tr>
</table>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 103" onclick="goToViewMt(103)"/>
		</td>
	</tr>	
</table>
<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="saveConfirmMtDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="cancelConfirmMtDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>
    var searchCasaAccountsUrl2 = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
    searchCasaAccountsUrl2 += "?cifNumber="+$("#cifNumber").val() + "&currency="+$("#currency").val();

    var sendersCorrespondentFlag = "${sendersCorrespondentFlag}";

    $(document).ready(function() {
        %{--$("#receivingBank").select2('data',{id: '${receivingBank}'});--}%
        $("#receivingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${receivingBank}'});
        $("#orderingAccountNumber").setAccountNumberDropdown2($(this).attr("id")).select2('data',{id: '${orderingAccountNumber}'});
        $("#beneficiaryAccountNumber").setAccountNumberDropdown2($(this).attr("id")).select2('data',{id: '${beneficiaryAccountNumber}'});

        $("#senderIdentifierCode").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCode}'});

        $("#senderIdentifierCode").attr("readonly", "readonly");
        $("#senderLocation").attr("readonly", "readonly");

        if(sendersCorrespondentFlag == 'A'){
            $("#senderIdentifierCode").removeAttr("readonly");
            $("#senderLocation").attr("readonly", "readonly");

        } else if(sendersCorrespondentFlag == 'B'){
            $("#senderIdentifierCode").attr("readonly", "readonly");
            $("#senderLocation").removeAttr("readonly");

        }

        $(".sendersCorrespondentFlag").change(function(){
            if($(this).val() == 'A'){
                $("#senderIdentifierCode").removeAttr("readonly").select2("enable");
                $("#senderLocation").val("");
                $("#senderLocation").attr("readonly", "readonly");

            } else if($(this).val() == 'B'){
                $("#senderIdentifierCode").attr("readonly", "readonly");
                $("#senderIdentifierCode").select2('data',{id: ''});
                $("#senderIdentifierCode").select2("disable");
                $("#senderLocation").removeAttr("readonly");
            }
        });

        if ($("#saveConfirmMtDetails").length > 0) {
            $("#saveConfirmMtDetails").click(function() {
            	if(validateExportTab("#mt103TabForm") > 0){
            		$("#alertMessage").text("Please fill in all the required fields.");
            		triggerAlert();
            	} else {
	            	$(".saveAction").show();
	            	$(".cancelAction").hide();
	                $("#mt103TabForm").submit();
            	}
            })
        }

        if ($("#cancelConfirmMtDetails").length > 0) {
            $("#cancelConfirmMtDetails").click(function() {
                mDisablePopup($("#mtDetailsDiv"), $("#mtDetailsBg"));
            })
        }
    });
</script>