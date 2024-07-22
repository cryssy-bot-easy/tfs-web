function setupRemittanceInquiryCdt(){

	/*PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: remittance_inquiry_grid.js
	 *
	 */

	var remittanceInquiryCdtUrl = searchCdtRemittanceUrl;
	
	setupJqGridPager('grid_list_remittance', {
		width: 780, height: 385, loadui: "disable", scrollOffset:0, rowNum: 20},
					[['remittanceDate', 'Date of Remittance'],
					['reportType', 'Type of Report'],
					['amountRemitted', 'Amount Remitted'],
					['collectionPeriodFrom', 'PCHC Confirmation Date(From)'],
					['collectionPeriodTo', 'PCHC Confirmation Date(To)']], 'grid_pager_remittance', remittanceInquiryCdtUrl);
}

function initRemittanceInquiryCdt(){
	setupRemittanceInquiryCdt();
	
//	var mainGrids = $("#grid_list_remittance");
//
//	mainGrids.addRowData("1", {
//		remittanceDate:"August 23, 2012",
//		reportType:"Final CDT",
//		amountRemitted:'1,000.00',
//		collectionPeriodFrom:"08/16/2012",
//		collectionPeriodTo:"08/26/2012"});
	
}

$(initRemittanceInquiryCdt);

