function setUpRebate(){
	setupJqGridWidthPagerHidden('grid_list_rebate_inquiry', {width: 780, loadui: "disable", scrollOffset:0},
			[['unitCode', 'Unit Code',],
          	 ['corresBank', 'Corres Bank'],
	 		 ['amount', 'Amount'],
	 		 ['particulars', 'Particulars'],
	 		 ['processDate', 'Process Date']], 'grid_pager_rebate_inquiry', rebate_inquiry_grid_url);

}



function initRebateInquiry(){
	setUpRebate();
}

$(initRebateInquiry);