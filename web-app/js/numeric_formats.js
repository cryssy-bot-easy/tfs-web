$(document).ready(function(){
	var thisClass=null;
	var classMatch=null;
	var splitMatch=null;
	var keyMatch=null;
	
	//numberFormat-length-decimal point
	//numberFormat-length
	//textFormat-length
	$("input[type=text][class]").filter(function(){
		return $(this).attr("class").match(/(text|number)Format[-\d+]*[-\d+]*/);
	}).each(function(){
		thisClass=$(this).attr("class");
			classMatch=thisClass.match(/(text|number)Format[-\d+]*[-\d+]*/)[0] || "UNKNOWN";
			splitMatch=classMatch.split("-");
			keyMatch=splitMatch[0].substring(splitMatch[0].indexOf("Format"),0);
			switch(keyMatch){
				case "number":
					if(splitMatch.length==2){//No Comma,No Decimal point
						$(this).autoNumeric({aSep:"",mDec:"0",vMax:addNine(splitMatch[1])});
					}
					else if(splitMatch.length==3){
						$(this).autoNumeric({vMax:addNine(splitMatch[1]),mDec:splitMatch[2]})
						.css("text-align","right");
					}
					break;
				case "text":
					$(this).attr("maxlength",splitMatch[1]);
					break;
			}
	});
	
	function addNine(numbers){
		var temp="";
		for(var x=0;x<numbers;x++){
			temp+="9";
		}
		return temp;
	}
});