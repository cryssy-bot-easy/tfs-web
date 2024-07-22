/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/3/12
 * Time: 10:54 AM
 * To change this template use File | Settings | File Templates.
 */
function onModeOfRefundChange() {
    var modeOfRefund = $("#modeOfRefund").val();
    if(modeOfRefund == "CASA") {
        //$(".md-casa").css("display", "table-row");
        $(".md-casa").show();
        $(".md-casa :input").each(function(){
        	$(this).toggleClass("required", true);
        });
    } else {
        $(".md-casa").hide();
        $(".md-casa :input").each(function(){
        	$(this).toggleClass("required", false);
        });
    }
}

function onModeOfApplicationChange(){
    var modeOfApplication = $("#modeOfApplication").val();

    if(modeOfApplication == "REFUND_TO_CLIENT_ISSUE_MC"){
        $(".modeRefund").show();
        $(".pn-number").hide();
    }
    else if(modeOfApplication == "APPLY_TO_LOAN"){
        $(".pn-number").show();
        $(".modeRefund").hide();
        $(".md-casa").hide();
        $.post(findPnNumberByDocumentNumber, {documentNumber: $("#documentNumber").val()}, function(data) {
        	if (data.pnNumber.length > 0){
        		$("#pnNumber").val(data.pnNumber);
        	}else{
        	    $("#alertMessage").text("No PN Number found for " + $("#documentNumber").val());
        	    triggerAlert();
        	}
        });
        
    }
    else{
    	$("#pnNumber").val("");
    	$("#remarks").val("");
        $(".modeRefund").hide();
        $(".pn-number").hide();
        $(".md-casa").hide();
    }
}

function evaluateMdPaymentDetails(){
	var mdCur=$("#mdCurrency").val();
	var mdAmt=$("#mdCollectionAmount").val();
	var hasError=false;
	
	if(parseInt(mdAmt) < 1){
		$("#alertMessage").text("MD Amount cannot be zero");
		hasError=true;
	}
	if( documentType != null && documentType != 'REFUND'){
		if("" == $.trim(mdAmt) || "" == mdCur ){
			$("#alertMessage").text("MD Currency and Amount required.");
			hasError=true;
		}
	}
	if($("#grid_list_cash_payment_summary tr").length == 4) {
		$("#alertMessage").text("Settlement charges cannot be more than 3.");
		hasError=true;
	}
	
	if(hasError){
		triggerAlert();
		return true;
	}
}


function initMdCollectionBasicDetails() {
    if ($("#modeOfRefund").length > 0) {
        $("#modeOfRefund").change(onModeOfRefundChange);
        onModeOfRefundChange();
    }

    if ($("#modeOfApplication").length > 0) {
        $("#modeOfApplication").change(onModeOfApplicationChange);
        onModeOfApplicationChange();
    }
}

$(initMdCollectionBasicDetails);
