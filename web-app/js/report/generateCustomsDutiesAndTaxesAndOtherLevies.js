//@js/gsp
function generateCustomsDutiesAndTaxesAndOtherLevies(){
			
	var tmpCustomsDutiesAndTaxesAndOtherLeviesUrl = customsDutiesAndTaxesAndOtherLeviesUrl;
	window.open(tmpCustomsDutiesAndTaxesAndOtherLeviesUrl);

}

function init() {
	$('#customsDutiesAndTaxesAndOtherLevies').click(generateCustomsDutiesAndTaxesAndOtherLevies);
}


$(init);