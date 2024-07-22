/**
	(revision)
	SCR/ER Number: 
	SCR/ER Description: Loans Interest Rate
	[Revised by:] John Patrick C. Bautista
	[Date revised:] 08/24/2016
	Program [Revision] Details: Added function to remove trailing zeroes on Interest Rate field. 
	Member Type: JS
	Project: tfs-web
	Project Name: loan_details_utility.js
 */

function disableUaDuaLoan() {
    $("#bookingCurrency").attr("disabled", "disabled");
    $("#loanDetailsMaturityDateUaLoan").attr("readonly", "readonly");
}

function enableUaDuaLoan() {
    $("#bookingCurrency").removeAttr("disabled");
//    commented out for bug fix
//    $("#loanDetailsMaturityDateUaLoan").removeAttr("readonly");
}

function clearUaDuaLoan() {
    $("input[name=bookingCurrency]").attr('checked', false);
    $("#loanDetailsMaturityDateUaLoan").val("");
}

function disableIbTrDbpDtrLoan() {
    $("#bookingCurrency, #interestTermCode, #interestRate, #interestTerm, #loanTerm, #loanTermCode, #withPriorApprovalInCram").attr("disabled", "disabled");
    $("#loanDetailsMaturityDate").attr("readonly", "readonly");
}

function enableIbTrDbpDtrLoan() {
    $("#bookingCurrency, #interestTermCode, #interestRate, #interestTerm, #loanTerm, #loanTermCode, #withPriorApprovalInCram").removeAttr("disabled");
//    commented out for bug fix
//    $("#loanDetailsMaturityDate").removeAttr("readonly");
}

function clearIbTrDbpDtrLoan() {
    $("input[name=bookingCurrency]").attr('checked', false);
    $("input[name=interestTermCode]").attr('checked', false);
    $("#interestRate, #interestTerm, #loanTerm, #loanTermCode, #loanDetailsMaturityDate");
    $("input[name=withPriorApprovalInCram]").attr('checked', false);
}

function onChangeTypeOfLoan(){
    var typeOfLoan = $("#typeOfLoan").val()?$("#typeOfLoan").val():'';

    if (typeOfLoan.toLowerCase()=="ib_loan" || typeOfLoan.toLowerCase()=="dbp_loan" || typeOfLoan.toLowerCase()=="ebp_loan" || typeOfLoan.toLowerCase()=="tr_loan" || typeOfLoan.toLowerCase()=="dtr_loan"  ){

        $(".ua-dua-loan").hide();
        disableUaDuaLoan();
        $(".ib-tr-dbp-dtr-loan").show();
        clearIbTrDbpDtrLoan();
        enableIbTrDbpDtrLoan();
    }else if(typeOfLoan.toLowerCase()=="ua_loan" || typeOfLoan.toLowerCase()=="dua_loan"){   

    	$(".ua-dua-loan").show();
        clearUaDuaLoan();
        enableUaDuaLoan();
        $(".ib-tr-dbp-dtr-loan").hide();
        disableIbTrDbpDtrLoan();
    }else{

        $(".ua-dua-loan").hide();
        clearUaDuaLoan();
        disableUaDuaLoan();
        $(".ib-tr-dbp-dtr-loan").hide();

        if (serviceType != "NEGOTIATION") {

            clearIbTrDbpDtrLoan();
            disableIbTrDbpDtrLoan();
        }
    }
}

$(document).ready(function(){
	$(".ua-dua-loan").hide();
	$(".ib-tr-dbp-dtr-loan").hide();
    //enableIbTrDbpDtrLoan();
	$("#typeOfLoan").change(onChangeTypeOfLoan);
    onChangeTypeOfLoan();
    
    // Remove trailing zeroes - applies to IB/TR/EBP/DBP/DTR/UA/DUA LOANS
    if( $('input[name=typeOfLoan]').val() != undefined ){
    	if( $('input[name=typeOfLoan]').val() != null || $('input[name=typeOfLoan]').val() != "" ){
    		var typeOfLoan = $('input[name=typeOfLoan]').val();
    		typeOfLoan = typeOfLoan.toUpperCase();
    		if( typeOfLoan != null || typeOfLoan != "" ){
    			if ( $('input[name=interestRate]').val() != undefined ){
	    			var loanIntRate = $('input[name=interestRate]').val();
	    			loanIntRate = loanIntRate.replace(/^0+|0+$/g, "");
	    			$('input[name=interestRate]').val(loanIntRate);
	    			// If string starts with decimal, append zero at the start
	    			var firstChar = loanIntRate.substr(0, 1);
	            	if( loanIntRate.charAt(0) === '.' && firstChar === '.' ){ 
	            		var zeroDef = 0;
	            		$('input[name=interestRate]').val(zeroDef + loanIntRate);
	            	} 
    			}
    		}
        }
    }
});