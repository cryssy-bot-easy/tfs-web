$(function(){
	$("input[name=totalAmountClaimedFlag]").click(function(){
		switch($(this).val()){
		case "A":
			$("#totalAmountClaimedDate").removeAttr("readonly").enableDatepicker();
			$("#totalAmountClaimed").attr("readonly", "readonly");
			break;
		case "B":
			$("#totalAmountClaimedDate").attr("readonly", "readonly").datepicker("destroy");
			$("#totalAmountClaimed").removeAttr("readonly");
			break;
		}
	})
	$("input[name=correspondentBankFlag]").click(function(){
		switch($(this).val()){
		case "A":
			$("#correspondentBankSwiftCode").removeAttr("disabled");
			$("#correspondentBankLocation").attr("readonly","readonly");
			$("#correspondentBankNameAndAddress").attr("readonly","readonly");
			break;
		case "B":
			$("#correspondentBankSwiftCode").attr("disabled","disabled");
			$("#correspondentBankLocation").removeAttr("readonly");
			$("#correspondentBankNameAndAddress").attr("readonly","readonly");
			break;
		case "D":
			$("#correspondentBankSwiftCode").attr("disabled","disabled");
			$("#correspondentBankLocation").attr("readonly","readonly");
			$("#correspondentBankNameAndAddress").removeAttr("readonly");
			break;
		}
	})
	$("input[name=correspondentBankAccountNumberFlag]").click(function(){
		switch($(this).val()){
		case "A":
			$("#correspondentBankAccountNumberSwiftCode").removeAttr("disabled");
			$("#correspondentBankAccountNumberNameAndAddress").attr("readonly","readonly");
			break;
		case "D":
			$("#correspondentBankAccountNumberSwiftCode").attr("disabled","disabled");
			$("#correspondentBankAccountNumberNameAndAddress").removeAttr("readonly");
			break;
		}
	})
	$.fn.enableDatepicker = function (){
		$(this).datepicker({
			showOn: "both",
			buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp	  
			changeMonth: true,
			changeYear: true,
			constrainInput:true,
			defaultDate:null,
			dateFormat:"mm/dd/yy"
	  	}).attr("readonly","readonly");
	}
});