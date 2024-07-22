function generateScheduleOfMarginalDeposit() {
	var tmpScheduleOfMarginalDepositUrl = scheduleOfMarginalDepositUrl;
	
	window.open(tmpScheduleOfMarginalDepositUrl);
}

$(document).ready(function() {
	$("#scheduleOfMarginalDepositSpad").click(generateScheduleOfMarginalDeposit);
});