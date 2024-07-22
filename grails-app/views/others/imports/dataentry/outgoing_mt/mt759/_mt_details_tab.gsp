<div ng-controller="Mt759DetailsController as md">
    <%@ page import="net.ipc.utils.DateUtils" %>
    <g:hiddenField name="messageType" value="759"/>
    <g:hiddenField name="chainName" value="viewMT759"/>
    <g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/>
    <g:hiddenField name="currencyValue" value="${details?.currency}"/>
    <g:hiddenField name="originalIssuer" value="${ details?.issuer ?: 'cccc' }"/>
    <table class="tabs_forms_table mt759">
        <tr>
            <td><span class="field_label title_label">Destination Bank<span ng-show="md.documentNumber !== ''" class="asterisk">*</span></span></td>
            <td><input class="select2_dropdown bigdrop" name="destinationBank" id="destinationBank"
                ng-init="md.destinationBank = '${details?.destinationBank ?: ''}'" ng-model="md.destinationBank"/></td>
        </tr>
        <tr>
            <td><span class="field_label title_label">20: Transaction Reference Number<span class="asterisk">*</span></span></td>
            <td><g:textField class="input_field_long popup_width_80" name="lcNumber" ng-init="md.lcNumber = '${details?.lcNumber ?: ''}'"
                ng-model="md.lcNumber" maxlength="16"/></td>
        </tr>
        <tr>
            <td><span class="field_label title_label">21: Related Reference</span></td>
            <td><g:textField class="input_field_long popup_width_80" name="relatedReference"
                ng-init="md.relatedReference = '${details?.relatedReference ?: ''}'" ng-model="md.relatedReference" maxlength="16"/></td>
        </tr>
        <tr>
            <td><span class="field_label title_label">22D: Form of Undertaking<span ng-show="md.documentNumber !== ''" class="asterisk">*</span> </span></td>
            <td><input class="select2_dropdown bigdrop" name="formOfUndertaking" id="formOfUndertaking"
                ng-init="md.formOfUndertaking = '${details?.formOfUndertaking ?: ''}'" ng-model="md.formOfUndertaking"/></td>
        </tr>
        <tr>
            <td><span class="field_label title_label">23: Undertaking Number</span></td>
            <td><g:textField class="input_field_long popup_width_80" name="undertakingNumber"
                ng-init="md.undertakingNumber = '${details?.undertakingNumber ?: ''}'" ng-model="md.undertakingNumber" maxlength="16"/></td>
        </tr>
        <tr>
            <td colspan="4"><span class="title_label">52<span class="issuerMt759OptionLetter title_label"></span>: Issuer</span></td>
        </tr>
        <tr>
            <td>
                <g:radio name="issuer" class="mt-radio" value="A" ng-model="md.issuer" ng-click="md.toggleIssuer()" />
                &#160;<span class="field_label">Identifier Code</span>
            </td>
            <td colspan="3" class="input_width"><input class="select2_dropdown bigdrop" name="issuerIdentifierCode" id="issuerIdentifierCode"/></td>
        </tr>
        <tr>
            <td valign="top">
                <g:radio name="issuer" class="mt-radio" value="D" ng-model="md.issuer" ng-click="md.toggleIssuer()"
                    />
                &#160;<span class="field_label">Name and Address</span>
            </td>
            <td>
                <g:hiddenField name="hiddenNameAndAddress" value="${details?.issuerNameAndAddress ?: ''}"/>
                <g:textArea class="fields-textarea textarea" name="issuerNameAndAddress"
                    ng-model="md.issuerNameAndAddress" rows="4"
                    readonly="readonly"></g:textArea>
                <a href="javascript:void(0)" class="popup_btn_bottom" ng-hide="md.hideIssuerD" ng-click="md.showPopup('Name and Address', md.issuerNameAndAddress)">...</a>
            </td>
        </tr>
        <tr>
            <td><span class="field_label title_label">23H: Function of Message<span ng-show="md.documentNumber !== ''" class="asterisk">*</span> </span></td>
            <td><input class="select2_dropdown bigdrop" name="functionOfMessage" id="functionOfMessage"
                ng-init="md.functionOfMessage = '${details?.functionOfMessage ?: ''}'" ng-model="md.functionOfMessage"/></td>
        </tr>
        <tr>
            <td valign="top"><span class="field_label title_label">45D: Narrative<span ng-show="md.documentNumber !== ''" class="asterisk">*</span> </span></td>
            <td>
                <g:hiddenField name="hiddenNarrative" value="${details?.narrative ?: ''}"/>
                <g:textArea class="fields-textarea textarea popup_width_80" name="narrative" value="${details?.narrative ?: ''}"
                    ng-model="md.narrative" rows="10" readonly="readonly"></g:textArea>
                <a href="javascript:void(0)" class="popup_btn_bottom" ng-click="md.showPopup('Narrative', md.narrative)">...</a>
            </td>
        </tr>
        <tr>
            <td><span class="field_label title_label">23X: File Identification<span ng-show="md.fileIdentificationCode !== '' && md.fileIdentificationCode !== undefined" class="asterisk">*</span></span></td>
            <td><input class="tags_bank select2_dropdown bigdrop" name="fileIdentification" id="fileIdentification" ng-model="md.fileIdentificationCode"/></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <g:hiddenField name="hiddenFileIdentificationDescription" value="${details?.fileIdentificationDescription ?: ''}"/>
                <g:textArea class="fields-textarea textarea popup_width_80" name="fileIdentificationDescription"
                    value="${details?.fileIdentificationDescription ?: ''}"
                    ng-model="md.fileIdentificationDescription"
                    rows="5" readonly="readonly"></g:textArea>
                <a href="javascript:void(0)" class="popup_btn_bottom" ng-click="md.showPopup('File Identification', md.fileIdentificationDescription)">...</a>
            </td>
        </tr>
    </table>
    <br /><br />
    <table class="buttons_for_grid_wrapper">
        <g:if test="${tradeServiceId?.tradeServiceId != null}">
            <tr>
                <td>
                    <input type="button" class="input_button2" value="View MT 759" onclick="viewOutgoingMt(759)"/>
                </td>
            </tr>
        </g:if>
        <tr>
            <td><input type="button" ng-click="md.save()" class="input_button" value="Save" /></td>
        </tr>
        <tr>
            <td><input type="button" id="cancelOutgoingMtPopup" class="input_button_negative" value="Cancel" /></td>
        </tr>
    </table>
    <g:render template="../angular/outgoing/mt759/popups/description_popup" />
</div>

<script>
    $(document).ready(function() {
        $("#destinationBank").setRmaBankDropdown($(this).attr("id")).select2('data', { id: '${details?.destinationBank}' });
        $("#formOfUndertaking").setFormOfUndertakingDropdown($(this).attr("id")).select2('data', { id: '${details?.formOfUndertaking}' });
        $("#issuerIdentifierCode").setBankDropdown($(this).attr("id")).select2('data', { id: '${details?.issuerIdentifierCode}' });
        $("#functionOfMessage").setFunctionOfMessageDropdown($(this).attr("id")).select2('data', { id: '${details?.functionOfMessage}' });
        $("#fileIdentification").setFileIdentificationDropdown($(this).attr("id")).select2('data', { id: '${details?.fileIdentification}' });
    });
</script>
