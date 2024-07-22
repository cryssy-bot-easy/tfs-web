<%--
 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _accordion.gsp
>--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Double display of Labels in accordion in EBC SETTLEMENT (Redmine# 4169)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 02/28/2017 (tfs-web Rev# 7413)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: The element for View Payment Accounting Entries was deleted.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _accordion.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: SCR# 
	SCR/ER Description: To view AccountingEntries in Action if role is TSD officer.
	[Created by:] Jonh Henry Alabin
	[Date deployed:] June 16,2017 
	Program [Revision] Details: Added a contition in viewing Accounting Entries.
	PROJECT: WEB
	MEMBER TYPE  : GSP
	Project Name: _accordion.gsp
>--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy Module
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 19, 2017
	[Date deployed:]
	Program [Revision] Details: Added css to color Generate Discrepancy and View MT 734 links. Removed their onclick function, to be added only when 
								there is value in Discrepancy tab.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _accordion.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 27, 2017
	[Date deployed:]
	Program [Revision] Details: Changed color of Generate Discrepancy and View MT 734 links to a lighter shade of grey.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _accordion.gsp
--%>

<%-- (Modify) 
     [Modified by:] Rafael Ski Poblete
     [Date Modified:] Sept 19, 2018
     Program [Modified] Details: Addd Outgoing MT707. -%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] Cedrick C. Nungay
	[Date revised:] September 17, 2018
	[Date deployed:]
	Program [Revision] Details: Added MT759 link
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _accordion.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] Cedrick C. Nungay
	[Date revised:] September 17, 2018
	[Date deployed:]
	Program [Revision] Details: Added MT759 link
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _accordion.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] Cedrick C. Nungay
	[Date revised:] January 09, 2019
	[Date deployed:]
	Program [Revision] Details: Added MT740 and MT747 link
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _accordion.gsp
--%>

<%@ page import="net.ipc.utils.GspStringUtils" %>
<g:javascript src="utilities/ets/commons/accordion_utility.js"/>
<g:javascript src="utilities/commons/accordion_links.js"/>
<!--[if IE 7]>
	<g:javascript src="loading.js"/>
<![endif]-->
<%--<g:javascript src="popups/accounting_entries_popup.js"/>--%>
<g:if test="${!documentClass?.equalsIgnoreCase('CDT')}">
	<g:javascript src="popups/debit_memo_popup.js"/>
</g:if>
<g:javascript src="report/generateBillingStatement.js"/>
<g:javascript src="report/generateBillingStatementForCash.js"/>
<g:javascript src="report/generateBillingStatementForImportAdvance.js"/>
<g:javascript src="report/generateBillingStatementForMarginalDeposit.js"/>
<g:javascript src="report/generateBillingStatementForNegoAmount.js"/>
<g:javascript src="report/generateBillingStatementWithoutPaymentDetails.js"/>
<g:javascript src="report/generateCertification.js"/>
<g:javascript src="report/generateConfirmationLetter.js"/>
<g:javascript src="report/generateCreditMemo.js"/>
<g:javascript src="report/generateDailyCashFxlcsOpenedTreasuryReport.js"/>
<g:javascript src="report/generateDailyFxlcsOpenedTreasuryReport.js"/>
<g:javascript src="report/generateDailyOutstandingFxlcsTreasuryReport.js"/>
<g:javascript src="report/generateDebitMemo.js"/>
<g:javascript src="report/generateDiscrepancyLetter.js"/>
<g:javascript src="report/generateDocumentCheckList.js"/>
<g:javascript src="report/generateDslcBiddingReports.js"/>
<g:javascript src="report/generateExportNegotiationAdvice.js"/>
<g:javascript src="report/generateLcConfirmationOpening.js"/>
<g:javascript src="report/generateLcConfirmationStandbyOpening.js"/>
<g:javascript src="report/generateLcConfirmationAmendment.js"/>
<g:javascript src="report/generateLetterOfAdvise.js"/>
<g:javascript src="report/generateMtMessage.js"/>
<g:javascript src="report/generatePaymentSummary.js"/>
<g:javascript src="report/generatePddtsReport.js"/>
<g:javascript src="report/generateTransmittalMessageToClient.js"/>
<g:javascript src="report/generateTransferLetter.js"/>
<g:javascript src="report/generateTransmittalLetter.js"/>

<g:javascript src="report/batches/processingUnitCode.js"/>

<%-- batches/fxlc --%>
<g:javascript src="report/batches/fxlc/generateConsolidatedRerportonFXLCsOpenedfortheMonth.js"/>
<g:javascript src="report/batches/fxlc/generateFXLCsOpenedfortheMonth.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsCashPerCurrency.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsCashPerImporter.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsStandByPerCurrency.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsStandByPerImporter.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsSightperCurrency.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsSightperImporter.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsUsanceperCurrency.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingFXLCsUsanceperImporter.js"/>
<g:javascript src="report/batches/fxlc/generateOutstandingInwardBillsforCollectionFXLCperCurrency.js"/>
<g:javascript src="report/batches/fxlc/generateQuarterlyReportonFXLCsStandbyOpened.js"/>
<g:javascript src="report/batches/fxlc/generateWeeklyReportonMaturingUsanceLcs.js"/>
<g:javascript src="report/batches/fxlc/generateYearEndReportonFXLCSOpenedperAdvisingBank.js"/>
<g:javascript src="report/batches/fxlc/generateYearEndReportonFXLCSOpenedperConfirmingBank.js"/>
<g:javascript src="report/batches/fxlc/generateYearEndReportonFXLCSOpenedperCountry.js"/>
<g:javascript src="report/batches/fxlc/generateYTDReportonFXLCsOpened.js"/>
<g:javascript src="report/batches/fxlc/generateYTDReportonFXLCsOpenedClassifiedbytop30ImporterandAdvisingBankinUSD.js"/>

<%-- batches/dmlc --%>
<g:javascript src="report/batches/dmlc/generateConsolidatedRerportonDMLCsOpenedfortheMonth.js"/>
<g:javascript src="report/batches/dmlc/generateDMLCsOpenedfortheMonth.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsCashPerCurrency.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsCashPerImporter.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsStandByPerCurrency.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsStandByPerImporter.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsSightperCurrency.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsSightperImporter.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsUsanceperCurrency.js"/>
<g:javascript src="report/batches/dmlc/generateOutstandingDMLCsUsanceperImporter.js"/>
<g:javascript src="report/batches/dmlc/generateYTDReportonDMLCsOpened.js"/>
<g:javascript src="report/batches/dmlc/YTDReportonDomesticLCsOpenedClassifiedbytop30ImporterandAdvisingLocalBankinPHP.js"/>

<%-- batches/other trade --%>
<g:javascript src="report/batches/othertrade/generateAPOthers.js"/>
<g:javascript src="report/batches/othertrade/generateAROthers.js"/>
<g:javascript src="report/batches/othertrade/generateMonthlyTransactionCount.js"/>
<g:javascript src="report/batches/othertrade/generateYtdTransactionCountImportExport.js"/>
<g:javascript src="report/batches/othertrade/generaterunDailySummaryOfAccountingEntries.js"/>
<g:javascript src="report/batches/othertrade/generateWeeklyScheduleDocStamps.js"/>
<g:javascript src="report/batches/othertrade/generateListOfTransactionsWithNoCifNumber.js"/>
<g:javascript src="report/batches/othertrade/generateProfitabilityMonitoringReport.js"/>
<g:javascript src="report/batches/othertrade/generateTfsCasaPostingReport.js"/>
<g:javascript src="report/batches/othertrade/generateCollectedTwoPercentCwt.js"/>
<g:javascript src="report/batches/othertrade/generateProductAvailmentsReport.js"/>
<g:javascript src="report/batches/othertrade/generateDwExceptionReport.js"/>
<g:javascript src="report/batches/othertrade/generateTradeServicesAMLAReportedTransactions.js"/>
<g:javascript src="report/batches/othertrade/generateVolumetrics.js"/>

<%-- batches/other nonlc --%>
<g:javascript src="report/batches/nonlc/generateDmNonLcsNegofortheYear.js"/>
<g:javascript src="report/batches/nonlc/generateFxNonLcsNegofortheYear.js"/>
<g:javascript src="report/batches/nonlc/generateOutstandingInwardBillsforCollectionDmDaDpperCurr.js"/>
<g:javascript src="report/batches/nonlc/generateOutstandingInwardBillsforCollectionFxDaDpperCurr.js"/>

<%-- batches/export --%>
<g:javascript src="report/batches/export/generateExportNegofortheMonthperClient.js"/>
<g:javascript src="report/batches/export/generateExportNegoperCollectingBank.js"/>
<g:javascript src="report/batches/export/generateExportPaymentsfortheMonthperClient.js"/>
<g:javascript src="report/batches/export/generateOutstandingExportNegotiationDomestic.js"/>
<g:javascript src="report/batches/export/generateOutstandingExportNegotiationForeign.js"/>

<%-- batches/other imports --%>
<g:javascript src="report/batches/other_imports/generateDailyFxlcOpenedReportCdtDetails.js"/>
<g:javascript src="report/batches/other_imports/generateDailyReportProcessedRefunds.js"/>
<g:javascript src="report/batches/other_imports/generateOutstandingBankGuaranty.js"/>
<g:javascript src="report/batches/other_imports/generateOutstandingMarginalDeposits.js"/>

<%-- online reports --%>
<g:javascript src="report/batches/online/generateBankCertification.js"/>
<g:javascript src="report/batches/online/generateDailyForeignRegularLcOpened.js"/>
<g:javascript src="report/batches/online/generateDailyForeignCashLcOpened.js"/>
<g:javascript src="report/batches/online/generateDailyOutstandingForeignLc.js"/>
<g:javascript src="report/batches/online/generateDailyFundingReport.js"/>
<g:javascript src="report/batches/online/generateDailyOutstandingLcCcbdReport.js"/>
<g:javascript src="report/batches/online/generateDailySummaryAccountingEntries.js"/>
<g:javascript src="report/batches/online/generateTramsReport.js"/>
<g:javascript src="report/batches/online/executeReverseLc.js"/>

<%-- spad --%>
<g:javascript src="report/spad/generateActualCorresChargesDataEntry.js"/>
<g:javascript src="report/spad/generateAdbBureauOfCustomsCollection.js"/>
<g:javascript src="report/spad/generateRebatesFromCorresBankDataEntry.js"/>
<g:javascript src="report/spad/generateScheduleOfMarginalDeposit.js"/>
<g:javascript src="report/spad/generateTsdExportBankCommission.js"/>
<g:javascript src="report/spad/generateFxForm1Schedule03.js"/>
<g:javascript src="report/spad/generateFxForm1Schedule04.js"/>
<g:javascript src="report/spad/generateFxForm1Schedule05.js"/>
<g:javascript src="report/spad/generateFxForm1Schedule07.js"/>
<g:javascript src="report/spad/generateFxForm1Schedule09.js"/>
<g:javascript src="report/spad/generateFxForm1Schedule10.js"/>
<g:javascript src="report/spad/generateFxForm1Schedule11.js"/>
<g:javascript src="report/spad/generateFxForm4Credex.js"/>

<%-- cdt reports (moved to online_reports_popup)--%>
<g:javascript src="report/generateConsolidatedDailyReportDepositsCollected.js"/>
<g:javascript src="report/generateConsolidatedReportDailyCollectionsCdtOtherLevies.js"/>
<g:javascript src="report/generateConsolidatedReportDailyCollectionsExportDocumentaryStampFees.js"/>
<g:javascript src="report/generateConsolidatedReportDailyCollectionsImportProcessingFees.js"/>
<g:javascript src="report/generateDailyReportProcessedCdtCollections.js"/>
<g:javascript src="report/generateYtdCustomsDutiesAndTaxesAndOtherLevies.js"/>
<g:javascript src="report/generateCustomsDutiesAndTaxesAndOtherLevies.js"/>

<%-- url --%>
<g:render template="/commons/script/accordion_url"/>

<div id="navigation">
%{--ACCORDION--}%
<div id="Accordion1" class="Accordion">
<div class="AccordionPanel">
    <div class="AccordionPanelTab panelHome" id="accordpanel_home">Home</div>
    <div class="AccordionPanelContent">
        <ul>
        	<g:if test="${!session['group']?.equalsIgnoreCase('TSD')}">
				<li class="unactedLink"><a href="javascript:void(0)" id="unactedTransactionsBtn">Unacted</a></li>
			</g:if>
           	<li><a href="javascript:void(0)" id="etsInquiryBtn">eTS Inquiry</a></li>            
            <g:if test="${session['group']?.equalsIgnoreCase('TSD')}" >
               	<li><a href="javascript:void(0)" id="dataEntryInquiryBtn">Data Entry Inquiry</a></li>
            </g:if>
        </ul>
    </div>
</div>
<g:if test="${session['group']?.equalsIgnoreCase('TSD')}">
<%--TSD UNACTED PANEL--%>
	<div class="AccordionPanel">
	    <div class="AccordionPanelTab panelHome" id="accordpanel_home">Unacted</div>
	    <div class="AccordionPanelContent">
	        <ul>
				<li><a href="javascript:void(0)" id="tsdLetterOfCredit"></a></li>
	           	<li><a href="javascript:void(0)" id="tsdNonLc"></a></li>            
               	<li><a href="javascript:void(0)" id="tsdAdviseOnExport"></a></li>
               	<li><a href="javascript:void(0)" id="tsdExportBills"></a></li>
               	<g:if test="${'TSDM' != session['userrole']['id']  }">
               		<li><a href="javascript:void(0)" id="tsdIncomingTsd"></a></li>
               	</g:if>
               	<g:else>
               		<li><a href="javascript:void(0)" id="tsdIncomingMaker"></a></li>
               	</g:else>
               	<li><a href="javascript:void(0)" id="tsdCashAdvance"></a></li>
               	<li><a href="javascript:void(0)" id="tsdAuxiliaryProducts"></a></li>
	        </ul>
	    </div>
	</div>
</g:if>

<g:if test="${(documentClass?.equalsIgnoreCase('CDT') && serviceType?.equalsIgnoreCase('PAYMENT') && referenceType?.equalsIgnoreCase('PAYMENT'))
	|| (documentClass?.equalsIgnoreCase('CDT') && serviceType?.equalsIgnoreCase('REMITTANCE') && referenceType?.equalsIgnoreCase('DATA_ENTRY'))
	|| (documentClass?.equalsIgnoreCase('CDT') && referenceType?.equalsIgnoreCase('TRANSACTIONS'))
	|| (documentClass?.equalsIgnoreCase('CDT') && serviceType?.equalsIgnoreCase('REFUND'))}">
	<div class="AccordionPanel">
		<div class="AccordionPanelTab panelHome" id="accordpanel_home">Actions</div>
			<div class="AccordionPanelContent">
				<ul>
					<li class="showPaymentAccountingEntriesLink">
						<a href="javascript:void(0)" id="openAccountingEntries" class="enablePaymentAccountingEntries disableAccountingEntries">View Payment Accounting Entries</a>
					</li>                
					<li class="showTransactionAccountingEntriesLink">
						<a href="javascript:void(0)" id="openTransactionAccountingEntries" class="enableTransactionAccountingEntries disableAccountingEntries">View Transaction Accounting Entries</a>
					</li>
					<li><a href="javascript:void(0)" id="viewCreditMemoDataEntryDomestic" class="viewCreditMemo disableCreditMemo">View Credit Memo</a></li>
					<li><a href="javascript:void(0)" id="viewDebitMemoPayment" class="viewDebitMemo disableDebitMemo">View Debit Memo</a></li>
				</ul>
			</div>
	</div>
</g:if>

<div class="AccordionPanel">
    <div class="AccordionPanelTab actions" id="accordpanel_actions">Actions</div>

    <div class="AccordionPanelContent accordionActions">
        <ul>
	        <%-- <g:if test="${(serviceType?.equalsIgnoreCase('Negotiation Discrepancy') || serviceType?.equalsIgnoreCase('Negotiation_Discrepancy'))}">
	            <li><g:remoteLink action="generateSwiftMessage" controller="swift" onSuccess="showMtPopup()" update="mt_popup_wrapper" params="[messageType : 750]">View MT 750</g:remoteLink> </li>
	        </g:if> --%>
        	<%-- Not Applicable for Indemnity Cancellation and Negotiation Discrepancy --%>
            <g:if test="${!(serviceType?.equalsIgnoreCase('Indemnity Cancellation') || serviceType?.equalsIgnoreCase('Indemnity_Cancellation')) && !(serviceType?.equalsIgnoreCase('Negotiation Discrepancy') || serviceType?.equalsIgnoreCase('Negotiation_Discrepancy'))}">
	            
				<%-- no view approved ets link in da dp cancellation/nego and tsd initiated transactions --%>
				<g:if test="${(referenceType == 'DATA_ENTRY' || referenceType == 'PAYMENT') && documentClass != 'REBATE'}">
					<g:if test="${!draftStatus?.equalsIgnoreCase('DRAFT')}">
						<li class="viewApprovedEtsLink"><a href="javascript:void(0)" id="viewApprovedEts">View Approved eTS</a></li>
						<li class="viewApprovedEtsLink"><a href="javascript:void(0)" id="viewApprovedEtsChargesAndPayments">Approved eTS<br/>Charges and Payment</a></li>
					</g:if>    
				</g:if>
				
				<g:if test="${referenceType == 'ETS' && status == 'APPROVED'}">
					<li><a href="javascript:void(0)" id="viewApprovedEtsChargesAndPayments">Approved eTS<br/>Charges and Payment</a></li>    
				</g:if>

                <g:if test="${reverseEts}">
                    <li class="viewApprovedEtsLink"><a href="javascript:void(0)" id="viewOriginalEts">View Original eTS</a></li>
                </g:if>
				
				<%-- for billing statement report --%>
				<g:if test="${session.userrole.id.contains('BR') && referenceType == 'ETS'}">
					<%-- billing statement with cash lc payment --%>
					<g:if test="${(documentSubType1 == 'CASH' && (serviceType == 'Opening' || serviceType?.contains('UA Loan'))) ||
                        (documentSubType1 == 'REGULAR' && serviceType == 'Adjustment') ||
						(documentSubType1 == 'CASH' && serviceType == 'Amendment' && lcAmountFlag == 'INC') ||
						(documentClass == 'IMPORT_ADVANCE' && serviceType == 'PAYMENT')}">
						<li><a href="javascript:void(0)" id="viewBillingStatementForCash" class="enableBillingStatement">Billing Statement</a></li>
					</g:if>
					
					<%-- billing statement without cash lc payment --%>
					<g:if test="${(documentSubType1 == 'CASH' && serviceType == 'Amendment' && lcAmountFlag != 'INC') ||
						(documentSubType1 != 'CASH' && (serviceType == 'Opening' || serviceType == 'Amendment')) ||
						serviceType == 'Issuance' ||
						(serviceType == 'Negotiation' && overdrawnAmount == '0.00') ||
						(documentClass == 'EXPORT_ADVANCE') ||
						(documentSubType1 == 'REGULAR' && serviceType == 'UA Loan Maturity Adjustment') ||
						(documentClass == 'CORRES_CHARGE') ||
						(documentType?.equalsIgnoreCase('DOMESTIC') && documentClass == 'BC') && serviceType?.equalsIgnoreCase('SETTLEMENT')}">
						<li class="showBillingStatement"><a href="javascript:void(0)" id="viewBillingStatement">Billing Statement</a></li>
					</g:if>
					
					<%-- billing statement with nego payment --%>	
					<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && overdrawnAmount != '0.00') ||
						((documentClass == 'DA' || documentClass == 'DR' || documentClass == 'OA') && serviceType == 'Settlement') ||
						(documentType == 'FOREIGN' && documentClass == 'DP' && serviceType == 'Settlement') ||
						(documentType == 'DOMESTIC' && documentClass == 'DP' && serviceType == 'Settlement') ||
						(documentSubType1 == 'REGULAR' && (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType == 'UA_LOAN_SETTLEMENT'))}">
						<li class="showBillingStatementNego"><a href="javascript:void(0)" id="viewBillingStatementForNegoAmount">Billing Statement</a></li>
					</g:if>

                    <g:if test="${ documentType == 'FOREIGN' && documentSubType1 == 'REGULAR' && (documentType == 'DOMESTIC' && documentSubType1 == 'REGULAR' &&
                            (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType == 'UA_LOAN_SETTLEMENT'))}">
                        <li class="showBillingStatementNego"><a href="javascript:void(0)" id="viewBillingStatementForNegoAmount">Billing Statement</a></li>
                    </g:if>
					
					<%-- billing statement for md --%>
					<g:if test="${documentClass == 'MD' && serviceType == 'Collection'}">
						<li><a href="javascript:void(0)" id="viewBillingStatementForMarginalDeposit">Billing Statement</a></li>
					</g:if>
				</g:if>
            </g:if>
            		
        	<%-- For Payment Processing --%>
			<g:if test="${referenceType == 'PAYMENT'}">
                <script>
                    var fromReverse = '${session.chargesModel?.reversalPaymentProcessing}';
                </script>
                <li><a href="javascript:void(0)" id="prepareDataEntryBtn">${'viewMode' == onViewMode ? 'View Data Entry' : 'Prepare Data Entry'}</a></li>
            </g:if>
            
            <g:if test="${(referenceType == 'PAYMENT' && documentClass == 'EXPORT_ADVISING')}">
				<li class="showBillingStatement"><a href="javascript:void(0)" id="viewBillingStatement">Billing Statement</a></li>
			</g:if>

        	<%-- For Data Entry --%>
        	<%-- Not Applicable for Cancellation and Negotiation Discrepancy --%>
			<g:if test="${referenceType == 'DATA_ENTRY' && !(documentClass in ['BC', 'BP'])}">
				<g:if test="${!(serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('LC')) && (!(serviceType?.equalsIgnoreCase('Negotiation Discrepancy') || serviceType?.equalsIgnoreCase('negotiation_discrepancy') || serviceType?.equalsIgnoreCase('Collection')) && !(serviceType?.equalsIgnoreCase('Adjustment') && documentClass?.equalsIgnoreCase('LC')) || (serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('Regular') && partialCash))}">
					<g:if test="${documentClass !='LC' && documentType == 'Settlement'}">
                 	   <li><a onclick="goToViewMt(400)" href="javascript:void(0)">View MT 400</a></li>
                    </g:if>
				</g:if>
				<%-- not applicable for md collection & DM DP Settlement Cancellation & TSD initiated amendment --%>
				<g:if test="${documentClass == 'EXPORT_ADVISING' && tradeServiceId}">
					<li class="viewPayTransactionLink"><a href="javascript:void(0)" id="payTransactionBtn">Pay Transaction</a></li>
				</g:if>		
				<g:elseif test="${!(documentClass in ['EXPORT_ADVISING', 'IMPORT_ADVANCE', 'REBATE', 'MD'])}">
                    <script>
                        var fromReverse = '${session.dataEntryModel?.reversalDataEntry}';                     
                    </script>
                    <g:if test="${!draftStatus?.equalsIgnoreCase('DRAFT')}">
						<li class="viewPayTransactionLink"><a href="javascript:void(0)" id="payTransactionBtn">Pay Transaction</a></li>
					</g:if>
				</g:elseif>
            </g:if>
            
			<g:if test="${referenceType == 'DATA_ENTRY' && documentClass == 'CORRES_CHARGE' && remitCorresCharges == 'Y'}">
				<li><a onclick="goToViewMt(202)" href="javascript:void(0)">View MT 202</a></li>
			</g:if>
			
            <g:if test="${'EXPORT_ADVISING'.equalsIgnoreCase(documentClass) &&
                    'FIRST_ADVISING'.equalsIgnoreCase(documentSubType1) &&
                    '1'.equals(sendMt730Flag)}">
                <li><a onclick="goToViewMt(730)" href="javascript:void(0)">View MT 730</a></li>
            </g:if>
            
            <%-- Accounting Entries Link --%>
			<g:if test="${((referenceType == 'DATA_ENTRY' || referenceType == 'PAYMENT') && session['userrole']['id'].equalsIgnoreCase('TSDO') && !title?.contains('Reversal')) && documentClass != 'BC'
				||((documentClass == 'AP' && (serviceType == "Apply" || serviceType == "Setup")) && session['userrole']['id'].equalsIgnoreCase('TSDO'))
				|| (documentClass == 'CDT' && serviceType == 'PAYMENT') || (documentClass in ['BC', 'BP'] && serviceType in ['NEGOTIATION', 'SETTLEMENT'] && session['userrole']['id'].equalsIgnoreCase('TSDO'))}">
				<li class="showPaymentAccountingEntriesLink">
					<a href="javascript:void(0)" id="openAccountingEntries" class="enablePaymentAccountingEntries disableAccountingEntries">View Payment Accounting Entries</a>
				</li>                
				<li class="showTransactionAccountingEntriesLink">
					<a href="javascript:void(0)" id="openTransactionAccountingEntries" class="enableTransactionAccountingEntries disableAccountingEntries">View Transaction Accounting Entries</a>
				</li>
			</g:if>
			
			<%-- pay process report links --%>
			<g:if test="${referenceType == 'PAYMENT' && !title?.contains('Reversal') && !(documentClass?.equalsIgnoreCase('LC') && serviceType?.equalsIgnoreCase('REFUND'))}">				
              	<%-- debit memo will show if CASA is PAID --%>
              	<g:if test="${!(documentClass == 'EXPORT_CHARGES' && serviceType == 'REFUND')}">
            		<li><a href="javascript:void(0)" id="viewDebitMemoPayment" class="viewDebitMemo disableDebitMemo">View Debit Memo</a></li>
            	</g:if>
            	<%-- for dm dp settlement --%>
            	<g:if test="${ (documentClass == 'EXPORT_CHARGES' && serviceType == 'REFUND')
				
					|| (documentType == 'DOMESTIC' && documentClass == 'DP' && serviceType?.equalsIgnoreCase('Settlement'))
					|| (documentType == 'DOMESTIC' && documentClass == 'LC' && serviceType?.equalsIgnoreCase('Negotiation') && (tenor != 'USANCE' && documentSubType2 != 'USANCE'))
            		|| (documentType == 'DOMESTIC' && documentClass == 'LC' && (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType == 'UA_LOAN_SETTLEMENT') && (tenor == 'USANCE' || documentSubType2 == 'USANCE'))}">
					<li><a href="javascript:void(0)" id="viewCreditMemoDataEntryDomestic" class="viewCreditMemo disableCreditMemo">View Credit Memo</a></li>
					<g:if test="${!(documentClass == 'EXPORT_CHARGES' && serviceType == 'REFUND')}">
						<li><a href="javascript:void(0)" id="viewPddtsReport" class="viewPddts disablePddts">View PDDTS</a></li>
					</g:if>
				</g:if>

				<%-- add conditions to generatePaymentSummary.js --%>
				<g:if test="${!(documentClass == 'EXPORT_CHARGES' && serviceType == 'REFUND')}">
                	<li class="showPaySummaryWithCash"><a href="javascript:void(0)" id="viewPaymentSummaryPayment" class="enablePaySummaryWithCash disablePaySummaryWithCash">View Payment Summary</a></li>
                </g:if>
				<li class="showPaySummaryWithoutCash"><a href="javascript:void(0)" id="viewPaymentSummaryWithoutCash" class="enablePaySummaryWithoutCash disablePaySummaryWithoutCash">View Payment Summary</a></li>
            	         
            </g:if>   
            
            <g:if test="${(documentClass?.equalsIgnoreCase('LC') && serviceType?.equalsIgnoreCase('REFUND') && referenceType == 'PAYMENT')
            	|| (documentClass?.equalsIgnoreCase('AP') && serviceType?.equalsIgnoreCase('REFUND') && referenceType == 'DATA_ENTRY')
            	|| (documentClass?.equalsIgnoreCase('MD') && serviceType?.equalsIgnoreCase('APPLICATION') && documentType?.equalsIgnoreCase('REFUND') && referenceType == 'DATA_ENTRY')}">
            	<li><a href="javascript:void(0)" id="viewCreditMemoDataEntryDomestic" class="viewCreditMemo disableCreditMemo">View Credit Memo</a></li>
            </g:if>
          	          	
			<%-- data entry report links (per group by documentClass and report)--%>
			<g:if test="${referenceType == 'DATA_ENTRY' && !title?.contains('Reversal')}">
			
				<%-- Settlement of Actual Corres Charges --%>
				<g:if test="${documentClass == 'CORRES_CHARGE' && !tsdInitiated}">
                    <li><a href="javascript:void(0)" id="viewDebitMemoPayment" class="viewDebitMemo disableDebitMemo">View Debit Memo</a></li>
                    <li class="showPaySummaryWithCash"><a href="javascript:void(0)" id="viewPaymentSummaryPayment" class="enablePaySummaryWithCash disablePaySummaryWithCash">View Payment Summary</a></li>
				</g:if>
				
				<g:if test="${(documentClass == 'BC' && serviceType == 'SETTLEMENT') || (documentClass == 'BP')}">
					<li><a href="javascript:void(0)" id="viewDebitMemoPayment" class="viewDebitMemo disableDebitMemo">View Debit Memo</a></li>
					<li><a href="javascript:void(0)" id="viewCreditMemoDataEntryDomestic" class="viewCreditMemo disableCreditMemo">View Credit Memo</a></li>
					<li><a href="javascript:void(0)" id="viewPddtsReport" class="viewPddts disablePddts">View PDDTS</a></li>
					<li class="showPaySummaryWithCash"><a href="javascript:void(0)" id="viewPaymentSummaryPayment" class="enablePaySummaryWithCash disablePaySummaryWithCash">View Payment Summary</a></li>
					<li class="showPaySummaryWithoutCash"><a href="javascript:void(0)" id="viewPaymentSummaryWithoutCash" class="enablePaySummaryWithoutCash disablePaySummaryWithoutCash">View Payment Summary</a></li>
				</g:if> 
								
				<%-- for MD Collection and Import Advance --%>
				<g:if test="${(documentClass == 'MD' && ((serviceType == 'Application' && documentType == 'REFUND') || serviceType == 'Collection'))
					|| (documentClass == 'IMPORT_ADVANCE' && serviceType == 'PAYMENT')}">
					<li><a href="javascript:void(0)" id="viewDebitMemoPayment" class="viewDebitMemo disableDebitMemo">View Debit Memo</a></li>
					<li class="showPaySummaryWithCash"><a href="javascript:void(0)" id="viewPaymentSummaryOtherImports" class="enablePaySummaryWithCash disablePaySummaryWithCash">View Payment Summary</a></li>
					
					<g:if test="${documentClass == 'IMPORT_ADVANCE' && serviceType == 'PAYMENT'}">
						<li><a onclick="goToViewMt(103)" href="javascript:void(0)">View MT 103</a></li>
					</g:if>
				</g:if>
				
				<%-- Payment of Other Import Charges --%>
				<g:if test="${documentClass == 'IMPORT_CHARGES'}">
					<li><a href="javascript:void(0)" id="viewDebitMemoPayment" class="viewDebitMemo disableDebitMemo">View Debit Memo</a></li>
					<li class="showPaySummaryWithoutCash"><a href="javascript:void(0)" id="viewPaymentSummaryWithoutCash" class="enablePaySummaryWithoutCash disablePaySummaryWithoutCash">View Payment Summary</a></li>
				</g:if> 
				
				<%-- LC --%>
				<g:if test="${documentClass == 'LC'}">
					<g:if test="${serviceType == 'Opening' || serviceType == 'Amendment' ||
						(((serviceType == 'Negotiation') || (serviceType == 'UA Loan Settlement' || serviceType == 'UA_LOAN_SETTLEMENT')) && documentSubType1 == 'REGULAR')}">
						<li><a href="javascript:void(0)" onclick="openTransmittalLetterPopUp()">View Transmittal Letter</a></li>
					</g:if>
			
					<g:if test="${serviceType == 'Negotiation'}">
						<g:if test="${documentType == 'FOREIGN' && (documentSubType1 == 'REGULAR' || documentSubType1 == 'CASH')}">
							<li><a href="javascript:void(0)" onclick="openBankCertificationAuthorizedSignatoryPopUp()">Bank Certification</a></li>
						</g:if>
						<g:if test="${ !(documentType == 'DOMESTIC' && documentSubType1 == 'CASH')}">
							<li><a href="javascript:void(0)" onclick="openDocumentCheckListAuthorizedSignatoryPopUp()">Document Checklist</a></li>
						</g:if>					
					</g:if>
					
					<g:if test="${serviceType == 'NEGOTIATION_DISCREPANCY' || serviceType == 'Negotiation Discrepancy' || serviceType == 'Negotiation_Discrepancy'}">
						<li><a href="javascript:void(0)" id="generateDiscrepancyLetterLink" >Generate Discrepancy Letter</a></li>
					</g:if>
			
					<g:if test="${documentType == 'DOMESTIC'}">
						<g:if test="${documentSubType1 != 'STANDBY' && serviceType == 'Opening'}">
							<li><a href="javascript:void(0)" onclick="openLcConfirmationOpeningPopUp()">LC Confirmation</a></li>
						</g:if>
						<g:if test="${documentSubType1 == 'STANDBY' && serviceType == 'Opening'}">
							<li><a href="javascript:void(0)" id="viewLcConfirmationStandbyOpening">LC Confirmation</a></li>
						</g:if>
						<g:if test="${serviceType == 'Amendment'}">
							<li><a href="javascript:void(0)" onclick="openLcConfirmationAmendmentPopUp()">LC Confirmation</a></li>
						</g:if>
					</g:if>
				</g:if>
				<%-- end of LC --%>
				
				<%-- NON LC --%>
				<g:if test="${documentClass == 'DA' || documentClass == 'DP' || documentClass == 'DR' || documentClass == 'OA'}"> 
<%--					<g:if test="${(documentType == 'FOREIGN' && serviceType == 'Cancellation') || (documentType == 'DOMESTIC' && settleFlag == 'Y')}">--%>
					<g:if test="${(documentType == 'FOREIGN' && serviceType == 'Cancellation') || (documentType == 'DOMESTIC' && serviceType == 'Cancellation')}">
						<li id="showLetterOfTransfer"><a href="javascript:void(0)" onclick="openLetterOfTransferPopUp()">Letter of Transfer</a></li>
					</g:if>
					
					<g:if test="${documentType == 'FOREIGN' &&
						(documentClass == 'DA' || documentClass == 'DP') &&
						(serviceType == 'Negotiation' || serviceType == 'Negotiation Acceptance')}">
						<li><a href="javascript:void(0)" onclick="openDocumentCheckListAuthorizedSignatoryPopUp()">Document Checklist</a></li>
					</g:if>
					
					<g:if test="${documentType == 'FOREIGN' && serviceType == 'Settlement'}">
						<li><a href="javascript:void(0)" onclick="openBankCertificationAuthorizedSignatoryPopUp()">Bank Certification</a></li>
					</g:if>
				</g:if>
				<%-- end of NON LC --%>
				
				<%-- for Export Advising --%>
				<g:if test="${documentClass == 'EXPORT_ADVISING'}">
					<li><a href="javascript:void(0)" onclick="openLetterOfAdvisePopUp()">Letter of Advice</a></li>
				</g:if>
				
				<%-- for Export Bills Negotiation --%>
				<g:if test="${(documentClass == 'BC' || documentClass == 'BP') && serviceType?.equalsIgnoreCase('Negotiation')}">
					<li><a href="javascript:void(0)" onclick="openExportNegotiationAdvicePopUp()" class="">Export Negotiation Advice</a></li>
				<%-- <g:if test="${documentType == 'FOREIGN' && mtFlag == '1' && (paymentMode == 'LC' ||
						paymentMode == 'LC') && ((issuingBankCode != null && reimbursingBankCode != null) &&
							 !issuingBankCode.equals(reimbursingBankCode))}"> --%>
					<g:if test="${documentType == 'FOREIGN' && mtFlag == '1' && paymentMode == 'LC'}">
						<li><a onclick="goToViewMt(742)" href="javascript:void(0)">View MT 742</a></li>
					</g:if>
				</g:if>
				<g:if test="${documentClass == 'EXPORT_ADVISING' && serviceType?.equalsIgnoreCase('CANCELLATION_ADVISING') && 
					sendMt799Flag.equals('1')}">
					<li><a onclick="goToViewMt(799)" href="javascript:void(0)">View MT 799</a></li>
				</g:if>
				
				<g:if test="${documentClass == 'BC' && serviceType?.equalsIgnoreCase('Settlement')}">
					<%-- remove for Issue # 4169 --%>	 
			<%-- <li><a href="javascript:void(0)" id="openAccountingEntries" class="enablePaymentAccountingEntries disableAccountingEntries">View Payment Accounting Entries</a></li> --%>                
					<%-- <li> 
						<a href="javascript:void(0)" id="openTransactionAccountingEntries" class="enableTransactionAccountingEntries disableAccountingEntries">View Transaction Accounting Entries</a>
					</li> --%>
				</g:if>
			</g:if>
			<%-- end of data entry report links --%>
			
			<%--MT LINKS IN ACTION--%>
          	<g:if test="${!session.userrole.id.contains('BR') && !title?.contains('Reversal')}"> 	
				<%--Foreign --%>
          		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">          		
          			<%--LC--%>
          			<g:if test="${documentClass?.equalsIgnoreCase('LC')}">
	          			<%--Opening --%>
	          			<g:if test="${serviceType?.equalsIgnoreCase('OPENING')}">
		          			<%--Cash and Regular--%>
		          			<g:if test="${documentSubType1?.equalsIgnoreCase('Cash') || documentSubType1?.equalsIgnoreCase('Regular')}">
			          			<li><a class="mtPreview" onclick="goToViewMt(700,0)" href="javascript:void(0)">View MT 700</a></li>
                                <g:set var="maxSequenceNumber" value="${GspStringUtils.getNumberOfViews(generalDescriptionOfGoods?:"", specialPaymentConditionsForReceivingBank?:"", specialPaymentConditionsForBeneficiary?:"", requiredDocumentsList?:[], additionalConditionsList?:[])}"/>                                
                                <g:if test="${maxSequenceNumber > 0}">
                                <g:each in="${1..maxSequenceNumber}" var="i">
                                    <li><a onclick="goToViewMt(701, ${i})" href="javascript:void(0)">View MT 701 - ${i}</a></li>
                                </g:each>
                                </g:if>
			          			<g:if test="${
									!GspStringUtils.getExistingValue(reimbursingBankIdentifierCodeTo,reimbursingBankIdentifierCode).isEmpty() &&
								  	!GspStringUtils.getExistingValue(reimbursingBankIdentifierCodeTo,reimbursingBankIdentifierCode).
								  	equals(GspStringUtils.getExistingValue(destinationBankTo,destinationBank))
								}">
				          			<li><a onclick="goToViewMt(740)" href="javascript:void(0)">View MT 740</a></li>
			          			</g:if>
		          			</g:if>
		          			<%--Standby--%>
		          			<g:else>
		          				<li><a onclick="goToViewMt(760)" href="javascript:void(0)">View MT 760</a></li>
	          				</g:else>
	          			</g:if>
	          			
	          			<%--Amendment--%>
	          			<g:if test="${serviceType?.equalsIgnoreCase('AMENDMENT')}">
		          			<%--Cash and Regular--%>
		          			<g:if test="${documentSubType1?.equalsIgnoreCase('Cash') || documentSubType1?.equalsIgnoreCase('Regular')}">
                                
		          				<li><a onclick="goToViewMt(707, 0)" href="javascript:void(0)">View MT 707</a></li>		          				
                                <g:set var="maxSequenceNumber" value="${GspStringUtils.getNumberOfViewsAmendment(generalDescriptionOfGoodsTo?:"", specialPaymentConditionsForReceivingBankTo?:"", specialPaymentConditionsForBeneficiaryTo?:"", mtDocuments?:"", mtConditions?:"")}"/>                                
                                <g:if test="${maxSequenceNumber > 0}">
                                <g:each in="${1..maxSequenceNumber}" var="i">
                                    <li><a onclick="goToViewMt(708, ${i})" href="javascript:void(0)">View MT 708 - ${i}</a></li>
                                </g:each>
                                </g:if>
		          				<g:if test="${
									
									GspStringUtils.isNotEmpty(positiveToleranceLimitTo,negativeToleranceLimitTo,maximumCreditAmountTo,
										additionalAmountsCoveredTo,amountTo,expiryDateTo) && 
									(
										!GspStringUtils.getExistingValue(reimbursingBankIdentifierCodeTo,reimbursingBankIdentifierCodeFrom,
											reimbursingBankIdentifierCode).isEmpty() &&
										!GspStringUtils.getExistingValue(reimbursingBankIdentifierCodeTo,reimbursingBankIdentifierCodeFrom).
										equals(GspStringUtils.getExistingValue(destinationBankTo,destinationBankFrom))
									)
									
									}">
			          				<li><a onclick="goToViewMt(747)" href="javascript:void(0)">View MT 747</a></li>
	          					</g:if>
		          			</g:if>
		          			<%--Standby--%>
		          			<g:else>
		          				<li><a onclick="goToViewMt(767)" href="javascript:void(0)">View MT 767</a></li>
	          				</g:else>
	          			</g:if>
	          			
	          			<%--Negotiation Discrepancy--%>
	          			<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION DISCREPANCY') || serviceType?.equalsIgnoreCase('NEGOTIATION_DISCREPANCY')}">
	          				<li><a href="javascript:void(0)" id="viewMt734Link" >View MT 734</a></li>
	          			</g:if>
	          			
	          			<%--Negotiation--%>
	          			<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">
	       					<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
	       						<g:if test="${'MT752' == generateMt}">
		          				<li><a onclick="goToViewMt(752)" href="javascript:void(0)">View MT 752</a></li>	       						
	       						</g:if>
	       						<g:elseif test="${'MT202' == generateMt}">
		          					<li><a onclick="goToViewMt(202)" href="javascript:void(0)">View MT 202</a></li>	       					
	       						</g:elseif>
	       					</g:if>
	       					<g:else>
	          					<li><a onclick="goToViewMt(202)" href="javascript:void(0)">View MT 202</a></li>	       					
		          				<li><a onclick="goToViewMt(752)" href="javascript:void(0)">View MT 752</a></li>
	       					</g:else>
		       			</g:if>
	          	
	          			<%--UA Loan Settlement--%>
			          	<g:if test="${serviceType?.equalsIgnoreCase('UA LOAN SETTLEMENT') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')}">
				          	<g:if test="${'MT202' == generateMt}">
				          		<li><a onclick="goToViewMt(202)" href="javascript:void(0)">View MT 202</a></li>
			          		</g:if>
			          	</g:if>  
		          	</g:if>
		          	
		          	<%--DP--%>
		          	<g:if test="${documentClass?.equalsIgnoreCase('DP') && !referenceType?.equalsIgnoreCase('ETS')}">
		          		<%--Negotiation Acknowledgement --%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION ACKNOWLEDGEMENT') }">
		          			<li><a onclick="goToViewMt(410)" href="javascript:void(0)">View MT 410</a></li>
		          		</g:if>
		          		
		          		<%--Negotiation --%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') }">
		          			<li><a onclick="goToViewMt(410)" href="javascript:void(0)">View MT 410</a></li>
		          		</g:if>
		          		
		          		<%--Settlement--%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('SETTLEMENT')}">
		          			<li><a onclick="goToViewMt(202)" href="javascript:void(0)">View MT 202</a></li>
		          			<li><a onclick="goToViewMt(400)" href="javascript:void(0)">View MT 400</a></li>
		          		</g:if>
		          	</g:if>
		          	
		          	<%--DA--%>
		          	<g:if test="${documentClass?.equalsIgnoreCase('DA') && !referenceType?.equalsIgnoreCase('ETS') }">
		          	
		          		<%--Negotiation Acknowledgement --%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION ACKNOWLEDGEMENT') }">
		          			<li><a onclick="goToViewMt(410)" href="javascript:void(0)">View MT 410</a></li>
		          		</g:if>
		          		
		          		<%--Negotiation Acceptance --%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION ACCEPTANCE') }">
		          			<li><a onclick="goToViewMt(412)" href="javascript:void(0)">View MT 412</a></li>
		          		</g:if>		      
		          		
		          		<%--Settlement--%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('SETTLEMENT')}">
		          			<li><a onclick="goToViewMt(202)" href="javascript:void(0)">View MT 202</a></li>
		          			<li><a onclick="goToViewMt(400)" href="javascript:void(0)">View MT 400</a></li>
		          		</g:if>
		          	</g:if>
		          	
		          	<%--DR--%>
		          	<g:if test="${documentClass?.equalsIgnoreCase('DR')}">
		          		<%--Settlement--%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('SETTLEMENT')}">
		          			<li><a onclick="goToViewMt(103)" href="javascript:void(0)">View MT 103</a></li>
		          		</g:if>
		          	</g:if>
		          	
		          	<%--OA--%>
		          	<g:if test="${documentClass?.equalsIgnoreCase('OA')}">
		          		<%--Settlement--%>
		          		<g:if test="${serviceType?.equalsIgnoreCase('SETTLEMENT')}">
		          			<li><a onclick="goToViewMt(103)" href="javascript:void(0)">View MT 103</a></li>
		          		</g:if>
		          	</g:if>
          		</g:if>
          		
          		<%--Domestic --%>
          		<g:else>          			
          			<%--LC--%>
          			<g:if test="${documentClass?.equalsIgnoreCase('LC')}">
	          			<%--Negotiation--%>
	          			<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">
<%--	          				<li><g:remoteLink action="generateSwiftMessage" class="viewMt103 disableMt103" controller="swift" onFailure="mtPreviewGenerationFailed()" onSuccess="showMtPopup()" update="mt_popup_wrapper" params="[messageType : '103']">View MT 103</g:remoteLink> </li>--%>
							<li><a class="viewMt103 disableMt103" onclick="goToViewMt(103)" href="javascript:void(0)">View MT 103</a></li>
	          			</g:if>
	          			
		          		<%--UA Loan Settlement--%>
				         <g:if test="${serviceType?.equalsIgnoreCase('UA LOAN SETTLEMENT') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')}">
				          	<li><a class="viewMt103 disableMt103" onclick="goToViewMt(103)" href="javascript:void(0)">View MT 103</a></li>
				         </g:if>
          			</g:if>
          			
          			<%--NON LC--%>
          			<g:else>
	          		
			          	
				        <%--DP--%>
			          	<g:if test="${documentClass?.equalsIgnoreCase('DP')}">
			          		<%--Settlement--%>
<%--			          		<g:if test="${serviceType?.equalsIgnoreCase('SETTLEMENT') && settleFlag == 'N'}">--%>
								<g:if test="${serviceType?.equalsIgnoreCase('SETTLEMENT')}">
                                  <li class="viewMt103Li">
                                  <g:if test="${referenceType.equals("DATA_ENTRY")}">
                                      <g:if test="${mt103Flag.equals("Y")}">
                                          <script>
                                              $(document).ready(function() {
                                                  $(".hiddenViewMt").hide();
                                              });
                                          </script>

                                          <a class="hiddenViewMt hideMe" onclick="goToViewMt(103)" href="javascript:void(0)">View MT 103</a>
                                      </g:if>
                                  </g:if>
                                  <g:else>
                                      <a class="hiddenViewMt" onclick="goToViewMt(103)" href="javascript:void(0)">View MT 103</a>
                                  </g:else>
                                </li>
			          		</g:if>
			          	</g:if>  
			         </g:else>
         	   </g:else>
         	 
			</g:if>	   
        </ul>
    </div>
</div>

%{--tempoarary, just to display other forms of reporting--}%
<g:if test="${title?.contains('Unacted Transactions') || title?.contains('Inquiry')}">
<div class="AccordionPanel">
    <div class="AccordionPanelTab" id="accordpanel_swift">Online Reports</div>

    <div class="AccordionPanelContent">
        <ul>
            %{--Alvin--}%
			<li><a href="javascript:void(0)" onclick="openBankCertificationPopUp()">Bank Certification</a></li>
			<li><a href="javascript:void(0)" onclick="openDailyExceptionReportAccountingEntriesPopUp()">Daily Exception Report of Accounting Entries</a></li>
            <li><a href="javascript:void(0)"
                   onclick="openDailyForeignRegularLcOpenedPopUp()">Daily Foreign Regular LCs Opened</a></li>
            <li><a href="javascript:void(0)"
                   onclick="openDailyFundingReportPopUp()">Daily Funding Report</a></li>
            <li><a href="javascript:void(0)" onclick="openDailyFxlcOpenedReportCdtDetailsPopUp()">Daily FXLC Opened Report with CDT Details</a></li>
            <li><a href="javascript:void(0)"
                   onclick="openDailyOutstandingLcCcbdReportPopUp()">Daily Outstanding LCs (CCBD Report)</a></li>
	       	<li><a href="javascript:void(0)" onclick="openDailyReportProcessedRefundsPopUp()">Daily Report on Processed Refunds</a></li>
	       	<li><a href="javascript:void(0)" onclick="openDailySummaryAccountingEntriesPopUp()">Daily Summary Of Accounting Entries</a></li>
            <li><a href="javascript:void(0)"
                   onclick="openTFSCASAPostingPopUp()">TFS CASA Posting Report</a>
            </li> 
			<li><a href="javascript:void(0)" onclick="openTramsReportPopUp()">TRAMS Report</a></li>
			<li><a href="javascript:void(0)" onclick="reverseOrCancelLc()">Reverse Expired LC</a></li>
        </ul>
    </div>
</div>
</g:if>

<div class="AccordionPanel">
	<div class="AccordionPanelTab" id="accordpanel_swift">Manual Reports for SPAD</div>
	<div class="AccordionPanelContent">
		<ul>
			<li><a href="javascript:void(0)" onclick="openActualCorresChargesDataEntryPopUp('report')">Actual Corres Charges Data Entry</a></li>
			<li><a href="javascript:void(0)" id="adbBureauOfCustomsCollectionSpad">ADB of Bureau of Customs Collection</a></li>
			<li><a href="javascript:void(0)" onclick="openRebatesFromCorresBankDataEntryPopUp('report')">Rebates from Corres Bank Data Entry</a></li>
			<li><a href="javascript:void(0)" id="scheduleOfMarginalDepositSpad">Schedule of Marginal Deposit</a></li>
			<li><a href="javascript:void(0)" id="tsdExportBankCommissionSpad">TSD Export Bank Commission</a></li>
			
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule3PopUp('schedule3Report')">FX Form1 Schedule 3</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule4PopUp('schedule4Report')">FX Form1 Schedule 4</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule5PopUp('schedule5Report')">FX Form1 Schedule 5</a></li>
			<%-- <li><a href="javascript:void(0)" onclick="openFxForm1Schedule7PopUp('schedule7Report')">FX Form1 Schedule 7</a></li> --%>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule9PopUp('schedule9Report')">FX Form1 Schedule 9</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule10PopUp('schedule10Report')">FX Form1 Schedule 10</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule11PopUp('schedule11Report')">FX Form1 Schedule 11</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm4CredexPopUp()">FX Form4 CREDEX</a></li>
			<%--
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule3PopUp('schedule3Text')">TRD03.txt</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule4PopUp('schedule4Text')">TRD04.txt</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule5PopUp('schedule5Text')">TRD05.txt</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule7PopUp('schedule7Text')">TRD07.txt</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule9PopUp('schedule9Text')">TRD09.txt</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule10PopUp('schedule10Text')">TRD10.txt</a></li>
			<li><a href="javascript:void(0)" onclick="openFxForm1Schedule11PopUp('schedule11Text')">TRD11.txt</a></li>
			--%>
		</ul>
	</div>
</div>

<div class="AccordionPanel">
    <div class="AccordionPanelTab panelImportProducts" id="accordpanel_importProd">Import Products</div>
    <div class="AccordionPanelContent panelImportProducts">
        %{--IMPORT CONTENTS--}%
        <br/>

        <h2 class="title_label_accordion">Letter of Credit</h2>
        <ul>
            <g:if test="${!session.userrole.id?.equalsIgnoreCase('BRO') && session['group']?.equalsIgnoreCase("BRANCH")}">
                <li><a href="javascript:void(0)" id="btnCreateTransaction">Create Transaction</a></li>
            </g:if>
            <li><a href="javascript:void(0)" id="lcInquiryBtn">LC Inquiry</a></li>
            <li><a href="javascript:void(0)" id="bgInquiryBtn">BG Inquiry</a></li>
            <li><a href="javascript:void(0)" id="negotiationInquiryBtn">Negotiation Inquiry</a></li>
            <g:if test="${session['group']?.equalsIgnoreCase('TSD')}" >
            	<li><a href="javascript:void(0)" id="icInquiryBtn">IC Inquiry</a></li>
            </g:if>
        </ul>
        <br/>

        <h2 class="title_label_accordion">Non-Letter of Credit</h2>
        <ul>
            <g:if test="${session['userrole']['id']?.contains('TSDM') && session['higherUserHeirarchy'] >= 2}">
                <li><a href="javascript:void(0)" id="btnCreateNonLc">Create Transaction</a></li>
           </g:if>
            <li><a href="javascript:void(0)" id="nonLcInquiryBtn">Non-LC Inquiry</a></li>
        </ul>
        <br/>

        <h2 class="title_label_accordion">Import Advance</h2>
        <ul>           
            <g:if test="${session['userrole']['id']?.equalsIgnoreCase('BRM')}">
                <li><a href="javascript:void(0)" id="importAdvancePaymentBtn">Create Transaction</a></li>
            </g:if>
            %{--<li><a href="javascript:void(0)" id="importChargesPaymentBtn">Create Transaction Charges</a></li>--}%
            <li><a href="javascript:void(0)" onClick="importAdvancePaymentInquiry()"
                   id="importAdvanceInquiryBtn">Import Advance Inquiry</a></li>
        </ul>
    </div>
</div>

<div class="AccordionPanel">
    <div class="AccordionPanelTab panelAuxillary" id="accordpanel_auxImport">Auxillary Import Products</div>

    <div class="AccordionPanelContent panelAuxillary">
        %{--AUXILLARY CONTENTS--}%
        <br/>

        <h2 class="title_label_accordion">Settlement of Actual Corres Charges</h2>
        <ul>
            <li><a href="javascript:void(0)" onClick="actualCorresChargesInquiry()"
                   id="actualCorresTransactionInquiryBtn">Actual Corres Transaction Inquiry</a></li>
            <g:if test="${"TSD".equals(session.group)}">
                <li><a href="javascript:void(0)" id="actualCorresChargeSettlement">Actual Corres Charges for Bank Settlement</a></li>
            </g:if>
        </ul>
        <g:if test="${"TSD".equals(session.group)}">
            <br/>

            <h2 class="title_label_accordion">Processing Rebates</h2>
            <ul>
                <li><a href="javascript:void(0)" id="rebateInquiryBtn">Rebate Inquiry</a></li>
                <g:if test="${session['userrole']['id']?.equalsIgnoreCase('TSDM')}">
                    <li><a href="javascript:void(0)" onClick="createRebate()">Create Rebate Data Entry</a></li>
                </g:if>
            </ul>
        </g:if>
        <br/>

        <h2 class="title_label_accordion">MD Collection</h2>
        <ul>
            <li><a href="javascript:void(0)" id="mdCollectionInquiryBtn">MD Collection Inquiry</a></li>
        </ul>
        <br/>

        <h2 class="title_label_accordion">MD Application</h2>
        <ul>
            <li><a href="javascript:void(0)" id="mdApplicationInquiryBtn">MD Application Inquiry</a></li>
        </ul>
        <br/>

        <h2 class="title_label_accordion">Accounts Receivable Monitoring</h2>
        <ul>
            <li><a href="javascript:void(0)" id="arInquiryBtn">AR Monitoring Inquiry</a></li>
            <g:if test="${session['userrole']['id']?.equalsIgnoreCase("TSDM")}">
                <li><a href="javascript:void(0)" id="setupArBtn">Set-Up Accounts Receivable</a></li>
            </g:if>
        </ul>
        <br/>

        <h2 class="title_label_accordion">Accounts Payable Monitoring</h2>
        <ul>
            <li><a href="javascript:void(0)" id="apInquiryBtn">AP Monitoring Inquiry</a></li>
            <g:if test="${session['userrole']['id']?.equalsIgnoreCase("TSDM")}">
                <li><a href="javascript:void(0)" id="setupApBtn">Set-Up Accounts Payable</a></li>
            </g:if>
        </ul>
        <br/>

        <h2 class="title_label_accordion">Custom Duties and Taxes</h2>
        <br/>

        <h2 class="title_label_accordion">&#160;&#160;&#160;Client</h2>
        <ul>
            <li><a href="javascript:void(0)" onClick="cdtClientInquiry()"
                   id="clientFileInquiryBtn">Client File Inquiry</a></li>
            %{--<li><a href="javascript:void(0)" onClick="uploadClientFileCdt()">Upload Client File</a></li>--}%
            <li><a href="javascript:void(0)" id="cdtUploadClients">Upload Client File</a></li>
        </ul>
        <br/>

        <h2 class="title_label_accordion">&#160;&#160;&#160;Collection</h2>
        <ul>
            <li><a href="javascript:void(0)" onClick="cdtInquiry()">CDT Inquiry</a></li>
            %{--<g:if test="${session['group']?.equalsIgnoreCase("TSD")}">--}%
            <li>
                %{--<a href="javascript:void(0)"--}%
                   %{--onClick="uploadTransactionCdt()">Upload Today's Transaction/<br/>Pending Transaction</a>--}%
                <a href="javascript:void(0)" id="cdtUploadTransactions">Upload Today's Transaction/<br/>Pending Transaction</a>
            </li>
            <li><a href="javascript:void(0)" id="cdtUploadPaymentHistory">Upload Payment History</a></li>
            %{--</g:if>--}%
        </ul>
        <br/>
        <g:if test="${session['group']?.equalsIgnoreCase("TSD")}">
            <h2 class="title_label_accordion">&#160;&#160;&#160;Remittance</h2>
            <ul>
                <li><a href="javascript:void(0)" onClick="remittanceInquiry()"
                       id="remittanceInquiryBtn">Remittance Inquiry</a></li>
                <g:if test="${session['userrole']['id']?.equalsIgnoreCase("TSDM")}">
                    <li><a href="javascript:void(0)" onClick="remittanceCdt()">Remit CDT</a></li>
                   <li><a href="javascript:void(0)" onClick="remittanceCdtreport()">View Report</a></li>
                    
                </g:if>
                
            </ul>
            <br/>
        </g:if>
        <g:if test="${session['userrole']['id']?.equalsIgnoreCase("BRM")}">
            <br/>

            <h2 class="title_label_accordion">Refund of Cash LC and Charges</h2>
            <ul>
                <li><a href="javascript:void(0)"
                       id="refundCashLcChargesInquiryBtn">Refund of Cash LC and Charges Inquiry</a></li>
            </ul>
            <br/>
        </g:if>
        <h2 class="title_label_accordion">Processing of Other Charges</h2>
        <ul>
            <li><a href="javascript:void(0)" onclick="otherImportChargesInquiry()"
                   id="otherImportChargesInquiryBtn">Other Import Charges Inquiry</a></li>
            <g:if test="${session.userrole.id?.equalsIgnoreCase('TSDM')}">
                <li><a href="javascript:void(0)" id="importChargesOthers">Payment of Other Import Charges - Others</a></li>
            </g:if>
        </ul>
    </div>
</div>

<%--  Export Products taken from old--%>
<div class="AccordionPanel">
    <div class="AccordionPanelTab panelExport" id="system_admin">Export Products</div>

    <div class="AccordionPanelContent panelExport">
        %{--EXPORT CONTENTS--}%
		<g:if test="${'BRANCH' != session['group']}">
	        <h2 class="title_label_accordion adviseExportOpening">Advise on Export Opening </h2>
	        <ul>
	        	<g:if test="${!session.userrole.id?.equalsIgnoreCase('TSDO')}">
		            <li class="adviseExportOpening">
		                <a href="javascript:void(0)" id="exportAdvising1st">Advise EXLC Opening - 1st Advising Bank</a>
		            </li>
		            <li class="adviseExportOpening">
		                <a href="javascript:void(0)" id="exportAdvising2nd">Advise EXLC Opening - 2nd Advising Bank</a>
		            </li>
	            </g:if>
	            <li class="adviseExportOpening">
	                <a href="javascript:void(0)" id="exportAdvisingInquiry">Export Advising Inquiry</a>
	            </li>
	
	            <li class="adviseExportOpening">
	                <a href="javascript:void(0)" id="exportAdvisingPaymentInquiry">Export Advising Payment Inquiry</a>
	            </li>
	        </ul>
		</g:if>
        %{--<h2 class="title_label_accordion adviseExportAmendment">Advise on Export Amendment</h2>--}%
        %{--<ul>--}%
            %{--<li class="adviseExportAmendment"><a href="javascript:void(0)"--}%
                                                 %{--onClick="onAdvisingBankAmendmentInquiryClick()">EXLC Amendment Inquiry</a>--}%
            %{--</li>--}%
        %{--</ul>--}%

        %{--<h2 class="title_label_accordion adviseExportCancellation">Advise on Export Cancellation</h2>--}%
        %{--<ul>--}%
            %{--<li class="adviseExportCancellation"><a href="javascript:void(0)"--}%
                                                    %{--onClick="onAdvisingBankCancellationInquiryClick()">EXLC Cancellation Inquiry</a>--}%
            %{--</li>--}%
        %{--</ul>--}%

        <h2 class="title_label_accordion">Export Bills</h2>
        <ul>
        	<g:if test="${!session.userrole.id?.equalsIgnoreCase('BRO') && session['group']?.equalsIgnoreCase("BRANCH")}">
	            <li><a href="javascript:void(0)" id="createExportBillsTransaction">Create Transaction</a></li>
        	</g:if>
            <g:if test="${!session.userrole.id?.equalsIgnoreCase('TSDO') && session['group']?.equalsIgnoreCase("TSD")}">
                <li><a href="javascript:void(0)" id="createExportBillsForCollection">Create Transaction</a></li>
            </g:if>
            <li><a href="javascript:void(0)" onClick="exportBillsInquiry()">Export Inquiry</a></li>
        </ul>

        <h2 class="title_label_accordion">Export Advance</h2>
        <ul>
        	<g:if test="${!session.userrole.id?.equalsIgnoreCase('BRO') && session['group']?.equalsIgnoreCase("BRANCH")}">
            	<li class="createExportAdvanceTransaction"><a href="javascript:void(0)" id="createExportAdvanceEts">Create Transaction</a></li>
        	</g:if>
            <li><a href="javascript:void(0)" onClick="onExportAdvanceInquiryClick()">Export Advance Inquiry</a></li>
        </ul>
    </div>
</div>

<div class="AccordionPanel">
    <div class="AccordionPanelTab" id="accordpanel_auxExp">Auxillary Export Products</div>

    <div class="AccordionPanelContent">
        <ul>
            <g:if test="${session.userrole.id?.equalsIgnoreCase('BRM')}">
                <li class="refundOtherExportCharges"><a href="javascript:void(0)" id="refundOfOtherExportChargesInquiry"> Refund of Other Export Charges Inquiry</a>
            </g:if>
            <li class="processOtherExportCharges"><a href="javascript:void(0)"
                                                     id="paymentOfOtherExportChargesInquiry">Processing of Other Export Charges Inquiry</a>
            </li>
            <g:if test="${session.userrole.id?.equalsIgnoreCase('TSDM')}">
                <li><a href="javascript:void(0)" id="exportChargesOthers">Payment of Other Export Charges - Others</a></li>
            </g:if>
        </ul>
    </div>
</div>

%{--tempoarary, just to display mt monitoring grid for user type telecom--}%
<div class="AccordionPanel">
    <div class="AccordionPanelTab" id="accordpanel_swift">MT Monitoring</div>

    <div class="AccordionPanelContent">
        <ul>
            <li><a href="javascript:void(0)" id="mtMonitoringInquiryBtn">MT Monitoring Inquiry</a></li>
        </ul>
    </div>
</div>


<g:if test="${session['userrole']['id']?.contains('TSD')}">
    <div class="AccordionPanel">
        <div class="AccordionPanelTab" id="accordpanel_swift">SWIFT</div>
        <div class="AccordionPanelContent">
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'103']">MT 103</g:link></li>
                %{--<li><a href="javascript:void(0)" onclick="otherOutgoingMtClick('103')" class="outgoingMtBtn">MT 103</a></li>--}%
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'199']">MT 199</g:link></li>
                %{--<li><a href="javascript:void(0)" onclick="otherOutgoingMtClick('199')" class="outgoingMtBtn">MT 199</a></li>--}%
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'202']">MT 202</g:link></li>
                %{--<li><a href="javascript:void(0)" class="outgoingMtBtn" onclick="otherOutgoingMtClick('202')">MT 202</a></li>--}%
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'299']">MT 299</g:link></li>
                %{--<li><a href="javascript:void(0)" class="outgoingMtBtn" onclick="otherOutgoingMtClick('299')">MT 299</a></li>--}%
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'499']">MT 499</g:link></li>
                %{--<li><a href="javascript:void(0)" class="outgoingMtBtn" onclick="otherOutgoingMtClick('499')">MT 499</a></li>--}%
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'707']">MT 707</g:link></li>
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'740']">MT 740</g:link></li>
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'742']">MT 742</g:link></li>
            <ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'747']">MT 747</g:link></li>
          </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'752']">MT 752</g:link></li>
                %{--<li><a href="javascript:void(0)" class="outgoingMtBtn" onclick="otherOutgoingMtClick('752')">MT 752</a></li>--}%
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'759']">MT 759</g:link></li>
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'799']">MT 799</g:link></li>
                %{--<li><a href="javascript:void(0)" class="outgoingMtBtn" onclick="otherOutgoingMtClick('799')">MT 799</a></li>--}%
            </ul>
            <ul>
                <li><g:link controller="outgoingMt" action="viewMt" params="[resetModel:'true',mtMessageType:'999']">MT 999</g:link></li>
                %{--<li><a href="javascript:void(0)" class="outgoingMtBtn" onclick="otherOutgoingMtClick('999')">MT 999</a></li>--}%
            </ul>
        </div>
    </div>
</g:if>

<div class="AccordionPanel">
    <div class="AccordionPanelTab" id="accordpanel_swift">Batch Reports</div>

    <div class="AccordionPanelContent">
		<ul>
			<li><a href="javascript:void(0)" id="customsDutiesAndTaxesAndOtherLevies">Customs Duties And Taxes And Other Levies</a></li>
			<li><a href="javascript:void(0)" id="ytdCustomsDutiesAndTaxesAndOtherLevies">YTD Customs Duties And Taxes And Other Levies</a></li>
			<li><a href="javascript:void(0)" id="">Allocation Exception Report</a></li>
			<li><a href="javascript:void(0)" id="APOthers">AP Others</a></li>
			<li><a href="javascript:void(0)" id="AROthers">AR Others</a></li>
			
			<li><a href="javascript:void(0)" id="viewCollectedTwoPercentCwt">Collected 2% CWT </a></li>
			<li><a href="javascript:void(0)" id="monthlyConsolidatedDmLcsOpenedReport">Cons. Report On DMLC For The Month</a></li>
			<li><a href="javascript:void(0)" id="monthlyConsolidatedFxlcReport">Cons. Report On FXLC For The Month</a></li>
			
			<li><a href="javascript:void(0)" onclick="openConsolidatedDailyReportsDepositCollected('collection')">Consolidated Daily Report on Deposits Collected</a></li>
			<li><a href="javascript:void(0)" onclick="openConsolidatedDailyReportsDepositCollected('remittance')">Consolidated Daily Report on Deposits Collected (Remittance)</a></li>
			<li><a href="javascript:void(0)" onclick="openConsolidatedDailyCollectionsDutiesTaxes('collection')">Consolidated Report on Daily Collections of Customs Duties, Taxes and Other Levies</a></li>
			<li><a href="javascript:void(0)" onclick="openConsolidatedDailyCollectionsDutiesTaxes('remittance')">Consolidated Report on Daily Collections of Customs Duties, Taxes and Other Levies (Remittance)</a></li>
			<li><a href="javascript:void(0)" onclick="openConsolidatedReportDailyExportStamp('collection')">Consolidated Report on Daily Collections of Export Documentary Stamp Fees</a></li>
			<li><a href="javascript:void(0)" onclick="openConsolidatedReportDailyExportStamp('remittance')">Consolidated Report on Daily Collections of Export Documentary Stamp Fees (Remittance)</a></li>
			<li><a href="javascript:void(0)" onclick="openConsolidatedReportDailyImportProcessing('collection')">Consolidated Report on Daily Collections of Import Processing Fees</a></li>
			<li><a href="javascript:void(0)" onclick="openConsolidatedReportDailyImportProcessing('remittance')">Consolidated Report on Daily Collections of Import Processing Fees (Remittance)</a></li>
			
			<li><a href="javascript:void(0)" onclick="openDailyForeignCashLcOpenedPopUp()">Daily Foreign Cash LCs Opened</a></li>
			<li><a href="javascript:void(0)" onclick="openDailyOutstandingForeignLcPopUp()">Daily Outstanding Foreign LCs</a></li>
			
			<li><a href="javascript:void(0)" id="dmNonLcsNegofortheYear">DM Non-LCs Negotiation For The Year</a></li>
			<li><a href="javascript:void(0)" id="monthlyDMLcOpenedReport">DMLC Opened For The Month</a></li>
			%{--<li><a href="javascript:void(0)" id="viewDwExceptionReport">DW Exception Report</a></li>--}%
			
			<li><a href="javascript:void(0)" id="exportNegofortheMonthperClient">Export Negotiation for the Month per Client</a></li>
			<li><a href="javascript:void(0)" id="exportNegoperCollectingBank">Export Negotiation per Collecting Bank</a></li>
			<li><a href="javascript:void(0)" id="exportPaymentsfortheMonthperClient">Export Payments for the Month per Client</a></li>
			
			<li><a href="javascript:void(0)" id="fxNonLcsNegofortheYear">FX Non-LCs Negotiation For The Year</a></li>
			<li><a href="javascript:void(0)" id="monthlyfxLcOpenedReport">FXLC Opened For The Month</a></li>
			
			<li><a href="javascript:void(0)" id="viewListOfTransactionsWithNoCifNumber">List of Transactions with No CIF Number</a></li>
			
			<li><a href="javascript:void(0)" id="">Master Exception Report</a></li>
			<li><a href="javascript:void(0)" id="viewMonthlyTransactionCount">Monthly Transaction Count</a></li>
			
			<li><a href="javascript:void(0)" id="viewOutstandingBankGuaranty">Outstanding Bank Guaranty</a></li>
			<li><a href="javascript:void(0)" id="outstandingDmLcCashPerCurrency">Outstanding Domestic Cash Lcs Per Currency</a></li>
			<li><a href="javascript:void(0)" id="OutstandingDmLcCashPerImporter">Outstanding Domestic Cash Lcs Per Importer</a></li>
			<li><a href="javascript:void(0)" id="outstandingDmLcSightPerCurrency">Outstanding Domestic Sight LC Per Currency</a></li>
			<li><a href="javascript:void(0)" id="outstandingDmSightLcPerImporter">Outstanding Domestic Sight LC Per Importer</a></li>
			<li><a href="javascript:void(0)" id="OutstandingDmLcStandbyPerCurrency">Outstanding Domestic Standby Lcs Per Currency</a></li>
			<li><a href="javascript:void(0)" id="OutstandingDmLcStandbyPerImporter">Outstanding Domestic Standby Lcs Per Importer</a></li>
			<li><a href="javascript:void(0)" id="outstandingDomesticLcUsancePerCurrency">Outstanding Domestic Usance LC Per Currency</a></li>
			<li><a href="javascript:void(0)" id="outstandingDomesticLcUsancePerImporter">Outstanding Domestic Usance LC Per Importer</a></li>
			<li><a href="javascript:void(0)" id="outstandingExportNegotiationDomestic">Outstanding Export Negotiation Domestic</a></li>
			<li><a href="javascript:void(0)" id="outstandingExportNegotiationForeign">Outstanding Export Negotiation Foreign</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcCashPerCurrency">Outstanding Foreign Cash Lcs Per Currency</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcCashPerImporter">Outstanding Foreign Cash Lcs Per Importer</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcSightPerCurrency">Outstanding Foreign Sight LC Per Currency</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcSightPerImporter">Outstanding Foreign Sight LC Per Importer</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcStandByPerCurrency">Outstanding Foreign Standby Lcs Per Currency</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcStandByPerImporter">Outstanding Foreign Standby Lcs Per Importer</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcUsancePerCurrency">Outstanding Foreign Usance LC Per Currency</a></li>
			<li><a href="javascript:void(0)" id="outstandingFxlcUsancePerImporter">Outstanding Foreign Usance LC Per Importer</a></li>
			<li><a href="javascript:void(0)" id="outstandingInwardBillsforCollectionDmDaDpperCurr">Outstanding Inward Bills For Collection DM DP Per Currency</a></li>
			<li><a href="javascript:void(0)" id="outstandingInwardBillsforCollectionFxDaDpperCurr">Outstanding Inward Bills For Collection FX DA/DP Per Currency</a></li>
			<li><a href="javascript:void(0)" id="OutstandingInwardBillsforCollectionFXLCperCurr">Outstanding Inward Bills for Collection FXLC per Currency</a></li>
			<li><a href="javascript:void(0)" id="viewOutstandingMarginalDeposits">Outstanding Marginal Deposits</a></li>
			
			<li><a href="javascript:void(0)" onclick="generateProductAvailments('e')">Product Availments Exception Report</a></li>
			<li><a href="javascript:void(0)" onclick="generateProductAvailments('ne')">Product Availments Report</a></li>
			<li><a href="javascript:void(0)" onclick="generateProfitabilityMonitoring('e')">Profitability Monitoring Exception Report</a></li>
			<li><a href="javascript:void(0)" onclick="generateProfitabilityMonitoring('ne')">Profitability Monitoring Report</a></li>
				
			<li><a href="javascript:void(0)" id="QuarterlyFxLcsStandybyOpenedReport">Quarterly Report On Foreign Standby Lcs Opened</a></li>
			
			<%--<li><a href="javascript:void(0)" id="viewTfsCasaPostingReport">TFS CASA Posting Report</a></li>--%>
			<li><a href="javascript:void(0)" onclick="window.open(tfsMcoUrl)">TFS MCO Reports</a></li>
			<li><a href="javascript:void(0)" onclick="openAMLAReportedTransactionsPopUp()">Trade Services AMLA Reported Transactions</a></li>
			<li><a href="javascript:void(0)" id="volumetricReport">Volumetrics Report</a></li>
			
			<li><a href="javascript:void(0)" id="weeklyMaturingUsanceReport">Weekly Report On Maturing Usance LC's</a></li>
			<li><a href="javascript:void(0)" id="viewWeeklyScheduleDocStampsTR">Weekly Schedule of Doc Stamps(TR)</a></li>
			<li><a href="javascript:void(0)" id="viewWeeklyScheduleDocStamps108">Weekly Schedule of Doc Stamps(108)</a></li>
			<li><a href="javascript:void(0)" id="viewWeeklyScheduleDocStamps113">Weekly Schedule of Doc Stamps(113)</a></li>
			
			<li><a href="javascript:void(0)" id="yearEndFxLcsOpenedPerAdvisingBankReport">Year End Report On Foreign Lcs Opened Per Advising Bank</a></li>
			<li><a href="javascript:void(0)" id="yearEndFxLcsOpenedPerConfirmingBankReport">Year End Report On Foreign Lcs Opened Per Confirming Bank</a></li>
			<li><a href="javascript:void(0)" id="yearEndFxLcsOpenedPerCountryReport">Year End Report On Foreign Lcs Opened Per Country</a></li>
			<li><a href="javascript:void(0)" id="ytdDMLCOpenedReport">YTD Report On DMLC Opened</a></li>
			<li><a href="javascript:void(0)" id="ytdDMLCOpenedClssfiedbyBankReport">YTD Report On DMLC Opened Classified By Bank</a></li>
			<li><a href="javascript:void(0)" id="ytdFXLCOpenedReport">YTD Report On FXLC Opened</a></li>
			<li><a href="javascript:void(0)" id="ytdReportFXLCOpenedClssfiedbyTop30">YTD Report On FXLC Opened Classified By Bank</a></li>
			<li><a href="javascript:void(0)" id="viewYtdTransactionCountImportExport">YTD Transaction Count (Import and Export)</a></li>
            <li><a href="javascript:void(0)" id="openTransactionAccountingEntries" class="enableTransactionAccountingEntries ">View Transaction Accounting Entries</a></li>
            <li><a href="javascript:void(0)" id="openAccountingEntries" class="enablePaymentAccountingEntries ">View Payment Accounting Entries</a></li>
		</ul>
    </div>
</div>

<g:if test="${documentType == 'DOMESTIC'}"> 
<%-- 
<div class="AccordionPanel">
    <div class="AccordionPanelTab" id="accordpanel_swift">DSLC Reports</div>

    <div class="AccordionPanelContent">
    	<h2 class="title_label adviseExportOpening">DSLC Bidding</h2>
    	<ul>
			<li><a href="javascript:void(0)" id="viewDslcBiddingSecurityA">Bidding Security A</a></li>
			<li><a href="javascript:void(0)" id="viewDslcBiddingSecurityB">Bidding Security B</a></li>
			<li><a href="javascript:void(0)" id="viewDslcBiddingSecurityC">Bidding Security C</a></li>
			<li><a href="javascript:void(0)" id="viewDslcBiddingSecurityD">Bidding Security D</a></li>
			<li><a href="javascript:void(0)" id="viewDslcBiddingSecurityE">Bidding Security E</a></li>
			<li><a href="javascript:void(0)" id="viewDslcBiddingSecurityF">Bidding Security F</a></li>
			<li><a href="javascript:void(0)" id="viewDslcBiddingSecurityG">Bidding Security G</a></li>
    		<li><a href="javascript:void(0)" id="viewBiddingSecurityH">Bidding Security H</a></li>
       	    <li><a href="javascript:void(0)" id="viewBiddingSecurityI">Bidding Security I</a></li>
       	    <li><a href="javascript:void(0)" id="viewBiddingSecurityJ">Bidding Security J</a></li>
       	    <li><a href="javascript:void(0)" id="viewBiddingSecurityK">Bidding Security K</a></li>
       	    <li><a href="javascript:void(0)" id="viewBiddingSecurityL">Bidding Security L</a></li>
       	    <li><a href="javascript:void(0)" id="viewBiddingSecurityM">Bidding Security M</a></li>
       	    <li><a href="javascript:void(0)" id="viewBiddingSecurityN">Bidding Security N</a></li>
    	</ul>
    	
    	<h2 class="title_label adviseExportOpening">DSLC Performance</h2>    
        <ul> 
        	<li><a href="javascript:void(0)"
                   onclick="window.open(advancePaymentUrl)">Advance Payment</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(advancePayment2Url)">Advance Payment 2</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(advancePayment3Url)">Advance Payment 3</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(faithfulPerformance2Url)">Faithful Performance 2</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(faithfulPerformanceAdvancePaymentUrl)">Faithful Performance Advance Payment</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(firstDataCorpFormatUrl)">Firse Data Corp Format</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(fp3Url)">FP3</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(fp4StandardFormatUrl)">FP4 Standard Format</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(fp5Url)">FP5</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(fp6Url)">FP6</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(fp7Url)">FP7</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(fpStandardFormat2Url)">FP Standard Format 2</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(othersUrl)">Others</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(others5Url)">Others 5</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(othersStandbyUrl)">Others Standby</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(othersStandby3CaltexUrl)">Others Standby 3 Caltex</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(paymentGuaranty2Url)">Payment Guaranty 2</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(paymentGuarrantyUrl)">Payment Guarranty</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(paymentGuarranty3Url)">Payment Guarranty 3</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(paymentGuarranty4Url)">Payment Guarranty 4</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(paymentGuarranty5Url)">Payment Guarranty 5</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(performanceBondUrl)">Performance Bond</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(performanceSecurity1Url)">Performance Security</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(performanceSecurity2Url)">Performance Security 2</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(ps2Url)">PS2</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(ps3Url)">PS3</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(ps4Url)">PS4</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(ps6Url)">PS6</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(ps7Url)">PS7</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(releaseRetentionUrl)">Release Retention</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(retention2_1Url)">Retention 2.1</a>
            </li>
        	<li><a href="javascript:void(0)"
                   onclick="window.open(retention2_2Url)">Retention 2.2</a>
            </li>          
            
            
        </ul>
    </div>
</div>
--%>
<div class="AccordionPanel">
    <div class="AccordionPanelTab" id="accordpanel_swift">DSLC Bidding</div>

    <div class="AccordionPanelContent">
        <ul>
%{--*BREN* -------------------------------------------------------------------}%
        	<li><a href="javascript:void(0)"
                   onclick="window.open(ps8Url)">PS 8</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(ps9Url)">PS 9</a>
            </li>
                 	<li><a href="javascript:void(0)"
                   onclick="window.open(ps10Url)">PS 10</a>
            </li>
            
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(retention3Url)">Retention 3</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(retention4Url)">Retention 4</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(retention5Url)">Retention 5</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(retention6Url)">Retention 6</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(retentionMoney3Url)">Retention Money 3</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(retentionUrl)">Retention</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(warrantyBond2Url)">Warranty Bond 2</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(warrantyBondUrl)">Warranty Bond </a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(suretyBond2Url)">Surety Bond 2</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(suretyBondUrl)">Surety Bond</a>
            </li>
                    	<li><a href="javascript:void(0)"
                   onclick="window.open(warrantySecurityUrl)">Warranty Security</a>
            </li>
        </ul>
    </div>
</div>
</g:if> %{--End of DSLC REPORTS--}%
</div> %{--End of ACCORDION--}%
</div> %{--End of Navigation--}%

<%-- For Accordion --%>
<g:render template="../commons/popups/accounting_entries_popup"/>
<g:render template="../commons/popups/authorized_signatory_popup"/>
<g:render template="../commons/popups/batch_processing_unit_code"/>
<g:render template="../commons/popups/batch_processing_unit_code2"/>
<g:if test="${!documentClass?.equalsIgnoreCase('CDT')}">
	<g:render template="../commons/popups/debit_memo_popup"/>
</g:if>
<g:render template="../commons/popups/digital_signatories"/>
<g:render template="../commons/popups/letter_of_transfer_popup"/>
<g:render template="../commons/popups/online_reports_popup"/>
<g:render template="../layouts/loading"/>

<g:render template="../commons/popups/create_export_advance_transaction_popup"/>
<g:render template="../commons/popups/create_export_bills_transaction_popup"/>

<g:render template="../commons/popups/loan_errors_popup"/>
<g:render template="../commons/popups/view_mt_popup"/>
