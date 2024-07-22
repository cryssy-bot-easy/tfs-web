function setExpiryLc() {
    var expiryLcSwitch = $("#expiredLcSwitch").val();

    if(expiryLcSwitch) {
        if(expiryLcSwitch.toLocaleString() == "on") {
            $("#expiredLcSwitchDisplay").attr("checked", "checked");
        } else {
            $("#expiredLcSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#expiredLcSwitchDisplay").attr("checked", false);
    }
}

function onExpiredLcSwitchClick() {
    if($("#expiredLcSwitchDisplay").attr("checked") == "checked") {
        $("#expiredLcSwitch").val("on");
    } else {
        $("#expiredLcSwitch").val("off");    	
    	if($(expiredStatus).val() == "EXPIRED") {
            $("#expiredStatus").val("");
            $(expiredStatus).val("");
    	}
    }
}

function setDescriptionLc() {
    var descriptionLc = $("#descriptionOfGoodsNotPerLcSwitch").val();

    if (descriptionLc) {
        if (descriptionLc.toLocaleString() == "on") {
            $("#descriptionOfGoodsNotPerLcSwitchDisplay").attr("checked", "checked");
        } else {
            $("#descriptionOfGoodsNotPerLcSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#descriptionOfGoodsNotPerLcSwitchDisplay").attr("checked", false);
    }
}

function onDescriptionOfGoodsNotPerLcSwitchClick() {
    if ($("#descriptionOfGoodsNotPerLcSwitchDisplay").attr("checked") == "checked") {
        $("#descriptionOfGoodsNotPerLcSwitch").val("on");
        $("#popup_btn_description_of_goods_not_as_per_lc").attr("disabled", false);
    } else {
        $("#descriptionOfGoodsNotPerLcSwitch").val("off");
        $("#descriptionOfGoodsNotAsPerLc").attr("readonly", "readonly");
        $("#popup_btn_description_of_goods_not_as_per_lc").attr("disabled", true);
        $("#descriptionOfGoodsNotAsPerLc").val("");
    }
}

function onDescriptionOfGoodsNotAsPerLcCheck() {
    if ($("#descriptionOfGoodsNotPerLcSwitchDisplay").attr("checked") == "checked") {
        $("#descriptionOfGoodsNotPerLcSwitch").val("on");
        $("#popup_btn_description_of_goods_not_as_per_lc").attr("disabled", false);
    } else {
        $("#descriptionOfGoodsNotPerLcSwitchDisplay").val("off");
        $("#descriptionOfGoodsNotAsPerLc").attr("readonly", "readonly");
        $("#popup_btn_description_of_goods_not_as_per_lc").attr("disabled", true);
        $("#descriptionOfGoodsNotAsPerLc").val("");
    }
}

function setDocumentsNotPresented() {
    var documentsNotPresented = $("#documentsNotPresentedSwitch").val();

    if(documentsNotPresented) {
        if(documentsNotPresented.toLocaleString() == "on") {
            $("#documentsNotPresentedSwitchDisplay").attr("checked", "checked");
        } else {
            $("#documentsNotPresentedSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#documentsNotPresentedSwitchDisplay").attr("checked", false);
    }
}

function onDocumentsNotPresentedSwitchClick() {
    if($("#documentsNotPresentedSwitchDisplay").attr("checked") == "checked") {
        $("#documentsNotPresentedSwitch").val("on");
    } else {
        $("#documentsNotPresentedSwitch").val("off");
        $("#documentsNotPresented").attr("readonly", "readonly");
        $("#documentsNotPresented").val("");
    }
}

function onDocumentsNotPresentedCheck() {
    if($("#documentsNotPresentedSwitchDisplay").attr("checked") == "checked") {
        $("#documentsNotPresentedSwitch").val("on");
    } else {
        $("#documentsNotPresentedSwitchDisplay").val("off");
        $("#documentsNotPresented").attr("readonly", "readonly");
        $("#documentsNotPresented").val("");
    }
}

function setOverdrawnForAmountSwitch() {
    var overdrawnAmountSwitch = $("#overdrawnForAmountSwitch").val();

    if(overdrawnAmountSwitch) {
        if(overdrawnAmountSwitch.toLocaleString() == "on") {
            $("#overdrawnForAmountSwitchDisplay").attr("checked", "checked");
        } else {
            $("#overdrawnForAmountSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#overdrawnForAmountSwitchDisplay").attr("checked", false);
    }
}

function onOverdrawnForAmountSwitchClick() {
    if($("#overdrawnForAmountSwitchDisplay").attr("checked") == "checked") {
        $("#overdrawnForAmountSwitch").val("on");
        $("#overdrawnForAmount").removeAttr("readonly");
    } else {
        $("#overdrawnForAmountSwitch").val("off");
        $("#overdrawnForAmount").attr("readonly", "readonly");
        $("#overdrawnForAmount").val("");
    }
}

function onOverdrawnCheck() {
    if($("#overdrawnForAmountSwitchDisplay").attr("checked") == "checked") {
        $("#overdrawnForAmountSwitch").val("on");
        $("#overdrawnForAmount").removeAttr("readonly");
    } else {
        $("#overdrawnForAmountSwitch").val("off");
        $("#overdrawnForAmount").attr("readonly", "readonly");
        $("#overdrawnForAmount").val("");
    }
}

function setOthersSwitch() {
    var othersSwitch = $("#othersSwitch").val();

    if(othersSwitch) {
        if(othersSwitch.toLocaleString() == "on") {
            $("#othersSwitchDisplay").attr("checked", "checked");
        } else {
            $("#othersSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#othersSwitchDisplay").attr("checked", false);
    }
}

function onOthersSwitchClick() {
    if($("#othersSwitchDisplay").attr("checked") == "checked") {
        $("#othersSwitch").val("on");
    } else {
        $("#othersSwitch").val("off");
        $("#others").attr("readonly", "readonly");
        $("#others").val("");
    }
}

function onOthersCheck() {
    if($("#othersSwitchDisplay").attr("checked") == "checked") {
        $("#othersSwitch").val("on");
    } else {
        $("#othersSwitch").val("off");
        $("#others").attr("readonly", "readonly");
        $("#others").val("");
    }
}

$(document).ready(function(){
	
//	$("#overdrawnForCheckBox").change(function(){
//		if (document.getElementById("overdrawnForCheckBox").checked==true){
//			$("#overdrawnFor").removeAttr("readonly");
//		}else{
//			$("#overdrawnFor").attr("readonly","readonly");
//		}
//
//	});
//
//	$("#othersCheckbox").change(function(){
//		if (document.getElementById("othersCheckbox").checked==true){
//			$("#others").removeAttr("readonly");
//		}else{
//			$("#others").attr("readonly","readonly");
//		}
//	});

    setExpiryLc();
    $("#expiredLcSwitchDisplay").click(onExpiredLcSwitchClick);

    setDescriptionLc();
    $("#descriptionOfGoodsNotPerLcSwitchDisplay").click(onDescriptionOfGoodsNotPerLcSwitchClick);
    onDescriptionOfGoodsNotAsPerLcCheck();
    
    setDocumentsNotPresented();
    $("#documentsNotPresentedSwitchDisplay").click(onDocumentsNotPresentedSwitchClick);
//    $('#documentsNotPresented').on('blur', function() {
//    	console.log($('#documentsNotPresented').val())
//    });
    onDocumentsNotPresentedCheck();

    setOverdrawnForAmountSwitch();
    $("#overdrawnForAmountSwitchDisplay").click(onOverdrawnForAmountSwitchClick);
    onOverdrawnCheck();

    setOthersSwitch();
    $("#othersSwitchDisplay").click(onOthersSwitchClick);
    onOthersCheck();
    
    console.log($(expiredStatus).val());
	if($(expiredStatus).val() === "EXPIRED"){
		$("#expiredLcSwitch").val("on");
		$("#expiredLcSwitchDisplay").attr("checked","checked");
		
	}
	console.log($(expiredStatus).val());
});

