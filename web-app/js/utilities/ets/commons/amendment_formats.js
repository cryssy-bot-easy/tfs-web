$(document).ready(function(){
	$("#settlementCurrency").val("PHP");
	$(".display_cash_payment").hide();
	$(".lc_currency").val($("#currency").val());
	$(".trans_currency").val($("#settlementCurrency").val());
	$(".cable").hide();
	$("#lcAmountFrom").val($("#amount").val());
	
	var expiryDate = new Date();
	$("#expiryDateFrom, #expiryDate, #lcAmendmentDate").val(function(){
		if((expiryDate.getMonth() + 1).toString().length == 1){
			return "0" + (expiryDate.getMonth() + 1) + "/" + expiryDate.getDate() + "/" + expiryDate.getFullYear()
		} else return (expiryDate.getMonth() + 1) + "/" + expiryDate.getDate() + "/" + expiryDate.getFullYear()
	});

    // TODO remove on click, validation is upon saving
	$("#lcAmountCheck").click(function(){
		if($("#lcAmountCheck").attr("checked") == "checked"){
			$("input[name=lcAmountFlag]").removeAttr("disabled");
			displayCashTab();
		} else {
			$("input[name=lcAmountFlag]:checked").removeAttr("checked");
			$("input[name=lcAmountFlag]").attr("disabled","disabled");
			$("#lcAmountTo").attr("readonly","readonly");
			$(".display_cash_payment").hide();
		}
	});
	$("input[name=lcAmountFlag]").click(function(){
		if($("input[name=lcAmountFlag]:checked").length != 0){
			$("#lcAmountTo").removeAttr("readonly");
			if($("#type").val() == "CASH"){
				displayCashTab();
			}
		}
	});
	
	$("#expiryDateCheck").click(function(){
		if($("#expiryDateCheck").attr("checked") == "checked"){
			$("input[name=expiryDateFlag]").removeAttr("disabled");
		} else {
			$("input[name=expiryDateFlag]:checked").removeAttr("checked");
			$("input[name=expiryDateFlag]").attr("disabled","disabled");
			$("#expiryDateTo").attr("readonly","readonly").removeClass("datepicker_field").datepicker("destroy");	//reverts the field to an ordinary input field
		}
	});
	$("input[name=expiryDateFlag]").click(function(){
		if($("input[name=expiryDateFlag]:checked").length != 0){
			$("#expiryDateTo").removeAttr("readonly").datepicker("destroy");
			expiryDatePicker();
			setNumberOfDays();
		}
	});
	$("#expiryDateTo").change(setNumberOfDays);
	$("#tenorCheck").click(function(){
		if($("#tenorCheck").attr("checked") == "checked"){
			$("#tenorTo, #tenorOfDraft").removeAttr("readonly");
		} else {
			$("#tenorTo, #tenorOfDraft").attr("readonly", "readonly");
		}
	});
	$("#changeInConfirmationCheck").click(function(){
		if($("#changeInConfirmationCheck").attr("checked") == "checked"){
			$("#changeInConfirmationTo").removeAttr("disabled");
		} else {
			$("#changeInConfirmationTo").attr("disabled", "disabled");
		}
	});
//	$("#narrativeCheck").click(function(){
//		if($("#narrativeCheck").attr("checked") == "checked"){
//			$("#narrative.textarea_long").removeAttr("readonly");
//		} else {
//			$("#narrative.textarea_long").attr("readonly", "readonly");
//		}
//	});
	
	function expiryDatePicker(){
		$("#expiryDateTo").datepicker({
			showOn: 'both',
			buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp	  
			changeMonth: true,
			changeYear: true,
			constrainInput:true,
			defaultDate:null,
			dateFormat:'mm/dd/yy'
	  	}).attr("readonly","readonly");
		if($("input[name=expiryDateFlag]:checked").val() == 'E'){
			$("#expiryDateTo").datepicker("option", "minDate", $("#expiryDateFrom").val());
		} else if($("input[name=expiryDateFlag]:checked").val() == 'R'){
			$("#expiryDateTo").datepicker("option", "maxDate", $("#expiryDateFrom").val());
			$("#expiryDateTo").datepicker("option", "minDate", $("#lcAmendmentDate").val());
		}
	}
	
	function displayCashTab(){
		var lcAmountFrom = parseFloat($("#lcAmountFrom").val());
		var lcAmountTo = parseFloat($("#lcAmountTo").val());
		
		if($("input[name=lcAmountFlag]:checked").val() == 'I'){
			$(".display_cash_payment").show();
		} else {
			$(".display_cash_payment").hide();
		}
	}
	
	function setNumberOfDays(){
		var oldExpiry = new Date($("#expiryDateFrom").val());
		var newExpiry = new Date($("#expiryDateTo").val())!=null?new Date($("#expiryDateTo").val()):'';
		
		if($("input[name=expiryDateFlag]:checked").val() == 'E' || $("input[name=expiryDateFlag]:checked").val() == 'R'){
			$("#expiryDateModifiedDays").val(parseInt(Math.abs((newExpiry-oldExpiry)/(1000*60*60*24)) || 0)); 
		}
	}
	$("#settlementCurrency").change(function(){
		$(".trans_currency").val($(this).val());
	});
	
	$("#settlementCurrencyCashFxlc").change(function(){
		$(".cash_currency").val($(this).val());
	});
	
});