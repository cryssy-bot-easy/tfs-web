
<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">LC Number</span></td>
		<td><g:textField name="lcNumber" maxlength="16" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">MT Message</span></td>
		<td class="space"><g:textArea name="mtMessage" class="textarea_mt_message" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">Instruction</span></td>
		<td class="space"><g:textArea name="instruction" class="textarea_mt_instruction"/></td>
	</tr>
	<tr>
		<td><span class="field_label">TSD/FD Maker</span></td>
		<td>
			<g:select name="tsdFdMaker" from="" class="select_dropdown" noSelection="['':'Select One']"/>	
		</td>
	</tr>
</table>
<table class="buttons tabs_forms_table">
	<tr>
		<td><g:submitToRemote name="print" class="input_button" value="Print"/></td>
	</tr>
	<tr>
		<td><g:submitToRemote name="save" class="input_button" value="Save"/></td>
	</tr>
	<tr>
		<td><g:submitToRemote name="routeToFsd" class="input_button_long" value="Route to FSD/FD Maker"/></td>
	</tr>
	%{--<tr>--}%
		%{--<td><g:submitToRemote name="returnMt" class="input_button_negative_long" value="Return to RSD-Cable Section"/></td>--}%
	%{--</tr>--}%
	
</table>