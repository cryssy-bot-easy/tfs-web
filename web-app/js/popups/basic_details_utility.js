// open facility lookup
function onFacilityLookup() {
	loadPopup("facility_popup", "facility_search_bg");
	centerPopup("facility_popup", "facility_search_bg");
}

// close facility lookup
function onCloseFacilityLookup() {
    mDisablePopup($("#facility_popup"),$("#facility_search_bg"))
}

//function onLcAmountChange() {
//	var amount = $("#amount").val();
//    $("#bankCommissionLCAmountPopup, #commitmentFeeLCAmountPopup, #confirmingFeeLCAmountPopup, #documentaryStampLCAmountPopup, #totalAmountDueLc, #cilexLCAmountPopup").val(amount);
//}

function showSaveAsDraft(){
//	if ((title == 'FX Cash LC Opening eTS' && formId == '#basicDetailsTabForm' ) || ( title == 'FX Regular LC Opening eTS' && formId == '#basicDetailsTabForm' ) || ( title == 'FX Standby LC Opening eTS' && formId == '#basicDetailsTabForm' ) ){
//		$(".save_as_draft").show();
//	}else{
//		$(".save_as_draft").hide();
//	}

    $(".save_as_draft").hide();

    if(documentType == "FOREIGN" && title.indexOf("eTS") != -1 && formId == "#basicDetailsTabForm") {
        $(".save_as_draft").show();
    }
}

function onChangeTenor(){
    var tenor = $("#tenor").val();

	$("#documentSubType2").val(tenor);

	if (tenor == 'USANCE'){
		$("#usancePeriod").removeAttr("readonly");
		$("#tenorOfDraftNarrative").removeAttr("readonly");
		$(".commitment_fee").show();
		$("#usancePeriod").addClass("numericQuantity");

        $("#usancePeriod").toggleClass("required", true);
        $("#tenorOfDraftNarrative").toggleClass("required", true);
	}else{
		$("#usancePeriod").val("");
		$("#tenorOfDraftNarrative").val("");
		$("#usancePeriod").attr("readonly","readonly");
		$("#tenorOfDraftNarrative").attr("readonly","readonly");
		$(".commitment_fee").hide();		
		$("#usancePeriod").removeClass("numericQuantity");

        $("#usancePeriod").toggleClass("required", false);
        $("#tenorOfDraftNarrative").toggleClass("required", false);
	}


//    if((documentSubType1 == 'REGULAR' && (tenor == 'USANCE' || tenor == 'SIGHT')) || documentSubType1 == 'STANDBY') {
//        $("#facilityType").val("FCN");
//    } else {
//        $("#facilityType").val("");
//    }
}

function onPriceTermChange() {
    if(loggedInUser != "TSD"){
        var priceTerm = $("#priceTerm").val();

        $("#marineInsurance").removeAttr("disabled");

        if(priceTerm == "CIF" || priceTerm == "CIP") {
            $("#marineInsurance").attr("disabled", "disabled");
            $("#marineInsurance").val("");
        }
    }
}

function onExpiryDateChange() {
    var dateNow = newDate;
    var currentDate = new Date(dateNow.getFullYear(), dateNow.getMonth(), dateNow.getDate());

    var expiryDate = new Date(this.value);

    if(expiryDate < currentDate) {
        $("#alertMessage").text("Expiry Date should be greater than the current date.");
        triggerAlert();

        $("#expiryDate").val("");
    }
}

//function disableElementsIfUserIsTsd(){
//	var lUser=typeof loggedInUser!=='undefined'? loggedInUser:"";
//	var dSub1=typeof documentSubType1!=='undefined' ? documentSubType1:"";
//	var dSub2=typeof documentSubType2!=='undefined' ? documentSubType2:"";
//	var dClass=typeof documentClass!=='undefined'? documentClass:"";
//	var dRef=typeof referenceType!=='undefined' ? referenceType:"";
//	
//	//Disable all inputs if user is TSD and reference is ETS
////	if(lUser=="TSD"&&dSub1=="REGULAR"&&dSub2=="SIGHT"&&dClass=="LC"&&dRef=="ETS"){
//	if(lUser=="TSD"&&dRef=="ETS"){
////		$("#body_forms :input,#body_forms :button,#body_forms select,.select_dropdown").attr("disabled","disabled");
//		
//		$("#body_forms a#add_instruction").parents("ul.buttons").remove();
//		$("#body_forms a").not("ul#tabs *").remove();
//		
//        $("#body_forms :input").each(function(){
//            if($(this).attr("type") == "text" || $(this).attr("type") == "textarea") {
//                $(this).attr("readonly", "readonly");
//                if($(this).hasClass("datepicker_field")) {
//                	$(this).datepicker("destroy");
//                	$(this).removeClass("datepicker_field").addClass("input_field");
//                }
//            }else if($(this).attr("type")=="button" || $(this).attr("type")=="submit") {
//            	$(this).remove();
//            }else{
//            	$(this).attr("disabled", "disabled");
//            }
//        });
//        
//        $(".numericQuantity").removeClass("numericQuantity");
//		$(".numericCurrency").removeClass("numericCurrency");
//	}
//}


function initializeBasicDetails() {
	// for facility lookup
	
	$("#facility_lookup").click(onFacilityLookup);
	$(".facility_search_close").click(onCloseFacilityLookup);


//    onLcAmountChange();
//	$("#amount").change(onLcAmountChange);
	
	// for Tenor 
    if($("#tenor").length > 0) {
        onChangeTenor();
    }

	$("#tenor").change(onChangeTenor);
	
	// for basic details of fxlc opening(cash, standby, regular)
	$(showSaveAsDraft);
	$("#basicDetailsTab, #attachedDocumentsTab, #chargesTab, #chargesPaymentTab, #cashLcPaymentTab, #instructionsRoutingTab").click(showSaveAsDraft);

    $("#priceTerm").change(onPriceTermChange);
    onPriceTermChange();

    $("#expiryDate").change(onExpiryDateChange);
    
//    disableElementsIfUserIsTsd();
}



$(initializeBasicDetails);