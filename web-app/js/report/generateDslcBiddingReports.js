//@js/gsp
function generateBiddingSecurityH_Report(){			
	var tempBiddingSecurityH_URL = biddingSecurityH_URL;	
	tempBiddingSecurityH_URL+="?reportID=H";
	//alert(tmpPaymentSummaryUrl);
	window.open(tempBiddingSecurityH_URL);
}

function generateBiddingSecurityI_Report(){			
	var tempBiddingSecurityI_URL = biddingSecurityI_URL;	
	tempBiddingSecurityI_URL+="?reportID=I";
	window.open(tempBiddingSecurityI_URL);
}

function generateBiddingSecurityJ_Report(){			
	var tempBiddingSecurityJ_URL = biddingSecurityJ_URL;	
	tempBiddingSecurityJ_URL+="?reportID=J";	
	window.open(tempBiddingSecurityJ_URL);
}
function generateBiddingSecurityK_Report(){			
	var tempBiddingSecurityK_URL = biddingSecurityK_URL;	
	tempBiddingSecurityK_URL+="?reportID=K";
	window.open(tempBiddingSecurityK_URL);
}
function generateBiddingSecurityL_Report(){			
	var tempBiddingSecurityL_URL = biddingSecurityL_URL;
	tempBiddingSecurityL_URL+="?reportID=L";
	window.open(tempBiddingSecurityL_URL);
}
function generateBiddingSecurityM_Report(){			
	var tempBiddingSecurityM_URL = biddingSecurityM_URL;	
	tempBiddingSecurityM_URL+="?reportID=M";
	window.open(tempBiddingSecurityM_URL);
}
function generateBiddingSecurityN_Report(){			
	var tempBiddingSecurityN_URL = biddingSecurityN_URL;	
	tempBiddingSecurityN_URL+="?reportID=N";
	window.open(tempBiddingSecurityN_URL);
}
function init() {
	$('#viewBiddingSecurityH').click(generateBiddingSecurityH_Report);	
	$('#viewBiddingSecurityI').click(generateBiddingSecurityI_Report);	
	$('#viewBiddingSecurityJ').click(generateBiddingSecurityJ_Report);	
	$('#viewBiddingSecurityK').click(generateBiddingSecurityK_Report);	
	$('#viewBiddingSecurityL').click(generateBiddingSecurityL_Report);	
	$('#viewBiddingSecurityM').click(generateBiddingSecurityM_Report);	
	$('#viewBiddingSecurityN').click(generateBiddingSecurityN_Report);	
}


$(init);