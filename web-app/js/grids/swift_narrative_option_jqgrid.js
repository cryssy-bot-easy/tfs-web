function toggleSwiftOrNarrative() {
    var swiftNarrative = $("input[type=radio][name=swiftNarrativeRadio]:checked").val();

    if(swiftNarrative == "SWIFT") {
        $("#additionalNarrative").attr("disabled", "disabled");
        $("#narrativeCharges").attr("disabled", "disabled");
        $(".swiftGrid").unblock({fadeOut: 1});
        $("#additionalNarrative").val("ALL CHARGES OUTSIDE THE PHILIPPINES ARE FOR THE ACCOUNT OF THE BENEFICIARY INCLUDING REIMBURSING CHARGES.");
        $("#narrativeCharges").val("BENEFICIARY");
    } else if(swiftNarrative == "NARRATIVE") {
        $("#additionalNarrative").removeAttr("disabled");
        $("#narrativeCharges").removeAttr("disabled");
        $(".swiftGrid").block({message: null, fadeIn: 1});
    }
}

function setupSwiftCharge() {
    $(".defAmount").autoNumeric();

    $.post(savedSwiftChargesUrl, {}, function(data) {
        for(var i in data.code) {
            $("#grid_list_swift_option").jqGrid("setSelection", data.code[i]);
        }
    });
}

function changeNarrativeCharges(){
	if($(this).val() == "BENEFICIARY"){
		$("#additionalNarrative").val("ALL CHARGES OUTSIDE THE PHILIPPINES ARE FOR THE ACCOUNT OF THE BENEFICIARY INCLUDING REIMBURSING CHARGES.");
	}else{
		$("#additionalNarrative").val("ALL CHARGES OUTSIDE THE PHILIPPINES ARE FOR THE ACCOUNT OF THE APPLICANT INCLUDING REIMBURSING CHARGES.");
	}
}


$(document).ready(function(){
	var swiftUrl = swiftChargesUrl;

    setupJqGridPagerNotSortable('grid_list_swift_option', {multiselect: true, width: 500, height: "auto", loadui: "disable", loadComplete: setupSwiftCharge},
        [['code', 'Code', 100],
            ['swiftCurrency', 'Currency'],
            ['swiftAmount', 'Amount']], 'grid_pager_swift_option', swiftUrl);

	$("input[type=radio][name=swiftNarrativeRadio]").click(toggleSwiftOrNarrative);
	$("#narrativeCharges").change(changeNarrativeCharges);
	$("#narrativeCharges").attr("disabled", "disabled");
    toggleSwiftOrNarrative();
});