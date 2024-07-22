<%-- Remittance fee --%>
<div id="remittanceFeePopup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_remittance popup_close">x</a>
        <h2 class="popup_title"> Remittance Fee </h2>
    </div>
    <table class="popup_table_short_center">
        <tr>
            <td><span class="field_label bold">Remittance Fee</span></td>
            <td><g:textField class="input_field_short trans_currency" name="remittanceFeePopupFieldCurrency" readonly="readonly" disabled="disabled"/></td>
            <td><g:textField name="remittanceFeePopupField" class="input_field right numericCurrency" disabled="disabled"/></td>
        </tr>
    </table>
    <br/>
    <table class="buttons">
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative popupClose_remittance" value="Cancel" /></td>
        </tr>
    </table>
</div>
<div id="popupBackground_remittance" class="popup_bg_override"></div>
