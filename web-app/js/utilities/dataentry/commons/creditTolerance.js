$(initializeCreditToleranceFields);

function initializeCreditToleranceFields() {
	$("#maximumCreditAmount").val("NOT EXCEEDING")
	$("#positiveToleranceLimit").change(onPositiveToleranceLimitChange).blur(onPositiveToleranceLimitChange);
	$("#positiveToleranceLimit, #negativeToleranceLimit").autoNumeric({mDec:2})
}

function onPositiveToleranceLimitChange() {
	$("#negativeToleranceLimit").val($("#positiveToleranceLimit").val());
	if ($("#positiveToleranceLimit").val().length > 0){
		$("#maximumCreditAmount").val("")
	} else {
		$("#maximumCreditAmount").val("NOT EXCEEDING")
	}
}