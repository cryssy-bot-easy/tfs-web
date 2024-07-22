    <g:javascript src="report/generateOutgoingMt.js"/>
    <div id="body_forms">

        <%@ page import="net.ipc.utils.DateUtils" %>
        <g:hiddenField name="serviceType" value="${serviceType}" />
        <g:hiddenField name="documentType" value="${documentType}" />
        <g:hiddenField name="documentClass" value="${documentClass}" />
        <g:hiddenField name="referenceType" value="${referenceType}" />
        <%--		<g:hiddenField name="form" value="basicDetails"/>--%>

        <hr/>
        <br/>
        <table class="tabs_forms_table">
            <tr>
                <td class="label_width"><span class="field_label">Reference Number</span> </td>
                <td class="input_width"><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/></td>
                <td class="label_width"><span class="field_label">Date of TSD/ FD Approval</span> </td>
                <td><g:textField name="modifiedDate" value="${modifiedDate}" class="input_field" readonly="readonly"/></td>
            </tr>
            <tr>
                <td><span class="field_label">MT Type</span></td>
                <td><g:textField name="mtType" class="input_field" value="${mtType}" readonly="readonly"/></td>
            </tr>
        </table>
        <br/><br/>
        <span class="title_label">MT Message</span>
        <br/>
        <div><g:textArea name="message" value="${message}" class="mtMessage_text_area" readonly="readonly"></g:textArea></div>
<%--		<br/><br/>--%>
<%--        <g:submitToRemote id="printMT" class="input_button2 generateOutgoingMt" value="Print MT"/>--%>
    </div>
