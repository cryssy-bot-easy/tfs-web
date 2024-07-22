/** Created by: Rafael Ski Poblete 
 * Date : 8/28/18
 * Description : Changed descriptionOfGoodsServicesPopupField and descriptionOfGoodsServicesPopupField to accept Z character set.
*/

/**
	(revision)
	[Modified by:] Cedrick C. Nungay
	[Date deployed:] 08/16/2018
	[Description: ] Change input format of description of goods to Z.
 */

function onSaveDescriptionOfGoodsClick() {
    var descriptionOfGoodsServices = $("#descriptionOfGoodsServicesPopupField").val();
    disablePopup("popup_descriptionOfGoods", "description_of_goods_bg");
    
    if(serviceType == "Opening") {
    	$("#descriptionOfGoodsServices").val(descriptionOfGoodsServices);
    }
    else {
    	$("#generalDescriptionOfGoodsTo").val(descriptionOfGoodsServices);
    }
}

$(document).ready(function(){
	
	var wrapper_div = "popup_descriptionOfGoods";
	var div_bg = "description_of_goods_bg";
	
	
	$("#popup_btn_description_of_goods").click(function(){
		$("#popup_header_descriptionOfGoods").text("Description of Goods and/or Service");
		if(serviceType == "Opening") {
			$("#descriptionOfGoodsServicesPopupField").val($("#generalDescriptionOfGoods").val());
		}
		else {
			$("#descriptionOfGoodsServicesPopupField").val($("#generalDescriptionOfGoodsTo").val());
		}
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		
		$("#descriptionOfGoodsServicesPopupField").limitCharAndLines(65,790,'Z');
	});
	$("#close_descriptionOfGoods1, #close_descriptionOfGoods2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	$(".confirm_descriptionOfGoods").click(function(){
		disablePopup(wrapper_div,div_bg);
	});

	
	$(".saveDescriptionOfGoods").click(onSaveDescriptionOfGoodsClick);

	$("#descriptionOfGoodsServicesPopupField").limitCharAndLines(65,790,'Z');
});