//@js/gsp
function generateYtdCustomsDutiesAndTaxesAndOtherLevies(){
			
	var tmpYtdCustomsDutiesAndTaxesAndOtherLeviesUrl = ytdCustomsDutiesAndTaxesAndOtherLeviesUrl;
	window.open(tmpYtdCustomsDutiesAndTaxesAndOtherLeviesUrl);

}

function init() {
	$('#ytdCustomsDutiesAndTaxesAndOtherLevies').click(generateYtdCustomsDutiesAndTaxesAndOtherLevies);
}


$(init);