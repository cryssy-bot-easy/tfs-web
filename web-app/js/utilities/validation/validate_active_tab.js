/**
 * (revision)
 *	SCR/ER Number: 
 *	SCR/ER Description: Tab Validation (Redmine# 4196)
 *	[Revised by:] Brian Harold A. Aquino
 *	[Date deployed:] 06/16/2017
 *	Member Type: JS
 *	Project: WEB
 *	Project Name: validate_active_tab.js
 */

/**
 * This javascript validates the tab if the fields is 
 * already saved before leaving the tab.
 * 
 * Note: all the default value that is not saved
 * in the database will also trigger the popup.
 * 
 * @author Brian Harold Aquino
 * @since 03/24/2017
 */
$(document).ready(function() {
	var div = $("#popup_tab_confirmation"),
		bg = $("#confirmation_background_tab"),
		formName;
	
	//This will disregard enter keys on text fields on exports.
	$("#tab_container input[type=text]").bind("keypress", function(e) {
		if(e.keyCode == 13) {
			console.log("Disregard enter key...");
			return false;
		}
	});
	
	// Setting up for active and previous tab.
	function getTabIndex (tabId) {
		var counter = 0, tab, tabCounter = 0;
		// Getting the index of tabId.
		$("#tabs li").each(function() {
			tab = $(this).attr("aria-controls");
			
			if (tab.toString() === tabId.substring(1, tabId.length)) {
				tabCounter = counter;
			} else {
				counter += 1;
			}
		});
		
		return tabCounter;
	}
	
	// Getting the id using the index of the tablist.
	function getTabId(index) {
		var counter = 0, prevTab;
		
		$("#tabs li").each(function() {
			if(counter.toString() === index.toString()) {
				prevTab = "#" + $(this).attr("aria-controls");
			}
			counter += 1;
		});
		
		return prevTab;
	}
	
	// Validation if the tab has unsaved data.
	function checkIfNotSaved (id) {
		var error = 0, prevTab = getTabId(id);
		
		$(prevTab + " :input").each(function() {
			var readonly = $(this).attr("readonly"), disabled = $(this).attr("disabled"),
				value = $(this).val(), orig = $(this).attr("data-orig");
			
			if ((($(this).hasClass("input_field") || $(this).hasClass("select_dropdown") || $(this).hasClass("datepicker_field") 
					|| $(this).hasClass("select2_dropdown") || $(this).hasClass("textarea") || $(this).hasClass("input_field_right")
					|| $(this).hasClass("textarea_long")) && !((disabled === "disabled" || readonly === "readonly") && !$(this).hasClass("required")) 
					&& $(this).attr("type") !== "hidden") || ($(this).attr("type") === "radio" 
					&& $(this).attr("checked") && ($(this).attr("checked").toString() === "checked" 
					|| $(this).attr("checked").toString() === "true")) || ($(this).hasClass("datepicker_field") 
					&& $(this).siblings().hasClass("ui-datepicker-trigger")) || $(this).hasClass("data-orig")) {
				
				if (!$(this).hasClass("not")) {
					value = ($(this).hasClass("input_field_right") && value) ? parseFloat(value.toString().replace(/,/g, "")) : value;
					orig = ($(this).hasClass("input_field_right") && orig) ? parseFloat(orig.toString().replace(/,/g, "")) : orig;
					
					// For getting the list of fields that is validated.
					console.info("NAME: " + ($(this).attr("name") || $(this).attr("id")));
//					console.log("not: " + !$(this).hasClass("not"));
					console.log("value: " + value);
					console.log("data-orig: " + orig);
					
					if (((value === undefined || orig === undefined || !value || !orig) && value !== orig) 
							|| (value && orig && value.toString().toUpperCase() !== orig.toString().toUpperCase())) {
						error += 1;
					} 
				}
			}
		});
		
		console.info("No. of error: " + error);
		return error
	}
	
	function getTabForm(name) {
		var counter = 0, prevTab;
		
		console.log("name labelledby: " + name.parent().attr("aria-labelledby"));
		$("#tab_container form").each(function() {
			console.log("labelledby: " + $(this).attr("aria-labelledby"));
			var label = $(this).attr("id");
			if(label.toString().includes(name.attr("id").toString())) {
				prevTab = $(this).children().children("#form").val();
			}
			counter += 1;
		});
		
		if (!prevTab) {
			console.info("second condition....");
			counter = 0;
			var nameHref = name.attr("href").substring(1, name.attr("href").length);
			$("#tab_container form").each(function() {
				var that = $(this).children().attr("id");
				if(that === nameHref.toString()) {
					console.log("name: " + nameHref);
					console.log("id: " + $(this).children().children("#form").val());
					prevTab = $(this).children().children("#form").val();
				} else if ($(this).attr("id").toString().includes(name.attr("id").toString())) {
					console.log("name: " + nameHref);
					console.log("id: " + $(this).children("input[id=form]").val());
					prevTab = $(this).children("input[id=form]").val();
				} else if ($(this).parent().attr("aria-labelledby") === name.parent().attr("aria-labelledby")) {
					console.log("name: " + nameHref);
					console.log("id: " + $(this).children("input[id=form]").val());
					prevTab = $(this).children("input[id=form]").val();
				}
				counter += 1;
			});
		}
		
		return prevTab;
	}
	
	$("#tabs").click(function() {
		// Setting the ID of previous and active tab.
		var activeTab = $(".ui-tabs-nav").children('.ui-tabs-active').children().attr("href"),
			prevTab = getTabIndex(activeTab);
		// Getting the ID of a tab.
		formName = $(".ui-tabs-nav").children('.ui-tabs-active').children();
		// Checking if the system is in ExportBills.
		if ($("#docuClass").val() === "BP" && $("#documentType").val() === "FOREIGN" && $("#prevTab").val().toString() !== getTabIndex(activeTab).toString()) {
			if (checkIfNotSaved($("#prevTab").val()) > 0) {
				// Shows the Confirmation Box.
				mCenterPopup(div, bg);
				mLoadPopup(div, bg);
			} else {
				$("#prevTab").val(prevTab);
			}
		}
	});
	
	// Event handler for clicking Yes in the Confirmation Box.
	$("#btnTabYes").click(function() {
		// For reloading the page and setting the current tab to active tab (before reloading).
		var activeTab = $(".ui-tabs-nav").children('.ui-tabs-active').children().attr("href"),
			prevTab = getTabIndex(activeTab),
			tradeServiceIdParam = $("#referenceType").val() === "ETS" ? $("#etsNumber").val() : tradeServiceId;
		formName = getTabForm(formName);
		
		console.info("formName: " + formName);
		
		location.href = '../exportBillsPurchase/viewNegotiationTab?tradeServiceId=' + tradeServiceIdParam + 
			'&formName=' + formName + '&toggle=' + $("#referenceType").val() + '&serviceType=' + $("#serviceType").val();
	});
	
	// Setting of initial value in prevTab.
	function initTab() {
		if ($("#docuClass").val() === "BP" && $("#documentType").val() === "FOREIGN") {
			var activeTab = $(".ui-tabs-nav").children('.ui-tabs-active').children().attr("href"),
				prevTab = getTabIndex(activeTab);
			
			console.info("active formName: " + $("#form").val());
			
//			console.log("serviceType: " + $("#serviceType").val());
//			console.log("documentType: " + $("#documentType").val());
//			console.log("documentClass: " + $("#documentClass").val());
//			console.log("referenceType: " + $("#referenceType").val());
			
			$("#prevTab").val(prevTab);
		}
	}
	
	// Event handler for clicking No in the Confirmation Box.
	$("#btnTabNo").click(function() {
		// Hides the Confirmation Box.
		mDisablePopup(div, bg);
		// Setting the active tab to previous tab.
		$("#tab_container").tabs({selected: $("#prevTab").val()});
	});
	
	// Setting timeout for 100ms delay before performing the function.
	setTimeout(function() {
		initTab();
	}, 0);
});
