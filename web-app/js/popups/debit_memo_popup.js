$(document).ready(function() {
	var popup_debit_memo_div = $('#debitMemoPopup');
	var popup_debit_memo_bg = $('#popupBackground_debit_memo');
	
	$("#viewDebitMemoPayment").click(function() {
		$("#accountNameProduct1, #accountNameProduct2, #accountNameProduct3, #accountNameCharges1, #accountNameCharges2, #accountNameCharges3").each(function(){
			$(this).val("");
		});
		mCenterPopup(popup_debit_memo_div, popup_debit_memo_bg);
		mLoadPopup(popup_debit_memo_div, popup_debit_memo_bg);
	});
	
	$(".popupClose_debit_memo").click(function() {
		mDisablePopup(popup_debit_memo_div, popup_debit_memo_bg);
	});
});

