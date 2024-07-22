<div id="mt_popup_wrapper">
    <div id="view_mt_popup" class="popup_div_override">
        <div class="popup_header">
            <a href="javascript:void(0)" class="popup_close" id="close_mt700_popup">x</a>
            <h2 id="header_add_instruction" class="popup_title">MT Message</h2>
        </div>
        <ul class="swiftErrorMessage">
            <g:each in="${errors}" var="error">
                <li>${error}</li>
            </g:each>
        </ul>
        <g:textArea name="mt_message" class="textarea_view_mt" disabled="disabled" value="${message}"/>
    </div>

    <div id="view_mt_popup_bg" class="popup_bg_override"></div>
</div>