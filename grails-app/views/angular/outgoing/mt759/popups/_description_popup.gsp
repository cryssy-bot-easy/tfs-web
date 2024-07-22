<div id="popup_description" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" ng-click="md.closePopup()" class="popup_close">x</a>
        <h2> {{ md.popupTitle }} </h2>
    </div>
    <div class="popup_divider">
        <g:textArea name="nameAndAddressDescription" ng-show="md.popupTitle == 'Name and Address'" ng-model="md.popupDescription" class="textarea_add_instructions" disabled="disabled"/>
        <g:textArea name="narrativeDescription" ng-show="md.popupTitle == 'Narrative'" ng-model="md.popupDescription" class="textarea_add_instructions" disabled="disabled"/>
        <g:textArea name="fileDescription" ng-show="md.popupTitle == 'File Identification'" ng-model="md.popupDescription" class="textarea_add_instructions" disabled="disabled"/>
        <span></span>
        <br /><br />
        <table class="popup_buttons">
            <tr><td class="right_indent"><input type="button" class="input_button" value="Save" ng-click="md.saveDescription()"/></td></tr>
            <tr><td class="right_indent"><input type="button" class="input_button_negative" ng-click="md.closePopup()" value="Close"/></td></tr>
        </table>
    </div>
</div>
<div id="description_bg" class="popup_bg_override"> </div>
