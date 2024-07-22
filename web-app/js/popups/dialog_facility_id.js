var popup_facilitySearch_div = $('#facility_popup').attr("id");
var popup_facilitySearch_bg = $('#facility_search_bg').attr("id");


function openPopUpfacilitySearch(){
	loadPopup("facility_popup", "facility_search_bg");
	centerPopup("facility_popup", "facility_search_bg");
}

function closePopUpfacilitySearch(){
    mDisablePopup($("#facility_popup"),$("#facility_search_bg"))
}


$(document).ready(function(){

	$('#facility_lookup').click(openPopUpfacilitySearch);
	$('.facility_search_close').click(closePopUpfacilitySearch);
	
});

