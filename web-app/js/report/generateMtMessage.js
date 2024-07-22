//@js/gsp
function generateMtMessageReport(){
	
	var tmpMtMessageUrl = mtMessageUrl;
	
	tmpMtMessageUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpMtMessageUrl += "&id=" + $("#id").val();

	window.open(tmpMtMessageUrl);
}

function init() {	
	$(".generateMtMessage").click(generateMtMessageReport);
}

$(init);