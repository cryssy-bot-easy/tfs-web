function setupCashGrids(){
	var var_grid_url = '';
	
	setupJqGridWidthEditable('grid_list_cash_forex', {width: 780, loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates', 10],
			['rateDescription', 'Rate Description', 25],
			['passOnRate', 'Pass-on Rate', 35, 'right'],
			['specialRate', 'Special Rate', 35, 'right']], var_grid_url, [], [], 'text');

//	var forex_cash = $("#grid_list_cash_forex");
//	forex_cash.addRowData("1",{rates: 'OFC-USD', rateDescription: 'USD - EUR (Bank Note-Sell)', passOnRate: '1.472464', specialRate: '1.472464'});
//	forex_cash.addRowData("2",{rates: 'OFC-PHP', rateDescription: 'PHP - EUR (Regular LC Sell)', passOnRate: '62.830039', specialRate: '62.830039'});
//	forex_cash.addRowData("3",{rates: 'USD-PHP', rateDescription: 'USD - PHP (Cash LC Sell)', passOnRate: '42.45', specialRate: '42.45'});
//	forex_cash.addRowData("4",{rates: 'URR', rateDescription: 'URR', passOnRate: '42.50', specialRate: '42.50'});
}

function init() {
	setupCashGrids();
	
}

$(init);