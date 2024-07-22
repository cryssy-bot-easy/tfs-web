<g:javascript src="grids/documents_enclosed_instructions_jqgrid.js"/>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="documentsEnclosedInstructionsTab" />


<ul class="buttons">
	<li> <a href="javascript:void(0)" class="add_btn" id="add_new_document"> </a> </li>
</ul>
<br /><br />
RAWR
<%--TENTATIVE COLUMN HEADERS (INTENDED TO BE IMPROVED LATER)--%>
<%--<span style="float: right; width: 217px; height:22px; text-align: center; background: #efe9e5; border: 1px solid #d7d3d0;"> Duplicate </span>--%>
<%--<span style="float: right; width: 225px; height:22px; text-align: center; background: #efe9e5; border: 1px solid #d7d3d0;"> Original </span>--%>
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="grid_list_documents_enclosed"> </table>
	<div id="grid_pager_documents_enclosed"> </div>
</div>
<br />
<ul class="buttons">
	<li> <a href="javascript:void(0)" class="add_btn"> </a> </li>
	<li> Add Conditions </li>
</ul>
<br /><br />
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="grid_list_instructions"> </table>
</div>
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="grid_list_additional_conditions"> </table>
</div>

<g:render template="../others/commons/popups/add_new_document_popup" />