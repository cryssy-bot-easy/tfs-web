//jquery function to disable inputs and hide <tr>
(function ($) {
	$.fn.show_charge = function(){
		$(this).show();
		$(this).find("input:text").removeAttr("disabled");
	}
	
	$.fn.hide_charge = function(){
		$(this).find("input:text").attr("disabled","disabled");
		$(this).hide();
	}
}(jQuery));


$(document).ready(function(){
	var oe_wrapper_div= $("#popup_other_export_charges_payment"),
		oe_wrapper_bg=$("#popup_bg_other_export_charges_payment"),
	
	//declare <tr> classes to hide/show
		oe_eaf	=	$(".oe-export-fxlc-advising-fee"),
		oe_bc	=	$(".oe-bank-commission"),
		oe_cf	=	$(".oe-cilex-fee"),
		oe_ds	=	$(".oe-documentary-stamp"),
		oe_cbf	=	$(".oe-cable-fee"),
		oe_po	=	$(".oe-postage"),
		oe_rf	=	$(".oe-remittance-fee"),
		oe_adv	=	$(".oe-advance-corres-charges"),
		oe_ai	=	$(".oe-advance-interest"),
		oe_oc	=	$(".oe-other-local-bank-charges"),
		oe_add	=	$(".oe-additional-corres-charges"),
		oe_cc	=	$(".oe-client-charges"),
		oe_ch	=	$(".oe-charges");
	
	
	$("#go").click(function(){
		if($("#paymentTransactionType").val() == '') return false;
			evaluateExportChargesFields();
			oe_wrapper_div.width(925);
			mCenterPopup(oe_wrapper_div,oe_wrapper_bg);
			mLoadPopup(oe_wrapper_div,oe_wrapper_bg);
	});
	
	$("#close_other_export_charges_payment,#close_other_export_charges_payment2").click(function(){
		mDisablePopup(oe_wrapper_div,oe_wrapper_bg);
	});
	
	
	//show/hide fields according to selected transaction type
	function evaluateExportChargesFields(){
		$("table#charges_list table.charges_table tr").hide_charge();
		switch($("#paymentTransactionType").val().toLowerCase()){
		case "advise on opening":
		case "advise on amendment":
		case "advise on cancellation":
			oe_ch.show_charge();
			oe_cc.show_charge();
			oe_eaf.show_charge();
			oe_cbf.show_charge();
			oe_oc.show_charge();
			$("span.export-title").text("Bank");
			break;
		case "export bills for purchase - negotiation":
			oe_ch.show_charge();
			oe_adv.show_charge();
		case "domestic bills for purchase - negotiation":
			oe_ch.show_charge();
			oe_ai.show_charge();
		case "domestic bills for collection - settlement":
		case "export bills for collection - settlement":
			oe_ch.show_charge();
			oe_po.show_charge();
			oe_rf.show_charge();
		case "export advance - payment":
			oe_ch.show_charge();
			oe_bc.show_charge();
			oe_ds.show_charge();
			oe_cf.show_charge();
			break;
		case "domestic bills for purchase - settlement":
			oe_cc.show_charge();
			oe_oc.show_charge();
			$("span.export-title").text("Local Bank's");
			break;
		case "export bills for purchase - settlement":
			oe_cc.show_charge();
			oe_add.show_charge();
			break;
		case "export advance - refund":
			oe_ch.show_charge();
			oe_bc.show_charge();
			oe_cbf.show_charge();
			break;
		}
	}
	
	
	
	
});


