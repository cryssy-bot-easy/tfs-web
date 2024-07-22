/**
 * Author: Arvin Patrick R. Guiam used for all textareas that requires to
 * display remaining characters and remaining lines
 * 
 * Modified by: Rafael Ski Poblete
 * Date : 7/26/18
 * Description : Added charset as global to limitCharAndLines function,
 * 				 Added var replaceFilter to be use in formatTextAreaColsRows function.
 * 				 Added conditions to check if charset is Z characters.
 */
//
var charsetGlobal;
$.fn.limitCharAndLines = function(cols, rows, charset){
		//Interim: This will bypass the 'Z' character set validation.
		charset = 'X';
		
		charsetGlobal = charset;
		$(this).siblings("span, br").remove();
		var charsLeft = 0;

	    var fieldName = $(this).attr("id");
	    var counterName = $(this).attr("id") + "_counter";
	    var lineName = $(this).attr("id") + "_line";
	    
	    var filter = /^[a-zA-Z0-9 \n\r\/\?\:\(\)\.\,\'+-]*$/;
	    var replaceFilter = /[^a-zA-Z0-9 \n\r\/\?\:\(\)\.\,\'+-]*/g;
	    
	    if(charsetGlobal == 'Z'){
	    	replaceFilter = /[^a-zA-Z0-9 \n\r\/\?\:\(\)\.\,\=\!\"\%\&\*\<\>\;\{\@\#\_\'+-]*/g; 
	    }
	    
		if(rows){
		    $(this).parent("div").append("<br/><span id='" + counterName + "'></span><br/><span id='" + lineName + "'></span>");
		    
		    $("#"+counterName).text('Characters Left: ' + cols);
		    $("#"+lineName).text('Lines Left: ' + rows);
		    function formatTextAreaColsRows(textareaId){
		    	var textarea = document.getElementById(textareaId);
		    	var string = textarea.value.replace(replaceFilter, "");
		    	var lines = new Array();
		    	var arrayInt = 0;
		    	lines[0] = "";
		    	while (string.length > 0){
			    	lines[arrayInt] = string.substring(0,cols);
			    	string = string.substring(cols, string.length);
			    	var j = 0; space = cols;
		        	if (arrayInt < rows - 1 && lines[arrayInt].length == cols){
				        while (j++ <= cols) {
			            	if (lines[arrayInt].charAt(j) === " "){
								space = j;
			            	}else if (lines[arrayInt].charAt(j) === "\n"){
			            		space = j;
			            		break;
			            	}
		        		}
			        }
					string = lines[arrayInt].substring(space + 1) + string;
			        lines[arrayInt] = lines[arrayInt].substring(0, space);
			        arrayInt++;
		    	}
		    	textarea.value = lines.slice(0, rows).join("\n");
		    	$("#"+counterName).text('Characters Left: ' + (cols - textarea.value.split("\n")[arrayInt].length));
		    	if(textarea.value.length > 0){
		        	$("#"+lineName).text('Lines Left: ' + (rows - textarea.value.split("\n").length));
		        	$("#lines").val(rows - textarea.value.split("\n").length);
		        } else {
		        	$("#"+lineName).text('Lines Left: ' + rows);
		        	$("#lines").val(rows);
		        }
		    } 
		    var textareaId = $(this).attr("id");
		    $(this).on("paste", function(e){
			    setTimeout(function(){
			    	formatTextAreaColsRows(textareaId);
			    }, 0);
		    });
		    $(this).on("keyup keypress change", function(e){
		    	var textarea = document.getElementById($(this).attr("id"));
		    	
		    	if(charsetGlobal == 'Z'){
		    		filter = /^[a-zA-Z0-9 \n\r\/\?\:\(\)\.\,\=\!\"\%\&\*\<\>\;\{\@\#\_\'+-]*$/; 
		    	}
		    	
		    	if(e.keyCode >= 35 && e.keyCode <= 37){
		       	 return false;
		       	}
		    	
		    	var regex = new RegExp(filter);
		        var key = String.fromCharCode(!e.charCode ? e.keyCode : e.charCode);
		    	var lines = textarea.value.split("\n");

			    for (var i = 0; i < lines.length; i++) {
			        if(regex.test(key)){
			    	if (lines[i].length <= cols) continue;
				        var j = 0; space = cols;
				        if (i < rows - 1){
					        while (j++ <= cols) {
					        	if (lines[i].charAt(j) === " "){
									space = j;
				            	}else if (lines[i].charAt(j) === "\n"){
				            		space = j;
				            		break;
				            	}
					        }
				        }
				        if (lines[i + 1]){
				        	lines[i + 1] = lines[i].substring(space + 1) + (" " + lines[i + 1]);
				        } else {
				        	lines[i + 1] = lines[i].substring(space + 1) + "";
				        }
				        lines[i] = lines[i].substring(0, space);
				    } else {
					    if(!(e.keyCode in {8:1,9:1,35:1,36:1,37:1,39:1,45:1,46:1,116:1})) e.preventDefault();
			        }
			    }
			    var pos = getInputSelection(textarea)
			    $(this).val(lines.slice(0, rows).join("\n"));
			    var lines = textarea.value.split("\n");
		        $("#"+counterName).text('Characters Left: ' + (cols - lines[lines.length-1].length));
		        if($(this).val().length > 0){
		        	$("#"+lineName).text('Lines Left: ' + (rows - lines.length));
		        } else {
		        	$("#"+lineName).text('Lines Left: ' + rows);
		        }
			    textarea.setSelectionRange(pos.start,pos.end);
		    });
		    setTimeout(function(){
		    	formatTextAreaColsRows(textareaId);
		    }, 0);
		}else{
			$(this).parent("div").append("<br/><span id='" + counterName + "'></span>");
			$("#"+counterName).text('Characters Left: ' + cols);
			function formatTextAreaCols(textareaId){
		    	var textarea = document.getElementById(textareaId);
		    	var string = textarea.value.replace(/[^a-zA-Z0-9 \n\r\/\?\:\(\)\.\,\'+-]*/gm, "");
		    	textarea.value = string.substring(0,cols);
		    	$("#"+counterName).text('Characters Left: ' + ((cols - textarea.value.length == -1) ? 0 : (cols - textarea.value.length)));
			}
			$(this).on("paste", function(e){
			    var textareaId = $(this).attr("id")
			    setTimeout(function(){
			    	formatTextAreaCols(textareaId);
			    }, 0);
		    });
			$(this).on("keyup keypress change", function(e){
				var textarea = document.getElementById($(this).attr("id"));
		    	var regex = new RegExp(filter);
		        var key = String.fromCharCode(!e.charCode ? e.keyCode : e.charCode);

		        var lines = textarea.value;
		        if(!regex.test(key) && !(e.keyCode in {8:1,9:1,35:1,36:1,37:1,39:1,45:1,46:1,116:1})) e.preventDefault();

		        var pos = getInputSelection(textarea)
		        $(this).val(lines.substring(0,cols));
		        $("#"+counterName).text('Characters Left: ' + ((cols - lines.length == -1) ? 0 : (cols - lines.length)));
		        textarea.setSelectionRange(pos.start,pos.end);
			});
			formatTextAreaCols($(this).attr('id'));
		}
		}
		function getInputSelection(el) {
		    var start = 0, end = 0, normalizedValue, range,
		        textInputRange, len, endRange;

		    if (typeof el.selectionStart == "number" && typeof el.selectionEnd == "number") {
		        start = el.selectionStart;
		        end = el.selectionEnd;
		    } else {
		        range = document.selection.createRange();

		        if (range && range.parentElement() == el) {
		            len = el.value.length;
		            normalizedValue = el.value.replace(/\r\n/g, "\n");

		            // Create a working TextRange that lives only in the input
		            textInputRange = el.createTextRange();
		            textInputRange.moveToBookmark(range.getBookmark());

		            // Check if the start and end of the selection are at the very end
		            // of the input, since moveStart/moveEnd doesn't return what we want
		            // in those cases
		            endRange = el.createTextRange();
		            endRange.collapse(false);

		            if (textInputRange.compareEndPoints("StartToEnd", endRange) > -1) {
		                start = end = len;
		            } else {
		                start = -textInputRange.moveStart("character", -len);
		                start += normalizedValue.slice(0, start).split("\n").length - 1;

		                if (textInputRange.compareEndPoints("EndToEnd", endRange) > -1) {
		                    end = len;
		                } else {
		                    end = -textInputRange.moveEnd("character", -len);
		                    end += normalizedValue.slice(0, end).split("\n").length - 1;
		                }
		            }
		        }
		    }

		    return {
		        start: start,
		        end: end
		    };
		}