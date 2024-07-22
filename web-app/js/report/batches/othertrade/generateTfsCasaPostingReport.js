//@js/gsp
function generateOpenTFSCASAPosting(){
	var tmpTfsCasaPostingReportUrl = tfsCasaPostingReportUrl;
	
	tmpTfsCasaPostingReportUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpTfsCasaPostingReportUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	tmpTfsCasaPostingReportUrl += "&tellerID=" + $("#tellerID").val();
	window.open(tmpTfsCasaPostingReportUrl);

}
