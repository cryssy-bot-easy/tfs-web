$(function(){
	var details_charges_popup = "details_charges_popup";
	var details_charges_bg = "details_charges_bg";
	
	$("#details_charges").click(function(){
		$("#detailsOfChargesComment").val($("#detailsOfCharges").val());
		$("#detailsOfChargesComment").limitCharAndLines(35, 6);
		//centering with css
        centerPopup(details_charges_popup, details_charges_bg);
        //load popup
        loadPopup(details_charges_popup, details_charges_bg);
	});
	
	$(".details_charges_close").click(function(){
		$("#detailsOfChargesComment").val("");
		//disable popup
        disablePopup(details_charges_popup, details_charges_bg);
	});
	
	$("#detailsOfChargesPopupSave").click(function(){
		$("#detailsOfCharges").val($("#detailsOfChargesComment").val());
		//disable popup
        disablePopup(details_charges_popup, details_charges_bg);
	});
	
	$("#detailsOfChargesComment").limitCharAndLines(35, 6);
})