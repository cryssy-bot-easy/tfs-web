/**
 * (revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 27, 2017
	[Date deployed:]
	Program [Revision] Details: Added new class datepicker_field3 for no future dates.
	PROJECT: WEB
	MEMBER TYPE  : JavaScript file
	Project Name: datepicker.js
	
 */

function createDatePicker(element) {
    var _dpdefaults = {
        showOn: 'both',
        buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
        changeMonth: true,
        changeYear: true,
        constrainInput:true,
        defaultDate:null,
        dateFormat:'mm/dd/yy'


    }
    element.datepicker(_dpdefaults);
}

$(function() {
	var _dpdefaults;
	$(".datepicker_field").each(function(){
		_dpdefaults={
				showOn: 'both',
				buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp	  
				changeMonth: true,
				changeYear: true,
				constrainInput:true,
				defaultDate:null,
				dateFormat:'mm/dd/yy'

            };
		
		if(($(this).attr("id").toUpperCase().match("EXPIRYDATE") && !($(this).attr("id").toUpperCase().match("LCEXPIRYDATE"))) ||
				($(this).attr("id").toUpperCase().match("MATURITYDATE") && !$(this).attr("id").toUpperCase().match("LOANMATURITYDATE"))){
			$.extend(_dpdefaults,{minDate: mindate});	
		}
		else if ($(this).attr("id").toUpperCase().match("LOANMATURITYDATE") && $("#valueDate").length > 0){
			$.extend(_dpdefaults,{minDate: $.datepicker.parseDate('mm/dd/yy', $("#valueDate").val())});	
		}	
		else if(($(this).attr("id").toUpperCase().match("ISSUEDATE") && !($(this).attr("id").toUpperCase().match("LCISSUEDATE"))) || 
				$(this).attr("id").toUpperCase().match("DATEOFBLAIRWAYBILL") || 
				$(this).attr("id").toUpperCase().match("VALUEDATE") || 
				$(this).attr("id").toUpperCase().match("NEGOTIATIONVALUEDATE")){
			$.extend(_dpdefaults,{maxDate: newDate});
		}

        else if($(this).attr("id").toUpperCase().match("DATEOFBIRTH") ||
            $(this).attr("id").toUpperCase().match("DATEOFINCORPORATION")){

            $.extend(_dpdefaults,{maxDate: newDate,yearRange: '-300:+0'});

        }


        else if($(this).attr("id").toUpperCase().match("AMENDMENTDATE") &&
				"undefined" !== typeof $("#expiryDate") && 
				"" != $("#expiryDate").val()){
			$.extend(_dpdefaults,{maxDate: $("#expiryDate").val()});
		}
		else if($(this).attr("id").match("latestShipmentDate")){
			$.extend(_dpdefaults,{maxDate: $("#expiryDate").val()});
		}
		$(this).datepicker(_dpdefaults);
		
	})
	.on("change",function(){
		if("" != $(this).val() && !$(this).val().match(/^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$/)){

            if($(this).attr("id").toUpperCase().match("DATEOFBIRTH") ||
               $(this).attr("id").toUpperCase().match("DATEOFINCORPORATION")) {}
            else{
            triggerAlertMessage("Not a valid Date.");
			$(this).val("");
            }

		}
	}).attr("readonly","readonly");	
	
	
	$(".datepicker_field2").datepicker(
				{showOn: 'both',
				buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp	  
				changeMonth: true,
				changeYear: true,
				constrainInput:true,
				defaultDate:null,
				dateFormat:'mm/dd/yy'})
	.on("change",function(){
		if(!$(this).val().match(/^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$/)){
            triggerAlertMessage("Not a valid Date.");
			$(this).val("");
		}
	});
	
});

$(function() {
	var _dpdefaults;
	$(".datepicker_field3").each(function(){
		_dpdefaults={
				showOn: 'both',
				buttonImage:$("#_datepickerImage").val(),  
				changeMonth: true,
				changeYear: true,
				constrainInput:true,
				defaultDate:null,
				yearRange: "-30:+0", // Up to 30 years minimum date
				maxDate: 0,
				dateFormat:'mm/dd/yy'
		};
		$(this).datepicker(_dpdefaults);
	})
});
// -- END