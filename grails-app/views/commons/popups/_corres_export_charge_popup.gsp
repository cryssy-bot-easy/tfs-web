<%-- Additional Corres Charge --%>
<div id="corresExportChargePopup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popupClose_corres_export popup_close">x</a>
        <h2 class="popup_title"> Additional Corres Charge </h2>
    </div>
    <table class="popup_table_short_center">
        <tr>
            <td><span class="field_label bold">Additional Corres Charge</span></td>
            <td><g:textField class="input_field_short trans_currency" name="corresExportChargePopupFieldCurrency" readonly="readonly" disabled="disabled"/></td>
            <td><g:textField name="corresExportChargePopupField" class="input_field right numericCurrency" disabled="disabled"/></td>
        </tr>
    </table>
    <br/>
    <table class="buttons">
        <tr>
            <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_negative popupClose_corres_export" value="Cancel" /></td>
        </tr>
    </table>
</div>
<div id="popupBackground_corres_export" class="popup_bg_override"></div>
