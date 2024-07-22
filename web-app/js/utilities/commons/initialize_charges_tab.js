$(document).ready(function(){
//	initPage();
});

function initPage(){
	if ( documentType == 'FOREIGN' && serviceType == 'Negotiation' && documentSubType1 == 'CASH' ){
		$(".interest_due").remove();
		$(".cilex").remove();
		$(".documentary_stamp").remove();		
	}
	if ( documentType == 'FOREIGN' && serviceType == 'Negotiation' && documentSubType1 == 'STANDBY' ){
		$(".documentary_stamp").remove();
		$(".notarial_fee").remove();
	}
	if ( documentType == 'FOREIGN' && serviceType == 'Negotiation' && documentSubType1 == 'REGULAR' && documentSubType2 == 'SIGHT' ){
		// Do nothing
	}
	if ( documentType == 'FOREIGN' && serviceType == 'Negotiation' && documentSubType1 == 'REGULAR' && documentSubType2 == 'USANCE' ){
		$(".cilex").remove();
		$(".documentary_stamp").remove();
	}
	
	if ( documentType == 'DOMESTIC' && serviceType == 'Negotiation' && documentSubType1 == 'CASH' ){
		$(".documentary_stamp").remove();
	}
	if ( documentType == 'DOMESTIC' && serviceType == 'Negotiation' && documentSubType1 == 'STANDBY' ){
		$(".documentary_stamp").remove();
	}
	if ( documentType == 'DOMESTIC' && serviceType == 'Negotiation' && documentSubType1 == 'REGULAR' && documentSubType2 == 'USANCE' ){
		$(".documentary_stamp").remove();
	}
}
	
	