function changeFormatType() {
    if($("#formatType").val()) {
        $.post(documentFormatUrl, {formatCode: $("#formatType").val()}, function(data) {
        	$("#detailsOfGuaranteeDisplay").html(data.documentFormat);
        	$("#detailsOfGuarantee").val(data.documentFormat);
        	
        	 formatTags();
        });
    } else {
    	$("#detailsOfGuaranteeDispay").html("");
        $("#detailsOfGuarantee").val("");
   
    }
    
   
    function formatTags(){
    	var myChangeVal = $("#detailsOfGuarantee").val().replace(/<br\s*\/?>/mg,"\n");
    	
    	$("#detailsOfGuaranteeDisplay2").val(myChangeVal);
    	$("#detailsOfGuarantee").val(myChangeVal);
    	
    }
}

function changeFormatTypeTo() {
    if($("#formatTypeTo").val()) {    	
        $.post(documentFormatUrl, {formatCode: $("#formatTypeTo").val()}, function(data) {
        	$("#detailsOfGuaranteeDisplayTo").html(data.documentFormat);
            $("#detailsOfGuaranteeTo").val(data.documentFormat);
        });
    } else {
    	
    	$("#detailsOfGuaranteeDisplayTo").val("");
        $("#detailsOfGuaranteeTo").val("");
    }
}

$(document).ready(function (){	
	var detailsGuaranteeVal = $("#detailsGuaranteeFrom").val();
	//
	var oldVal ="";
	//$("#detailsOfGuarantee").val("");
	//$("#detailsOfGuaranteeDisplay2").val("");
	
	$("#detailsGuaranteeTo").attr("readonly","readonly");
	$("#formatTypeTo").attr("disabled","disabled");
	
	
	$("#detailsGuarantee").click(function(){
		
		if($("#detailsGuarantee").attr("checked")=="checked"){
			$("#formatTypeTo").removeAttr("disabled");
			$("#detailsGuaranteeTo").removeAttr("readonly");
			//$("#detailsGuaranteeTo").val(detailsGuaranteeVal);
			
		}else{
			$("#formatTypeTo").attr("disabled","disabled");
			$("#detailsGuaranteeTo").attr("readonly","readonly");			
		}
	});	
	
	
	$("#formatType").change(changeFormatType);
	
	$("#formatTypeTo").change(changeFormatTypeTo);
	$("#detailsOfGuaranteeDisplay").keyup(function(){
		$("#detailsOfGuarantee").val($(this).html());
	}).keydown(function(){
		$("#detailsOfGuarantee").val($(this).html());
	});

	
	$(".txtAreaDetailsOfGuarantee").on("change keyup paste", function(){
		var currentVal = $(this).val();
		if(currentVal == oldVal){
			return;
		}
		oldVal = currentVal;
		$("#detailsOfGuarantee").val(oldVal);

	});
});