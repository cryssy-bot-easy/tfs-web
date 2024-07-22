/**
 * Modified by: Rafael Ski Poblete
 * Date Modified: 08/28/18
 * Details : Added disableNarrative function to handle validations on Period For Presentation field.
 */
function onChangeReimbursingBankFlag() {
    var reimbursingBankFlag = $("input[type=radio][name=reimbursingBankFlag]:checked").val();

    if(reimbursingBankFlag == 'A') {
        $("#reimbursingBankIdentifierCode").removeAttr("readonly","readonly");
        $("#reimbursingBankNameAndAddress").attr("readonly","readonly");
        $("#reimbursingBankNameAndAddress").val("");
    } else if(reimbursingBankFlag == 'B') {
        $("#reimbursingBankIdentifierCode").attr("readonly","readonly");
        $("#reimbursingBankIdentifierCode").val("");
		$("#reimbursingBankNameAndAddress").removeAttr("readonly","readonly");
    }
}

function onChangeAdviceThroughBankFlag() {
    var adviceThroughBankFlag = $("input[type=radio][name=adviseThroughBankFlag]:checked").val();

    if(adviceThroughBankFlag == 'A') {
        $("#adviseThroughBankIdentifierCode").removeAttr("readonly","readonly");
        $("#adviseThroughBankLocation").attr("readonly","readonly");
        $("#adviseThroughBankLocation").val("");
        $("#popup_btn_advise_through_bank").hide();
        $("#adviseThroughBankNameAndAddress").attr("readonly","readonly");
        $("#adviseThroughBankNameAndAddress").val("");
    } else if(adviceThroughBankFlag == 'B') {
        $("#adviseThroughBankIdentifierCode").attr("readonly","readonly");
        $("#adviseThroughBankIdentifierCode").val("");
        $("#adviseThroughBankLocation").removeAttr("readonly","readonly");
        $("#popup_btn_advise_through_bank").hide();
        $("#adviseThroughBankNameAndAddress").attr("readonly","readonly");
        $("#adviseThroughBankNameAndAddress").val("");
    } else if(adviceThroughBankFlag == 'C') {
        $("#adviseThroughBankIdentifierCode").attr("readonly","readonly");
        $("#adviseThroughBankIdentifierCode").val("");
        $("#adviseThroughBankLocation").attr("readonly","readonly");
        $("#adviseThroughBankLocation").val("");
        $("#adviseThroughBankNameAndAddress").attr("readonly","readonly");
        $("#popup_btn_advise_through_bank").show();
    }
}

function onChangeAdviceThroughBankOpeningFlag() {
	var adviceThroughBankFlag = $("input[type=radio][name=adviseThroughBankOpeningFlag]:checked").val();
	
	if(adviceThroughBankFlag == 'A') {
		$("#adviseThroughBankIdentifierCode").select2("enable");
		$("#adviseThroughBankPopup").hide();
		$("#adviseThroughBankNameAndAddress").val("");
	} else if(adviceThroughBankFlag == 'D') {
		$("#adviseThroughBankIdentifierCode").select2("disable");
		$("#adviseThroughBankIdentifierCode").select2('data',null);
		$("#adviseThroughBankPopup").show();
	}
}

$(document).ready(function (){
    
	$("#popup_btn_advise_through_bank").hide();

    //for Opening
	if(serviceType == "Opening"){
		
		//for reimbursing bank
        $("input[type=radio][name=reimbursingBankFlag]").click(onChangeReimbursingBankFlag);
        onChangeReimbursingBankFlag();

        $("input[type=radio][name=adviseThroughBankFlag]").click(onChangeAdviceThroughBankFlag);
        onChangeAdviceThroughBankFlag();

        $("input[type=radio][name=adviseThroughBankOpeningFlag]").click(onChangeAdviceThroughBankOpeningFlag);
        onChangeAdviceThroughBankOpeningFlag();
		
	}
	function disableNarrative() {
		if($("#periodForPresentationNumber").val() !== null && $("#periodForPresentationNumber").val() !== "") {
			$("#periodForPresentation").removeAttr("readonly");
		} else {
			$("#periodForPresentation").attr("readonly", "true");
			$("#periodForPresentation").val("");
		}
	}
	$("#periodForPresentationNumber").keyup(function (event) {
				if (!/^[1-9]\d*$/.test(this.value)) {
					this.value = this.value.substr(0, this.value.length - 1);
				}
				disableNarrative();
		 	});
	$("#periodForPresentationNumber").keydown(function (event) {
		if (!/^[1-9]\d*$/.test(this.value)) {
			this.value = this.value.substr(0, this.value.length - 1);
		}
		disableNarrative();
 	});
	
	$("#periodForPresentationNumber").blur(function (event) {
		if (!/^[1-9]\d*$/.test(this.value)) {
			this.value = this.value.substr(0, this.value.length - 1);
		}
		disableNarrative();
 	});
});