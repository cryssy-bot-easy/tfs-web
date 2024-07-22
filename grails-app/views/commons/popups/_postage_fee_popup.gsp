<%-- Postage fee --%>
<div id="postageFeePopup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_postage popup_close">x</a>
        <h2 class="popup_title"> Postage Fee </h2>
    </div>
    <table class="popup_table_short_center">
        <tr>
            <td><span class="field_label bold">Postage Fee</span></td>
            <td><g:textField class="input_field_short trans_currency" name="postageFeePopupFieldCurrency" readonly="readonly" disabled="disabled"/></td>
            <td><g:textField name="postageFeePopupField" class="input_field right numericCurrency" disabled="disabled"/></td>
        </tr>
    </table>
    <br/>
    <table class="buttons">
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative popupClose_postage" value="Cancel" /></td>
        </tr>
    </table>
</div>
<div id="popupBackground_postage" class="popup_bg_override"></div>
