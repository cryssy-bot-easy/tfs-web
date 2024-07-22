<%-- 
(revision)
SCR/ER Number: 
SCR/ER Description: Redmine Issue #4168 - EBP Negotiation e-ts, the field Main CIF Number should have a ellipsis.
[Revised by:] John Patrick C. Bautista
[Date deployed:] 06/16/2017
Program [Revision] Details: Added id for labels to be called in EBP Nego eTS, so that it can change its text.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _cif_search_main.gsp
--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _cif_search_main.gsp
--%>

<g:javascript src="grids/cif_search_main_jqgrid.js" />
<script type="text/javascript">
    var searchMainCifByCifUrl = '${g.createLink(controller: "cif", action: "searchMainCifByCif")}';
    var facilitySearchUrl = '${g.createLink(controller: "facility", action: "getEarmarkingFacilities")}';
</script>
	<div id="popup_cif_main" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="popupClose_cif_main" class="popup_close">x</a>
		<h2 id="popup_cif_title_main" class="popup_title">Select Main CIF</h2>
	</div>
	   
		    <table class="popup_table">
			  <tr> 
				<%-- Redmine 4168 - Added id for labels to be edited in EBP Nego eTS --%>
				<td class="verry_long_width"> <span class="field_label" id="mainCifNumberLabel"> Main CIF Number </span> </td>
				<td class="input_width"> <g:textField class="input_field" name="mainCIFNumberMainSearch" data-orig="${mainCIFNumberMainSearch}" /> </td>
				<td class="verry_long_width"> <span class="field_label" id="mainCifNameLabel"> Main CIF Name </span> </td>
				<td> <g:textField class="input_field" name="mainCIFNameMainSearch" data-orig="${mainCIFNameMainSearch}" /> </td>
			  </tr>
			  <tr> <%-- BUTTON --%>
				<td colspan="4">
				  <input type="button" class="input_button" id="mainCifSearchBtn" value="Search" />
				</td>
			  </tr>
			</table>
			
			<div class="grid_wrapper_popup"> <%-- JQGRID --%>
			  <table id="grid_list_main_cif_popup"> </table>
			  <div id="grid_pager_main_cif_popup"> </div>
			</div>
			
		   	<input type="button" class="input_button" id="mainCifSelectBtn" value="Select" />
		
	</div>
    <div id="popupBackground_cif_main" class="popup_bg_override"> </div> <%-- CIF SEARCH POPUP END --%>
  