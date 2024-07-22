<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="form" value="mtMessage" />
 
<div id="body_forms">
		<hr/>
		<br/>	
		<g:if test="${userType.equalsIgnoreCase('APPROVER')}">
			<g:render template="../mt/incoming/approver/approver_incoming_mt"/>
		</g:if>
		<g:if test="${userType.equalsIgnoreCase('MAKER')}">
            <g:render template="../mt/incoming/maker/maker_incoming_mt"/>
		</g:if>
</div>