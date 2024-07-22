<%-- Notarial Fee --%>
<div id="notarialFeePopup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_notarial_fee popup_close">x</a>
        <h2 class="popup_title"> Notarial Fee </h2>
    </div>
    <table class="popup_table_short_center">
        <tr>
            <td><span class="field_label bold">Notarial Fee</span></td>
            <td><g:textField class="input_field_short input_three trans_currency" name="notarialFeePopupFieldCurrency" readonly="readonly" disabled="disabled"/></td>
            <td><g:textField name="notarialFeePopupField" class="input_field_right numeric_fifteen numericCurrency" disabled="disabled"/></td>
        </tr>
    </table>

    <br/>


    <br/>

    <table class="buttons">
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative popupClose_notarial_fee" value="Cancel" /></td>
        </tr>
    </table>
</div>
<div id="popupBackground_notarial_fee" class="popup_bg_override"></div>