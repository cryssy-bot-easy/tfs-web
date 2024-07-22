<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main" />
<title>Trade Finance System - Non LC Inquiry</title>
<g:javascript src="grids/non_lc_inquiry_jqgrid.js"/>
<g:javascript src="utilities/commons/non_lc_inquiry_utility.js" />
<g:javascript src="popups/alert_utility.js"/>

<script type="text/javascript">
	var username = '${username}';
	var userrole = '${session.userrole.id}';
	var unitcode = '${session.unitcode}';
	
<%--	var settleDaUrl = '${g.createLink(controller: "daEtsSettlement", action: "viewSettlementEts")}';--%>
<%--	var settleDpUrl = '${g.createLink(controller: "dpEtsSettlement", action: "viewSettlementEts")}';--%>
<%--	var settleDrUrl = '${g.createLink(controller: "drEtsSettlement", action: "viewSettlementEts")}';--%>
<%--	var settleOaUrl = '${g.createLink(controller: "oaEtsSettlement", action: "viewSettlementEts")}';--%>

<%--	var acceptDaUrl = '${g.createLink(controller: "daDataEntryNegotiationAcceptance", action: "viewNegotiationAcceptanceDataEntry")}';--%>
		
<%--	var cancelDaUrl = '${g.createLink(controller: "daDataEntryCancellation", action: "viewCancellationDataEntry")}';--%>
<%--	var cancelDpUrl = '${g.createLink(controller: "dpDataEntryCancellation", action: "viewCancellationDataEntry")}';--%>
<%--	var cancelDrUrl = '${g.createLink(controller: "drDataEntryCancellation", action: "viewCancellationDataEntry")}';--%>
<%--	var cancelOaUrl = '${g.createLink(controller: "oaDataEntryCancellation", action: "viewCancellationDataEntry")}';--%>

	var viewApprovedNonLcBranchUrl = '${g.createLink(controller: 'documentClass', action: 'viewApprovedNonLc')}';
	var viewApprovedNonLcTsdUrl = '${g.createLink(controller: 'documentClass', action: 'viewApprovedNonLcTsdInitiated')}';
	var mainNonLcInquiryGridUrl = '${g.createLink(controller: 'inquiry', action: 'searchNonLcInquiryGrid')}'

    var multipleServiceInstructionUrl = '${g.createLink(controller: "etsReversal", action: "validateMultipleServiceInstruction")}';
</script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>
	
	<div id="body_forms">
        <form id="nonLcInquiry" class="inquiry_form">
            <table class="body_forms_table">
                <tr>
                    <td class="label_width"><span class="field_label">Document Number</span></td>
                    <td class="input_width"><g:textField class="input_field" name="documentNumber"/></td>
                    <td class="label_width" colspan="2"><span class="field_label">Status</span></td>
                    <td class="input_width"><g:select class="select_dropdown" name="status" from="${session['group']?.equalsIgnoreCase("BRANCH") ? ['NEGOTIATED','ACCEPTED'] : ['NEGOTIATED', 'ACCEPTED', 'ACKNOWLEDGED', 'CLOSED', 'CANCELLED']}" noSelection="['':'SELECT ONE...']"/></td>
                </tr>
                <tr>
                    <td><span class="field_label">CIF Name</span></td>
                    <td><g:textField class="input_field" name="cifName" /></td>
                    <td><span class="field_label">Negotiation Date</span></td>
                    <td><span class="right_indent">From:</span></td>
                    <td><g:textField name="negotiationDateFrom" class="datepicker_field" readonly="readonly" /></td>
                </tr>
                <tr>
                	<g:if test="${session['userrole']['id'].contains("TSD")}">
	                	<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
	                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
	                    <td/>
	                </g:if>
                    <g:else>
                    <td colspan="3"/>
                    </g:else>
                    <td><span class="right_indent">To:</span></td>
                    <td><g:textField name="negotiationDateTo" class="datepicker_field" readonly="readonly" /></td>
                </tr>
                <tr><%-- BUTTON --%>
                    <td colspan="5">
                        <table class="body_forms_table_btn">
                            <tr><td><input type="button" id="nonLcSearch" class="input_button" value="Search" /></td></tr>
                            <tr><td><input type="reset" id="nonLcReset" class="input_button_negative" value="Reset" /></td></tr>
                        </table>
                    </td>
                </tr>
            </table><%-- End of SEARCH Form--%>
        </form>

		<g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">		
			<div class="grid_wrapper">
				<%-- JQGRID --%>		
				<div id="grid_pager_non_lc_inquiry"></div>
				<table id="grid_list_non_lc_inquiry_branch"></table>
			</div>
		</g:if> 
		<g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
			<div class="grid_wrapper">
				<%-- JQGRID --%>		
				<div id="grid_pager_non_lc_inquiry"></div>
				<table id="grid_list_non_lc_inquiry_main"></table>
			</div>
		</g:if>  
	</div>
</div>
<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_non_lc_popup" />
<g:render template="../commons/popups/create_non_lc_ets_popup" />
<%--<g:render template="../commons/popups/accept_cancel_nonlc_popup" />--%>
<g:render template="../layouts/alert" />
<g:render template="../layouts/confirm2"/> %{--for settlement--}%
</body>
</html>