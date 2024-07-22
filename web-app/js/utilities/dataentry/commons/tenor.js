$(document).ready(function confirmedThis(){
	
	$("#tenorFrom").change(function(){
		
		if($("#tenorFrom").val().toLowerCase()=="sight" && $("#tenorTo").val().toLowerCase()=="usance"){
			$("#tenorNarrative").css("display","block");
		}

		if($(this).val().toLowerCase()!="sight"){
			$("#tenorNarrative").css("display","none");
		}
		
	})
	
	$("#tenorTo").change(function(){
		
		//alert('hey');
		if($("#tenorFrom").val().toLowerCase()=="sight" && $("#tenorTo").val().toLowerCase()=="usance"){
			$("#tenorNarrative").css("display","block");
		}

		if($(this).val().toLowerCase()!="usance"){
			$("#tenorNarrative").css("display","none");
		}
		
	})
	
});