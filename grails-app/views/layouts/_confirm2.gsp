<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert" id="popup_confirm_div_settle">
  <div class="popup_header"/>
  	<h2 class="popup_title"> Alert! </h2>
  </div>
    <span id="confirmMessage_settle"> </span>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_alert" value="Yes" id="confirmYes_settle"/>
      		<input type="button" class="input_button_negative_alert" value="No" id="confirmNo_settle"/>
      	</li>
    </ul>
</div>
<div class="popup_bg_alert" id="popup_confirm_bg_settle"></div>
<%-- CONFIRMATION POPUP END --%>

<script>
    $(document).ready(function () {
        $("#confirmYes_settle").click(function () {
            mDisablePopup($("#popup_confirm_div_settle"), $("#popup_confirm_bg_settle"));
        });

        $("#confirmNo_settle").click(function () {
            location.href = settleUrl;
        });
    });
</script>