//global var to save params
var glb_srl_tab={
		params_before:'',
		params_after:''
};

$(function() {
	//Serialize data on tab to check if tab is dirty
	$(".ui-tabs-anchor").on("click",function(){
		if(typeof formId !== 'undefined'){
			glb_srl_tab.params_before=$("form"+formId,"div#body_forms").serialize();
		}
	});
	
	
	
	
	/*
	 	Deprecated: All datepicker fields must be readonly. (2/20/2013) - Ton
	 */
	//alert("DATEPICKER FILTER!")
//	
//	$('.datepicker_field').attr('maxLength','10').focusout(function() {
//	    $('span.error-keyup-5').remove();
//	    var inputVal = $(this).val();
//	    var inputValLength = inputVal.length;
//	    //inputVal.maxLength = 10;
//	    var dateReg = /^[0,1]?\d{1}\/(([0-2]?\d{1})|([3][0,1]{1}))\/(([1]{1}[9]{1}[9]{1}\d{1})|([2-9]{1}\d{3}))$/; //mm/dd/yyyy format
//	    //var dateReg = '/(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/';
//
//	    if((!dateReg.test(inputVal)) && (inputValLength == 10)) {
//	    	//alert('inputValLength = ' +inputValLength)
//	    	
//	    	$("#alertMessage").text("Invalid Date Format");
//	        triggerAlert();
//	        $(this).val("");
//	    }else if ((dateReg.test(inputVal)) && (inputValLength < 10)) {
//	    	//alert('inputValLength = ' +inputValLength)
//	    	
//	    	$("#alertMessage").text("Invalid Date Format");
//	        triggerAlert();
//	        $(this).val("");
//	    }
//	});
	
	
});

