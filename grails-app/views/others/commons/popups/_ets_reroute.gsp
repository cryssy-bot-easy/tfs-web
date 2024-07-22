<div id="popup_etsReroute" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_etsReroute1" class="popup_close">x</a>
		<h2 id="popup_title" class="popup_title"> Re - route </h2>
	</div>
	<div class="popup_divider">
		<br /><br />
		<table>
			<tr>
				<td class="label_width"><span class="field_label">Routed To:</span></td>
				<td class="input_width"><g:textField name="routedTo" class="input_field" readonly="readonly"/></td>
			</tr>
			<tr>
				<td><span class="field_label">Re-route to:</span></td>
				<td>
					<g:select from="" name="reRouteTo" class="select_dropdown" noSelection="['':'Select One']"/>
				</td>
			</tr>
		</table>
		<table class="buttons">
			<tr>
				<td><g:submitToRemote class="input_button" value="Route" /></td>
			</tr>
			<tr>
				<td><g:submitToRemote id="close_etsReroute2" class="input_button_negative" value="Cancel" /></td>
			</tr>
		</table>
	</div>
</div>
<div id="popup_etsReroute_bg" class="popup_bg_override"> </div>
