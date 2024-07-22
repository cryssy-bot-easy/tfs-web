<g:javascript src="grids/cif_search_normal_jqgrid.js" />
<script type="text/javascript">
    var cifNormalSearchUrl = '${g.createLink(controller: "cif", action: "searchCif")}';
</script>
<div id="popup_cif_normal" class="popup_div_override">
    <div class="popup_header">
        <a href="javascript:void(0)" id="popupClose_cif_normal" class="popup_close">x</a>
        <h2 id="popup_cif_normal_title" class="popup_title"> Select CIF </h2>
    </div>
    <div id="cif_tab">
        <table class="popup_table">
            <tr>
                <td class="long_width"> <span class="field_label"> CIF Number </span> </td>
                <td> <g:textField class="input_field" name="cIFNumberSearchNormal" disabled="disabled"/> </td>
                <td class="long_width"> <span class="field_label"> CIF Name </span> </td>
                <td> <g:textField class="input_field" name="cIFNameSearchNormal" disabled="disabled"/> </td>
            </tr>
            <tr>
                <td colspan="4">
                    <input type="button" class="input_button" value="Search" id="cifNormalSearchBtn"/>
                </td>
            </tr>
        </table>
        <div class="grid_wrapper_popup fix">
            <table id="grid_list_cif_popup"> </table>
            <div id="grid_pager_cif_popup"> </div>
        </div>
        <div class="popup_buttons">
            <input type="button" class="input_button" value="Select" id="cifSearchNormalSelect" />
        </div>

    </div>
</div>
<div id="popupBackground_cif_normal" class="popup_bg_override"> </div>