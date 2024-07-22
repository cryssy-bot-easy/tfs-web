<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td><g:textField name="etsNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Date</span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Refund Currency</span></td>
		<td><g:textField name="refundCurrency" class="input_field" value="PHP" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Refund Amount</span></td>
		<td><g:textField name="refundAmount" class="input_field" readonly="readonly"/></td>
	</tr>	
	<tr>
		<td class="label_width"><span class="field_label">With 2% CWT</span></td>
		<td><g:radioGroup name="cwtRadio" values="['Yes','No']" labels="['Yes','No']" >
			<label>${it.radio}&#160;${it.label}</label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Corres Bank</span></td>
		<td><g:textField name="corresBank" class="input_field" />&#160;<g:select from="${['SWIFT CD']}" name="corresDropdown" class="select_dropdown" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label single_indent">Type Of Account</span></td>
		<td><g:textField name="accountType" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Country Code</span></td>
		<td><g:select from="${['Code 1','Code 2','Code N'] }" name="countryCode" class="select_dropdown" noSelection="['':'Select One']"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Shipment Date</span></td>
		<td><g:textField name="shipmentDate" class="datepicker_field2"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Credit Facility Code</span></td>
		<td><g:radioGroup name="facilityCode" values="['1','2']" labels="['1','2']" >
			<label>${it.radio}&#160;${it.label}&#160;</label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">AP-Remittance</span></td>
		<td><g:radioGroup name="apRemittance" values="['Yes','No']" labels="['Yes','No']" >
			<label>${it.radio}&#160;${it.label}&#160;</label>
			</g:radioGroup>
		</td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />