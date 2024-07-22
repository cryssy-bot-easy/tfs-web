
//////////////////////
//COMMENTED OUT SABI NI TONG DI NAMAN KELANGAN
////////////////////


//$(document).ready(function (){
//	
//	if(documentSubType1 == 'STANDBY'){
//		
//		standbyFunction();
//		
//	}
//		
//	if(documentSubType1 == 'REGULAR'){
//		
//		regularFunction();
//		
//	} 
//	
//	if(documentSubType1 == 'CASH'){
//		
//		cashFunction();
//		
//	}
//	
//	
//});

////all utility for standby
//function standbyFunction(){
//	var otherRule = "\'OTHR\' - THE GUARANTEE IS SUBJECT TO ANOTHER SET OF RULES, WHICH MUST BE SPECIFIED IN NARRATIVE (2ND SUBFIELD)"
//	$("#otherRule").attr("disabled","disabled");
//	$(".other_rule").hide();
//		
//	$("#applicableRules").change(function(){
//		if($("#applicableRules").val().toUpperCase() == otherRule){
//				$(".other_rule").show();
//				$("#otherRule").removeAttr("disabled","disabled");
//			}else{
//				$(".other_rule").hide();
//				$("#otherRule").attr("disabled","disabled");
//			}
//
//		});
//	
//}
//
//
////all utitlity for regular
//function regularFunction(){
//	var otherRuleReg = "\'OTHR\' - OTHR"
//		$("#otherRule").attr("disabled","disabled");
//		$(".other_rule").hide();
//			
//		$("#applicableRules").change(function(){
//			if($("#applicableRules").val().toUpperCase() == otherRuleReg){
//					$("#otherRule").removeAttr("disabled","disabled");
//					$(".other_rule").show();	
//			}else{
//					$("#otherRule").attr("disabled","disabled");
//					$(".other_rule").hide();
//				}
//
//			});
//
//	
//}
//
////all utitlity for cash
//function cashFunction(){
//	var otherRuleCash = "\'OTHR\' - OTHR"
//		$("#otherRule").attr("disabled","disabled");
//		$(".other_rule").hide();
//			
//		$("#applicableRules").change(function(){
//			if($("#applicableRules").val().toUpperCase() == otherRuleCash){
//					$(".other_rule").show();
//					$("#otherRule").removeAttr("disabled","disabled");
//				}else{
//					$(".other_rule").hide();
//					$("#otherRule").attr("disabled","disabled");
//				}
//
//			});
//
//	
//}