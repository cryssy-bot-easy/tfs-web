//@js/gsp
function generatePddtsReport(){
			
	var tmpPddtsReportUrl = pddtsReportUrl;
	
	tmpPddtsReportUrl += "?fundingReferenceNumber=" + $("#fundingReferenceNumber").val();
	tmpPddtsReportUrl += "&documentNumber=" + $("#documentNumber").val();
	tmpPddtsReportUrl += "&swift=" + $("#swift").val();
	tmpPddtsReportUrl += "&bank=" + $("#bank").val();
	tmpPddtsReportUrl += "&beneficiary=" + $("#beneficiary").val();
	tmpPddtsReportUrl += "&pddtsAccountNumber=" + $("#pddtsAccountNumber").val();
	tmpPddtsReportUrl += "&byOrder=" + $("#byOrder").val();
	tmpPddtsReportUrl += "&negotiationCurrency=" + $("#negotiationCurrency").val();
	tmpPddtsReportUrl += "&pddtsAmount=" + $("#pddtsAmount").val();
	tmpPddtsReportUrl += "&remittanceFeeCurrency2=" + $("#remittanceFeeCurrency2").val();
	tmpPddtsReportUrl += "&remittanceFee2=" + $("#remittanceFee2").val();
	tmpPddtsReportUrl += "&totalAmountCurrency=" + $("#totalAmountCurrency").val();
	tmpPddtsReportUrl += "&totalAmount=" + $("#totalAmount").val();
	tmpPddtsReportUrl += "&documentType=" + $("#documentType").val();		
	tmpPddtsReportUrl += "&documentSubType1=" + $("#documentSubType1").val();		
	tmpPddtsReportUrl += "&documentClass=" + $("#documentClass").val();		
	tmpPddtsReportUrl += "&serviceType=" + $("#serviceType").val();	
	tmpPddtsReportUrl += "&authorizedSignatory1=" + $("#authorizedSignatory1").val();
	tmpPddtsReportUrl += "&authorizedSignatory1Position=" + $("#authorizedSignatory1Position").val();
	tmpPddtsReportUrl += "&authorizedSignatory2=" + $("#authorizedSignatory2").val();
	tmpPddtsReportUrl += "&authorizedSignatory2Position=" + $("#authorizedSignatory2Position").val();

	window.open(tmpPddtsReportUrl);

}

function showPddtsMt103Report() {
	var mt103 = false;
	var pddts = false;
	
	var gridDataProceedsTeller = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
	
	$.each(gridDataProceedsTeller,function(idx, data) {
		if(data.modeOfPayment.indexOf("PDDTS") != -1){
			$(".viewPddts").attr("id", "viewPddtsReport");
			$(".viewPddts").removeClass("disablePddts");
			mt103 = false;
			pddts = true;
		}
		else if(data.modeOfPayment.indexOf("SWIFT") != -1){
			$(".viewMt103").removeClass("disableMt103");
			$(".viewMt103").attr("onclick", "goToViewMt(103)");
			mt103 = true;
			pddts = false;
		}
		else {
			mt103 = false;
			pddts = false;
		}
	});
		
	if (mt103 == false && pddts == true){
		$(".viewMt103").removeAttr("action");
		$(".viewMt103").addClass("disableMt103");
		$(".viewMt103").removeAttr("onclick");
	}
	else if (mt103 == true && pddts == false){
		$(".viewPddts").removeAttr("id");
		$(".viewPddts").addClass("disablePddts");
	}
	else {
		$(".viewMt103").removeAttr("onclick");
		$(".viewMt103").addClass("disableMt103");
		$(".viewPddts").removeAttr("id");
		$(".viewPddts").addClass("disablePddts");
	}
}

$(document).ready(function() {
//	$("#grid_list_proceeds_payment_summary").mouseover(showPddtsMt103Report);
	
	if(referenceType == "DATA_ENTRY" && mt103Flag == "Y") {
		$(".viewMt103").removeClass("disableMt103");
	} else if (referenceType == "DATA_ENTRY" && mt103Flag == "N") {
		$(".viewMt103").removeAttr("id");
	}
	
	$("#viewPddtsReport").live("click",function(){	
		openPddtsPopUp();
	});
});