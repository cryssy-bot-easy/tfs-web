$(document).ready(function(){
	var maxLength = 35;
	
	$('.adviseThroughBankA').click(enableOptionAdviseA);
	$('.adviseThroughBankB').click(enableOptionAdviseB);
	$('.adviseThroughBankD').click(enableOptionAdviseD);
	
	$('#adviseThroughBankIdentifierCodeTo').attr("readonly","readonly");
	$('#adviseThroughBankLocationTo').attr("readonly","readonly");
	$('#adviseThroughBankNameAndAddressTo').attr("readonly","readonly");
	
function enableOptionAdviseA(){
	$('#adviseThroughBankIdentifierCodeTo').removeAttr("readonly");
	$('#adviseThroughBankLocationTo').attr("readonly","readonly");
	$('#adviseThroughBankNameAndAddressTo').attr("readonly","readonly");
	
};

function enableOptionAdviseB(){
	$('#adviseThroughBankIdentifierCodeTo').attr("readonly","readonly");
	$('#adviseThroughBankLocationTo').removeAttr("readonly");
	$('#adviseThroughBankNameAndAddressTo').attr("readonly","readonly");
};

function enableOptionAdviseD(){
	$('#adviseThroughBankIdentifierCodeTo').attr("readonly","readonly");
	$('#adviseThroughBankLocationTo').attr("readonly","readonly");
	$('#adviseThroughBankNameAndAddressTo').removeAttr("readonly");
	
};
});