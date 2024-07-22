/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/7/12
 * Time: 2:02 AM
 * To change this template use File | Settings | File Templates.
 */

function disableShipmentFields() {
    $("form#shipmentOfGoodsTabForm :input").each(function(){
        var input = $(this); // This is the jquery object of the input, do what you will

        if(input.attr("name") != undefined) {
            var name = input.attr("name");
//              alert(name + " " + input.attr("type"));
            if(name.substring(name.length -2, name.length) == "To") {
                if(input.attr("type") == "text" || input.attr("type") == "textarea") {
                    input.attr("readonly", "readonly");
                }else {
                    input.attr("disabled", "disabled");
                }
            }
        }
    });
}

function setLatestShipmentDate() {
    var latestShipmentDate = $("#latestShipmentDateSwitch").val();

    if(latestShipmentDate) {
        if(latestShipmentDate.toLowerCase() == "on") {
            $("#latestShipmentDateSwitchDisplay").attr("checked", "checked");
        } else {
            $("#latestShipmentDateSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#latestShipmentDateSwitchDisplay").attr("checked", false);
    }
}

function onCheckLatestShipmentDate() {
    if($("#latestShipmentDateSwitchDisplay").attr("checked") == "checked") {
        $("#latestShipmentDateSwitch").val("on");

        $("#latestShipmentDateTo").addClass("datepicker_field");

        $("#latestShipmentDateTo").datepicker({
            showOn: 'both',
            buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
            changeMonth: true,
            changeYear: true,
            constrainInput:true,
            defaultDate:null,
            dateFormat:'mm/dd/yy'
        }).attr("readonly","readonly");

        $("#latestShipmentDateTo").removeAttr("readonly");
        $(".latestShipmentDateToAsterisk").addClass("asterisk");
        $(".latestShipmentDateToAsterisk").removeClass("clear_font");
    } else {
        $("#latestShipmentDateSwitch").val("off");
        $("#latestShipmentDateTo").removeClass("datepicker_field").addClass("input_field").datepicker("destroy");
        $("#latestShipmentDateTo").attr("readonly", "readonly");
        $("#latestShipmentDateTo").val("");
        $(".latestShipmentDateToAsterisk").removeClass("asterisk");
        $(".latestShipmentDateToAsterisk").addClass("clear_font");
    }
}

function setShipmentPeriod() {
    var shipmentPeriod = $("#shipmentPeriodSwitch").val();

    if(shipmentPeriod) {
        if(shipmentPeriod.toLowerCase() == "on") {
            $("#shipmentPeriodSwitchDisplay").attr("checked", "checked");
        } else {
            $("#shipmentPeriodSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#shipmentPeriodSwitchDisplay").attr("checked", false);
    }
}

function onCheckShipmentPeriod() {
    if($("#shipmentPeriodSwitchDisplay").attr("checked") == "checked") {
        $("#shipmentPeriodSwitch").val("on");
        $("#shipmentPeriodTo").removeAttr("disabled");
        $(".amend_shipment_period_btn").show();
        $(".shipmentPeriodToAsterisk").addClass("asterisk");
        $(".shipmentPeriodToAsterisk").removeClass("clear_font");
    } else {
        $("#shipmentPeriodSwitch").val("off");
        $(".amend_shipment_period_btn").hide();
        $("#shipmentPeriodTo").val("");
        $(".shipmentPeriodToAsterisk").removeClass("asterisk");
        $(".shipmentPeriodToAsterisk").addClass("clear_font");
    }
}

function setGeneralDescriptionOfGoods() {
    var generalDescription = $("#generalDescriptionOfGoodsSwitch").val();

    if(generalDescription) {
        if(generalDescription.toLowerCase() == "on") {
            $("#generalDescriptionOfGoodsSwitchDisplay").attr("checked", "checked");
        } else {
            $("#generalDescriptionOfGoodsSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#generalDescriptionOfGoodsSwitchDisplay").attr("checked", false);
    }
}

function onCheckGeneralDescriptionOfGoods() {
    if($("#generalDescriptionOfGoodsSwitchDisplay").attr("checked") == "checked") {
        $("#generalDescriptionOfGoodsSwitch").val("on");
        $("#generalDescriptionOfGoodsTo").removeAttr("disabled");
        $(".amend_description_of_goods_btn").show();
        $(".generalDescriptionOfGoodsToAsterisk").addClass("asterisk");
        $(".generalDescriptionOfGoodsToAsterisk").removeClass("clear_font");
        $(".popup_btn_input_instructions.descriptionOfGoods").css("visibility", "visible");
        if (!isInitial && $('#documentType').val() == 'FOREIGN' && $('#documentType').val() != 'STANDBY') {
            $(".popup_btn_input_instructions.descriptionOfGoods").click();
        }
    } else {
        $("#generalDescriptionOfGoodsSwitch").val("off");
        $(".amend_description_of_goods_btn").hide();
        $("#generalDescriptionOfGoodsTo").val("");
        $(".generalDescriptionOfGoodsToAsterisk").removeClass("asterisk");
        $(".generalDescriptionOfGoodsToAsterisk").addClass("clear_font");
        $(".popup_btn_input_instructions.descriptionOfGoods").css("visibility", "hidden");
    }
    isInitial = false;
}

function shipmentPeriodEditCheckBox() {
	if($("#latestShipmentDateFrom").val() != ""){
		$("#latestShipmentDateSwitchDisplay").removeAttr("disabled");
		$("#shipmentPeriodSwitchDisplay").attr("disabled", "disabled");
	}
	
	else {
		$("#latestShipmentDateSwitchDisplay").attr("disabled", "disabled");
		$("#shipmentPeriodSwitchDisplay").removeAttr("disabled");
	}
}

var isInitial;

function initializeDataEntryShipmentsGoods() {
    disableShipmentFields();
    shipmentPeriodEditCheckBox();

    setLatestShipmentDate();
    $("#latestShipmentDateSwitchDisplay").click(onCheckLatestShipmentDate);
    onCheckLatestShipmentDate();

    isInitial = true;
    setShipmentPeriod();
    $("#shipmentPeriodSwitchDisplay").click(onCheckShipmentPeriod);
    onCheckShipmentPeriod();

    setGeneralDescriptionOfGoods();
    $("#generalDescriptionOfGoodsSwitchDisplay").click(onCheckGeneralDescriptionOfGoods);
    onCheckGeneralDescriptionOfGoods();
}

$(initializeDataEntryShipmentsGoods);
