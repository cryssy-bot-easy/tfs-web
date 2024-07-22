<%@ page import="net.ipc.utils.DateUtils" %>
<div id="body_forms">
	<div id="body_forms_header">
		<table id="header_details" class="tabs_form_table">
			<tr>
			  <td class="label_width"> <span class="field_label"> Document Number </span> </td>
			  <td class="input_width"> <g:textField name="documentNumber" class="input_field"/> </td>
			</tr>
			<tr>
				<td>&#160;</td>
			</tr>
			<tr> 
			  <td> <span class="field_label"> Transaction Type </span> </td>
			  <td> 
				<g:radioGroup name="transactionTypeFlag" labels="['RTGS Peso','Foreign']" values="['P','F']">
				    ${it.radio}&#160;&#160;&#160;<g:message code="${it.label}" />
			    </g:radioGroup>
			  </td>
			</tr>
			<tr>
				<td>&#160;</td>
			</tr>
			<tr> 
			  <td> <span class="field_label"> SWIFT Address </span> </td>
			  <td> 
					<g:select name="swiftAddress" from="${['SWIFT Code 1', 'SWIFT Code 2', 'SWIFT Code N']}" class="select_dropdown" noSelection="['':'Select One']"/>
			  </td>
			</tr>
		</table>
		<table id="header_details2">
			<tr>
			  <td> <span class="field_label"> Date </span> </td>
			  <td> <g:textField name="outgoingMtDate" class="input_field" readonly="readonly"  value="${DateUtils.shortDateFormat(new Date())}"/> </td>
			</tr>
			<tr> 
			  <td> <span class="field_label"> Funding Number </span> </td>
			  <td> <g:textField name="fundingNumber" class="input_field"/> </td>
			</tr>
			<tr> 
			  <td> <span class="field_label"> Destination </span> </td>
			  <td> <g:textField name="outgoingMtDestination" class="input_field" readonly="readonly" /> </td>
			</tr>
		</table>
	</div>
	<div id="tab_container">
	<ul>
		<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> MT Details </span></a></li>
   		 		
  		<li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
  	</ul>

     	<g:form id="basicDetailsTabForm">
		   	<%-- TAB BASIC DETAILS --%>  	
			     <div id="basic_details_tab">
					<g:if test="${'103'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt103/mt_details_tab" />
					</g:if>
					<g:if test="${'199'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt199/mt_details_tab" />
					</g:if>
					<g:if test="${'202'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt202/mt_details_tab" />
					</g:if>
					<g:if test="${'299'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt299/mt_details_tab" />
					</g:if>
					<g:if test="${'499'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt499/mt_details_tab" />
					</g:if>
					<g:if test="${'742'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt742/mt_details_tab" />
					</g:if>
					<g:if test="${'752'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt752/mt_details_tab" />
					</g:if>
					<g:if test="${'799'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt799/mt_details_tab" />
					</g:if>
					<g:if test="${'999'.equalsIgnoreCase(referenceType)}">
						<g:render template="../others/imports/dataentry/outgoing_mt/mt999/mt_details_tab" />
					</g:if>
			     </div>
      	</g:form>
		<g:form id="instructionsAndRoutingTabForm">
		<div id="instructions_tab">
			<g:render template="/commons/tabs/instructions_and_routing_tab" />
		</div>
		</g:form>
		
	</div> <%-- End of TABS --%>
		
</div>