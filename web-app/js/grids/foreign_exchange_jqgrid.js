function setupForexChargesGrids(){
	var var_grid_url = foreignExchangeUrl;
	
	if(windowed){
		setupJqGridWidth('grid_list_forex', {width: 780, scrollOffset: 0, height: "auto", loadui: "disable", loadComplete:setupForeignExchangeRates},
				[['rates', 'Rates', 10],
				 ['rateDescription', 'Rate Description', 25],
				 ['passOnRate', 'Pass-on Rate', 35, 'right'],
				 ['specialRate', 'Special Rate', 35, 'right']], var_grid_url);
	} else {
		setupJqGridWidthEditable('grid_list_forex', {width: 780, scrollOffset: 0, height: "auto", loadui: "disable", loadComplete:setupForeignExchangeRates},
				[['rates', 'Rates', 10],
				 ['rateDescription', 'Rate Description', 25],
				 ['passOnRate', 'Pass-on Rate', 35, 'right'],
				 ['specialRate', 'Special Rate', 35, 'right']], var_grid_url, [2,3], [1,2,3], 'text');
	}
//	setupJqGridWidthEditable('grid_list_forex_popup', {width: 780, scrollOffset: 0, height: "auto", loadComplete:setupForeignExchangeRates},
//			[['rates', 'Rates', 10],
//			['rateDescription', 'Rate Description', 25],
//			['passOnRate', 'Pass-on Rate', 35, 'right'],
//			['specialRate', 'Special Rate', 35, 'right']], var_grid_url, [2,3], [1,2,3], 'text');

}

var conversion_rates = new Object()
function setupForeignExchangeRates() {
    if($("#grid_list_forex").length > 0) {
        var forexdata = $("#grid_list_forex").jqGrid("getRowData");
        $("#foreignExchangeRates").val(JSON.stringify(forexdata));
        forexdata = $("#grid_list_forex").jqGrid("getDataIDs")
        $.each(forexdata, function(index, value) {
        	conversion_rates[value] = $("#grid_list_forex").jqGrid("getCell",value,"specialRate");
        });

    }
}

function initForexCharges() {
	setupForexChargesGrids();
	
	// remove when backend is ready
//	insertToForexGrid();
    setupForeignExchangeRates();
}

// temporary inserts data to grid
//function insertToForexGrid() {
//	var forex_charges = $("#grid_list_forex");
//
//	forex_charges.addRowData("1",
//        {
//            rates: 'OFC-USD',
////            rates: '<input type="text" id="rates" value="OFC-USD" />',
//            rateDescription: 'USD-EUR(Bank Note-Sell)',
////            rateDescription: '<input type="text" id="rateDescription" value="USD-EUR (Bank Note-Sell)" />',
//            passOnRate: "1.472464",
////            passOnRate: '<input type="text" id="passOnRate" value="1.472464" />',
//            specialRate: "1.472464"
////            specialRate: '<input type="text" id="specialRate" value="1.472464" />'
//        }
//    );
//
//	forex_charges.addRowData("2",
//        {
//            rates: 'OFC-PHP',
////            rates: '<input type="text" id="rates" value="OFC-USD" />',
//            rateDescription: 'PHP - EUR (Regular LC Sell)',
////            rateDescription: '<input type="text" id="rateDescription" value="PHP-EUR (Regular LC Sell)" />',
//            passOnRate: '62.830039',
////            passOnRate: '<input type="text" id="passOnRate" value="62.830039" />',
//            specialRate: '62.830039'
////            specialRate: '<input type="text" id="specialRate" value="62.830039" />'
//        }
//    );
//
//	forex_charges.addRowData("3",
//        {
//            rates: 'USD-PHP',
////            rates: '<input type="text" id="rates" value="USD-PHP" />',
//            rateDescription: 'USD - PHP (Cash LC Sell)',
////            rateDescription: '<input type="text" id="rateDescription" value="USD-PHP (Cash LC Sell)" />',
//            passOnRate: '42.45',
////            passOnRate: '<input type="text" id="passOnRate" value="42.45" />',
//            specialRate: '42.45'
////            specialRate: '<input type="text" id="specialRate" value="42.45" />'
//        }
//    );
//
//    forex_charges.addRowData("4",
//        {
//            rates: 'URR',
////            rates: '<input type="text" id="rates" value="URR" />',
//            rateDescription: 'URR',
////            rateDescription: '<input type="text" id="rateDescription" value="URR" />',
//            passOnRate: '42.50',
////            passOnRate: '<input type="text" id="rates" value="42.50" />',
//            specialRate: '42.50'
////            specialRate: '<input type="text" id="rates" value="42.50" />'
//        }
//    );
//}

$(initForexCharges);