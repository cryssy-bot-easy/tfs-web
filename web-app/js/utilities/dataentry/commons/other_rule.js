$(document).ready(function confirmedThis(){
	
	$(".ifOtherRule1").css("display","none");
	$(".ifOtherRule2").css("display","none");
	$(".ifOtherRuleFrom").css("display","none");
	$(".ifOtherRuleTo").css("display","none");
	
	$("#applicableRulesFrom").change(function(){
		
		//alert('hey');
		if($(this).val().toLowerCase()=="others"){
			$(".ifOtherRule").css("display","block");
			$(".ifOtherRuleFrom").css("display","block");
			$(".ifOtherRule1").css("display","block");
			$(".ifOtherRule2").css("display","none");
		}

		if($(this).val().toLowerCase()!="others"){
			$(".ifOtherRule").css("display","none");
			$(".ifOtherRuleFrom").css("display","none");
			$(".ifOtherRule1").css("display","none");
		}
		
	})
	
	$("#applicableRulesTo").change(function(){
		
		if($(this).val().toLowerCase()!="others"){
			$(".ifOtherRule").css("display","none");
			$(".ifOtherRuleTo").css("display","none");
			$(".ifOtherRule2").css("display","none");
		}
		
		if($(this).val().toLowerCase()=="others"){
			$(".ifOtherRule").css("display","block");
			$(".ifOtherRuleTo").css("display","block");
			$(".ifOtherRule1").css("display","none");
			$(".ifOtherRule2").css("display","block");

		}
		
	})
	
});