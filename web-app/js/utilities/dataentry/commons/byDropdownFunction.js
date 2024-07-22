$(document).ready(function enabledThis(){

    var mixedPaymentDetailsVal = $("#mixPaymentDetailsFrom").val();
    var defPaymentDetailsVal = $("#defPaymentDetailsFrom").val();

    $("#byDropdownTo").change(function(){

        //alert('hey');
        if($(this).val().toLowerCase()=="by default payment"){
            $("#mixPaymentDetailsTo").attr("readonly","readonly");
            $("#defPaymentDetailsTo").removeAttr("readonly","readonly");
            $("#defPaymentDetailsTo").val(defPaymentDetailsVal);

        }else if($(this).val().toLowerCase()=="by mixed payment"){
            $("#defPaymentDetailsTo").attr("readonly","readonly");
            $("#mixPaymentDetailsTo").removeAttr("readonly","readonly");
            $("#mixPaymentDetailsTo").val(mixedPaymentDetailsVal);

        }else{
            $("#mixPaymentDetailsTo").attr("readonly","readonly");
            $("#defPaymentDetailsTo").attr("readonly","readonly");
        }

    })

    if($("#documentSubType1").val() != "STANDBY") {
        setByValue();
    }

    $("select#availableByDisplay").change(function(){
        switch($(this).val()){
            case "M":
                $(".mixed_payment_details").show();
                $(".mixed_payment_details").toggleClass("required", true);
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
//                $(".drawee").hide();
                break;
            case "D":
                $(".deffered_payment_details").show();
                $(".deffered_payment_details").toggleClass("required", true);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
//                $(".drawee").hide();
                break; 
            case "":
//                $(".drawee").hide();
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
                break;
            default:
                $(".drawee").show();
	            $(".deffered_payment_details").hide();
	            $(".deffered_payment_details").toggleClass("required", false);
	            $(".mixed_payment_details").hide();
	            $(".mixed_payment_details").toggleClass("required", false);
                break;
        }
    });

    var confirmationInstructionsFlag = $("input[name=confirmationInstructionsFlag]:checked").val();

    if(confirmationInstructionsFlag == "M") {
        $("select#availableByDisplay").val("N");
        $("#availableBy").val("N");
        $("select#availableByDisplay").attr("disabled", "disabled");
//		$(".drawee").hide();
    }

    $("input[name=confirmationInstructionsFlag]").change(setByValue);
});

function setByValue(){
    if($("#tenor").length > 0 && $("#tenor").val().toLowerCase() == "sight"){
        switch($("input[name=confirmationInstructionsFlag]:checked").val()){
            case "Y":
                $("select#availableByDisplay").val("P").attr("disabled","disabled")
                $("#availableBy").val("P");
                $(".drawee").show();
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
                break;
            case "N":
                $("select#availableByDisplay").val("N").attr("disabled","disabled")
                $("#availableBy").val("N");
                $(".drawee").show();
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
                break;
            default :
            	$("select#availableByDisplay").val("N").attr("disabled","disabled")
                $("#availableBy").val("N");
//                $(".drawee").hide();
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
                break;
        }
    }else if($("#tenor").length > 0 && $("#tenor").val().toLowerCase() == "usance"){
        switch($("input[name=confirmationInstructionsFlag]:checked").val()){
            case "Y":
            	$("select#availableByDisplay").val("A").attr("disabled","disabled")
                $("#availableBy").val("A");
                $(".drawee").show();
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
                break;
            case "N":
                $("select#availableByDisplay").val("N").attr("disabled","disabled")
                $("#availableBy").val("N");
                $(".drawee").show();
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
                break;
            default :
            	$("select#availableByDisplay").val("N").attr("disabled","disabled")
            	$("#availableBy").val("N");
//                $(".drawee").hide();
                $(".deffered_payment_details").hide();
                $(".deffered_payment_details").toggleClass("required", false);
                $(".mixed_payment_details").hide();
                $(".mixed_payment_details").toggleClass("required", false);
                break;
        }
    }
}