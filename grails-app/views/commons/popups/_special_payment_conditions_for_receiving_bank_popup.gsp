<!--Created by: Rafael Ski Poblete
    Date: 08/14/18 
    Description: new gsp file to support Special Payment Conditions For Receiving Bank popup element-->
<div id="special_payment_conditions_for_receiving_bank_popup" class="popup_div_override special_payment_conditions">
    <div class="popup_header">
        <a href="javascript:void(0)" class="popup_close special_payment_conditions_for_receiving_bank_close">x</a>
        <h2 id="popupClose_bank" class="popup_title"> Special Payment Conditions For Receiving Bank </h2>
    </div>
    <br/>
    <div><g:textArea name="specialPaymentConditionsForReceivingBankComment" class="textarea_add_instructions special_payment_conditions" disabled="disabled"></g:textArea></div>
    <br />
    <table class="buttons">
        <tr>
          <td><input type="button" class="input_button special_payment_conditions_for_receiving_bank_save" value="Save" id="specialPaymentConditionsForReceivingBankPopupSave"/></td>
        </tr>
        <tr>
          <td><input type="button" class="input_button_negative special_payment_conditions_for_receiving_bank_close"value="Close" /></td>
        </tr>
    </table>
</div>
<div id="special_payment_conditions_for_receiving_bank_bg" class="popup_bg_override"> </div>