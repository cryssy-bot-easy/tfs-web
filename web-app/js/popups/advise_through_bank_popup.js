$(function(){
	var adviseDiv = $("#advise_through_bank_popup").attr("id");
	var adviseBg = $("#advise_through_bank_bg").attr("id");
	$("#adviseThroughBankPopup").click(function(){
		$("#adviseThroughBankComment").val($("#adviseThroughBankNameAndAddress").val());
		$("#adviseThroughBankComment").val($("#adviseThroughBankNameAndAddress").val());
		centerPopup(adviseDiv,adviseBg);
		loadPopup(adviseDiv,adviseBg);
	});
	
	$("#adviseThroughBankSave").click(function(){
		$("#adviseThroughBankNameAndAddress").val($("#adviseThroughBankComment").val());
		disablePopup(adviseDiv,adviseBg);
	});
	
	$("#adviseThroughBankClose,.adviseClose").click(function(){
		disablePopup(adviseDiv,adviseBg);
	});
});