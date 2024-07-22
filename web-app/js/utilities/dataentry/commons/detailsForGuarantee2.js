$(document).ready(function (){	
	showEditableFields();
	$("#formatType").change(showEditableFields);
});

function showEditableFields() {
	var f = $("#formatType").val();
	
	$(".showBiddingDate").hide();
	$(".showBidInvitationNumber").hide();
	$(".showBidInvitationDate").hide();
	$(".showContractLocation").hide();
	$(".showAttentionName").hide();
	$(".showAttentionNamePosition").hide();
	$(".showBank").hide();
	$(".showBankBranch").hide();
	$(".showBankAddress").hide();
	$(".showCity").hide();
	$(".showProprietor").hide();
	$(".showProprietorPosition").hide();
	$(".showAuthorizedSignatory1").hide();
	$(".showAuthorizedSignatoryPosition1").hide();
	$(".showAuthorizedSignatory2").hide();
	$(".showAuthorizedSignatoryPosition2").hide();
	
	if(f == 'BIDDING SECURITY B' || f == 'BIDDING SECURITY C' || f == 'BIDDING SECURITY D' || f == 'BIDDING SECURITY E' || f == 'BIDDING SECURITY F'
		|| f == 'BIDDING SECURITY G' || f == 'BIDDING SECURITY I' || f == 'BIDDING SECURITY J' || f == 'BIDDING SECURITY K' || f == 'BIDDING SECURITY M'
		|| f == 'ADVANCE PAYMENT 3' || f == 'PS 4' || f == 'PS 8' || f == 'PS 9' || f == 'RETENTION 2' || f == 'RETENTION 3' || f == 'RETENTION 6'
		|| f == 'RETENTION MONEY 3' || f == 'SURETY BOND' || f == 'WARRANTY SECURITY') {
		$(".showBiddingDate").show();
	}
	
	if(f == 'BIDDING SECURITY I') {
		$(".showBidInvitationNumber").show();
	}
	
	if(f == 'BIDDING SECURITY I') {
		$(".showBidInvitationDate").show();
	}
	
	if(f == 'BIDDING SECURITY F') {
		$(".showContractLocation").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY B' || f == 'BIDDING SECURITY H' || f == 'BIDDING SECURITY M' || f == 'ADVANCE PAYMENT'
		|| f == 'ADVANCE PAYMENT 2' || f == 'ADVANCE PAYMENT 3' || f == 'FAITHFUL PERFORMANCE ADVANCE PAYMENT' || f == 'FP 5' || f == 'FP 6' || f == 'FP 7'
		|| f == 'OTHERS' || f == 'OTHERS STANDBY 3' || f == 'PAYMENT GUARANTY 3' || f == 'PERFORMANCE BOND' || f == 'PS 4' || f == 'PS 6' || f == 'PS 8'
		|| f == 'PS 10' || f == 'RELEASE RETENTION' || f == 'SURETY BOND 2' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND 2') {
		$(".showAttentionName").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY B' || f == 'ADVANCE PAYMENT' || f == 'ADVANCE PAYMENT 2' || f == 'ADVANCE PAYMENT 3'
		|| f == 'FAITHFUL PERFORMANCE ADVANCE PAYMENT' || f == 'FP 5' || f == 'FP 6' || f == 'FP 7' || f == 'OTHERS' || f == 'PERFORMANCE BOND'
		|| f == 'PERFORMANCE SECURITY 1' || f == 'PERFORMANCE SECURITY 2' || f == 'PS 4' || f == 'PS 6' || f == 'PS 8' || f == 'PS 10'
		|| f == 'RELEASE RETENTION' || f == 'SURETY BOND 2' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND 2') {
		$(".showAttentionNamePosition").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY B' || f == 'BIDDING SECURITY C' || f == 'BIDDING SECURITY D' || f == 'BIDDING SECURITY E'
		|| f == 'BIDDING SECURITY F' || f == 'BIDDING SECURITY G' || f == 'BIDDING SECURITY H' || f == 'BIDDING SECURITY I' || f == 'BIDDING SECURITY J'
		|| f == 'BIDDING SECURITY K' || f == 'BIDDING SECURITY L' || f == 'BIDDING SECURITY M' || f == 'BIDDING SECURITY N' || f == 'ADVANCE PAYMENT'
		|| f == 'ADVANCE PAYMENT 2' || f == 'ADVANCE PAYMENT 3' || f == 'FP 4 STANDARD FORMAT' || f == 'OTHERS' || f == 'PAYMENT GUARANTY' || f == 'PAYMENT GUARANTY 3' || f == 'PAYMENT GUARANTY 4'
		|| f == 'PERFORMANCE BOND' || f == 'PERFORMANCE SECURITY 1' || f == 'PERFORMANCE SECURITY 2' || f == 'PS 2' || f == 'PS 4' || f == 'PS 6'
		|| f == 'RELEASE RETENTION' || f == 'RETENTION 2' || f == 'RETENTION 3' || f == 'SURETY BOND' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND 2'
		|| f == 'WARRANTY SECURITY') {
		$(".showBank").show();
	}
	
	if(f == 'BIDDING SECURITY D' || f == 'BIDDING SECURITY H' || f == 'BIDDING SECURITY J' || f == 'ADVANCE PAYMENT' || f == 'OTHERS' || f == 'PAYMENT GUARANTY 3'
		|| f == 'PERFORMANCE BOND' || f == 'PERFORMANCE SECURITY 2' || f == 'PS 4' || f == 'PS 6' || f == 'RELEASE RETENTION' || f == 'SURETY BOND' || f == 'SURETY BOND 3'
		|| f == 'WARRANTY BOND 2') {
		$(".showBankBranch").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY C' || f == 'BIDDING SECURITY D' || f == 'BIDDING SECURITY E' || f == 'BIDDING SECURITY F'
		|| f == 'BIDDING SECURITY G' || f == 'BIDDING SECURITY H' || f == 'BIDDING SECURITY H' || f == 'BIDDING SECURITY I' || f == 'BIDDING SECURITY J'
		|| f == 'BIDDING SECURITY K' || f == 'BIDDING SECURITY L' || f == 'BIDDING SECURITY M' || f == 'BIDDING SECURITY N' || f == 'ADVANCE PAYMENT 2'
		|| f == 'ADVANCE PAYMENT 3' || f == 'FP 4 STANDARD FORMAT' || f == 'OTHERS' || f == 'PAYMENT GUARANTY' || f == 'PAYMENT GUARANTY 4' || f == 'PERFORMANCE SECURITY 1'
		|| f == 'PERFORMANCE SECURITY 2' || f == 'PS 2' || f == 'PS 6' || f == 'RETENTION' || f == 'RETENTION 2' || f == 'RETENTION 3' || f == 'RETENTION 4'
		|| f == 'WARRANTY BOND 2' || f == 'WARRANTY SECURITY') {
		$(".showBankAddress").show();
	}
	
	if(f == 'ADVANCE PAYMENT 2' || f == 'FP 5' || f == 'PAYMENT GUARANTY 4' || f == 'PERFORMANCE BOND' || f == 'PERFORMANCE SECURITY 2' || f == 'SURETY BOND'
		 || f == 'SURETY BOND 2' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND 2') {
		$(".showCity").show();
	}
	
	if(f == 'PS 3' || f == 'PS 4' || f == 'PS 7' || f == 'SURETY BOND' || f == 'SURETY BOND 2' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND 2') {
		$(".showProprietor").show();
	}
	
	if(f == 'PS 4' || f == 'SURETY BOND' || f == 'SURETY BOND 2' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND 2') {
		$(".showProprietorPosition").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY B' || f == 'BIDDING SECURITY C' || f == 'BIDDING SECURITY D' || f == 'BIDDING SECURITY E'
		|| f == 'BIDDING SECURITY F' || f == 'BIDDING SECURITY G' || f == 'BIDDING SECURITY H' || f == 'BIDDING SECURITY J' || f == 'BIDDING SECURITY K'
		|| f == 'BIDDING SECURITY L' || f == 'BIDDING SECURITY M' || f == 'BIDDING SECURITY N' || f == 'ADVANCE PAYMENT' || f == 'ADVANCE PAYMENT 2'
		|| f == 'ADVANCE PAYMENT 3' || f == 'FAITHFUL PERFORMANCE 2' || f == 'FAITHFUL PERFORMANCE ADVANCE PAYMENT' || f == 'FP 3' || f == 'FP 4 STANDARD FORMAT'
		|| f == 'FP 5' || f == 'FP 6' || f == 'FP 7' || f == 'FP STANDARD FORMAT 2' || f == 'OTHERS 5' || f == 'OTHERS' || f == 'PAYMENT GUARANTY'
		|| f == 'PAYMENT GUARANTY 2' || f == 'PAYMENT GUARANTY 3' || f == 'PAYMENT GUARANTY 4' || f == 'PERFORMANCE BOND' || f == 'PERFORMANCE SECURITY 1'
		|| f == 'PERFORMANCE SECURITY 2' || f == 'PS 2' || f == 'PS 3' || f == 'PS 6' || f == 'PS 7' || f == 'PS 8' || f == 'PS 9' || f == 'PS 10'
		|| f == 'RELEASE RETENTION' || f == 'RETENTION' || f == 'RETENTION 2' || f == 'RETENTION 3' || f == 'RETENTION 4' || f == 'RETENTION 5'
		|| f == 'RETENTION 6' || f == 'RETENTION MONEY 3' || f == 'SURETY BOND' || f == 'SURETY BOND 2' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND'
		|| f == 'WARRANTY BOND 2' || f == 'WARRANTY SECURITY') {
		$(".showAuthorizedSignatory1").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY B' || f == 'BIDDING SECURITY C' || f == 'BIDDING SECURITY D' || f == 'BIDDING SECURITY E'
		|| f == 'BIDDING SECURITY F' || f == 'BIDDING SECURITY G' || f == 'BIDDING SECURITY H' || f == 'BIDDING SECURITY J' || f == 'BIDDING SECURITY K'
		|| f == 'BIDDING SECURITY L' || f == 'BIDDING SECURITY M' || f == 'BIDDING SECURITY N' || f == 'ADVANCE PAYMENT'  || f == 'ADVANCE PAYMENT 2'
		|| f == 'ADVANCE PAYMENT 3' || f == 'FAITHFUL PERFORMANCE 2' || f == 'FAITHFUL PERFORMANCE ADVANCE PAYMENT' || f == 'FP 3' || f == 'FP 4 STANDARD FORMAT'
		|| f == 'FP 5' || f == 'FP 6' || f == 'FP 7' || f == 'FP STANDARD FORMAT 2' || f == 'OTHERS 5' || f == 'PAYMENT GUARANTY' || f == 'PAYMENT GUARANTY 2'
		|| f == 'PAYMENT GUARANTY 3' || f == 'PAYMENT GUARANTY 4' || f == 'PERFORMANCE BOND' || f == 'PERFORMANCE SECURITY 1' || f == 'PERFORMANCE SECURITY 2'
		|| f == 'PS 2' || f == 'PS 3' || f == 'PS 7' || f == 'PS 8' || f == 'PS 9' || f == 'PS 10' || f == 'RELEASE RETENTION' || f == 'RETENTION'
		|| f == 'RETENTION 2' || f == 'RETENTION 3' || f == 'RETENTION 4' || f == 'RETENTION 5' || f == 'RETENTION 6' || f == 'RETENTION MONEY 3'
		|| f == 'SURETY BOND' || f == 'SURETY BOND 2' || f == 'SURETY BOND 3' || f == 'WARRANTY BOND' || f == 'WARRANTY BOND 2' || f == 'WARRANTY SECURITY') {
		$(".showAuthorizedSignatoryPosition1").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY E' || f == 'BIDDING SECURITY G' || f == 'BIDDING SECURITY J' || f == 'BIDDING SECURITY L'
		|| f == 'BIDDING SECURITY M' || f == 'BIDDING SECURITY N' || f == 'ADVANCE PAYMENT 3' || f == 'FAITHFUL PERFORMANCE 2' || f == 'FAITHFUL PERFORMANCE ADVANCE PAYMENT'
		|| f == 'FP 3' || f == 'FP 4 STANDARD FORMAT' || f == 'FP 6' || f == 'FP STANDARD FORMAT 2' || f == 'OTHERS 5' || f == 'PAYMENT GUARANTY'
		|| f == 'PAYMENT GUARANTY 2' || f == 'PAYMENT GUARANTY 4' || f == 'PS 3' || f == 'PS 8' || f == 'PS 9' || f == 'PS 10' || f == 'RETENTION'
		|| f == 'RETENTION 2' || f == 'RETENTION 3' || f == 'RETENTION 4' || f == 'RETENTION 5' || f == 'RETENTION 6' || f == 'RETENTION MONEY 3'
		|| f == 'WARRANTY BOND') {
		$(".showAuthorizedSignatory2").show();
	}
	
	if(f == 'BIDDING SECURITY A' || f == 'BIDDING SECURITY E' || f == 'BIDDING SECURITY G' || f == 'BIDDING SECURITY J' || f == 'BIDDING SECURITY L'
		|| f == 'BIDDING SECURITY M' || f == 'BIDDING SECURITY N' || f == 'ADVANCE PAYMENT 3' || f == 'FAITHFUL PERFORMANCE 2' || f == 'FAITHFUL PERFORMANCE ADVANCE PAYMENT'
		|| f == 'FP 3' || f == 'FP 4 STANDARD FORMAT' || f == 'FP 6' || f == 'FP STANDARD FORMAT 2' || f == 'OTHERS 5' || f == 'PAYMENT GUARANTY'
		|| f == 'PAYMENT GUARANTY 2' || f == 'PAYMENT GUARANTY 4' || f == 'PS 3' || f == 'PS 8' || f == 'PS 9' || f == 'PS 10' || f == 'RETENTION'
		|| f == 'RETENTION 2' || f == 'RETENTION 3' || f == 'RETENTION 4' || f == 'RETENTION 5' || f == 'RETENTION 6' || f == 'RETENTION MONEY 3'
		|| f == 'WARRANTY BOND') {
		$(".showAuthorizedSignatoryPosition2").show();
	}
	
}