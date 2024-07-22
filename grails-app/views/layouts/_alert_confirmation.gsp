<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert" id="${popupId}">
  <div class="popup_header"/>
  	<h2 class="popup_title"> ${popupTitle?:'Alert!'} </h2>
  </div>
    <span id="alertPopupMessage"> ${popupMessage?:'Are you sure?'} </span>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_alert" value="Yes" id="${yesBtnId}"/> 
      		<input type="button" class="input_button_negative_alert" value="No" id="${noBtnId}"/>
      		<g:if test="${true.equals(includeCancel)||'true'.equals(includeCancel)}">
      			<input type="button" class="input_button_negative_alert" value="Close" id="${cancelBtnId}"/>
      		</g:if> 
      	</li>
    </ul>
</div>
<div class="popup_bg_alert" id="alert_confirmation_bg"></div>
<%-- CONFIRMATION POPUP END --%>