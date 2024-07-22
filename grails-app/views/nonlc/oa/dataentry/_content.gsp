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
			  		<g:textField name="cifNumber" class="input_field textFormat-7 ${serviceType == 'Negotiation' ? 'required' : ''}" readonly="readonly" value="${cifNumber}"/>
			  		<g:if test="${serviceType == 'Negotiation'}">
			  			<a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a>
			  		</g:if>
			  	</td>
			</tr>
			<tr> 
				<td><span class="field_label"> CIF Name </span></td>
				<td><g:textField name="cifName" class="input_field textFormat-20" readonly="readonly" value="${cifName}"/></td>
			</tr>
			<tr> 
				<td><span class="field_label"> Account Officer </span></td>
				<td><g:textField name="accountOfficer" class="input_field" readonly="readonly" value="${accountOfficer}"/></td>
			</tr>
			<tr> 
				<td><span class="field_label"> CCBD/Branch Unit Code </span></td>
				<td><g:textField name="ccbdBranchUnitCode" class="input_field textFormat-3" readonly="readonly" value="${ccbdBranchUnitCode}" /></td>
				<g:hiddenField name="allocationUnitCode" value="${allocationUnitCode }"/>
			</tr>
		</table>
	</div>
	<div id="tab_container"> 
		<ul id="tabs">
			<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details<br/>&#160; </span></a></li>
			<g:if test="${serviceType?.equalsIgnoreCase('Settlement') }">
				<li><a href="#attached_documents_tab" id="attachedDocumentsTab"><span class="tab_titles"> Attached Documents<br/>&#160; </span></a></li>
				<li><a href="#mt103_details_tab" id="mt103Tab"><span class="tab_titles"> MT103 Details<br/>&#160; </span></a></li>
<%--				<g:if test="${settlementMode.contains('TR')}">--%>
<%--					<g:each in="${paymentsMade}"><g:if test="${it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("TR_LOAN")}">--%>
<%--					<li><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br/>&#160; </span></a></li>--%>
<%--					</g:if></g:each>--%>
<%--				</g:if>--%>
			</g:if>
			<li><a href="#instructions_routing_tab" id="instructionsRoutingTab"> <span class="tab_titles"> Instructions and Routing<br/>&#160; </span></a></li>
		</ul>
		
		<%-- BASIC DETAILS TAB --%>
		<div id="basic_details_tab">						
			<form id="basicDetailsTabForm">
				<g:if test="${serviceType?.equalsIgnoreCase('Settlement')}">
					<g:render template="../nonlc/oa/dataentry/settlement/foreign/basic_details_tab" />
				</g:if>
				<g:elseif test="${serviceType?.equalsIgnoreCase('Open Account') || serviceType?.equalsIgnoreCase('Negotiation')}">
					<g:render template="../nonlc/oa/dataentry/negotiation/foreign/basic_details_tab" />
				</g:elseif>
				<g:elseif test="${serviceType?.equalsIgnoreCase('Cancellation')}">
					<g:render template="../nonlc/oa/dataentry/cancellation/foreign/basic_details_tab" />
				</g:elseif>
			</form>
		</div>
		
		<g:if test="${serviceType?.equalsIgnoreCase('Settlement') }">
			<%-- ATTACHED DOCUMENTS TAB --%>
			<div id="attached_documents_tab">
					<g:render template="../commons/tabs/attached_documents_tab" />
			</div>
			
			<%-- MT103 DETAILS TAB --%>
			<div id="mt103_details_tab">
				<form id="mt103TabForm">
					<g:render template="../nonlc/commons/tabs/mt103_details_tab" />
				</form>
			</div>
			
			<%-- LOAN DETAILS TAB --%>
<%--			<g:if test="${settlementMode.contains('TR')}">--%>
<%--			<g:each in="${paymentsMade}"><g:if test="${it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("TR_LOAN")}">--%>
<%--			<div id="loan_details_tab">--%>
<%--				<form id="loanDetailsTabForm">--%>
<%--					<g:render template="../commons/tabs/loan_details_tab"/>--%>
<%--				</form>--%>
<%--			</div>--%>
<%--			</g:if></g:each>--%>
<%--			</g:if>--%>
		</g:if>
							
		<%-- INSTRUCTIONS AND ROUTING TAB --%>
		<div id="instructions_routing_tab">
			<form id="instructionsAndRoutingTabForm">
				<g:render template="../commons/tabs/instructions_and_routing_tab" />
			</form>
		</div>
	</div>
</div>
