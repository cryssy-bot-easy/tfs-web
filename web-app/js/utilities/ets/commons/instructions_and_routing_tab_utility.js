function onUserRoleChange() {
	var passToRole = $("#userRole").val();
	subTitleButtonsVariation();

    return;
	
	switch(passToRole){
		case "maker":
			$("#makerButton").show();			
			$("#checkerButton").hide();			
			$("#approverButton").hide();
			break;
		case "checker":
			$("#makerButton").hide();			
			$("#checkerButton").show();			
			$("#approverButton").hide();
			break;
		case "approver":
			$("#makerButton").hide();			
			$("#checkerButton").hide();			
			$("#approverButton").show();
			break;
		default:
			$("#makerButton").show();			
			$("#checkerButton").hide();			
			$("#approverButton").hide();
			break;			
	}
}

function onPrepareClick() {
	$("#statusAction").val(this.value);

    // specifically for negotiation ets if there is an IC but not selected
    if(serviceType.toUpperCase() == "NEGOTIATION" && referenceType == "ETS") {
        var icCount = $("#icCount").val();
        var icNumber = $("#icNumber").val();

        if(parseInt(icCount) > 0 && !icNumber) {
            $("#alertMessage").text("No IC Number selected.");
            triggerAlert();
        }
    }

//    if(serviceType.toUpperCase() == "OPENING") {
//
//    }
}

function onOverAvailmentClick(){
	mDisablePopup($('#popup_over_availment'), $('#popupBackground_over_availment'));
}

function onAbortClick() {
	$("#statusAction").val(this.value);	
}

function onReturnClick() {
	$("#statusAction").val(this.value);	
}

function onReturnToBranchClick() {
    $("#statusAction").val("ReturnToBranch");
}

function onDisapproveClick() {
	$("#statusAction").val(this.value);
}

function onCheckClick() {
    $("#statusAction").val(this.value);
}

function onApproveClick() {
	
	$("#statusAction").val(this.value);
}

function onPreApproveClick() {
    $("#statusAction").val("preApprove")
}

function onPostApproveClick() {
    $("#statusAction").val("postApprove");
}

//different buttons for Data Entry
function subTitleButtonsVariation(){
	
	var getSubTitle = $("#subtitle").text();
	
	// for ets
	if(getSubTitle.indexOf("eTS") != -1){
		$(".etsButtons").show();
		$(".dataEntryButtons").hide();
		
	//for Data Entry
	}else if (getSubTitle.indexOf("Data Entry") != -1){
		$(".dataEntryButtons").show();	
		$(".etsButtons").hide();
	}
}

function initializeInstructionsAndRoutingTabUtility() {
	onUserRoleChange();
	$("#userRole").change(onUserRoleChange);
	
	// wire button actions
	$("#btnPrepare").click(onPrepareClick);
	$("#btnAbort").click(onAbortClick);
	$("#btnReturnChecker, #btnReturnApprover").click(onReturnClick);
    $("#btnReturnEtsToBranch").click(onReturnToBranchClick);
    $("#btnCheck").click(onCheckClick);
	$("#btnDisapprove").click(onDisapproveClick);
	$("#btnApprove").click(onApproveClick);

	$(".popupCloseOverAvailment").click(onOverAvailmentClick);
    $("#btnPreApprove").click(onPreApproveClick);
    $("#btnPostApprove").click(onPostApproveClick);
}

$(initializeInstructionsAndRoutingTabUtility);