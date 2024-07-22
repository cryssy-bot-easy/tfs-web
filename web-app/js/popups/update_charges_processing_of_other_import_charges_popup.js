function loadFxlcOpeningDetails(){
	var wrapper_div=$("#popup_updateChargesFxlcOpening").attr("id");
	var div_bg=$("#update_charges_fxlc_opening_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='FXLC Opening'){
			$("#popup_header_updateChargesFxlcOpening").text("Update Charges");
			$("#popup_updateChargesFxlcOpening").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesFxlcOpening1, #close_updateChargesFxlcOpening2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadDmlcOpeningDetails(){
	var wrapper_div=$("#popup_updateChargesDmlcOpening").attr("id");
	var div_bg=$("#update_charges_dmlc_opening_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='DMLC Opening'){
			$("#popup_header_updateChargesDmlcOpening").text("Update Charges");
			$("#popup_updateChargesDmlcOpening").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesDmlcOpening1, #close_updateChargesDmlcOpening2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_dmlc_opening").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadFxlcAdjustmentDetails(){
	var wrapper_div=$("#popup_updateChargesFxlcAdjustment").attr("id");
	var div_bg=$("#update_charges_fxlc_adjustment_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='FXLC Adjustment'){
			$("#popup_header_updateChargesFxlcAdjustment").text("Update Charges");
			$("#popup_updateChargesFxlcAdjustment").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesFxlcAdjustment1, #close_updateChargesFxlcAdjustment2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_fxlc_adjustment").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadFxlcAmendmentDetails(){
	var wrapper_div=$("#popup_updateChargesFxlcAmendment").attr("id");
	var div_bg=$("#update_charges_fxlc_amendment_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='FXLC Amendment'){
			$("#popup_header_updateChargesFxlcAmendment").text("Update Charges");
			$("#popup_updateChargesFxlcAmendment").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesFxlcAmendment1, #close_updateChargesFxlcAmendment2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_fxlc_amendment").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadDmlcAmendmentDetails(){
	var wrapper_div=$("#popup_updateChargesDmlcAmendment").attr("id");
	var div_bg=$("#update_charges_dmlc_amendment_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='DMLC Amendment'){
			$("#popup_header_updateChargesDmlcAmendment").text("Update Charges");
			$("#popup_updateChargesDmlcAmendment").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesDmlcAmendment1, #close_updateChargesDmlcAmendment2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_dmlc_amendment").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadFxlcNegotiationDetails(){
	var wrapper_div=$("#popup_updateChargesFxlcNegotiation").attr("id");
	var div_bg=$("#update_charges_fxlc_negotiation_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='FXLC Negotiation'){
			$("#popup_header_updateChargesFxlcNegotiation").text("Update Charges");
			$("#popup_updateChargesFxlcNegotiation").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesFxlcNegotiation1, #close_updateChargesFxlcNegotiation2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_fxlc_negotiation").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadDmlcNegotiationDetails(){
	var wrapper_div=$("#popup_updateChargesDmlcNegotiation").attr("id");
	var div_bg=$("#update_charges_dmlc_negotiation_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='DMLC Negotiation'){
			$("#popup_header_updateChargesDmlcNegotiation").text("Update Charges");
			$("#popup_updateChargesDmlcNegotiation").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesDmlcNegotiation1, #close_updateChargesDmlcNegotiation2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_dmlc_negotiation").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadBgbeIssuanceChargesDetails(){
	var wrapper_div=$("#popup_updateChargesBgbeIssuanceCharges").attr("id");
	var div_bg=$("#update_charges_bgbe_issuance_charges_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='BG/BE Issuance Charges'){
			$("#popup_header_updateChargesBgbeIssuanceCharges").text("Update Charges");
			$("#popup_updateChargesBgbeIssuanceCharges").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesBgbeIssuanceCharges1, #close_updateChargesBgbeIssuanceCharges2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_bgbe_issuance_charges").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function loadBgCancellationChargesDetails(){
	var wrapper_div=$("#popup_updateChargesBgCancellationCharges").attr("id");
	var div_bg=$("#update_charges_bg_cancellation_charges_bg").attr("id");
	
	$("#update_charges_processing_of_other_import_charges").click(function(){
		if($("#paymentTransactionType").val()=='BG Cancellation Charges'){
			$("#popup_header_updateChargesBgCancellationCharges").text("Update Charges");
			$("#popup_updateChargesBgCancellationCharges").height("auto");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
		}
	});

	$("#close_updateChargesBgCancellationCharges1, #close_updateChargesBgCancellationCharges2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#confirm_bg_cancellation_charges").click(function(){
		disablePopup(wrapper_div,div_bg);
		openPopupX();
	});
}

function initUpdateChargesProcessingOfOtherImportChargesPopup(){
	loadFxlcOpeningDetails();
	loadDmlcOpeningDetails();
	loadFxlcAdjustmentDetails();
	loadFxlcAmendmentDetails();
	loadDmlcAmendmentDetails();
	loadFxlcNegotiationDetails();
	loadDmlcNegotiationDetails();
	loadBgbeIssuanceChargesDetails();
	loadBgCancellationChargesDetails();
}	
	
$(initUpdateChargesProcessingOfOtherImportChargesPopup);