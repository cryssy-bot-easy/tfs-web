/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/29/12
 * Time: 6:16 PM
 * To change this template use File | Settings | File Templates.
 */

// display / hide loan details tab based on existing payments made (displays if there is payments made through loan, otherwise, hides it)
function constuctLoanDetailsTab() {
    if(parseInt(loanCount) > 0) {
        $(".loanDetailsTab_data_entry").show();
    } else {
        $(".loanDetailsTab_data_entry").hide();
    }
}

function initializeNegotiationDataEntryBusinessRules() {
    constuctLoanDetailsTab();
}

$(initializeNegotiationDataEntryBusinessRules);
