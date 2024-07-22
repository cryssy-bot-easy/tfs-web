function setupMDCollectionGrids(){
	var mdCollectionGridUrl = '';
	
	setupJqGridPager('grid_list_md_collection', {height: 71, width: 780, loadui: "disable", scrollOffset:0},
					[['accountNumber', 'Account Number'],
					['modeOfPayment', 'Mode of Payment'],
					['settlementCurrency', 'Settlement Currency'],
					['amount', 'Marginal Deposit Amount'],
					['edit','Edit'],
					['deleteMdCollection','Delete']], 'grid_pager_md_collection', mdCollectionGridUrl);
}

function initMDCollectionGrid(){
	setupMDCollectionGrids();

//	var mdCollectionGrid=$("#grid_list_md_collection");
//	mdCollectionGrid.addRowData("1",{accountNumber:'100-000-000',modeOfPayment:'CASH',settlementCurrency:'USD',amount:'1,000,000.00',edit:'<a href=\"javascript:void(0)\">edit</a>',deleteMdCollection:'<a href=\"javascript:void(0)\">delete</a>'});
//	mdCollectionGrid.addRowData("2",{accountNumber:'200-000-000',modeOfPayment:'CASH',settlementCurrency:'USD',amount:'1,000,000.00',edit:'<a href=\"javascript:void(0)\">edit</a>',deleteMdCollection:'<a href=\"javascript:void(0)\">delete</a>'});
//	mdCollectionGrid.addRowData("3",{accountNumber:'300-000-000',modeOfPayment:'CASH',settlementCurrency:'USD',amount:'1,000,000.00',edit:'<a href=\"javascript:void(0)\">edit</a>',deleteMdCollection:'<a href=\"javascript:void(0)\">delete</a>'});

}

$(initMDCollectionGrid);

