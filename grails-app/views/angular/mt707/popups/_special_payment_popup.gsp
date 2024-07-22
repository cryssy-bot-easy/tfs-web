<div id="popup_special_payment" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" ng-click="rdc.closePopup('popup_special_payment', 'special_payment_bg')" class="popup_close">x</a>
        <h2 id="popup_header_addCondition1"> {{ rdc.specialPayment == 'BENEFICIARY' ? 'Special Payment Conditions for Beneficiary' : 'Special Payment Conditions for Receiving Bank'}} </h2>
    </div>
    <div class="popup_divider">
        <g:textArea maxlength="6500" name="specialPaymentDescription" ng-model="rdc.specialPaymentDescription" class="textarea_add_instructions" disabled="disabled" />
        <span></span>
        <br /><br />
        <table class="popup_buttons">
            <tr><td class="right_indent"><input type="button" class="input_button" value="Save" ng-click="rdc.saveSpecialPayment()"/></td></tr>
            <tr><td class="right_indent"><input type="button" class="input_button_negative" ng-click="rdc.closePopup('popup_special_payment', 'special_payment_bg')" value="Close"/></td></tr>
        </table>
    </div>
</div>
<div id="special_payment_bg" class="popup_bg_override"> </div>
