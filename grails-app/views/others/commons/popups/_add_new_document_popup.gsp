<script>
    var saveEnclosedDocumentUrl = '${g.createLink(controller: "documentEnclosed", action: "addDocumentEnclosed")}';
</script>
<g:javascript src="popups/add_new_document_utility.js" />
<div id="addNewDocumentPopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_add_new_document popup_close">x</a>
		<h2 class="popup_title"> Add New Document </h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td><span class="field_label bold">Document Name</span></td>
			<td><g:textField maxlength="500" name="documentName" class="right input_field null_case"  disabled="disabled"/></td>
		</tr>
		
	</table>
	<br/>
	<table class="buttons"> 
	<tr>
	  <td><input type="button" class="input_button" id="save_new_document" value="Save" /></td>
	</tr>
	<tr>
	  <td><input type="button" class="input_button_negative popupClose_add_new_document" value="Cancel" /></td>
	</tr>
	</table>
</div>
<div id="popupBackground_add_new_document" class="popup_bg_override"></div>