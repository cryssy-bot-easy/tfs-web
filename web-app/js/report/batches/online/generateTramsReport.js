//@js/gsp
function generateTramsReport(){
			
	var tmpTramsUrl = tramsUrl;
	
	tmpTramsUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	
	window.open(tmpTramsUrl);
}

function init() {
	$('#generateTramsReport').click(generateTramsReport);
}

$(init);