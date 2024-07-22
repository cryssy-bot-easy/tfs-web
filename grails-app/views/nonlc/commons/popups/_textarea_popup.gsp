<div id="${textAreaPopupId}" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" class="${closeTextAreaBtnPopup} popup_close">x</a>
        <h2 class="popup_title">${textAreaHeader}</h2>
    </div>
        <div><g:textArea name="${textAreaName}" class="textarea_add_instructions" disabled="disabled"></g:textArea></div><%--<br />
            <g:if test="${remainCharsTextArea}">
            <span><span id="${remainCharsTextArea}"></span>&#160;Characters Left</span>
            </g:if>
            <g:if test="${remainLinesTextArea}">
            <span><span id="${remainLinesTextArea}"></span>&#160;Lines Left</span>
            </g:if>
            --%><br />
            <table class="popup_buttons_short2">
                <tr><td><input type="button" class="input_button ${saveTextAreaBtnPopup}" value="Save" id="${saveTextAreaBtnPopupId}"/></td></tr>
                <tr><td><input type="button" class="input_button_negative ${closeTextAreaBtnPopup}" value="Close" /></td></tr>   
            </table>
</div>
<div id="${textAreaPopupbg}" class="popup_bg_override"> </div>
<g:javascript src="${textAreaScript}" />