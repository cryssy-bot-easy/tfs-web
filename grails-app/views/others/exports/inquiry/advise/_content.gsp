<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="grids/advising_bank_inquiry_jqgrid.js" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="subType1" value="${subType1}" />
<g:hiddenField name="subType1" value="${subType2}" />
<br/>
<table class="body_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span> </td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" /></td>
		<g:if test="${!serviceType?.equalsIgnoreCase('cancellation')}">
			<td class="label_width"><span class="field_label">CIF Name</span> </td>
			<td><g:textField name="cifName" class="input_field" /></td>
		</g:if>
		<g:if test="${serviceType?.equalsIgnoreCase('cancellation')}">
			<td><span class="field_label"> Exporter Name </span></td>
			<td><g:textField name="exporterName" class="input_field" maxlength="60"/></td>
		</g:if>
	</tr>
	<g:if test="${!serviceType?.equalsIgnoreCase('cancellation')}">
		<tr>
			<td><span class="field_field"> LC Number </span></td>
			<td><g:textField name="lcNumber" maxlength="16" class="input_field" /></td>
			<td><span class="field_label"> Exporter Name </span></td>
			<td><g:textField name="exporterName" class="input_field" maxlength="60"/></td>
		</tr>
	</g:if>
</table>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td><input type="button" id="btnSearch" class="input_button" value="Search" /></td>
	</tr>
	<tr>
		<td><input type="button" id="btnReset" class="input_button_negative" value="Reset" /></td>
	</tr>
</table>
<br/>
<div class="grid_wrapper clear-float">
	<table id="grid_list_advising_bank_inquiry"></table>
	<div id="grid_pager_advising_bank_inquiry"></div>
</div>
<g:render template="../commons/popups/create_advise_on_export_transaction_popup" />
<script>

$(function(){
	$("#lcNumber").keypress(function(e){
	    var charCheck = true;
	    if (e.charCode == 45){
	        charCheck = false;
	    }
	    return charCheck
	});
});
</script>