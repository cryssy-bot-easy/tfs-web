$(function(){
	var popup_div_ordering_customer = "popup_div_ordering_customer";
	var popup_bg_ordering_customer = "popup_bg_ordering_customer";
	
	$("#popup_btn_ordering_customer").click(function(){
		$("#orderingCustomerAddressComment").val(($("#orderingAddress").length > 0) ? $("#orderingAddress").val() : $("#bankNameAndAddress").val());
		$("#orderingCustomerAddressComment").limitCharAndLines(35, 4);
		//centering with css
        centerPopup(popup_div_ordering_customer, popup_bg_ordering_customer);
        //load popup
        loadPopup(popup_div_ordering_customer, popup_bg_ordering_customer);
	});
	
	$(".popup_close_ordering_customer").click(function(){
		$("#orderingCustomerAddressComment").val("");
		//disable popup
        disablePopup(popup_div_ordering_customer, popup_bg_ordering_customer);
	});
	
	$("#orderingCustomerAddressPopupSave").click(function(){
		var orderingCustomerAddress = $("#orderingCustomerAddressComment").val().toUpperCase()
		if($("#orderingAddress").length > 0) {
			$("#orderingAddress").val(orderingCustomerAddress);
		} else if($("#bankNameAndAddress").length > 0) {
			$("#bankNameAndAddress").val(orderingCustomerAddress);
		}
		//disable popup
        disablePopup(popup_div_ordering_customer, popup_bg_ordering_customer);
	});
	
	$("#orderingCustomerAddressComment").limitCharAndLines(35, 4);
})