function isNumberKey(evt) //for amount
{


   var charCode = (evt.which) ? evt.which : event.keyCode;
   if (charCode != 46 && charCode > 31 
     && (charCode < 48 || charCode > 57))
      return false;

   return true;
   

}

function isAlphaNumericKey2(e){
	var regex=/[a-zA-Z0-9-\/]/;
	var charCheck = true;
	var charCode = (e.which) ? e.which : e.keyCode;
	var actual_char=String.fromCharCode(charCode);

	if(!regex.test(actual_char) && !(e.keyCode in {8:1,9:1,35:1,36:1,37:1,39:1,45:1,46:1,116:1})){
        charCheck = false;
    } 
	return charCheck
}

function isAlphaNumericKey(e){
	var regex=/[a-zA-Z0-9]/;
	var charCheck = true;
	var actual_char=String.fromCharCode(e.which);

	if(!regex.test(actual_char)){
        charCheck = false;
    } 
	return charCheck
}

function isNumberKeyOnly(evt) 
{
	var charCode = (evt.which) ? evt.which : evt.keyCode;
	   if (charCode = 46 && charCode > 31 
	     && (charCode < 48 || charCode > 57))
	   {   return false;
	   }
	   return true;  

}

//
function intFormat(n)
{
var
regex = /(\d)((\d{3},?)+)$/;

n = n.split(',').join('');

while(regex.test(n))
{
n = n.replace(regex, '$1,$2');
}

return n;
}
function numFormat(n)
{
var
pointReg = /([\d,\.]*)\.(\d*)$/, f;

if(pointReg.test(n))
{
f = RegExp.$2;
return intFormat(RegExp.$1) + '.' + f;
}
return intFormat(n);
}

$(function(){
	String.prototype.charCount = function(c)
	{
		return this.split(c).length;
	}
	$("#negotiationAmount").keydown(setAmount);
	
});

function setAmount(e){
	if((e.keyCode >= 33 && e.keyCode <= 57) || (e.keyCode >= 93 && e.keyCode <= 105) || e.keyCode == 27 || e.keyCode == 8){
		//for numbers, string navigation keys, and backspace and esc keys
		return true;
	} else if(e.keyCode == 190 || e.keyCode == 110){	// for "."
		if($(this).val().charCount('.') <= 1){
			return true;
		}else{
			return false;
		}
	} else {
		return false;
	}
}
