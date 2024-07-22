$(document).ready(function (){
	
	var listUALoanPaymentUrlFX = '';
	var gridListFX = $('#grid_list_ua_loan_payment_summary_fx');
	var idx = "1";
	var tempIdx=parseInt(idx);
	//count grid row
	var fxGridRowNum = $(gridListFX).getRowData().length;
	//initializing values
	var totalPayment = $("#totalPaymentChargesSettlement");
	var settlementAmount = $("#amountUaLoanSettlementPayment");
	var settlementCurrency = $("#amountSettlementCurrency");
	var cashLcCurrency = $("#amountLcCurrency");
	var fxlcAmount = $("#amountUaLoanLcPayment");
	var modeValue = $("#modeOfPaymentUsance");
	//for charges
	var cilex= $(".cilex");
	var docStamp = $(".documentary_stamp");
	var cilexText = $('.cilexText');
	var docStampText = $('.docStampText');
	
	
	//for popup disable
	var wrapper_div=$("#popup_modeOfPaymentUaLoan").attr("id");
	var div_bg=$("#mode_of_payment_ua_loan_bg").attr("id");

	if(documentType == 'FOREIGN'){
		cilex.hide();
		docStamp.hide();
		cilexText.attr("disabled","true");
		docStampText.attr("disabled","true");
		$(".row-total").hide();
		$(".charges_title").hide();
	}
	
	
	setupJqGridWidth('grid_list_ua_loan_payment_summary_fx', {width : 780, height: 72, loadui: "disable", scrollOffset : 0},
			[ [ 'modeOfPayment', 'MODE OF PAYMENT', 120, 'center'],
			[ 'cashLc', 'Cash LC Currency',100, 'center'],	
			[ 'amountLc', 'AMOUNT (in LC currency)',150, 'right'],		
			[ 'settlementCurrency', 'SETTLEMENT CURRENCY',120, 'center'],
			[ 'amountSettlement', 'AMOUNT (in settlement currency)',170, 'right'],
			[ 'editPayment', 'Edit',60, 'center'],
			[ 'deletePayment', 'Delete',60,'center'] ], listUALoanPaymentUrlFX);

	
	
	$("#save_modeOfPaymentUsance").click(function (){
		if(modeValue.val() == ""){
			alert("Please Select Mode Of Payment!");
			
		}else{
			var amountCurrency = $("#amountSettlementCurrency").val();
			
//					addToPaymentSummaryFx();
					$(".display-casa-ua-loan").css("display", "none");
					$(".display-tr-loan").css("display", "none");
					$(".display-check-ua_loan").css("display", "none");
					$(".display-cash-ua_loan").css("display", "none");
					$(".display-apply-ap-ua_loan").css("display", "none");
					$(".display-remittance-ua_loan").css("display", "none");
					$(".display-ap-balance2_ua_loan").css("display", "none");
					$(".display-ap-balance1_ua_loan").css("display", "none");
					
					if(amountCurrency != "php" && $("#modeOfPaymentUsance").val().toLowerCase() == "cash"){
						cilex.show();
						cilexText.removeAttr("disabled","true");
						$(".row-total").show();
						$(".charges_title").show();
					}
					
					if($("#modeOfPaymentUsance").val().toLowerCase()=="tr loan"){
						docStamp.show();
						docStampText.removeAttr("disabled","true");
						$(".row-total").show();
						$(".charges_title").show();
					}
					$(".usancePopUpButton").css("display", "none");
					$("#modeOfPaymentUsance").val("");
					disablePopup(wrapper_div,div_bg);
					$('.popup_container').css("width","380px");

			}
		
		});
	
	
//	function addToPaymentSummaryFx(){
//		var modeText = modeValue.val();
//		var amount = fxlcAmount.val();
//	//	var totalTemp = parseFloat(amount);
//			if (fxGridRowNum == "3") {
//				alert('You can only Have 3 Payment Records');
//			}else{
//				if(modeValue.val().toLowerCase()=="credit to casa"){
//					modeText = "CASA"
//
//					//alert(settlementAmount.val()+"="+settlementCurrency.val());
//					gridListFX.addRowData(tempIdx, {modeOfPayment:modeText, amountSettlement:settlementAmount.val(), settlementCurrency:settlementCurrency.val(), cashLc:cashLcCurrency.val(), amountLc:fxlcAmount.val(), editPayment:"<a href=\"javascript:void(0)\" class=\"editRecord\" style=\"color: blue\">edit</a>", deletePayment:"<a href=\"javascript:void(0)\" class=\"deleteRecords\"  style=\"color: red\">delete</a>" });
//					fxGridRowNum = fxGridRowNum + 1;
//					//alert(tempIdx);
//					tempIdx++;
//
//
//				//	totalTemp = parseFloat(totalTemp) + parseFloat(amount);
//				//	alert(totalTemp);
//
//				}else{
//					gridListFX.addRowData(tempIdx, {modeOfPayment:modeText.toUpperCase(), amountSettlement:settlementAmount.val(), settlementCurrency:settlementCurrency.val(), cashLc:cashLcCurrency.val(), amountLc:fxlcAmount.val(), editPayment:"<a href=\"javascript:void(0)\" class=\"editRecord\"  style=\"color: blue\">edit</a>", deletePayment:"<a href=\"javascript:void(0)\" class=\"deleteRecords\" style=\"color: red\">delete</a>" });
//					fxGridRowNum = fxGridRowNum + 1;
//					//alert(tempIdx);
//					tempIdx++;
//
//
//				//	totalTemp = parseFloat(totalTemp) + parseFloat(amount);
//					//alert(totalPayment.val(totalTemp));
//				}
//			}
//	}
	
	$(".deleteRecords").live("click", function(){
		
		var confirming = confirm("Are you sure you want to Delete this record?");
		
		if(confirming){
			$(this).parent().parent().remove();
	        alert("Record Deleted!");
	        fxGridRowNum = fxGridRowNum-1;
		}else{
			alert("Delete Canceled!");
		}
	});	
});


//$(".jqgrow").mouseover(function (){
//var row_id = $('#grid_list_ua_loan_payment_summary_fx').jqGrid('getDataIDs');
//var cellValue = $("#grid_list_ua_loan_payment_summary_fx").jqGrid('getCell', rids, 'modeOfPayment');
//
//
//var rowData=$(gridListFX).jqGrid("getRowData",tempIdx);
//var rowId = $(this).attr("id");
//var rowData=$('#'+id).jqGrid("getRowData",rowId)
//$(".editRecord").live("click", function(){
	//alert(rowId);
//});
//});	



//$(".editRecord").live("click", function(){
//var row_id = $('#grid_list_ua_loan_payment_summary_fx').jqGrid('getDataIDs');


//var stringId = row_id.toString();
//var splitId = stringId.split('\,');
//for(var i=0; i<splitId.length; i++){
//	var rowDataId = splitId[i];
//}
//function updateRowData(rowData){
//	alert(rowData.modeOfPayment);
//}
//var cellValue = $("#grid_list_ua_loan_payment_summary_fx").jqGrid('getCell', row_id, 'modeOfPayment');	

//alert(row_id);

//});