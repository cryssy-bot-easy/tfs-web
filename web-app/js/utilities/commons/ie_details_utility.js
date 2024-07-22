function checkToleranceLimits() {
	
	if(!$("#positiveToleranceLimit").val()=="" || !$("#positiveToleranceLimit").val()=="0.00"){
		
		$("#maximumCreditAmount").val("");
		$("#negativeToleranceLimit").val(formatCurrency($("#positiveToleranceLimit").val()));
	}else {
		$("#positiveToleranceLimit, #negativeToleranceLimit").val("");
		$("#maximumCreditAmount").val("NOT EXCEEDING");
	}
}

function checkToleranceLimits2() {
	
	if(!$("#positiveToleranceLimit").val()=="" || !$("#positiveToleranceLimit").val()=="0.00"){
		$("#maximumCreditAmount").val("");
	}else {
		$("#positiveToleranceLimit, #negativeToleranceLimit").val("");
		$("#maximumCreditAmount").val("NOT EXCEEDING");
	}
}

function checkMaximumCreditAmount(){
	if($("#positiveToleranceLimit").val()=="" || $("#positiveToleranceLimit").val()=="0.00"){
		$("#maximumCreditAmount").val("NOT EXCEEDING");
	}
}

$(document).ready(function(){
	checkToleranceLimits2();
	$("#positiveToleranceLimit").keyup(checkToleranceLimits);
	checkMaximumCreditAmount();
	
	$("input[type=radio][name=availableWithFlag]").change(function(){
	if($("input[type=radio][name=availableWithFlag]:checked").val() == "A") {
		$("#availableWith").addClass("required");
		$("#nameAndAddress").removeClass("required");
	} else {
		$("#availableWith").removeClass("required");
		$("#nameAndAddress").addClass("required");
	} 
	});
	if($("input[type=radio][name=availableWithFlag]:checked").val() == "A") {
		$("#availableWith").addClass("required");
		$("#nameAndAddress").removeClass("required");
	} else {
		$("#availableWith").removeClass("required");
		$("#nameAndAddress").addClass("required");
	}
});