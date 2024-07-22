function setupTransactionTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_transaction_type', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function initTransactionTypeGrid(){
	setupTransactionTypeGrid();
	
//	var grid2=$("#grid_list_transaction_type");
//
//	grid2.addRowData("1",{rates:"OFC-USD",rateDescription:"USD - EUR (Bank Note Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	grid2.addRowData("2",{rates:"OFC-PHP",rateDescription:"PHP - EUR (Regular LC Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	grid2.addRowData("3",{rates:"USD-PHP",rateDescription:"USD - PHP (Regular LC Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	grid2.addRowData("4",{rates:"USD-USD",rateDescription:"URR",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
}



$(initTransactionTypeGrid);
