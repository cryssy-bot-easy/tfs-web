$(document).ready(function(){
	
	var refundPartial=$(".refundPartial *");
	var refundPartialText=$("#partialAmountForRefund");
	var refundOthers=$(".refundOthers *");
	var refundOthersSelect=$("#otherOption");
	
	$("input[name=refundOption]:radio").change(function(){
		
		switch($(this).val().toString()){
		case "refundPartialAmount":
				refundOthers.hide();
				refundOthersSelect.attr("disabled","true");
				refundPartial.show();
				refundPartialText.parent().addClass("editable");
				refundPartialText.removeAttr("readonly");
			break;
		case "refundOsAmount":
				refundPartial.hide();
				refundPartialText.parent().removeClass("editable");
				refundPartialText.attr("readonly","");
				refundOthers.hide();
				refundOthersSelect.attr("disabled","true");
			break;
		case "refundOthers":
				refundPartial.hide();
				refundPartialText.parent().removeClass("editable");
				refundPartialText.attr("readonly","");
				refundOthers.show();
				refundOthersSelect.removeAttr("disabled");
			break;
		}
	});
});