<%--  PROLOGUE:
 * 	(revision)
	SCR/ER Number: 20160414-0529
	SCR/ER Description: Transaction was approved in TSD, but is found on TSD Makers' screen the next day, with Pending status.
	[Revised by:] Allan Comboy Jr.
	[Date Deployed:] 04/14/2016
	Program [Revision] Details: Add pop-up alert to notify user if transaction failed to route(TSD only)
	PROJECT: WEB
	MEMBER TYPE  : Grails GSP
	Project Name: unacted_transaction.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: unacted_transaction


>--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System </title>
    <g:javascript src="popups/alert_utility.js" />

   
  	<%-- initialize jqgrids --%>
	<g:javascript src="grids/unacted_letter_of_credit.js"/>
	<g:javascript src="grids/confirmation_route.js"/>
	<%-- <g:javascript src="grids/unacted_cash_advance_branch.js"/>	Duplicate	--%>
	<g:javascript src="grids/unacted_auxiliary_import.js"/>

    <g:javascript src="grids/unacted_non_lc.js"/>
    <g:javascript src="grids/unacted_advise_on_export.js"/>
    <g:javascript src="grids/unacted_export_bills.js"/>
    <g:javascript src="grids/unacted_incoming_mt.js"/>
    <g:javascript src="grids/unacted_cash_advance.js"/>
    <g:javascript src="grids/outgoing_mt_telecom.js"/>
      <g:javascript src="pop_up.js"/> 

	<%-- AutoComplete Test --%>
	%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>    --}%

    <g:javascript src="utilities/commons/unacted_utility.js" />
	    
    <script type="text/javascript">
        var unactedExportAdvisingUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedExportAdvisingMain')}';

        var unactedExportBillsUrl = '${g.createLink(controller: "unactedTransactions", action: "viewUnactedExportBillsBranch")}';

        var viewExportBillsEtsUrl = '${g.createLink(controller: "unactedTransactions", action: "viewEts")}';
        var viewExportBillsDataEntryUrl = '${g.createLink(controller: "unactedTransactions", action: "viewDataEntry")}';

        // lc grid url
        var unactedLcBranchUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedLcBranch')}';
        var unactedLcMainUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedLcMain')}';
        var unactedNonLcBranchUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedNonLcBranch')}';
       var unactedNonLcMainUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedNonLcMain')}';
        var unactedAuxillaryBranchUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedAuxilllaryBranch')}';
        var unactedAuxillaryMainUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedAuxilllaryMain')}';
        var unactedAuxillaryMainUrlcdt = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedAuxilllaryMaincdt')}';

        var unactedCashAdvanceBranchUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedCashAdvanceBranch')}';
        var unactedCashAdvanceMainUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedCashAdvanceMain')}';

        var unactedIncomingMtMainUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedIncomingMtTsd')}';
        var unactedRoutedIncomingMtUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedRoutedIncomingMt')}';

        var unactedOutgoingMtUrl = '${g.createLink(controller:'unactedTransactions',action:'viewUnactedOutgoingMt')}';
        var transmitUrl = '${g.createLink(controller: "outgoingMt", action: "transmitMtMessage")}';
        var discardUrl = '${g.createLink(controller: "outgoingMt", action: "discardMtMessage")}';
        var reverseUrl = '${g.createLink(controller: "outgoingMt", action: "reverseMtMessage")}';

        // view from grid urls
        var viewEtsUrl = '${g.createLink(controller:'unactedTransactions',action:'viewEts')}';
        var viewDataEntryUrl = '${g.createLink(controller:'unactedTransactions',action:'viewDataEntry')}';
        var viewChargesUrl = '${g.createLink(controller:'unactedTransactions',action:'viewPaymentProcessing')}';
        var viewMtUrl = '${g.createLink(controller:'unactedTransactions',action:'viewMt')}';
        var username = '${username}';
		var setTsdGrid ='${session['group']?.equalsIgnoreCase('TSD') ? 'true' : ''}';
		var checkTsdTableId='${tsdTableId}';
		
     	// EXPORTS CORE
		//ets
		var etsExportCoreUrl = '${g.createLink(controller:'etsExportCore', action:'viewExportCoreEts')}'
		//data entry
		var dataEntryExportCoreUrl = '${g.createLink(controller:'dataentryExportCore', action:'viewExportCoreDataentry')}'

		//OTHER EXPORTS
		//ets - export advance payment
		var etsExportAdvancePaymentUrl = '${g.createLink(controller:'etsExportAdvancePayment', action: 'viewExportAdvancePaymentEts')}'
		//ets - export advance refund
		var etsExportAdvanceRefundUrl = '${g.createLink(controller:'etsExportAdvanceRefund', action: 'viewExportAdvanceRefundEts')}'
		//ets - refund of other export charges
		var etsRefundOfOtherExportChargesUrl = '${g.createLink(controller:'etsRefundOfOtherExportCharges', action: 'viewRefundOfOtherExportChargesEts')}'

		//data entry - export advance payment
		var dataEntryExportAdvancePaymentUrl = '${g.createLink(controller:'dataEntryExportAdvancePayment', action: 'viewExportAdvancePaymentDataEntry')}'
		//data entry - export advance refund
		var dataEntryExportAdvanceRefundUrl = '${g.createLink(controller:'dataEntryExportAdvanceRefund', action: 'viewExportAdvanceRefundDataEntry')}'
		//data entry - refund of other export charges
		var dataEntryRefundOfOtherExportChargesUrl = '${g.createLink(controller:'dataEntryRefundOfOtherExportCharges', action: 'viewRefundOfOtherExportChargesDataEntry')}'
		//data entry - processing of other export charges
		var dataEntryProcessingOfOtherExportChargesUrl = '${g.createLink(controller:'DataEntryProcessingOfOtherExportCharges', action: 'viewProcessingOfOtherExportChargesDataEntry')}'
		//data entry - processing of other export charges (other charges payment)

		var sessionGroup = '${session['group']}';
		
    </script>
    
<%--******************************************--%>
<%--FOR TESTING PURPOSES. DELETE AS NECESSARY.--%>
<%--******************************************--%>

    <script type="text/javascript">
		  //OTHER IMPORTS
			//ets - import advance
			var etsImportAdvanceUrl = '${g.createLink(controller:'etsImportAdvance', action:'viewImportAdvance')}';
			//ets - monitoring
			var etsMonitoringUrl = '${g.createLink(controller:'etsMonitoring', action:'viewMonitoringAction')}'; 
			//ets - refund import advance
			var etsMdUrl = '${g.createLink(controller:'etsMd', action:'viewMdAction')}';
			//ets - settlement actual corres charges
			var etsCorresChargesUrl = '${g.createLink(controller:'corresChargeEtsSettlement', action:'viewSettlementEts')}';
			//ets - other import charges payment
			var etsOtherImportChargesPaymentUrl = '${g.createLink(controller:'etsOtherImportChargesPayment', action:'viewOtherImportPayment')}';
			//ets - refund of cash lc & charges
			var etsRefundCashLcChargesUrl = '${g.createLink(controller:'etsRefundCashLcCharges', action:'viewRefundCashLcCharges')}';
		
			
			//data entry - ap monitoring 
			var dataEntryApMonitoringUrl = '${g.createLink(controller:'dataentryApMonitoring', action:'viewApMonitoringDataentry')}';
			//data entry - ar monitoring 
			var dataEntryArMonitoringUrl = '${g.createLink(controller:'dataentryArMonitoring', action:'viewArMonitoringDataentry')}';
			//data entry - import advance 
			var dataEntryImportAdvanceUrl = '${g.createLink(controller:'dataentryImportAdvance', action:'viewImportAdvanceDataentry')}';
			//data entry - Outgoing Mt 
			var dataEntryOutgoingMtUrl = '${g.createLink(controller:'dataentryOutgoingMt', action:'viewOutgoingMt')}';
			//data entry - MD 
			var dataEntryMdUrl = '${g.createLink(controller:'dataentryMD', action:'viewMdDataentry')}';
			//data entry - Processing of Rebates 
			var dataEntryProcessingRebatesUrl = '${g.createLink(controller:'dataentryProcessingRebates', action:'viewProcessingRebatesDataentry')}';
			//data entry - Settlement of Actual Corres Charges
			var dataEntrySettlementActualCorresChargesUrl = '${g.createLink(controller:'dataentrySettlementActualCorresCharges', action:'viewSettlementActualCorresDataentry')}';
			//data entry - Payment of Other Import Charges
			var dataEntryPaymentOtherImportChargesUrl = '${g.createLink(controller:'dataentryPaymentOtherImportCharges', action:'viewPaymentOtherImportChargesDataentry')}';
			//data entry - Refund of Cash Lc
			var dataEntryRefundOfCashLcUrl = '${g.createLink(controller:'dataentryRefundOfCashLc', action:'viewRefundOfCashLcDataentry')}';

			//SELECT2 URL
			var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
			var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
			var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
			var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';		

	</script>
    
<%--********--%>
<%--END TEST--%>
<%--********--%>

</head>
  <body style="visibility: hidden;" onload="js_Load()">


  <div id="outer_wrap">
	  
		  <%-- HEADER --%>
		  <g:render template="../layouts/header"/>  
		  	  
		  <%-- ACCORDION --%>
		  <g:if test="${!(session['group']?.equalsIgnoreCase("TELECOMS"))}">
		    <g:render template="../layouts/accordion"/>
          </g:if>

          <g:if test="${session['group']?.equalsIgnoreCase("TELECOMS")}">
          	<g:render template="../commons/popups/telecom_reports_popup"/>
          	<script>
          		var outgoingMtUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutgoingMtReport")}';
          	</script>
          	<g:javascript src="report/generateOutgoingMt.js"/>
			<div id="telecom">
	                    <div class="grid_wrapper_telecom">
	                      <table id="grid_list_mt_monitoring_inquiry"></table>
	                      <div id="grid_pager_mt_monitoring_inquiry"></div>
	                    </div>
	                    <br/>
	                    <input type="button" class="input_button_long generateOutgoingMt" value="View Report" />
			</div>
          </g:if>
      <div id="body_forms">
         <%--	  
		  Bank____: <input class="tags_bank select2_dropdown bigdrop" id="tags_bank1" /><br />  
          CB Code_: <input class="tags_cbcode select2_dropdown bigdrop" id="" /><br />  
          Country_: <input class="tags_country select2_dropdown bigdrop" id="" /><br />  
          Currency: <input class="tags_currency select2_dropdown bigdrop" id="" /><br />  	  
         --%>	  

          <g:if test="${session['group']?.equalsIgnoreCase('TSD')}">
			<h3 class="title_label_unacted">${session.tsdUnactedLabelText ?:'Letter Of Credit'}</h3>
			<div class="${tsdGridWrapperClass ?: 'grid_wrapper_unacted fix'}">
				 <table id="${session.tsdUnactedTableId ?: 'grid_list_letter_of_credit_unacted_main'}"></table>
			</div>
			
			
			 <g:if test="${session.tsdUnactedLabelText?.equalsIgnoreCase('Auxiliary Products')}">
			  <h3 class="title_label_unacted">CDT Products</h3> 
			    <div class="grid_wrapper_unacted fix">
			 <%--<h3 class="title_label_unacted">${session.tsdUnactedLabelText ?:'Letter Of Credit'}</h3> --%>
			        
                  <table id="grid_list_auxiliary_import_unacted_maincdt"></table>
                  <div id="grid_pager_auxiliary_import_unacted_maincdt"></div>
                  </div>
			</g:if>
			
         
			
			
          </g:if>
          
          <g:if test="${session['group']?.equalsIgnoreCase('BRANCH')}">

      
          <h3 class="title_label_unacted">Letter of Credit</h3>
          <div class="grid_wrapper_unacted fix">
              <%-- <g:if test="${username?.equalsIgnoreCase("branch")}"> --%>
              <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">

                  <table id="grid_list_letter_of_credit_unacted_branch"></table>
                  <div id="grid_pager_letter_of_credit_unacted_branch"></div>
              </g:if>
              <%-- <g:if test="${username?.equalsIgnoreCase("main")}"> --%>
              <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">

                  <table id="grid_list_letter_of_credit_unacted_main"></table>
                  <div id="grid_pager_letter_of_credit_unacted_main"></div>
              </g:if>
          </div>
          <br/>
          <br/>

          <h3 class="title_label_unacted">Non-LC</h3>
         
          <div class="grid_wrapper_unacted fix">
              <%-- <g:if test="${username?.equalsIgnoreCase("branch")}"> --%>
              <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                  <table id="grid_list_non_letter_of_credit_unacted_branch"></table>
                  <div id="grid_pager_non_letter_of_credit_unacted_branch"></div>
              </g:if>
              <%-- <g:if test="${username?.equalsIgnoreCase("main")}"> --%>
              <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                  <table id="grid_list_non_letter_of_credit_unacted_main"></table>
                  <div id="grid_pager_non_letter_of_credit_unacted_main"></div>
              </g:if>
          </div>
          <br/>
          <br/>
          <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
              <h3 class="title_label_unacted">Advise on Export</h3>
              <div class="grid_wrapper_unacted fix">
                  <table id="grid_list_advise_on_export_unacted"></table>
                  <div id="grid_pager_advise_on_export_unacted"></div>
              </div>
              <br/>
              <br/>
          </g:if>

          <h3 class="title_label_unacted">Export Bills</h3>
          <div class="grid_wrapper_unacted fix">
                  %{--<table id="grid_list_export_bills_unacted"></table>--}%
              <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                  <table id="grid_list_export_bills_unacted_branch"></table>
              </g:if>
              <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                  <table id="grid_list_export_bills_unacted_tsd"></table>
              </g:if>
                  <div id="grid_pager_export_bills_unacted"></div>
          </div>
          <br/>
          <br/>

          <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
              <h3 class="title_label_unacted">Incoming MT - TSD </h3>
              <div class="grid_wrapper_unacted fix">
                  <table id="grid_list_incoming_mt_unacted_tsd"></table>
                  <div id="grid_pager_incoming_mt_unacted_tsd"></div>
              </div>
              <br/>
              <br/>


              <h3 class="title_label_unacted">Incoming MT - Maker</h3>
              <div class="grid_wrapper_unacted fix">
                  <table id="grid_list_incoming_mt_unacted"></table>
                  <%--  <table id="grid_list_incoming_mt_unacted_tsd"></table> --%>
                  <div id="grid_pager_incoming_mt_unacted"></div>
              </div>
              <br/>
              <br/>


          </g:if>

          <h3 class="title_label_unacted">Cash Advance</h3>
          <div class="grid_wrapper_unacted fix">
              <%-- JQGRID --%>
              <table id="grid_list_cash_advance_unacted"></table>
              <div id="grid_pager_cash_advance_unacted"></div>
          </div>
          <br/>
          <br/>

          <h3 class="title_label_unacted">Auxiliary Products</h3>
		 <div class="grid_wrapper_unacted fix">
              <%-- JQGRID --%>             
             <g:if test="${session['group']?.equalsIgnoreCase("BRANCH")}">
                  <table id="grid_list_auxiliary_import_unacted_branch"></table>
                  <div id="grid_pager_auxiliary_import_unacted_branch"></div>
             </g:if>
             <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
                  <table id="grid_list_auxiliary_import_unacted_main"></table>
                  <div id="grid_pager_auxiliary_import_unacted_main"></div>
             </g:if>
          </div>
          </g:if>
     </div>
</div>





  <g:render template="../commons/popups/create_transaction_popup" />
  <g:render template="../commons/popups/create_ua_popup" />
  <g:render template="../commons/popups/create_ets_popup" />
  <g:render template="../commons/popups/create_non_lc_popup" />
  <g:render template="../layouts/confirm_alert" />
   <g:render template="../layouts/confirm_transaction" />


   	    <SCRIPT LANGUAGE="JavaScript" >
 
       if(test="${groovy.json.StringEscapeUtils.escapeJavaScript(message)}")
       {

    	  
          
          
          function transPopup() {  	   	         
              var mSave_div = $("#popup_trans_confirmation");
              var mBg = $("#confirmation_trans_background");

              mLoadPopup(mSave_div, mBg);
              mCenterPopup(mSave_div, mBg);
          }
          
		transPopup();

       }    
       
       </SCRIPT>   
       
   
   	  
  
  
  </body>
</html>