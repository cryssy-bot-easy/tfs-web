<script type="text/javascript">
    function cancelConfirmation() {
        $(".confirm_alert_bg").fadeOut("fast");
        $(".confirm_alert_div").fadeOut("fast");
    }
</script>

<div class="popup_div_alert confirm_alert_div" id="${confirmDivId}">
    <div class="popup_header">
        <h2 class="popup_title"> Alert! </h2>
    </div>
    <span class="are_you_sure"> Are you sure? </span>
    <ul class="popup_buttons_alert">
        <li>
            %{--<input type="button" class="input_button_alert confirmYes" value="Yes" id="${confirmId}"/>--}%
            <input type="button" class="input_button_alert" value="Yes" id="${confirmId}" />
            <input type="button" class="input_button_negative_alert" value="No" id="${cancelId}" onclick="cancelConfirmation()"/>
        </li>
    </ul>
</div>
<div class="popup_bg_alert confirm_alert_bg" id="${confirmBgId}"></div>