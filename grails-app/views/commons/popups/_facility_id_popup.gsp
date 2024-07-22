<g:javascript src="grids/facility_search_grid.js" />

<script type="text/javascript">
    var facilitySearchUrl = '${g.createLink(controller: "facility", action: "getEarmarkingFacilities")}';
    var facilitySearchForUaUrl = '${g.createLink(controller: "facility", action: "getEarmarkingFacilitiesForUaSearch")}';

    var ibLineFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getIBFacilities")}';
    var uaLineFacilitySearchUrl = '${g.createLink(controller: "facility", action: "getUAFacilities")}';
    var trLineFacilitySearchUrl = '${g.createLink(controller: "facility", action: "getTrFacilities")}';
    var getFacilityBalance =  '${g.createLink(controller: "facility", action: "getFacilityBalance")}';
    var dbpLoanFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getDbpFacilities")}';
    var ebpLoanFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getEbpFacilities")}';

    var getCurrentSystemDateUrl = '${g.createLink(controller:'facility', action:'getCurrentDate')}';

</script>

<div id="facility_popup" class="popup_div_override">
    <div class="popup_header">
    	<a href="javascript:void(0)" class="facility_search_close popup_close">x</a>
    	<h2 class="popup_title"> Facility Search </h2>
    </div>
    <table class="popup_table">
        <tr>
            <td width="70"> <span class="field_label"> Facility ID </span> </td>
            <td> <g:textField class="input_field" name="facilityIdParam"  disabled="disabled"/> </td>
        </tr>
        <tr> <%-- BUTTON --%>
            <td colspan="2">
                <ul class="body_forms_table_btn">
                    <li><input type="button" class="input_button" value="Search" id="searchFacility" /></li>
                    <li><input type="button" class="input_button_negative" value="Reset" id="resetFacility" /></li>
                </ul>
            </td>
        </tr>
    </table>
			<div class="grid_wrapper_auto fix">
			  <table id="grid_list_facility_type"> </table>
			  <div id="grid_pager_facility_type"> </div>
			</div>
			<br />
			<table class="popup_buttons">
<%--				<tr>--%>
						<%--<input type="button" class="input_button button_override confirm_facility_id" value="Save" />--%>
<%--                    <td>--%>
<%--                        <input type="text" value="" disabled="disabled" id="facilityBalance" class="input_field">--%>
<%--                    </td>--%>
<%--                    <td>--%>
<%--                        <input type="button" class="input_button2" value="Check Balance" id="checkBalance"/>--%>
<%--                    </td>--%>
<%--				</tr>--%>
                <tr>
                    <td colspan="2">
                        <input type="button" class="input_button" value="Select" id="selectFacility"/>
                    </td>
                </tr>
				<tr>
					<td colspan="2">
                        <input type="button" class="input_button_negative button_override facility_search_close" value="Cancel" />
                    </td>
				</tr>
			</table> 

</div>
<div id="facility_search_bg" class="popup_bg_override"> </div>
<script>
    var searchfacilityURL = '${g.createLink(controller: "facility", action: "getEarmarkingFacilitiesSearch")}';
    var uaFacilitySearchUrl = '${g.createLink(controller: "facility", action: "getEarmarkingFacilitiesForUaSearch")}';

    $(document).ready(function() {
        $("#searchFacility").click(function() {
            if (referenceType == "PAYMENT" || (referenceType == "DATA_ENTRY" && documentClass == 'BP')) {
                searchLoanFacilities();
            } else {
                var id = $("#grid_list_cif").jqGrid("getGridParam", "selrow");
                var cifNumberParam = $("#grid_list_cif").jqGrid("getRowData", id).cifNumber;
                var mainid = $("#grid_list_main_cif").jqGrid("getGridParam", "selrow");
                var mainCifNumberParam = $("#grid_list_main_cif").jqGrid("getRowData", id).mainCifNumber;

                if (cifNumberParam == undefined) {
                    cifNumberParam = $("#cifNumber").val();
                }

                if (mainCifNumberParam == undefined) {
                	mainCifNumberParam = $("#mainCifNumber").val();
                }

                var facilitySearchingUrl

                var serviceType = $("#serviceType").val();

                if (serviceType.toUpperCase() == "UA LOAN SETTLEMENT" || serviceType.toUpperCase() == 'UA_LOAN_SETTLEMENT') {
                    facilitySearchingUrl = uaFacilitySearchUrl + "?cifNumber=" + cifNumberParam + "&mainCifNumber=" + mainCifNumberParam + "&seqNo=" + $("#facilityIdParam").val() + "&currency=" + $("#currency").val();
                } else {
                    facilitySearchingUrl = searchfacilityURL + "?cifNumber=" + cifNumberParam + "&mainCifNumber=" + mainCifNumberParam + "&seqNo=" + $("#facilityIdParam").val();
                }

                $('#grid_list_facility_type').jqGrid('setGridParam', {url: facilitySearchingUrl, page: 1, datatype: "json"}).trigger("reloadGrid");
            }
        });

        $("#resetFacility").click(function() {
            $("#facilityIdParam").val("");

            var id = $("#grid_list_cif").jqGrid("getGridParam", "selrow");
            var cifNumberParam = $("#grid_list_cif").jqGrid("getRowData", id).cifNumber;

            var facilitySearchingUrl = searchfacilityURL + "?cifNumber=" + cifNumberParam + "&seqNo=";
            $('#grid_list_facility_type').jqGrid('setGridParam', {url: facilitySearchingUrl, page: 1, datatype: "json"}).trigger("reloadGrid");
        });
    });
</script>