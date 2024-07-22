<%-- Cancellation Fee --%>
<div id="cancellationFeePopup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_cancellation_fee popup_close">x</a>
        <h2 class="popup_title"> Cancellation Fee </h2>
    </div>
    <table class="popup_table_short_center">
        <tr>
            <td><span class="field_label bold">Cancellation Fee</span></td>
            <td><g:textField class="input_field_short trans_currency" name="cancellationFeePopupFieldCurrency" readonly="readonly" disabled="disabled"/></td>
            <td><g:textField name="cancellationFeePopupField" class="input_field_right numericCurrency" value="" disabled="disabled"/></td>
        </tr>
    </table>
    <br/>
    <br/>
    <table class="buttons">
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative popupClose_cancellation_fee" value="Cancel" /></td>
        </tr>
    </table>
</div>
<div id="popupBackground_cancellation_fee" class="popup_bg_override"></div>