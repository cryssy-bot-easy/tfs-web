$(initializeTransactionGrid);

function setupTransactionGrids(){
	var transactionGridUrl = '';
	setupJqGridPager('grid_list_transaction', {height: 72, width: 280, loadui: "disable", scrollOffset: 0},
		[['type', 'Type'],
		['amount', 'Amount']],'grid_pager_transaction', transactionGridUrl);
}

function initializeTransactionGrid(){
	setupTransactionGrids();
}
