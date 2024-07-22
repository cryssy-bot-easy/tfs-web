<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added a new dialog box for tab validation.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _confirm_alert.gsp
--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy
	[Revised by:] John Patrick C. Bautista
	[Date revised:] 09/18/2017
	Program [Revision] Details: Added a new dialog box for narrative field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _confirm_alert.gsp
--%>
<%-- 
(revision)
	[Modified by:] Rafael Ski Poblete
	[Date revised:] 08/08/2018
	Description: Added CONFIRMATION POPUP FOR SENDER TO RECEIVER
--%>

<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert" id="popup_save_confirmation">
  <div class="popup_header"/>
	   <h2 class="popup_title"> Alert! </h2>
  </div>
    <span class="are_you_sure"> Are you sure? </span>
    <%--<g:textField name="statusAction" value=""/>--%>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_alert" value="Yes" id="btnAlertConfirm"/> 
      		<input type="button" class="input_button_negative_alert" value="No" id="btnAlertNo"/> 
      	</li>
<%--      	<li> <input type="button" class="input_button_negative_alert" value="Cancel" id="btnAlertCancel"/> </li>--%>
    </ul>
</div>
<div class="popup_bg_alert" id="confirmation_background"></div>
<%-- CONFIRMATION POPUP END --%>

<%-- CONFIRMATION POPUP FOR TAB --%>
<div class="popup_div_alert" id="popup_tab_confirmation">
  <div class="popup_header"/>
  	<h2 class="popup_title"> Alert! </h2>
  </div>
    <span class="are_you_sure"> There are unsaved changes <br/>(User inputted, System-computed, System-derived). <br/> Proceed? </span>
    <%--<g:textField name="statusAction" value=""/>--%>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_alert" value="Yes" id="btnTabYes"/> 
      		<input type="button" class="input_button_negative_alert" value="No" id="btnTabNo"/> 
      	</li>
<%--      	<li> <input type="button" class="input_button_negative_alert" value="Cancel" id="btnAlertCancel"/> </li>--%>
    </ul>
</div>
<div class="popup_bg_alert" id="confirmation_background_tab"></div>

<%-- CONFIRMATION POPUP FOR NARRATIVE --%>
<div class="popup_div_alert" id="popup_narrative_confirmation">
  <div class="popup_header"/>
  	<h2 class="popup_title"> Alert! </h2>
  </div>
    <span class="are_you_sure"> The Narrative field will be cleared once Disposal Code has been changed. Proceed? </span>
    <%--<g:textField name="statusAction" value=""/>--%>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_alert" value="Yes" id="btnNarrativeYes"/> 
      		<input type="button" class="input_button_negative_alert" value="No" id="btnNarrativeNo"/> 
      	</li>
    </ul>
</div>
<div class="popup_bg_alert" id="confirmation_background_tab"></div>

<%-- CONFIRMATION POPUP FOR TAB END --%>


<%-- CONFIRMATION POPUP FOR SENDER TO RECEIVER --%>
<div class="popup_div_alert" id="popup_senderToReceiver_confirmation">
  <div class="popup_header"/>
  	<h2 class="popup_title"> Alert! </h2>
  </div>
    <span class="are_you_sure"> The Narrative field will be cleared once Sender to Receiver Code has been changed. Proceed? </span>
    <%--<g:textField name="statusAction" value=""/>--%>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_alert" value="Yes" id="btnSenderToReceiverYes"/> 
      		<input type="button" class="input_button_negative_alert" value="No" id="btnSenderToReceiverNo"/> 
      	</li>
    </ul>
</div>
<div class="popup_bg_alert" id="confirmation_background_tab"></div>

<script>
    $(document).ready(function() {
        $("#btnAlertNo").click(function() {
            if ($("#commandName").length > 0 && session.mtModel) {
                $("#commandName").val('${status}');
            }

            var mSave_div = $("#popup_save_confirmation");
            var mBg = $("#confirmation_background");

            mDisablePopup(mSave_div, mBg);
        });
    });
</script>