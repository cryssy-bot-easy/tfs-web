/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 11/6/12
 * Time: 11:21 AM
 * To change this template use File | Settings | File Templates.
 */

jQuery.fn.setAccountNumberDropdown = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: searchCasaAccountsUrl,
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
        formatResult: formatAccountNumberResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionAccountNumber, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller,
    });

    return this;
}

jQuery.fn.queryCasaAccountNumbersByCurrency = function(currencyid) {
    var elementName = '#'+this.attr("id");
    var currency = $(currencyid).val();

    var casaUrl = searchCasaAccountsUrl;

    if (searchCasaAccountsUrl.indexOf("cifNumber") != -1) {
        casaUrl += '&currency=' + currency
    } else {
        if ($("#documentClass").length > 0 && $("#documentClass").val() == "CDT") {
            casaUrl += '?currency=PHP'
        }
    }
    //alert(casaUrl)
    $(elementName).select2({
        minimumInputLength: 0,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: casaUrl, //searchCasaAccountsUrl + '&currency=' + currency,
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
        formatResult: formatAccountNumberResult, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionAccountNumber, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller,
    });

    return this;
}

function formatAccountNumberResult(result) {

    var markup = "<table>";
    markup += "<tr>";
    markup += "<td>";
    markup += "<div>" + result.id + "</div>";
    markup += "<div class='autocomplete_id_below'>" + result.label + "</div>";
    markup += "</td>";
    markup += "</tr>";
    markup += "</table>";

    return markup;
}

function formatSelectionAccountNumber(result) {
    $("#accountName").val(result.label);
    return result.id;
}

////////////////////////
jQuery.fn.setAccountNumberDropdown2 = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 2,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: searchCasaAccountsUrl2,
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
        formatResult: formatAccountNumberResult2, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionAccountNumber2, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller,
    });

    return this;
}

jQuery.fn.setAccountNumberDropdown3 = function() {

    var elementName = '#'+this.attr("id");

    $(elementName).select2({
        minimumInputLength: 0,
        placeholder: 'SELECT ONE...',
        allowClear:true,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: searchCasaAccountsUrl2,
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
        formatResult: formatAccountNumberResult2, // omitted for brevity, see the source of this page
        formatSelection: formatSelectionAccountNumber2, // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller,
    });

    return this;
}

function formatAccountNumberResult2(result) {

    var markup = "<table>";
    markup += "<tr>";
    markup += "<td>";
    markup += "<div>" + result.id + "</div>";
    markup += "<div class='autocomplete_id_below'>" + result.label + "</div>";
    markup += "</td>";
    markup += "</tr>";
    markup += "</table>";

    return markup;
}

function formatSelectionAccountNumber2(result) {
    return result.id;
}


function initializeCasaAccounts() {
}

$(initializeCasaAccounts);
