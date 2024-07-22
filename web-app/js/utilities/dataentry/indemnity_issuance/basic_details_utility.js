$(document).ready(function (){
	$(".ifBySeaRadio").hide();
	$("#transportMedium").change(function(){

		if($(this).val().toLowerCase()=="by sea"){
			$(".ifBySeaRadio").show();
		}else{
			$(".ifBySeaRadio").hide();
		}
	}
			
	);
	
	if($("#documentSubType1").val().toLowerCase()=="cash"){
		$("#withExpiredTrLineDate").val("N/A");
	}else if($("#documentSubType1").val().toLowerCase()=="regular"){
		$("#withExpiredTrLineDate").val("\"extracted from sibs~~\"");
	}else{
		
	}
});