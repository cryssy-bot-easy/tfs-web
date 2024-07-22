<g:javascript src="utilities/commons/grid_wrapper_utility.js" />

			<table class="buttons_for_grid_wrapper">
				<tr>
					<%-- BUTTON --%>
					<td><input type="button" id="saveAsPending" class="input_button openSaveConfirmation actionWidget validate" value="Save" /></td>
				</tr>

                <g:if test="${session['userrole']['id'].equals("BRM")}">
                    <tr class="save_as_draft">
                        <td><input type="button" id="saveAsDraft" class="input_button2 button_override openSaveConfirmationDraft actionWidget" value="Save as Draft" /></td>
                    </tr>
                </g:if>
				<tr>
					<%-- BUTTON --%>
					<td><input type="button" class="input_button_negative cancelTransaction actionButton actionWidget" value="Cancel" /></td>
				</tr>
			</table>
						

