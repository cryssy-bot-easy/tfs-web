function setUpApGrids(){

	var apBalanceChargesGridUrl = null//'http://localhost:8080/tfs-web/weh';
	var apBalanceCashGridUrl = null//'http://localhost:8080/tfs-web/weh';
	var apBalanceUaLoanGridUrl = null//'http://localhost:8080/tfs-web/weh';


	// Cash Payment
    setupJqGridPagerTest('grid_list_ap_balance_cash', {height:"auto", width: 280, loadui: "disable", scrollOffset:0},
					[['transactionCash', 'Transaction'],
					['apCurrencyCash', 'AP Currency'],
					['apAmountCash', 'AP Amount']],'grid_pager_ap_balance_cash');

	// Charges Payment
    setupJqGridPagerTest('grid_list_ap_balance_charges', {height:"auto", width: 280, loadui: "disable", scrollOffset:0},
					[['transactionCharges', 'Transaction'],
					['apCurrencyCharges', 'AP Currency'],
					['apAmountCharges', 'AP Amount']],'grid_pager_ap_balance_charges');

	// UA Loan
    setupJqGridPagerTest('grid_list_ap_balance_ua_loan', {height:"auto", width: 280, loadui: "disable", scrollOffset:0},
					[['transactionCharges', 'Transaction'],
					['apCurrencyCharges', 'AP Currency'],
					['apAmountCharges', 'AP Amount']],'grid_pager_ap_balance_ua_loan');

}

function initializeApGrids(){
    setUpApGrids();
}

$(initializeApGrids);