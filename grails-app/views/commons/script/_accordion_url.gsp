

<script type="text/javascript">

//  PROLOGUE:
// 	(revision)
//	SCR/ER Number: SCR# IBD-16-1206-01
//	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
//	[Created by:] Allan Comboy and Lymuel Saul
//	[Date Deployed:] 12/20/2016
//	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
//	PROJECT: WEB
//	MEMBER TYPE  : GSP
//	Project Name: _accordion_url

//  PROLOGUE:
// 	(revision)
//	SCR/ER Number: 
//	SCR/ER Description:
//	[Revised by:] John Patrick C. Bautista
//	[Date Revised:] 08/16/2017
//	Program [Revision] Details: Added create link variable to direct to inquiry controller.
//	PROJECT: WEB
//	MEMBER TYPE  : GSP
//	Project Name: _accordion_url

    var viewRefundOfOtherExportChargesInquiryUrl = '${g.createLink(controller: "inquiry", action: "viewRefundExportChargesInquiry")}';

    var viewOtherExportChargesInquiryUrl = '${g.createLink(controller: "inquiry", action: "viewOtherExportChargesInquiry")}';

    var importChargesOthersUrl = '${g.createLink(controller: "product", action: "gotoImportChargesOthers")}';
    var exportChargesOthersUrl = '${g.createLink(controller: "product", action: "gotoExportChargesOthers")}';

    var corresChargeActualUrl = '${g.createLink(controller: "product", action: "gotoCorresCharge")}';

    var exportAdvisingOpeningSecondUrl = '${g.createLink(controller: "product", action: "viewExportAdvisingOpeningSecond")}';
    var exportAdvisingOpeningFirstUrl = '${g.createLink(controller: "product", action: "viewExportAdvisingOpeningFirst")}';

    var gotoSearchExportAdvisingPaymentUrl = '${g.createLink(controller: "inquiry", action: "exportAdvisingPaymentInquiry")}';

    var gotoSearchExportAdvisingUrl = '${g.createLink(controller: "inquiry", action: "exportAdvisingInquiry")}';

    var gotoSearchExportBillsUrl = '${g.createLink(controller: "inquiry", action: "exportBillsInquiry")}';

	var importAdvanceUrl = '${g.createLink(controller: "product", action: "viewImportAdvancePayment")}';
	var importChargesUrl = '${g.createLink(controller: "product", action: "viewImportChargesPayment")}';
	
	var cdtRemittance = '${g.createLink(controller: "product", action: "viewCdtRemittance")}';

	var viewReportcdtRemit = '${g.createLink(controller: "product", action: "viewReportcdt")}';
	var cdtUploadTransactionUrl = '${g.createLink(controller:'product', action:'viewCdtUploadTransactions')}';
    var cdtUploadClientsUrl  = '${g.createLink(controller:'product', action:'viewCdtUploadClients')}';
    var cdtUploadPaymentHistoryUrl= '${g.createLink(controller:'product', action:'viewCdtUploadPaymentHistory')}';

    var refundProductServiceChargesUrl = '${g.createLink(controller:'product', action:'viewRefundProductServiceCharge')}';
	
	var outstandingInwardBillsForCollectionFxDaDpPerCurrurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingInwardBillsForCollectionFxDaDpPerCurrency")}';
	var outstandingInwardBillsForCollectionDmDaDpPerCurrurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingInwardBillsForCollectionDmDaDpPerCurrency")}';
	var fxNonLcsNegofortheYearurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxNonLcsNegoForTheYear")}';		
	var dmNonLcsNegofortheYearurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDmNonLcsNegoForTheYear")}';
	
	var exportNegofortheMonthperClienturl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runExportNegofortheMonthperClient")}';
	var exportNegoperCollectingBankurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runexportNegoperCollectingBank")}';
	var exportPaymentsfortheMonthperClienturl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runExportPaymentsfortheMonthperClient")}';
	
    var unactedTransactionsUrl = '${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
    var etsInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewEtsInquiry')}';
    var dataEntryInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewDataEntryInquiry')}';
    var lcInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewLcInquiry')}';
    var icInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewIcInquiry')}';
    var bgInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewBgInquiry')}';
    var negotiationInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewNegotiationInquiry')}';
    var nonLcInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewNonLcInquiry')}';
    var importAdvanceInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewImportAdvanceInquiry')}';
    var exportAdvanceInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewExportAdvanceInquiry')}';
    var actualCorresTransactionInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewActualCorresTransactionInquiry')}';
    var arMonitoringInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewArMonitoringInquiry')}';
    var apMonitoringInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewApMonitoringInquiry')}';
    var clientFileInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewClientFileInquiry')}';
    var cdtInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewCdtInquiry')}';
    var remittanceInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewRemittanceInquiry')}';
    var otherImportChargesInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewOtherImportChargesInquiry')}';
    var rebateInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewRebateInquiry')}';
    var refundCashLcChargesInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewRefundCashLcChargesInquiry')}';
    var mtMonitoringInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewMtMonitoringInquiry')}';
    var otherOutgoingMtUrl = '${g.createLink(controller:'outgoingMt', action:'goToOtherOutgoingMt')}';
    var mdCollectionInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewMdCollectionInquiry')}';
    var mdApplicationInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewMdApplicationInquiry')}';

    var setupApUrl = '${g.createLink(controller:'apDataEntrySetup', action:'viewSetupDataEntry')}';
    var apInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewApInquiry')}';

    var setupArUrl = '${g.createLink(controller:'arDataEntrySetup', action:'viewSetupDataEntry')}';
    var arInquiryUrl = '${g.createLink(controller:'inquiry', action:'viewArInquiry')}';

    var viewEtsAccordionUrl = '${g.createLink(controller: "unactedTransactions", action: "viewEts")}';
    var viewApprovedEtsChargesAndPaymentsAccordionUrl = '${g.createLink(controller: "unactedTransactions", action: "viewApprovedEtsChargesAndPayments")}';
    
    var viewDataEntryAccordionUrl = '${g.createLink(controller: "unactedTransactions", action: "viewDataEntry")}';
    var viewPaymentProcessingAccordionUrl = '${g.createLink(controller: "unactedTransactions", action: "viewPaymentProcessing")}';

    //SWIFT
    var mtMessagePageUrl = '${g.createLink(controller:'dataentryOutgoingMt', action:'viewOutgoingMt')}';

    var chargesSavedValidationUrl = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedCharges')}';

    //ISO - new tfs link
    var tfs2ApiUrl = '${grailsApplication.config.tfs.tfs2.api.url}';
    var tfs2ApiKey ='${grailsApplication.config.tfs.tfs2.api.key}';

    // EXPORTS
    // advising bank - opening - Data Entry 1st & 2nd
    var dataEntryAdvisingBankOpeningUrl = '${g.createLink(controller:'dataEntryAdvisingBankOpening',action: 'viewOpeningDataEntry')}';
    // advising bank - opening/amendment/cancellation
    var advisingBankInquiryUrl = '${g.createLink(controller:'inquiryAdvisingBank', action: 'viewAdvisingBankInquiry')}';
    // export advance
    %{--var exportAdvanceInquiryUrl = '${g.createLink(controller:'inquiryExportAdvance', action: 'viewExportAdvanceInquiry')}';--}%
    // refund & processing of other export charges
    var OtherOfExportChargesInquiryUrl = '${g.createLink(controller:'inquiryOtherExportCharges', action: 'viewOtherExportChargesInquiry')}';
    //export bills inquiry
    var exportBillsUrl = '${g.createLink(controller:'inquiryExportBills', action:'viewExportBillsInquiry')}';
    //other exports
    var etsExportAdvancePaymentUrl = '${g.createLink(controller:'etsExportAdvancePayment', action:'viewExportAdvancePaymentEts')}';

    //CDT
    //remittance
    var remittanceCdtUrl = '${g.createLink(controller:'remittanceCdt', action:'viewRemittanceCdt')}';
    //upload client file
    var uploadClientFileCdtUrl = '${g.createLink(controller:'uploadClientFile', action:'viewUploadClientFilesCdt')}';
    //upload transaction
    var uploadTransactionsCdtUrl = '${g.createLink(controller:'uploadTransaction', action:'viewUploadTransactionsCdt')}';
    //upload transaction
    var uploadPaymentHistoryCdtUrl = '${g.createLink(controller:'uploadPaymentHistory', action:'viewUploadPaymentHistoryCdt')}';

    var bankCertificationUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBankCertication")}';
    var billingStatementUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBillingStatement")}';
    var billingStatementForCashUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBillingStatementCash")}';
    var billingStatementForImportAdvanceUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBillingStatementImportAdvance")}';
    var billingStatementForMarginalDepositUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBillingStatementForMarginalDeposit")}';
    var billingStatementForNegoAmountUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBillingStatementNegoAmount")}';
    var billingStatementWithoutPaymentDetailsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBillingStatementWithoutPaymentDetails")}';
    var certificationUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runCertificationReport")}';
    var confirmationLetterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConfirmationLetter")}';
    var creditMemoUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runCreditMemoReport")}';
    var dailyCashFxlcsOpenedTreasuryReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyCashFXLCsOpenedTreasuryReport")}';
    var dailyFxlcsOpenedTreasuryReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyFXLCsOpenedTreasuryReport")}';
    var dailyOutstandingFxlcsTreasuryReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyOutstandingFXLCsTreasuryReport")}';
    var debitMemoUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDebitMemoReport")}';
    var discrepancyLetterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDiscrepancyLetter")}';
    var documentCheckListUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDocumentsCheckListReport")}';
    var exportNegotiationAdviceUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runExportNegotiationAdvice")}';
    var lcConfirmationOpeningUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runLcConfirmationRegularCashOpening")}';
    var lcConfirmationStandbyOpeningUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runLcConfirmationStandbyOpening")}';
    var lcConfirmationAmendmentUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runLcConfirmationRegularCashAmendment")}';
    var letterOfAdviseUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runLetterOfAdvise")}';
    var mtMessageUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runMtMessageReport")}';
    var outgoingMtUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutgoingMtReport")}';
    var paymentSummaryUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runPaymentSummaryReport")}';
    var paymentSummaryWithoutCashUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runPaymentSummaryReport")}';   
    var paymentSummaryOtherImportsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runPaymentSummaryReport")}';   
    var pddtsReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runPddts")}';
    var transmittalLetterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTransmittalLetterReport")}';
    var transmittalLetterToClientUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTransmittalLetter")}';
    var transmittalMessageToClientUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTransmittalMessageToClient")}';
    var transferLetterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runLetterOfTransfer")}';
    var OutstandingDomesticCashLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticCashLcPerImporter")}';
    var OutstandingDomesticCashLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticCashLcPerCurrency")}';
    var OutstandingDomesticStandbyLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticStandbyLcPerImporter")}';
    var OutstandingDomesticStandbyLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticStandbyLcPerCurrency")}';
    var OutstandingForeignCashLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignCashLcPerImporter")}';
    var OutstandingForeignCashLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignCashLcPerCurrency")}';
    var OutstandingForeignStandbyLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignStandbyLcPerImporter")}';
    var OutstandingForeignStandbyLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignStandbyLcPerCurrency")}';

    var QuarterlyReportOnForeignStandybyLcsOpenedUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runQuarterlyReportOnForeignStandybyLcsOpened")}';
    var YearEndReportOnForeignLcsOpenedPerCountryUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYearEndReportOnForeignLcsOpenedPerCountry")}';
    var YearEndReportOnForeignLcsOpenedPerConfirmingBankUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYearEndReportOnForeignLcsOpenedPerConfirmingBank")}';
    var YearEndReportOnForeignLcsOpenedPerAdvisingBankUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYearEndReportOnForeignLcsOpenedPerAdvisingBank")}';
    var dailyForeignRegularLcOpenedUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyForeignRegularLcOpened")}';
    var dailyForeignCashLcOpenedUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyForeignCashLcOpened")}';
    var dailyOutstandingForeignLcUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyOutstandingForeignLc")}';
    var dailyFundingUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyFunding")}';
    var dailyOutstandingLcsCCBDUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"dailyOutstandingCCBD")}';
    var outstandingForeignSightLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignSightLcPerImporter")}';
    var outstandingForeignSightLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignSightLcPerCurrency")}';
    var outstandingDomesticSightLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticSightLcPerImporter")}';
    var outstandingDomesticSightLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticSightLcPerCurrency")}';
    var outstandingForeignUsanceLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignUsanceLcPerImporter")}';
    var outstandingForeignUsanceLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingForeignUsanceLcPerCurrency")}';
    var outstandingDomesticUsanceLcPerImporterUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticUsanceLcPerImporter")}';
    var outstandingDomesticUsanceLcPerCurrencyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingDomesticUsanceLcPerCurrency")}';
	var outstandingInwardBillsforCollectionFXLCperCurrurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingInwardBillsforCollectionFXLCperCurrency")}';
	var outstandingInwardBillsforCollectionDMLCperCurrurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingInwardBillsforCollectionDMLCperCurrency")}';
    var outstandingExportNegotiationDomesticUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingExportNegotiationDomestic")}';
	var outstandingExportNegotiationForeignUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingExportNegotiationForeign")}';
	var dailySummaryOfAccountingEntriesUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailySummaryOfAccountingEntries")}';
	var fxLcOpendfordMnthUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runForeignLcOpenedForTheMonth")}';
    var dMLcOpenedfordMonthUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDomesticLcOpenedForTheMonth")}';
	var consolidated_Report_OnDmLcsOpened_for_dMonth_url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConsolidatedReportDomesticLcOpenedForMonth")}';
	var consolidated_Report_OnFXLcsOpened_for_dMonth_url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base , controller:"genericReports", action:"runConsolidatedReportOnForeignLcOpenedForMonth")}';
    var ytdReport_on_FXLCOpenedurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYtdReportOnForeignLcOpened")}';
    var ytdReport_on_DMLCOpenedurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYtdReportOnDomesticLcOpened")}';
    var ytdReport_on_FXLCOpenedClssfiedbyBankurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYtdReportOnForeignLcOpenedClassifiedByBank")}';
    var ytdReport_on_DMLCOpenedClssfiedbyBankurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYtdReportOnDomesticLcOpenedClassifiedByBank")}';
    var WeeklyReport_on_MaturingusanceLCurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runWeeklyReportOnMaturingUsancLc")}';
    var apOthersurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runApOthers")}';
    var arOthersurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runArOthers")}';
	var tfsMcoUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTfsMcoReport")}';
	%{--var tramsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTramsReport")}';--}%
	var amlaReportedTransactionsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTradeServicesAMLAReportedTransactions")}';
	var volumetricsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runVolumetrics")}';

    var tramsUrl = '${g.createLink(controller: "cdt", action: "generateTrams")}';
	var reverseOrCancelLcUrl = '${g.createLink(controller: "batch", action: "reverseOrCancelLc")}';
    
	var dailyFundingLcsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyFundingLcs", params: [etsNumber: documentNumber])}';
	var advancePaymentUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runAdvancePayment", params: [etsNumber: documentNumber])}';
	var advancePayment2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runAdvancePayment2", params: [etsNumber: documentNumber])}';
	var advancePayment3Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runAdvancePayment3", params: [etsNumber: documentNumber])}';
	var faithfulPerformance2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFaithfulPerformance2", params: [etsNumber: documentNumber])}';
	var faithfulPerformanceAdvancePaymentUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFaithfulPerformanceAdvancePayment", params: [etsNumber: documentNumber])}';
	var firstDataCorpFormatUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFirstDataCorpFormat", params: [etsNumber: documentNumber])}';
	var fp3Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFp3", params: [etsNumber: documentNumber])}';
	var fp4StandardFormatUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFp4StandardFormat", params: [etsNumber: documentNumber])}';
	var fp5Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFp5", params: [etsNumber: documentNumber])}';
	var fp6Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFp6", params: [etsNumber: documentNumber])}';
	var fp7Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFp7", params: [etsNumber: documentNumber])}';
	var fpStandardFormat2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runFpStandardFormat2", params: [etsNumber: documentNumber])}';
	var othersUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runOthers", params: [etsNumber: documentNumber])}';
	var others5Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runOthers5", params: [etsNumber: documentNumber])}';
	var othersStandbyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runOthersStandby", params: [etsNumber: documentNumber])}';
	var othersStandby3CaltexUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runOthersStandby3Caltex", params: [etsNumber: documentNumber])}';
	var paymentGuaranty2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPaymentGuaranty2", params: [etsNumber: documentNumber])}';
	var paymentGuarrantyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPaymentGuarranty", params: [etsNumber: documentNumber])}';
	var paymentGuarranty3Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPaymentGuarranty3", params: [etsNumber: documentNumber])}';
	var paymentGuarranty4Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPaymentGuarranty4", params: [etsNumber: documentNumber])}';
	var paymentGuarranty5Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPaymentGuarranty5", params: [etsNumber: documentNumber])}';
	var performanceBondUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPerformanceBond", params: [etsNumber: documentNumber])}';
	var performanceSecurity1Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPerformanceSecurity1", params: [etsNumber: documentNumber])}';
	var performanceSecurity2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPerformanceSecurity2", params: [etsNumber: documentNumber])}';
	var ps2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs2", params: [etsNumber: documentNumber])}';
	var ps3Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs3", params: [etsNumber: documentNumber])}';
	var ps4Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs4", params: [etsNumber: documentNumber])}';
	var ps6Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs6", params: [etsNumber: documentNumber])}';
	var ps7Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs7", params: [etsNumber: documentNumber])}';
	var releaseRetentionUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runReleaseRetention", params: [etsNumber: documentNumber])}';
	var retention2_1Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetention2_1", params: [etsNumber: documentNumber])}';
	var retention2_2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetention2_2", params: [etsNumber: documentNumber])}';

	//dslc bidding
	var dslcBiddingSecurityAUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runDslcBidding")}';
	var dslcBiddingSecurityBUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runDslcBidding")}';
	var dslcBiddingSecurityCUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runDslcBidding")}';
	var dslcBiddingSecurityDUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runDslcBidding")}';
	var dslcBiddingSecurityEUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runDslcBidding")}';
	var dslcBiddingSecurityFUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runDslcBidding")}';
	var dslcBiddingSecurityGUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runDslcBidding")}';

	var biddingSecurityH_URL = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runBiddingSecurity")}';
	var biddingSecurityI_URL = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runBiddingSecurity")}';
	var biddingSecurityJ_URL = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runBiddingSecurity")}';
	var biddingSecurityK_URL = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runBiddingSecurity")}';
	var biddingSecurityL_URL = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runBiddingSecurity")}';
	var biddingSecurityM_URL = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runBiddingSecurity")}';
	var biddingSecurityN_URL = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runBiddingSecurity")}';
	
	//bren
	var ps8Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs8")}';
	var ps9Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs9")}';
	var ps10Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runPs10")}';
	var retention3Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetention3")}';
	var retention4Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetention4")}';
	var retention5Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetention5")}';
	var retention6Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetention6")}';
	var retentionMoney3Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetentionMoney3")}';
	var retentionUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runRetention")}';
	var warrantyBond2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runWarrantyBond2")}';
	var warrantyBondUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runWarrantyBond")}';
	var suretyBond2Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runSuretyBond2")}';
	var suretyBondUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runSuretyBond")}';
	var warrantySecurityUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"dslcReports", action:"runWarrantySecurity")}';

	//batches other imports
	var dailyFxlcOpenedReportCdtDetailsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyFxlcOpenedReportCdtDetails")}';
	var dailyReportProcessedRefundsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyReportProcessedRefunds")}';
	var outstandingBankGuarantyUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingBankGuarantyReport")}';
	var outstandingMarginalDepositsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingMarginalDepositsReport")}';

	//batches other trade
	var monthlyTransactionCountUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runMonthlyTransactionCountReport")}';
	var ytdTransactionCountImportExportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYtdTransactionCountImportExportReport")}';
	var weeklyScheduleDocStampsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runWeeklyScheduleDocStamps")}';
	var listOfTransactionsWithNoCifNumberUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runListOfTransactionsWithNoCifNumber")}';
	var profitabilityMonitoringReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runProfitabilityMonitoringReport")}';
	var tfsCasaPostingReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTfsCasaPostingReport")}';
	var collectedTwoPercentCwtUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runCollectedTwoPercentCwt")}';
	var productAvailmentsReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runProductAvailmentsReport")}';
	var dwExceptionReportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDwExceptionReport")}';

	//cdt reports
	var batchDebitMemoUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runBatchDebitMemoReport")}';
	var consolidatedDailyReportDepositsCollectedUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConsolidatedDailyReportDepositsCollected")}';
	var consolidatedReportDailyCollectionsCdtOtherLeviesUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConsolidatedReportDaliyCollectionsCdtOtherLevies")}';
	var consolidatedReportDailyCollectionsImportProcessingFeesUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConsolidatedReportDailyCollectionsImportProcessingFees")}';
	var consolidatedReportDailyCollectionsExportDocumentaryStampFeesUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConsolidatedReportDailyCollectionsExportDocumentaryStampFees")}';
	var dailyReportProcessedCdtCollectionsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyReportProcessedCdtCollections")}';
	var consolidatedReportDailyCollectionsImportExportUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConsolidatedReportDailyCollectionsImportExport")}';
	var consolidatedReportDailyCollectionsFinalAdvanceUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runConsolidatedReportDailyCollectionsFinalAdvance")}';
	var customsDutiesAndTaxesAndOtherLeviesUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runCustomsDutiesAndTaxesAndOtherLevies")}';
	var ytdCustomsDutiesAndTaxesAndOtherLeviesUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runYtdCustomsDutiesAndTaxesAndOtherLevies")}';

	//spad
	var actualCorresChargesDataEntryUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runActualCorresChargesDataEntry")}';
	var adbBureauOfCustomsCollectionUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runAdbBureauOfCustomsCollection")}';
	var exportAdvanceUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runExportAdvance")}';
	var exportProceedsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runExportProceeds")}';
	var importAdvanceAndRefundUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runImportAdvanceAndRefund")}';
	var importedLettersOfCreditLcsOpenedUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runImportedLettersOfCreditLcsOpened")}';
	var importPaymentsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runImportPayments")}';
	var otherForeignExchangeAcquisitionsDispositionsUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOtherForeignExchangeAcquisitionsDispositions")}';
	var rebatesFromCorresBankDataEntryUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runRebatesFromCorresBankDataEntry")}';
	var scheduleOfMarginalDepositUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runScheduleOfMarginalDeposit")}';
	var tsdExportBankCommissionUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTsdExportBankCommission")}';
		
	//for debit memo, to pass the value of reference type
	var referenceType = '${referenceType}';

	var settleFlag = '${settleFlag}';
	var productStatus = '${productStatus}';
	var tsdInitiated = '${tsdInitiated}';
	var lcAmountFlag = '${lcAmountFlag}';
	var mt103Flag = '${mt103Flag}';
	var amendmentDate = '${amendmentDate}';
	var partialCashSettlementFlag = '${partialCashSettlementFlag}';
	var title = '${title}';
	var user = '${session?.userrole?.description}';
	var paymentStatus = '${paymentStatus}';
	var reinstateFlag = '${reinstateFlag}';
	var documentClass = '${documentClass}';
	var etsStatus = '${status}';
	
	//tenor = documentSubType2 in session.model
	var tenor = '${documentSubType2}';
	
	//for View Payment Accounting Entries
	%{--var accountingEntriesUrl = '${g.createLink(controller:'accountingEntry', action:'viewAccountingEntries')}';--}%
    var transactionAccountingEntriesUrl = '${g.createLink(controller:'accountingEntry', action:'viewTransactionAccountingEntries')}';
    var unactedTransactionTsdUrl = '${g.createLink(controller:'unactedTransactions', action:'viewUnactedTsd')}';
    var totalUnactedEntriesUrl = '${g.createLink(controller:'unactedTransactions', action:'getTotalUnactedEntries')}';
    var acc_userRole="${session['userrole']['id']}";
    var goToMtUrl = '${g.createLink(controller:'swift', action:'generateSwiftMessage')}';
    var checkMtUrl = '${g.createLink(controller:'swift', action:'checkSwiftMessage')}';
    var goToMt701Url = '${g.createLink(controller:'swift', action:'generateMt701')}';
    var rebateUrl = '${g.createLink(controller: "product", action: "gotoRebate")}';
    var validateAccountingUrl = '${g.createLink(controller:'accountingEntry', action:'validateAccountingEntry')}';
    var checkAccountingErrorUrl = '${g.createLink(controller:'accountingEntry', action:'checkErrorStackTrace')}';
    //fx form 1 txt files
	var fxForm1Schedule3Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxForm1Schedule3")}';
	var fxForm1Schedule4Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxForm1Schedule4")}';
	var fxForm1Schedule5Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxForm1Schedule5")}';
	var fxForm1Schedule7Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxForm1Schedule7")}';
	var fxForm1Schedule9Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxForm1Schedule9")}';
	var fxForm1Schedule10Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxForm1Schedule10")}';
	var fxForm1Schedule11Url = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxForm1Schedule11")}';
	var fxForm4CredexUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runCredexReport")}';
</script>