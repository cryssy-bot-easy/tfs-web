$(document).ready(function(){
	$(".casa").hide();
	
});

function modeChange(){
	if($("#modeOfRefund").val().toLowerCase()=="credit casa"){
		showCASA();
	}
	else {
		hideCASA();
	}
}

function showCASA(){	
		$(".casa").show();
}

function hideCASA(){
		$(".casa").hide();
}