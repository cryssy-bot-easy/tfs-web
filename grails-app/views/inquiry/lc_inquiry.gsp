<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main" />
<title>Trade Finance System - ${session.title}</title>
<g:javascript src="popups/view_transaction_main_popup.js"/>
<g:javascript src="grids/lc_inquiry_jqgrid.js"/>
<g:javascript src="utilities/commons/lc_inquiry_utility.js"/>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%
<g:javascript src="popups/alert_utility.js"/>
	<script type="text/javascript">

	var branchLcInquiryUrl = '${g.createLink(controller: 'inquiry', action: 'searchLcInquiryGrid')}';
	var checkDocumentTypeUrl = '${g.createLink(controller: "inquiry", action: "checkDocumentType")}';
	var viewLcUrl = '${g.createLink(controller: 'inquiry', action: 'viewDataEntry')}';
	
    var constructCreateEtsUrl = '${g.createLink(controller: 'serviceInstruction', action: 'constructEtsCreatePopup')}';

	var username = '${username}';
	var userrole = '${session.userrole.id}';
	var unitcode = '${session.unitcode}';
	</script>

</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">

	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>

	<div id="body_forms">
		<form id="lcInquiry" class="inquiry_form">
			<table class="body_forms_table">
				<tr>
					<td colspan="2"><span class="field_label">Document Number</span></td>
					<td><g:textField class="input_field" name="documentNumber" /></td>
					<td colspan="2"><span class="field_label">LC Currency</span></td>
					<td>
						<%-- <g:select class="select_dropdown" name="currency" from="['USD','PHP','EUR']" noSelection="['':'SELECT ONE...']"/> --%>
					
						<%-- Auto Complete --%>
						%{--<input class="tags_currency select2_dropdown bigdrop" name="lcCurrency" id="lcCurrency" />--}%
                        <input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" />
					</td>
				</tr>
				<tr>
					<td colspan="2"><span class="field_label">CIF Name</span></td>
					<td><g:textField class="input_field" name="cifName" /></td>
					<td colspan="2"><span class="field_label">LC Expiry Date</span></td>
					<td>
					<%--<g:select class="select_dropdown" name="type" from="${['FXLC Regular Opening','FXLC Cash Opening','FXLC Standby Opening','DMLC Regular Opening','DMLC Cash Opening','DMLC Standby Opening']}" noSelection="['':'SELECT ONE...']" />--%>
					<g:textField class="datepicker_field" name="expiryDate" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td colspan="3"/>
					<td colspan="2"><span class="field_label">Status</span></td>
					<td>
					  <%-- <g:select name="status" class="select_dropdown" from="" noSelection="['': 'Select One...']"/> --%>
					  <tfs:tradeProductStatus class="select_dropdown" name="status" value="" />
					</td>
				</tr>
				<tr>
					<td><span class="field_label">O/S LC Amount</span></td>
					<td><span class="right_indent">From:</span></td>
					<td><g:textField class="input_field_right numericCurrency" name="outstandingLcAmountFrom" /></td>
					<td><span class="field_label">Opening Date</span></td>
					<td><span class="right_indent">From:</span></td>
					<td><g:textField name="openingDateFrom" class="datepicker_field" readonly="readonly"/></td>
				</tr>
				<tr>
					<td/>
					<td><span class="right_indent">To:</span></td>
					<td><g:textField class="input_field_right numericCurrency" name="outstandingLcAmountTo" /></td>
					<td/>
					<td><span class="right_indent">To:</span></td>
					<td><g:textField name="openingDateTo" class="datepicker_field" readonly="readonly"/></td>
				</tr>
				<g:if test="${session['userrole']['id'].contains("TSD")}">
				<tr>
                	<td colspan="2"> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
                </tr>
                </g:if>
				<%--<tr>--%>
				<%--<td><span class="field_label">LC Expiry Date</span></td>--%>
				<%--<td><g:textField class="datepicker_field" name="expiryDate" /></td>--%>
				<%--</tr>--%>
				<tr><%-- BUTTON --%>
					<td colspan="6">
						<table class="body_forms_table_btn">
							<tr><td><input type="button" class="input_button" value="Search" id="searchLcBtn"/></td></tr>
							<tr><td><input type="reset" class="input_button_negative" value="Reset" id="resetLcBtn"/></td></tr>
						</table>
					</td>
				</tr>  
			</table><%-- End of SEARCH Form--%>
		</form>
		<div class="grid_wrapper">
			<%-- JQGRID --%>
			<g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                          <table id="grid_list_lc_inquiry_branch"></table>
                          <div id="grid_pager_lc_inquiry_branch"></div>
                        </g:if>
                        <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                          <table id="grid_list_lc_inquiry_main"></table>
                          <div id="grid_pager_lc_inquiry_main"></div>
                        </g:if>		

		</div>
	</div>
<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_ets_main_popup" />

<g:render template="../commons/popups/create_non_lc_popup" />
<g:render template="../commons/popups/view_transaction_main_popup"/>
<g:render template="../layouts/reinstate_alert"/>

<g:render template="../layouts/alert" />
<g:render template="../layouts/confirm"/>
</div>
</body>
</html>

%{--<script>--}%
    %{--$(document).ready(function() {--}%
        %{--alert(1)--}%
        %{--$("#currency").setCurrencyDropdown($(this).attr("id"));--}%
    %{--});--}%
%{--</script>--}%