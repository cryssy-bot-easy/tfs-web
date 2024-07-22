 <%-- CILEX fee --%>
<%--
 * PROLOGUE
 * SCR/ER Description: To add notes on screen pop-up
 *	[Revised by:] Jesse James Joson
 *	Program [Revision] Details: Put a note "Please click RE-COMPUTE button to refresh values."
 *	Date deployment: 6/16/2016 
 *	Member Type: GSP
 *	Project: Web
 *	Project Name: _cilex_popup.gsp
--%>

<div id="cilexFeePopup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_cilex_fee popup_close">x</a>
        <h2 class="popup_title">CILEX</h2>
    </div>
    <table class="popup_full_width">
        <tr>
            <td><span class="field_label bold">CILEX</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="cilexFeePopupFieldCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="input_field_right numericCurrency" name="cilexFeePopupField" disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">Percentage</span></td>
            <td/>
            <td class="center"><g:textField class="center input_field_short numericQuantity" name="cilexPercentageNumerator"
                                            value="${cilexPercentageNumerator?:1}"/>
            &#160;&#47;&#160;
            <g:textField class="center input_field_short numericQuantity" name="cilexPercentageDenominator" value="${cilexPercentageDenominator?:4}"/>
            &#160; of &#160;
            <g:textField class="center input_field_short percentage numericQuantity" name="cilexPercentage" value="${cilexPercentage?:1}"/>
            &#160;&#37;&#160;
            </td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">Net CILEX</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="cilexNetBankComCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="right input_field" name="cilexNet" readonly="readonly" disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">2% CWT</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency" name="cilexCWTCurrency"
                                            readonly="readonly" disabled="disabled"/></td>
            <td><g:textField class="right input_field" name="cilexCwt" readonly="readonly" disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">Gross CILEX</span></td>
            <td class="center"><g:textField class="input_field_short input_three trans_currency"
                                            name="cilexGrossBankComCurrency" readonly="readonly"
                                            disabled="disabled"/></td>
            <td><g:textField class="right input_field" name="grossCilex" readonly="readonly" disabled="disabled"/></td>
        </tr>
        <tr>
            <td class="indent1"><span class="field_label">Negotiation Amount</span></td>
            <td class="center"><g:textField class="input_field_short input_three lc_currency"
                                            name="cilexLCAmountCurrency" readonly="readonly" value="${originalCurrency ?: currency}"
                                            disabled="disabled"/></td>
            <td><g:if test="${!serviceType?.equalsIgnoreCase('Negotiation')}">
                <g:textField class="input_field_right" name="cilexLCAmountPopup" readonly="readonly" disabled="disabled"
                             value="${originalAmount ?: amount}"/>
            </g:if><g:else>
                <g:textField class="input_field_right" name="cilexLCAmountPopup" readonly="readonly" disabled="disabled"
                             value="${negotiationAmount ?: amount}"/>
            </g:else>
            </td>
        </tr>
        %{--<tr>--}%
            %{--<td class="indent1"><span class="field_label">Rate</span></td>--}%
            %{--<td class="center"><g:textField class="input_field_medium input_ten rate_currency center"--}%
                                            %{--name="cilexRateCurrency" readonly="readonly" disabled="disabled"/></td>--}%
            %{--<td><g:textField class="right input_field" name="cilexRate" readonly="readonly" disabled="disabled"/></td>--}%
        %{--</tr>--}%
    </table>
    <br/>    
    <br/>
    <table class="popup_full_width" >
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
            <td><input type="button" class="input_button2" value="Re-Compute" id="btnRecomputeCilexFee"/></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save"/></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative popupClose_cilex_fee" value="Cancel"/></td>
        </tr>
    </table>
</div>

<div id="popupBackground_cilex_fee" class="popup_bg_override"></div>