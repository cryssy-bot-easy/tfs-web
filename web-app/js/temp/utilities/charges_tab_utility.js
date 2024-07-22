//function getRateCurrency() {
//	var lcCurrency = $("#lcCurrency").val();
//	var settlementCurrency = $("#settlementCurrency").val();
//
//	if(settlementCurrency != "") {
//		if(lcCurrency == settlementCurrency) {
//			return settlementCurrency;
//		}else{
//			return lcCurrency + " TO " + settlementCurrency;
//		}
//	}else{
//		return "";
//	}
//}
//
//function setupCashLcCurrencies() {
//	var lcCurrencyVal = $("#lcCurrency").val();
//
//	$("#totalAmountDueLcCurrency").val(lcCurrencyVal);
//}
//
//// setup values of currency in popup
//function setupBankCommission(settlementCurrency) {
//	$("#bankCommission").val("");
//
//	$("#bankCommissionPopupFieldCurrency, #bankCommissionNetBankComCurrency, #bankCommissionCWTCurrency, #bankCommissionGrossBankComCurrency").val(settlementCurrency);
//
//	$("#bankCommissionRateCurrency").val(getRateCurrency());
//}
//
//// setup values of commitment fee in popup
//function setupCommitmentFee(settlementCurrency) {
//	$("#commitmentFee").val("");//
//	$("#confirmingFeePopupFieldCurrency, #commitmentFeeNetBankComCurrency, #commitmentFeeCWTCurrency, #commitmentFeeGrossBankComCurrency").val(settlementCurrency);
//
//	$("#commitmentFeeRateCurrency").val(getRateCurrency());
//}
//
//// setup values of cilex fee in popup
//function setupCilexFee(settlementCurrency) {
//	$("#cilexFee").val("");
//
//	$("#cilexFeePopupFieldCurrency, #cilexNetBankComCurrency, #cilexCWTCurrency, #cilexGrossBankComCurrency").val(settlementCurrency);
//
//	$("#cilexRateCurrency").val(getRateCurrency());
//}
//
//// setup values of documentary stamp in popup
//function setupDocumentaryStamp(settlementCurrency) {
//	$("#documentaryStamp").val("");
//
//	$("#documentaryStampPopupFieldCurrency").val(settlementCurrency);
//
//	$("#documentaryStampRateCurrency").val(getRateCurrency());
//}
//
//// setup values of cable fee in popup
//function setupCableFee(settlementCurrency) {
//	$("#cableFee").val("");
//
//	$("#cableFeePopupFieldCurrency").val(settlementCurrency);
//}
//
//// setup values of supplies fee in popup
//function setupSuppliesFee(settlementCurrency) {
//	$("#suppliesFee").val("");
//
//	$("#suppliesFeePopupFieldCurrency").val(settlementCurrency);
//}
//
////setup values of notarial fee in popup
//function setupNotarialFee(settlementCurrency){
//	$("#notarialFee").val("");
//
//	$("#notarialFeeCurrency").val(settlementCurrency);
//}
//
////setup values of interest due in popup
//function setupInterestDue(settlementCurrency){
//	$("#interestDue").val("");
//
//	$("#interestDueCurrency").val(settlementCurrency);
//}
//
////setup values of remittancee fee in popup
//function setupRemittanceFee(settlementCurrency){
//	$("#remittanceFee").val("");
//
//	$("#remittanceFeeCurrency").val(settlementCurrency);
//}
//
//// setup values of advising fee in popup
//function setupAdvisingFee(settlementCurrency) {
//	$("#advisingFee").val("");
//
//	$("#advisingFeePopupFieldCurrency").val(settlementCurrency);
//}
//
//// setup values of confirming fee in popup
//function setupConfirmingFee(settlementCurrency) {
//	$("#confirmingFee").val("");
//
//	$("#commitmentFeePopupFieldCurrency").val(settlementCurrency);
//
//	$("#confirmingFeeRateCurrency").val(getRateCurrency());
//}
//
//// setup values in charges payment tab
//function setupChargesPayment(settlementCurrency) {
//	$("#totalAmtDueCurrency, #remainingBalanceCurrency, #amountOfPaymentChargesSettlementCurrency").text(settlementCurrency);
//}
//
//// setup charges popup
//function setupChargesPopup() {
//		var input = $(activePopup);
//
//		var parameters = new Object();
//		// obtains all inputs inside active popup
//	    for(var idx = 0; idx < input.length; idx++) {
//	    	if(input[idx].id.indexOf("Currency") == -1 && $(input[idx]).attr("type") != "button") {
//		    	parameters[input[idx].id] = $("#"+input[idx].id).val();
//	    	}
//	    }
//
//	    // used for charges popups
//	    var jsonString = JSON.stringify(parameters);
//
//	    // sets value of hidden for popup parameters
//	    $("#"+activePopupDiv+"Params").val(jsonString);
//
//	    var fieldId = activePopupDiv.substring(0, activePopupDiv.indexOf("Popup"));
//
//	    // sets value in textfields of active popup
//	    $("#"+fieldId).val($("#"+activePopupDiv+"Field").val());
//
//	// closes active popup
//	disablePopup(activePopupDiv, activePopupBg);
//
//	//get charges amounts
//	var amounts = constructAmountList();
//
//	// compute total charges
//	$.post(computeTotalUrl, {amounts: amounts.toString()}, function(data) {
//		$("#totalAmountCharges, #totalAmountDue").val(data.totalAmount);
//
//		// compute balance and excess
//		$.post(computeBalanceUrl,{totalAmountDue: $("#totalAmountDue").val(), totalAmount: 0}, function(data2) {
//			$("#remainingBalance").val(data2.balance);
//			$("#excessAmountCharges").val(data2.excess);
//		})
//	})
//}
//
//function constructAmountList() {
//	var amounts = [];
//
//	if($("#bankCommission").val() != undefined) {
//		amounts.push($("#bankCommission").val().replace(/,/g,"*"));
//	}
//	if($("#commitmentFee").val() != undefined) {
//		amounts.push($("#commitmentFee").val().replace(/,/g,"*"));
//	}
//	if($("#cilexFee").val() != undefined) {
//		amounts.push($("#cilexFee").val().replace(/,/g,"*"));
//	}
//	if($("#documentaryStamp").val() != undefined) {
//		amounts.push($("#documentaryStamp").val().replace(/,/g,"*"));
//	}
//	if($("#cableFee").val() != undefined) {
//		amounts.push($("#cableFee").val().replace(/,/g,"*"));
//	}
//	if($("#suppliesFee").val() != undefined) {
//		amounts.push($("#suppliesFee").val().replace(/,/g,"*"));
//	}
//	if($("#notarialFee").val() != undefined) {
//		amounts.push($("#suppliesFee").val().replace(/,/g,"*"));
//	}
//	if($("#interestDue").val() != undefined) {
//		amounts.push($("#suppliesFee").val().replace(/,/g,"*"));
//	}
//	if($("#remittanceFee").val() != undefined) {
//		amounts.push($("#remittanceFee").val().replace(/,/g,"*"));
//	}
//	if($("#advisingFee").val() != undefined) {
//		amounts.push($("#advisingFee").val().replace(/,/g,"*"));
//	}
//	if($("#confirmingFee").val() != undefined) {
//		amounts.push($("#confirmingFee").val().replace(/,/g,"*"));
//	}
//
//	return amounts;
//}
//
//function onSettlementCurrencyChange() {
//	var settlementCurrency = $("#settlementCurrency").val();
//
//	// setup values in charges tab currency
//
//	$("#bankCommissionCurrency, #commitmentFeeCurrency, #cilexFeeCurrency, #documentaryStampCurrency, #cableFeeCurrency, #suppliesCurrency, #advisingFeeCurrency, #confirmingFeeCurrency, #totalAmountChargesCurrency, #notarialFeeCurrency, #interestDueCurrency, #remittanceFeeCurrency").text(settlementCurrency);
//
//	// clears values of charges tab amounts if settlement currency is blank
//	if(settlementCurrency == "") {
//		$("#bankCommission, #commitmentFee, #cilexFee, #documentaryStamp, #cableFee, #suppliesFee, #advisingFee, #confirmingFee ,#notarialFee ,#interestDue ,#remittanceFee").val("");
//	}
//
//	// setup popup values
//	setupBankCommission(settlementCurrency);
//	setupCommitmentFee(settlementCurrency);
//	setupCilexFee(settlementCurrency);
//	setupDocumentaryStamp(settlementCurrency);
//	setupCableFee(settlementCurrency);
//	setupSuppliesFee(settlementCurrency);
//	setupNotarialFee(settlementCurrency);
//	setupInterestDue(settlementCurrency);
//	setupRemittanceFee(settlementCurrency);
//	setupAdvisingFee(settlementCurrency);
//    setupConfirmingFee(settlementCurrency);
//	setupChargesPayment(settlementCurrency);
//
//	// setup lc cash payment values
//	$("#totalAmountDueLcCurrency, #remainingBalancLcCurrency, #cashAmountInLcCurrency").text($("#lcCurrency").val());
//}
//
//// init function
//function initializeChargesTabUtility() {
//
//	// for domestic only
//	if(documentType == "DOMESTIC") {
//		onSettlementCurrencyChange();
//        $("#totalAmountChargesCurrency").text("PHP");
//	}
//
//	// wires on change event to settlement currency
//	$("#settlementCurrency, #lcCurrency").change(onSettlementCurrencyChange);
//
//	$(".chargesPopupBtn").click(setupChargesPopup);
//}
//
//$(initializeChargesTabUtility);

