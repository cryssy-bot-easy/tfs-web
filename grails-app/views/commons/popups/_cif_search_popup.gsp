	<g:javascript src="grids/cif_search_jqgrid.js" />
    <script type="text/javascript">
        var cifSearchUrl = '${g.createLink(controller: "cif", action: "searchCif")}';
        var mainCifByCifSearchUrl = '${g.createLink(controller: "cif", action: "searchMainCifByCif")}';
        var cifByMainCifSearchUrl = '${g.createLink(controller: "cif", action: "searchCifByMainCif")}';
        var facilitySearchUrl = '${g.createLink(controller: "facility", action: "getEarmarkingFacilities")}';
        var cifResetUrl = '${g.createLink(controller: "cif", action: "resetCif")}';

        var trLineFromCifChangeUrl = '${g.createLink(controller: "facility", action: "searchTrLines")}';
    </script>

	<div id="popup_cif" class="popup_div_override">
	    <div class="popup_header">
			<a href="javascript:void(0)" id="popupClose_cif" class="popup_close">x</a>
			<h2 id="popup_cif_title" class="popup_title"> CIF Search </h2>
		</div>
	  
	  <table class="popup_table"> 
		  <tr> 
			<td class="verry_long_width"> <span class="field_label"> CIF Number </span> </td>
			<td> <g:textField class="input_field" name="cIFNumberSearch"  disabled="disabled"/> </td>
			<td class="verry_long_width"> <span class="field_label"> CIF Name </span> </td>
			<td> <g:textField class="input_field" name="cIFNameSearch" disabled="disabled" /> </td>
		  </tr>
		  <tr> 
			<td class="verry_long_width"> <span class="field_label"> Main CIF </span> <br /><span class="field_label"> Number </span> </td>
			<td> <g:textField class="input_field" name="mainCIFNumberMainSearch"  disabled="disabled"/> </td>
			<td class="verry_long_width"> <span class="field_label"> Main CIF </span> <br /><span class="field_label"> Name </span> </td>
			<td> <g:textField class="input_field" name="mainCIFNameMainSearch"  disabled="disabled"/> </td>
		  </tr>
		  <tr> <%-- BUTTON --%>
			<td colspan="4">
              <ul class="body_forms_table_btn">
                  <li><input type="button" class="input_button" value="Search" id="cifSearchBtn" /></li>
                  <li><input type="button" class="input_button_negative" value="Reset" id="cifResetBtn" /></li>
              </ul>
			</td>
		  </tr>
	  </table>
			
	  <span class="p_header_indent">CIF Table</span>
	  
	  <div class="grid_wrapper_popup fix"> <%-- JQGRID --%>
		  <table id="grid_list_cif"> </table>
		  <div id="grid_pager_cif"> </div>
	  </div>		
	  <br /><br />
		  
	  <span class="p_header_indent">Main CIF Table</span>
	  <div class="grid_wrapper_popup fix"> <%-- JQGRID --%>
		  <table id="grid_list_main_cif"> </table>
		  <div id="grid_pager_main_cif"> </div>
	  </div>
			
	  <div class="popup_buttons">
	      <input type="button" class="input_button" value="Select" id="cifSearchSelect"/>
	  </div>
	  
	</div>
    <div id="popupBackground_cif" class="popup_bg_override"> </div> <%-- CIF SEARCH POPUP END --%>
  