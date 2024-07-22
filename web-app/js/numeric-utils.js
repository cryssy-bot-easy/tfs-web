/**
	(revision)
	SCR/ER Number:
	SCR/ER Description: Loans Interest Rate
	[Revised by:] John Patrick C. Bautista
	[Date revised:] 08/24/2016
	Program [Revision] Details: Added global functions to be called as classes to format certain fields.
	Member Type: JS
	Project: tfs-web
	Project Name: numeric-utils.js
 */

function addCommas(numberToFormat) {
    numberToFormat += '';
    x = numberToFormat.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }

    return x1 + x2;
}

function formatCurrency(num) {
    if (num == undefined) {
        num = "0"
    }
    num = num.toString().replace(/\$|\,/g, '');
    if (isNaN(num)) num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10) cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
        num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
    return (((sign) ? '' : '-') + num + '.' + cents);
}

function formatCurrencyForComputation(num) {
    if (num == undefined) {
        num = "0"
    }
    num = num.toString().replace(/\$|\,/g, '');

    if (isNaN(num)) {num = "0";}

    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 10000 + 0.000050000000001);
    cents = num % 10000;
    num = Math.floor(num / 10000).toString();
    if (cents < 10){ cents = "000" + cents;} else
    if (cents < 100){ cents = "00" + cents;} else
    if (cents < 1000){ cents = "0" + cents;}

    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++) {
        num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
    }
    return (((sign) ? '' : '-') + num + '.' + cents);
}

// strips commas for numeric strings
function stripCommas(numberToStrip) {
   if (numberToStrip!=undefined){
	return numberToStrip.replace(/,/g,"");
	}
}

// formats value of display to fields with class numericCurrency
function formatCurrencyFields() {
    $(".numericCurrency").each(function() {
        if($(this).val() != "") {
            var new_value = formatCurrency($(this).val());
        }

        $(this).val(new_value);
    });
}

function initializeNumericFormats() {
    // set autonumeric for fields with class numericCurrency
    $(".numericCurrency").autoNumeric();
    //Bug #615
//    $(".numericCurrency").autoNumeric({vMax: '9999999999999999999.99'});
//    $(".numericRates").autoNumeric({vMax: '9999999999999999999.99999999'});
    $(".numericQuantity").autoNumeric({mDec: 0});
    $(".numericWholeQuantity").autoNumeric({aSep: "", mDec: 0});
    $(".numericPercentage").autoNumeric({mDec: 4});
    $(".numericRates").autoNumeric({mDec: 8});

    $(".numeric").keydown(function (e) {
        var e = event || evt; // for trans-browser compatibility
        var charCode = e.which || e.keyCode;
        if ((charCode > 31 && (charCode < 48 || charCode > 57)) && charCode != 190){
            return false;
        }
        return true;
    });
    
    $(".numericWithNumpad").keydown(function (e) {
        var e = event || evt; // for trans-browser compatibility
        var charCode = e.which || e.keyCode;
        if ((charCode > 31 && (charCode < 48 || charCode > 57)) && (charCode < 96 || charCode > 105) && charCode != 190){
            return false;
        }
        return true;
    });

    function overrideMaxlength(id){
    	var fieldId = '#' + id;
    	$(fieldId).removeAttr('maxlength');
    	$(fieldId).attr('maxlength','6');
    }

    $(".intRate").keydown(function (e) {
    	var id = $(this).attr('id');
    	overrideMaxlength(id);
	    if ( e.shiftKey == true ) { //no shift
	    	e.preventDefault();
	    }
	    if ( (e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105) //0-9, numpad 0-9
	    		|| e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 37 || e.keyCode == 39  //backspace, tab, left arrow, right arrow
	    		|| e.keyCode == 46 || e.keyCode == 190 || e.keyCode == 110 ) { //delete, period, decimal point
	    } else {
	        e.preventDefault();
	    }
	    if( $(this).val().indexOf('.') != -1
	    		&& (e.keyCode == 190 || e.keyCode == 110) ){ // one decimal only
	    	return false;
	    }
    });

    $(".appendDecimal").keydown(function (e) {
    	var id = $(this).attr('id');
    	overrideMaxlength(id);
	    if ( (e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105) ){//0-9, numpad 0-9
		    if( $(this).val().match(/^\d+$/) ){ // append decimal after if number was inputted
		    	var decimalDef = '.';
		    	$(this).val($(this).val() + decimalDef);
		    }
	    }
    });

    $(".appendZero").keyup(function (e) {
    	var id = $(this).attr('id');
    	overrideMaxlength(id);
	    var firstChar = $(this).val().substr(0, 1);
	    if ( e.keyCode == 190 || e.keyCode == 110 ) { //period, decimal point
		    if( $(this).val().charAt(0) === '.' // one occurence of decimal point
		    		&& firstChar === '.' ){ // append zero at the start
		    	var zeroDef = 0;
		    	$(this).val(zeroDef + $(this).val());
		    }
	    }
    });

    formatCurrencyFields();

    // fix when autonumeric fields are disabled
    $(".numericCurrency, .numericQuantity, .numericWholeQuantity, .numericPercentage, .numericRates").each(function(){
    	$(this).focus(function(){
    		if($(this).attr("readonly") == "readonly"){
    			$(this).blur();
    		}
    	});
    });
}

$(initializeNumericFormats);
