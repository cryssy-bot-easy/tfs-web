
//@js/gsp
function generateTransmittalLetterToClientReport(){
			
	var tmpTransmittalLetterToClientUrl = transmittalLetterToClientUrl;
	window.open(tmpTransmittalLetterToClientUrl);

}

function init() {
	$('#viewTransmittalLetterToClient').click(generateTransmittalLetterToClientReport);
}


$(init);