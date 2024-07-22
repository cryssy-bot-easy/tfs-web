<g:javascript src="grids/exporter_cb_code_jqgrid.js"/>

<div id="popup_exporterCbCode" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_exporterCbCode1" class="popup_close">x</a>
		<h2 id="popup_header_exporterCbCode"></h2>
	</div>
	
	<table>
		<tr>  
			<td> <span class="field_label">Exporter Name</span> </td>
			<td> <g:textField name="exporterNamePopup" class="input_field" disabled="disabled" maxlength="60"/> </td>
			<td> <input type="button" class="input_button" id="" value="Search" />  </td>
		</tr>
	</table>
		
		<div class="grid_wrapper_popup"> <%-- JQGRID --%>
			<table id="grid_list_exporter_cb_code_type"> </table>
			<div id="grid_pager_exporter_cb_code_type"> </div>
		</div>
		<br /><br />
		<ul class="right_indent">
			<li class="right_indent"><input type="button" class="input_button_negative" id="close_exporterCbCode2" value="Close" /></li>
		</ul>
</div>
<div id="exporter_cb_code_bg" class="popup_bg_override"> </div>
