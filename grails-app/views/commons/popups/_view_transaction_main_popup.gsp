<div id="view_transaction_main_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="#" id="view_transaction_main_popup_close" class="popup_close">x</a>
		<h2 id="view_transaction_main_popup_header"></h2>
	</div>
	<div class="grid_wrapper_auto">
		<table id="grid_list_create_transaction_main"></table>
		<div id="grid_pager_create_transaction_main"></div>
	</div>
	<br/>
	<table class="full_width">
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="cancelView" value="Cancel" class="input_button_negative" /></td>
		</tr>
	</table>
	<%--Hidden field shared by 2 grids--%>
	<g:hiddenField name="hiddenViewTransaction"/>
</div>
<div id="view_transaction_main_popup_bg" class="popup_bg_override"> </div>

<script type="text/javascript">
	$(document).ready(function(){
	



		$('#redirectTo').click(function(){
			switch($(":checked","#create_transaction_popup").val().toString()){
			case "fxlcCash":
				window.location.href="${createLink(controller:'fxlcEtsOpeningCash',action:'viewCashOpening')}";
				break;
			case "fxlcRegular":
				window.location.href="${createLink(controller:'fxlcEtsOpeningRegular',action:'viewRegularOpening')}";
				break;
			case "fxlcStandby":
				window.location.href="${createLink(controller:'fxlcEtsOpeningStandby',action:'viewStandByOpening')}";
				break;
			case "dmlcCash":
				window.location.href="${createLink(controller:'dmlcEtsOpeningCash',action:'viewCashOpening')}";
				break;
			case "dmlcRegular":
				window.location.href="${createLink(controller:'dmlcEtsOpeningRegular',action:'viewDmlcEtsOpeningRegular')}";
				break;
			case "dmlcStandby":
				window.location.href="${createLink(controller:'dmlcEtsOpeningStandby',action:'viewDmlcEtsOpeningStandby')}";
				break;
			}
		});
	});
</script>