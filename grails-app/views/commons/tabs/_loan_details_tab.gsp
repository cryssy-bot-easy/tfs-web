<g:javascript src="utilities/dataentry/commons/loan_details_utility.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="loanDetails" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>

<g:if test="${!(serviceType?.equalsIgnoreCase('UA Loan Settlement') ||
        serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT'))}">

    <g:each in="${paymentsMade}">
   	%{--<g:hiddenField name="withCramApproval" value="${withCramApproval ?: (it.WITHCRAMAPPROVAL == 1) ? true : false}" />--}%
    <%--if TR/IB Loan--%>
     <g:if test="${(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("TR_LOAN") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("DTR_LOAN")) ||
             it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("IB_LOAN") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("DBP")}">

         <g:hiddenField name="withCramApproval" value="${withCramApproval ?: (it.WITHCRAMAPPROVAL == 1) ? true : false}" />

<%-- <div class="ib-tr-dbp-dtr-loan"> --%>
	<table class="tabs_forms_table">
<%--		<tr>--%>
<%--                    <g:if test="${documentType == 'DOMESTIC'}">--%>
<%--                        <td colspan="2"><p class="p_header field_label">If DBP/DTR Loan: (Regular Sight and Standby)</p></td>--%>
<%--                    </g:if>--%>
<%--                    <g:if test="${documentType == 'FOREIGN'}">--%>
<%--                        <td colspan="2"><p class="p_header field_label">If BP/TR Loan: (Regular Sight and Standby)</p></td>--%>
<%--                    </g:if>--%>
<%--                </tr>--%>

				<tr>
					<td class="label_width"><span class="field_label">Type of Loan</span></td>
						<%-- for negotiation only--%>
					<g:if test="${documentType == 'DOMESTIC'}">
						<td class="input_width"><g:textField  name="typeOfLoan" class="input_field" readonly="readonly" value="D${it.PAYMENTINSTRUMENTTYPE}"/></td>
					</g:if>
					<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
						<td class="input_width">
			<%--                <g:select name="typeOfLoan" value="${typeOfLoan}" class="select_dropdown" from="${['IB Loan','TR Loan', 'UA Loan']}" noSelection="['':'SELECT ONE...']" />--%>
			             	<g:textField  name="typeOfLoan" class="input_field" readonly="readonly" value="${it.PAYMENTINSTRUMENTTYPE}"/>
			            </td>
					</g:if>
					<td class="label_width"><span class="field_label">Booking Currency </span></td>
                   	<td class="input_width">
<%--                        <g:radioGroup name="bookingCurrency" labels="['USD','PHP']" values="['USD','PHP']" disabled="disabled" value="${it.BOOKINGCURRENCY}">--%>
<%--                            ${it.radio}&#160;<g:message code="${it.label}" />--%>
<%--                        </g:radioGroup>--%>
                       	<g:textField  name="bookingCurrency" class="input_field" readonly="readonly" value="${it.BOOKINGCURRENCY}"/>
                   	</td>
				</tr>      
                <tr>
                    <td><span class="field_label"> Interest Rate (in %) </span></td>
                    <td class="input_width"><g:textField name="interestRate" class="input_field" readonly="readonly" value="${it.INTERESTRATE}"/></td>
                    <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
	                <td class="label_width"> <span class="field_label"> Facility ID</span> </td>
					<td> <g:textField class="input_field" name="facilityId" readonly="readonly" value="${it.FACILITYID}"/></td>
					</g:if>
                </tr>
                <tr>
                    <td><span class="field_label"> Interest Term </span></td>
                    <td>
                        <g:textField name="interestTerm" class="input_field" readonly="readonly" value="${it.INTERESTTERM}"/>
                        %{--<g:radioGroup name="interestTermCode" labels="['Months','Days']" values="['M','D']" value="${it.INTERESTTERMCODE}" disabled="true">--}%
                            %{--${it.radio}&#160;<g:message code="${it.label}" />--}%
                        %{--</g:radioGroup>--}%

                    </td>
                    <td><span class="field_label"> Interest Code </span></td>
                    <td><g:textField name="interestTermCode" class="input_field" readonly="readonly" value="${it.INTERESTTERMCODE}"/></td>
                </tr>
                <tr>
                    <td><span class="field_label"> Loan Term </span></td>
                    <td>
                        <g:textField name="loanTerm" class="input_field" value="${it.LOANTERM}" readonly="readonly"/>
                        %{--<g:radioGroup name="loanTermCode" labels="['Months','Days']" values="['M','D']" value="${it.LOANTERMCODE}" disabled="true">--}%
                            %{--${it.radio}&#160;<g:message code="${it.label}" />--}%
                        %{--</g:radioGroup>--}%
                    </td>
                    <td><span class="field_label"> Loan Code </span></td>
                    <td><g:textField name="loanTermCode" class="input_field" readonly="readonly" value="${it.LOANTERMCODE}"/></td>
                </tr>
                <tr>
                    <td><span class="field_label"> Loan Maturity Date </span></td>
<%--                     <td><g:textField name="loanDetailsMaturityDate" class="input_field" readonly="readonly" value="${it.LOANMATURITYDATE}"/></td> --%>
                    <td><g:textField name="loanDetailsMaturityDate" class="input_field" value="${it.LOANMATURITYDATE}" readonly="readonly"/></td>
                    <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
                    <td><span class="field_label">PN Number</span></td>
                    <td><g:textField name="pnNumber" class="input_field" readonly="readonly" value="${it.PNNUMBER}"/></td>
                    </g:if>
                </tr>
<%--                <tr>--%>
<%--                    <td><p class="field_label"> With prior approval in the CRAM? (For DTR Loan) </p></td>--%>
<%--                    <td>--%>
<%--                        <g:radioGroup name="cramFlag" labels="['YES','NO']" values="['Y','N']" disabled="disabled" value="">--%>
<%--                            ${it.radio}&#160;<g:message code="${it.label}" />--%>
<%--                        </g:radioGroup>--%>
<%--                    </td>--%>
<%--                </tr>--%>
                <tr>
                    <td><span class="field_label">Payment Code</span></td>
                    <td><g:textField name="paymentCode" class="input_field" readonly="readonly" value="${it.PAYMENTCODE}" /></td>
                    <td><span class="field_label">Agri - Agra BSP Tagging</span></td>
                    <td>
						<g:textField name="agriAgraTagging" class="input_field" value="${it.AGRIAGRATAGGING}" readonly="readonly"/>
                        <%--<g:select from="${['Agri','Agra'] }" keys="${[]}" agriAgraBspTagging" value="${agriAgraBspTagging}" class="select_dropdown" noSelection="['':'Regular']"/>--%>
                    </td>
                </tr>
            </table>
        </g:if>
        %{--</div>--}%

        %{--<div class="ua-dua-loan">--}%
	<br />

        <%--if UA/DUA Loan--%>
        <g:if test="${it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("UA_LOAN") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("DUA_LOAN")}">
            <table class="tabs_forms_table">
                <tr>
                    <g:if test="${documentType == 'DOMESTIC'}">
                        <td colspan="2"><p class="p_header field_label">If DUA Loan: (Regular Usance)</p></td>
                    </g:if>
                    <g:if test="${documentType == 'FOREIGN'}">
                        <td colspan="2"><p class="p_header field_label">If UA Loan: (Regular Usance)</p></td>
                    </g:if>
                </tr>
<%--                <tr>--%>
<%--                    <td class="label_width"><span class="field_label">Booking Currency </span></td>--%>
<%--                    <td class="input_width"><g:radioGroup name="bookingCurrency" labels="['USD','PHP']" values="['USD','PHP']" disabled="disabled" value="${it.BOOKINGCURRENCY}" >--%>
<%--                        ${it.radio}&#160;<g:message code="${it.label}" />--%>
<%--                    </g:radioGroup>--%>
<%--                     </td>--%>
<%--                 </tr>--%>
                 <tr>
	                <td class="label_width"> <span class="field_label"> Facility ID</span> </td>
					<td> <g:textField class="input_field" name="facilityId" readonly="readonly" value="${facilityId ?: it.FACILITYID}"/></td>
				</tr>	
                 <tr>                   
                   
                    <td class="label_width"><span class="field_label">Loan Maturity Date</span>
                    <td><g:textField name="loanDetailsMaturityDate" class="input_field" readonly="readonly" value="${it.LOANMATURITYDATE}"/></td>
                </tr>
                <tr>
                    <td><span class="field_label">PN Number</span></td>
                    <td><g:textField name="pnNumber" class="input_field" readonly="readonly" value="${it.PNNUMBER}"/></td>
                </tr>
                <tr>
                    <td><span class="field_label">Payment Code</span></td>
<%--                    <td><g:select from="${['0','1','2','3','4','5','6'] }" noSelection="${['':'SELECT ONE...']}" name="paymentCode" class="select_dropdown paymentCode" value=""/></td>--%>
                    <td><g:textField name="paymentCode" class="input_field" readonly="readonly" value="${it.PAYMENTCODE}" /></td>
                </tr>
                <%--TODO: confirm this--%>
                <tr>
                    <td><span class="field_label">Agri - Agra BSP Tagging</span></td>
                    <td>
                    	<g:textField name="agriAgraTagging" class="input_field" value="${it.AGRIAGRATAGGING}" readonly="readonly"/>
                        <%--<g:select from="${['Agri','Agra'] }" name="agriAgraBspTagging" value="${agriAgraBspTagging}" class="select_dropdown" noSelection="['':'Regular']"/>--%>
                    </td>
                </tr>                
            </table>
            %{--</div>--}%
            <br><br>
        </g:if>
    </g:each>
</g:if>


<%-- For UA Loan Settlement only --%>
<g:if test="${serviceType == 'UA Loan Settlement' || serviceType == 'UA_LOAN_SETTLEMENT'}">
%{--<table class="tabs_forms_table">--}%
	%{--<tr>--}%
		%{--<td class="label_width"><span class="field_label">If over-availment: With prior approval in CRAM?</span></td>--}%
		%{--<td class="input_width"><g:textField name="cramFlag" value="${withCramApproval}" class="input_field" readonly="readonly"/></td>--}%
	%{--</tr>--}%
%{--<%--	<tr>--%>--}%
%{--<%--		<td class="label_width"></td>--%>--}%
%{--<%--		<td class="label_width"><span class="field_label">Booking Currency</span></td>--%>--}%
%{--<%--		<td>--%>--}%
%{--<%--			<g:radioGroup name="bookingCurrency" value="${bookingCurrency}" labels="['USD','PHP']" values="['USD','PHP']" disabled="true">--%>--}%
%{--<%--		        ${it.radio}&#160;<g:message code="${it.label}" />--%>--}%
%{--<%--		    </g:radioGroup>--%>--}%
%{--<%--		</td>--%>--}%
%{--<%--	</tr>--%>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Interest Rate (in %)</span></td>--}%
		%{--<td><g:textField name="interestRate" value="${interestRate}" class="input_field" readonly="readonly"/></td>--}%
	%{--</tr>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Interest Term/Code</span></td>--}%
		%{--<td>--}%
			%{--<g:textField name="interestTerm" class="input_field " value="${interestTerm}" readonly="readonly"/>--}%
%{--<%--			<g:radioGroup name="interestTermCode" labels="['Months','Days']" values="['M','D']" value="${interestTermCode}" disabled="true">--%>--}%
%{--<%--		        ${it.radio}&#160;<g:message code="${it.label}" />--%>--}%
%{--<%--		    </g:radioGroup>--%>--}%
			%{--<g:textField name="interestTermCodeFlag" class="input_field" value="${interestTermCode}" readonly="readonly"/>--}%
		%{--</td>--}%
	%{--</tr>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Repricing Term/Code</span></td>--}%
		%{--<td>--}%
			%{--<g:textField name="repricingTerm" value="${repricingTerm}" class="input_field" readonly="readonly"/>--}%
%{--<%--			<g:radioGroup name="repricingTermCode" labels="['Months','Days']" values="['M','D']" value="${repricingTermCode}" disabled="true">--%>--}%
%{--<%--		        ${it.radio}&#160;<g:message code="${it.label}" />--%>--}%
%{--<%--		    </g:radioGroup>--%>--}%
			%{--<g:textField name="repricingTermCodeFlag" class="input_field" value="${repricingTermCode}" readonly="readonly"/>--}%
		%{--</td>--}%
	%{--</tr>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Loan Term/Code</span></td>--}%
		%{--<td>--}%
			%{--<g:textField name="loanTerm" class="input_field" value="${loanTerm}" readonly="readonly"/>--}%
%{--<%--			<g:radioGroup name="loanTermCode" labels="['Months','Days']" values="['M','D']" value="${loanTermCode}" disabled="true">--%>--}%
%{--<%--		        ${it.radio}&#160;<g:message code="${it.label}" />--%>--}%
%{--<%--		    </g:radioGroup>--%>--}%
			%{--<g:textField name="loanTermCodeFlag" class="input_field" value="${loanTermCode}" readonly="readonly"/>--}%
		%{--</td>--}%
	%{--</tr>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Loan Maturity Date</span></td> --}%
		%{--<td><g:textField name="loanDetailsMaturityDate" class="input_field input_ten" value="${loanDetailsMaturityDate}" readonly="readonly"/></td>--}%
	%{--</tr>--}%
%{--<%--</table>--%>--}%
%{--<%--<table>--%>--}%
	%{--<tr>--}%
		%{--<td><input type="hidden" name="officer" value="${officer}"/></td>--}%
	%{--</tr>--}%
%{--<%--	<tr>--%>--}%
%{--<%--		<td><span class="field_label">Documentary Stamp Tagging</span></td>--%>--}%
%{--<%--		<td><g:select name="documentaryStampTagging" from="${['Option 1','Option 2','Option 3'] }" class="select_dropdown " disabled="true" value="${documentaryStampTagging}"/></td>--%>--}%
%{--<%--	</tr>--%>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Payment Code</span></td>--}%
		%{--<td><g:select from="${['0','1','2','3','4','5','6'] }" name="paymentCode" class="select_dropdown" value="${paymentCode}"/></td>--}%
	%{--</tr>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">PN Number</span></td>--}%
		%{--<td><g:textField name="pinNumber" value="${pinNumber}" class="input_field" readonly="readonly"/></td>--}%
	%{--</tr>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Agri - Agra BSP Tagging</span></td>--}%
		%{--<td><g:textField name="agriAgraTagging" class="input_field" value="${agriAgraTagging}" readonly="readonly"/></td>--}%
	%{--</tr>--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Transaction Posting Status</span></td>--}%
		%{--<td><g:textField name="transactionPostingStatus" value="${transactionPostingStatus}" class="input_field" readonly="readonly"/></td>--}%
	%{--</tr>--}%
%{--</table>--}%

    <g:each in="${paymentsMade}">
        %{--<g:hiddenField name="withCramApproval" value="${withCramApproval ?: (it.WITHCRAMAPPROVAL == 1) ? true : false}" />--}%

        <g:if test="${(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("TR_LOAN") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("DTR_LOAN")) ||
             it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("IB_LOAN")}">

            <g:hiddenField name="withCramApproval" value="${withCramApproval ?: (it.WITHCRAMAPPROVAL == 1) ? true : false}" />

        <table class="tabs_forms_table">
            <tr>
                <td class="label_width"><span class="field_label">Type of Loan</span></td>
                <g:if test="${documentType == 'DOMESTIC'}">
                    <td class="input_width"><g:textField  name="typeOfLoan" class="input_field" readonly="readonly" value="D${it.PAYMENTINSTRUMENTTYPE}"/></td>
                </g:if>
                <g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
                    <td class="input_width">
                        <%--                <g:select name="typeOfLoan" value="${typeOfLoan}" class="select_dropdown" from="${['IB Loan','TR Loan', 'UA Loan']}" noSelection="['':'SELECT ONE...']" />--%>
                        <g:textField  name="typeOfLoan" class="input_field" readonly="readonly" value="${it.PAYMENTINSTRUMENTTYPE}"/>
                    </td>
                </g:if>
                <td class="label_width"><span class="field_label">Booking Currency </span></td>
                <td class="input_width">
                    <g:textField  name="bookingCurrencyField" class="input_field" readonly="readonly" value="${it.BOOKINGCURRENCY}"/>
                </td>
            </tr>
            <tr>
                <td><span class="field_label"> Interest Rate (in %) </span></td>
                <td class="input_width"><g:textField name="interestRate" class="input_field" readonly="readonly" value="${it.INTERESTRATE}"/></td>
                <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
                    <td class="label_width"> <span class="field_label"> Facility ID</span> </td>
                    <td> <g:textField class="input_field" name="facilityId" readonly="readonly" value="${it.FACILITYID}"/></td>
                </g:if>
            </tr>
            <tr>
                <td><span class="field_label"> Interest Term </span></td>
                <td>
                    <g:textField name="interestTerm" class="input_field" readonly="readonly" value="${it.INTERESTTERM}"/>
                </td>
                <td><span class="field_label"> Interest Code </span></td>
                <td><g:textField name="interestTermCode" class="input_field" readonly="readonly" value="${it.INTERESTTERMCODE}"/></td>
            </tr>
            <tr>
                <td><span class="field_label"> Loan Term </span></td>
                <td>
                    <g:textField name="loanTerm" class="input_field" value="${it.LOANTERM}" readonly="readonly"/>
                </td>
                <td><span class="field_label"> Loan Code </span></td>
                <td><g:textField name="loanTermCode" class="input_field" readonly="readonly" value="${it.LOANTERMCODE}"/></td>
            </tr>
            <tr>
                <td><span class="field_label"> Loan Maturity Date </span></td>
                <td><g:textField name="loanDetailsMaturityDate" class="input_field" value="${it.LOANMATURITYDATE}" readonly="readonly"/></td>
                <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
                    <td><span class="field_label">PN Number</span></td>
                    <td><g:textField name="pnNumber" class="input_field" readonly="readonly" value="${it.PNNUMBER}"/></td>
                </g:if>
            </tr>
            <tr>
                <td><span class="field_label">Payment Code</span></td>
                <td><g:textField name="paymentCode" class="input_field" readonly="readonly" value="${it.PAYMENTCODE}" /></td>
                <g:if test="${!referenceType.equalsIgnoreCase('ETS')}">
                    <td><span class="field_label">Agri - Agra BSP Tagging</span></td>
                    <td>
                        %{--<g:if test="${documentClass in ['DA', 'DP', 'OA', 'DR']}">--}%
                            %{--<g:select from="${['AGRI','AGRA','REGULAR']}" class="select_dropdown" name="agriAgraTagging" value="${agriAgraTagging}" noSelection="['':'SELECT ONE...']"/>--}%
                        %{--</g:if>--}%
                        %{--<g:else>--}%
                            %{--<g:select from="${['AGRI','AGRA']}" class="select_dropdown" name="agriAgraTagging" value="${agriAgraTagging}" noSelection="['':'SELECT ONE...']"/>--}%
                        %{--</g:else>--}%
                        <g:textField name="agriAgraTagging" class="input_field" value="${it.AGRIAGRATAGGING}" readonly="readonly"/>
                    </td>
                </g:if>
            </tr>
        </table>
        <br />
        </g:if>
    </g:each>
</g:if>
<br/>

%{--removed save button in loan details 15.Jul.2013--}%
%{--<g:render template="../layouts/buttons_for_grid_wrapper" />--}%

<script>
    $(document).ready(function() {
        $("#paymentCode").change(function() {
            if ($("#paymentCodeComplete").val() != "") {
                $("#paymentCodeComplete").val("true");
            } else {
                $("#paymentCodeComplete").val("");
            }
        });
    });
</script>