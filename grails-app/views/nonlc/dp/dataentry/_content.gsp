<div id="body_forms">
	<div id="body_forms_header">
		<div id="header_details">
			<h3 class="header_details_title" id="longNameDisplay"> ${longName} </h3> <g:hiddenField name="longName" value="${longName}" />
			<h3 class="header_details_title" id="address1Display"> ${address1} </h3> <g:hiddenField name="address1" value="${address1}" />
			<h3 class="header_details_title" id="address2Display"> ${address2} </h3> <g:hiddenField name="address2" value="${address2}" />
			<g:hiddenField name="firstName" value="${firstName}"/>
			<g:hiddenField name="middleName" value="${middleName}"/>
			<g:hiddenField name="lastName" value="${lastName}"/>
			<g:hiddenField name="tinNumber" value="${tinNumber}"/>
			<g:hiddenField name="officerCode" value="${officerCode}"/>
			<g:hiddenField name="exceptionCode" value="${exceptionCode}"/>
			<br /><br /><br />
		</div>
		<table id="header_details2">
			<tr>
				<td><span class="field_label"> CIF Number <span class="asterisk">*</span></span></td>
			  	<td>
			  		<g:textField class="input_field numericString ${serviceType == 'Negotiation' ? 'required' : ''}" name="cifNumber" readonly="readonly" value="${cifNumber}"/>
			  		<g:if test="${serviceType == 'Negotiation'}">
			  			<a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a>
			  		</g:if>
			  	</td>
			</tr>
			<tr>
				<td><span class="field_label"> CIF Name </span></td>
				<td> 
				  <g:textField class="input_field" readonly="readonly" name="cifName" value="${cifName}"/>
				</td>
			</tr>
			<tr>
				<td><span class="field_label"> Account Officer </span></td>
				<td>
				  <g:textField class="input_field" readonly="readonly" name="accountOfficer"
                                             value="${accountOfficer}"/>
				</td>
			</tr>
			<tr>
				<td><span class="field_label"> CCBD/Branch Unit Code </span></td>
				<td><g:textField class="input_field" readonly="readonly" name="ccbdBranchUnitCode"
                                             value="${ccbdBranchUnitCode}"/>
                                             <g:hiddenField name="allocationUnitCode" value="${allocationUnitCode}"/>
                                </td>
			</tr>
		</table>
	</div>
	<div id="tab_container">
		<ul id="tabs">
			<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details<br/>&#160; </span></a></li>
			<g:if test="${serviceType?.equalsIgnoreCase('Settlement')}">
				<li><a href="#attached_documents_tab" id="attachedDocumentsTab"><span class="tab_titles"> Attached Documents<br/>&#160; </span></a></li>
			</g:if>
			<g:if test="${serviceType?.equalsIgnoreCase('Settlement') && documentType?.equalsIgnoreCase('FOREIGN')}">
				<li><a href="#mt400_details_tab" id="mt400_DetailsTab"><span class="tab_titles"> MT400 Details<br/>&#160; </span></a></li>
				<li><a href="#mt202_details_tab" id="mt202_DetailsTab"><span class="tab_titles"> MT202 Details<br/>&#160; </span></a></li>
			</g:if>
			<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && !(documentType?.equalsIgnoreCase('DOMESTIC'))}">
				<li><a href="#transmittal_letter_tab" id="detailsTransmittalLetterTab"><span class="tab_titles"> Transmittal Letter<br/>&#160; </span></a></li>
			</g:if>
			<li><a href="#instructions_routing_tab" id="instructionsRoutingTab"> <span class="tab_titles"> Instructions and Routing<br/>&#160; </span></a></li>
		</ul>

		<%-- BASIC DETAILS TAB --%>
		<div id="basic_details_tab">
			<form id="basicDetailsTabForm">
				<g:if test="${serviceType?.equalsIgnoreCase('Settlement') && documentType?.equalsIgnoreCase('FOREIGN')}">
					<g:render template="../nonlc/dp/dataentry/settlement/foreign/basic_details_tab" />
				</g:if>
				<g:elseif test="${serviceType?.equalsIgnoreCase('Settlement') && documentType?.equalsIgnoreCase('DOMESTIC')}">
					<g:render template="../nonlc/dp/dataentry/settlement/domestic/basic_details_tab" />
				</g:elseif>
				<g:elseif test="${serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('FOREIGN')}">
					<g:render template="../nonlc/dp/dataentry/negotiation/foreign/basic_details_tab" />
				</g:elseif>
				<g:elseif test="${serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('DOMESTIC')}">
					<g:render template="../nonlc/dp/dataentry/negotiation/domestic/basic_details_tab" />
				</g:elseif>
				<g:elseif test="${serviceType?.equalsIgnoreCase('Cancellation')}">
					<g:render template="../nonlc/dp/dataentry/cancellation/foreign/basic_details_tab" />
				</g:elseif>
			</form>
		</div>

		<g:if test="${serviceType?.equalsIgnoreCase('Settlement')}">
			<%-- ATTACHED DOCUMENTS TAB --%>
			<div id="attached_documents_tab">
					<g:render template="../commons/tabs/attached_documents_tab" />
			</div>
		</g:if>
		
		<g:if test="${serviceType?.equalsIgnoreCase('Settlement') && documentType?.equalsIgnoreCase('FOREIGN')}">
		
			<%-- MT400 SETTLE TAB --%>
			<div id="mt400_details_tab">
				<form id="mt400_DetailsTabForm">
					<g:render template="../nonlc/commons/tabs/mt400_settle_details_tab" />
				</form>
			</div>
			
			<%-- MT202 SETTLE TAB --%>
			<div id="mt202_details_tab">
				<form id="mt202_DetailsTabForm">
					<g:render template="../nonlc/commons/tabs/mt202_settle_details_tab" />
				</form>
			</div>

		</g:if>

		<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && !(documentType?.equalsIgnoreCase('DOMESTIC'))}">
			<%-- TRANSMITTAL LETTER TAB --%>
			<div id="transmittal_letter_tab">
				<form id="detailsTransmittalLetterTabForm">
					<g:render template="../commons/tabs/details_transmittal_letter_tab" />
				</form>
			</div>
		</g:if>
							
		<%-- INSTRUCTIONS AND ROUTING TAB --%>
		<div id="instructions_routing_tab">
			<form id="instructionsAndRoutingTabForm">
				<g:render template="../commons/tabs/instructions_and_routing_tab" />
			</form>
		</div>
	</div>
</div>