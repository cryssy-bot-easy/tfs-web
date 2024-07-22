function validatePaymentTab(buttonParentId) {

	if(buttonParentId == "paymentDetailsTabForm" || buttonParentId == "cashLcPaymentTabForm" || buttonParentId == "proceedsDetailsTabForm"){
	    var error = 0;

	    if($("#forex_product tr").length >= 3 && $("#passOnRateConfirmedByCash").val() == "" && !($("#forex_product").is(":hidden") && $("#passOnRateConfirmedByCash").is(":hidden"))) {
	    	error++;
		}
	    
	    if($("#grid_list_cash_payment_summary").length > 0 && $("#grid_list_cash_payment_summary").getRowData().length == 0 && !($("#grid_list_cash_payment_summary").is(":hidden"))) {
	    	error++;
		}
	
	    if (error > 0) {
	        triggerAlertMessage("Please fill up all required fields.")
	        _pageHasErrors = true;
	    } else {
	    	// loading popup to prevent multiple saving of payment tab
	    	mCenterPopup($("#loading_div"), $("#loading_bg"));
	    	mLoadPopup($("#loading_div"), $("#loading_bg"));
	        _pageHasErrors = false;
	    }
    }

    if(buttonParentId == "chargesTabForm"){

        var error = 0;

        if($("#forex_charges tr").length >= 3 && $("#passOnRateConfirmedByCharges").val() == "") {
            error++;
        }

        if (error > 0) {
            triggerAlertMessage("Please fill up all required fields.")
            _pageHasErrors = true;
        } else {
        	mCenterPopup($("#loading_div"), $("#loading_bg"));
	    	mLoadPopup($("#loading_div"), $("#loading_bg"));
            _pageHasErrors = false;
        }
    }
    
    if(buttonParentId == "instructionsAndRoutingTabForm"){
    	if(documentClass == 'MD' && serviceType == 'Collection'){
	    	var error = 0;
	    	if($("#grid_list_cash_payment_summary").length > 0 && $("#grid_list_cash_payment_summary").getRowData().length == 0) {
		    	error++;
			}
		
		    if (error > 0) {
		        triggerAlertMessage("Please fill up all required fields.")
		        _pageHasErrors = true;
		    } else {
		        _pageHasErrors = false;
		    }
    	}
    }

}