<%-- Commitment fee --%>
<div id="commitmentFeePopup" class="popup_div_override <%--<g:if
        test="${serviceType == 'Amendment' && lcAmountFlag == 'INC' && expiryDateFlag == 'EXT'}">amendment</g:if>--%>">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_commitmentFee popup_close">x</a>
        <h2 class="popup_title">Commitment Fee</h2>
    </div>


    <table class="popup_full_width">
        <tr>
            <td><span class="field_label bold">Commitment Fee</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="commitmentFeePopupFieldCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right numericCurrency" name="commitmentFeePopupField"
                             disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">Percentage</span></td>
            <g:if test="${serviceType != 'Amendment'}">
            <td rowspan="2"/>
            </g:if>
            <g:else>
            <td/>
            </g:else>
            <td class="center"><g:textField class="center input_field_short numericQuantity"
                                            name="comFeePercentageNumerator" value="${comFeePercentageNumerator?:1}"/>
            &#160;&#47;&#160;
            <g:textField class="center input_field_short numericQuantity" name="comFeePercentageDenominator" value="${comFeePercentageDenominator?:4}"
                         />
            &#160; of &#160;
            <g:textField class="center input_field_short percentage numericQuantity" name="comFeePercentage" value="${comFeePercentage?:1}"
                         />
            &#160;&#37;&#160;
            </td>
        </tr>
        <g:if test="${(serviceType != 'Amendment')}">
            <tr>
                <td class="indent1"><span class="field_label">Number of Days</span></td>
                <td><g:textField class="center input_field numericQuantity" name="comFeeNumberOfMonths"
                                 disabled="disabled"/></td>
            </tr>
        </g:if>
        <tr>
            <td class="indent1"><span class="field_label">Net Commitment Fee</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="commitmentFeeNetBankComCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right" name="netCommittmentFee" readonly="readonly"
                             disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">2% CWT</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="commitmentFeeCWTCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right" name="comFeeCwt" readonly="readonly" disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">Gross Commitment Fee</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="commitmentFeeGrossBankComCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right" name="grossCommitmentFee" readonly="readonly"
                             disabled="disabled"/></td>
        </tr>
        <g:if test="${(serviceType != 'Amendment')}">
        <tr>
            <td class="indent1"><span class="field_label">LC Amount</span></td>
            <td class="center"><g:textField class="input_field_short input_three lc_currency"
                                            name="commitmentFeeLCAmountCurrency" readonly="readonly"
                                            value="${originalCurrency ?: currency}" disabled="disabled"/></td>
            <td><g:textField class="input_field_right numericCurrency" value="${originalAmount ?: amount}"
                             name="commitmentFeeLCAmountPopup" readonly="readonly" disabled="disabled"/></td>
        </tr>
        </g:if>
    </table>
    <br/>
    <table class="buttons">
        <tr>
            <td><input type="button" class="input_button2" value="Re-Compute" id="btnRecomputeCommitmentFee"/></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save"/></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative popupClose_commitmentFee" value="Cancel"/></td>
        </tr>
    </table>
</div>

<div id="popupBackground_commitment_fee" class="popup_bg_override"></div>