$(document).ready(function(){
	var wrapper_div=$("#popup_modeOfPaymentUaLoan").attr("id");
	var div_bg=$("#mode_of_payment_ua_loan_bg").attr("id");
	
	var pLoan=$("#modeOfPaymentUsance");
	var nLoan=$("#referenceNumberUsance");
	var bLoan=$(".usancePopUpButton");
	
	var cilex = $(".display_cilex_ua_loan");
	var docStamp = $(".display_docStamp_ua_loan");
	var blank = $(".border_blank");
	
	cilex.css("display","none");
	docStamp.css("display","none");

	var casaLoan=$(".display-casa-ua-loan");
	var trLoan = $(".display-tr-loan");
	var checkLoan = $(".display-check-ua_loan");
	var cashLoan = $(".display-cash-ua_loan");
	var applyLoan = $(".display-apply-ap-ua_loan");
	var remitLoan = $(".display-remittance-ua_loan");
	var apBalDisplay2Loan=$(".display-ap-balance2_ua_loan");
	var apBalDisplay1Loan=$(".display-ap-balance1_ua_loan");
	
	bLoan.css("display", "none");
	casaLoan.css("display", "none");
	trLoan.css("display", "none");
	checkLoan.css("display", "none");
	cashLoan.css("display", "none");
	applyLoan.css("display", "none");
	remitLoan.css("display", "none");
	apBalDisplay2Loan.css("display", "none");
	apBalDisplay1Loan.css("display", "none");
	
	pLoan.change(function(){
	
		if(pLoan.val().toLowerCase()=="credit to casa"){
			nLoan.val("");
			bLoan.css("display", "block");
			applyLoan.css("display", "none");
			checkLoan.css("display", "none");
			cashLoan.css("display", "none");
			casaLoan.css("display","block");
			trLoan.css("display", "none");
			remitLoan.css("display", "none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","380px");
			centerPopup(wrapper_div,div_bg);
		}
		else if(pLoan.val().toLowerCase()=="tr loan"){
			nLoan.val("");
			bLoan.css("display", "block");
			checkLoan.css("display", "none");
			cashLoan.css("display", "none");
			applyLoan.css("display", "none");
			trLoan.css("display", "block");
			casaLoan.css("display","none");
			remitLoan.css("display", "none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","600px");
			
			centerPopup(wrapper_div,div_bg);
		}
		else if(pLoan.val().toLowerCase()=="dtr loan"){ 
			nLoan.val("");
			bLoan.css("display", "block");
			checkLoan.css("display", "none");
			cashLoan.css("display", "none");
			applyLoan.css("display", "none");
			trLoan.css("display", "block");
			casaLoan.css("display","none");
			remitLoan.css("display", "none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","400px");
			
			centerPopup(wrapper_div,div_bg);
		}
		else if(pLoan.val().toLowerCase()=="check"){ 
			nLoan.val("");
			bLoan.css("display", "block");
			checkLoan.css("display", "block");
			cashLoan.css("display", "none");
			applyLoan.css("display", "none");
			trLoan.css("display", "none");
			casaLoan.css("display","none");
			remitLoan.css("display", "none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","380px");
			
			centerPopup(wrapper_div,div_bg);
		}
		else if(pLoan.val().toLowerCase()=="cash"){ 
			nLoan.val("");
			bLoan.css("display", "block");
			checkLoan.css("display", "none");
			cashLoan.css("display", "block");
			applyLoan.css("display", "none");
			trLoan.css("display", "none");
			casaLoan.css("display","none");
			remitLoan.css("display", "none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","380px");
			
			centerPopup(wrapper_div,div_bg);
		}
		else if(pLoan.val().toLowerCase()=="apply ap"){ 
			nLoan.val("");
			bLoan.css("display", "none");
			applyLoan.css("display", "block");
			checkLoan.css("display", "none");
			cashLoan.css("display", "none");
			trLoan.css("display", "none");
			casaLoan.css("display","none");
			remitLoan.css("display", "none");
			$('.popup_container').css("width","380px");
			
			centerPopup(wrapper_div,div_bg);
		}
		else if(pLoan.val().toLowerCase()=="remittance"){ 
			nLoan.val("");
			bLoan.css("display", "block");
			remitLoan.css("display", "block");
			applyLoan.css("display", "none");
			cashLoan.css("display", "none");
			checkLoan.css("display", "none");
			trLoan.css("display", "none");
			casaLoan.css("display","none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","380px");
			centerPopup(wrapper_div,div_bg);
		}else if(pLoan.val().toLowerCase()=="set-up ar"){ 
			nLoan.val("");
			bLoan.css("display", "block");
			remitLoan.css("display", "none");
			applyLoan.css("display", "none");
			cashLoan.css("display", "none");
			checkLoan.css("display", "none");
			trLoan.css("display", "none");
			casaLoan.css("display","none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","380px");
			centerPopup(wrapper_div,div_bg);
		}else{
			nLoan.val("");
			bLoan.css("display", "none");
			casaLoan.css("display", "none");
			trLoan.css("display", "none");
			checkLoan.css("display", "none");
			cashLoan.css("display", "none");
			applyLoan.css("display", "none");
			remitLoan.css("display", "none");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","380px");
			centerPopup(wrapper_div,div_bg);
		}
		
		
	});
	
	nLoan.change(function changeCharges(){
		
		if(nLoan.val().toLowerCase()=="document number 1"){
			bLoan.css("display", "block");
			apBalDisplay2Loan.css("display", "block");
			apBalDisplay1Loan.css("display", "none");
			$('.popup_container').css("width","380px");
			
			centerPopup(wrapper_div,div_bg);;
			
		}else if(nLoan.val().toLowerCase()=="document number 2"){
			bLoan.css("display", "block");
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "block");
			$('.popup_container').css("width","400px");
			
			centerPopup(wrapper_div,div_bg);
		}
		else{
			apBalDisplay2Loan.css("display", "none");
			apBalDisplay1Loan.css("display", "none");
		}
	});

	
	$(".input_button").click(function (){
		$('.popup_container').css("width","380px");
	});
	
});
	

