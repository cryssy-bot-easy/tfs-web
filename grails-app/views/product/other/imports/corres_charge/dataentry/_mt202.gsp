<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt202" />

<g:javascript src="new/corres_charge/corres_charge_mt202.js" />

<script type="text/javascript">
    var sendersCorrespondentPartyIdentifier = '${depositoryAccountNumber}';

    $(document).ready(function() {
        $("#senderIdentifierCodeMt").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCodeMt ? ('A'.equals(sendersCorrespondentFlagMt202) ? senderIdentifierCodeMt : '') : ''}'});
        $("#bankIdentifierCodeMt").setBankDropdown($(this).attr("id")).select2('data',{id: '${bankIdentifierCodeMt}'});
        $("#receiverIdentifierCodeMt").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCodeMt}'});
        $("#intermediaryIdentifierCodeMt").setBankDropdown($(this).attr("id")).select2('data',{id: '${intermediaryIdentifierCodeMt}'});
        $("#accountIdentifierCodeMt").setBankDropdown($(this).attr("id")).select2('data',{id: '${accountIdentifierCodeMt}'});
        $("#beneficiaryIdentifierCodeMt").setBankDropdown($(this).attr("id")).select2('data',{id: '${beneficiaryIdentifierCodeMt ?: remittingBank}'});

        // ordering bank
        $("input[name=orderingBankFlagMt202]").click(onOrderingBankChange);
        onOrderingBankChange();
        $("#orderingBankNameAndAddressPopup").click(function() {
            $("#orderingBankNameAndAddressTextArea").val("");
            centerPopup("orderingBankNameAndAddressDiv", "orderingBankNameAndAddressBg");
            loadPopup("orderingBankNameAndAddressDiv", "orderingBankNameAndAddressBg");
        });

        $("#orderingBankNameAndAddressClose, #orderingBankNameAndAddressCloseX").click(function() {
            disablePopup("orderingBankNameAndAddressDiv", "orderingBankNameAndAddressBg");
        });

        $("#orderingBankNameAndAddressSave").click(function() {
            $("#bankNameAndAddressMt").val($("#orderingBankNameAndAddressTextArea").val());
            disablePopup("orderingBankNameAndAddressDiv", "orderingBankNameAndAddressBg");
        });

        // senders correspondent
        $("input[name=sendersCorrespondentFlagMt202]").click(onSendersCorrespondentChange);
        onSendersCorrespondentChange();
        $("#sendersCorrespondentNameAndAddressPopup").click(function() {
            centerPopup("sendersCorrespondentNameAndAddressDiv", "sendersCorrespondentNameAndAddressBg");
            loadPopup("sendersCorrespondentNameAndAddressDiv", "sendersCorrespondentNameAndAddressBg");
        });

        $("#sendersCorrespondentNameAndAddressClose, #sendersCorrespondentNameAndAddressCloseX").click(function() {
            disablePopup("sendersCorrespondentNameAndAddressDiv", "sendersCorrespondentNameAndAddressBg");
        });

        $("#sendersCorrespondentNameAndAddressSave").click(function() {
            $("#senderNameAndAddressMt").val($("#sendersCorrespondentNameAndAddressTextArea").val());
            disablePopup("sendersCorrespondentNameAndAddressDiv", "sendersCorrespondentNameAndAddressBg");

            if ($("#sendersCorrespondentNameAndAddressTextArea").val() != "") {
                $("#sendersCorrespondentComplete").val("true");
            } else {
                $("#sendersCorrespondentComplete").val("");
            }
        });

        $("#senderIdentifierCodeMt").change(onSendersCorrespondentIdentifierCodeChange);
        onSendersCorrespondentIdentifierCodeChange();

        // receivers corresnpondent
        $("input[name=receiversCorrespondentFlagMt202]").click(onReceiversCorrespondentChange);
        onReceiversCorrespondentChange();
        $("#receiversCorrespondentNameAndAddressPopup").click(function() {
            $("#receiversCorrespondentNameAndAddressTextArea").val("");
            centerPopup("receiversCorrespondentNameAndAddressDiv", "receiversCorrespondentNameAndAddressBg");
            loadPopup("receiversCorrespondentNameAndAddressDiv", "receiversCorrespondentNameAndAddressBg");
        });

        $("#receiversCorrespondentNameAndAddressClose, #receiversCorrespondentNameAndAddressCloseX").click(function() {
            disablePopup("receiversCorrespondentNameAndAddressDiv", "receiversCorrespondentNameAndAddressBg");
        });

        $("#receiversCorrespondentNameAndAddressSave").click(function() {
            $("#receiverNameAndAddressMt").val($("#receiversCorrespondentNameAndAddressTextArea").val());
            disablePopup("receiversCorrespondentNameAndAddressDiv", "receiversCorrespondentNameAndAddressBg");
        });

        // intermediary
        $("input[name=intermediaryFlagMt202]").click(onIntermediaryChange);
        onIntermediaryChange();
        $("#intermediaryNameAndAddressPopup").click(function() {
            $("#intermediaryNameAndAddressTextArea").val("");
            centerPopup("intermediaryNameAndAddressDiv", "intermediaryNameAndAddressBg");
            loadPopup("intermediaryNameAndAddressDiv", "intermediaryNameAndAddressBg");
        });

        $("#intermediaryNameAndAddressClose, #intermediaryNameAndAddressCloseX").click(function() {
            disablePopup("intermediaryNameAndAddressDiv", "intermediaryNameAndAddressBg");
        });

        $("#intermediaryNameAndAddressSave").click(function() {
            $("#intermediaryNameAndAddressMt").val($("#intermediaryNameAndAddressTextArea").val());
            disablePopup("intermediaryNameAndAddressDiv", "intermediaryNameAndAddressBg");
        });

        // account with bank
        $("input[name=accountWithBankFlagMt202]").click(onAccountWithBankChange);
        onAccountWithBankChange();
        $("#accountWithBankNameAndAddressPopup").click(function() {
            $("#accountWithBankNameAndAddressTextArea").val("");
            centerPopup("accountWithBankNameAndAddressDiv", "accountWithBankNameAndAddressBg");
            loadPopup("accountWithBankNameAndAddressDiv", "accountWithBankNameAndAddressBg");
        });

        $("#accountWithBankNameAndAddressClose, #accountWithBankNameAndAddressCloseX").click(function() {
            disablePopup("accountWithBankNameAndAddressDiv", "accountWithBankNameAndAddressBg");
        });

        $("#accountWithBankNameAndAddressSave").click(function() {
            $("#accountNameAndAddressMt").val($("#accountWithBankNameAndAddressTextArea").val());
            disablePopup("accountWithBankNameAndAddressDiv", "accountWithBankNameAndAddressBg");
        });

        // beneficiary bank
        $("input[name=beneficiaryBankFlagMt202]").click(onBeneficiaryBankChange);
        onBeneficiaryBankChange();
        $("#beneficiaryBankNameAndAddressPopup").click(function() {
            $("#beneficiaryBankNameAndAddressTextArea").val("");
            centerPopup("beneficiaryBankNameAndAddressDiv", "beneficiaryBankNameAndAddressBg");
            loadPopup("beneficiaryBankNameAndAddressDiv", "beneficiaryBankNameAndAddressBg");
        });

        $("#beneficiaryBankNameAndAddressClose, #beneficiaryBankNameAndAddressCloseX").click(function() {
            disablePopup("beneficiaryBankNameAndAddressDiv", "beneficiaryBankNameAndAddressBg");
        });

        $("#beneficiaryBankNameAndAddressSave").click(function() {
            $("#beneficiaryNameAndAddressMt").val($("#beneficiaryBankNameAndAddressTextArea").val());
            disablePopup("beneficiaryBankNameAndAddressDiv", "beneficiaryBankNameAndAddressBg");

            if ($("#beneficiaryBankNameAndAddressTextArea").val() != "") {
                $("#beneficiaryBankComplete").val("true");
            } else {
                $("#beneficiaryBankComplete").val("");
            }
        });

        $("#beneficiaryIdentifierCodeMt").change(onBeneficiaryBankIdentifierCodeChange);
        onBeneficiaryBankIdentifierCodeChange();

        // sender to receiver information
        $("#senderToReceiverInformationPopup").click(function() {
            $("#senderToReceiverInformationNameAndAddressTextArea").val("");
            centerPopup("senderToReceiverInformationNameAndAddressDiv", "senderToReceiverInformationNameAndAddressBg");
            loadPopup("senderToReceiverInformationNameAndAddressDiv", "senderToReceiverInformationNameAndAddressBg");
        });

        $("#senderToReceiverInformationNameAndAddressClose, #senderToReceiverInformationNameAndAddressCloseX").click(function() {
            disablePopup("senderToReceiverInformationNameAndAddressDiv", "senderToReceiverInformationNameAndAddressBg");
        });

        $("#senderToReceiverInformationNameAndAddressSave").click(function() {
            $("#senderToReceiverInformationMt").val($("#senderToReceiverInformationNameAndAddressTextArea").val());
            disablePopup("senderToReceiverInformationNameAndAddressDiv", "senderToReceiverInformationNameAndAddressBg");
        });

        // save buttons
        $("#saveConfirmMt202").click(function() {
            if(validateExportTab("#mt202TabForm") > 0){
                $("#alertMessage").text("Please fill in all the required fields.");
                triggerAlert();
            } else {
                $(".saveAction").show();
                $(".cancelAction").hide();
                $("#mt202TabForm").submit();
            }
        });

        $("#cancelConfirmMt202").click(function() {
            $(".saveAction").hide();
            $(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });
    });
</script>
<g:hiddenField name="sendersCorrespondentComplete" class="required" value="${sendersCorrespondentComplete}"/>
<g:hiddenField name="beneficiaryBankComplete" class="required" value="${beneficiaryBankComplete}"/>

<g:if test="${session.dataEntryModel?.withoutReference}">
    <g:hiddenField name="totalBillingAmountInPhp" value="${totalBillingAmountInPhp}"/>
    <g:hiddenField name="netBillingAmount" value="${netBillingAmount}"/>
</g:if>

<table class="tabs_forms_table">
    <tr>
        <td><span class="field_label"> 20: Document Number </span></td>
        <td><g:textField class="input_field" name="documentNumberMT103" value="${documentNumber}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label"> 21: Remitting Bank (Ref Number) </span></td>
        <td><g:textField class="input_field" name="remittingBankReferenceNumber" value="${remittingBankReferenceNumber}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">13C: Time Indication</span></td>
        <td>
            <g:select from="${['SNDTIME','CLSTIME','RNCTIME']}" noSelection="['':'SELECT ONE']" name="timeIndicationMt" class="select_dropdown" value="${timeIndicationMt}"/>
            <g:textField class="input_field" name="timeIndicationFieldMt" value="${timeIndicationFieldMt}" maxlength="9"/>
        </td>
    </tr>
    <tr>
        <td><span class="field_label"> 32A: TS Date/Settlement Currency/ <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Settlement Amount </span></td>
        <td>
            <g:textField class="input_field" name="valueDateMt" value="${valueDateMt ?: etsDate}" readonly="readonly"/>
            <g:textField class="input_field_short" name="lcCurrencyMt" value="${lcCurrencyMt ?: currency}" readonly="readonly"/>
            <g:textField class="input_field_right numericCurrency" name="netAmountMt" value="${netAmountMt ?: productAmount}" readonly="readonly"/>
        </td>
    </tr>
    <tr>
        <td colspan="2"><span class="title_label">52<span class="orderingBankMt202OptionLetter title_label"></span>: Ordering Bank</span></td>
        <%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="orderingBank" class="select_dropdown"/></td>--%>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202" value="A" checked="${'A'.equals(orderingBankFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
        <td>
            <%-- <g:textField class="input_field" name="bankIdentifierCode" /> --%>

            <%-- Auto Complete --%>
            <input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCodeMt" id="bankIdentifierCodeMt" value="${bankIdentifierCodeMt}"/>
        </td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202" value="D" checked="${'D'.equals(orderingBankFlagMt202)}" />&#160;&#160;Name and Address</span></td>
        <td>
            <g:textArea class="textarea" name="bankNameAndAddressMt" value="${bankNameAndAddressMt}" rows="4" readonly="readonly"/>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="orderingBankNameAndAddressPopup">...</a>
            <g:render template="../product/other/imports/corres_charge/dataentry/popup/name_and_address"
                      model="[nameAndAddressTextArea: 'orderingBankNameAndAddressTextArea',
                              remainingCharacterNameAndAddress: 'orderingBankNameAndAddressRemChar',
                              remainingLineNameAndAddress: 'orderingBankNameAndAddressRemLine',
                              nameAndAddressHeader: 'Ordering Bank (MT202)',
                              nameAndAddressDiv: 'orderingBankNameAndAddressDiv',
                              nameAndAddressCloseX: 'orderingBankNameAndAddressCloseX',
                              nameAndAddressSave: 'orderingBankNameAndAddressSave',
                              nameAndAddressClose: 'orderingBankNameAndAddressClose',
                              nameAndAddressBg: 'orderingBankNameAndAddressBg']" />
        </td>
    </tr>
    <tr>
        <td colspan="2"><span class="title_label">53<span class="sendersCorrespondentMt202OptionLetter title_label"></span>: Sender's Correspondent <span class="asterisk">*</span> </span></td>
        <%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="senderCorrespondent" class="select_dropdown"/></td>--%>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="A" checked="${'A'.equals(sendersCorrespondentFlagMt202)}"/>&#160;&#160;Identifier Code</span></td>
        <td>
            <%-- <g:textField class="input_field" name="senderIdentifierCode" /> --%>

            <%-- Auto Complete --%>
            <input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt" id="senderIdentifierCodeMt" value="${senderIdentifierCodeMt}"/>
        </td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="B" checked="${sendersCorrespondentFlagMt202 ? !('A'.equals(sendersCorrespondentFlagMt202) || 'D'.equals(sendersCorrespondentFlagMt202)) : true}"/>&#160;&#160;Party Identifier</span></td>
        <td><g:textField class="input_field" name="senderPartyIdentifierMt" value="${senderPartyIdentifierMt ?: !('A'.equals(sendersCorrespondentFlagMt202) || 'D'.equals(sendersCorrespondentFlagMt202)) ? depositoryAccountNumber : ''}" readonly="readonly"/></td>
    </tr>
    <%--	<tr>--%>
    <%--		<td class="valign_top"><span class="field_label_indent2"> Location </span></td>--%>
    <%--		<td><g:textArea class="textarea" name="senderLocationMt" value="${senderLocationMt ?: !('A'.equals(sendersCorrespondentFlagMt202) || 'D'.equals(sendersCorrespondentFlagMt202)) ? reimbursingBankName : ''}" rows="2"/></td>--%>
    <%--	</tr>--%>
    <tr>
        <td class="valign_top"><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="D" checked="${'D'.equals(sendersCorrespondentFlagMt202)}"/>&#160;&#160;Name and Address</span></td>
        <td>
            <g:textArea class="textarea" name="senderNameAndAddressMt" value="${senderNameAndAddressMt}" readonly="readonly" rows="4"/>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="sendersCorrespondentNameAndAddressPopup">...</a>
            <g:render template="../product/other/imports/corres_charge/dataentry/popup/name_and_address"
                      model="[nameAndAddressTextArea: 'sendersCorrespondentNameAndAddressTextArea',
                              remainingCharacterNameAndAddress: 'sendersCorrespondentNameAndAddressRemChar',
                              remainingLineNameAndAddress: 'sendersCorrespondentNameAndAddressRemLine',
                              nameAndAddressHeader: 'Sender\'s Correspondent (MT202)',
                              nameAndAddressDiv: 'sendersCorrespondentNameAndAddressDiv',
                              nameAndAddressCloseX: 'sendersCorrespondentNameAndAddressCloseX',
                              nameAndAddressSave: 'sendersCorrespondentNameAndAddressSave',
                              nameAndAddressClose: 'sendersCorrespondentNameAndAddressClose',
                              nameAndAddressBg: 'sendersCorrespondentNameAndAddressBg']" />
        </td>
    </tr>
    <tr>
        <td colspan="2"><span class="title_label">54<span class="receiversCorrespondentMt202OptionLetter title_label"></span>: Receiver's Correspondent</span></td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="A" checked="${'A'.equals(receiversCorrespondentFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
        <td>
            <%-- Auto Complete --%>
            <input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt" id="receiverIdentifierCodeMt" value="${receiverIdentifierCodeMt}"/>
        </td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="B" checked="${'B'.equals(receiversCorrespondentFlagMt202)}" />&#160;&#160;Party Identifier</span></td>
        <td><g:textField class="input_field" name="receiverPartyIdentifierMt" value="${receiverPartyIdentifierMt}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label_indent2"> Location </span></td>
        <td><g:textArea class="textarea" name="receiverLocationMt" value="${receiverLocationMt}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="D" checked="${'D'.equals(receiversCorrespondentFlagMt202)}" />&#160;&#160;Name and Address</span></td>
        <td>
            <g:textArea class="textarea" name="receiverNameAndAddressMt" value="${receiverNameAndAddressMt}" rows="4" readonly="readonly"/>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="receiversCorrespondentNameAndAddressPopup">...</a>
            <g:render template="../product/other/imports/corres_charge/dataentry/popup/name_and_address"
                      model="[nameAndAddressTextArea: 'receiversCorrespondentNameAndAddressTextArea',
                              remainingCharacterNameAndAddress: 'receiversCorrespondentNameAndAddressRemChar',
                              remainingLineNameAndAddress: 'receiversCorrespondentNameAndAddressRemLine',
                              nameAndAddressHeader: 'Receiver\'s Correspondent (MT202)',
                              nameAndAddressDiv: 'receiversCorrespondentNameAndAddressDiv',
                              nameAndAddressCloseX: 'receiversCorrespondentNameAndAddressCloseX',
                              nameAndAddressSave: 'receiversCorrespondentNameAndAddressSave',
                              nameAndAddressClose: 'receiversCorrespondentNameAndAddressClose',
                              nameAndAddressBg: 'receiversCorrespondentNameAndAddressBg']" />
        </td>
    </tr>
    <tr>
        <td><span class="title_label">56<span class="intermediaryMt202OptionLetter title_label"></span>: Intermediary</span></td>
        <%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="intermediary" class="select_dropdown"/></td>--%>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202" value="A" checked="${'A'.equals(intermediaryFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
        <td>
            <%-- <g:textField class="input_field" name="intermediaryIdentifierCode" /> --%>

            <%-- Auto Complete --%>
            <input class="tags_bank select2_dropdown bigdrop" name="intermediaryIdentifierCodeMt" id="intermediaryIdentifierCodeMt" value="${intermediaryIdentifierCodeMt}"/>
        </td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label small_margin_left"><g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202" value="D" checked="${'D'.equals(intermediaryFlagMt202)}" />&#160;&#160;Name and Address</span></td>
        <td>
            <g:textArea class="textarea" name="intermediaryNameAndAddressMt" value="${intermediaryNameAndAddressMt}" rows="4" readonly="readonly"/>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="intermediaryNameAndAddressPopup">...</a>
            <g:render template="../product/other/imports/corres_charge/dataentry/popup/name_and_address"
                      model="[nameAndAddressTextArea: 'intermediaryNameAndAddressTextArea',
                              remainingCharacterNameAndAddress: 'intermediaryNameAndAddressRemChar',
                              remainingLineNameAndAddress: 'intermediaryNameAndAddressRemLine',
                              nameAndAddressHeader: 'Intermediary (MT202)',
                              nameAndAddressDiv: 'intermediaryNameAndAddressDiv',
                              nameAndAddressCloseX: 'intermediaryNameAndAddressCloseX',
                              nameAndAddressSave: 'intermediaryNameAndAddressSave',
                              nameAndAddressClose: 'intermediaryNameAndAddressClose',
                              nameAndAddressBg: 'intermediaryNameAndAddressBg']" />
        </td>
    </tr>
    <tr>
        <td><span class="title_label">57<span class="accountWithBankMt202OptionLetter title_label"></span>: Account with Bank</span></td>
        <%--		<td><g:select from="${['Option A-SWIFT Code','Option B-','Option D-Name']}" noSelection="['':'SELECT ONE']" name="accountWithBank" class="select_dropdown"/></td>--%>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="A" checked="${'A'.equals(accountWithBankFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
        <td>
            <%-- <g:textField class="input_field" name="accountIdentifierCode" /> --%>

            <%-- Auto Complete --%>
            <input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCodeMt" id="accountIdentifierCodeMt" value="${accountIdentifierCodeMt}"/>
        </td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="B" checked="${'B'.equals(accountWithBankFlagMt202)}"/>&#160;&#160;Party Identifier</span></td>
        <td><g:textField class="input_field" name="accountWithBankIdentifierMt" value="${accountWithBankIdentifierMt}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label_indent2"> Location </span></td>
        <td><g:textArea class="textarea" name="accountWithBankLocationMt" value="${accountWithBankLocationMt}" rows="2" readonly="readonly"/></td>
    </tr>
    <%--<tr>
        <td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="B" checked="${accountWithBankFlag.equals('B')}" />&#160;&#160;Location</span></td>
        <td><g:textField class="input_field" name="accountLocation" value="${accountLocation}"/></td>
    </tr>--%>
    <tr>
        <td class="valign_top"><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="D" checked="${'D'.equals(accountWithBankFlagMt202)}" />&#160;&#160;Name and Address</span></td>
        <td>
            <g:textArea class="textarea" name="accountNameAndAddressMt" value="${accountNameAndAddressMt}" rows="4" readonly="readonly"/>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="accountWithBankNameAndAddressPopup">...</a>
            <g:render template="../product/other/imports/corres_charge/dataentry/popup/name_and_address"
                      model="[nameAndAddressTextArea: 'accountWithBankNameAndAddressTextArea',
                              remainingCharacterNameAndAddress: 'accountWithBankNameAndAddressRemChar',
                              remainingLineNameAndAddress: 'accountWithBankNameAndAddressRemLine',
                              nameAndAddressHeader: 'Account with Bank (MT202)',
                              nameAndAddressDiv: 'accountWithBankNameAndAddressDiv',
                              nameAndAddressCloseX: 'accountWithBankNameAndAddressCloseX',
                              nameAndAddressSave: 'accountWithBankNameAndAddressSave',
                              nameAndAddressClose: 'accountWithBankNameAndAddressClose',
                              nameAndAddressBg: 'accountWithBankNameAndAddressBg']" />
        </td>
    </tr>
    <tr>
        <td><span class="title_label">58<span class="beneficiaryBankMt202OptionLetter title_label"></span>: Beneficiary Bank<span class="asterisk">*</span></span></td>
        <%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="beneficiaryBank" class="select_dropdown"/></td>--%>
    </tr>
    <tr>
        <td><span class="field_label"><g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202" value="A" checked="${beneficiaryBankFlagMt202 ? 'A'.equals(beneficiaryBankFlagMt202) : true}" />&#160;&#160;Identifier Code</span></td>
        <td>
            <%-- Auto Complete --%>
            <input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCodeMt" id="beneficiaryIdentifierCodeMt" value="${beneficiaryIdentifierCodeMt ?: remittingBank}"/>
        </td>
    </tr>
    <tr>
        <td class="valign_top"> <span class="field_label"> <g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202" value="D" checked="${'D'.equals(beneficiaryBankFlagMt202) || (!beneficiaryBankFlagMt202 && documentClass.equals('DA'))}" />&#160;&#160;Name and Address</span> </td>
        <td>
            <g:textArea class="textarea" name="beneficiaryNameAndAddressMt" rows="4" readonly="readonly">${beneficiaryNameAndAddressMt}</g:textArea>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="beneficiaryBankNameAndAddressPopup">...</a>
            <g:render template="../product/other/imports/corres_charge/dataentry/popup/name_and_address"
                      model="[nameAndAddressTextArea: 'beneficiaryBankNameAndAddressTextArea',
                              remainingCharacterNameAndAddress: 'beneficiaryBankNameAndAddressRemChar',
                              remainingLineNameAndAddress: 'beneficiaryBankNameAndAddressRemLine',
                              nameAndAddressHeader: 'Beneficiary Bank (MT202)',
                              nameAndAddressDiv: 'beneficiaryBankNameAndAddressDiv',
                              nameAndAddressCloseX: 'beneficiaryBankNameAndAddressCloseX',
                              nameAndAddressSave: 'beneficiaryBankNameAndAddressSave',
                              nameAndAddressClose: 'beneficiaryBankNameAndAddressClose',
                              nameAndAddressBg: 'beneficiaryBankNameAndAddressBg']" />
        </td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label">72: Sender to Receiver Information</span></td>
        <td>
            <g:textArea class="textarea" name="senderToReceiverInformationMt" readonly="readonly" value="${senderToReceiverInformationMt}" rows="6"/>
            <a href="javascript:void(0)" class="search_btn" id="senderToReceiverInformationPopup">...</a>
            <g:render template="../product/other/imports/corres_charge/dataentry/popup/name_and_address"
                      model="[nameAndAddressTextArea: 'senderToReceiverInformationNameAndAddressTextArea',
                              remainingCharacterNameAndAddress: 'senderToReceiverInformationNameAndAddressRemChar',
                              remainingLineNameAndAddress: 'senderToReceiverInformationNameAndAddressRemLine',
                              nameAndAddressHeader: 'Sender to Receiver Information (MT202)',
                              nameAndAddressDiv: 'senderToReceiverInformationNameAndAddressDiv',
                              nameAndAddressCloseX: 'senderToReceiverInformationNameAndAddressCloseX',
                              nameAndAddressSave: 'senderToReceiverInformationNameAndAddressSave',
                              nameAndAddressClose: 'senderToReceiverInformationNameAndAddressClose',
                              nameAndAddressBg: 'senderToReceiverInformationNameAndAddressBg']" />
        </td>
    </tr>
    <%--<tr>
        <td><span class="field_label">Receiver's Correspondent</span></td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="A" checked="${receiversCorrespondentFlag.equals('A')}" />&#160;&#160;Identifier Code</span></td>
        <td>
             <g:textField class="input_field" name="receiverIdentifierCode" />

             Auto Complete
            <input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCode" id="receiverIdentifierCode" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="B" checked="${receiversCorrespondentFlag.equals('B')}" />&#160;&#160;Location</span></td>
        <td><g:textField class="input_field" name="receiverLocation" value="${receiverLocation}" /></td>
    </tr>
    <tr>
        <td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="D" checked="${receiversCorrespondentFlag.equals('D')}" />&#160;&#160;Name and Address</span></td>
        <td>
            <g:textArea class="textarea" name="receiverNameAndAddress" value="${receiverNameAndAddress}"/></td>
    </tr>--%>
</table>

<br/><br/>
<table class="buttons_for_grid_wrapper">
    <tr>
        <td>
            <input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
        </td>
    </tr>

    <tr>
        <td><input type="button" id="saveConfirmMt202" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmMt202" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

%{--<g:render template="../nonlc/commons/popups/textarea_popup"--}%
          %{--model="${[textAreaPopupId: 'details_charges_popup',--}%
                  %{--closeTextAreaBtnPopup: 'details_charges_close',--}%
                  %{--textAreaHeader: 'Details of Charges',--}%
                  %{--textAreaName: 'detailsOfChargesComment',--}%
                  %{--saveTextAreaBtnPopupId: 'detailsOfChargesPopupSave',--}%
                  %{--saveTextAreaBtnPopup: 'details_charges_save',--}%
                  %{--textAreaPopupbg: 'details_charges_bg',--}%
                  %{--textAreaScript:'popups/details_charges_utility.js']}" />--}%
%{--<g:render template="../nonlc/commons/popups/textarea_popup"--}%
          %{--model="${[textAreaPopupId: 'sender_receiver_mt202_popup',--}%
                  %{--closeTextAreaBtnPopup: 'sender_receiver_mt202_close',--}%
                  %{--textAreaHeader: 'Sender to Receiver Information',--}%
                  %{--textAreaName: 'senderToReceiverInformationMt202Comment',--}%
                  %{--remainCharsTextArea: 'remainingCharacterSenderToReceiverMt202',--}%
                  %{--remainLinesTextArea: 'remainingLineSenderToReceiverMt202',--}%
                  %{--saveTextAreaBtnPopupId: 'senderToReceiverInformationMt202PopupSave',--}%
                  %{--saveTextAreaBtnPopup: 'sender_receiver_mt202_save',--}%
                  %{--textAreaPopupbg: 'sender_receiver_mt202_bg',--}%
                  %{--textAreaScript:'popups/sender_receiver_mt202_popup.js']}" />--}%
