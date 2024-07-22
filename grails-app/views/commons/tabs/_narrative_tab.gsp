<%-- 
(revision)
[Revised by:] Cedrick C. Nungay
[Date deployed:] 08/06/2018
Program [Revision] Details: Change label of MT707
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _narrative_tab.gsp
--%>
<%-- 
(revision)
[Revised by:] Cedrick C. Nungay
[Date deployed:] 09/13/2018
Program [Revision] Details: Added narrative for mt747
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _narrative_tab.gsp
--%>
<%@ page import="net.ipc.utils.GspStringUtils" %>
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="narrative" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<%--<g:if test="${serviceType?.equalsIgnoreCase('AMENDMENT')}">--%>
<%--<g:javascript src="utilities/dataentry/commons/amendmentNarrative.js" />--%>
<%--</g:if>--%>

<div class="amendmentNarrative">
	<ul>
		<li>
			<span class="bold field_label">
				<g:if test="${documentSubType1?.equalsIgnoreCase('Standby')}">
					Amendment Details
				</g:if>
				<g:elseif test="${documentType?.equalsIgnoreCase('FOREIGN') && !documentSubType1?.equalsIgnoreCase('Standby')}">
					Narrative for MT707
				</g:elseif>
				<g:else>
					Narrative
				</g:else>
			</span>
		</li>
		<li><div><g:textArea name="narrative" class="amendment_narrative" value="${narrative ?: narrativeCheck}" style="text-transform: uppercase;"/></div></li>
		<%--<li><span class="field_label"><span id="remaining_char_narrative_amendment"></span>&#160;Characters</span></li>--%>
		<%--<li><span class="field_label"><span id="remaining_line_narrative_amendment"></span>&#160;Lines</span></li>--%>
	</ul>
	<br/>
	<g:if test="${serviceType?.equalsIgnoreCase('Amendment') && documentType?.equalsIgnoreCase('FOREIGN') && !documentSubType1?.equalsIgnoreCase('Standby') &&
		GspStringUtils.isNotEmpty(positiveToleranceLimitTo,negativeToleranceLimitTo,maximumCreditAmountTo, additionalAmountsCoveredTo,amountTo,expiryDateTo) &&
		(!GspStringUtils.getExistingValue(reimbursingBankIdentifierCodeFrom,reimbursingBankIdentifierCode).isEmpty() &&
		!GspStringUtils.getExistingValue(reimbursingBankIdentifierCodeFrom,reimbursingBankIdentifierCode).equals(GspStringUtils.getExistingValue(destinationBankFrom,destinationBank)))}">
	    <ul>
	        <li><span class="bold field_label">Narrative for MT747</span></li>
            <li><div><g:textArea name="narrativeFor747" class="amendment_narrative" value="${narrativeFor747 ?: ''}" style="text-transform: uppercase;"/></div></li>
	    </ul>
    </g:if>
</div>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<script type="text/javascript">
$(function(){
	if($("#documentSubType1").val() != "STANDBY") {
		$("#narrativeFor747").limitCharAndLines(50, 35, 'Z');	
		$("#narrative").limitCharAndLines(65, 12, 'Z');	
	} else {
		$("#narrative").limitCharAndLines(65, 150);
	}	
});
</script>