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
				<td><span class="field_label"> CIF Number </span></td>
				<td>
				  	<g:textField name="cifNumber" class="input_field textFormat-7" readonly="readonly" value="${cifNumber}"/>
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
			<li><a href="#negotiation_payment_tab" id="cashLcPaymentTab"><span class="tab_titles"> Negotiation Payment<br/>&#160; </span></a></li>

            %{--<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">--}%
            <g:if test="${documentType == 'DOMESTIC' && settleFlag != 'Y'}">
                <li><a href="#proceeds_to_teller_tab" id="proceedsDetailsTab"> <span class="tab_titles"> Settlement to Beneficiary<br/>&#160; </span></a></li>
            </g:if>

            %{--<g:if test="${pddtsFlag?.equals("Y")}">--}%
                <li id="pddtsTabLi"><a href="#pddts_tab" id="pddtsTab"><span class="tab_titles"> PDDTS<br>&#160;</span></a></li>
            %{--</g:if>--}%
            %{--<g:if test="${mt103Flag?.equals("Y")}">--}%
                <li id="mt103TabLi"><a href="#mt103_tab" id="mt103Tab"><span class="tab_titles"> MT103<br>&#160;</span></a></li>
            %{--</g:if>--}%
			<g:if test="${serviceType?.equalsIgnoreCase('Settlement')}">
				<g:if test="${settlementMode?.contains('TR')}">
					<g:each in="${paymentsMade}">
						<g:if test="${it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("TR_LOAN")}"> 
							<li><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br/>&#160; </span></a></li>
						</g:if>
					</g:each>
				</g:if>
			</g:if>
			<li><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges<br/>&#160; </span></a></li>
			<li><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges Payment<br/>&#160; </span></a>
		</ul>
		
		<%-- BASIC DETAILS TAB --%>
		<div id="basic_details_tab">						
			<form id="basicDetailsTabForm">
				<g:if test="${documentClass?.equalsIgnoreCase('DA')}">
					<g:render template="../nonlc/da/payment/settlement/foreign/basic_details_tab" />
				</g:if>
				<g:elseif test="${documentClass?.equalsIgnoreCase('DP')}">
					<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
						<g:render template="../nonlc/dp/payment/settlement/foreign/basic_details_tab" />
					</g:if>
					<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
						<g:render template="../nonlc/dp/payment/settlement/domestic/basic_details_tab" />
					</g:if>
				</g:elseif>
				<g:elseif test="${documentClass?.equalsIgnoreCase('DR')}">
					<g:render template="../nonlc/dr/payment/settlement/foreign/basic_details_tab" />
				</g:elseif>
				<g:elseif test="${documentClass?.equalsIgnoreCase('OA')}">
					<g:render template="../nonlc/oa/payment/settlement/foreign/basic_details_tab" />
				</g:elseif>
			</form>
		</div>
		
		<%-- NEGOTIATION PAYMENT --%>
		<div id="negotiation_payment_tab">
			<form id="cashLcPaymentTabForm">
				<g:render template="../commons/tabs/cash_lc_payment_tab" />
            </form>
		</div>
		
		<%-- LOAN DETAILS --%>
		<g:if test="${serviceType?.equalsIgnoreCase('Settlement')}">
			<g:if test="${settlementMode?.contains('TR')}">
				<g:each in="${paymentsMade}">
					<g:if test="${it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("TR_LOAN")}">
						<div id="loan_details_tab">
							<form id="loanDetailsTabForm">
								<g:render template="../commons/tabs/loan_details_tab"/>
							</form>
						</div>
					</g:if>
				</g:each>
			</g:if>
		</g:if>

        <g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && settleFlag != 'Y'}">
        <%-- PROCEEDS TO BENEFICIARY --%>
            <div id="proceeds_to_teller_tab">
                <form id="proceedsDetailsTabForm">
                    %{--<g:render template="../nonlc/commons/tabs/proceeds_to_teller_tab" />--}%
                    <g:render template="../commons/tabs/proceeds_details_tab" />
                </form>
            </div>
        </g:if>

        %{--<g:if test="${pddtsFlag?.equals("Y")}">--}%
        <div id="pddts_tab">
            <form id="pddtsTabForm">
                <g:render template="../commons/tabs/pddts_tab"/>
            </form>
        </div>
        %{--</g:if>--}%

        %{--<g:if test="${mt103Flag?.equals("Y")}">--}%
        <div id="mt103_tab">
            <form id="mt103TabForm">
                <g:render template="../commons/tabs/mt_103_tab"/>
            </form>
        </div>
        %{--</g:if>--}%
		
		<%-- CHARGES TAB --%>
		<div id="charges_tab">
			<form id="chargesTabForm">
		 		<g:render template="../commons/tabs/charges_tab" />
<%--                 <g:render template="../product/commons/charges_tab" />--%>
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
		
	</div>
</div>



<script type="text/javascript">
    var pddtsFlag = '${pddtsFlag}';
    var mt103Flag = '${mt103Flag}';

    $(document).ready(function() {
        $("#pddtsTabLi").hide();
        $(".viewPddtsLi").hide();
        $("#mt103TabLi").hide();
        $(".hiddenViewMt").hide();
        
<%--        $(".viewMt103Li").hide();--%>

        if (pddtsFlag == "Y") {
            $("#pddtsTabLi").show();
            $(".viewPddtsLi").show();
        }

        if (mt103Flag == "Y") {
            $("#mt103TabLi").show();
            $(".viewMt103Li").show();
            $(".hiddenViewMt").show();
        }
    });
</script>

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
