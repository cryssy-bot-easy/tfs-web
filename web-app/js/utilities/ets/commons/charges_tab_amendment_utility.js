/**
 * Charges Computation
 * Created by: Arvin Patrick R. Guiam
 * server-side computation of charges.
 */
$(function(){
	setDefaults();
	checkRate();
	$("input[type=checkbox], input[type=radio]").click(function(){
		setBankCommission();
		setCommitmentFee();
		if($("#lcAmountCheck").attr("checked") == "checked"){
			if($("input[name=lcAmountFlag]:checked").length != 0){
				setCableFee();
			} else if($("input[name=expiryDateFlag]:checked").length == 0){
				$("#cableFee").val(0);
			}
		}
		if($("#expiryDateCheck").attr("checked") == "checked"){
			if($("input[name=expiryDateFlag]:checked").length != 0){
				setCableFee();
			} else if($("input[name=lcAmountFlag]:checked").length == 0){
				$("#cableFee").val(0);
			}
		}
		if($("#tenorCheck").attr("checked") == "checked" || $("#changeInConfirmationCheck").attr("checked") == "checked" || $("#narrativeCheck").attr("checked") == "checked"){
			setCableFee();
		}
		if($("input[type=checkbox]:checked").length == 0){
			$("#cableFee").val(0);
		}
		if ($("input[name=advanceCorresChargesFlag]:checked").val() == 'TRUE') {
			if($("#changeInConfirmationCheck:checked").length != 0 || ($("#lcAmountCheck:checked").length != 0 && $("input[name=lcAmountFlag]:checked").val() == 'I') || ($("#tenorCheck:checked").length != 0 && ($("#expiryDateCheck:checked").length != 0 && $("input[name=expiryDateFlag]:checked").val() == 'E'))){
				setConfirmingFee();
				setAdvisingFee();
			} else if ($("#tenorCheck:checked").length != 0  && !($("#expiryDateCheck:checked").length != 0 && $("input[name=expiryDateFlag]:checked").val() == 'E')) {
				setAdvisingFee();
			} else if ($("#tenorCheck:checked").length == 0  && ($("#expiryDateCheck:checked").length != 0 && $("input[name=expiryDateFlag]:checked").val() == 'E')) {
				setConfirmingFee();
			}
		} else if ($("input[name=advanceCorresChargesFlag]:checked").val() == 'N') {
			setAdvisingFee();
		}
		computeTotalCharges();
	});
	
	$("#settlementCurrency").change(function(){
		checkRate();
		resetChargesVariables();
	});
	
	$("#changeInConfirmationTo").change(setConfirmingFee);
	$("#changeInConfirmationCheck").click(setConfirmingFee);
	
	$("input[name=advanceCorresChargesFlag]").click(setMonth);
	$("#lcAmendmentDate").change(setMonth);
	$("#expiryDateTo").change(setMonth);
	$("input[name=expiryDateFlag]").click(setMonth);
	$("input[name=lcAmountFlag]").click(setMonth);
	$("#tenorOfDraft").change(setMonth);
	
	$("#lcAmountTo").change(function(){
		if($("input[name=lcAmountFlag]:checked").val() == 'I'){
			var os_lc_amount = parseCharges($("#lcAmountFrom").val().replace(/[^0-9\.]+/g,""));
			lc_amount_increase = parseCharges($("#lcAmountTo").val().replace(/[^0-9\.]+/g,""));
			
			if (lc_amount_increase > os_lc_amount){
				$("#documentaryStampLCAmountPopup, #bankCommissionLCAmountPopup, #confirmingFeeLCAmount2Popup").val((lc_amount_increase - os_lc_amount).toFixed(2));
				$("#commitmentFeeLCAmountPopup").val(function(){
					if($("#type").val() == 'REGULAR'){
						if($("#tenorFrom").val() == "SIGHT") return (lc_amount_increase).toFixed(2);
						else if ($("#tenorFrom").val() == "USANCE") return (lc_amount_increase - os_lc_amount).toFixed(2)
					} else if($("#type").val() == 'STANDBY') return (lc_amount_increase - os_lc_amount).toFixed(2)
				});
				resetChargesVariables();
			} else {
				alert("New LC Amount value is not valid!");
				$("#lcAmountTo").val("");
			}
		}
	})

	var bank_compute;
	function setBankCommission(){
		if($("input[type=checkbox]:checked").length != 0){
			if(($("#lcAmountCheck").attr("checked") == "checked" && $("input[name=lcAmountFlag]:checked").val() == 'I') || ($("#expiryDateCheck").attr("checked") == "checked" && $("input[name=expiryDateFlag]:checked").val() == 'E')){
				if($("input[name=lcAmountFlag]:checked").val() == 'I' && $("input[name=expiryDateFlag]:checked").val() != 'E'){
					bank_compute = 1;
				} else {
					$("#bankCommissionLCAmount2Popup").val(parseCharges($("#lcAmountFrom").val().replace(/[^0-9.]+/g,"")).toFixed(2));
					if($("input[name=lcAmountFlag]:checked").val() != 'I' && $("input[name=expiryDateFlag]:checked").val() == 'E'){
						bank_compute = 2;
					} else if($("input[name=lcAmountFlag]:checked").val() == 'I' && $("input[name=expiryDateFlag]:checked").val() == 'E'){
						bank_compute = 0;
					}
				}
				computeBankCommission();
				saveBankCommission();
			} else if($("#tenorCheck").attr("checked") == "checked" || $("#changeInConfirmationCheck").attr("checked") == "checked" || $("#narrativeCheck").attr("checked") == "checked" || ($("#lcAmountCheck").attr("checked") == "checked" && $("input[name=lcAmountFlag]:checked").val() == 'D') || ($("#expiryDateCheck").attr("checked") == "checked" && $("input[name=expiryDateFlag]:checked").val() == 'R')){
				$("#bankCommission").val((500 * php_to).toFixed(2));
				computeTotalCharges();
			} else {
				$("#bankCommission").val(0);
				computeTotalCharges();
			}
		} else {
			$("#bankCommission").val(0);
			computeTotalCharges();
		}
	}
	
	var commitment_compute;
	function setCommitmentFee(){
		if($("#type").val() == "REGULAR"){
			if($("#tenorFrom").val() == "SIGHT" && $("#tenorCheck:checked").length != 0){
				if($("input[name=lcAmountFlag]:checked").val() == 'I'){
					$("#commitmentFeeLCAmountPopup").val(parseCharges($("#lcAmountTo").val().replace(/[^0-9\.]+/g,"")).toFixed(2));
				} else {
					$("#commitmentFeeLCAmountPopup").val(parseCharges($("#lcAmountFrom").val().replace(/[^0-9\.]+/g,"")).toFixed(2));
				}
				commitment_compute = 1;
				computeCommitmentFee();
				saveCommitmentFee();
			} else if($("#tenorFrom").val() == "SIGHT" && $("#tenorCheck:checked").length == 0){
				$("#commitmentFee").val(0);
				computeTotalCharges();
			} else if($("#tenorFrom").val() == "USANCE" && $("input[name=lcAmountFlag]:checked").val() == 'I'){
				commitment_compute = 1;
				computeCommitmentFee();
				saveCommitmentFee();
//			} else if($("#tenorFrom").val() == "USANCE" && $("input[name=lcAmountFlag]:checked").val() == 'D'){
//				$("#commitmentFee").val((500 * php_to).toFixed(2));
//				computeTotalCharges();
			} else {
				$("#commitmentFee").val(0);
				computeTotalCharges();
			}
		} else if ($("#type").val() == "STANDBY"){
			if($("input[name=expiryDateFlag]:checked").val() == 'E' || $("input[name=lcAmountFlag]:checked").val() == 'I'){
				if($("input[name=expiryDateFlag]:checked").val() != 'E' && $("input[name=lcAmountFlag]:checked").val() == 'I'){
					commitment_compute = 1;
				} else{ 
					$("#commitmentFeeLCAmount2Popup").val(parseCharges($("#lcAmountFrom").val().replace(/[^0-9.]+/g,"")).toFixed(2));
					if($("input[name=expiryDateFlag]:checked").val() == 'E' && $("input[name=lcAmountFlag]:checked").val() != 'I'){
						commitment_compute = 2;
					} else if($("input[name=expiryDateFlag]:checked").val() == 'E' && $("input[name=lcAmountFlag]:checked").val() == 'I'){
						commitment_compute = 0;
					}
				}
				computeCommitmentFee();
				saveCommitmentFee();
//			} else if($("input[name=expiryDateFlag]:checked").val() == 'R' || $("input[name=lcAmountFlag]:checked").val() == 'D'){
//				$("#commitmentFee").val((500 * php_to).toFixed(2));
//				computeTotalCharges();
			} else {
				$("#commitmentFee").val(0);
				computeTotalCharges();
			}
		}
	}
	
	function setCableFee(){
		if($("input[type=checkbox]:checked").length != 0){
			checkRate();
			$("#cableFee").val((500 * php_to).toFixed(2));
			computeTotalCharges();
		}
	}
	
	var confirm_compute
	function setConfirmingFee(){
		if(($("#changeInConfirmationCheck:checked").length != 0) && ($("#changeInConfirmationTo").val() == "YES") && ($("input[name=advanceCorresChargesFlag]:checked").val() == 'TRUE')){
			if($("input[name=lcAmountFlag]:checked").val() == 'I' && $("input[name=expiryDateFlag]:checked").length == 0){
				confirm_compute = 2;
			} else {
				$("#confirmingFeeLCAmountPopup").val(parseCharges($("#lcAmountFrom").val().replace(/[^0-9.]+/g,"")).toFixed(2));
				if($("input[name=lcAmountFlag]:checked").val() == 'I' && $("input[name=expiryDateFlag]:checked").length != 0){
					confirm_compute = 0;
				} else if($("input[name=lcAmountFlag]:checked").val() != 'I'){
					confirm_compute = 1;
				}
			}
			computeConfirmingFee();
			saveConfirmingFee();
		} else {
			$("#confirmingFee").val(0);
		}
		computeTotalCharges();
	}
	
	function setAdvisingFee(){
		checkRate();
		if(!$("#advisingFee").parent().hasClass("corres_hide")){
			$("#advisingFee").val(parseCharges(50 * usd_to).toFixed(2));
		} else $("#advisingFee").val(0);
		computeTotalCharges();
	}

	function setMonth(){
		$("#bankCommissionNumberMonths2Popup, #commitmentFeeNumberMonths2Popup").val(function(){
			if($("input[name=expiryDateFlag]:checked").val() == 'E'){
				return minimumMonthCheck(parseCharges($("#expiryDateModifiedDays").val() / 30));
			}else if($("input[name=expiryDateFlag]:checked").val() == 'R') return 0;
		});
		
		var number_of_months;
		issue = new Date($("#issueDate").val());
		expiry = new Date($("#expiryDate").val());
		//computes the number of months from fxlc opening date to expiry date
		number_of_days = numberOfDaysSwitch(parseInt(Math.abs((expiry-issue)/(1000*60*60*24))));
		number_of_months = minimumMonthCheck(number_of_days / 30);
		$("#confirmingFeeNumberMonthsPopup").val(parseRates(number_of_months));
		number_of_days = null
		number_of_months = null; //resets the variable.
		
		var amend = new Date($("#lcAmendmentDate").val())!=null?new Date($("#lcAmendmentDate").val()):'';
		//computes the number of months from fxlc amendment date to expiry date
		number_of_days = numberOfDaysSwitch(parseInt(Math.abs((expiry-amend)/(1000*60*60*24))));
		number_of_months = minimumMonthCheck(number_of_days / 30);
		$("#bankCommissionNumberMonthsPopup, #confirmingFeeNumberMonths2Popup").val(parseRates(number_of_months));
		$("#commitmentFeeNumberMonthsPopup").val(function(){
			if($("#type").val() == "STANDBY") return parseRates(number_of_months);
			else if($("#type").val() == "REGULAR") return parseRates(minimumMonthCheck(parseRates($("#tenorOfDraft").val()) / 30));
		});
		
		number_of_days = null
		number_of_months = null; //resets the variable.
		resetChargesVariables();
	}
	
	function numberOfDaysSwitch(number_of_days){	//method that acts when the expiry date has been amended
		if($("input[name=expiryDateFlag]:checked").length != 0){
			var period_change = parseInt($("#expiryDateModifiedDays").val());
			if($("input[name=expiryDateFlag]:checked").val() == 'E') {
				number_of_days += period_change;
			} else if($("input[name=expiryDateFlag]:checked").val() == 'R') {
				number_of_days -= period_change;
			}
		}
		return number_of_days
	}
	
	function minimumMonthCheck(number_of_months){	//ensures that the minimum number of months is always 1
		if(number_of_months <= 1){
			return 1;
		} else {
			return number_of_months;
		}
	}
	
	function setDefaults(){
		$("#bankCommissionPercentageNPopup, #bankCommissionPercentageRPopup, #bankCommissionPercentageN2Popup, #bankCommissionPercentageR2Popup, #commitmentFeePercentageNPopup, #commitmentFeePercentageRPopup, #commitmentFeePercentageN2Popup, #commitmentFeePercentageR2Popup, #confirmingFeePercentageNPopup, #confirmingFeePercentageRPopup, #confirmingFeePercentageN2Popup, #confirmingFeePercentageR2Popup").val(1);
		$("#bankCommissionPercentageDPopup, #bankCommissionPercentageD2Popup, #confirmingFeePercentageDPopup, #confirmingFeePercentageD2Popup").val(8);
		$("#commitmentFeePercentageDPopup, #commitmentFeePercentageD2Popup").val(4);
		$("#documentaryStampCentavosPopup").val(parseFloat(0.30).toFixed(2));
	}
	
	function parseCharges(charge){	//function used for casting charges values to float values. Returns 0 when value does not exist.
		return parseFloat(charge || 0);
	}
	
	function parseRates(charge){	//function used for casting conversion rates to float values. Returns 1 when value is not assigned.  
		return parseFloat(charge || 1);
	}
	
	function computeTotalCharges(){	//computes total value of charges. Can be applied even if field does not exist.
		var sum = parseCharges($("#bankCommission").val())+parseCharges($("#commitmentFee").val())+parseCharges($("#documentaryStamp").val())+parseCharges($("#cableFee").val())+parseCharges($("#advisingFee").val())+parseCharges($("#confirmingFee").val());
		$("#totalAmountChargesDue, #totalAmountDue").val(sum.toFixed(2));
	}
	
	function resetChargesVariables(){	//function used to recompute charges whenever currency (lc or settlement), radio values (corres or cwt), or lc amount is changed.
		checkRate();
		if($("#currency").val() != '' && $(".trans_currency").val() != ''){
			
			setBankCommission();
			setCableFee();
			setAdvisingFee();
			setConfirmingFee();
			setCommitmentFee();
			
			if($("#lcAmountCheck").attr("checked") == "checked" && $("input[name=lcAmountFlag]:checked").val() == 'I'){
				computeDocumentaryStamp();
				saveDocumentaryStamp();
			} else $("#documentaryStamp").val(0);
			computeTotalCharges();
		}
	}
	
	var x;
	//sets action prior to saving manually re-computed values.
	function pendingBankCommission(){
		x = 'bank commission'
	}
	
	function pendingCommitmentFee(){
		x = 'commitment fee'
	}
	
	function pendingDocumentaryStamp(){
		x = 'documentary stamp'
	}
	
	function pendingConfirmingFee(){
		x = 'confirming fee'
	}
	
	function verifyAction(){	//matches action when commencing save action. 
		if (x === 'bank commission') saveBankCommission();
		if (x === 'commitment fee') saveCommitmentFee();
		if (x === 'documentary stamp') saveDocumentaryStamp();
		if (x === 'confirming fee') saveConfirmingFee();
		
		//clears any backup values.
		temp_n = null;
		temp_d = null;
		temp_r = null;
		temp_m = null;
		temp_cents = null;
		temp_200 = null;
	}
	
	function verifyCancel(){	//matches action when the "No" button on confirmatino screen is pressed.
		if (x === 'bank commission') cancelBankCommission();
		if (x === 'commitment fee') cancelCommitmentFee();
		if (x === 'documentary stamp') cancelDocumentaryStamp();
		if (x === 'cable fee') cancelCableFee();
		if (x === 'advising fee') cancelAdvisingFee();
		if (x === 'confirming fee') cancelConfirmingFee();
	}
	
	//saves values to corresponding charges tab fields.
	function saveBankCommission(){
		if (bank_compute == 1){
			$("#BC").val(parseCharges($("#bankCommissionPopup").val()).toFixed(2));
		} else if (bank_compute == 2){
//			$("#bankCommission").val(parseCharges($("#bankCommission2Popup").val()).toFixed(2));
			$("#BC").val(parseCharges($("#bankCommissionPopupField2").val()).toFixed(2));
		} else if (bank_compute == 0){
//			$("#bankCommission").val(parseCharges($("#bankCommissionTotalPopup").val()).toFixed(2));
			$("#BC").val(parseCharges($("#bankCommissionPopup").val()).toFixed(2));
		}
		closeBankCommission();
		computeTotalCharges();
	}
	
	function saveCommitmentFee(){
		if (commitment_compute == 1){
			$("#commitmentFee").val(parseCharges($("#confirmingFeePopup").val()).toFixed(2));
		} else if (commitment_compute == 2){
			$("#commitmentFee").val(parseCharges($("#commitmentFee2Popup").val()).toFixed(2));
		} else if (commitment_compute == 0){
			$("#commitmentFee").val(parseCharges($("#commitmentFeeTotalPopup").val()).toFixed(2));
		}
		closeCommitmentFee();
		computeTotalCharges();
	}
	
	function saveDocumentaryStamp(){
		$("#documentaryStamp").val(parseCharges($("#documentaryStampPopup").val()).toFixed(2));
		closeDocumentaryStamp();
		computeTotalCharges();
	}
	
	function saveConfirmingFee(){
		if(confirm_compute == 1){
			$("#confirmingFee").val(parseCharges($("#confirmFeePopup").val()).toFixed(2));
		} else if(confirm_compute == 2){
			$("#confirmingFee").val(parseCharges($("#confirmFee2Popup").val()).toFixed(2));
		} else if(confirm_compute == 0){
			$("#confirmingFee").val(parseCharges($("#confirmingFeeTotalPopup").val()).toFixed(2));
		}
		closeConfirmingFee();
		computeTotalCharges();
	}
	
	//computations used when the re-compute button is clicked. 
	function computeBankCommission(){
		if(bank_compute == 1){ 
			computeBankCommission1();
		}else if(bank_compute == 2){ 
			computeBankCommission2();
		}else if(bank_compute == 0){
			computeBankCommission1();
			computeBankCommission2();
			$("#bankCommissionTotalPopup").val((parseCharges($("#bankCommissionPopup").val()) + parseCharges($("#bankCommission2Popup").val())).toFixed(2));
		}
	}
	function computeBankCommission1(){
		var lc_amount = parseCharges($("#bankCommissionLCAmountPopup").val().replace(/[^0-9\.]+/g,""));
		var n = parseCharges($("#bankCommissionPercentageNPopup").val());
		var d = parseCharges($("#bankCommissionPercentageDPopup").val());
		var r = parseCharges($("#bankCommissionPercentageRPopup").val());
		var m = parseCharges($("#bankCommissionNumberMonthsPopup").val());
		var result = Math.round((lc_amount * parseRates(lc_to_php)) * ((n * r * m)/(d * 100))* 100) / 100;
		if (parseCharges(result)  > 500){
			$("#bankCommissionPopup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
				$("#bankCommissionNetBankComPopup").val((parseCharges(result) * parseRates(php_to) * .98).toFixed(2));
				$("#bankCommissionCwtPopup").val((parseCharges(result) * parseRates(php_to) * .02).toFixed(2));
				$("#bankCommissionGrossBankComPopup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			} else emptyCWTBankCommission();
		}
		else {$("#bankCommissionPopup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
			if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
				$("#bankCommissionNetBankComPopup").val((parseCharges(500) * parseRates(php_to) * .98).toFixed(2));
				$("#bankCommissionCwtPopup").val((parseCharges(500) * parseRates(php_to) * .02).toFixed(2));
				$("#bankCommissionGrossBankComPopup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
			} else emptyCWTBankCommission();
		}
	}
	function computeBankCommission2(){
		var lc_amount = parseCharges($("#bankCommissionLCAmount2Popup").val().replace(/[^0-9\.]+/g,""));
		var n = parseCharges($("#bankCommissionPercentageN2Popup").val());
		var d = parseCharges($("#bankCommissionPercentageD2Popup").val());
		var r = parseCharges($("#bankCommissionPercentageR2Popup").val());
		var m = parseCharges($("#bankCommissionNumberMonths2Popup").val());
		var result = Math.round((lc_amount * parseRates(lc_to_php)) * ((n * r * m)/(d * 100))* 100) / 100;
		if (parseCharges(result)  > 500){
			$("#bankCommission2Popup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
				$("#bankCommissionNetBankCom2Popup").val((parseCharges(result) * parseRates(php_to) * .98).toFixed(2));
				$("#bankCommissionCwt2Popup").val((parseCharges(result) * parseRates(php_to) * .02).toFixed(2));
				$("#bankCommissionGrossBankCom2Popup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			} else emptyCWTBankCommission2();
		}
		else {$("#bankCommission2Popup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
			if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
				$("#bankCommissionNetBankCom2Popup").val((parseCharges(500) * parseRates(php_to) * .98).toFixed(2));
				$("#bankCommissionCwt2Popup").val((parseCharges(500) * parseRates(php_to) * .02).toFixed(2));
				$("#bankCommissionGrossBankCom2Popup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
			} else emptyCWTBankCommission2();
		}
	}
	
	function computeDocumentaryStamp(){
		var lc_amount = parseCharges($("#documentaryStampLCAmountPopup").val().replace(/[^0-9.]+/g,""));
		var cents = parseCharges($("#documentaryStampCentavosPopup").val());
		var lc_200 = Math.ceil((lc_amount * parseRates(lc_to_php)) / 100) * 100;
		if ((lc_200 / 100) % 2 != 0){
			lc_200 = parseInt(((lc_200 / 100) + 1) * 100) ;
		}
		$("#documentaryStampForEvery200Popup").val(lc_200.toFixed(2));
		 $("#docStampPopup").val(parseCharges(lc_200 * cents / 200).toFixed(2));
		 $("#documentaryStampPopup").val((parseRates(php_to) * parseRates($("#docStampPopup").val())).toFixed(2));
	}
	
	function computeCommitmentFee(){
		if(commitment_compute == 1){ 
			computeCommitmentFee1();
		}else if(commitment_compute == 2){ 
			computeCommitmentFee2();
		}else if(commitment_compute == 0){
			computeCommitmentFee1();
			computeCommitmentFee2();
			$("#commitmentFeeTotalPopup").val((parseCharges($("#confirmingFeePopup").val()) + parseCharges($("#commitmentFee2Popup").val())).toFixed(2));
		}
	}
	
	function computeCommitmentFee1(){
		var lc_amount = parseCharges($("#commitmentFeeLCAmountPopup").val().replace(/[^0-9.]+/g,""));
		var n = parseCharges($("#commitmentFeePercentageNPopup").val());
		var d = parseCharges($("#commitmentFeePercentageDPopup").val());
		var r = parseCharges($("#commitmentFeePercentageRPopup").val());
		var m = parseCharges($("#commitmentFeeNumberMonthsPopup").val());
		var result = Math.round((lc_amount * parseRates(lc_to_php)) * ((n * r * m)/(d * 100))* 100) / 100;
		if (parseCharges(result) > 500){
			$("#confirmingFeePopup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
				$("#commitmentFeeNetconfirmingFeePopup").val((parseCharges(result) * parseRates(php_to) * .98).toFixed(2));
				$("#commitmentFeeCwtPopup").val((parseCharges(result) * parseRates(php_to) * .02).toFixed(2));
				$("#commitmentFeeGrossconfirmingFeePopup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			} else emptyCWTCommitmentFee();
		}
		else {$("#confirmingFeePopup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
			if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
				$("#commitmentFeeNetconfirmingFeePopup").val((parseCharges(500) * parseRates(php_to) * .98).toFixed(2));
				$("#commitmentFeeCwtPopup").val((parseCharges(500) * parseRates(php_to) * .02).toFixed(2));
				$("#commitmentFeeGrossconfirmingFeePopup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
			} else emptyCWTCommitmentFee();
		}
	}
	
	function computeCommitmentFee2(){
		var lc_amount = parseCharges($("#commitmentFeeLCAmount2Popup").val().replace(/[^0-9.]+/g,""));
		var n = parseCharges($("#commitmentFeePercentageN2Popup").val());
		var d = parseCharges($("#commitmentFeePercentageD2Popup").val());
		var r = parseCharges($("#commitmentFeePercentageR2Popup").val());
		var m = parseCharges($("#commitmentFeeNumberMonths2Popup").val());
		var result = Math.round((lc_amount * parseRates(lc_to_php)) * ((n * r * m)/(d * 100))* 100) / 100;
		if (parseCharges(result) > 500){
			$("#commitmentFee2Popup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
				$("#commitmentFeeNetCommitmentFee2Popup").val((parseCharges(result) * parseRates(php_to) * .98).toFixed(2));
				$("#commitmentFeeCwt2Popup").val((parseCharges(result) * parseRates(php_to) * .02).toFixed(2));
				$("#commitmentFeeGrossCommitmentFee2Popup").val((parseCharges(result) * parseRates(php_to)).toFixed(2));
			} else emptyCWTCommitmentFee2();
		}
		else {$("#commitmentFee2Popup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
		if ($("input[name=cwtFlag]:checked").val() == 'TRUE'){
			$("#commitmentFeeNetCommitmentFee2Popup").val((parseCharges(500) * parseRates(php_to) * .98).toFixed(2));
			$("#commitmentFeeCwt2Popup").val((parseCharges(500) * parseRates(php_to) * .02).toFixed(2));
			$("#commitmentFeeGrossCommitmentFee2Popup").val((parseCharges(500) * parseRates(php_to)).toFixed(2));
		} else emptyCWTCommitmentFee2();
		}
	}
	
	function computeConfirmingFee(){
		if(confirm_compute == 1){
			computeConfirmingFee1();
		} else if(confirm_compute == 2){
			computeConfirmingFee2();
		} else if(confirm_compute == 0){
			computeConfirmingFee1();
			computeConfirmingFee2();
			$("#confirmingFeeTotalPopup").val((parseCharges($("#confirmFeePopup").val()) + parseCharges($("#confirmFee2Popup").val())).toFixed(2));
		}
	}
	
	function computeConfirmingFee1(){
		var lc_amount = parseCharges($("#confirmingFeeLCAmountPopup").val().replace(/[^0-9.]+/g,""));
		var n = parseCharges($("#confirmingFeePercentageNPopup").val());
		var d = parseCharges($("#confirmingFeePercentageDPopup").val());
		var r = parseCharges($("#confirmingFeePercentageRPopup").val());
		var m = parseCharges($("#confirmingFeeNumberMonthsPopup").val());
		var result = Math.round((lc_amount * parseRates(lc_to_usd)) * ((n * r * m)/(d * 100))* 100) / 100;
		if (parseCharges(result) > 50){
			$("#confirmFeePopup").val((parseCharges(result) * parseRates(usd_to)).toFixed(2));
		}
		else $("#confirmFeePopup").val((parseCharges(50) * parseRates(usd_to)).toFixed(2));
	}
	
	function computeConfirmingFee2(){
		var lc_amount = parseCharges($("#confirmingFeeLCAmount2Popup").val().replace(/[^0-9.]+/g,""));
		var n = parseCharges($("#confirmingFeePercentageN2Popup").val());
		var d = parseCharges($("#confirmingFeePercentageD2Popup").val());
		var r = parseCharges($("#confirmingFeePercentageR2Popup").val());
		var m = parseCharges($("#confirmingFeeNumberMonths2Popup").val());
		var result = Math.round((lc_amount * parseRates(lc_to_usd)) * ((n * r * m)/(d * 100))* 100) / 100;
		if (parseCharges(result) > 50){
			$("#confirmFee2Popup").val((parseCharges(result) * parseRates(usd_to)).toFixed(2));
		}
		else $("#confirmFee2Popup").val((parseCharges(50) * parseRates(usd_to)).toFixed(2));
	}
	
	
	
	//empties net, gross, and cwt fields when cwt radio is set to "No"
	function emptyCWTBankCommission(){
		$("#bankCommissionNetBankComPopup").val('');
		$("#bankCommissionCwtPopup").val('');
		$("#bankCommissionGrossBankComPopup").val('');
	}
	function emptyCWTBankCommission2(){
		$("#bankCommissionNetBankCom2Popup").val('');
		$("#bankCommissionCwt2Popup").val('');
		$("#bankCommissionGrossBankCom2Popup").val('');
	}
	
	function emptyCWTCommitmentFee(){
		$("#commitmentFeeNetconfirmingFeePopup").val('');
		$("#commitmentFeeCwtPopup").val('');
		$("#commitmentFeeGrossconfirmingFeePopup").val('');
	}
	
	function emptyCWTCommitmentFee2(){
		$("#commitmentFeeNetCommitmentFee2Popup").val('');
		$("#commitmentFeeCwt2Popup").val('');
		$("#commitmentFeeGrossCommitmentFee2Popup").val('');
	}
	
	var temp_n;
	var temp_d;
	var temp_r;
	var temp_m;
	var temp_cents;
	var temp_200;
	//creates backup of original values whenever predetermined charges popup has been selected
	function backupBankCommission(){
		temp_n = $("#bankCommissionPercentageNPopup").val();
		temp_d = $("#bankCommissionPercentageDPopup").val();
		temp_r = $("#bankCommissionPercentageRPopup").val();
		temp_m = $("#bankCommissionNumberMonthsPopup").val();
	}
	
	function backupCommitmentFee(){
		temp_n = $("#commitmentFeePercentageNPopup").val();
		temp_d = $("#commitmentFeePercentageDPopup").val();
		temp_r = $("#commitmentFeePercentageRPopup").val();
		temp_m = $("#commitmentFeeNumberMonthsPopup").val();
	}
	
	function backupDocumentaryStamp(){
		temp_cents = $("#documentaryStampCentavos").val();
		temp_200 = $("#documentaryStampForEvery200Popup").val();
	}
	
	function backupConfirmingFee(){
		temp_n = $("#confirmingFeePercentageNPopup").val();
		temp_d = $("#confirmingFeePercentageDPopup").val();
		temp_r = $("#confirmingFeePercentageRPopup").val();
		temp_m = $("#confirmingFeeNumberMonthsPopup").val();
	}
	
	//resets values of certain data when saving has been cancelled
	function cancelBankCommission(){
		$("#bankCommissionPercentageNPopup").val(temp_n);
		$("#bankCommissionPercentageDPopup").val(temp_d);
		$("#bankCommissionPercentageRPopup").val(temp_r);
		$("#bankCommissionNumberMonthsPopup").val(temp_m);
		closeBankCommission();
		resetChargesVariables();
	}
	
	function cancelCommitmentFee(){
		$("#commitmentFeePercentageNPopup").val(temp_n);
		$("#commitmentFeePercentageDPopup").val(temp_d);
		$("#commitmentFeePercentageRPopup").val(temp_r);
		$("#commitmentFeeNumberMonthsPopup").val(temp_m);
		closeCommitmentFee();
		resetChargesVariables();
	}
	
	function cancelDocumentaryStamp(){
		$("#documentaryStampCentavos").val(temp_cents);
		$("#documentaryStampForEvery200Popup").val(temp_200);
		closeDocumentaryStamp();
		resetChargesVariables();
	}
	
	function cancelConfirmingFee(){
		$("#confirmingFeePercentageNPopup").val(temp_n);
		$("#confirmingFeePercentageDPopup").val(temp_d);
		$("#confirmingFeePercentageRPopup").val(temp_r);
		$("#confirmingFeeNumberMonthsPopup").val(temp_m);
		closeConfirmingFee();
		resetChargesVariables();
	}

	var to_php;
	var to_usd;
	var php_to;
	var usd_to;
	var lc_to_php;
	var lc_to_usd;
	var before_php;
	var before_usd;
	function checkRate(){	//function assigns values to variables prior to computation
		before_php = to_php;
		before_usd = to_usd;
		if ($("#currency").val() === $("#settlementCurrency").val()){
			$("#documentaryStampRatePopup, #bankCommissionRatePopup, #confirmingFeeRatePopup, #commitmentFeeRatePopup").val(parseCharges(1).toFixed(2));
			switch($(".trans_currency").val()){
			default:
				to_usd = null;
				to_php = null;
				usd_to = null;
				php_to = null;
				lc_to_php = null;
				lc_to_usd = null;
				$(".rate_currency").val("");
				break;
			case "PHP":
				to_usd = parseRates(1 / 42.45);
				to_php = parseRates(1);
				usd_to = parseRates(42.45);
				php_to = parseRates(1);
				lc_to_php = to_php;
				lc_to_usd = to_usd;
				$(".rate_currency").val("PHP");
				break;
			case "USD":
				to_usd = parseRates(1);
				to_php = parseRates(42.45);
				usd_to = parseRates(1);
				php_to = parseRates(1 / 42.45);
				lc_to_php = to_php;
				lc_to_usd = to_usd;
				$(".rate_currency").val("USD");
				break;
			case "EUR":
				to_usd = parseRates(1.4725);
				to_php = parseRates(62.83);
				usd_to = parseRates(1 / 1.4725);
				php_to = parseRates(1 / 62.83);
				lc_to_php = to_php;
				lc_to_usd = to_usd;
				$(".rate_currency").val("EUR");
				break;
			}
		} else {
			$(".rate_currency").val($("#currency").val() + " to " + $("#settlementCurrency").val());
			switch ($(".rate_currency").val()){
			case "PHP to USD": $("#documentaryStampRatePopup, #bankCommissionRatePopup, #cilexRatePopup, #confirmingFeeRatePopup, #commitmentFeeRatePopup").val(parseRates(42.45).toFixed(8));
			to_usd = parseRates(1);
			to_php = parseRates(42.45);
			usd_to = parseRates(1);
			php_to = parseRates(1 / 42.45);
			lc_to_php = parseRates(1);
			lc_to_usd = parseRates(1 / 42.45);
			break;
			case "PHP to EUR": $("#documentaryStampRatePopup, #bankCommissionRatePopup, #cilexRatePopup, #confirmingFeeRatePopup, #commitmentFeeRatePopup").val(parseRates(62.83).toFixed(8));
			to_usd = parseRates(1.4725);
			to_php = parseRates(62.83);
			usd_to = parseRates(1 / 1.4725);
			php_to = parseRates(1 / 62.83);
			lc_to_php = parseRates(1);
			lc_to_usd = parseRates(1 / 42.45);
			break;
			case "USD to EUR": $("#documentaryStampRatePopup, #bankCommissionRatePopup, #cilexRatePopup, #confirmingFeeRatePopup, #commitmentFeeRatePopup").val(parseRates(1.4725).toFixed(8));
			to_usd = parseRates(1.4725);
			to_php = parseRates(62.83);
			usd_to = parseRates(1 / 1.4725);
			php_to = parseRates(1 / 62.83);
			lc_to_php = parseRates(42.45);
			lc_to_usd = parseRates(1);
			break;
			case "USD to PHP": $("#documentaryStampRatePopup, #bankCommissionRatePopup, #cilexRatePopup, #confirmingFeeRatePopup, #commitmentFeeRatePopup").val(parseRates(1 / 42.45).toFixed(8));
			to_usd = parseRates(1 / 42.45);
			to_php = parseRates(1);
			usd_to = parseRates(42.45);
			php_to = parseRates(1);
			lc_to_php = parseRates(42.45);
			lc_to_usd = parseRates(1);
			break;
			case "EUR to PHP": $("#documentaryStampRatePopup, #bankCommissionRatePopup, #cilexRatePopup, #confirmingFeeRatePopup, #commitmentFeeRatePopup").val(parseRates(1 / 62.83).toFixed(8));
			to_usd = parseRates(1 / 42.45);
			to_php = parseRates(1);
			usd_to = parseRates(42.45);
			php_to = parseRates(1);
			lc_to_php = parseRates(62.83);
			lc_to_usd = parseRates(1.4725);
			break;
			case "EUR to USD": $("#documentaryStampRatePopup, #bankCommissionRatePopup, #cilexRatePopup, #confirmingFeeRatePopup, #commitmentFeeRatePopup").val(parseRates(1 / 1.4725).toFixed(8));
			to_usd = parseRates(1);
			to_php = parseRates(42.45);
			usd_to = parseRates(1);
			php_to = parseRates(1 / 42.45);
			lc_to_php = parseRates(62.83);
			lc_to_usd = parseRates(1.4725);
			break;
			}
		}
	}
});