<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert" id="popup_alert_dv">
	<h2 class="popup_title"> Alert! </h2>
    <span id="alertMessage"></span>
    
    <table class="alert_button" >
		<tr><td> <input type="button" class="input_button" value="Ok" id="btnAlertOk"/> </td></tr>
	</table>
    
</div>
<div class="popup_bg_alert" id="popup_alert_bg"></div>
<%-- CONFIRMATION POPUP END --%>

<script>
    $(document).ready(function() {
        $("#btnAlertOk").click(function() {
            mDisablePopup($("#popup_alert_dv"), $("#popup_alert_bg"));
        });
    });
</script>