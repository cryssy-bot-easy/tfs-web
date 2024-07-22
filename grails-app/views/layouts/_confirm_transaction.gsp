<%--  PROLOGUE:
 * 	(revision)
	SCR/ER Number: 20160414-0529
	SCR/ER Description: Transaction was approved in TSD, but is found on TSD Makers' screen the next day, with Pending status.
	[Revised by:] Allan Comboy Jr.
	[Date Deployed:] 04/14/2016
	Program [Revision] Details: Add pop-up alert to notify user if transaction failed to route(TSD only)
	PROJECT: WEB
	MEMBER TYPE  : Grails GSP
	Project Name: _confirm_transaction.gsp
--%>


<g:if test="${email  == true}">

    <%-- Email Error POPUP --%>
<div class="popup_div_alert" id="popup_trans_confirmation"> 
  <div class="popup_header"/>
  	<h2 class="popup_title" style="color:red; font-size:13px;"> ${headtitle} </h2>
  </div>

    <p style="color:red; font-size:13px; "> ${message} </p><br>
    <span class="are_you_sure"> ${message1} </span><br>
    <span class="are_you_sure"> ${message2} </span>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input style="margin-top:10px;" type="button" class="input_button_alert" value="OK" id="confrimTransBtn"/> 
      	</li>
    </ul>
</div>
<div class="popup_bg_alert" id="confirmation_trans_background" ></div>
<%-- Email Error END --%>

</g:if>


<g:elseif test="${message != null || message != '' }">

<%-- CONFIRMATION POPUP --%>
  <div class="popup_div_alert" id="popup_trans_confirmation"> 
    <div class="popup_header"/>
    	<h2 class="popup_title"> Alert! </h2>
    </div>
    <span class="are_you_sure"> ${message} </span>
    <%--<g:textField name="statusAction" value=""/>--%>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_negative_alert" value="OK" id="confrimTransBtn"/> 
      	</li>
<%--      	<li> <input type="button" class="input_button_negative_alert" value="Cancel" id="btnAlertCancel"/> </li>--%>
    </ul>
</div>
<div class="popup_bg_alert" id="confirmation_trans_background" ></div>
<%-- CONFIRMATION POPUP END --%>

</g:elseif>


<script>
    $(document).ready(function() {
        $("#confrimTransBtn").click(function() {
            console.log("CLOSED");
            var mSave_div = $("#popup_trans_confirmation");
            var mBg = $("#confirmation_trans_background");
            mDisablePopup(mSave_div, mBg);
        });
    });
</script>


<ul>
    <g:each in="${lsOut}" var="it">
        <li>${it.encodeAsHTML()}</li>
    </g:each>
</ul>