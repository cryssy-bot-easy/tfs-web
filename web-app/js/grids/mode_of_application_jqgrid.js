function setupModeOfApplicationJqgrid(){
	var setupModeOfApplicationUrl = '';
	
	setupJqGridPager('grid_list_mode_of_application', {width: 780, loadui: "disable", scrollOffset:0},
					[['accountNumber', 'MODE OF APPLICATION'],
					['modeOfPayment', 'MODE OF REFUND'],
					['settlementC', 'AMOUNT(in MD Currency)'],
					['editMode', 'Edit'],
					['deleteMode','Delete']], setupModeOfApplicationUrl);
}

function initModeOfApplicationJqgrid(){
	setupModeOfApplicationJqgrid();
//	$("#grid_list_mode_of_application").addRowData("1",{modeOfApplication:"Refund MD",modeOfRefund:"CASA",mdCurrencyAmount:"10,000.00",editMode:"<a href='javascript:void(0)'>Edit</a>",deleteMode:"<a href='javascript:void(0)'>Delete</a>"})
}

$(initModeOfApplicationJqgrid);