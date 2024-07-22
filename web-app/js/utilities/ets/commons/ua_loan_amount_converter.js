$(document).ready(function(){

		
		var selectCurrency = $(".settlementCurrencyUaLoanAmount");
		var settlementCurrency = $(".settle_currency");
		var settlementAmount = $("#amountUaLoanSettlementPayment");
		var fxlcAmount = $("#amountUaLoanLcPayment");
				
			selectCurrency.change(function() {
						settlementCurrency.val(selectCurrency.val());
					});
			
				settlementAmount.keypress(disableFxlcAmount);
				settlementAmount.keydown(disableFxlcAmount);
				settlementAmount.keyup(disableFxlcAmount);

			
			settlementAmount.change(function() {settlementAmount.val(parseCharges(settlementAmount.val()).toFixed(2));
					});
			
				fxlcAmount.keypress(disableSettlementAmount);
				fxlcAmount.keydown(disableSettlementAmount);
				fxlcAmount.keyup(disableSettlementAmount);

			fxlcAmount.change(function() {fxlcAmount.val(parseCharges(fxlcAmount.val()).toFixed(2));
					});

			$("#recomputeButton").click(computeExchange);
		

function disableSettlementAmount() {

	if (fxlcAmount.val().length > 0) {
			$('.amountSettlement').text('');
			settlementAmount.attr("readonly", "readonly");
			settlementAmount.parent().removeClass("editable");
			//settlementAmount.val("0.00");
		//	computeExchange();
		
	} else {
		$('.amountSettlement').text('*');
		settlementAmount.removeAttr("readonly");
		settlementAmount.parent().addClass("editable");
	}
}

function disableFxlcAmount() {

	if (settlementAmount.val().length > 0) {
			
			$('.amountLc').text('');
			fxlcAmount.attr("readonly", "readonly");
			fxlcAmount.parent().removeClass("editable");
			//fxlcAmount.val("0.00");
			//computeExchange();

	} else {
		
		$('.amountLc').text('*');
		fxlcAmount.removeAttr("readonly");
		fxlcAmount.parent().addClass("editable");
	}
}
var exchange_rate;
function computeExchange() {
	
	if(settlementCurrency.val()==""){
		alert("Please Select Settlement Currency");
	}else if(settlementAmount.val()=="" && fxlcAmount.val()==""){
		alert("Please Enter Amount to Recompute");
	}else{
	
	$("#popup_mode_of_payment_ua_loan").show();
	switch (settlementCurrency.val()) {
		case "PHP":
			switch ($(".fxlc_currency").val()) {
			case "PHP":
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(fxlcAmount.val());
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(settlementAmount.val());
				}
				break;
			case "USD":
				exchange_rate = 42.45;
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(parseCharges(fxlcAmount.val()*exchange_rate).toFixed(2));
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(parseCharges(settlementAmount.val()/exchange_rate).toFixed(2));
				}
				break;
			case "EUR":
				exchange_rate = 62.83;
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(parseCharges(fxlcAmount.val()*exchange_rate).toFixed(2));
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(parseCharges(settlementAmount.val()/exchange_rate).toFixed(2));
				}
				break;
			}
			break;
		case "USD":
			switch ($(".fxlc_currency").val()) {
			case "PHP":
				exchange_rate = 42.45;
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(parseCharges(fxlcAmount.val()/exchange_rate).toFixed(2));
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(parseCharges(settlementAmount.val()*exchange_rate).toFixed(2));
				}
				break;
			case "USD":
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(fxlcAmount.val());
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(settlementAmount.val());
				}
				break;
			case "EUR":
				exchange_rate = 1.4725;
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(parseCharges(fxlcAmount.val()*exchange_rate).toFixed(2));
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(parseCharges(settlementAmount.val()/exchange_rate).toFixed(2));
				}
				break;
			}
			break;
		case "EUR":
			switch ($(".fxlc_currency").val()) {
			case "PHP":
				exchange_rate = 62.83;
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(parseCharges(fxlcAmount.val()/exchange_rate).toFixed(2));
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(parseCharges(settlementAmount.val()*exchange_rate).toFixed(2));
				}
				break;
			case "USD":
				exchange_rate = 1.4725;
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(parseCharges(fxlcAmount.val()/exchange_rate).toFixed(2));
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(parseCharges(settlementAmount.val()*exchange_rate).toFixed(2));
				}
				break;
			case "EUR":
				if (settlementAmount.attr("readonly") == "readonly") {
					settlementAmount.val(fxlcAmount.val());
				} else if (fxlcAmount.attr("readonly") == "readonly") {
					fxlcAmount.val(settlementAmount.val());
				}
				break;
			}
			break;
		}
	}
}

});