<div id="ec_login_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_ec_login1" class="popup_close">x</a>
		<h2 class="popup_title popup_header_ec_login"> Log in to your account</h2>
	</div>
	<hr />
	<br />
	<div id="login_area_inside">
		<form id="ec_login" class="form-validation"  method="post">
			<table id="login_area_table" class="validation_table">
				<tr>
					<td><span class="field_label_login">Username:</span></td>
					<td><g:textField name="ecLoginUsername" class="input_field required1 name"/></td>
				</tr>
				<tr>
					<td><span class="field_label_login">Password:</span></td>
					<td><g:passwordField name="ecLoginPassword" class="input_field required1 pass"/></td>
				</tr>
				<tr>
					<td>&#160;</td>
				</tr>
				<tr>
					<td></td>
					<td><input type="button" id="login_ec" class="input_button no_border float_right" value="Log-in"/></td>
				</tr>
				<tr>
					<td>&#160;<br/></td>
				</tr>
			</table>
		</form>
	</div>
</div>
<div id="ec_login_bg" class="popup_bg_override"> </div>