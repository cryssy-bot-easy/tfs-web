function reverseOrCancelLc(){
	centerPopup("loading_div", "loading_bg");
	loadPopup("loading_div", "loading_bg");
	
	$.post(reverseOrCancelLcUrl,function(data){
		if('undefined' !== typeof data.errors && data.errors.length > 0){
			alert("Reverse or Cancel LC Execution: FAILED");
//			triggerAlertMessage("Execution <span style='color:red,font-weight:bold;'>FAILED</span>");
		}else{
			alert("Reverse or Cancel LC Execution: SUCCESS");
//			triggerAlertMessage("Execution <span style='color:green,font-weight:bold;'>SUCCESS</span>");
		}
	}).complete(function(){
		disablePopup("loading_div", "loading_bg");
	}).fail(function(){
		alert("Critical Error: function failed to return result.");
	});
}