<!--Created by: Rafael Ski Poblete
    Date: 08/14/18 
    Description: new gsp file to support deferred payment details popup element-->
<div id="deferred_payment_details_popup" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popup_close deferred_payment_details_close">x</a>
        <h2 id="popupClose_bank" class="popup_title"> Deferred Payment Details </h2>
    </div>
    <br/>
    <div><g:textArea maxlength="215" name="deferredPaymentDetailsComment" class="textarea_add_instructions" disabled="disabled"></g:textArea></div>
    <br />
    <table class="buttons">
        <tr>
           <td><input type="button" class="input_button deferred_payment_details_save" value="Save" id="deferredPaymentDetailsPopupSave"/></td>
        </tr>
        <tr>
           <td><input type="button" class="input_button_negative deferred_payment_details_close"value="Close" /></td>
        </tr>
    </table>
</div>
<div id="deferred_payment_details_bg" class="popup_bg_override"> </div>