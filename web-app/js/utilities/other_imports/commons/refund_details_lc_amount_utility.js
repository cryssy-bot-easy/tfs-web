$(document).ready(function(){
	
	$("#partialAmountPopup").hide();
	$("#otherRefundPopup").hide();
	
	var refund_wrapper_div= $("#popup_partialAmountRefund");
	var refund_wrapper_bg=$("#popup_bg_partialAmountRefund");
	
	$("input[name=refundOption]:radio").change(function(){
		
		switch($(this).val().toString()){
		case "refundPartialAmount":
			$("#partialAmountForRefund").removeAttr("readonly","readonly");
			$("#partialAmountPopup").show();
			$("#otherRefund").attr("disabled","true");
			$("#otherRefundPopup").hide();
		
			break;
		
		case "refundOsAmount":
			$("#partialAmountForRefund").attr("readonly","readonly");
			$("#partialAmountPopup").hide();
			$("#otherRefund").attr("disabled","true");
			$("#otherRefundPopup").hide();
			
			break;
			
		case "refundOthers":
			
			//check value
			if($("#otherRefund").val() != ""){
				$("#otherRefundPopup").show();
			}else {
				$("#otherRefundPopup").hide();
			}
			
			//if value might change
			$("#otherRefund").change(function(){
				if($("#otherRefund").val() != ""){
					$("#otherRefundPopup").show();
				}else {
					$("#otherRefundPopup").hide();
				}
			});
			
			$("#otherRefund").removeAttr("disabled","true");
			$("#partialAmountForRefund").attr("readonly","readonly");
			$("#partialAmountPopup").hide();
			
			break;
		}
		
	});
	
	$("#partialAmountPopup").click(function(){
			refund_wrapper_div.width(800);
			mCenterPopup(refund_wrapper_div,refund_wrapper_bg);
			mLoadPopup(refund_wrapper_div,refund_wrapper_bg);
			
			
			// hide and disabled input fields for other refund 
			$(".other_refund_table").hide();
			$(".otherRefundTitle").hide();
			$(".partial_amount_table").show();
			$(".partialAmountRefundTitle").show();
			$(".partialRefundInput").removeAttr("disabled","disabled");
			$(".otherRefundInput").attr("disabled","disabled");
	});
	
	
	$("#otherRefundPopup").click(function(){
		refund_wrapper_div.width(800);
		mCenterPopup(refund_wrapper_div,refund_wrapper_bg);
		mLoadPopup(refund_wrapper_div,refund_wrapper_bg);
		
		
		// hide and disabled input fields for partial amount refund
		$(".partial_amount_table").hide();
		$(".partialAmountRefundTitle").hide();
		$(".other_refund_table").show();
		$(".otherRefundTitle").show();
		$(".partialRefundInput").attr("disabled","disabled");
		$(".otherRefundInput").removeAttr("disabled","disabled");
	});
	 

	$("#close_partialAmountRefund1,#close_partialAmountRefund2").click(function(){
		mDisablePopup(refund_wrapper_div,refund_wrapper_bg);
		
	});
	
});