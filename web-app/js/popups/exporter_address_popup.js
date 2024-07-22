function onexporterAddressPopupSaveClick() {
    var exporterAddress = $("#exporterAddressComment").val();

    $("#exporterAddress").val(exporterAddress);

    disablePopup("popup_exporterAddress", "exporter_address_bg");
}

$(document).ready(function(){
	var wrapper_div=$("#popup_exporterAddress").attr("id");
	var div_bg=$("#exporter_address_bg").attr("id");

	$("#popup_btn_exporter_address").click(function(){
        $("#exporterAddressComment").val(($("#exporterAddressTo").length > 0) ? $("#exporterAddressTo").val() : $("#exporterAddress").val());

		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_exporterAddress1, #close_exporterAddress2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});

	$("#exporterAddressComment").limitCharAndLines(35,4);

	$("#exporterAddressPopupSave").click(onexporterAddressPopupSaveClick);
});
