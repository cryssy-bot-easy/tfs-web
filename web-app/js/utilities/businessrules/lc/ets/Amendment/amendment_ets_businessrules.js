/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/29/12
 * Time: 1:16 PM
 * To change this template use File | Settings | File Templates.
 */

function initializeAmendmentEtsBusinessRules() {   

	
	if($("#amountSwitch").val() == "off") {

    	$(".display_cash_payment").hide();    	
    	
    }    
    else{
    	if($("#lcAmountFlag").val() == "INC"){
    		$(".display_cash_payment").show();    
    	}else{
    		$(".display_cash_payment").hide();    
    	}    	
    }     
  
}


$(document).ready(function() {
	//$(initializeAmendmentEtsBusinessRules);
	initializeAmendmentEtsBusinessRules();
});