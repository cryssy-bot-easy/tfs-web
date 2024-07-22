$(document).ready(function(){
	var oi_wrapper_div= $("#popup_updateChargesFxlcAmendment");
	var oi_wrapper_bg=$("#update_charges_fxlc_amendment_bg");
	
	$("#go").click(function(){
		if($("#paymentTransactionType").val().toLowerCase().indexOf('fxlc opening')>=0){
			oi_wrapper_div.width(925);
			mCenterPopup(oi_wrapper_div,oi_wrapper_bg);
			mLoadPopup(oi_wrapper_div,oi_wrapper_bg);
		}
	});
	
	$("#close_updateChargesFxlcAmendment1,#close_updateChargesFxlcAmendment2").click(function(){
		mDisablePopup(oi_wrapper_div,oi_wrapper_bg);
	});
});