$(document).ready(function(){

	initializePage();

});
function initializePage(){
	
	var attachedDocuments = $(".display_attached_documents");
	var charges =  $(".display_charges");
	var chargesPayment =  $(".display_charges_payment");
	var cashPayment =  $(".display_cash_payment");
	var proceedsBeneficiary =  $(".display_proceeds_beneficiary"); 
	var natureAmendment = $(".display_nature_amendment");
	var cashPaymentSpecial = $(".display_negotiation_ua_loan");

	if (serviceType == 'Opening'){
		if (documentSubType1 == 'CASH'){

			proceedsBeneficiary.remove();
			natureAmendment.remove();
		}else{

			cashPayment.remove();
			proceedsBeneficiary.remove();
			natureAmendment.remove();
			cashPaymentSpecial.remove();
		}
	}else if (serviceType == 'Adjustment'){

		if (documentType == 'FOREIGN'){
			if (documentSubType1 == 'REGULAR'){
				charges.remove();
				chargesPayment.hide();
				//cashPayment.hide();
				proceedsBeneficiary.remove();
				natureAmendment.remove();
				cashPaymentSpecial.remove();
			}else{
				charges.remove();
				chargesPayment.remove();
				//cashPayment.remove();
				proceedsBeneficiary.remove();
				natureAmendment.remove();
				cashPaymentSpecial.remove();
			}
		}else {
			if (documentSubType1 == 'REGULAR'){
				charges.remove();
				chargesPayment.remove();
				//cashPayment.hide();
				proceedsBeneficiary.remove();
				natureAmendment.remove();
				cashPaymentSpecial.remove();
			}else{
				charges.remove();
				chargesPayment.remove();
				//cashPayment.remove();
				proceedsBeneficiary.remove();
				natureAmendment.remove();
				cashPaymentSpecial.remove();
			}
		}
	}else if(serviceType == 'Amendment'){

		cashPayment.remove();
		proceedsBeneficiary.remove();
		cashPaymentSpecial.remove();
		
	}else if(serviceType == 'Cancellation'){

		attachedDocuments.remove();
		charges.remove();
		chargesPayment.remove();
		cashPayment.remove();
		proceedsBeneficiary.remove();
		natureAmendment.remove();
		cashPaymentSpecial.remove();
		
	}else if(serviceType.toLowerCase() == "issuance" && grid.documentClass == "INDEMNITY"){
		cashPayment.remove();
		proceedsBeneficiary.remove();
		natureAmendment.remove();
		cashPaymentSpecial.remove();
		
	}else if(serviceType == 'Negotiation'){

		if (documentType == 'FOREIGN'){
			//cashPayment.remove();
			proceedsBeneficiary.remove();
			natureAmendment.remove();
		}else{
			//cashPayment.remove();
			natureAmendment.remove();
		}
		
	}else if(serviceType == 'UA Loan Settlement' || serviceType == 'UA_LOAN_SETTLEMENT'){

		if (documentType == 'FOREIGN'){
			cashPayment.remove();
			proceedsBeneficiary.remove();
			natureAmendment.remove();
		}else{
			cashPayment.remove();
			natureAmendment.remove();
		}
		
	}else if(serviceType == 'UA Loan Maturity Adjustment' || serviceType == 'UA_LOAN_MATURITY_ADJUSTMENT'){

		cashPayment.remove();
		proceedsBeneficiary.remove();
		natureAmendment.remove();
		cashPaymentSpecial.remove();
		
	}
}