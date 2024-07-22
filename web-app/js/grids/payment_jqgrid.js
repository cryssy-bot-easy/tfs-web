$(document).ready(function (){
	
	var paymentGrid=$("#grid_list_payment_edit_delete");
	
	//payment summary with without delete column
	var paymentGridEdit=$(".grid_list_payment_edit");
	
	//payment summary for refund
	var paymentGridRefund=$("#grid_list_payment_refund");
	
	//payment summary for tsd initiated
	var paymentGridTsd=$("#grid_list_payment_tsd");

	//payment summary for tsd initiated
	var paymentGridCdt=$("#grid_list_payment_cdt");

	
	//EC popups
	var ec_login_popup=$("#ec_login_popup").attr("id");
	var ec_login_bg=$("#ec_login_bg").attr("id");

	var ec_login_popup_reverse=$("#reverse_popup_confirmation").attr("id");
	var ec_login_bg_reverse=$("#reverse_confirmation_background").attr("id");
	
	var paymentGridUrl = '';
	var paymentGridUrlEdit = '';
	
	//payment summary with edit and delete column
	setupJqGridWidth('grid_list_payment_edit_delete', {height: "auto", width: 780, loadui: "disable", scrollOffset: 0},
					[['accountNumber', 'Account Number', 120, 'left'],
					['modeOfPaymentColCharges', 'Mode of Payment', 100, 'center'],
					['settlementCurrencyColCharges', 'Settlement Currency', 120, 'center'],
					['amountColCharges', 'Amount (in settlement currency', 220, 'right'],
					['editPaymentColCharges','Edit', 40, 'center'],
					['deletePaymentColCharges','Delete', 50, 'center'],
					['statusColCharges','Status', 60, 'center'],
					['buttonsColCharges','&nbsp;', 70, 'center']], paymentGridUrl);
	
	//payment summary without delete column
	setupJqGridWidthClass('grid_list_payment_edit', {height: "auto", width: 780, loadui: "disable", scrollOffset: 0},
			[['accountNumber', 'Account Number', 130, 'left'],
			['modeOfPaymentColCharges', 'Mode of Payment', 100, 'center'],
			['settlementCurrencyColCharges', 'Settlement Currency', 140, 'center'],
			['amountColCharges', 'Amount (in settlement currency)', 250, 'right'],
			['editPaymentColCharges','Edit', 40, 'center'],
			['statusColCharges','Status', 60, 'center'],
			['buttonsColCharges','&nbsp;', 70, 'center']], paymentGridUrl);

	//payment summary for refund
	setupJqGridWidth('grid_list_payment_refund', {height: "auto", width: 780, loadui: "disable", scrollOffset: 0},
			[['accountNumber', 'Account Number', 130, 'left'],
			['modeOfPaymentColCharges', 'Mode of Payment', 100, 'center'],
			['refundColCharges', 'Refund Currency', 140, 'center'],
			['amountColCharges', 'Amount', 250, 'right'],
			['editPaymentColCharges','Edit', 40, 'center'],
			['statusColCharges','Status', 60, 'center'],
			['buttonsColCharges','&nbsp;', 70, 'center']], paymentGridUrl);
	
	//payment summary for tsd initiated
	setupJqGridWidth('grid_list_payment_tsd', {height: "auto", width: 780, loadui: "disable", scrollOffset: 0},
			[['accountNumber', 'Account Number', 130, 'left'],
			['chargesColCharges', 'Charges Type', 240, 'left'],
			['modeOfPaymentColCharges', 'Mode of Payment', 100, 'center'],
			['amountColCharges', 'Amount', 150, 'right'],
			['editPaymentColCharges','Edit', 40, 'center'],
			['statusColCharges','Status', 60, 'center'],
			['buttonsColCharges','&nbsp;', 70, 'center']], paymentGridUrl);
	
	//payment summary for cdt 
	setupJqGridWidth('grid_list_payment_cdt', {height: "auto", width: 780, loadui: "disable", scrollOffset: 0},
			[['accountNumber', 'Account Number', 150, 'left'],
			['modeOfPaymentColCharges', 'Mode of Payment', 150, 'center'],
			['amountColCharges', 'Amount', 200, 'right'],
			/*['editPaymentColCharges','Edit', 40, 'center'],*/
			['deletePaymentColCharges','Delete', 50, 'center'],
			['statusColCharges','Status', 60, 'center'],
			['buttonsColCharges','&#160;', 70, 'center']], paymentGridUrl);
	
	
	
//	// ************** STATIC DATA FOR paymentGrid ******************
//
//	paymentGrid.addRowData("1",{accountNumber:'00-001-183625-3',
//			   modeOfPaymentColCharges:'CASH',
//			   settlementCurrencyColCharges:'USD',
//			   amountColCharges:'1,000,000.00',
//			   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//			   deletePaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: red\">delete</a>',
//			   statusColCharges:"<span class=\"notCasaStatus\">Not Paid</span>",
//			   buttonsColCharges:"<input type=\"button\" class=\"input_button notCasaButton\" value=\"Pay\"/>" });
//
//	paymentGrid.addRowData("2",{accountNumber:'00-001-183625-3',
//			   modeOfPaymentColCharges:'CASA',
//			   settlementCurrencyColCharges:'USD',
//			   amountColCharges:'1,000,000.00',
//			   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//			   deletePaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: red\">delete</a>',
//			   statusColCharges:"<span class=\"casaStatus\">Not Paid</span>",
//			   buttonsColCharges:"<input type=\"button\" class=\"input_button casaButton\" value=\"Pay\"/>" });
//
//	paymentGrid.addRowData("3",{accountNumber:'',
//			   modeOfPaymentColCharges:'',
//			   settlementCurrencyColCharges:'',
//			   amountColCharges:'',
//			   editPaymentColCharges:'',
//			   deletePaymentColCharges:'',
//			   statusColCharges:"",
//			   buttonsColCharges:"" });
//
//
//	// ************** STATIC DATA FOR paymentGridEdit ******************
//
//	paymentGridEdit.addRowData("1",{accountNumber:'00-001-183625-3',
//		   modeOfPaymentColCharges:'CASH',
//		   settlementCurrencyColCharges:'USD',
//		   amountColCharges:'1,000,000.00',
//		   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//		   statusColCharges:"<span class=\"notCasaStatus\">Not Paid</span>",
//		   buttonsColCharges:"<input type=\"button\" class=\"input_button notCasaButton\" value=\"Pay\"/>" });
//
//	paymentGridEdit.addRowData("2",{accountNumber:'00-001-183625-3',
//			   modeOfPaymentColCharges:'CASA',
//			   settlementCurrencyColCharges:'USD',
//			   amountColCharges:'1,000,000.00',
//			   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//			   statusColCharges:"<span class=\"casaStatus\">Not Paid</span>",
//			   buttonsColCharges:"<input type=\"button\" class=\"input_button casaButton\" value=\"Pay\" onClick=\"onViewPopupEcCharges()\"/>" });
//
//	paymentGridEdit.addRowData("3",{accountNumber:'',
//			   modeOfPaymentColCharges:'',
//			   settlementCurrencyColCharges:'',
//			   amountColCharges:'',
//			   editPaymentColCharges:'',
//			   statusColCharges:"",
//			   buttonsColCharges:"" });
//
//// ************** STATIC DATA FOR paymentGridRefund ******************
//
//	paymentGridRefund.addRowData("1",{accountNumber:'00-001-183625-3',
//		   modeOfPaymentColCharges:'CASH',
//		   refundColCharges:'USD',
//		   amountColCharges:'1,000,000.00',
//		   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//		   statusColCharges:"<span class=\"notCasaStatus\">Not Paid</span>",
//		   buttonsColCharges:"<input type=\"button\" class=\"input_button notCasaButton\" value=\"Pay\"/>" });
//
//	paymentGridRefund.addRowData("2",{accountNumber:'00-001-183625-3',
//			   modeOfPaymentColCharges:'CASA',
//			   refundColCharges:'USD',
//			   amountColCharges:'1,000,000.00',
//			   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//			   statusColCharges:"<span class=\"casaStatus\">Not Paid</span>",
//			   buttonsColCharges:"<input type=\"button\" class=\"input_button casaButton\" value=\"Pay\" onClick=\"onViewPopupEcCharges()\"/>" });
//
//	paymentGridRefund.addRowData("3",{accountNumber:'',
//			   modeOfPaymentColCharges:'',
//			   refundColCharges:'',
//			   amountColCharges:'',
//			   editPaymentColCharges:'',
//			   statusColCharges:"",
//			   buttonsColCharges:"" });
//
//// ************** STATIC DATA FOR paymentGridTsd ******************
//
//	paymentGridTsd.addRowData("1",{accountNumber:'00-001-183625-3',
//		   modeOfPaymentColCharges:'CASH',
//		   chargesColCharges:'Bank Commission',
//		   amountColCharges:'1,000,000.00',
//		   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//		   statusColCharges:"<span class=\"notCasaStatus\">Not Paid</span>",
//		   buttonsColCharges:"<input type=\"button\" class=\"input_button notCasaButton\" value=\"Pay\"/>" });
//
//	paymentGridTsd.addRowData("2",{accountNumber:'00-001-183625-3',
//			   modeOfPaymentColCharges:'CASA',
//			   chargesColCharges:'Marine/Fire Insurance',
//			   amountColCharges:'1,000,000.00',
//			   editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',
//			   statusColCharges:"<span class=\"casaStatus\">Not Paid</span>",
//			   buttonsColCharges:"<input type=\"button\" class=\"input_button casaButton\" value=\"Pay\" onClick=\"onViewPopupEcCharges()\"/>" });
//
//	paymentGridTsd.addRowData("3",{accountNumber:'',
//			   modeOfPaymentColCharges:'',
//			   chargesColCharges:'',
//			   amountColCharges:'',
//			   editPaymentColCharges:'',
//			   statusColCharges:"",
//			   buttonsColCharges:"" });
//
//// ************** STATIC DATA FOR paymentGridCDT ******************
//
//	paymentGridCdt.addRowData("1",{accountNumber:'00-001-183625-3',
//		   modeOfPaymentColCharges:'CASH',
//		   amountColCharges:'1,000,000.00',
//		   /*editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">delete</a>',*/
//		   deletePaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: red\">delete</a>',
//		   statusColCharges:"<span class=\"notCasaStatus\">Not Paid</span>",
//		   buttonsColCharges:"<input type=\"button\" class=\"input_button notCasaButton\" value=\"Pay\"/>" });
//
//	paymentGridCdt.addRowData("2",{accountNumber:'00-001-183625-3',
//			   modeOfPaymentColCharges:'CASA',
//			   amountColCharges:'1,000,000.00',
//			   /*editPaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: blue\">edit</a>',*/
//			   deletePaymentColCharges:'<a href=\"javascript:void(0)\"  style=\"color: red\">delete</a>',
//			   statusColCharges:"<span class=\"casaStatus\">Not Paid</span>",
//			   buttonsColCharges:"<input type=\"button\" class=\"input_button casaButton\" value=\"Pay\" />" });
//
//	paymentGridCdt.addRowData("3",{accountNumber:'',
//			   modeOfPaymentColCharges:'',
//			   amountColCharges:'',
//			   /*editPaymentColCharges:'',*/
//			   deletePaymentColCharges:'',
//			   statusColCharges:"",
//			   buttonsColCharges:"" });
	
	
//	**********************************************
//	*************EVENTS***************************
//	**********************************************
	$(".notCasaButton").live("click",function(){
		//for status
		if($('.notCasaButton').val()=="Pay"){
			$('.notCasaStatus').text('Paid');
			$('.notCasaButton').val('Reverse');
			$('.notCasaButton').attr("class","input_button_negative notCasaButton");
		}else{		
			onViewPopupReverseBtnCharges1();
		}
		
	});

	$(".casaButton").live("click",function(){
		if($('.casaButton').val()=="Pay"){
			$('.casaStatus').text('Paid');
			$('.casaButton').val('EC');
			$('.casaButton').attr("class","input_button_negative casaButton");
		}else{		
			onViewPopupEcCharges();
		}
		
	});

	//EC Login PopUp
	function onViewPopupEcCharges(){
		
		$(".popup_header_ec_login").text("LOG-IN TO YOUR ACCOUNT");
		centerPopup(ec_login_popup,ec_login_bg);
		loadPopup(ec_login_popup,ec_login_bg);
		
		$("#close_ec_login1").click(function(){
			disablePopup(ec_login_popup,ec_login_bg);
			
			//close popup but not login
			$('.casaStatus').text('Paid');
			$('.casaButton').val('EC');
			$("#ecLoginUsername").val("");
			$("#ecLoginPassword").val("");
		});
		
		$("#login_ec").click(function(){
			
				$('.casaStatus').text('Not Paid');
				$('.casaButton').val('Pay');
				$('.casaButton').attr("class","input_button casaButton");
				
				disablePopup(ec_login_popup,ec_login_bg);
				$("#ecLoginUsername").val("");
				$("#ecLoginPassword").val("");

		});
	}

	//confirmation popup

	function onViewPopupReverseBtnCharges1(){
		
		centerPopup(ec_login_popup_reverse,ec_login_bg_reverse);
		loadPopup(ec_login_popup_reverse, ec_login_bg_reverse);
		
		$(".popupClose_confirmation9").click(function(){
			disablePopup(ec_login_popup_reverse,ec_login_bg_reverse);
		});
		
		$(".popupClose_confirmation8").click(function(){
			disablePopup(ec_login_popup_reverse,ec_login_bg_reverse);
			
			$('.notCasaStatus').text('Not Paid');
			$('.notCasaButton').val('Pay');
			$('.notCasaButton').attr("class","input_button notCasaButton");
			$('.casaStatus').text('Not Paid');
			$('.casaButton').val('Pay');
		});
	}

});







