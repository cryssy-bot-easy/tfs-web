//@js/gsp
function generateTransmittalMessageToClientReport(){

	var tmpTransmittalMessageToClientUrl = transmittalMessageToClientUrl;
	window.open(tmpTransmittalMessageToClientUrl);

}

function init() {
	$('#viewTransmittalMessageToClient').click(generateTransmittalMessageToClientReport);
}


$(init);