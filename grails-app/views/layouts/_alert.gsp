
<g:if test="${emailErr}">
 <%-- Email Error POPUP --%>
<div class="popup_div_alert" id="popup_emailErr_dv">
  <div class="popup_header"/>
		<h2 class="popup_title" style="color:red; font-size:13px;"> ERROR: Unable to send email notification </h2>
    </div>

    <p style="color:red; font-size:13px; "> ${message} </p><br>
    <span class="are_you_sure"> 1. Please manually notify the recipient instead. </span><br>
    <span class="are_you_sure"> 2. Please call ${defaultAddress} about the error. </span>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input style="margin-top:10px;" type="button" class="input_button_alert" value="OK" id="confrimTransBtn"/> 
      	</li>
    </ul>
</div>
<div class="popup_bg_alert" id="popup_emailErr_bg"></div>
<%-- Email Error END --%>
</g:if>

<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert" id="popup_alert_dv">
    <div class="popup_header"/>
    	<h2 class="popup_title"> Alert! </h2>
    </div>
    <span id="alertMessage"></span>
    
    <table class="alert_button" >
		<tr><td> <input type="button" class="input_button" value="Ok" id="btnAlertOk"/> </td></tr>
	</table>
    
</div>
<div class="popup_bg_alert" id="popup_alert_bg"></div>
<%-- CONFIRMATION POPUP END --%>



<script>
    $(document).ready(function() {
        $("#confrimTransBtn").click(function() {
            console.log("CLOSED");
            var mSave_div = $("#popup_emailErr_dv");
            var mBg = $("#popup_emailErr_bg");
            mDisablePopup(mSave_div, mBg);
        });
    });
</script>