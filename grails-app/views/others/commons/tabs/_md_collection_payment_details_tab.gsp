<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="collectionPaymentTabForm" />


<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">MD Currency<span class="asterisk"> *</span></span></td>
		<td class="input_width"><g:select name="mdCurrency" from="${['PHP','USD','WON','YEN']}" class="select_dropdown" noSelection="['':'Select One...']"/></td>
	</tr>
	<tr>
		<td><span class="field_label">MD Collection Amount <span class="asterisk">*</span></span></td>
		<td><g:textField name="mdCollectionAmount" class="input_field" /></td>
	</tr>
</table>
<br/>
<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Payment Mode"/>
<br /><br/>
<span class="title_label">Payment Summary</span>
<div class="grid_wrapper">
   <g:if test="${referenceType.equalsIgnoreCase('eTS') }">
      <table id="grid_list_md_collection"></table>
   </g:if>
   <g:if test="${referenceType.equalsIgnoreCase('Data Entry') }">
     <table class="grid_list_payment_edit"></table>
   </g:if>
</div>	
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />