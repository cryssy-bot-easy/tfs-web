///* WITH REMOTE DATA */
//

/**
 * (revision)
SCR/ER Number: 
SCR/ER Description: Redmine Issue #4195 - Add validation in the settlement currency field in both Settlement to Bene and Charges tabs such that only PHP and USD are allowed. Thirds are not allowed.
[Revised by:] John Patrick C. Bautista
[Date deployed:] 06/16/2017
Program [Revision] Details: Added new jQuery function for new Settlement Currency only using USD and PHP
Member Type: JavaScript file (JS)
Project: WEB
Project Name: autocomplete_utility.js

 * (Modify)
[Modified by:] Rafael Ski Poblete
[Date Modified:] 09/19/2018
Program [Modified] Details: Added autocomplete for Purpose of Message.
 */
/**
 * (revision)
SCR/ER Number: 
SCR/ER Description:
[Revised by:] Cedrick C. Nungay
[Date deployed:] 09/18/2018
Program [Revision] Details: Added set dropdowns for 759
Member Type: JavaScript file (JS)
Project: WEB
Project Name: autocomplete_utility.js
 */

jQuery.fn.setCurrencyDropdownForeign = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteCurrencyUrl,
            dataType: 'json',
            data: function (term, page, type) {
                return {
                    //featureClass: "P",
                    //q: term, // search term
                    type: "FX",
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setCurrencyDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteCurrencyUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setCurrencyDropdownUsdPhpOnly = function() {

    var elementName = '#'+this.attr("id");

    var autocompleteUrl = "";

    if(typeof autoCompleteUsdPhpOnlyCurrencyUrl != 'undefined') {
        autocompleteUrl = autoCompleteUsdPhpOnlyCurrencyUrl;
    } else {
        autocompleteUrl = autoCompleteCurrencyUrl;
    }


    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autocompleteUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setSettlementCurrencyDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
        	url: autoCompleteSettlementCurrencyUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

// 03232017 - RM 4195 - Additional method for new Settlement Currency only using USD and PHP
jQuery.fn.setNewSettlementCurrencyDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
//        	url: autoCompleteSettlementCurrencyUrl,
        	url: autoCompleteUsdPhpOnlyCurrencyUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setDomesticProductCurrencyDropdown = function(currency) {
	
	var elementName = '#'+this.attr("id");
	currencyCode = currency;
	
	$(elementName).select2({
		minimumInputLength: 2,
		placeholder: 'SELECT ONE...',
		allowClear:true,
		ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
			url: autoCompleteDomesticProductCurrencyUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					//featureClass: "P",
					//q: term, // search term
					starts_with: term,
					currency: currencyCode,
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
		formatResult: formatResult, // omitted for brevity, see the source of this page
		formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});
	
	return this;
}

jQuery.fn.setDomesticSettlementCurrencyDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteDomesticSettlementCurrencyUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setCBCodeDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteCBCodeUrl,
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCBCode, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller

    });

    return this;
}

jQuery.fn.setFirmLibDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteFirmLibUrl,
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionFirmLib, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller

    });

    return this;
}

jQuery.fn.setClientDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteClientUrl,
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionClient, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller

    });

    return this;
}

jQuery.fn.setCountryDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteCountryUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCountry, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });
    return this;
}

jQuery.fn.setCountryIsoDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteCountryIsoUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCountry, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });
    return this;
}


jQuery.fn.setBankDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteBankUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
            formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
            dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}


jQuery.fn.setLocalBankDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteLocalBankUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
            formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
            dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setRmaBankDropdown = function() {
	
	var elementName = '#'+this.attr("id");
	
	$(elementName).select2({
		minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
		ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
			url: autoCompleteRmaBankUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					starts_with: term,
					page_limit: 10//,
				};
			},
			results: function (data, page) { // parse the results into the format expected by Select2.
				//since we are using custom formatting functions we do not need to alter remote JSON data
				var more = (page * 10) < data.total; // whether or not there are more results available
				
				// notice we return the value of more so Select2 knows if more results can be loaded
				return {results: data.results, more: more};
				
			}
		},
		formatResult: formatResult, // omitted for brevity, see the source of this page
		formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});
	
	return this;
}


jQuery.fn.setDepositoryBankDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteDepositoryBankUrl,
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setDepositoryBankDropdownWithCurrency = function(currency) {

    var elementName = '#'+this.attr("id");
    currencyCode = currency;

    $(elementName).select2({
        minimumInputLength: 0,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteBankUrl,//autoCompleteDepositoryBankUrl
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    currency: currencyCode,
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setDepositoryBankDropdownWithCurrencyCorres = function(currency) {

    var elementName = '#'+this.attr("id");
    currencyCode = currency;

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteDepositoryBankUrl,
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    currency: currencyCode,
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setDepositoryBankDropdownWithCurrency2 = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 0,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteDepositoryBankUrl,
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    currency: $("#currency").val(),
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setDepositoryBankDropdown2 = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 0,
         placeholder: 'SELECT ONE...',
         allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteDepositoryBankUrl,
            dataType: 'json',
            data: function (term, page) {
                return {
                    starts_with: term,
                    page_limit: 10//,
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                //since we are using custom formatting functions we do not need to alter remote JSON data
                var more = (page * 10) < data.total; // whether or not there are more results available

                // notice we return the value of more so Select2 knows if more results can be loaded
                return {results: data.results, more: more};

            }
        },
        formatResult: formatResultForDepositoryBank, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionBanks, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setCurrencyDropdownInquiry = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteCurrencyUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionCurrency, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setExportAdvisingNumber = function() {

    var elementName = '#'+this.attr("id");

    var compUrl = autoCompleteExportAdvisingUrl;

    if ($("#cifNumber").length > 0) {
        compUrl += "?cifNumber=" + $("#cifNumber").val();
    }

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: compUrl,
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
        formatResult: formatResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionExportAdvising, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });
    return this;
}

jQuery.fn.setDigitalSignatoriesDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        placeholder: 'SELECT ONE...',
        allowClear:true,
            ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: autoCompleteDigitalSignatoriesUrl,
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
        formatResult: formatResultForDigitalSignatories, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionDigitalSignatories, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });

    return this;
}

jQuery.fn.setCommodityCodeDropdown = function() {
	var elementName = '#'+this.attr("id");

	$(elementName).select2({
		minimumInputLength: 2,
		placeholder: 'SELECT ONE...',
		allowClear:true,
		ajax: { 
			url: autoCompleteCommodityCodeUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					starts_with: term,
					page_limit: 10
				};
			},
			results: function (data, page) { // parse the results into the format expected by Select2.
				//since we are using custom formatting functions we do not need to alter remote JSON data
				var more = (page * 10) < data.total; // whether or not there are more results available
				// notice we return the value of more so Select2 knows if more results can be loaded
				return {results: data.results, more: more};
			}
		},
		formatResult: formatResultCommodityCode, // omitted for brevity, see the source of this page
		formatSelection: formatSelectionCommodityCode, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});

	return this;
}

jQuery.fn.setParticularsDropdown = function() {
	var elementName = '#'+this.attr("id");
	
	$(elementName).select2({
		minimumInputLength: 2,
		placeholder: 'SELECT ONE...',
		allowClear:true,
		ajax: { 
			url: autoCompleteParticularsUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					starts_with: term,
					page_limit: 10
				};
			},
			results: function (data, page) { // parse the results into the format expected by Select2.
				//since we are using custom formatting functions we do not need to alter remote JSON data
				var more = (page * 10) < data.total; // whether or not there are more results available
				// notice we return the value of more so Select2 knows if more results can be loaded
				return {results: data.results, more: more};
			}
		},
		formatResult: formatResultParticulars, // omitted for brevity, see the source of this page
		formatSelection: formatSelectionParticulars, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});
	
	return this;
}

jQuery.fn.setFormOfUndertakingDropdown = function(functionOfMessage) {
	var elementName = '#'+this.attr("id");
	
	$(elementName).select2({
		minimumInputLength: 2,
		placeholder: 'SELECT ONE...',
		allowClear:true,
		ajax: { 
			url: autoCompleteFormOfUndertakingUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					starts_with: term,
					functionOfMessage: functionOfMessage,
					page_limit: 10
				};
			},
			results: function (data, page) { // parse the results into the format expected by Select2.
				//since we are using custom formatting functions we do not need to alter remote JSON data
				var more = (page * 10) < data.total; // whether or not there are more results available
				// notice we return the value of more so Select2 knows if more results can be loaded
				return {results: data.results, more: more};
			}
		},
		formatResult: formatResult, // omitted for brevity, see the source of this page
		formatSelection: formatSelectionParticulars, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});
	
	return this;
}

jQuery.fn.setFunctionOfMessageDropdown = function() {
	var elementName = '#'+this.attr("id");
	
	$(elementName).select2({
		minimumInputLength: 2,
		placeholder: 'SELECT ONE...',
		allowClear:true,
		ajax: { 
			url: autoCompleteFunctionOfMessageUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					starts_with: term,
					page_limit: 20
				};
			},
			results: function (data, page) { // parse the results into the format expected by Select2.
				//since we are using custom formatting functions we do not need to alter remote JSON data
				var more = (page * 20) < data.total; // whether or not there are more results available
				// notice we return the value of more so Select2 knows if more results can be loaded
				return {results: data.results, more: more};
			}
		},
		formatResult: formatResult, // omitted for brevity, see the source of this page
		formatSelection: formatSelectionParticulars, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});
	
	return this;
}

jQuery.fn.setFileIdentificationDropdown = function() {
	var elementName = '#'+this.attr("id");
	
	$(elementName).select2({
		minimumInputLength: 2,
		placeholder: 'SELECT ONE...',
		allowClear:true,
		ajax: { 
			url: autoCompleteFileIdentificationUrl,
			dataType: 'json',
			data: function (term, page) {
				return {
					starts_with: term,
					page_limit: 20
				};
			},
			results: function (data, page) { // parse the results into the format expected by Select2.
				//since we are using custom formatting functions we do not need to alter remote JSON data
				var more = (page * 20) < data.total; // whether or not there are more results available
				// notice we return the value of more so Select2 knows if more results can be loaded
				return {results: data.results, more: more};
			}
		},
		formatResult: formatResult, // omitted for brevity, see the source of this page
		formatSelection: formatSelectionParticulars, // omitted for brevity, see the source of this page
		dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	});
	
	return this;
}
jQuery.fn.setPurposeOfMessageDropdown = function() {
		var elementName = '#'+this.attr("id");
		
		$(elementName).select2({
			minimumInputLength: 2,
			placeholder: 'SELECT ONE...',
			allowClear:true,
			ajax: { 
				url: autoCompletePurposeOfMessageUrl,
				dataType: 'json',
				data: function (term, page) {
					return {
						starts_with: term,
						page_limit: 20
					};
				},
				results: function (data, page) { // parse the results into the format expected by Select2.
					//since we are using custom formatting functions we do not need to alter remote JSON data
					var more = (page * 20) < data.total; // whether or not there are more results available
					// notice we return the value of more so Select2 knows if more results can be loaded
					return {results: data.results, more: more};
				}
			},
			formatResult: formatResult, // omitted for brevity, see the source of this page
			formatSelection: formatSelectionParticulars, // omitted for brevity, see the source of this page
			dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
		});
		
		return this;
}
function formatResult(result) {

    var markup = '<table><tr><td>';
    markup += '<div>' + result.label + '</div>';
    markup += '<div class="autocomplete_id_below">' + result.id + (result.hidden ? (' - ' + result.hidden) : '') + '</div>';
    markup += '</td></tr></table>';
    return markup;
}

function formatResultForDepositoryBank(result) {

    var markup = '<table><tr><td>';
    markup += '<div>' + result.label + '</div>';
    markup += '<div class="autocomplete_id_below">' + result.currency + '</div>';
    markup += '<div class="autocomplete_id_below">' + result.id + '</div>';
    markup += '</td></tr></table>';
    return markup;
}
//
////Kung ano ang masasave sa Input Field
//function formatSelection(result) {
//	
//	
//    return result.label;
//}
//
function formatSelectionBanks(result) {
    return result.id;
}
//
function formatSelectionCBCode(result) {
	return result.id;
}
//
function formatSelectionFirmLib(result) {
	return result.id;
}
//
function formatSelectionClient(result) {
	if(result.id != null){
		return result.id;
	} else {
		return result.clientId;
	}
}
//
function formatSelectionCountry(result) {
    return result.id;
}
//
function formatSelectionCurrency(result) {
    return result.id;
}
//

function formatSelectionExportAdvising(result) {
    return result.id;
}

function formatSelectionDigitalSignatories(result) {
	return result.id;
}

function formatSelectionCommodityCode(result) {
	return result.id;
}

function formatSelectionParticulars(result) {
	return result.id;
}

function formatResultForDigitalSignatories(result) {
	var markup = '<table><tr><td>';
    markup += '<div>' + result.id+ '</div>';
    markup += '<div class="autocomplete_id_below">' + result.position + '</div>';
    markup += '</td></tr></table>';
    return markup;
}

function formatResultCommodityCode(result) {
	var markup = '<table><tr><td>';
    markup += '<div>' + result.label + '</div>';
    markup += '<div class="autocomplete_id_below">' + result.code + '</div>';
    markup += '</td></tr></table>';
    return markup;
}

function formatResultParticulars(result) {
	var markup = '<table><tr><td>';
	markup += '<div>' + result.label+ '</div>';
	markup += '<div class="autocomplete_id_below">' + result.code + '</div>';
	markup += '</td></tr></table>';
	return markup;
}
