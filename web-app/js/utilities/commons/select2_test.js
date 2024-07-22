/* DEFAULT */
/*
$(document).ready(function() { 

	$("#states").select2(); 
});
*/

/* WITH REMOTE DATA */

$(document).ready(function() { 
	
	$("#states").select2(); 
	
	$("#statess").select2({
	
		//placeholder: "Search for a movie",
		minimumInputLength: 2,
		ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
			url: autoCompleteCBCodeUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					//featureClass: "P",
					//q: term, // search term
					starts_with: term,
					page_limit: 10//,
					//apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
				};
			},
			results: function (data, page) { // parse the results into the format expected by Select2.
				//since we are using custom formatting functions we do not need to alter remote JSON data
				 var more = (page * 10) < data.total; // whether or not there are more results available
				 
				// notice we return the value of more so Select2 knows if more results can be loaded
				return {results: data.results, more: more};				
				
			}
		},
		formatResult: movieFormatResult, // omitted for brevity, see the source of this page
		formatSelection: movieFormatSelection, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});
	
});


function movieFormatResult(result) {
    var markup = "<table><tr>";
    markup += "<td><div>" + result.id + "</div>";
    markup += "<div>" + result.label + "</div>";    
    markup += "</td></tr></table>";
    return markup;
}

//Kung ano ang masasave sa Input Field
function movieFormatSelection(result) {
    return result.id;
}
