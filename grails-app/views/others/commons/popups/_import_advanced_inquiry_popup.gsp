<script type="text/javascript">

	//ets - import advance
	var etsImportAdvanceUrl = '${g.createLink(controller:'etsImportAdvance', action:'viewImportAdvance')}';

</script>


<div id="popup_createImportAdvancedEts" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_createImportAdvancedEts1" class="popup_close">x</a>
		<h2 id="popup_title" class="popup_title"> Create Import Advance e-TS </h2>
	</div>
	<div class="popup_divider">
		<br /><br />
		<g:radioGroup name="importAdvanceCreateEtsFlag" labels="['New Import Advance Payment','Refund (w/o existing Import Advance Payment)']" values="['P','R']">
		       <label>${it.radio}<g:message code="${it.label}" /><br/></label>
		    </g:radioGroup>
		<br /><br />
		
		<table class="buttons">
			<tr>
				<td><g:submitToRemote class="input_button" id="selectEts" value="Select" /></td>
			</tr>
			<tr>
				<td><g:submitToRemote id="close_createImportAdvancedEts2" class="input_button_negative" value="Cancel" /></td>
			</tr>
		</table>
	</div>
</div>
<div id="create_import_advanced_ets_bg" class="popup_bg_override"> </div>
