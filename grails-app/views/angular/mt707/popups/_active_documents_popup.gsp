<div id="popup_docsRequired" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" ng-click="rdc.closePopup('popup_docsRequired', 'add_docsRequired_bg')" class="popup_close">x</a>
        <h2 id="popup_header_addCondition1"> {{ rdc.saveType == 'NEWREPALL' ? 'Replace All Documents' : 'Add/Edit Documents'}} </h2>
    </div>
    <div class="popup_divider">
        <g:textArea maxlength="6500" name="requiredDocDescription" ng-model="rdc.activeDocument.description" class="textarea_add_instructions" disabled="disabled" />
        <span></span>
        <br /><br />
        <table class="popup_buttons">
            <tr><td class="right_indent"><input type="button" class="input_button" value="Save" ng-click="rdc.saveActiveDocument(rdc.activeDocument)"/></td></tr>
            <tr><td class="right_indent"><input type="button" class="input_button_negative" ng-click="rdc.closePopup('popup_docsRequired', 'add_docsRequired_bg')" value="Close"/></td></tr>
        </table>
    </div>
</div>
<div id="add_docsRequired_bg" class="popup_bg_override"> </div>
