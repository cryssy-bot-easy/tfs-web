/**
 * Modified by: Rafael Ski Poblete
 * Date Modified: 08/28/18
 * Details :(BUG) Added and else if condition to ruturn datepicker after it was removed in if condition.
 */
function onShipmentPeriodSave() {
//    $("#shipmentPeriod").val($("#shipmentPeriodPopupField").val());
    if($("#shipmentPeriodTo").length > 0) {
        $("#shipmentPeriodTo").val($("#shipmentPeriodPopupField").val())
    } else {
        $("#shipmentPeriod").val($("#shipmentPeriodPopupField").val())
    }
    $("#shipmentPeriodPopupField").val("");
}

function onDescriptionOfGoodsAndServicesSave() {
//    $("#generalDescriptionOfGoods").val($("#descriptionOfGoodsServicesPopupField").val());

    if($("#generalDescriptionOfGoodsTo").length > 0) {
        $("#generalDescriptionOfGoodsTo").val($("#descriptionOfGoodsServicesPopupField").val())
    } else {
        $("#generalDescriptionOfGoods").val($("#descriptionOfGoodsServicesPopupField").val())
    }

    $("#descriptionOfGoodsServicesPopupField").val("");
}

$(document).ready(function (){	
	var shipmentsPeriodVal = $("#shipmentsPeriodFrom").val();
	var descriptionOfGoodsServicesVal = $("#descriptionOfGoodsServicesFrom").val();
	
	$("#latestDateShipmentTo").attr("readonly","readonly");
	$("#shipmentsPeriodTo").attr("readonly","readonly");
	$("#descriptionOfGoodsServicesTo").attr("readonly","readonly");	
	
	$("#latestDateShipmentRow").click(function (){
		if($("#latestDateShipmentRow").attr("checked") == "checked"){
			$("#latestDateShipmentTo").removeAttr("readonly","readonly");	
		}else{
			$("#latestDateShipmentTo").attr("readonly","readonly");
		}
	});
	
	$("#shipmentsPeriodRow").click(function (){
		if($("#shipmentsPeriodRow").attr("checked") == "checked"){
			$("#shipmentsPeriodTo").removeAttr("readonly","readonly");
			$("#shipmentsPeriodTo").val(shipmentsPeriodVal);	
		}else{
			$("#shipmentsPeriodTo").attr("readonly","readonly");
		}
	});

	$("#descriptionOfGoodsServicesRow").click(function (){
		if($("#descriptionOfGoodsServicesRow").attr("checked") == "checked"){
			$("#descriptionOfGoodsServicesTo").removeAttr("readonly","readonly");	
			$("#descriptionOfGoodsServicesTo").val(descriptionOfGoodsServicesVal);	
		}else{
			$("#descriptionOfGoodsServicesTo").attr("readonly","readonly");
		}
	});

    // button wiring for save
    $("#shipmentPeriodSave").click(onShipmentPeriodSave);
    $("#descriptionOfGoodsAndServicesSave").click(onDescriptionOfGoodsAndServicesSave);

});

$(window).load(function(){
	evaluateShipmentGoodFields();
});

function evaluateShipmentGoodFields(){
	if($("#shipmentPeriod").length > 0 && $("#shipmentPeriod").val().length > 0){
		$("#latestShipmentDate").datepicker("destroy");
		$("#latestShipmentDate").removeClass("datepicker_field").addClass("input_field");
		$("#latestShipmentDate").attr("readonly","readonly");
		$("#latestShipmentDate").val("");		
	} else if($("#latestShipmentDate").attr("class").indexOf("datepicker_field") != -1) {
		$("#latestShipmentDate").removeAttr("readonly");
		$("#latestShipmentDate").datepicker({
			  showOn: 'both',
			  buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp	  
			  changeMonth: true,
			  changeYear: true
			})/*.attr("readonly","readonly")*/;
	} else if(!($("#shipmentPeriod").length > 0 && $("#shipmentPeriod").val().length > 0)) {
		$("#latestShipmentDate").removeAttr("readonly");
		$("#latestShipmentDate").datepicker({
			  showOn: 'both',
			  buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp	  
			  changeMonth: true,
			  changeYear: true
			})/*.attr("readonly","readonly")*/;
	}
}