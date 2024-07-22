<div id="body_forms" <g:if test="${windowed}">class="window"</g:if>>
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
				<td><span class="field_label"> CIF Number </span></td>
				<td>
				  	<g:textField name="cifNumber" class="input_field textFormat-7" readonly="readonly" value="${cifNumber}"/>
				  	<g:if test="${!hasCif}">
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
				<td><g:textField name="ccbdBranchUnitCode" class="input_field textFormat-3" readonly="readonly" value="${ccbdBranchUnitCode}"/></td>
				<g:hiddenField name="allocationUnitCode" value="${allocationUnitCode }"/>
			</tr>
		</table>
	</div>
	<div id="tab_container"> 
		<ul id="tabs">
			<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details<br/>&#160; </span></a></li>
			<li><a href="#attached_documents_tab" id="attachedDocumentsTab"><span class="tab_titles"> Attached<br/>Documents </span></a></li>
			<g:if test="${(documentType == 'DOMESTIC' && settleFlag != 'Y') || documentType == 'FOREIGN'}">
				<%-- remove tab when viewed thru view approved ets link --%>
			   	<g:if test="${!windowed?.equalsIgnoreCase('true')}">
					<li><a href="#cash_lc_payment_tab" id="cashLcPaymentTab"><span class="tab_titles"> Negotiation<br/>Payment </span></a></li>
					<g:if test="${documentType == 'DOMESTIC' && settleFlag != 'Y'}">
				<li><a href="#proceeds_to_teller_tab" id="proceedsDetailsTab"> <span class="tab_titles"> Settlement to<br/>Beneficiary </span></a></li>
					</g:if>
					<li><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges<br/>&#160; </span></a></li>
					<li><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges<br/>Payment </span></a></li>
				</g:if>
			</g:if>
            <g:if test="${serviceType?.equalsIgnoreCase('Settlement')}">
                <g:if test="${settlementMode?.contains('TR')}">
                    <g:each in="${paymentsMade}"><g:if test="${it?.PAYMENTINSTRUMENTTYPE?.equalsIgnoreCase("TR_LOAN")}">
                        <li><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br/>&#160; </span></a></li>
                    </g:if></g:each>
                </g:if>
            </g:if>
            %{--<g:if test="${pddtsFlag?.equals("Y")}">--}%
                %{--<li id="pddtsTabLi"><a href="#pddts_tab" id="pddtsTab"><span class="tab_titles"> PDDTS<br>&#160;</span></a></li>--}%
            %{--</g:if>--}%
            %{--<g:if test="${pddtsFlag?.equals("Y")}">--}%
                %{--<li id="mt103TabLi"><a href="#mt103_tab" id="mt103Tab"><span class="tab_titles"> MT103<br>&#160;</span></a></li>--}%
            %{--</g:if>--}%
			<li><a href="#instructions_routing_tab" id="instructionsRoutingTab"> <span class="tab_titles"> Instructions and<br/>Routing </span></a></li>
		</ul>
		
		<%-- BASIC DETAILS TAB --%>
		<div id="basic_details_tab">						
			<form id="basicDetailsTabForm">
				<g:if test="${documentClass == 'DA'}">
					<g:render template="../nonlc/da/ets/settlement/foreign/basic_details_tab" />
				</g:if>
				<g:elseif test="${documentClass == 'DP'}">
					<g:if test="${documentType == 'FOREIGN'}">
						<g:render template="../nonlc/dp/ets/settlement/foreign/basic_details_tab" />
					</g:if>
					<g:if test="${documentType == 'DOMESTIC'}">
						<g:render template="../nonlc/dp/ets/settlement/domestic/basic_details_tab" />
					</g:if>
				</g:elseif>
				<g:elseif test="${documentClass == 'DR'}">
					<g:render template="../nonlc/dr/ets/settlement/foreign/basic_details_tab" />
				</g:elseif>
				<g:elseif test="${documentClass == 'OA'}">
					<g:render template="../nonlc/oa/ets/settlement/foreign/basic_details_tab" />
				</g:elseif>
			</form>
		</div>
		
		<%-- ATTACHED DOCUMENTS TAB --%>
		<div id="attached_documents_tab">
<%--			<form id="attachedDocumentsTabForm">--%>
				<g:render template="../commons/tabs/attached_documents_tab" />
<%--			</form>--%>
		</div>
		
		<g:if test="${(documentType == 'DOMESTIC' && settleFlag != 'Y') || documentType == 'FOREIGN'}">
			<%-- remove tab when viewed thru view approved ets link --%>
			<g:if test="${!windowed?.equalsIgnoreCase('true')}">
				<%-- NEGOTIATION PAYMENT --%>
				<div id="cash_lc_payment_tab">
					<form id="cashLcPaymentTabForm">
						<%--<g:render template="../nonlc/commons/tabs/negotiation_payment_tab" />--%>
		                <g:render template="../commons/tabs/cash_lc_payment_tab" />
		                %{--<g:render template="../product/commons/tabs/product_payment_tab" />--}%
		            </form>
				</div>
				
				<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && settleFlag != 'Y'}">
				<%-- PROCEEDS TO TELLER --%>
					<div id="proceeds_to_teller_tab">
				<form id="proceedsDetailsTabForm">
							<g:render template="../commons/tabs/proceeds_details_tab" />
							<%--<g:render template="../nonlc/commons/tabs/proceeds_to_teller_tab" />--%>
						</form>
					</div>
				</g:if>
				
				<%-- CHARGES TAB --%>
				<div id="charges_tab">
					<form id="chargesTabForm">
				 		<%--<g:render template="../nonlc/commons/tabs/charges_tab" />--%>
		                 <g:render template="../commons/tabs/charges_tab" />
		                 %{--<g:render template="../product/commons/tabs/charges_tab" />--}%
					</form>
				</div>
				
				<%-- CHARGES PAYMENT TAB --%>
				<div id="charges_payment_tab">
					<form id="chargesPaymentTabForm">
				 		<g:render template="../commons/tabs/charges_payment_tab" />
		                 %{--<g:render template="../product/commons/tabs/charges_payment_tab" />--}%
					</form>
				</div>
			</g:if>
		</g:if>

        <g:if test="${serviceType?.equalsIgnoreCase('Settlement')}">
            <%-- LOAN DETAILS TAB --%>
            <g:if test="${settlementMode?.contains('TR')}">
                <g:each in="${paymentsMade}"><g:if test="${it.PAYMENTINSTRUMENTTYPE?.equalsIgnoreCase("TR_LOAN")}">
                    <div id="loan_details_tab">
                        <form id="loanDetailsTabForm">
                            <g:render template="../commons/tabs/loan_details_tab"/>
                        </form>
                    </div>
                </g:if></g:each>
            </g:if>
        </g:if>
		
        %{--<form id="pddtsTabForm"  >--}%
            %{--<div id="pddts_tab" >--}%
                %{--<g:render template="../commons/tabs/pddts_tab"/>--}%
            %{--</div>--}%
        %{--</form>--}%

        %{--<form id="mt103TabForm"  >--}%
            %{--<div id="mt103_tab" >--}%
                %{--<g:render template="../commons/tabs/mt_103_tab"/>--}%
            %{--</div>--}%
        %{--</form>--}%

		<%-- INSTRUCTIONS AND ROUTING TAB --%>
		<div id="instructions_routing_tab">
			<form id="instructionsAndRoutingTabForm">
				<g:render template="../commons/tabs/instructions_and_routing_tab" />
			</form>
		</div>
	</div>
</div>

%{--<g:render template="/commons/popups/override_confirmation"/>--}%

<g:javascript src="new/override_authorization_utils.js" />
<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'payAuthorizeDiv',
                  overrideAuthDivBg: 'payAuthorizeBg',
                  overrideAuthUsernameId: 'payAuthorizeUsername',
                  overrideAuthPasswordId: 'payAuthorizePassword',
                  overrideAuthConfirmId: 'payAuthorizeConfirm',
                  overrideAuthCancelId: 'payAuthorizeCancel',
                  overrideAuthCasaPaymentId: 'payAuthorizeCasaId'
          ]"/>

<g:render template="/commons/popups/override_authorization"
          model="[overrideAuthDivId: 'unpayAuthorizeDiv',
                  overrideAuthDivBg: 'unpayAuthorizeBg',
                  overrideAuthUsernameId: 'unpayAuthorizeUsername',
                  overrideAuthPasswordId: 'unpayAuthorizePassword',
                  overrideAuthConfirmId: 'unpayAuthorizeConfirm',
                  overrideAuthCancelId: 'unpayAuthorizeCancel',
                  overrideAuthCasaPaymentId: 'unpayAuthorizeCasaId'
          ]"/>