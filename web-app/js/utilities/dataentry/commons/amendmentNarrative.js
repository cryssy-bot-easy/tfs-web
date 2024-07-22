$(document).ready(function (){

	if($("#narrative_shipment").length > 0){
		//for shipment of goods narrative
		$("#narrative_shipment").limitCharAndLines(35,50);
	}
	
	if($("#narrative_ac1").length > 0){
		//for additional condition 1 narrative
		$("#narrative_ac1").limitCharAndLines(35,50);
	}
	
	if($("#narrative_ac2").length > 0){
		//for additional condition 2 narrative
		$("#narrative_ac2").limitCharAndLines(35,50);
		
	}
});