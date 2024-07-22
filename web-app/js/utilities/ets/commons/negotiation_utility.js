$(document).ready(function(){
	if(loggedInUser!="TSD"){
		$("#valueDate").datepicker({
			showOn: 'both',
			buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp	  
			changeMonth: true,
			changeYear: true,
			constrainInput:true,
			defaultDate:null,
			dateFormat:'mm/dd/yy'
		}).attr("readonly","readonly");
		
		$("#valueDate").datepicker("option", "maxDate", $("#etsDate").val());
	}
});

