<g:hiddenField name="referenceType" value="incomingMt"/>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">LC Number</span></td>
		<td>
            <g:hiddenField name="id" value="${id}" />
            <g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">MT Message</span></td>
		<td class="space"><div><g:textArea name="message" value="${message}" class="textarea_mt_message" readonly="readonly"/></div></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">Instruction</span></td>
		<td class="space">
            <g:if test="${!userActiveDirectoryId}">
                <g:textArea name="instruction" value="${instruction}" class="textarea_mt_instruction"/>
            </g:if>
            <g:else>
                <g:textArea name="instruction" value="${instruction}" class="textarea_mt_instruction" readonly="readonly"/>
            </g:else>
        </td>
	</tr>
    <g:if test="${!userActiveDirectoryId}">
        <tr>
            <td><span class="field_label">TSD/FD Maker</span></td>
            <td>
                %{--<g:select name="tsdFdMaker" from="" class="select_dropdown" noSelection="['':'Select One']"/>	--}%
                <g:select name="userActiveDirectoryId" from="${session.nextRoute}" optionKey="key" optionValue="value" class="select_dropdown" />
            </td>
        </tr>
    </g:if>
</table>

<table class="buttons tabs_forms_table">
	<tr>
		<td>
            %{--<g:submitToRemote name="print" class="input_button" value="Print"/>--}%
            <input type="button" class="input_button generateMtMessage" name="print" value="Print" />
        </td>
	</tr>
    <g:if test="${!userActiveDirectoryId}">
        <tr>
            <td>
                %{--<g:submitToRemote name="save" class="input_button" value="Save"/>--}%
                <input type="button" class="input_button openSaveConfirmation" name="save" value="Save" />
            </td>
        </tr>
        <tr>
            <td>
                %{--<g:submitToRemote name="routeToFsd" class="input_button_long" value="Route to FSD/FD Maker"/>--}%
                <input type="button" class="input_button_long openRouteConfirmation" name="route" value="Route to FSD/FD Maker" />
            </td>
        </tr>
    </g:if>
	%{--<tr>--}%
		%{--<td>--}%
            %{--<g:submitToRemote name="returnMt" class="input_button_negative_long" value="Return to RSD-Cable Section"/>--}%
            %{--<input type="button" class="input_button_negative_long openReturnConfirmation" name="return" value="Return to RSD-Cable Section" />--}%
        %{--</td>--}%
	%{--</tr>--}%
	
</table>