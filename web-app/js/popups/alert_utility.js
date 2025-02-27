//	PROLOGUE:
//	(revision)
//	SCR/ER Number: 20160218-092
//	SCR/ER Description: redmine 4086 - AMLA Error in CTR1 Daily Monitoring as of December 15, 2015
//	[Revised by:] Maximo Brian Lulab
//	[Date revised:] 3/10/2016
//	Program [Revision] Details: The fields accept input with any first String,but AMLA should have first character/alphabet.
//                              to catch exception if field/s are hidden.
//								to catch exception of the names per tab.
//	Date deployment: 3/15/2016 
//	Member Type: javascript
//	Project: WEB
//	Project Name: alert_utility.js

/**
 	(revision)
	SCR/ER Number: SCR# IBD-15-1125-01
	SCR/ER Description: Added Regular expression for Buyer and Seller Address
	[Revised by:] Jonh Henry Santos Alabin
	[Date revised:] 1/12/2017
	Program [Revision] Details: Revision in the conditional Statements for the validation upon saving if change in Buyer or Seller Info(checkbox) was checked but the new Amount was left unfilled. 
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: alert_utility.js
 */

/**
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy Module
	[Revised by:] John Patrick C. Bautista
	[Date revised:] July 19, 2017
	[Date deployed:]
	Program [Revision] Details: Added more validation for Discrepancy tab fields 
	Member Type: JavaScript file (JS)
	Project: WEB
	Project Name: alert_utility.js
 */
/**
 	(revision)
	[Revised by:] Cedrick C. Nungay
	[Date revised:] October 20, 2018
	[Date deployed:]
	Program [Revision] Details: Modified setting of required documents and additional conditions for MT707.
	Member Type: JavaScript file (JS)
	Project: WEB
	Project Name: alert_utility.js
 */

/**
 	(revision)
	[Modified by:] Rafael Ski Poblete
	[Date Modified:] July 28, 2018
	[Details:] Fixed bug on passing special character to JSON stringify that causes error.
 */


var formChanged = "";
var formIsChanged = false;
var docReqSaveType = "";
var addCondType = "";
var transLetterType = "";

var mtUrl = "";
var action = "";
var idToDelete = "";
var regexp1 = /^[a-zA-Z]{1}/;
var regexp2 = /^[a-zA-Z0-9]{1}/;
var _pageHasErrors=false;

function onRouteClick() {
    action = "route";
    openAlert();
}

function onDoneClick() {
    action = "close";
    openAlert();
}

function onReturnClick() {
    action = "return";
    openAlert();
}

function onTransmitClick(gotoUrl) {
    mtUrl = gotoUrl;
    action = "transmit";
    openAlert();
}

function onDiscardClick(gotoUrl) {
    mtUrl = gotoUrl;
    action = "discard";
    openAlert();
}

function onReverseClick2(gotoUrl) {
    mtUrl = gotoUrl;
    action = "reverse";
    openAlert();
}

function onSaveClick(e) {
//for testing purpose only
//   if(!validateIndemnityIssuance()) return;
//   if(!validateEtsUaLoanSettlement())	return;
//   if(!validateDataEntryUaLoanSettlement()) return;
//   if(!validateEtsDuaLoanSettlement()) return;
    var referenceType = $("#referenceType").val();
    var serviceType = $("#serviceType").val();

    if($("#serviceType").val() == 'Amendment' ){

    } else {
        if(referenceType.toUpperCase()=="ETS"){
            if(parseInt($("#amount").val())<=0){
                $("#alertMessage").text("LC Amount cannot be zero");
                triggerAlert();
                return;
            }
        }
    }


    
    var okToContinue = negotiationPartialShipmentChecker(referenceType, serviceType);  // Negotiation
    if (okToContinue) {
        action = "save";
		if("undefined" !== formId && "#instructionsAndRoutingTabForm" == formId){
			openAlert();
		}else{
			confirmAlert();
		}
    }
}


// START GENERAL
function onSaveValidate(event) {
//for testing purpose only
//   if(!validateIndemnityIssuance()) return;
//   if(!validateEtsUaLoanSettlement())	return;
//   if(!validateDataEntryUaLoanSettlement()) return;
//   if(!validateEtsDuaLoanSettlement()) return;
	var referenceType = $("#referenceType").val();
	var serviceType = $("#serviceType").val();
	var buttonParentId=typeof formId !== 'undefined' ? formId.slice(1) : $(this).parents("form").attr("id");

	if(formId == "#basicDetailsTabForm" || formId == "#chargesTabForm" || formId == "#chargesPaymentTabForm" || formId == "#proceedsTabForm" || formId == "#natureOfAmendmentTabForm"
			|| formId == "actualCorresChargesTabForm") {
    	mCenterPopup($("#loading_div"), $("#loading_bg"));
    	mLoadPopup($("#loading_div"), $("#loading_bg"));
	}

	if($("#serviceType").val() == 'Amendment' ){

    } else {
        if(referenceType.toUpperCase()=="ETS"){
            if(parseInt($("#amount").val())<=0){
                $("#alertMessage").text("LC Amount cannot be zero");
                triggerAlert();
                return;
            }
        }
    }

	if (formId == "#documentsRequiredTabForm" && $('#documentType').val() == 'FOREIGN' &&
		$('#serviceType').val() == 'Amendment' &&
		($('#documentSubType1').val() == 'CASH' || $('#documentSubType1').val() == 'REGULAR')) {
		var hasError = false, alert_msg = '';
		if ($('#specialPaymentConditionsForBeneficiaryTo').hasClass('required') && $('#specialPaymentConditionsForBeneficiaryTo').val() == '') {
			alert_msg += 'specialPaymentConditionsForBeneficiaryTo<br/>';
			hasError = true;
		}
		if ($('#specialPaymentConditionsForReceivingBankTo').hasClass('required') && $('#specialPaymentConditionsForReceivingBankTo').val() == '') {
			alert_msg += 'specialPaymentConditionsForReceivingBankTo<br/>';
			hasError = true;
		}
		if (hasError) {
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );
			return;
		}
	}

	/*
	 	Combined all openSaveConfirmation click events into one. 
		Hirap mag edit pag ang daming click event handler (~_~!)
	*/
	if(formId != "#basicDetailsTabForm") {
	  // start of max validation of redmine 4086  ERF-20160218-092 as of 03/15/2016 catch exception if names are not  in  basic details tab only
		_pageHasErrors=false;  
		$("#additional_details_tab :input").each(function(){
		//seller name
		if($("#beneficiaryNameSwitch").val() == 'on'){
			
			if($("#beneficiaryNameTo").val() == "" || $("#beneficiaryNameTo").val() == null){  
				alert_msg = "Seller name";
				triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
				_pageHasErrors=true;   
				
			} else if ($("#beneficiaryNameTo").val() != "" || $("#beneficiaryNameTo").val() != null) {                
				if((!regexp1.test($("#beneficiaryNameTo").val()))  || (!regexp1.test($("#beneficiaryNameTo").val())) ){
					triggerAlertMessage("Seller name should start with a letter");                                            
					_pageHasErrors = true;                                                                             
				}                                                                                                 
			} 
			
		} 
		
		//seller address
		
		if($("#beneficiaryAddressSwitch").val() == 'on'){
			
			if($("#beneficiaryAddressTo").val() == "" || $("#beneficiaryAddressTo").val() == null){  
				alert_msg = "Seller Address";
				triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
				_pageHasErrors=true;   
				
			} else if ($("#beneficiaryAddressTo").val() != "" || $("#beneficiaryAddressTo").val() != null) {                
				if((!regexp2.test($("#beneficiaryAddressTo").val()))  || (!regexp2.test($("#beneficiaryAddressTo").val())) ){
					triggerAlertMessage("Seller Address should start with a letter or number");                                            
					_pageHasErrors = true;                                                                             
				}                                                                                                 
			} 
			
		} 
		
		//buyer name
		
		if($("#applicantNameSwitch").val() == 'on'){
			
			if($("#applicantNameTo").val() == "" || $("#applicantNameTo").val() == null){  
				alert_msg = "Buyer Name";
				triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
				_pageHasErrors=true;   
				
			} else if ($("#applicantNameTo").val() != "" || $("#applicantNameTo").val() != null) {                
				if((!regexp1.test($("#applicantNameTo").val()))  || (!regexp1.test($("#applicantNameTo").val())) ){
					triggerAlertMessage("Buyer Name should start with a letter");                                            
					_pageHasErrors = true;                                                                             
				}                                                                                                 
			} 
			
		}
		
		// buyer address
		
		if($("#applicantAddressSwitch").val() == 'on'){
			
			if($("#applicantAddressTo").val() == "" || $("#applicantAddressTo").val() == null){  
				alert_msg = "Buyer Address";
				triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
				_pageHasErrors=true;   
				
			} else if ($("#applicantAddressTo").val() != "" || $("#applicantAddressTo").val() != null) {                
				if((!regexp2.test($("#applicantAddressTo").val()))  || (!regexp2.test($("#applicantAddressTo").val())) ){
					triggerAlertMessage("Buyer Address should start with a letter or number");                                            
					_pageHasErrors = true;                                                                             
				}                                                                                                 
			} 
			
		} 
		});
		
		if (formId == "#discrepancyTabForm") {
			var missingField = "";

			if ($("#overdrawnForAmountSwitchDisplay").attr("checked") == "checked" && 
					$("#overdrawnForAmountSwitch").val() == "on" &&
					$("#overdrawnForAmount").val() == "") {
				missingField += "Overdrawn for (Amount)<br/>";
				_pageHasErrors = true;    
			}
			if ($("#descriptionOfGoodsNotPerLcSwitchDisplay").attr("checked") == "checked" && 
					$("#descriptionOfGoodsNotPerLcSwitch").val() == "on" &&
					$("#descriptionOfGoodsNotAsPerLc").val() == "") {
				missingField += "Description of Goods not as per LC<br/>";
				_pageHasErrors = true;    
			} 
			if ($("#documentsNotPresentedSwitchDisplay").attr("checked") == "checked" && 
					$("#documentsNotPresentedSwitch").val() == "on" &&
					$("#documentsNotPresented").val() == "") {
				missingField += "Documents not Presented<br/>";
				_pageHasErrors = true;    
			} 
			if($("#othersSwitchDisplay").attr("checked") == "checked" && 
					$("#othersSwitch").val() == "on" &&
					$("#others").val() == "") {
				missingField += "Others<br/>";
				_pageHasErrors = true;    
			} 
			
			// 07182017 - FX/DM LC Cash/Regular/Standby Nego Discrepancy validations -- START
			// Checkboxes
			var allMissingValues = false;
			var expiredLcSwitch = $("#expiredLcSwitch").val();
			var overdrawnForAmountSwitch = $("#overdrawnForAmountSwitch").val();
			var descriptionOfGoodsNotPerLcSwitch = $("#descriptionOfGoodsNotPerLcSwitch").val();
			var documentsNotPresentedSwitch = $("#documentsNotPresentedSwitch").val();
			var othersSwitch = $("#othersSwitch").val();
			// Textareas
			var overdrawnForAmount = $("#overdrawnForAmount").val();
			var descriptionOfGoodsNotAsPerLc = $("#descriptionOfGoodsNotAsPerLc").val();
			var documentsNotPresented = $("#documentsNotPresented").val();
			var others = $("#others").val();
			if( expiredLcSwitch != "off" || overdrawnForAmountSwitch != "off" || descriptionOfGoodsNotPerLcSwitch != "off" 
				|| documentsNotPresentedSwitch != "off" || othersSwitch != "off" || overdrawnForAmount != ""  
				|| descriptionOfGoodsNotAsPerLc != "" || documentsNotPresented != "" || others != "" ){
				// Allow saving
				allMissingValues = false;
			} else {
				// Intercept saving
				allMissingValues = true;
				_pageHasErrors = true;
			}
			// -- END

			if (_pageHasErrors == true) {
				if( allMissingValues == false ){
					triggerAlertMessage("Missing Required Fields:<br/>" +  missingField );
				} else {
					triggerAlertMessage("Missing Required Field: Discrepancy Details.")
				}
				mDisablePopup($("#loading_div"), $("#loading_bg"));
			}
		}
		
		
  // end of max validation of redmine 4086
	if('function' === typeof validateFxlcOpeningEts){
//		alert("validateFxlcOpeningEts");
        validateFxlcOpeningEts(buttonParentId);
	}
	if('function' === typeof validateChargesTab){
//		alert("validateChargesTab");
		validateChargesTab(buttonParentId);
	}
	if('function' === typeof validateAmendmentEts){
//		alert("validateAmendmentEts");
		validateAmendmentEts(buttonParentId);
	}
	if('function' === typeof validateFxlcDataEntryAmendment){
//        alert("validateFxlcDataEntryAmendment")
		validateFxlcDataEntryAmendment(buttonParentId);
	}
	if('function' === typeof validateDmlcOpeningDataEntry){
//		alert("validateDmlcOpeningDataEntry");
      validateDmlcOpeningDataEntry(buttonParentId);
	}
	if('function' === typeof validateDmlcOpeningEts){
//		alert("validateDmlcOpeningEts");
		validateDmlcOpeningEts(buttonParentId);
	}
	if('function' === typeof validateFxlcOpeningDataEntry){
//		alert('validateFxlcOpeningDataEntry');
        // removes error caused when event is null
        var eventId = "";
        if (event != undefined) {
            eventId = event.target.id;
        }

		validateFxlcOpeningDataEntry(buttonParentId, eventId);
	}
	if('function' === typeof validateFxlcOpeningPayment){
//		alert("validateFxlcOpeningPayment");
		validateFxlcOpeningPayment(buttonParentId);
	}
//    alert(documentClass + " " + serviceType + " " + formId)
	if('function' === typeof validateIndemnityIssuance && formId != "#chargesTabForm"){
//		alert("validateIndemnityIssuance");
		validateIndemnityIssuance(buttonParentId);
	}
	if('function' === typeof validateFxlcIndemnityIssuanceDataEntry){
		validateFxlcIndemnityIssuanceDataEntry(buttonParentId);
	}
	if('function' === typeof validateNegotiation){
//		alert("validateNegotiation");
		validateNegotiation(buttonParentId);
	}
	if('function' === typeof validateNonLc){
//        alert("validateNonLc")
		validateNonLc(buttonParentId);
	}
	if('function' === typeof validatePddts){
//        alert("validatePddts")
		validatePddts(buttonParentId);
	}
	
	if('function' === typeof validateDmlcEts && formId != "#chargesTabForm"){ // this also applies to FXLC ETS
//        alert("validateDmlcEts")
        var result = validateChangeInCif();

        if (result == "failed") {
            $("#alertMessage").text("There is a change in CIF Number. Please update Main CIF Number" + ((documentSubType1.toUpperCase() == "CASH") ? "." : " and Facility ID."));
            triggerAlert();
            mDisablePopup($("#loading_div"), $("#loading_bg"));
            return;
        } else {
            validateDmlcEts(buttonParentId);
        }
	}
	
	if('function' === typeof validateLcCancellation){
//        alert("validateLcCancellation")
		validateLcCancellation(buttonParentId);
	}
	
	if('function' === typeof validateDmlcUaLoanMaturityAdjustmentEts){
//        alert("validateDmlcUaLoanMaturityAdjustmentEts")
		validateDmlcUaLoanMaturityAdjustmentEts(buttonParentId);
	}
	if('function' === typeof validateFxlcUaLoanMaturityAdjustmentEts){
//        alert("validateFxlcUaLoanMaturityAdjustmentEts")
		validateFxlcUaLoanMaturityAdjustmentEts(buttonParentId);
	}
	if('function' === typeof validateNegoDiscrepancDataEntry){
//        alert("validateNegoDiscrepancDataEntry")
		validateNegoDiscrepancDataEntry(buttonParentId);
	}
	if('function' === typeof validateProceedsSummary && "proceedsDetailsTabForm" == buttonParentId ){
//        alert("validateProceedsSummary")
		validateProceedsSummary();
	}
	
	if('function' === typeof validatePaymentTab && formId != "#chargesTabForm"){
//        alert("validatePaymentTab")
		validatePaymentTab(buttonParentId);
	}
	
	if('function' === typeof validateFxUaLoanSettlement){
		validateFxUaLoanSettlement(buttonParentId);
	}

	if('function' === typeof validateBasicDetailsTab){
		validateBasicDetailsTab(buttonParentId)
	}
	
	if('function' === typeof validateApMonitoringApplicationDataEntry){
		validateApMonitoringApplicationDataEntry(buttonParentId)
	}
	
	if('function' === typeof validateApMonitoringSetupDataEntry){
		validateApMonitoringSetupDataEntry(buttonParentId)
	}

    /*if ('function' === typeof validateRequiredMT103 && formId == "#mt103TabForm") {
        var result = validateRequiredMT103();

        if (result == 'failed') {
            triggerAlertMessage("Please fill up all required fields.");
            return;
        }
    }*/
	} else {
		var error = 0;
		var alert_msg = "";
		_pageHasErrors=false;
		var field_name;
		$("#basicDetailsTabForm :input").each(function(){
	        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
	           if ($(this).val() == "" && !($(this).attr("type") in {"radio":1,"check":1})) {
	               error ++;
	               if(alert_msg.length > 0){
	            	   alert_msg += ",<br/>";
	               }
                   alert_msg += $(this).attr("name");
	           } else if ($(this).attr("type") in {"radio":1,"check":1}){
	        	   if($(this).attr("name") != field_name){
		        	   var isChecked = false;
		        	   var name_field = $(this).attr("name");
		        	   if($("#basicDetailsTabForm input[name="+name_field+"]:checked").length > 0)
		        		   isChecked = true;
		        	   if (!isChecked){
		        		   error ++;
			               if(alert_msg.length > 0){
			            	   alert_msg += ",<br/>";
			               }
		                   alert_msg += $(this).attr("name");
		        	   }
	        	   }
	           }
	            // start of max validation of redmine 4086  ERF-20160218-092 as of 03/15/2016 catch exception of not hidden fields
	           if( $("#beneficiaryName").attr("type") != "hidden" || $("#applicantName").attr("type") != "hidden"){
	        	   if((!regexp1.test($("#exporterName").val())) || (!regexp1.test($("#importerName").val())) || (!regexp1.test($("#beneficiaryName").val())) || (!regexp1.test($("#applicantName").val()))) {
	        		   triggerAlertMessage("Name should start with a letter");
						_pageHasErrors = true;  
	        	  }else
	        		  _pageHasErrors = false;
	           }
	            // end of max validation of redmine 4086
	        }
	    });
	  // start of max validation of redmine 4086  ERF-20160218-092 as of 03/15/2016 catch exception if names are in  basic details tab only
		$("#basic_details_tab :input").each(function(){

			if($("#importerNameSwitch").val() == 'on'){
					if($("#importerNameTo").val() == "" || $("#importerNameTo").val() == null  ){
				if(($("#importerNameTo").val() == "" || $("#importerNameTo").val() == null)){
					alert_msg = "Importer Name";
					triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );
					_pageHasErrors=true;
				}
			}else if(($("#importerNameTo").val() != "" || $("#importerNameTo").val() != null)  ){
				if((!regexp1.test($("#importerNameTo").val()))  || (!regexp1.test($("#importerNameTo").val())) ){
					triggerAlertMessage("Name should start with a letter");
					_pageHasErrors = true;
				}
			}
			}

			if($("#exporterNameSwitch").val() == 'on'){
				if($("#exporterNameTo").val() == "" || $("#exporterNameTo").val() == null  ){
					if(($("#exporterNameTo").val() == "" || $("#exporterNameTo").val() == null)){
						alert_msg = "Exporter Name";
					}
					triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );
					_pageHasErrors=true;
				}else if(($("#exporterNameTo").val() != "" || $("#exporterNameTo").val() != null)  ){
	    			if((!regexp1.test($("#exporterNameTo").val()))  || (!regexp1.test($("#exporterNameTo").val())) ){
	    				triggerAlertMessage("Name should start with a letter");
	    				_pageHasErrors = true;
	    			}
	    		}
			}
			
			//address validation
			
			if($("#importerAddressSwitch").val() == 'on'){
				if($("#importerAddressTo").val() == "" || $("#importerAddressTo").val() == null  ){
					if(($("#importerAddressTo").val() == "" || $("#importerAddressTo").val() == null)){
						alert_msg = "Importer Address";
						triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );
						_pageHasErrors=true;
					}
				}else if(($("#importerAddressTo").val() != "" || $("#importerAddressTo").val() != null)  ){
					if((!regexp2.test($("#importerAddressTo").val()))  || (!regexp2.test($("#importerAddressTo").val())) ){
						triggerAlertMessage("Address should start with a letter or number");
						_pageHasErrors = true;
					}
				}
			}

			if($("#exporterAddressSwitch").val() == 'on'){
				if($("#exporterAddressTo").val() == "" || $("#exporterAddressTo").val() == null  ){
					if(($("#exporterAddressTo").val() == "" || $("#exporterAddressTo").val() == null)){
						alert_msg = "Exporter Address";
						triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );
						_pageHasErrors=true;
					}
				}else if(($("#exporterAddressTo").val() != "" || $("#exporterAddressTo").val() != null)  ){
					if((!regexp2.test($("#exporterAddressTo").val()))  || (!regexp2.test($("#exporterAddressTo").val())) ){
						triggerAlertMessage("Address should start with a letter or number");
						_pageHasErrors = true;
					}
				}
			}
	    });
		   // end of max validation of redmine 4086
		if ($("#cifNumber").attr("class") != undefined && $("#cifNumber").attr("class") != null && $("#cifNumber").attr("class").indexOf("required") != -1) {
	        if ($("#cifNumber").val() == "") {
	            error ++;
	            if(alert_msg.length > 0){
	            	   alert_msg += "<br/>";
	               }
                alert_msg += "cifNumber";
	        }
	    }

		
		if(error > 0){
			triggerAlertMessage("Missing Required Fields:<br/>"+alert_msg);
			_pageHasErrors=true;
		}
	}

	var okToContinue = negotiationPartialShipmentChecker(referenceType, serviceType);  // Negotiation
	if(!_pageHasErrors && okToContinue){
		action = "save";
		if("instructionsAndRoutingTabForm" == buttonParentId){
			/*if ($("#chargesTabForm").length > 0){
				validaseSavedCharges();
			} else {*/
				openAlert();
//			}
		}else{
			confirmAlert();
		}
	} else {
		mDisablePopup($("#loading_div"), $("#loading_bg"));
    }
}

function doBalanceCheck2(pollLimit, transactionSequenceNumber) {
	console.log('sequence number: ' + transactionSequenceNumber);
	
	var params = {
	        balanceQueryRequestId: transactionSequenceNumber
	    };

	    mLoadPopup($("#loading_div"), $("#loading_bg"));
	    mCenterPopup($("#loading_div"), $("#loading_bg"));

	    $.post(getFacilityBalanceResult, params,function (data) {
	        console.log(JSON.stringify(data));
	        console.log(data.status);

	        if (data.status == 'pending') {
	            if (pollLimit < 6) {
	                pollLimit++;
	                setTimeout(function () {
	                    doBalanceCheck2(pollLimit, transactionSequenceNumber);
	                }, 6000); // wait 6 seconds then retry
	            } else {
	                mDisablePopup($("#loading_div"), $("#loading_bg"));
	                $("#overAvailment").val("NOTE: No response received from Silverlake.");
	                $(".overAvailment").html("NOTE: No response received from Silverlake.");
	            }
	        } else if (data.status == 'rejected') {
	            mDisablePopup($("#loading_div"), $("#loading_bg"));
//	            $("#overAvailment").val("NOTE: Transaction has been rejected.");
//	            $(".overAvailment").html("NOTE: Transaction has been rejected.");
	        } else if (data.status != 'rejected') {
	            mDisablePopup($("#loading_div"), $("#loading_bg"));
	            if (data.isBalanceSufficient == true) {
	            	$("#overAvailment").val(" ");
	            	$(".overAvailment").html(" ");
	            } else if (data.hasCramApproval == true) {
	                $("#overAvailment").val("NOTE: There is an over-availment in facility. Facility balance is: PHP " + data.balance);
	                $(".overAvailment").html("NOTE: There is an over-availment in facility. Facility balance is: PHP " + data.balance);
	            } else {
	                $("#overAvailment").val("NOTE: Facility balance is insufficient. Current balance is: PHP " + data.balance);
	                $(".overAvailment").html("NOTE: Facility balance is insufficient. Current balance is: PHP " + data.balance);
	            }

	        }
	    });
}

/*function validateSavedCharges(){
	var postUrl = validateSavedChargesUrl
    var rates;
	switch ($("#settlementCurrency").val()){
	case "PHP":
		rates = 1
		break;
	case "USD":
		rates = parseFloat($("#USD-PHP_urr").val());
		break;
	default:
		rates = parseFloat($("#USD-PHP_urr").val() * $("#" + $("#settlementCurrency").val() + "-USD_special_rate_charges").val());
	}
	var params = {tradeServiceId: $("#tradeServiceId").val(),
				  rates: rates};

    $("#chargesTabForm :input").each(function(){
        if($(this).attr("type") == "text" && $(this).parents("table").hasClass("charges_table") && $(this).attr("id") != "totalAmountCharges"){
            params[$(this).attr("id")] = $(this).val();
        }
    });
	$.post(postUrl, params, function(data){
		var error = 0
		for(var key in data){
			console.log(data[key]);
			error++;
		}
		if(error > 0) {
			$("#alertMessage").text("Charges did not match.");
		    triggerAlert();
		} else {
			openAlert();
		}
	});
}*/

function validateChangeInCif(){
    var result = "success";
    if ($("#serviceType").val().toUpperCase() == "ADJUSTMENT") {
        if ($("#cifNumberTo").length > 0 &&
            $("#cifNumberFrom").length > 0 &&
            $("#cifNumberFlag").length > 0 &&
            $("#cifNumberFlag").attr("checked") == "checked" &&
            $("#mainCifNumberTo").length > 0) {

            var cifNumberFrom = $("#cifNumberFrom").val();
            var cifNumberTo = $("#cifNumberTo").val();
            var mainCifNumberTo = $("#mainCifNumberTo").val();

            if ((cifNumberTo != "" && cifNumberFrom != cifNumberTo) &&
                mainCifNumberTo == "") {
                result = "failed";
            } else {
                if ($("#facilityIdTo").length > 0) {
                    if ($("#facilityIdTo").val() == "") {
                        result = "failed";
                    }
                }
            }
        }
    }
    return result;
}

function onCloseClick() {
	action = "";
	closeAlert();

    $("#statusAction").val("");
}

function onCancelClick(){
		
	//global var on input_field_filter_regexp.js
	glb_srl_tab.params_after = $("form"+formId,"div#body_forms").serialize();
	
	if(glb_srl_tab.params_after != glb_srl_tab.params_before & formId == "#basicDetailsTabForm"){
		action="save";
		openAlertConfirmationPopup();
	}else if(glb_srl_tab.params_after != glb_srl_tab.params_before & formId != "#basicDetailsTabForm"){
		action="save";
		openAlert2();
	}else if(glb_srl_tab.params_after == glb_srl_tab.params_before & formId == "#basicDetailsTabForm"){
		action="gotounacted";
		confirmAlert();
	}else{
		location.reload(true);
	}
}

function validateInputInCancelButton(){
	closeAlertConfirmationPopup();
	closeAlert2();
	onSaveValidate();
	if(_pageHasErrors){
		return;
	}
	closeAlert();
	//if user clicked yes on cancel popup
	if("yesBtnBD" == $(this).attr("id") && typeof formId !== 'undefined'){
		$(formId).append("<input type='hidden' name='cancelBd' value='true'/>");
	}
	action="save";
	confirmAlert();
}


function onNoAlert2(){
	action="";
	$("#statusAction").val("");
	if($(this).attr("id") == "noBtnBD"){
		action="gotounacted";
		confirmAlert();
	}else{
		location.reload(true);
	}
}

function onCancelAlert2(){
	action = "";
	$("#statusAction").val("");
	closeAlert2();
}

function onAlertConfirmationCancel(){
	action = "";
	$("#statusAction").val("");
	closeAlertConfirmationPopup();
}


function onDeleteClick() {
	action = "delete";
	openAlert();
}
 
// opens save alert
function openAlert() {
    if ('undefined' !== typeof formIsChanged && formIsChanged == true) {
        if (formId != formChanged) {
            triggerAlertMessage("There were unsaved changes.");
            return;
        }
    }
    var mSave_div = $("#popup_save_confirmation");
    var mBg = $("#confirmation_background");

    mLoadPopup(mSave_div, mBg);
    mCenterPopup(mSave_div, mBg);

}

function openAlertWithoutChangeValidate() {
    var mSave_div = $("#popup_save_confirmation");
    var mBg = $("#confirmation_background");

    mLoadPopup(mSave_div, mBg);
    mCenterPopup(mSave_div, mBg);

}

// TODO: this is the updated version
//function openAlert() {
//    if (validateFormChange() == "failed") {  // validate form change
//        triggerAlertMessage("There were unsaved changes.");
//    } else {
//
//        if (validatePaymentBalance() == "failed") {
//            triggerAlertMessage("Please setup Payment before Preparing.");
//        } else {
//            var mSave_div = $("#popup_save_confirmation");
//            var mBg = $("#confirmation_background");
//
//            mLoadPopup(mSave_div, mBg);
//            mCenterPopup(mSave_div, mBg);
//        }
//    }
//}

//function validatePaymentBalance() {
//    if ($(".cash_lc_payment_tab").is(":hidden") == false &&
//        $("#remainingBalanceLc").length > 0 && $("#remainingBalanceLc").val() != "0.00") {
//        console.log("there is product payment tab and balance is " + $("#remainingBalanceLc").val());
//        return "failed";
//    }
//
//    if ($(".charges_payment_tab").is(":hidden") == false &&
//        $("#remainingBalance").length > 0 && $("#remainingBalance").val() != "0.00") {
//        console.log("there is service charge payment tab and balance is " + $("#remainingBalance").val());
//
//        return "failed";
//    }
//
//    return "success";
//}

//function validateFormChange() {
//    if (formIsChanged == true) {
//        if (formId != formChanged) {
//            return "failed";
//        }
//    }
//
//    return "success";
//}

// closes save alert
function closeAlert() {
	var mSave_div = $("#popup_save_confirmation");
	var mBg = $("#confirmation_background");
	
	mDisablePopup(mSave_div, mBg);

    $("#saveAs").val("");
}

//opens save alert 2
function openAlert2(){

	var mSave_div = $("#popup_save_confirmation_cancel");
	var mBg = $("#popup_save_confirmation_cancel_bg");

	mLoadPopup(mSave_div, mBg);
	mCenterPopup(mSave_div, mBg);
}

//opens alert confirmation save in basic details
function openAlertConfirmationPopup(){
	var mSave_div = $("#popup_cancel_basic_details");
	var mBg = $("#alert_confirmation_bg");
	
	mLoadPopup(mSave_div, mBg);
	mCenterPopup(mSave_div, mBg);
}

//closes alert confirmation save in basic details
function closeAlertConfirmationPopup(){
	var mSave_div = $("#popup_cancel_basic_details");
	var mBg = $("#alert_confirmation_bg");
	
	mDisablePopup(mSave_div, mBg);

    $("#saveAs").val("");
}

// closes save alert 2
function closeAlert2() {
	var mSave_div = $("#popup_save_confirmation_cancel");
	var mBg = $("#popup_save_confirmation_cancel_bg");
	
	mDisablePopup(mSave_div, mBg);

    $("#saveAs").val("");
}

// confirms saving
function confirmAlert() {

    var postUrl = "";
	// do save action
	if(action == "save") {
	    postUrl = saveUrl;
        var referenceType = $("#referenceType").val();
        var documentClass = $("#documentClass").val();
        var serviceType = $("#serviceType").val();

		// if basic details tab
		if(formId != "#basicDetailsTabForm") {
		    postUrl = updateUrl;
//            if(referenceType == "ETS") {
//                $(formId).append($("#etsNumber"));
//            } else if(referenceType == "DATA_ENTRY" || referenceType == "PAYMENT"){
//                $(formId).append($("#documentNumber"));
//                $(formId).append($("#tradeServiceId"));
//            }
		}else{
            if((referenceType == "ETS" && $("#etsNumber").val()) || (referenceType == "DATA_ENTRY" && $("#tradeServiceId").val())) {
                postUrl = updateUrl;
            }
        }
			
		// if instructions routing tab
		if(formId == "#instructionsAndRoutingTabForm") {
			// to prevent multiple clicking of Yes
			mDisablePopup($("#popup_save_confirmation"), $("#confirmation_background"));
			mCenterPopup($("#loading_div"), $("#loading_bg"));
			mLoadPopup($("#loading_div"), $("#loading_bg"));
            if(!activePopupDiv) {
                postUrl = updateStatusUrl;
            }else{
            	//Commented-out BUG#3176: user have to click the row for this to work, if the user clicked edit link
            	//without clicking the row, this will return null
//                var id = $("#grid_list_instructions_routing_remarks").jqGrid('getGridParam','selrow');
//                var row = $("#grid_list_instructions_routing_remarks").jqGrid('getRowData',id);
                
                if('editInstructions' == $("#instructionAction").val()) {
                    postUrl = updateRemarksUrl + "?referenceType=" + $("#referenceType").val();
                }else{
                    postUrl = addRemarksUrl + "?referenceType=" + $("#referenceType").val();
                }
                var params;
                if(referenceType == "ETS") {
                    params = {
                        serviceType: $("#serviceType").val(),
                        documentType: $("#documentType").val(),
                        documentClass: $("#documentClass").val(),
                        documentSubType1: $("#documentSubType1").val(),
                        documentSubType2: $("#documentSubType2").val(),
                        etsNumber: $("#etsNumber").val(),
                        form: "instructionsAndRouting",
                        comment: $("#addInstruction").val(),
                        cifNumber: $("#cifNumber").val(),
                        statusAction: $("#statusAction").val(),
                        message: $("#message").val().toUpperCase(),
                        id : rowId//var from instructions_routing_tab
                    }
                } else if(referenceType == "DATA_ENTRY") {
                    params = {
                        serviceType: $("#serviceType").val(),
                        documentType: $("#documentType").val(),
                        documentClass: $("#documentClass").val(),
                        documentSubType1: $("#documentSubType1").val(),
                        documentSubType2: $("#documentSubType2").val(),
//                        documentNumber: $("#documentNumber").val(),
                        tradeServiceId: $("#tradeServiceId").val(),
                        form: "instructionsAndRouting",
                        comment: $("#addInstruction").val(),
                        cifNumber: $("#cifNumber").val(),
                        statusAction: $("#statusAction").val(),
                        message: $("#message").val().toUpperCase(),
                        id : rowId
                    }
                }

                disablePopup(activePopupDiv, activePopupBg);
                // add / edit remarks via ajax
                $.post(postUrl, params, function(data) {
                    closeAlert();
                    var gridRemarksUrl = getRemarks;

                    gridRemarksUrl += "?referenceType="+$("#referenceType").val();
                    $("#instructionAction").val("");
//                    $('#grid_list_instructions_routing_remarks').jqGrid('setGridParam', {url: getRemarks, page: 1}).trigger("reloadGrid");
                    $('#grid_list_instructions_routing_remarks').jqGrid('setGridParam', {url: gridRemarksUrl, page: 1}).trigger("reloadGrid");
                }).always(function(){
                	mDisablePopup($("#loading_div"), $("#loading_bg"));
                });
//                closeAlert();
//                $("#instructionAction").val("");
//                $('#grid_list_instructions_routing_remarks').jqGrid('setGridParam', {url: getRemarks, page: 1, datatype : 'json'}).trigger("reloadGrid");
                return true;
            }
		}
		
        // if charges payment tab
        if(formId == "#chargesPaymentTabForm") {
        	if($("#grid_list_charges_payment").length > 0) {
                var paymentsummarydata = $("#grid_list_charges_payment").jqGrid("getRowData");

                $("#chargesPaymentSummary").val(JSON.stringify(paymentsummarydata));
        	}

            if(referenceType == "PAYMENT") {
                postUrl = payUrl;
            }
        }
        // if cash lc payment tab
        if(formId == "#cashLcPaymentTabForm" || formId == "#paymentDetailsTabForm" || formId == "#proceedsDetailsTabForm") {
            if(formId == "#proceedsDetailsTabForm") {
                if($("#grid_list_proceeds_payment_summary").length > 0) {
                    var proceedspaymentsummarydata = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
                    $("#proceedsPaymentSummary").val(JSON.stringify(proceedspaymentsummarydata));
                }
            } else {
                if($("#grid_list_refund_branch").length > 0) {
                    var appayment = $("#grid_list_refund_branch").jqGrid("getRowData");
                    $("#documentPaymentSummary, #proceedsPaymentSummary").val(JSON.stringify(appayment));
                } else if($("#grid_list_refund_main").length > 0) {
                    var appayment = $("#grid_list_refund_main").jqGrid("getRowData");
                    $("#proceedsPaymentSummary, #documentPaymentSummary").val(JSON.stringify(appayment));
                } else if($("#grid_list_cash_payment_summary").length > 0) {
                    var cashpaymentsummarydata = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
                    $("#documentPaymentSummary").val(JSON.stringify(cashpaymentsummarydata));
                }
            }
            if(referenceType == "PAYMENT") {
                postUrl = payUrl;
            }
        }
        if(formId == "#documentsRequiredTabForm") {

            if(!activePopupDiv) {
                if(docReqSaveType == "adddelete") {
                    var id = $("#requiredDocId").val();

                    var reloadUrl = addedDocumentsUrl;
                    reloadUrl += "?deletedDocument="+id;

                    $("#preview_doc_required_list").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    docReqSaveType = "";

                    return true;
                } else {
                    postUrl = updateUrl;

                    if (!($('#documentType').val() == 'FOREIGN' && serviceType == 'Amendment' && ($('#documentSubType1').val() != 'REGULAR' || $('#documentSubType1').val() != 'CASH'))) {
                        // saves default documents
                        var requiredDocuments = $("#doc_required_list").jqGrid("getGridParam","selarrrow");
                        var requiredDocumentsList = new Array();

                        for(var i in requiredDocuments) {
                            var id = requiredDocuments[i]

                            var data = $("#doc_required_list").jqGrid("getRowData", id);

                            var requiredDocumentItem = {documentCode: id, description: data.description};

                            requiredDocumentsList.push(requiredDocumentItem);
                        }

                        $("#requiredDocumentsList").val(JSON.stringify(requiredDocumentsList));
                    }
                }
            } else {

                var params = {
                    documentCode: $("#requiredDocumentCode").val(),
                    description: $("#requiredDocDescription").val().replace(/\n/gmi,"<br/>")
                }

                if(docReqSaveType == "edit") {
                    $("#doc_required_list").jqGrid("setCell", $("#requiredDocId").val() , "description", $("#requiredDocDescription").val().replace(/\n/gmi,"<br/>"));

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    docReqSaveType = "";

                    $("#requiredDocId").val("");
                } else if(docReqSaveType == "add") {
                    var id = generateGuid();

                    var addData = {
                        id: id,
                        description: $("#requiredDocDescription").val().replace(/\n/gmi,"<br/>"),
                        editDocument: "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + id + "\'; editAddedDocsRequired(id);\">edit</a>",
                        deleteDocument: "<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + id + "\'; deleteAddedDocsRequired(id);\">delete</a>"
                    }

                    var reloadUrl = addedDocumentsUrl;
                    reloadUrl += "?addedDocuments="+encodeURIComponent(JSON.stringify(addData));

                    $("#preview_doc_required_list").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    docReqSaveType = "";
                } else if(docReqSaveType == "addedit") {
                    var addData = {
                        id: $("#requiredDocId").val(),
                        description: $("#requiredDocDescription").val()
                    }

                    var reloadUrl = addedDocumentsUrl;
                    reloadUrl += "?updatedDocuments="+encodeURIComponent(JSON.stringify(addData));

                    $("#preview_doc_required_list").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    docReqSaveType = "";

                    $("#requiredDocId").val("");
                }

                return true;
            }
        }

        if(formId == "#additionalCondition1TabForm") {
            if(!activePopupDiv) {
                if(addCondType == "adddelete") {
                    var id = $("#conditionCode").val();

                    var reloadUrl = addedConditionUrl;
                    reloadUrl += "?deletedCondition="+id;

                    $("#add_conditions2_list").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    addCondType = "";

                    return true;
                } else {
                    postUrl = updateUrl;

                    if (!($('#documentType').val() == 'FOREIGN' && serviceType == 'Amendment' &&
                    		($('#documentSubType1').val() != 'REGULAR' || $('#documentSubType1').val() != 'CASH'))) {
	                    // saves default documents
	                    var requiredDocuments = $("#add_conditions1_list").jqGrid("getGridParam","selarrrow");
	                    var requiredDocumentsList = new Array();
	
	                    for(var i in requiredDocuments) {
	                        var id = requiredDocuments[i]
	
	                        var data = $("#add_conditions1_list").jqGrid("getRowData", id);
	
	                        var requiredDocumentItem = {conditionCode: id, condition: data.condition};
	
	                        requiredDocumentsList.push(requiredDocumentItem);
	                    }
	
	                    $("#additionalConditionsList").val(JSON.stringify(requiredDocumentsList));
                    }

                    // saves swift charges
                    var swiftCharges = $("#grid_list_swift_option").jqGrid("getGridParam","selarrrow");
                    var swiftChargesList = new Array();

                    for(var i in swiftCharges) {
                        var id = swiftCharges[i]

                        var data = $("#grid_list_swift_option").jqGrid("getRowData", id);

                        var container = "#tempContainerSwift"
                        $(data.swiftCurrency).appendTo(container);
                        $(data.swiftAmount).appendTo(container);

                        var swiftCurrency
                        var swiftAmount

                        $("#tempContainerSwift > :input").each(function() {
                            if($(this).attr("name") == "swiftCurrency") {
                                swiftCurrency = $(this).val();
                            }

                            if($(this).attr("name") == "swiftAmount") {
                                swiftAmount = $(this).val();
                            }
                        });


                        var swiftChargesItem = {
                            code: id,
                            swiftCurrency: swiftCurrency,
                            swiftAmount: swiftAmount
                        };


                        swiftChargesList.push(swiftChargesItem);

                        $("#tempContainerSwift").empty();
                    }

                    $("#swiftChargesList").val(JSON.stringify(swiftChargesList));
                }
            } else {

                var params = {
                    conditionCode: $("#conditionCode").val(),
                    condition: $("#additionalCondition").val()
                }

                if(addCondType == "edit") {
                    $("#add_conditions1_list").jqGrid("setCell", $("#conditionCode").val() , "condition", $("#additionalCondition").val());

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    addCondType = "";

                    $("#conditionCode").val("");
                } else if(addCondType == "add") {
                    var id = generateGuid();

                    var addData = {
                        id: id,
                        condition: $("#additionalCondition").val(),
                        editDocument: "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + id + "\'; editAddedAdditionalCondition(id);\">edit</a>",
                        deleteDocument: "<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + id + "\'; deleteAddedAdditionalCondition(id);\">delete</a>"
                    }

                    var reloadUrl = addedConditionUrl;
                    reloadUrl += "?addedCondition="+encodeURIComponent(JSON.stringify(addData));

                    $("#add_conditions2_list").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    addCondType = "";
                } else if(addCondType == "addedit") {
                    var addData = {
                        id: $("#conditionCode").val(),
                        condition: $("#additionalCondition").val()
                    }

                    var reloadUrl = addedConditionUrl;
                    reloadUrl += "?updatedCondition="+encodeURIComponent(JSON.stringify(addData));

                    $("#add_conditions2_list").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    addCondType = "";

                    $("#conditionCode").val("");
                }

                return true;
            }
        }

        if(formId == "#detailsTransmittalLetterTabForm") {

            if(!activePopupDiv) {

                if(transLetterType == "adddelete") {

                    var id = $("#transmittalLetterId").val();

                    var reloadUrl = addedLetterUrl;
                    reloadUrl += "?deletedLetter="+id;

                    $("#grid_list_transmittal_letter").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    transLetterType = "";

                    return true;
                } else {

                    postUrl = updateUrl;

                    // saves default transmittal letter
                    var transmittalLetters = $("#grid_list_clients_documents").jqGrid("getGridParam","selarrrow");
                    var transmittalLetterList= new Array();

                    for(var i in transmittalLetters) {
                        var id = transmittalLetters[i]

                        // applies changes on click save - start
                        var obj = new Object();
                        obj.keys = true;
                        obj.oneditfunc = null;
                        obj.successfunc = null;
                        obj.url = transmittalLettersUrl;
                        obj.extraparam = null;
                        obj.aftersavefunc = null;
                        obj.errorfunc = null;
                        obj.afterrestorefunc = null;
                        obj.restoreAfterError = true;
                        obj.mtype = "POST";

                        $("#grid_list_clients_documents").saveRow(id, obj, undefined, undefined, undefined, undefined, undefined);
                        // applies changes on click save - end

                        var data = $("#grid_list_clients_documents").jqGrid("getRowData", id);
//                        var container = "#tempContainer"

//                        $(data.originalClientsDocuments).appendTo(container);
//                        $(data.duplicateClientsDocuments).appendTo(container);
//
//                        var originalCopy
//                        var duplicateCopy
//
//                        $("#tempContainer > :input").each(function() {
//                            if($(this).attr("name").indexOf("originalCopy") != -1) {
//                                originalCopy = $(this).val();
//                            }
//                            alert(originalCopy)
//
//                            if($(this).attr("name").indexOf("duplicateCopy") != -1) {
//                                duplicateCopy = $(this).val();
//                            }
//                        });

                        var transmittalLetterItem = {
                            transmittalLetterCode: id,
                            letterDescription: data.clientsDocuments,
                            originalCopy: data.originalClientsDocuments,
                            duplicateCopy: data.duplicateClientsDocuments
//                            originalCopy: originalCopy,
//                            duplicateCopy: duplicateCopy
                        };


                        transmittalLetterList.push(transmittalLetterItem);
//                        alert(transmittalLetterList)
//                        $("#tempContainer").empty();
                    }

                    $("#transmittalLetterList").val(JSON.stringify(transmittalLetterList));

                    var addedTransmittalLetterIds = $("#grid_list_transmittal_letter").jqGrid("getDataIDs");
                    var addedTransmittalLetterList= new Array();

                    for (i in addedTransmittalLetterIds) {
                        var id = addedTransmittalLetterIds[i];

                        var obj2 = new Object();
                        obj2.keys = true;
                        obj2.oneditfunc = null;
                        obj2.successfunc = null;
                        obj2.url = addedLetterUrl;
                        obj2.extraparam = null;
                        obj2.aftersavefunc = null;
                        obj2.errorfunc = null;
                        obj2.afterrestorefunc = null;
                        obj2.restoreAfterError = true;
                        obj2.mtype = "POST";

                        $("#grid_list_transmittal_letter").saveRow(id, obj2, undefined, undefined, undefined, undefined, undefined);

                        var data = $("#grid_list_transmittal_letter").jqGrid("getRowData", id);

                        var transmittalLetterItem = {
                            transmittalLetterCode: id,
                            letterDescription: data.descriptionTransmittal,
                            originalCopy: data.originalTransmittal,
                            duplicateCopy: data.duplicateTransmittal
//                            originalCopy: originalCopy,
//                            duplicateCopy: duplicateCopy
                        };

                        addedTransmittalLetterList.push(transmittalLetterItem);
                    }

                    $("#addedTransmittalLetterList").val(JSON.stringify(addedTransmittalLetterList));
                }

            } else {

                if(transLetterType == "add") {

                    var id = generateGuid();

                    var addData = {
                        id: id,
                        letterDescription: $("#transmittalLettter").val().toUpperCase(),
                        originalCopy: "0",
                        duplicateCopy: "0",
                        editLetter: "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id=\'" + id + "\'; editAddedTransmittalLetter(id);\">edit</a>",
                        deleteLetter: "<a href=\"javascript:void(0)\" style=\"color:red\" onclick=\"var id=\'" + id + "\'; deleteAddedTransmittalLetter(id);\">delete</a>"
                    }

                    var reloadUrl = addedLetterUrl;
                    reloadUrl += "?addedLetter="+JSON.stringify(addData);

                    $("#grid_list_transmittal_letter").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    transLetterType = "";
                } else if(transLetterType == "addedit") {

                    var data = $("#grid_list_transmittal_letter").jqGrid("getRowData", $("#transmittalLetterId").val());
//                    var container = "#tempContainer"
//                    $(data.originalTransmittal).appendTo(container);
//                    $(data.duplicateTransmittal).appendTo(container);
//
//                    var originalCopy
//                    var duplicateCopy
//
//                    $("#tempContainer > :input").each(function() {
//                        if($(this).attr("name") == "originalCopy") {
//                            originalCopy = $(this).val();
//                        }
//
//                        if($(this).attr("name") == "duplicateCopy") {
//                            duplicateCopy = $(this).val();
//                        }
//                    });

                    var addData = {
                        id: $("#transmittalLetterId").val(),
                        letterDescription: $("#transmittalLettter").val().toUpperCase(),
                        originalCopy: data.originalTransmittal,
                        duplicateCopy: data.duplicateTransmittal
//                        originalCopy: originalCopy,
//                        duplicateCopy: duplicateCopy
                    }

                    var reloadUrl = addedLetterUrl;
                    reloadUrl += "?updatedLetter="+JSON.stringify(addData);

                    $("#grid_list_transmittal_letter").jqGrid("setGridParam", {url: reloadUrl, page: 1}).trigger("reloadGrid");

                    closeAlert();
                    disablePopup(activePopupDiv, activePopupBg);
                    transLetterType = "";
                }

                return true;
            }
//            return;
        }

        if(formId == "#additionalCondition2TabForm") {
            if(activePopupDiv) {
                $("#add_conditions3_list").jqGrid("setCell", $("#instructionToBankId").val() , "instruction", $("#instructionToBank").val());

                closeAlert();
                disablePopup(activePopupDiv, activePopupBg);

                $("#instructionToBankId").val("");

                return true
            } else {
                var instructionsToBank = $("#add_conditions3_list").jqGrid("getGridParam", "selarrrow");

                var instructionsToBankList = new Array();

                for(var i in instructionsToBank) {
                    var id = instructionsToBank[i]

                    var data = $("#add_conditions3_list").jqGrid("getRowData", id);

                    var instructionsToBankItem = {instructionToBankCode: id, instruction: data.instruction};

                    instructionsToBankList.push(instructionsToBankItem);
                }

                $("#instructionToBankList").val(JSON.stringify(instructionsToBankList));
            }
        }
        
        // if shipment of goods tab
        if(formId == "#shipmentOfGoodsTabForm") {
        	if(activePopupDiv) {
            	if(activePopupDiv == "popup_shipmentPeriod") {
                	$("#shipmentPeriod").val($("#add_commentShipmentPeriod").val());        		
            	} else if(activePopupDiv == "popup_descriptionOfGoods") {
            		$("#descriptionOfGoodsServices").val($("#add_commentDescriptionOfGoods").val());
            	}

            	disablePopup(activePopupDiv, activePopupBg);

            	closeAlert();

            	return true;
        		
        	}
        }
      
		// sets form attributes
		$(formId).attr("method", "POST");
		$(formId).attr("action", postUrl);
		
        if(formId != "#incomingMtForm") {
//        	if("000" != pad($("#ccbdBranchUnitCode").val().trim(),"0",3))
            validateAddHeader();
        }
//        if("000" != pad($("#ccbdBranchUnitCode").val().trim(),"0",3)){
        	$(formId).submit();
//        } else {
//        	triggerAlertMessage("There is an error in branch unit code. Please check.")
//        	mDisablePopup($("#loading_div"), $("#loading_bg"));
//        }
	} else if(action == "route") { // route incoming MT
        postUrl = routeUrl;
        $(formId).attr("method", "POST");
        $(formId).attr("action", postUrl);

        $(formId).append($("#userrole"));
        $(formId).submit();
    } else if(action == "close") { // close incoming MT
        postUrl = closeUrl;

        $(formId).attr("method", "POST");
        $(formId).attr("action", postUrl);

        $(formId).append($("#userrole"));
        $(formId).submit();
    } else if(action == "return") { // return incoming MT
        postUrl = returnUrl;

        $(formId).attr("method", "POST");
        $(formId).attr("action", postUrl);

        $(formId).append($("#userrole"));
        $(formId).submit();
    } else if(action == "transmit" || action == "discard" || action == "reverse") {
        postUrl = mtUrl;

        location.href = postUrl;
    } else if(action=="gotounacted"){
    		postUrl=unactedTransactionsUrl;
    		location.href=postUrl;
    } else if(action == "delete") {
    	if(idToDelete){
    		if($("#referenceType").val() == 'DATA_ENTRY' && (formId in {"#cashLcPaymentTabForm":1, "#chargesPaymentTabForm":1, "#productPaymentTabForm":1, "#proceedsPaymentTabForm":1})){
    			formIsChanged = false;
    		} else {
    			formIsChanged = true;
    		}
    		onDeletePayment(idToDelete);
    		disablePopup(activePopupDiv, activePopupBg);
    		closeAlert();
    	}
    } else { // do delete action
		postUrl = deleteDocumentUrl;
		
		var params = {
	            serviceType: $("#serviceType").val(),
	            documentType: $("#documentType").val(),
	            documentClass: $("#documentClass").val(),
	            documentSubType1: $("#documentSubType1").val(),
	            documentSubType2: $("#documentSubType2").val(),
	            etsNumber: $("#etsNumber").val(),
	            form: "attachedDocuments",
	            id: idToDelete
		}
		
		// delete document via ajax
		$.post(postUrl, params, function(data) {
			// TODO reload grid
			disablePopup(activePopupDiv, activePopupBg);
			closeAlert();
		});		
	}
}

// open alert box on click delete file
function onDeleteFileClick(id) {
	action = "delete";
	idToDelete = id;
	openAlert();
}

// open alert box on click delete payment summary
function onDeletePaymentSummary(id) {
	action = "delete";
	idToDelete = id;
	//openAlert();
    openAlertWithoutChangeValidate();
}

// normal alert
function triggerAlert() {
	var mSave_div = $("#popup_alert_dv");
	var mBg = $("#popup_alert_bg");
	
	mLoadPopup(mSave_div, mBg);
	mCenterPopup(mSave_div, mBg);
	$("#btnAlertOk").focus();
}

function triggerAlertMessage(alertMessage){
    $("#alertMessage").html(alertMessage);
    triggerAlert();
}

function onAlertOkClick() {
	var mSave_div = $("#popup_alert_dv");
	var mBg = $("#popup_alert_bg");

	mDisablePopup(mSave_div, mBg);
	//disablePopup(activePopupDiv, activePopupBg);
//    if (formIsChanged == true) {
//        if (formId != formChanged) {
//            var mSave_div = $("#popup_save_confirmation");
//            var mBg = $("#confirmation_background");
//
//            mLoadPopup(mSave_div, mBg);
//            mCenterPopup(mSave_div, mBg);
//        }
//    }
}

// TODO: this is the updated version
//function onAlertOkClick() {
//    var mSave_div = $("#popup_alert_dv");
//    var mBg = $("#popup_alert_bg");
//
//    mDisablePopup(mSave_div, mBg);
//}
// END GENERAL

function validateAddHeader() {	
	var _cifNumber,
	_cifName,
	_accountOfficer,
	_ccbdCode,
	_longName,
	_address1,
	_address2,
	_userRole,
	_mainCifName,
	_mainCifNumber,
	_facilityType,
	_facilityId,
	_allocationUnitCode,
	_firstName,
	_middleName,
	_lastName,
	_tinNumber,
	_officerCode,
	_exceptionCode,
	_overAvailment;
	

	// adds header in parameters
    /*if(referenceType == "ETS" && formId == "#basicDetailsTabForm") {
        if(serviceType.toUpperCase() == "OPENING") {
        	_cifNumber=$('<input/>',{type:'hidden',name:'cifNumber',id:'cifNumber',value:$("#cifNumber").val()});
        	_cifName=$('<input/>',{type:'hidden',name:'cifName',id:'cifName',value:$("#cifName").val()});
        	_accountOfficer=$('<input/>',{type:'hidden',name:'accountOfficer',id:'accountOfficer',value:$("#accountOfficer").val()});
        	_ccbdCode=$('<input/>',{type:'hidden',name:'ccbdBranchUnitCode',id:'ccbdBranchUnitCode',value:$("#ccbdBranchUnitCode").val().toString()});
        	_longName=$('<input/>',{type:'hidden',name:'longName',id:'longName',value:$("#longName").val()});
        	_address1=$('<input/>',{type:'hidden',name:'address1',id:'address1',value:$("#address1").val()});
        	_address2=$('<input/>',{type:'hidden',name:'address2',id:'address2',value:$("#address2").val()});
        	_userRole=$('<input/>',{type:'hidden',name:'userrole',id:'userrole',value:$("#userrole").val()});
        	_allocationUnitCode=$('<input/>',{type:'hidden',name:'allocationUnitCode',id:'allocationUnitCode',value:$("#allocationUnitCode").val()});
        	_firstName=$('<input/>',{type:'hidden',name:'firstName',id:'firstName',value:$("#firstName").val()});
        	_middleName=$('<input/>',{type:'hidden',name:'middleName',id:'middleName',value:$("#middleName").val()});
        	_lastName=$('<input/>',{type:'hidden',name:'lastName',id:'lastName',value:$("#lastName").val()});
        	_tinNumber=$('<input/>',{type:'hidden',name:'tinNumber',id:'tinNumber',value:$("#tinNumber").val()});
        	_officerCode=$('<input/>',{type:'hidden',name:'officerCode',id:'officerCode',value:$("#officerCode").val()});
        	_exceptionCode=$('<input/>',{type:'hidden',name:'exceptionCode',id:'exceptionCode',value:$("#exceptionCode").val()});
        	_overAvailment=$('<input/>',{type:'hidden',name:'overAvailment',id:'overAvailment',value:$("#overAvailment").val()});
//            $(formId).append($("#cifNumber"));
//            $(formId).append($("#cifName"));
//            $(formId).append($("#accountOfficer"));
//            $(formId).append($("#ccbdBranchUnitCode"));
//
//            $(formId).append($("#longName"));
//            $(formId).append($("#address1"));
//            $(formId).append($("#address2"));
//
//            $(formId).append($("#userrole"));
        
        	$(formId).append(_cifNumber);
        	$(formId).append(_cifName);
        	$(formId).append(_accountOfficer);
        	$(formId).append(_ccbdCode);
        	$(formId).append(_longName);
        	$(formId).append(_address1);
        	$(formId).append(_address2);
        	$(formId).append(_userRole);
        	$(formId).append(_allocationUnitCode);
        	$(formId).append(_firstName);
        	$(formId).append(_middleName);
        	$(formId).append(_lastName);
        	$(formId).append(_tinNumber);
        	$(formId).append(_officerCode);
        	$(formId).append(_exceptionCode);
        	$(formId).append(_overAvailment);
        	

        } else { // if service type is not opening
            // adds cifNumber, cifName, accountOfficer and ccbdBranchCode fields if not existing
            var $inputs = $(formId + " :input");

            var cifNumberCount = 0;
            var cifNameCount = 0;
            var accountOfficerCount = 0;
            var ccbdBranchUnitCodeCount = 0;

            var mainCifNameCount = 0;
            var mainCifNumberCount = 0;
            var facilityTypeCount = 0;
            var facilityIdCount = 0;

            var longNameCount = 0;
            var address1Count = 0;
            var address2Count = 0;

            var userroleCount = 0;
            
            var allocationUnitCodeCount = 0;
            
            var firstNameCount = 0;
            var middleNameCount = 0;
            var lastNameCount = 0;
            var tinNumberCount = 0;
            
            var officerCodeCount = 0;
            var exceptionCodeCount = 0;
            
            var overAvailmentCount = 0;

            $inputs.each(function(index) {
                var idname = $(this).attr("id");

                if($(this).attr("id") == undefined) {
                    idname = $(this).attr("name");
                }
                if(idname == "cifNumber") {
                    cifNumberCount ++;
                }
                if(idname == "cifName") {
                    cifNameCount ++;
                }
                if(idname == "accountOfficer") {
                    accountOfficerCount ++;
                }
                if(idname == "ccbdBranchUnitCode") {
                    ccbdBranchUnitCodeCount ++;
                }

                if(idname == "mainCifName") {
                    mainCifNameCount ++;
                }
                if(idname == "mainCifNumber") {
                    mainCifNumberCount ++;
                }
                if(idname == "facilityType") {
                    facilityTypeCount ++;
                }
                if(idname == "facilityId") {
                    facilityIdCount ++;
                }
                if(idname == "userrole") {
                    userroleCount ++;
                }
                if(idname == "longName") {
                    longNameCount ++;
                }
                if(idname == "address1") {
                    address1Count ++;
                }
                if(idname == "address2") {
                    address2Count ++;
                }
                if(idname == "allocationUnitCode") {
                	allocationUnitCodeCount ++;
                }
                if(idname == "firstName") {
                	firstNameCount ++;
                }
                if(idname == "middleName") {
                	middleNameCount ++;
                }
                if(idname == "lastName") {
                	lastNameCount ++;
                }
                if(idname == "tinNumber") {
                	tinNumberCount ++;
                }
                if(idname == "officerCode") {
                	officerCodeCount ++;
                }
                if(idname == "exceptionCode") {
                	exceptionCodeCount ++;
                }
                if(idname == "overAvailment") {
                	overAvailmentCount ++;
                }
            });

            if(cifNumberCount == 0) {
            	_cifNumber=$('<input/>',{type:'hidden',name:'cifNumber',id:'cifNumber',value:$("#cifNumber").val()});
                $(formId).append(_cifNumber);
            }
            if(cifNameCount == 0) {
            	_cifName=$('<input/>',{type:'hidden',name:'cifName',id:'cifName',value:$("#cifName").val()});
                $(formId).append(_cifName);
            }
            if(accountOfficerCount == 0) {
            	_accountOfficer=$('<input/>',{type:'hidden',name:'accountOfficer',id:'accountOfficer',value:$("#accountOfficer").val()});
                $(formId).append(_accountOfficer);
            }
            if(ccbdBranchUnitCodeCount == 0) {
            	_ccbdCode=$('<input/>',{type:'hidden',name:'ccbdBranchUnitCode',id:'ccbdBranchUnitCode',value:$("#ccbdBranchUnitCode").val().toString()});
                $(formId).append(_ccbdCode);
            }

            if(mainCifNameCount == 0) {
            	_mainCifName=$('<input/>',{type:'hidden',name:'mainCifName',id:'mainCifName',value:$("#mainCifName").val()});
                $(formId).append(_mainCifName);
            }
            if(mainCifNumberCount == 0) {
            	_mainCifNumber=$('<input/>',{type:'hidden',name:'mainCifNumber',id:'mainCifNumber',value:$("#mainCifNumber").val()});
                $(formId).append(_mainCifNumber);
            }
            if(facilityTypeCount == 0) {
            	_facilityType=$('<input/>',{type:'hidden',name:'facilityType',id:'facilityType',value:$("#facilityType").val()});
                $(formId).append(_facilityType);
            }
            if(facilityIdCount == 0) {
            	_facilityId=$('<input/>',{type:'hidden',name:'facilityId',id:'facilityId',value:$("#facilityId").val()});
                $(formId).append(_facilityId);
            }
            if(userroleCount == 0) {
            	_userRole=$('<input/>',{type:'hidden',name:'userrole',id:'userrole',value:$("#userrole").val()});
                $(formId).append(_userRole);
            }
            if(longNameCount == 0) {
            	_longName=$('<input/>',{type:'hidden',name:'longName',id:'longName',value:$("#longName").val()});
                $(formId).append(_longName);
            }
            if(address1Count == 0) {
            	_address1=$('<input/>',{type:'hidden',name:'address1',id:'address1',value:$("#address1").val()});
                $(formId).append(_address1);
            }
            if(address2Count == 0) {
            	_address2=$('<input/>',{type:'hidden',name:'address2',id:'address2',value:$("#address2").val()});
                $(formId).append(_address2);
            }
            if(allocationUnitCodeCount == 0) {
            	_allocationUnitCode=$('<input/>',{type:'hidden',name:'allocationUnitCode',id:'allocationUnitCode',value:$("#allocationUnitCode").val()});
            	$(formId).append(_allocationUnitCode);
            }
            if(firstNameCount == 0) {
            	_firstName=$('<input/>',{type:'hidden',name:'firstName',id:'firstName',value:$("#firstName").val()});
            	$(formId).append(_firstName);
            }
            if(middleNameCount == 0) {
            	_middleName=$('<input/>',{type:'hidden',name:'middleName',id:'middleName',value:$("#middleName").val()});
            	$(formId).append(_middleName);
            }
            if(lastNameCount == 0) {
            	_lastNamee=$('<input/>',{type:'hidden',name:'lastName',id:'lastName',value:$("#lastName").val()});
            	$(formId).append(_lastName);
            }
            if(tinNumberCount == 0) {
            	_tinNumber=$('<input/>',{type:'hidden',name:'tinNumber',id:'tinNumber',value:$("#tinNumber").val()});
            	$(formId).append(_tinNumber);
            }
            if(officerCodeCount == 0) {
            	_officerCode=$('<input/>',{type:'hidden',name:'officerCode',id:'officerCode',value:$("#officerCode").val()});
            	$(formId).append(_officerCode);
            }
            if(exceptionCodeCount == 0) {
            	_exceptionCode=$('<input/>',{type:'hidden',name:'exceptionCode',id:'exceptionCode',value:$("#exceptionCode").val()});
            	$(formId).append(_exceptionCode);
            }
            if(overAvailmentCount == 0) {
            	_overAvailment=$('<input/>',{type:'hidden',name:'overAvailment',id:'overAvailment',value:$("#overAvailment").val()});
        		$(formId).append(_overAvailment);
            }
        }
    } else {*/
    	
        var $inputs = $(formId + " :input");

        var cifNumberCount = 0;
        var cifNameCount = 0;
        var accountOfficerCount = 0;
        var ccbdBranchUnitCodeCount = 0;

        var mainCifNameCount = 0;
        var mainCifNumberCount = 0;
        var facilityTypeCount = 0;
        var facilityIdCount = 0;

        var longNameCount = 0;
        var address1Count = 0;
        var address2Count = 0;

        var userroleCount = 0;
        
        var allocationUnitCodeCount = 0;
        
        var firstNameCount = 0;
        var middleNameCount = 0;
        var lastNameCount = 0;
        var tinNumberCount = 0;
        
        var officerCodeCount = 0;
        var exceptionCodeCount = 0;
        
        var overAvailmentCount = 0;

        $inputs.each(function(index) {
            var idname = $(this).attr("id");

            if($(this).attr("id") == undefined) {
                idname = $(this).attr("name");
            }
            if(idname == "cifNumber") {
                cifNumberCount ++;
            }
            if(idname == "cifName") {
                cifNameCount ++;
            }
            if(idname == "accountOfficer") {
                accountOfficerCount ++;
            }
            if(idname == "ccbdBranchUnitCode") {
                ccbdBranchUnitCodeCount ++;
            }

            if(idname == "mainCifName") {
                mainCifNameCount ++;
            }
            if(idname == "mainCifNumber") {
                mainCifNumberCount ++;
            }
            if(idname == "facilityType") {
                facilityTypeCount ++;
            }
            if(idname == "facilityId") {
                facilityIdCount ++;
            }
            if(idname == "userrole") {
                userroleCount ++;
            }
            if(idname == "longName") {
                longNameCount ++;
            }
            if(idname == "address1") {
                address1Count ++;
            }
            if(idname == "address2") {
                address2Count ++;
            }
            if(idname == "allocationUnitCode") {
            	allocationUnitCodeCount ++;
            }
            if(idname == "firstName") {
            	firstNameCount ++;
            }
            if(idname == "middleName") {
            	middleNameCount ++;
            }
            if(idname == "lastName") {
            	lastNameCount ++;
            }
            if(idname == "tinNumber") {
            	tinNumberCount ++;
            }
            if(idname == "officerCode") {
            	officerCodeCount ++;
            }
            if(idname == "exceptionCode") {
            	exceptionCodeCount ++;
            }
            if(idname == "overAvailment") {
            	overAvailmentCount ++;
            }
        });

        if(cifNumberCount == 0) {
        	_cifNumber=$('<input/>',{type:'hidden',name:'cifNumber',id:'cifNumber',value:$("#cifNumber").val()});
            $(formId).append(_cifNumber);
        }
        if(cifNameCount == 0) {
        	_cifName=$('<input/>',{type:'hidden',name:'cifName',id:'cifName',value:$("#cifName").val()});
            $(formId).append(_cifName);
        }
        if(accountOfficerCount == 0) {
        	_accountOfficer=$('<input/>',{type:'hidden',name:'accountOfficer',id:'accountOfficer',value:$("#accountOfficer").val()});
            $(formId).append(_accountOfficer);
        }
        if(ccbdBranchUnitCodeCount == 0) {
        	_ccbdCode=$('<input/>',{type:'hidden',name:'ccbdBranchUnitCode',id:'ccbdBranchUnitCode',value:$("#ccbdBranchUnitCode").val().toString()});
            $(formId).append(_ccbdCode);
        }

        if(mainCifNameCount == 0) {
        	_mainCifName=$('<input/>',{type:'hidden',name:'mainCifName',id:'mainCifName',value:$("#mainCifName").val()});
            $(formId).append(_mainCifName);
        }
        if(mainCifNumberCount == 0) {
        	_mainCifNumber=$('<input/>',{type:'hidden',name:'mainCifNumber',id:'mainCifNumber',value:$("#mainCifNumber").val()});
            $(formId).append(_mainCifNumber);
        }
        if(facilityTypeCount == 0) {
        	_facilityType=$('<input/>',{type:'hidden',name:'facilityType',id:'facilityType',value:$("#facilityType").val()});
            $(formId).append(_facilityType);
        }
        if(facilityIdCount == 0) {
        	_facilityId=$('<input/>',{type:'hidden',name:'facilityId',id:'facilityId',value:$("#facilityId").val()});
            $(formId).append(_facilityId);
        }
        if(userroleCount == 0) {
        	_userRole=$('<input/>',{type:'hidden',name:'userrole',id:'userrole',value:$("#userrole").val()});
            $(formId).append(_userRole);
        }
        if(longNameCount == 0) {
        	_longName=$('<input/>',{type:'hidden',name:'longName',id:'longName',value:$("#longName").val()});
            $(formId).append(_longName);
        }
        if(address1Count == 0) {
        	_address1=$('<input/>',{type:'hidden',name:'address1',id:'address1',value:$("#address1").val()});
            $(formId).append(_address1);
        }
        if(address2Count == 0) {
        	_address2=$('<input/>',{type:'hidden',name:'address2',id:'address2',value:$("#address2").val()});
            $(formId).append(_address2);
        }
        if(allocationUnitCodeCount == 0) {
        	_allocationUnitCode=$('<input/>',{type:'hidden',name:'allocationUnitCode',id:'allocationUnitCode',value:$("#allocationUnitCode").val()});
        	$(formId).append(_allocationUnitCode);
        }
        if(firstNameCount == 0) {
        	_firstName=$('<input/>',{type:'hidden',name:'firstName',id:'firstName',value:$("#firstName").val()});
        	$(formId).append(_firstName);
        }
        if(middleNameCount == 0) {
        	_middleName=$('<input/>',{type:'hidden',name:'middleName',id:'middleName',value:$("#middleName").val()});
        	$(formId).append(_middleName);
        }
        if(lastNameCount == 0) {
        	_lastNamee=$('<input/>',{type:'hidden',name:'lastName',id:'lastName',value:$("#lastName").val()});
        	$(formId).append(_lastName);
        }
        if(tinNumberCount == 0) {
        	_tinNumber=$('<input/>',{type:'hidden',name:'tinNumber',id:'tinNumber',value:$("#tinNumber").val()});
        	$(formId).append(_tinNumber);
        }
        if(officerCodeCount == 0) {
        	_officerCode=$('<input/>',{type:'hidden',name:'officerCode',id:'officerCode',value:$("#officerCode").val()});
        	$(formId).append(_officerCode);
        }
        if(exceptionCodeCount == 0) {
        	_exceptionCode=$('<input/>',{type:'hidden',name:'exceptionCode',id:'exceptionCode',value:$("#exceptionCode").val()});
        	$(formId).append(_exceptionCode);
        }
        if(overAvailmentCount == 0) {
        	_overAvailment=$('<input/>',{type:'hidden',name:'overAvailment',id:'overAvailment',value:$("#overAvailment").val()});
    		$(formId).append(_overAvailment);
        }
//    }
}

// For Negotiation
function negotiationPartialShipmentChecker(referenceType, serviceType) {

    var okToContinue = true;

    // 1) Check partial shipment.
    // 2) Negotiation amount must not exceed Positive/Negative Tolerance Limits.
    /*if (referenceType == "ETS" && serviceType.toUpperCase() == "NEGOTIATION") {

        var partialShipment = $("#partialShipment").val();

        var outstandingBalance = parseFloat(stripCommas($("#outstandingBalance").val()));
        var negotiationAmount = parseFloat(stripCommas($("#negotiationAmount").val()));

        var positiveToleranceLimit = parseFloat(stripCommas($("#positiveToleranceLimit").val()));
        var negativeToleranceLimit = parseFloat(stripCommas($("#negativeToleranceLimit").val()));

        var positiveLimit = eval(outstandingBalance + (outstandingBalance * (positiveToleranceLimit * 0.01)));
        var negativeLimit = eval(outstandingBalance - (outstandingBalance * (positiveToleranceLimit * 0.01)));

        // alert("positiveToleranceLimit = " + positiveToleranceLimit + ", negativeToleranceLimit = " + negativeToleranceLimit + ", positiveLimit = " + positiveLimit + ", negativeLimit = " + negativeLimit);

        if (partialShipment.toUpperCase() == "NOT ALLOWED" && formId == "#basicDetailsTabForm") {

            if (eval(negotiationAmount < outstandingBalance)) {

                okToContinue = false;
                $("#alertMessage").text("Partial shipment is not allowed.");
                triggerAlert();

            } else if (eval(negotiationAmount > outstandingBalance)) {

                if (eval(negotiationAmount > positiveLimit)) {
                    okToContinue = false;
                    $("#alertMessage").text("Negotiation amount exceeds Positive Tolerance Limit.");
                    triggerAlert();
                }
            }

        } else if (partialShipment.toUpperCase() == "ALLOWED" && formId == "#basicDetailsTabForm") {

            if (eval(negotiationAmount > positiveLimit)) {
                okToContinue = false;
                $("#alertMessage").text("Negotiation amount exceeds Positive Tolerance Limit.");
                triggerAlert();
            } else if (eval(negotiationAmount < negativeLimit)) {
                okToContinue = false;
                $("#alertMessage").text("Negotiation amount is below the Negative Tolerance Limit.");
                triggerAlert();
            }
        }
    }*/

    return okToContinue;
}

function showAlert() {
    action = "save";
    openAlert();
}

function onSaveAsDraft() {
    $("#saveAs").val("DRAFT");
    onSaveValidate();
}

function initializeButtonWiring() {
	// all open save confirmation classes opens save alert
	$(".openSaveConfirmation").click(onSaveValidate);
    $(".openSaveConfirmation2").click(showAlert);

    $(".openSaveConfirmationDraft").click(onSaveAsDraft);

	$(".cancelTransaction").click(onCancelClick);
	
	// cancel and no closes alert
	$("#btnAlertNo").click(onCloseClick);
	
	// confirms saving alert
	$("#btnAlertConfirm").click(confirmAlert);
	
	$("#btnAlertOk").click(onAlertOkClick);
	$("#btnAlertConfirm2,#yesBtnBD").click(validateInputInCancelButton);
	$("#btnAlertNo2,#noBtnBD").click(onNoAlert2);
	$("#btnAlertCancel2").click(onCancelAlert2);
	$("#cancelBtnBD").click(onAlertConfirmationCancel);

    $(".openRouteConfirmation").click(onRouteClick);

    $(".openDoneConfirmation").click(onDoneClick);

    $(".openReturnConfirmation").click(onReturnClick);
    
    
    //ensures that buttons cannot be interacted upon by a keyboard keys after being click (especially those that may incur errors)
    $("input[type=button]").click(function(){
    	$(this).blur();
    })

//    if (formId != undefined && formId != null) {
//        $(formId).change(function() {
//            formChanged = true;
//        });
//
//    }
}

$(initializeButtonWiring);





//***********************FOR TESTING PURPOSES********************************
//***************************************************************************
//***************************************************************************
var indemnityIssuanceValidator=false;
var shipmentAmountValidator=false;
var etsDuaLoanSettlementValidator=false;
var etsUaLoanSettlementValidator=false;
var dataEntryUaLoanSettlementValidator=false;


function validateIndemnityIssuance(){
	
	if(!$("#fxlc_indemnity_issuance_filter .-required").length>0) return true;
	
	$("#fxlc_indemnity_issuance_filter .-required").each(function(){
		
		if($(this).is("#shipmentAmount")){
			if(parseInt($(this).val())<1||$(this).val()==""){
				shipmentAmountValidator=true;
				indemnityIssuanceValidator=false;
				$(this).css("border","1px solid red");
				return false;
			}
			else{
				shipmentAmountValidator=false;
				$(this).css("border","1px solid #00aeef");
			}
		}else{
			if($(this).val()==""){
				indemnityIssuanceValidator=false;
				$(this).css("border","1px solid red");
				return false;
			}
			else{
				indemnityIssuanceValidator=true;
				$(this).css("border","1px solid #00aeef");
			}
		}
	});
	
//	//shipment amount
//	if($("#fxlc_indemnity_issuance_filter #shipmentAmount").val()==""||parseInt($("#fxlc_indemnity_issuance_filter #shipmentAmount").val())<1){
//		
//		$("#fxlc_indemnity_issuance_filter #shipmentAmount").css("border","1px solid red");
//		indemnityIssuanceValidator=false;
//	}
//	else {
//		$("#fxlc_indemnity_issuance_filter #shipmentAmount").css("border","1px solid #00aeef");
//		indemnityIssuanceValidator=true;
//		shipmentAmountValidator=true;
//	}
//	
//	if($("#fxlc_indemnity_issuance_filter #transportMedium").val()==""){
//		$("#fxlc_indemnity_issuance_filter #transportMedium").css("border","1px solid red");
//		indemnityIssuanceValidator=false;
//	}
//	else {
//		$("#fxlc_indemnity_issuance_filter #transportMedium").css("border","1px solid #00aeef");
//		indemnityIssuanceValidator=true;
//	}
	
	if(!indemnityIssuanceValidator){
		if(shipmentAmountValidator) {
            //alert("Shipment Amount is required and must not be equal to zero");
            triggerAlertMessage("Shipment Amount is required and must not be equal to zero");
        } else {
            //alert("Please fill in all the required fields");
            triggerAlertMessage("Please fill in all the required fields");
        }
	}
	
	return indemnityIssuanceValidator;
}

function validateEtsUaLoanSettlement(){
	
	if(!$("#ets_ua_loan_settlement_filter").length>0) return true;
	
	if($("#ets_ua_loan_settlement_filter #valueDate").val()==""){
		$("#ets_ua_loan_settlement_filter #valueDate").css("border","1px solid red");
		etsUaLoanSettlementValidator=false;
	}
	else {
	$("#ets_ua_loan_settlement_filter #valueDate").css("border","1px solid #00aeef");
		etsUaLoanSettlementValidator=true;
	}
	
	if(!etsUaLoanSettlementValidator){
			//alert("Please fill in all the required fields");
        triggerAlertMessage("Please fill in all the required fields");
	}
	
	return etsUaLoanSettlementValidator;
}

function validateEtsDuaLoanSettlement(){
	
	if(!$("#ets_dua_loan_settlement_filter").length>0)return true;
	
	if($("#ets_dua_loan_settlement_filter #negotiationNumber").val()==""){
		$("#ets_dua_loan_settlement_filter #negotiationNumber").css("border","1px solid red");
		etsDuaLoanSettlementValidator=false;
	}
	else {
	$("#ets_dua_loan_settlement_filter #negotiationNumber").css("border","1px solid #00aeef");
	etsDuaLoanSettlementValidator=true;
	}
	
	if(!etsDuaLoanSettlementValidator){
			//alert("Please fill in all the required fields");
        triggerAlertMessage("Please fill in all the required fields");
	}
	
	return etsDuaLoanSettlementValidator;
}

function validateDataEntryUaLoanSettlement(){
	
	if($("#data_entry_ua_loan_settlement_filter").length>0) return true;
	
	if($("#data_entry_ua_loan_settlement_filter #reimburseBank").val()==""){
		dataEntryUaLoanSettlementValidator=false;
	}
	else {
		dataEntryUaLoanSettlementValidator=true;
		}
	
	if($("#data_entry_ua_loan_settlement_filter #negotiatingBanksReferenceNumber").val()==""){
		dataEntryUaLoanSettlementValidator=false;
	}
	else {
		dataEntryUaLoanSettlementValidator=true;
		}
	
	if($("#data_entry_ua_loan_settlement_filter #bankIdentifierCodeMt202").val()==""){
		dataEntryUaLoanSettlementValidator=false;
	}
	else {
		dataEntryUaLoanSettlementValidator=true;
		}
	
	if($("#data_entry_ua_loan_settlement_filter #bankNameAndAddressMt202").val()==""){
		dataEntryUaLoanSettlementValidator=false;
	}
	else {
		dataEntryUaLoanSettlementValidator=true;
		}
	
	if($("#data_entry_ua_loan_settlement_filter #beneficiaryIdentifierCodeMt202").val()==""){
		dataEntryUaLoanSettlementValidator=false;
	}
	else {
		dataEntryUaLoanSettlementValidator=true;
		}
	
	if($("#data_entry_ua_loan_settlement_filter #beneficiaryNameAndAddressMt202").val()==""){
		dataEntryUaLoanSettlementValidator=false;
	}
	else {
		dataEntryUaLoanSettlementValidator=true;
		}
	
	if(!dataEntryUaLoanSettlementValidator){
		//alert("Please fill in all the required fields");
        triggerAlertMessage("Please fill in all the required fields");
	}

	return dataEntryUaLoanSettlementValidator;
}