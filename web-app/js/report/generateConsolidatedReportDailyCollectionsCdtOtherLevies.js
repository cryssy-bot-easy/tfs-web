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
		Project Name: generateConsolidatedReportDailyCollectionsCdtOtherLevies.js
 */
function generateConsolidatedReportDailyCollectionsCdtOtherLevies(consolidatedReportType){
			
	var tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl = consolidatedReportDailyCollectionsCdtOtherLeviesUrl;

	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "?consolidatedReportType=" + consolidatedReportType;
	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&onlineReportDate=" + $("#onlineReportDate").val();
	
	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&collectionPeriodFrom=" + $("#collectionPeriodFrom").val();
	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&collectionPeriodTo=" + $("#collectionPeriodTo").val();
	 

	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&authFirst=" + $("#authorizedSignatory1").val();
	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&authFirstPos=" + $("#authorizedSignatory1Position").val();
	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&authSec=" + $("#authorizedSignatory2").val(); 
	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&authSecPos=" + $("#authorizedSignatory2Position").val();
	tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl += "&remDate=" + $("#remittanceDate").val();
	

	window.open(tmpConsolidatedReportDailyCollectionsCdtOtherLeviesUrl);
}

function init() {
//	$('#viewConsolidatedReportDailyCollectionsCdtOtherLevies').click(generateConsolidatedReportDailyCollectionsCdtOtherLevies);
}

$(init);