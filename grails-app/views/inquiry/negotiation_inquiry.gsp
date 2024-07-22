<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System </title>
    <g:javascript src="utilities/commons/negotiation_inquiry_utility.js" />
    <g:javascript src="grids/negotiation_inquiry_jqgrid.js"/>
    <g:javascript src="popups/alert_utility.js"/>
    <script type="text/javascript">
        var searchNegotiationInquiryUrl = '${g.createLink(controller: "inquiry", action: "searchNegotiationInquiryGrid")}';

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
    <form id="negotiationInquiry" class="inquiry_form">
        <table class="body_forms_table">
            <tr>
                <td class="label_width"> <span class="field_label"> Document Number </span> </td>
                <td class="input_width"> <g:textField class="input_field" name="documentNumber"/> </td>
                <td class="label_width"> <span class="field_label"> CIF Name </span> </td>		<%-- added on sept 20 --%>
                <td class="input_width"> <g:textField class="input_field" name="cifName"/> </td>
              
              <%--   <td class="label_width"> <span class="field_label"> Currency </span> </td> --%>
              
             <%--<td class="input_width"> <g:select class="select_dropdown" name="negotiationCurrency" from="${['PHP','USD','EUR'] }" noSelection="['':'Select One...']"/> </td> --%>
           		
            </tr>
            <tr>
                <td class="label_width"> <span class="field_label"> Client's Name </span> </td>		<%-- added on sept 20 --%>
                <td class="input_width"> <g:textField class="input_field" name="clientName"/> </td>
               
                <td class="label_width"> <span class="field_label"> Negotiation Date <span style="float:right;"> From: </span></span> </td>
                <td class="input_width"> <g:textField class="datepicker_field" name="negotiationDateFrom" /> </td>
                  

                <td>&#160;</td>
                <td>&#160;</td>
            </tr>
            <tr>
	            <td> <span class="field_label"> Negotiation Number </span> </td>
	            <td class="input_width"> <g:textField class="input_field" name="negotiationNumber"/> </td>
            
             <%--    <td> <span class="field_label"> Negotiation Amount </span> </td> --%>
               <td><span style="float:right;">To: </span></td>
               <td>
                   <g:textField class="datepicker_field" name="negotiationDateTo" />
               </td>
            <%--  
                <td> <span class="field_label"> Shipment Number </span> </td>
                <td> <g:textField class="input_field" name="shipmentNumber" /></td>
                <td> <span class="field_label"> Document Type </span> </td>
                <td> <g:select class="select_dropdown" name="documentType" from="" noSelection="['':'Select One...']" /> </td>
          
            </tr>
            <tr>
                <td> <span class="field_label"> LC Type </span> </td>
                <td> <g:textField class="input_field" name="type" /> </td>
                <td> <span class="field_label"> LC Inquiry Guide </span> </td>
                <td> <g:textField class="input_field" name="lcInquiryGuide" /> </td>
  --%>
            </tr>
            <g:if test="${session['userrole']['id'].contains("TSD")}">
				<tr>
                	<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField class="input_field numericWholeQuantity" name="unitCode" /> </td>
                </tr>
                </g:if>
            
            <tr> <%-- BUTTON --%>
                <td colspan="4">
                	<table class="body_forms_table_btn">
                    <tr>
                        <td> <input type="button" class="input_button" id="negotiationInquirySearch" value="Search" /> </td>
                    </tr>
                    <tr>
                        <td> <input type="reset" class="input_button_negative" id="negotiationInquiryReset" value="Reset" /> </td>
                    </tr>
                    </table>
                    
                </td>
            </tr>
        </table> 
        </form>
        <div class="grid_wrapper">
            <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                <table id="grid_list_negotiation_inquiry_branch"></table>
                <div id="grid_pager_negotiation_inquiry_branch"></div>
            </g:if>
            <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                <table id="grid_list_negotiation_inquiry_main"></table>
                <div id="grid_pager_negotiation_inquiry_main"></div>
            </g:if>
        </div>
    </div>
</div>

<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_non_lc_popup" />

<g:render template="../layouts/alert" />
</body>
</html>