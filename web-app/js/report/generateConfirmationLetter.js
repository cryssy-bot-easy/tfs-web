//@js/gsp
function generateConfirmationLetterReport(){
			
	var tmpConfirmationLetterUrl = confirmationLetterUrl;
	window.open(tmpConfirmationLetterUrl);

}

function init() {
	$('#viewConfirmationLetter').click(generateConfirmationLetterReport);
}


$(init);