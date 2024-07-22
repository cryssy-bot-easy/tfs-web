$(document).ready(function(){
	
	/************* Account Institution **************/
	$('#accountWithInstitutionIdentifierCode').attr("readonly","readonly");
	$('#accountWithInstitutionLocation').attr("readonly","readonly");
	$('#accountNameAndAddressMt').attr("readonly","readonly");

	
	$('.acctInstitutionOptionA').click(accountEnableInputA);
	$('.acctInstitutionOptionB').click(accountEnableInputB);
	$('.acctInstitutionOptionD').click(accountEnableInputD);
	$('.acctInstitutionOptionC').click(accountEnableInputC);

	/************************** Account with Bank *************************/
	
	$('.accountWithBankOptionA').click(accountWithBankEnableInputA);
	$('.accountWithBankOptionB').click(accountWithBankEnableInputB);
	$('.accountWithBankOptionD').click(accountWithBankEnableInputD);
	
	$('#accountWithBankIdentifierCode').attr("readonly","readonly");
	$('#accountWithBankLocation').attr("readonly","readonly");
	$('#accountWithBankNameAndAddress').attr("readonly","readonly");
	

	/**************** Beneficiary Institution *******************/
	$('.beneficiaryInstitutionOptionA').click(beneficiaryEnableInputA);
	$('.beneficiaryInstitutionOptionD').click(beneficiaryEnableInputD);
	
	$('#beneficiarysInstitutionIdentifierCode').attr("readonly","readonly");
	$('#beneficiaryNameAndAddressMt').attr("readonly","readonly");
	
	/*********************** Beneficiary Bank **********************/
	
	$('.beneficiaryBankOptionA').click(beneficiaryBankEnableInputA);
	$('.beneficiaryBankOptionB').click(beneficiaryBankEnableInputB);
	$('.beneficiaryBankOptionD').click(beneficiaryBankEnableInputD);
	
	$('#beneficiaryBankIdentifierCode').attr("readonly","readonly");
	$('#beneficiaryBankLocation').attr("readonly","readonly");
	$('#beneficiaryBankNameAndAddress').attr("readonly","readonly");
	
	
	/**************** Intermediary *******************/
	
	$('.intermediaryOptionA').click(intermediaryEnableInputA);
	$('.intermediaryOptionC').click(intermediaryEnableInputC);
	$('.intermediaryOptionD').click(intermediaryEnableInputD);
	
	$('#intermediaryIdentifierCode').attr("readonly","readonly");
	$('#intermediaryNameAndAddressMt').attr("readonly","readonly");
	
	/**************** Issuing Bank *******************/
	
	$('.issuingBankOptionA').click(issuingBankEnableInputA);
	$('.issuingBankOptionD').click(issuingBankEnableInputD);
	
	$('#issuingBankIdentifierCode').attr("readonly","readonly");
	$('#issuingBankNameAndAddress').attr("readonly","readonly");
	
	/**************** Ordering Institution *******************/
	
	$('.orderInstitutionOptionA').click(orderingEnableInputA);
	$('.orderInstitutionOptionD').click(orderingEnableInputD);
	
	$('#orderingInstitutionIdentifierCode').attr("readonly","readonly");
	$('#bankNameAndAddressMt').attr("readonly","readonly");
	
	/******************* receiver correspondent ***************************/
	
	$('.receiverCorrespondentOptionA').click(receiverEnableInputA);
	$('.receiverCorrespondentOptionB').click(receiverEnableInputB);
	$('.receiverCorrespondentOptionD').click(receiverEnableInputD);
	
	$('#receiversCorrespondentIdentifierCode').attr("readonly","readonly");
	$('#receiversCorrespondentLocation').attr("readonly","readonly");
	$('#receiverNameAndAddressMt').attr("readonly","readonly");

	/******************* sender correspondent ***************************/
	$('.senderCorrespondentOptionA').click(senderEnableInputA);
	$('.senderCorrespondentOptionB').click(senderEnableInputB);
	$('.senderCorrespondentOptionD').click(senderEnableInputD);
	
	$('#senderCorrespondentIdentifierCode').attr("readonly","readonly");
	$('#sendersCorrespondentLocation').attr("readonly","readonly");
	$('#senderNameAndAddressMt').attr("readonly","readonly");

	
	/**************** Third Reimbursement *******************/
	$('.thirdReimbursementInstitutionOptionA').click(thirdReimbursementEnableInputA);
	$('.thirdReimbursementInstitutionOptionB').click(thirdReimbursementEnableInputB);
	$('.thirdReimbursementInstitutionOptionD').click(thirdReimbursementEnableInputD);
	
	$('#thirdReimbursementInstitutionIdentifierCode').attr("readonly","readonly");
	$('#thirdReimbursementInstitutionLocation').attr("readonly","readonly");
	$('#thirdReimbursementInstitutionNameAndAddress').attr("readonly","readonly");

    $("#currency").setCurrencyDropdown();
    $("#sendersChargesCurrency").setCurrencyDropdown();
    $("#receiversChargesCurrency").setCurrencyDropdown();



});

/************* Account Institution **************/
function accountEnableInputA(){
	$('#accountWithInstitutionIdentifierCode').removeAttr("readonly");
	$('#accountWithInstitutionLocation').attr("readonly","readonly");
	$('#accountNameAndAddressMt').attr("readonly","readonly");
	$('#accountInstitutionIdentity').text("a");
};

function accountEnableInputB(){
	
	$('#accountWithInstitutionLocation').removeAttr("readonly");
	$('#accountWithInstitutionIdentifierCode').attr("readonly","readonly");
	$('#accountNameAndAddressMt').attr("readonly","readonly");
	$('#accountInstitutionIdentity').text("b");
};

function accountEnableInputD(){
	
	$('#accountNameAndAddressMt').removeAttr("readonly");
	$('#accountWithInstitutionIdentifierCode').attr("readonly","readonly");
	$('#accountWithInstitutionLocation').attr("readonly","readonly");
	$('#accountInstitutionIdentity').text("d");
	
};

function accountEnableInputC(){
	$('#accountWithInstitutionIdentifierCode').attr("readonly","readonly");
	$('#accountWithInstitutionLocation').attr("readonly","readonly");
	$('#accountWithInstitutionNameAndAddress').attr("readonly","readonly");
	$('#accountInstitutionIdentity').text("c");	
}

/************************** Account with Bank *************************/

function accountWithBankEnableInputA(){
	$('#accountWithBankIdentifierCode').removeAttr("readonly");
	$('#accountWithBankLocation').attr("readonly","readonly");
	$('#accountWithBankNameAndAddress').attr("readonly","readonly");
	
};

function accountWithBankEnableInputB(){
	
	$('#accountWithBankLocation').removeAttr("readonly");
	$('#accountWithBankIdentifierCode').attr("readonly","readonly");
	$('#accountWithBankNameAndAddress').attr("readonly","readonly");
};

function accountWithBankEnableInputD(){
	
	$('#accountWithBankNameAndAddress').removeAttr("readonly");
	$('#accountWithBankIdentifierCode').attr("readonly","readonly");
	$('#accountWithBankLocation').attr("readonly","readonly");
};

/**************** Beneficiary Institution *******************/
function beneficiaryEnableInputA(){
	$('#beneficiarysInstitutionIdentifierCode').removeAttr("readonly");
	$('#beneficiaryNameAndAddressMt').attr("readonly","readonly");
	$('#beneficiaryIdentity').text("a");
};

function beneficiaryEnableInputD(){
	$('#beneficiaryNameAndAddressMt').removeAttr("readonly");
	$('#beneficiarysInstitutionIdentifierCode').attr("readonly","readonly");
	$('#beneficiaryIdentity').text("d");
	$(countCharactersBeneficiaryInstitutionAddress);
};

/*********************** Beneficiary Bank **********************/

function beneficiaryBankEnableInputA(){
	$('#beneficiaryBankIdentifierCode').removeAttr("readonly");
	$('#beneficiaryBankLocation').attr("readonly","readonly");
	$('#beneficiaryBankNameAndAddress').attr("readonly","readonly");
	
};

function beneficiaryBankEnableInputB(){
	
	$('#beneficiaryBankLocation').removeAttr("readonly");
	$('#beneficiaryBankIdentifierCode').attr("readonly","readonly");
	$('#beneficiaryBankNameAndAddress').attr("readonly","readonly");
};

function beneficiaryBankEnableInputD(){
	
	$('#beneficiaryBankNameAndAddress').removeAttr("readonly");
	$('#beneficiaryBankIdentifierCode').attr("readonly","readonly");
	$('#beneficiaryBankLocation').attr("readonly","readonly");
};


/**************** Intermediary *******************/

function intermediaryEnableInputA(){
	$('#intermediaryIdentifierCode').removeAttr("readonly");
	$('#intermediaryNameAndAddressMt').attr("readonly","readonly");
	$('#intermediaryIdentity').text("a");
};

function intermediaryEnableInputD(){
	$('#intermediaryNameAndAddressMt').removeAttr("readonly");
	$('#intermediaryIdentifierCode').attr("readonly","readonly");
	$('#intermediaryIdentity').text("d");
	$(countCharactersIntermediaryAddress);
};

function intermediaryEnableInputC(){
	$('#intermediaryIdentifierCode').attr("readonly","readonly");
	$('#intermediaryNameAndAddressMt').attr("readonly","readonly");
	$('#intermediaryIdentity').text("c");
}

/**************** Issuing Bank *******************/

function issuingBankEnableInputA(){
	$('#issuingBankIdentifierCode').removeAttr("readonly");
	$('#issuingBankNameAndAddress').attr("readonly","readonly");
	
};

function issuingBankEnableInputD(){
	$('#issuingBankNameAndAddress').removeAttr("readonly");
	$('#issuingBankIdentifierCode').attr("readonly","readonly");
};

/**************** Ordering Institution *******************/

function orderingEnableInputA(){
	$('#orderingInstitutionIdentifierCode').removeAttr("readonly");
	$('#bankNameAndAddressMt').attr("readonly","readonly");
	$('#orderingIdentity').text("a");
};

function orderingEnableInputD(){
	$('#bankNameAndAddressMt').removeAttr("readonly");
	$('#orderingInstitutionIdentifierCode').attr("readonly","readonly");
	$('#orderingIdentity').text("d");
	
};


/******************* receiver correspondent ***************************/

function receiverEnableInputA(){
	$('#receiversCorrespondentIdentifierCode').removeAttr("readonly");
	$('#receiversCorrespondentLocation').attr("readonly","readonly");
	$('#receiverNameAndAddressMt').attr("readonly","readonly");
	$('#receiverIdentity').text("a");
};

function receiverEnableInputB(){
	
	$('#receiversCorrespondentLocation').removeAttr("readonly");
	$('#receiversCorrespondentIdentifierCode').attr("readonly","readonly");
	$('#receiverNameAndAddressMt').attr("readonly","readonly");
	$('#receiverIdentity').text("b");
};

function receiverEnableInputD(){
	
	$('#receiverNameAndAddressMt').removeAttr("readonly");
	$('#receiversCorrespondentIdentifierCode').attr("readonly","readonly");
	$('#receiversCorrespondentLocation').attr("readonly","readonly");
	$('#receiverIdentity').text("d");
};

/******************* sender correspondent ***************************/
function senderEnableInputA(){
	$('#senderCorrespondentIdentifierCode').removeAttr("readonly");
	$('#sendersCorrespondentLocation').attr("readonly","readonly");
	$('#senderNameAndAddressMt').attr("readonly","readonly");
	$('#senderIdentity').text("a");
};

function senderEnableInputB(){
	
	$('#sendersCorrespondentLocation').removeAttr("readonly");
	$('#senderCorrespondentIdentifierCode').attr("readonly","readonly");
	$('#senderNameAndAddressMt').attr("readonly","readonly");
	$('#senderIdentity').text("b");
};

function senderEnableInputD(){
	
	$('#senderNameAndAddressMt').removeAttr("readonly");
	$('#senderCorrespondentIdentifierCode').attr("readonly","readonly");
	$('#sendersCorrespondentLocation').attr("readonly","readonly");
	$('#senderIdentity').text("d");
	
};

/**************** Third Reimbursement *******************/

function thirdReimbursementEnableInputA(){
	$('#thirdReimbursementInstitutionIdentifierCode').removeAttr("readonly");
	$('#thirdReimbursementInstitutionLocation').attr("readonly","readonly");
	$('#thirdReimbursementInstitutionNameAndAddress').attr("readonly","readonly");
	$('#thirdReimbursementIdentity').text("a");
};

function thirdReimbursementEnableInputB(){
	
	$('#thirdReimbursementInstitutionLocation').removeAttr("readonly");
	$('#thirdReimbursementInstitutionIdentifierCode').attr("readonly","readonly");
	$('#thirdReimbursementInstitutionNameAndAddress').attr("readonly","readonly");
	$('#thirdReimbursementIdentity').text("b");
};

function thirdReimbursementEnableInputD(){
	
	$('#thirdReimbursementInstitutionNameAndAddress').removeAttr("readonly");
	$('#thirdReimbursementInstitutionIdentifierCode').attr("readonly","readonly");
	$('#thirdReimbursementInstitutionLocation').attr("readonly","readonly");
	$('#thirdReimbursementIdentity').text("d");
};


