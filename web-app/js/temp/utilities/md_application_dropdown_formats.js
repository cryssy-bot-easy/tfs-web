$(document).ready(function(){
	$(".md-casa").hide();
	$(".modeRefund").hide();
	$(".pn-number").hide();
	
	$("#modeOfRefundMd").change(function(){
		switch($(this).val().toLowerCase()){
		case 'credit casa':
			$(".md-casa").show();
			break;
		default:
			$(".md-casa").hide();
			break;
		}
	});
	
	$("#modeOfRefundMdApply").change(function(){
		if($("#modeOfRefundMdApply").val()=="Refund to Client"){
			$(".modeRefund").show();
			$(".pn-number").hide();
		}
		else if($("#modeOfRefundMdApply").val()=="Apply to Loan"){
			$(".pn-number").show();
			$(".modeRefund").hide();
			$(".md-casa").hide();
		}
		else{
			$(".modeRefund").hide();
			$(".pn-number").hide();
			$(".md-casa").hide();
		}
		
	});
});