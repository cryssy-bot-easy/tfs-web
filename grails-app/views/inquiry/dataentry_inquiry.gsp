<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main" />
<title> Trade Finance System - Data Entry Inquiry </title>
<g:javascript src="grids/dataentry_inquiry_jqgrid.js"/>
<g:javascript src="popups/alert_utility.js"/>
<script type="text/javascript">
	var username = '${username}';
    var dataEntryInquiryGridUrl = '${g.createLink(controller: "inquiry", action: "searchDataEntryInquiryGrid")}';
    var viewDataEntryUrl = '${g.createLink(controller: "unactedTransactions", action: "viewDataEntry")}';
</script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">  
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>

	<div id="body_forms">
        <form id="dataEntryInquiry" class="inquiry_form">
            <table class="form_table_inquiry">
                <tr>
                    <td class="label_width"> <span class="field_label"> Document Number </span> </td>
                    <td class="input_width"> <g:textField class="input_field" name="documentNumber" /> </td>
                    <td> <span class="field_label"> Product </span> </td>
                    <td>
                        <tfs:documentClass class="select_dropdown" name="product" />
                        <g:hiddenField name="documentClass" value="" />
                    </td>
                </tr>
                <tr>
                    <td class="label_width"> <span class="field_label"> Status </span> </td>
                    <td>
                        %{--<g:select class="select_dropdown" name="transactionName" from="${['FX-LC-CASH']}" noSelection="['':'Select One...']" /> --}%
                        %{--<tfs:transactionName name="transactionName" class="select2_dropdown" />--}%
<%--                        <g:select class="select_dropdown" name="status" from="${['PREPARED', 'CHECKED', 'PRE APPROVED', 'APPROVED', 'POST APPROVED', 'ABORTED','RETURNED']}"--%>
<%--                                  keys="${['PREPARED', 'CHECKED', 'PRE_APPROVED', 'APPROVED', 'POST_APPROVED', 'ABORTED','RETURNED']}" noSelection="['':'SELECT ONE...']" />--%>
						<tfs:dataEntryStatus class="select_dropdown" name="status" value="" />
                    </td>
                    <td> <span class="field_label"> Product Scope </span> </td>
                    <td>
                        <tfs:documentType class="select_dropdown" name="documentType" />
                    </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> CIF Name </span> </td>
                    <td> <g:textField class="input_field" name="cifName" /> </td>
                    <td> <span class="field_label"> Product Type </span> </td>
                    <td>
                        <g:select class="select_dropdown" name="productType" value="" from="${[]}" noSelection="${["":"SELECT ONE..."]}"/>
                        <g:hiddenField name="documentSubType1" value="" />
                    </td>                    
                </tr>
                <tr>
                    <td> <span class="field_label"> Date of Transaction </span> </td>
                    <td> <g:textField class="datepicker_field2" name="dateOfTransaction" /> </td>
                    <td> <span class="field_label"> Transaction Type </span> </td>
                    <td>
                        %{--<tfs:transactionName class="select_dropdown" name="transactionType" />--}%
                        <g:select class="select_dropdown" name="transactionType" value="" from="${[]}" noSelection="${["":"SELECT ONE..."]}"/>
                        <g:hiddenField name="serviceType" value="" />
                    </td>
                </tr>
                <g:if test="${username == 'branch'}">
                    <tr>
                        <td> <span class="field_label"> e-TS Number </span> </td>
                        <td> <g:textField class="input_field" name="etsNumber" /></td>
                    </tr>
                </g:if>
                <tr>
                    <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /></td>
                </tr>
            </table> <%-- End of SEARCH Form--%>
            <table class="buttons_for_grid_wrapper">
				<tr>
					<td><input type="button" id="dataEntryInquirySearch" class="input_button" value="Search" /></td>
				</tr>
				<tr>
					<td><input type="reset" id="dataEntryInquiryReset" class="input_button_negative" value="Reset" /></td>
				</tr>
			</table>
        </form>                                                       
		<div class="grid_wrapper">
			<table id="grid_list_dataentry_inquiry"></table>
            <div id="grid_pager_dataentry_inquiry"></div>
		</div>
	</div>
</div>
  <g:render template="../commons/popups/reroute_popup" />
  <g:render template="../commons/popups/create_transaction_popup" />
  <g:render template="../commons/popups/create_ua_popup" />
  <g:render template="../commons/popups/create_ets_popup" />
  <g:render template="../commons/popups/create_non_lc_popup" />
  <g:render template="../layouts/alert" />
</body>
</html>