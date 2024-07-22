$(document).ready(function(){
	var maxLength = 35;
	
	$('.reimburseA').click(enableOptionReimburseA);
	$('.reimburseD').click(enableOptionReimburseD);
	
	$('#reimbursingBankIdentifierCodeTo').attr("readonly","readonly");
	$('#reimbursingBankNameAndAddressTo').attr("readonly","readonly");
	
function enableOptionReimburseA(){
	$('#reimbursingBankIdentifierCodeTo').removeAttr("readonly");
	$('#reimbursingBankNameAndAddressTo').attr("readonly","readonly");
	
};

function enableOptionReimburseD(){
	$('#reimbursingBankNameAndAddressTo').removeAttr("readonly");
	$('#reimbursingBankIdentifierCodeTo').attr("readonly","readonly");
	$("#remaining_char_reimbursingBankTo").text("");
};
});