<%-- 
	PROLOGUE:
	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date created:] 08/16/2017
	Program [Revision] Details: IC Inquiry module
	Member Type: GSP
	Project: tfs-web
	Project Name: _ic_inquiry.gsp
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System - ${session.title}</title>
	<g:javascript src="popups/view_transaction_main_popup.js"/>
	<g:javascript src="grids/ic_inquiry_jqgrid.js"/>
	<g:javascript src="utilities/commons/ic_inquiry_utility.js"/>
	<g:javascript src="utilities/commons/autocomplete_utility.js"/>
	<g:javascript src="popups/alert_utility.js"/>
		<script type="text/javascript">
			var tsdIcInquiryUrl = '${g.createLink(controller: 'inquiry', action: 'searchIcInquiryGrid')}';
			var username = '${username}';
			var userrole = '${session.userrole.id}';
<%--			var unitcode = "";--%>
		</script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
	<g:render template="../layouts/header"/>
	<g:render template="../layouts/accordion"/>

	<div id="body_forms">
		<form id="icInquiry" class="inquiry_form">
			<table class="body_forms_table">
				<tr>
					<td colspan="2"><span class="field_label">Document Number</span></td>
					<td><g:textField name="documentNumber" class="input_field icSearchCriteria" maxlength="21"/></td>
					<td colspan="2"><span class="field_label">IC Number</span></td>
					<td><g:textField name="icNumber" class="input_field icSearchCriteria" maxlength="20"/></td>
				</tr>
				<tr>
					<td colspan="2"><span class="field_label">CIF Name</span></td>
					<td><g:textField name="cifName" class="input_field icSearchCriteria" maxlength="50"/></td>
					<td><span class="field_label">IC Date</span></td>
					<td><span class="right_indent">From:</span></td>
					<td><g:textField name="icDateFrom" class="datepicker_field3 icSearchCriteria" readonly="readonly"/></td>
				</tr>
				<tr>
					<td colspan="2"><span class="field_label">CCBD/Branch Unit Code</span></td>
					<td><g:textField name="unitCode" class="input_field numeric icSearchCriteria" maxlength="3"/></td>
					<td></td>
					<td><span class="right_indent">To:</span></td>
					<td><g:textField name="icDateTo" class="datepicker_field3 icSearchCriteria" readonly="readonly"/></td>
					
				</tr>
				<tr>
					<td colspan="2"><span class="field_label">LC Currency</span></td>
					<td><input name="currency" id="currency" class="tags_currency select2_dropdown bigdrop icSearchCriteria"/></td>
					<td><span class="field_label">IC Amount</span></td>
					<td><span class="right_indent">From:</span></td>
					<td><g:textField name="icAmountFrom" class="input_field_right numericCurrency validateIfZero icSearchCriteria" onblur="validateAmounts(id)"/></td>
				</tr>
				<tr>
					<td><span class="field_label">LC Amount</span></td>
					<td><span class="right_indent">From:</span></td>
					<td><g:textField name="lcAmountFrom" class="input_field_right numericCurrency validateIfZero icSearchCriteria" onblur="validateAmounts(id)"/></td>
					<td colspan="2"><span class="right_indent">To:</span></td>
					<td><g:textField name="icAmountTo" class="input_field_right numericCurrency validateIfZero icSearchCriteria" onblur="validateAmounts(id)"/></td>
				</tr>
				<tr>
					<td colspan="2"><span class="right_indent">To:</span></td>
					<td><g:textField name="lcAmountTo" class="input_field_right numericCurrency validateIfZero icSearchCriteria" onblur="validateAmounts(id)"/></td>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td colspan="6">
						<table class="body_forms_table_btn">
							<tr><td><input type="button" class="input_button" value="Search" id="searchIcBtn"/></td></tr>
							<tr><td><input type="reset" class="input_button_negative" value="Reset" id="resetIcBtn"/></td></tr>
						</table>
					</td>
				</tr>  
			</table>
		</form>
		<div class="grid_wrapper">
        	<g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
            	<table id="grid_list_ic_inquiry_main"></table>
                	<div id="grid_pager_ic_inquiry_main"></div>
        	</g:if>		
		</div>
	</div>
<g:render template="../layouts/alert" />
<g:render template="../layouts/confirm"/>
</div>
</body>
</html>