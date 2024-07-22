function displayCashTab(){
    var lcAmountFrom = parseFloat($("#amount").val());
    var lcAmountTo = parseFloat($("#amountTo").val());

    if($("input[name=lcAmountFlag]:checked").val() == 'INC'){
        $(".cash_lc_payment_tab").show();
    } else {
        $(".cash_lc_payment_tab").hide();
    }
}

function onChangeLcAmountFlag(){
    if($("input[name=lcAmountFlag]:checked").length != 0 && ($("input[name=lcAmountFlag]").attr("disabled") != "disabled")){
        $("#amountTo").removeAttr("disabled");
        if($("#type").val() == "CASH"){
            displayCashTab();
        }
    }
}

$(document).ready(function(){
	//$("#edit_cable_fee, #edit_supplies_fee, #edit_advising_fee").hide();
	//$("#settlementCurrency").val("PHP");
	$(".cash_lc_payment_tab").hide();
//	$(".lc_currency").val($("#currency").val());
//	$(".trans_currency").val($("#settlementCurrency").val());
	//$(".cable_fee, .supplies").hide();
//	$("#amountFrom").val($("#amount").val());
//	unloadDocumentaryStamp();
//	unloadCommitmentFee();
//	unloadConfirmingFee();
//	unloadAdvisingFee();
//	unloadBankCommission();
	//hidePopupFields();
    $("#bankCommissionPopup .expiry_change").hide();
	if($("#tenor").val() == "USANCE"){
		$("#tenorCheck").attr("disabled","disabled");
	}
	//	for testing purposes only
//	var expiryDate = new Date();
//	$("#expiryDateFrom, #expiryDate").val(function(){
//		if((expiryDate.getMonth() + 1).toString().length == 1){
//			return "0" + (expiryDate.getMonth() + 1) + "/" + expiryDate.getDate() + "/" + expiryDate.getFullYear()
//		} else return (expiryDate.getMonth() + 1) + "/" + expiryDate.getDate() + "/" + expiryDate.getFullYear()
//	});
	
	$("#lcAmountCheck").click(function(){
		if($("#lcAmountCheck").attr("checked") == "checked"){
			$("input[name=lcAmountFlag]").removeAttr("disabled");
			displayCashTab();
		} else {
			$("input[name=lcAmountFlag]:checked").removeAttr("checked");
			$("input[name=lcAmountFlag]").attr("disabled","disabled");
			$("#amountTo").attr("disabled","disabled");
			$(".cash_lc_payment_tab").hide();
		}
	});
	$("input[name=lcAmountFlag]").click(onChangeLcAmountFlag);
    onChangeLcAmountFlag();
	
	$("#expiryDateCheck").click(function(){
		if($("#expiryDateCheck").attr("checked") == "checked"){
			$("input[name=expiryDateFlag]").removeAttr("disabled");
		} else {
			$("input[name=expiryDateFlag]:checked").removeAttr("checked");
			$("input[name=expiryDateFlag]").attr("disabled","disabled");
			$("#expiryDateTo").attr("disabled","disabled").removeClass("datepicker_field").datepicker("destroy");	//reverts the field to an ordinary input field
		}
	});
	$("input[name=expiryDateFlag]").click(function(){
		if($("input[name=expiryDateFlag]:checked").length != 0){
			$("#expiryDateTo").removeAttr("disabled").datepicker("destroy");
			expiryDatePicker();
			setNumberOfDays();
		}
	});
	$("#expiryDateTo").change(setNumberOfDays);
	$("#tenorCheck").click(function(){
		if($("#tenorCheck").attr("checked") == "checked"){
            alert("c1")
			$("#tenorTo, #tenorOfDraft").removeAttr("disabled");
			$("#tenorTo").val("USANCE");
		} else {
            alert("c2")
			$("#tenorTo, #tenorOfDraft").val("");
			$("#tenorTo, #tenorOfDraft").attr("disabled", "disabled");
		}
	});
	$("#changeInConfirmationCheck").click(function(){
		if($("#changeInConfirmationCheck").attr("checked") == "checked"){
			$("#confirmationInstructionsFlagTo").removeAttr("disabled");
		} else {
			$("#confirmationInstructionsFlagTo").attr("disabled", "disabled");
		}
	});
	$("#narrativeCheck").click(function(){
		if($("#narrativeCheck").attr("checked") == "checked"){
			$("#narrative.textarea_long").removeAttr("readonly");
		} else {
			$("#narrative.textarea_long").attr("readonly", "readonly");
		}
	});
	
	$("input[type=checkbox], input[type=radio]").click(function(){
		loadBankCommission();
		loadCommitmentFee();
		if($("#lcAmountCheck").attr("checked") == "checked"){
			if($("input[name=lcAmountFlag]:checked").length != 0){
				loadCableFee();
				if($("input[name=lcAmountFlag]:checked").val() == 'INC'){
					$(".documentary_stamp").show();
				} else unloadDocumentaryStamp();
			} else if($("input[name=expiryDateFlag]:checked").length == 0){
				$(".cable_fee, .supplies").hide();
			}
		} else unloadDocumentaryStamp();
		if($("#expiryDateCheck").attr("checked") == "checked"){
			if($("input[name=expiryDateFlag]:checked").length != 0){
				loadCableFee();
			} else if($("input[name=lcAmountFlag]:checked").length == 0){
				$(".cable_fee, .supplies").hide();
			}
		}
		if($("#tenorCheck").attr("checked") == "checked" || $("#changeInConfirmationCheck").attr("checked") == "checked" || $("#narrativeCheck").attr("checked") == "checked"){
			loadCableFee();
		}
		if($("input[type=checkbox]:checked").length == 0){
			$(".cable_fee, .supplies").hide();
		}
		if ($("input[name=advanceCorresChargesFlag]:checked").val() == 'Y') {
			if($("#changeInConfirmationCheck:checked").length != 0 || ($("#lcAmountCheck:checked").length != 0 && $("input[name=lcAmountFlag]:checked").val() == 'INC') || ($("#tenorCheck:checked").length != 0 && ($("#expiryDateCheck:checked").length != 0 && $("input[name=expiryDateFlag]:checked").val() == 'EXT'))){
				loadConfirmingFee();
				loadAdvisingFee();
			} else if ($("#tenorCheck:checked").length != 0  && !($("#expiryDateCheck:checked").length != 0 && $("input[name=expiryDateFlag]:checked").val() == 'EXT')) {
				unloadConfirmingFee();
				loadAdvisingFee();
			} else if ($("#tenorCheck:checked").length == 0  && ($("#expiryDateCheck:checked").length != 0 && $("input[name=expiryDateFlag]:checked").val() == 'EXT')) {
				unloadAdvisingFee();
				loadConfirmingFee();
			} else {
				unloadConfirmingFee();
				unloadAdvisingFee();
			}
		} else if ($("input[name=advanceCorresChargesFlag]:checked").val() == 'N') {
			unloadConfirmingFee();
			unloadAdvisingFee();
		}
	});
	
	$("#changeInConfirmationTo").change(loadConfirmingFee);
	$("#changeInConfirmationCheck").click(loadConfirmingFee);
	
	function unloadDocumentaryStamp(){
		$(".documentary_stamp").hide();
	}

	function loadBankCommission(){
		if($("input[type=checkbox]:checked").length != 0){
			if(($("#lcAmountCheck").attr("checked") == "checked" && $("input[name=lcAmountFlag]:checked").val() == 'INC') || ($("#expiryDateCheck").attr("checked") == "checked" && $("input[name=expiryDateFlag]:checked").val() == 'EXT')){
				$(".bank_commission").show();
				if($("input[name=lcAmountFlag]:checked").val() == 'INC' && $("input[name=expiryDateFlag]:checked").val() != 'EXT'){
					$("#bankCommissionPopup .lc_increase").show();
					$("#bankCommissionPopup .expiry_change").hide();
					$("#bankCommissionPopup").toggleClass("amendment", false);
				} else {
					if($("input[name=lcAmountFlag]:checked").val() != 'INC' && $("input[name=expiryDateFlag]:checked").val() == 'EXT'){
						$("#bankCommissionPopup .expiry_change").show();
						$("#bankCommissionPopup .lc_increase").hide();
						$("#bankCommissionPopup").toggleClass("amendment", false);
					} else if($("input[name=lcAmountFlag]:checked").val() == 'INC' && $("input[name=expiryDateFlag]:checked").val() == 'EXT'){
						$("#bankCommissionPopup .lc_increase.expiry_change, #bankCommissionPopup .expiry_change, #bankCommissionPopup .lc_increase").show();
						$("#bankCommissionPopup").toggleClass("amendment", true);
					}
				}
				//$("#edit_bank_commission").show();
			} else if($("#tenorCheck").attr("checked") == "checked" || $("#changeInConfirmationCheck").attr("checked") == "checked" || $("#narrativeCheck").attr("checked") == "checked" || ($("#lcAmountCheck").attr("checked") == "checked" && $("input[name=lcAmountFlag]:checked").val() == 'DEC') || ($("#expiryDateCheck").attr("checked") == "checked" && $("input[name=expiryDateFlag]:checked").val() == 'RED')){
				$(".bank_commission").show();
				//$("#edit_bank_commission").hide();
			} else {
				unloadBankCommission();
			}
		} else {
			unloadBankCommission();
		}
	}
	
	function unloadBankCommission(){
		$(".bank_commission").hide();
	}
	
	function loadCommitmentFee(){
		if($("#type").val() == "REGULAR"){
			if($("#tenor").val() == "SIGHT" && $("#tenorCheck:checked").length != 0){
				openCommitmentFee();
				if($("input[name=lcAmountFlag]:checked").val() == 'INC'){
					$("#commitmentFeePopup .lc_increase").show();
				} else {
					$("#commitmentFeePopup .lc_increase").hide();
				}
//				$("#edit_commitment_fee").show();
			} else if($("#tenor").val() == "SIGHT" && $("#tenorCheck:checked").length == 0){
				unloadCommitmentFee();
			} else if($("#tenor").val() == "USANCE" && $("input[name=lcAmountFlag]:checked").val() == 'INC'){
				$("#commitmentFeePopup .lc_increase").show();
				openCommitmentFee();
//				$("#edit_commitment_fee").show();
//			} else if($("#tenorFrom").val() == "USANCE" && $("input[name=lcAmountFlag]:checked").val() == 'DEC'){
//				openCommitmentFee();
//				$("#edit_commitment_fee").hide();
			} else {
				unloadCommitmentFee();
			}
		} else if ($("#type").val() == "STANDBY"){
			openCommitmentFee();
			if($("input[name=expiryDateFlag]:checked").val() == 'EXT' || $("input[name=lcAmountFlag]:checked").val() == 'INC'){
//				$("#edit_commitment_fee").show();
				if($("input[name=expiryDateFlag]:checked").val() == 'EXT' && $("input[name=lcAmountFlag]:checked").val() != 'INC'){
					$("#commitmentFeePopup .expiry_change").show();
					$("#commitmentFeePopup .lc_increase").hide();
					$("#commitmentFeePopup").toggleClass("amendment", false);
				} else if($("input[name=expiryDateFlag]:checked").val() != 'EXT' && $("input[name=lcAmountFlag]:checked").val() == 'INC'){
					$("#commitmentFeePopup .lc_increase").show();
					$("#commitmentFeePopup .expiry_change").hide();
					$("#commitmentFeePopup").toggleClass("amendment", false);
				} else if($("input[name=expiryDateFlag]:checked").val() == 'EXT' && $("input[name=lcAmountFlag]:checked").val() == 'INC'){
					$("#commitmentFeePopup .lc_increase.expiry_change, #commitmentFeePopup .expiry_change, #commitmentFeePopup .lc_increase").show();
					$("#commitmentFeePopup").toggleClass("amendment", true);
				}
//			} else if($("input[name=expiryDateFlag]:checked").val() == 'RED' || $("input[name=lcAmountFlag]:checked").val() == 'DEC'){
//				$("#edit_commitment_fee").hide();
			} else unloadCommitmentFee();
		}
	}
	
	function openCommitmentFee(){
		$(".commitment_fee").show();
	}
	
	function unloadCommitmentFee(){
		$(".commitment_fee").hide();
	}
	
	function loadConfirmingFee(){
		if(($("#changeInConfirmationCheck:checked").length != 0) && ($("#changeInConfirmationTo").val() == "YES") && ($("input[name=advanceCorresChargesFlag]:checked").val() == 'Y')){
			$(".confirming_fee").show();
			if($("input[name=lcAmountFlag]:checked").val() == 'INC' && $("input[name=expiryDateFlag]:checked").length == 0){
				$("#confirmingFeePopup .lc_increase").show();
				$("#confirmingFeePopup .expiry_change").hide();
				$("#confirmingFeePopup").toggleClass("amendment", true);
			} else {
				if($("input[name=lcAmountFlag]:checked").val() == 'INC' && $("input[name=expiryDateFlag]:checked").length != 0){
					confirmCheckExpiry();
					$("#confirmingFeePopup .lc_increase.expiry_change, #confirmingFeePopup .lc_increase").show();
					$("#confirmingFeePopup").toggleClass("amendment", true);
				} else if($("input[name=lcAmountFlag]:checked").val() != 'INC'){
					confirmCheckExpiry();
					$("#confirmingFeePopup .lc_increase").hide();
					$("#confirmingFeePopup").toggleClass("amendment", false);
				}
			}
		}
	}
	
	function unloadConfirmingFee(){
		$(".confirming_fee").hide();
	}
	
	function confirmCheckExpiry(){
		if($("input[name=expiryDateFlag]:checked").length != 0){
			$("#confirmingFeePopup .expiry_change").show();
			if($("input[name=expiryDateFlag]:checked").val() == 'EXT'){
				$("span.confirm_amend").text("Extended ");
			} else if ($("input[name=expiryDateFlag]:checked").val() == 'RED'){
				$("span.confirm_amend").text("Reduced ");
			}
		} else {
			$("#confirmingFeePopup .expiry_change").hide();
		}
	}
	
	function loadAdvisingFee(){
		$(".advising_fee").show();
	}
	
	function unloadAdvisingFee(){
		$(".advising_fee").hide();
	}

	function loadCableFee(){
		if($("input[type=checkbox]:checked").length != 0){
			$(".cable_fee, .supplies").show();
		}
	}
	
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
		if($("input[name=expiryDateFlag]:checked").val() == 'EXT'){
			$("#expiryDateTo").datepicker("option", "minDate", $("#expiryDate").val());
		} else if($("input[name=expiryDateFlag]:checked").val() == 'RED'){
			$("#expiryDateTo").datepicker("option", "maxDate", $("#expiryDate").val());
			$("#expiryDateTo").datepicker("option", "minDate", $("#lcAmendmentDate").val());
		}
	}
	
	function setNumberOfDays(){
		var oldExpiry = new Date($("#originalExpiryDate").val());
		var newExpiry = new Date($("#expiryDateTo").val())!=null?new Date($("#expiryDateTo").val()):'';

		if($("input[name=expiryDateFlag]:checked").val() == 'EXT' || $("input[name=expiryDateFlag]:checked").val() == 'RED'){
			$("#expiryDateModifiedDays").val(parseInt(Math.abs((newExpiry-oldExpiry)/(1000*60*60*24)) || 0)); 
		}
	}
	$("#lcAmendmentDate").change(function(){
		if($("input[name=expiryDateFlag]:checked").val() == 'RED'){
			$("#expiryDateTo").datepicker("option", "minDate", $("#lcAmendmentDate").val());
		}
	});
	$("#settlementCurrency").change(function(){
		$(".trans_currency").val($(this).val());
	});
	
	$("#settlementCurrencyCashFxlc").change(function(){
		$(".cash_currency").val($(this).val());
	});
	
	function hidePopupFields() {
		$(".expiry_change, .lc_increase").hide();
	}

    $("#expiryDateModifiedDays").val("");
	
});