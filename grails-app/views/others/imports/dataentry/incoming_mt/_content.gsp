<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="incomingMt" />
 


<div id="body_forms">
<%--	<div id="tab_container">--%>
		<hr/>
		<br/>	
		<g:if test="${userType.equalsIgnoreCase('approver')}">
			<g:render template="../others/imports/dataentry/incoming_mt/approver/approver_incoming_mt"/>
		</g:if>
		<g:if test="${userType.equalsIgnoreCase('maker')}">
			<g:render template="../others/imports/dataentry/incoming_mt/maker/maker_incoming_mt"/>
		</g:if>
		
<%--	</div> <%-- End of TABS --%>--%>
		
</div>