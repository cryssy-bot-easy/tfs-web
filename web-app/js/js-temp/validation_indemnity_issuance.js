///**
// * Created by IntelliJ IDEA.
// * User: Marv
// * Date: 11/23/12
// * Time: 8:51 PM
// * To change this template use File | Settings | File Templates.
// */
//
//function onBasicDetailsSaveClick() {
//    var errors = validateBasicDetailsIndemnity();
//    onSaveClick(errors);
//}
//
//function onSaveClick(errors){
//    if(!errors){
//        action = "save";
//        openAlert();
//    }
//}
//
//function onSaveIndemnityClick(){
//    action = "save";
//    openAlert();
//}
//
//function onChargesTabSaveClick(){
//	var errors = validateCharges();
//	onSaveClick(errors);	
//}
//function validateBasicDetailsIndemnity() {
//    if(!$("#transportMedium").val() ||
//       !$("#shipmentAmount").val() ||
//       !$("input[name=cwtFlag]:checked").val() {
//
//        $("#alertMessage").text("Please fill in all the required fields.")
//        triggerAlert();
//        return true;
//    } else {
//        return false;
//    }
//}
//
//function validateCharges(){
//	var error_msg = ""
//		if($("#settlementCurrency").val()==""){
//			error_msg+="Settlement currency is empty."
//		}
//		if($("#passOnRateConfirmedBy").val()==""){
//			error_msg+="Pass on rates is empty."
//		}
//		
//		if(error_msg.length > 0){
//	        $("#alertMessage").text("Please fill in all the required fields.");
//	        triggerAlert();
//			return true
//		} else {		
//			return false;
//		}
//}
//
//$(function(){
//    $(".openSaveConfirmation").click(function(){
//        switch($(this).parents("form").attr("id")){
//            case "basicDetailsTabForm":
//                onBasicDetailsSaveClick();
//                break;
//            case "chargesTabForm":
//				onChargesTabSaveClick();
//				break;
//            default:
//                onSaveIndemnityClick();
//                break;
//        }
//    });
//});
//


function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsAmendment();
	onSaveClick(errors);
}

function onSaveClick(errors){
	if(!errors){
//		action = "save";
		_pageHasErrors=false;
//		openAlert();
//		confirmAlert();
	}else{
		_pageHasErrors=true;
	}
}

function onAmendmentSaveClick(){
	/*action = "save";
	openAlert();	*/
	_pageHasErrors=false;
}

function validateBasicDetailsAmendment(){
	var error_msg = ""
		if($("#transportMedium").val()=="") {			
			  error_msg+="Transport medium is empty"
	}
	if($("#shipmentAmount").val()=="") {			
		  error_msg+="Shipment amount is empty"
	}
	if($("input[name=cwtFlag]:checked").val()=="") {			
		  error_msg+="CWT not checked"
	}	 
	
	if(error_msg.length > 0){
//		alert(error_msg);
		//alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
	return false;
	}
}


function validateCharges(){
	var error_msg = ""
		if($("#settlementCurrency").val()==""){
			error_msg+="Settlement currency is empty."
		}
		
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
			return true
		} else {			
			return false;
		}
}

function onChargesTabSaveClick(){
	var errors = validateCharges();
	onSaveClick(errors);	
}

function validateIndemnityIssuance(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	case "chargesTabForm":
		onChargesTabSaveClick();
		break;
	default:
		onAmendmentSaveClick();
		break;
	}
}

