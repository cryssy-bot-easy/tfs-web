$(document).ready(function(){
	
	//import advance payment ets
	_changeCurrency($(".iaAmount"),"iaAmountCurrency");
	_changeCurrency($(".iaCharges"),"iaChargesCurrency");
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function _changeCurrency(_select_dropdown,_currency_class){
		_select_dropdown.change(function(){
				$("."+_currency_class).val($(this).val());
		});	
	
	}
});