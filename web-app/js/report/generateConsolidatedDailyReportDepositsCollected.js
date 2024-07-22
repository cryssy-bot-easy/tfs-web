//@js/gsp

 
/** PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: generateConsolidatedDailyReportDepositsCollected.js
 */
function generateConsolidatedDailyReportDepositsCollected(consolidatedReportType){
			
	var tmpConsolidatedDailyReportDepositsCollectedUrl = consolidatedDailyReportDepositsCollectedUrl;

	tmpConsolidatedDailyReportDepositsCollectedUrl += "?consolidatedReportType=" + consolidatedReportType;
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&onlineReportDate=" + $("#onlineReportDate").val();
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&collectionPeriodFrom=" + $("#collectionPeriodFrom").val();
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&collectionPeriodTo=" + $("#collectionPeriodTo").val();
		
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&authFirst=" + $("#authorizedSignatory1").val();
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&authFirstPos=" + $("#authorizedSignatory1Position").val();
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&authSec=" + $("#authorizedSignatory2").val(); 
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&authSecPos=" + $("#authorizedSignatory2Position").val();
	tmpConsolidatedDailyReportDepositsCollectedUrl += "&remDate=" + $("#remittanceDate").val();
	
	

	
	window.open(tmpConsolidatedDailyReportDepositsCollectedUrl);
}

function init() {
//	$('#viewConsolidatedDailyReportDepositsCollected').click(generateConsolidatedDailyReportDepositsCollected);
}

$(init);