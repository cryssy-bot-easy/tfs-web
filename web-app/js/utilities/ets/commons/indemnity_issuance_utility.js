//function onChangeIndemnityType() {
//    var indemnityType = $("#indemnityType").val();
//
//    if(indemnityType == "BG") {
//        $("#transportMedium").val("BY SEA");
//    } else if(indemnityType == "BE") {
//        $("#transportMedium").val("BY AIR");
//    } else {
//        $("#transportMedium").val("");
//    }
//}

function onChangeTransportMedium() {
    var transportMedium = $("#transportMedium").val();

    if(transportMedium == "SEA") {
        $("#indemnityType").val("BG");
        $("#indemnityTypeSpan").text("BANK GUARANTEE");
    } else if(transportMedium == "AIR") {
        $("#indemnityType").val("BE");
        $("#indemnityTypeSpan").text("BANK ENDORSEMENT");
    }else {
        $("#indemnityType").val("");
        $("#indemnityTypeSpan").text("");
    }
}

$(document).ready(function(){
//	$(".bank_commission").hide();
//	$(".documentary_stamp").hide();
//	$("#indemnityType").change(indemnityType);
//    $("#indemnityType").change(onChangeIndemnityType);
//	$(".charges_currency").text("PHP");

    // displays appropriate indemnity type based on selected transport medium
    $("#transportMedium").change(onChangeTransportMedium);
});

//function indemnityType(){
//	if ($("#indemnityType").val().toLowerCase()=="bank guaranty"){
//		$(".bank_commission").show();
//		$(".documentary_stamp").show();
//		$("#bankCommission").val("500.00");
//		$("#documentaryStamp").val("37.50");
//	}else if($("#indemnityType").val().toLowerCase()=="bank endorsement"){
//		$("#bankCommission").val("500.00");
//		$("#documentaryStamp").val("0.00");
//		$(".bank_commission").show();
//		$(".documentary_stamp").hide();
//	}else{
//		$("#bankCommission").val("0.00");
//		$("#documentaryStamp").val("0.00");
//		$(".bank_commission").hide();
//		$(".documentary_stamp").hide();
//	}
//}

//$(document).ready(function(){
//	$(".bank_commission").hide();
//	$(".documentary_stamp").hide();
//	$("#indemnityType").change(indemnityType);
//	$(".charges_currency").text("PHP");
//
//});
//
//
////function onChangeIndemnityType() {
////    var indemnityType = $("#indemnityType").val();
////
////    if(indemnityType == "BG") {
////        $("#transportMedium").val("BY SEA");
////    } else if(indemnityType == "BE") {
////        $("#transportMedium").val("BY AIR");
////    } else {
////        $("#transportMedium").val("");
////    }
////}
//
//
//
//function indemnityType(){
//	if ($("#indemnityType").val().toLowerCase()=="bank guaranty"){
//		$(".bank_commission").show();
//		$(".documentary_stamp").show();
//		$("#bankCommission").val("500.00");
//		$("#documentaryStamp").val("37.50");
//	}else if($("#indemnityType").val().toLowerCase()=="bank endorsement"){
//		$("#bankCommission").val("500.00");
//		$("#documentaryStamp").val("0.00");
//		$(".bank_commission").show();
//		$(".documentary_stamp").hide();
//	}else{
//		$("#bankCommission").val("0.00");
//		$("#documentaryStamp").val("0.00");
//		$(".bank_commission").hide();
//		$(".documentary_stamp").hide();
//	}
//}
//
//
//<%-- function onChangeTransportMedium() {
//    var transportMedium = $("#transportMedium").val();
//
//    if(transportMedium == "SEA") {
//        $("#indemnityType").val("BG");
//        $("#indemnityTypeSpan").text("BANK GUARANTEE");
//    } else if(transportMedium == "AIR") {
//        $("#indemnityType").val("BE");
//        $("#indemnityTypeSpan").text("BANK ENDORSEMENT");
//    }else {
//        $("#indemnityType").val("");
//        $("#indemnityTypeSpan").text("");
//    }
//} --%>
