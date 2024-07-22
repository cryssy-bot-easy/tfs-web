<div id="loan_popup_wrapper">
    <div id="loan_error_popup" class="popup_div_override">
        <div class="popup_header">
            <a href="javascript:void(0)" class="popup_close" id="close_loan_error_popup">x</a>
            <h2 id="header_view_loan_errors" class="popup_title">Loan Errors</h2>
        </div>
        <ul class="swiftErrorMessage">
            <g:each in="${errors}" var="error">
                <li>${error}</li>
            </g:each>
        </ul>
    </div>
    <div id="view_loan_error_popup_bg" class="popup_bg_override"></div>
</div>