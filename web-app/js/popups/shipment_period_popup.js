$(document).ready(function(){

	$("#popup_btn_shipment_period").click(function(){
		if($("#latestShipmentDate").val()==""){	
			var wrapper_div=$("#popup_shipmentPeriod").attr("id");
			var div_bg=$("#shipment_period_bg").attr("id");
			$("#popup_header_shipmentPeriod").text("Shipment Period");
			$("#shipmentPeriodPopupField").text($("#shipmentPeriod").text());
			$("#shipmentPeriodPopupField").val($("#shipmentPeriod").val());		
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
				
			$("#close_shipmentPeriod1, #close_shipmentPeriod2, .save_shipmentPeriod").click(function(){
		    	$("#shipmentPeriodTo").val($("#shipmentPeriodPopupField").val());
				disablePopup(wrapper_div,div_bg);
				evaluateShipmentGoodFields();
			}); 
		}else{	
            triggerAlertMessage("Latest date of shipment field is not empty.");
		}		
		
	});
	
	$("#shipmentPeriodPopupField").limitCharAndLines(65,6);
	
});