<%-- ACCEPT/CANCEL POPUP --%>
<div class="popup_div_override" id="accept_cancel_nonlc_popup">
	<div class="popup_header">
		<a href="javascript:void(0)"
			class="accept_cancel_nonlc_close popup_close">x</a>
		<%--		<h2> Notice </h2>
			Please select one of the following actions:
			--%>
		<h2 id="create_transaction_popup_header">Create Transaction</h2>
	</div>


	<%--<div class="center">
			<input type="button" class="input_button_negative center" value="Cancel" onclick="goToCancel()" />
			<input type="button" class="input_button" value="Accept" onclick="goToAccept()"/> &#160;&#160; 
		</div>
		--%>
	<g:radioGroup values="${['accept', 'cancel']}"
		labels="${['FX Non LC - DA Negotiation Acceptance', 'FX Non LC - DA Cancellation']}"
		name="createDa">
		<label> ${it.radio}&#160;${it.label}
		</label>
		<br />
	</g:radioGroup>
	<g:hiddenField name="daDocNum" />
	<table class="popup_buttons">
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="accept_cancelRedirect" value="Go"
				class="input_button" /></td>
		</tr>
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="accept_cancelCancel" value="Cancel"
				class="input_button_negative" /></td>
		</tr>
	</table>
</div>
<div class="popup_bg_override" id="accept_cancel_nonlc_bg"></div>
<%-- ACCEPT/CANCEL POPUP END --%>