<%-- 
(revision)
SCR/ER Number: 20161121-097
SCR/ER Description: Failed to route because of following reason: TFS Web app allows user to input MORE THAN 50 characters on the screen. However, our database accepts only 50 characters. (Redmine# 5644)
[Revised by:] John Patrick C. Bautista
[Date deployed:] 1/10/2016
Program [Revision] Details: Adjusted the max length of textfields. As for textareas, LCs and Non LCs: Importer/Buyer 4x35, Exporter/Seller 2x35.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />  
<g:hiddenField name="documentType" value="${documentType}" /> 
<g:hiddenField name="documentClass" value="${documentClass}" /> 
<g:hiddenField name="subType1" value="${subType1}" />
<g:hiddenField name="subType2" value="${subType2}" />
<g:hiddenField name="referenceType" value="${referenceType}" /> 
<g:hiddenField name="form" value="basicDetailsTabForm" />
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value=""/> </td>
	 	<g:if test="${ subType1.equalsIgnoreCase('First') }"> 
			<td class="label_width"> <span class="field_label"> 2nd Advising Bank </span> </td>
			<td class="input_width"> <g:textField name="advisingBank" class="input_field" readonly='readonly' /></td>
	 	</g:if> 
		<g:if test="${ subType1.equalsIgnoreCase('Second') }">
			<td colspan="2"> <span class="title_label"> Other Bank Charges (for Payment via MC) </span></td>
		</g:if>	 
	</tr>
	<tr>
		<td> <span class="field_label"> Document Number </span> </td>
		<td> <g:textField name="documentNumber" class="input_field" readonly="readonly" /> </td>
		<g:if test="${ subType1.equalsIgnoreCase('First') }">		
			<td rowspan="2"> <span class="field_label"> 2nd Advising Bank Address </span> </td>
			<td rowspan="2"> <g:textArea name="advisingBankAddress" class="textarea" rows="2" readonly="readonly"> </g:textArea> </td>
		</g:if>				
		<g:if test="${ subType1.equalsIgnoreCase('Second') }">
			<td class="label_width"> <span class="field_label"> Receiving Bank  </span> </td>
			<td class="input_width"> <g:textField name="receivingBank" class="input_field" readonly="readonly" /></td>
		</g:if>			
	</tr>
	<tr>
		<td> <span class="field_label"> Exporter CB Code <br/> (if without CIF No.) </span> </td>
		<td> <g:textField name="exporterCbCode" class="input_field" readonly="readonly" /> </td>
		<g:if test="${ subType1.equalsIgnoreCase('Second') }">	
			<td> <span class="field_label"> Total Amount of Other <span class="asterisk"> * </span> <br/> Bank Charges </span></td>
			<td> <g:textField name="totalAmountOtherBankCharges" class="input_field" /></td>
		</g:if>		
	</tr>
	<tr>
		<td> <span class="field_label"> Exporter Name (Drawer) </span> </td>
		<td> <g:textField name="exporterName" class="input_field" readonly="readonly" /> </td>
		<td> <span class="field_label"> Date of Cancellation </span> </td>
		<td> <g:textField name="dateOfCancellation" class="datepicker_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td> <span class="field_label"> Exporter Address </span> </td>
		<td> <g:textArea name="exporterAddress" class="textarea" rows="4" readonly="readonly" value="" /> </td>
		<g:if test="${ subType1.equalsIgnoreCase('First') }">	
			<td> <span class="field_label"> Related Reference </span> </td>
			<td> <g:textField name="relatedReference" class="input_field"  value="NON-REF"/></td>
		</g:if>		
	</tr>
	<tr>
		<td> <span class="field_label"> Importer Name (Drawer) </span> </td>
		<td> <g:textField name="importerName" class="input_field" readonly="readonly" /> </td>
		<g:if test="${ subType1.equalsIgnoreCase('First') }">
			<td> <span class="field_label"> Narrative </span> </td>
			<td> <g:textArea name="narrative" class="textarea" rows="2"></g:textArea></td>			
		</g:if>		
	</tr>
	<tr>
		<td> <span class="field_label"> LC Type </span> </td>
		<td> <g:textField name="lcType" class="input_field" readonly="readonly" /> </td>
		<g:if test="${ subType1.equalsIgnoreCase('First') }">
			<td> <span class="field_label"> Send MT 799? </span> </td>
			<td> <g:radioGroup name="sendMt799Flag" labels="['Yes', 'No']" values="[1,2]" value="2"> ${it.radio} ${it.label} &#160; &#160;</g:radioGroup></td>			
		</g:if>		
	</tr>
	<tr>
		<td> <span class="field_label"> LC Number </span> </td>
		<td> <g:textField name="lcNumber" maxlength="16" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> LC Issue Date </span> </td>
		<td> <g:textField name="lcIssueDate" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> LC Tenor Term </span> </td>
		<td> <g:textField name="lcTenorTerm" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> If Usance: Usance Term </span> </td>
		<td> <g:textField name="usanceTerm" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> LC Currency </span> </td>
		<td> <g:textField name="lcCurrency" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> LC Amount </span> </td>
		<td> <g:textField name="lcAmount" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> LC Expiry Date </span> </td>
		<td> <g:textField name="lcExpiryDate" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> Confirmed by UCPB? </span> </td>
		<td> <g:textField name="confirmedByUcpbFlag" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> Issuing Bank </span> </td>
		<td> <g:textField name="issuingBank" class="input_field" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td> <span class="field_label"> Reimbursing Bank </span> </td>
		<td> <g:textField name="reimbursingBank" class="input_field" readonly="readonly" /> </td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />