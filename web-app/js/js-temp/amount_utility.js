$(function(){
	String.prototype.charCount = function(c)
	{
		return this.split(c).length;
	}
	$("#amount.lc_amount").keydown(setAmount);
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