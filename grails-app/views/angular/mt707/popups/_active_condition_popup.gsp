<div id="popup_addCondition" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" ng-click="acc.closePopup('popup_addCondition', 'add_addCondition_bg')" class="popup_close">x</a>
        <h2 id="popup_header_addCondition1"> {{ acc.saveType == 'NEWREPALL' ? 'Replace All Conditions' : 'Add/Edit Conditions'}} </h2>
    </div>
    <div class="popup_divider">
        <g:textArea maxlength="6500" name="additionalConditionDescription" ng-model="acc.activeCondition.description" class="textarea_add_instructions" disabled="disabled" />
        <span></span>
        <br /><br />
        <table class="popup_buttons">
            <tr><td class="right_indent"><input type="button" class="input_button" value="Save" ng-click="acc.saveActiveCondition(acc.activeCondition)"/></td></tr>
            <tr><td class="right_indent"><input type="button" class="input_button_negative" ng-click="acc.closePopup('popup_addCondition', 'add_addCondition_bg')" value="Close"/></td></tr>
        </table>
    </div>
</div>
<div id="add_addCondition_bg" class="popup_bg_override"> </div>
