$(document).ready(function(){
	var wrapper_div=$("#popup_modeOfPaymentProceeds").attr("id");
	var div_bg=$("#mode_of_payment_proceeds_bg").attr("id");
	
	var pCash=$("#modeOfPaymentProceeds");
	var dCash=$(".display-casa-proceeds");
	var dIssuance=$(".display-issuance-of-mc");
	var dRemittanceSwift=$(".display-remittance-via-swift");
	var dRemittancePddts=$(".display-remittance-via-pddts");
	
	dCash.css("display", "none");
	dIssuance.css("display","none");
	dRemittanceSwift.css("display","none");
	dRemittancePddts.css("display","none");
	
	//for dataentry ua loan settlement tab hiding
	if(serviceType == 'UA Loan Settlement' || serviceType == 'UA_LOAN_SETTLEMENT'){
		$(".mt103Tab_data_entry").hide();
		$(".pddtsTab_data_entry").hide();
	}
	
	pCash.change(function(){
	
		if(pCash.val().toLowerCase()=="credit to casa"){
			dCash.css("display","block");
			dIssuance.css("display","none");
			dRemittanceSwift.css("display","none");
			dRemittancePddts.css("display","none");
			centerPopup(wrapper_div,div_bg);
		}else if(pCash.val().toLowerCase()=="issuance of mc"){
			dCash.css("display", "none");
			dIssuance.css("display","block");
			dRemittanceSwift.css("display","none");
			dRemittancePddts.css("display","none");
			centerPopup(wrapper_div,div_bg);
			
		}else if(pCash.val().toLowerCase()=="remittance via swift"){
			dCash.css("display", "none");
			dIssuance.css("display","none");
			dRemittanceSwift.css("display","block");
			dRemittancePddts.css("display","none");
			centerPopup(wrapper_div,div_bg);
			
			//for unhide tab
			$("#saveProceeds").click(function(){
				$(".mt103Tab_data_entry").show();
			});
			
			
//			$("#btnAlertNo").click(function(){
//				$("#mt103_tab_header").hide();
//			});
		}else if(pCash.val().toLowerCase()=="remittance via pddts"){
			dCash.css("display", "none");
			dIssuance.css("display","none");
			dRemittanceSwift.css("display","none");
			dRemittancePddts.css("display","block");			
			centerPopup(wrapper_div,div_bg);
			
			//for unhide tab
			$("#saveProceeds").click(function(){
				$(".pddtsTab_data_entry").show();
			});
			
//			$("#btnAlertNo").click(function(){
//				$("#pddts_tab_header").hide();
//			});
		}else {
			dCash.css("display", "none");
			dIssuance.css("display","none");
			dRemittanceSwift.css("display","none");
			dRemittancePddts.css("display","none");
			centerPopup(wrapper_div,div_bg);
		}
	});
	
	
});
	