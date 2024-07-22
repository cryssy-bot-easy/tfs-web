<g:javascript src="grids/monitoring_breakdown_jqgrid.js"/>

<div id="popup_monitoring" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_breakdown1" class="popup_close">x</a>
		<h2 id="popup_title" class="popup_title"> O/S Breakdown </h2>
	</div>
	<div class="popup_divider">
		<br />
		<div class="grid_wrapper_apply_ap">
			<g:if test="${title.contains('AP')}">
			<table id="grid_list_breakdown"></table>
			</g:if>
			<g:if test="${title.contains('AR')}">
			<table id="grid_list_breakdown_ar"></table>
			</g:if>
			<div id="grid_pager_breakdown"></div>
		</div>
	</div>
	<input type="button" class="input_button_negative" id="close_breakdown2" value="Close" />
</div>
<div id="popup_monitoring_bg" class="popup_bg_override"> </div>