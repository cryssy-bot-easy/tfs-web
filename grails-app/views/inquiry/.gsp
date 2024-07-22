 <script type="text/javascript">
 	var referenceType = '${referenceType}';
	var serviceType = '${serviceType}';
	var documentType = '${documentType}';
	var documentClass = '${documentClass}';
	var username = '${username}';
 
 	var etsRefundCashLcCharges='${g.createLink(controller:'etsRefundCashLcCharges', action:'viewRefundCashLcCharges')}';
 	
 </script>
 
 <div id="body_forms">
 	<g:hiddenField name="referenceType" value="${referenceType}" />
	<g:hiddenField name="serviceType" value="${serviceType}" />
	<g:hiddenField name="documentType" value="${documentType}" />
	<g:hiddenField name="documentClass" value="${documentClass}" />
	<g:hiddenField name="username" value="${username}" />
   <table class="form_table_inquiry">
	  <tr>
		<td class=""> <span class="field_label"> Document Number</span> </td>
		<td class="input_width"> <g:textField name="documentNumber" class="input_field"/> </td>
		<td class=""><span class="field_label"> CIF Name </span></td>
	  	<td class="input_width"> <g:textField name="cifName" class="input_field"/> </td>
	  </tr>
	</table>
	<br/>
	<br/>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td><input type="button" id="btnSearch" class="input_button" value="Search" /></td>
	</tr>
	<tr>
		<td><input type="button" id="btnReset" class="input_button_negative" value="Reset" /></td>
	</tr>
</table>
	<br/>
	<div class="grid_wrapper">
	  <%-- JQGRID --%>
	 <table id="grid_list_refund_cash_lc_charges"></table>
	  <div id="grid_pager_refund_cash_lc_charges"></div>
	</div>
</div>