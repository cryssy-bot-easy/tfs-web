	<div id="popup_reroute" class="popup_div_override">
        <div class="popup_header">
    	  <a href="#" id="popupClose_reroute" class="popup_close">x</a>
    	  <h2 id="popup_reroute_title" class="popup_title"> </h2>
        </div>
	  <g:hiddenField name="etsNumberToReroute" value="" />
	  <table class="popup_table"> 
		<tr> 
		  <td width="90"> <span class="field_label"> Routed To </span> </td>
		  <td> <g:textField class="input_field" name="routedTo" readonly="readonly"/> </td>
		</tr>
		<tr>
		  <td> <span class="field_label"> Re-Route To </span> </td>
		  <td> <g:select class="select_dropdown" name="reRouteTo" from="${['']}" /> </td>
		</tr>
	  </table>
	  
	  <ul class="popup_buttons_center">
		 <li> <input type="button" id="routeEtsBtn" class="input_button" value="Route" /> </li>
		 <li> <input type="button" id="cancelRouteEtsBtn" class="input_button_negative" value="Cancel" /> </li>
	  </ul>
	  		
	</div>
    <div id="popupBackground_reroute" class="popup_bg_override"> </div> <%-- CIF SEARCH POPUP END --%>

<script>
    var getEtsDetailsUrl = '${g.createLink(controller: "inquiry", action: "getEtsDetails")}';
    var rerouteEtsUrl = '${g.createLink(controller: "inquiry", action: "rerouteServiceInstruction")}';

    function rerouteServiceInstruction(id) {
        var grid;
        if ($("#grid_list_ets_inquiry_branch").length > 0) {
            grid = $("#grid_list_ets_inquiry_branch")
        } else if ($("#grid_list_ets_inquiry_main").length > 0) {
            grid = $("#grid_list_ets_inquiry_main")
        }

        var lastUser = grid.jqGrid("getRowData", id).lastUser;
        var currentOwner = grid.jqGrid("getRowData", id).currentOwner;

        $.post(getEtsDetailsUrl, {etsNumber: id, lastUser: lastUser, currentOwner: currentOwner}, function(data) {
            $("#etsNumberToReroute").val(id);

            $('#popup_reroute_title').text("Re-route");

            $("#reRouteTo").empty();
//            $("#reRouteTo").append($('<option></option>').val("").html("SELECT ONE..."));

            $.each(data.nextBranchApprovers, function(key, branchApprover) {
                var option = "<option value="+branchApprover.id+">"+branchApprover.ename+"</option>";

                $("#reRouteTo").append(option)
            });

            centerPopup("popup_reroute", "popupBackground_reroute");
            loadPopup("popup_reroute", "popupBackground_reroute");

            $("#routedTo").val(data.routedTo);
        });
    }

    $(document).ready(function() {
        $("#routeEtsBtn").click(function() { // confirm routing
            var gotoUrl = rerouteEtsUrl;
            gotoUrl += "?etsNumber=" + $("#etsNumberToReroute").val();
            gotoUrl += "&rerouteTo=" + $("#reRouteTo").val();
            gotoUrl += "&routedTo=" + $("#routedTo").val();

            location.href = gotoUrl;

        });

        $("#cancelRouteEtsBtn, #popupClose_reroute").click(function() {
            $("#etsNumberToReroute").val("");

            disablePopup("popup_reroute", "popupBackground_reroute");
        });
    });
</script>