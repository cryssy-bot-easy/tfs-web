<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="mt799" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<span class="title_label">Outgoing MT799</span>
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="outgoing_mt799_list"> </table>
	<div id="outgoing_mt799_pager"> </div>
</div>
<br/><br/>
<span class="title_label">Incoming MT799</span>
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="incoming_mt799_list"> </table>
	<div id="incoming_mt799_pager"> </div>
</div>
<br />
<%--TODO confirm this--%>
<%--<g:render template="/layouts/buttons_for_grid_wrapper" />--%>
<g:render template="../commons/popups/mt_narrative_popup" />
<g:javascript src="grids/mt799_grid.js"/>