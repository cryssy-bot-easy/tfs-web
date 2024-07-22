$(document).ready(function(){
	var chargesTab = $("#charges_tab");
	var chargesPaymentTab = $("#charges_payment_tab");
	var cashLcPaymentTab = $("#cash_lc_payment_tab");
	var partialCashSettlement = $("#partialCashSettlementCheckBox");
	initPage();
	getStatusPartialSettlement.click(getStatusPartialCashSettlement);
});

function hideTabs(){
	chargesTab.hide();
	chargesPaymentTab.hide();
	$("#setupServicePayment").toggleClass("required", false)
	cashLcPaymentTab.hide();
	$("#setupProductPayment").toggleClass("required", false)
}

function showTabs(){
	chargesTab.show();
	chargesPaymentTab.show();
	$("#setupServicePayment").toggleClass("required", true)
	cashLcPaymentTab.show();
	$("#setupProductPayment").toggleClass("required", true)
}

function initPage(){
	hideTabs();
	partialCashSettlement.attr("checked","false");
}

function getStatusPartialCashSettlement(){
	if (partialCashSettlement.attr("checked","checked")){
		showTabs();
	}else{
		hideTabs();
	}
}


//function asdf(){
//	//**************BASIC DETAILS****************\\
//	
//	//********************CIF********************\\
//	$("#cifNumberTo").attr("readonly", "readonly");
//	$("#cif_search").hide();
//
//	$("#cifNumberCheckBox").change(function(){
//		if($(this).val() == "cifNumberEnabled"){
//			if( ($("#cifNumberTo").attr("readonly")) && ($("#cif_search").hide()) ){
//				$("#cifNumberTo").removeAttr("readonly");
//				$("#cif_search").show();
//			} else{
//				$("#cifNumberTo").attr("readonly", "readonly");
//				$("#cif_search").hide();
//			}
//		} 
//	});
//	
//	//******************MAIN CIF******************\\
//	$("#mainCifNumberTo").attr("readonly", "readonly");
//	$("#main_cif_search").hide();
//
//	$("#mainCifNumberCheckBox").change(function(){
//		if($(this).val() == "mainCifNumberEnabled"){
//			if( ($("#mainCifNumberTo").attr("readonly")) && ($("#main_cif_search").hide()) ){
//				$("#mainCifNumberTo").removeAttr("readonly");
//				$("#main_cif_search").show();
//			} else{
//				$("#mainCifNumberTo").attr("readonly", "readonly");
//				$("#main_cif_search").hide();
//			}
//		} 
//	});
//	
//	//*****************FACILTY ID*****************\\
//	$("#facilityIdTo").attr("disabled", true);
//	$("#facility_id_search").hide();
//
//	$("#facilityIdCheckBox").change(function(){
//		if($(this).val() == "facilityIdEnabled"){
//			if( ($("#facilityIdTo").attr("disabled")) && ($("#facility_id_search").hide()) ){
//				$("#facilityIdTo").removeAttr("disabled");
//				$("#facility_id_search").show();
//			} else{
//				$("#facilityIdTo").attr("disabled", true);
//				$("#facility_id_search").hide();
//			}
//		} 
//	});
//	//************END BASIC DETAILS**************\\
//	
//	var value1 = $("#partialCashSettlementCheckBox");
//	var value2 = $("#type");
//	var block1 = $(".display_charges_payment_tab");
//	var block2 = $(".display_cash_lc_tab");
//	
//	block1.css("display", "none");
//	block2.css("display", "none");
//	
//	//DISPLAY CHARGES PAYMENT & CASH LC TAB
//	value1.change(function(){
//				
//		if(value1.val() == "partialCashSettlementEnabled"){
//			if(block1.css("display")=="none"){
//				block1.css("display","block");
//			}
//			else block1.css("display","none");
//		}
//		
//		if((value1.val() == "partialCashSettlementEnabled") && (value2.val() == "Regular")){
//			
//			if(block2.css("display")=="none"){
//				block2.css("display","block");
//			}
//			else block2.css("display","none");
//		}
//		
//	});	
//	
//		
//	$("#settlementCurrencyCharges").change(function(){
//		$(".trans_currency2").val($(this).val());
//	});
//	
//	$("#settlementCurrencyCashLc").change(function(){
//		$(".trans_currency3").val($(this).val());
//	});
}