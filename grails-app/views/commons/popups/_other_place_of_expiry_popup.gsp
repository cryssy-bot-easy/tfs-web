<!--Created by: Rafael Ski Poblete
    Date: 08/13/18 
    Description: new gsp file to support Other Place of Expiry popup element-->
<div id="otherPlaceOfExpiry_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popup_close otherPlaceOfExpiry_close">x</a>
        <h2 id="popupClose_bank" class="popup_title"> Other Place of Expiry </h2>
    </div>
    <br/>
    <div><g:textArea maxlength="215" name="otherPlaceOfExpiryComment" class="textarea_add_instructions" disabled="disabled"></g:textArea></div>
    <br />
    <table class="buttons">
        <tr>
          <td><input type="button" class="input_button otherPlaceOfExpiry_save" value="Save" id="otherPlaceOfExpiryPopupSave"/></td>
        </tr>
        <tr>
          <td><input type="button" class="input_button_negative otherPlaceOfExpiry_close"value="Close" /></td>
        </tr>
    </table>
</div>
<div id="otherPlaceOfExpiry_bg" class="popup_bg_override"> </div>