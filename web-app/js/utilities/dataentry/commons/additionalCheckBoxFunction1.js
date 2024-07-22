$(document).ready(function (){
	
	var additionalConditionsVal = $("#additionalConditionsFrom").val();
	$("#additionalConditionsTo").attr("readonly","readonly");
	
	
	$("#additionalConditionsRow1").click(function (){
		if($("#additionalConditionsRow1").attr("checked") == "checked"){
			$("#additionalConditionsTo").removeAttr("readonly","readonly");
			$("#additionalConditionsTo").val(additionalConditionsVal);
		}else{
			$("#additionalConditionsTo").attr("readonly","readonly");
		}
	});
});