<%-- BANK COMMISSION POPUP --%>
<%--<div id="bankCommissionPopup" class="popup_div_override">--%>

<%--
 * PROLOGUE
 * SCR/ER Description: To add notes on screen pop-up
 *	[Revised by:] Jesse James Joson
 *	Program [Revision] Details: Put a note "Please click RE-COMPUTE button to refresh values."
 *	Date deployment: 6/16/2016 
 *	Member Type: GSP
 *	Project: Web
 *	Project Name: _bank_commission_popup.gsp
--%>

<div id="bankCommissionPopup" class="popup_div_override <%--<g:if
        test="${serviceType == 'Amendment' && lcAmountFlag == 'INC' && expiryDateFlag == 'EXT'}">amendment</g:if>--%>">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_bank_commission popup_close">x</a>
        <h2 class="popup_title">Bank Commission</h2>
    </div>
    <table class="popup_full_width">
        <tr>
            <td class="label_width"><span class="field_label bold">Bank Commission</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="bankCommissionPopupFieldCurrency" value="" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right numericCurrency" name="bankCommissionPopupField"
                             disabled="disabled" value=""/></td>
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
                                            name="bankComPercentageNumerator" value="${bankComPercentageNumerator?:1}"/>
            &#160;&#47;&#160;
            <g:textField class="center input_field_short numericQuantity" name="bankComPercentageDenominator"
                value="${documentClass in ['BP','BC','EXPORT_CHARGES','EXPORT_ADVANCE','EXPORT_ADVISING']? 4 : 8}"
            /> <%-- temporarily removed bankComPercentageDenominator?: // comment by robs --%>
            &#160; of &#160;
            <g:textField class="center input_field_short percentage numericQuantity" name="bankComPercentage" value="${bankComPercentage?:1}"
                         />
            &#160;&#37;&#160;
            </td>
        </tr>
        <g:if test="${serviceType != 'Amendment'}">
        <tr>
            <td class="indent1"><span class="field_label">Number of Days</span></td>
            <td><g:textField class="center input_field numericQuantity" name="bankComNumberOfMonths"
                             disabled="disabled"/></td>
        </tr>
        </g:if>
        <tr>
            <td class="indent1"><span class="field_label">Net Bank Com</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="bankCommissionNetBankComCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right" name="netBankCommission" readonly="readonly"
                             disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">2% CWT</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="bankCommissionCWTCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right" name="bankComCwt" readonly="readonly"
                             disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">Gross Bank Com</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="bankCommissionGrossBankComCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right" name="grossBankCommission" readonly="readonly"
                             disabled="disabled"/></td>
        </tr>
        <g:if test="${serviceType != 'Amendment'}">
        <tr>
            <td class="indent1"><span class="field_label">LC Amount</span></td>
            <td class="center"><g:textField class="input_field_short input_three lc_currency"
                                            name="bankCommissionLCAmountCurrency" readonly="readonly"
                                            disabled="disabled" value="${originalCurrency ?: currency}"/></td>
            <td><g:textField class="input_field_right numericCurrency" name="bankCommissionLCAmountPopup"
                             value="${originalAmount ?: amount}" readonly="readonly" disabled="disabled"/></td>
        </tr>
        </g:if>
    </table>
    <br/>
    <br/>
    <table>
        <g:if test="${documentClass in ['BP','BC']}">
        <tr>
        	<td class="indent1">
        		<span class="title_label">Please click RE-COMPUTE button to refresh values.</span>
        		
        	</td>
        </tr>
        </g:if>
    </table>
    <table class="buttons">
        <tr>
            <td><input type="button" class="input_button2" value="Re-Compute" id="btnRecomputeBankCommission"/></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save"/></td>
        </tr>
        <tr>
            <td>
                <input type="button" class="input_button_negative popupClose_bank_commission" value="Cancel"/>
            </td>
        </tr>
    </table>
</div>

<div id="popupBackground_bank_commission" class="popup_bg_override"></div>
<%-- BANK COMMISSION POPUP END --%>
