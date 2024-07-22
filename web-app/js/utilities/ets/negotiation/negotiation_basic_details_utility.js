/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/1/12
 * Time: 12:32 PM
 * To change this template use File | Settings | File Templates.
 */

function initializeNegotiationBasicDetailsUtility() {
    var negotiationNumbers = stringToListHashMap(negotiationNumberString);

    for(var i in negotiationNumbers) {
        $('#negotiationNumber').append(
            $('<option></option>').val(negotiationNumbers[i]["NEGOTIATIONNUMBER"]).html(negotiationNumbers[i]["NEGOTIATIONNUMBER"])
        );
    }
}

$(initializeNegotiationBasicDetailsUtility);


