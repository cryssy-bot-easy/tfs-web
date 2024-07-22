<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System - eTS Inquiry </title>
    <g:javascript src="/popups/reroute_popup.js" />
    <g:javascript src="/utilities/commons/ets_inquiry_utility.js" />
    <g:javascript src="/grids/ets_inquiry_jqgrid.js" />
    <g:javascript src="popups/alert_utility.js"/>
    <g:javascript src="pop_up.js"/> 
	<script type="text/javascript">
	
        var branchEtsInquiryUrl = '${g.createLink(controller: "inquiry", action: "searchEtsInquiryGrid")}';
        var viewEtsUrl = '${g.createLink(controller: "unactedTransactions", action: "viewEts")}';
        var reverseEtsUrl = '${g.createLink(controller: "etsReversal", action: "requestReverse")}';

        var getHasReversalUrl = '${g.createLink(controller: "product", action: "getHasReversal")}';

        var username = '${session.username}';
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
        <form action="" id="etsInquiry" class="inquiry_form">
            <table class="body_forms_table">
                <tr>
                    <td> <span class="field_label"> eTS Number </span> </td>
                    <td> <g:textField class="input_field" name="etsNumber" /> </td>
                     <td> <span class="field_label"> Status </span> </td>
                    <td>
                        <%--<g:select class="select_dropdown" name="transactionType" from="${[]}" /> --%>
                        %{--<tfs:transactionType class="select_dropdown" name="transactionType" />--}%
                        <tfs:etsStatus class="select_dropdown" name="status" value="" />
                    </td>
				</tr>
				<g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
				<tr>
                    <td> <span class="field_label"> eTS Created Date </span> </td>
                    <td> <g:textField class="datepicker_field" name="createdDate" /> </td>
                    <td> <span class="field_label"> Product </span> </td>
                    <td>
                        <tfs:documentClass class="select_dropdown" name="product" />
                        <g:hiddenField name="documentClass" value="" />
                    </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> eTS Modified Date </span> </td>
                    <td> <g:textField class="datepicker_field" name="modifiedDate" /> </td>
                    <td> <span class="field_label"> eTS Approved Date </span> </td>
                    <td> <g:textField class="datepicker_field" name="approvedDate" /> </td>
                </tr>
				</g:if>
				<g:else>
				<tr>
                    <td> <span class="field_label"> eTS Date </span> </td>
                    <td> <g:textField class="datepicker_field" name="createdDate" /> </td>
                    <td> <span class="field_label"> Product </span> </td>
                    <td>
                        <tfs:documentClass class="select_dropdown" name="product" />
                        <g:hiddenField name="documentClass" value="" />
                    </td>
                </tr>
                </g:else>
                <tr>
                    <td> <span class="field_label"> CIF Name </span> </td>
                    <td> <g:textField class="input_field" name="cifName" /> </td>
                     <td> <span class="field_label"> Product Scope </span> </td>
                    <td>
                        <tfs:documentType class="select_dropdown" name="documentType" />
                    </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> CIF Number </span> </td>
                    <td> <g:textField class="input_field" name="cifNumber" /> </td>
                    <td> <span class="field_label"> Product Type </span> </td>
                    <td>
                        <g:select class="select_dropdown" name="productType" value="" from="${[]}" noSelection="${["":"SELECT ONE..."]}"/>
                        <g:hiddenField name="documentSubType1" value="" />
                    </td>
                </tr>
                <tr>
                	<g:if test="${session['userrole']['id'].contains("TSD")}">
                	<td> <span class="field_label"> CCBD/Branch User Unit Code </span> </td>
                    <td> <g:textField class="input_field numericWholeQuantity" name="userActiveDirectoryId" /> </td>
                    </g:if><g:else>
                    <td> <span class="field_label"> User ID </span> </td>
                    <td> <g:textField class="input_field" name="userId" /> </td>
                    </g:else>
                    <td> <span class="field_label"> Transaction Type </span> </td>
                    <td>
                        %{--<tfs:transactionName class="select_dropdown" name="transactionType" />--}%
                        <g:select class="select_dropdown" name="transactionType" value="" from="${[]}" noSelection="${["":"SELECT ONE..."]}"/>
                        <g:hiddenField name="serviceType" value="" />
                    </td>
                </tr>
                <tr> <%-- BUTTON --%>
                    <td colspan="4">
                        <table class="body_forms_table_btn">
                            <tr><td> <input type="button" class="input_button" value="Search" id="searchEtsBtn"/> </td></tr>
                            <tr><td> <input type="reset" class="input_button_negative" value="Reset" id="resetEtsBtn"/> </td></tr>
                        </table>
                    </td>
                </tr>
            </table> <%-- End of SEARCH Form--%>
        </form>
        <div class="grid_wrapper">
            <%-- JQGRID --%>
                   
            <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                      <table id="grid_list_ets_inquiry_branch"></table>
                	  <div id="grid_pager_ets_inquiry_branch"></div>
            </g:if>
            <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                       <table id="grid_list_ets_inquiry_main"></table>
              		   <div id="grid_pager_ets_inquiry_main"></div>
            </g:if>  
        </div>

    </div>
  </div>

  <g:render template="../commons/popups/reroute_popup" />
  <g:render template="../commons/popups/create_transaction_popup" />
  <g:render template="../commons/popups/create_ua_popup" />
  <g:render template="../commons/popups/create_ets_popup" />
  <g:render template="../commons/popups/create_non_lc_popup" />
  <g:render template="../layouts/alert" />
  
  <SCRIPT LANGUAGE="JavaScript" >
 
       if(test="${groovy.json.StringEscapeUtils.escapeJavaScript(message)}")
       {

    	  
          
          
          function transPopup() {  	   	         
              var mSave_div = $("#popup_emailErr_dv");
              var mBg = $("#popup_emailErr_bg");

              mLoadPopup(mSave_div, mBg);
              mCenterPopup(mSave_div, mBg);
          }
          
		transPopup();

       }    
       
       </SCRIPT>   
  
  </body>
</html>