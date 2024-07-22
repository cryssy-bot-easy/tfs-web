$(document).ready(function(){
	initPage();
	$("#partialCashSettlementFlagBox").click(changePartialCashSettlement);

	$("#cifNumberFlag ").click(changeCifNumber);

	$("#mainCifNumberFlag").click(changeMainCifNumber);

	$("#facilityIdFlag").click(changeFacilityId);
	

//    setPartialCashSettlementFlagValue();
    setAdjustableFields();
    changePartialCashSettlement();
});

function setAdjustableFields() {
    if($("#cifNumberTo").val() != "") {
        $("#cifNumberFlag").attr("checked", true);
        changeCifNumber();
    }
    if($("#mainCifNumberTo").val() != "") {
        $("#mainCifNumberFlag").attr("checked", true);
        changeMainCifNumber();
    }

    if($("#facilityIdTo").val() != "") {
        $("#facilityIdFlag").attr("checked", true);
        changeFacilityId();
    }
}

function initPage(){
	if ($("#partialCashSettlementFlagBox").attr('checked') != "checked" || $("#partialCashSettlementFlagBox") == 0){
		hideTabs();
	}
	$("#partialCashSettlementFlag").removeAttr('checked')
	//$("#cifNumberFlag").removeAttr('checked');
	//$("#mainCifNumberFlag").removeAttr('checked');
	//$("#facilityIdFlag").removeAttr('checked');
	$(".popup_btn_cif_normal").hide();
	$(".popup_btn_cif_main").hide();
	$(".popup_btn_facility").hide();
}

function hideTabs(){
	$(".charges_tab").remove();
	$(".charges_payment_tab").remove();
	$("#setupServicePayment").toggleClass("required", false)
	$(".cash_lc_payment_tab").each(function(){
		$(this).remove();
	});
	$("#setupProductPayment").toggleClass("required", false)
}

function hideTabs2(){
	$(".charges_tab").remove();
	$(".charges_payment_tab").remove();
	$("#setupServicePayment").toggleClass("required", false)
}

/*function showTabs(){
	$(".charges_tab").each(function(){
		$(this).show();
	});
	$(".charges_payment_tab").each(function(){
		$(this).show();
	});
	$("#setupServicePayment").toggleClass("required", true)
	$(".cash_lc_payment_tab").show();
	$("#setupProductPayment").toggleClass("required", true)
}*/

function changePartialCashSettlement(){
//    partialCashSettlementEnabled
	if ($("#partialCashSettlementFlagBox").attr("checked") == "checked"){
//		showTabs();
        $("#cashAmount").removeAttr("readonly").toggleClass("required", true);
        $("#cashLcAmountAsterisk").text("*");
        $("#partialCashSettlementFlag").val("partialCashSettlementEnabled");
	}else{
        $("#partialCashSettlementFlag").val("");
        $("#cashAmount").val("");
        $("#cashLcAmountAsterisk").text("");
        $("#cashAmount").attr("readonly", "readonly").toggleClass("required", false);
//		hideTabs();
	}
}

function setPartialCashSettlementFlagValue(nonPHPCount) {
    var partialCashSettlementFlag = $("#partialCashSettlementFlag").val();

    if(partialCashSettlementFlag == "partialCashSettlementEnabled") {
        $("#partialCashSettlementFlagBox").attr('checked', true);
//        var cashAmount = $("#cashAmount").val().replace(/,/g,"");
        $("#cashLcAmountAsterisk").text("*");
        if($("#cashAmount").val() != "0.00" && $("#cashAmount").val() != "" && nonPHPCount > 0) {
//            showTabs();
        } else {
        	hideTabs2();
        }
    }else{
    	$("#cashLcAmountAsterisk").text("");
    }
    changePartialCashSettlement();
}

function checkSettlementCurrency(){
	var ids = $("#grid_list_cash_payment_summary").jqGrid('getDataIDs');
	var nonPHPCount = 0
	for (var i = 0; i < ids.length; i++) 
	{
	    var rowId = ids[i];
	    var rowData = $('#grid_list_cash_payment_summary').jqGrid ('getRowData', rowId);
	    if(rowData.settlementCurrency != 'PHP'){
	    	nonPHPCount++;
	    }
	}
	setPartialCashSettlementFlagValue(nonPHPCount);
}

function changeCifNumber(){
	if ($("#cifNumberFlag").attr('checked')){
		$(".popup_btn_cif_normal").show();
		$("#cifNumberTo").toggleClass("required", true);
	}else{
		$(".popup_btn_cif_normal").hide();
		$("#cifNumberTo").val("").toggleClass("required", false);;
		$("#mainCifNumberTo").toggleClass("required", false);
		$("#facilityIdTo").toggleClass("required", false);
	}
}

function changeMainCifNumber(){
	if ($("#mainCifNumberFlag").attr('checked')){
		$(".popup_btn_cif_main").show();
	}else{
		$(".popup_btn_cif_main").hide();
		$("#mainCifNumberTo").val("");
	}
}

function changeFacilityId(){
	if ($("#facilityIdFlag").attr('checked')){
		$(".popup_btn_facility").show();
	}else{
		$(".popup_btn_facility").hide();
		$("#facilityIdTo").val("");
        $("#facilityReferenceNumberTo").val("");
	}
}


