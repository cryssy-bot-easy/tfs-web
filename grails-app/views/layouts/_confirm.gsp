<%-- CONFIRMATION POPUP --%>
<div class="popup_div_alert" id="popup_confirm_div">
    <div class="popup_header"/>
    	<h2 class="popup_title"> Alert! </h2>
    </div>
    <span id="confirmMessage"> </span>
    <ul class="popup_buttons_alert">
      	<li> 
      		<input type="button" class="input_button_alert" value="Yes" id="confirmYes"/>
      		<input type="button" class="input_button_negative_alert" value="No" id="confirmNo"/>
      	</li>
    </ul>
</div>
<div class="popup_bg_alert" id="popup_confirm_bg"></div>
<%-- CONFIRMATION POPUP END --%>

<script>
    function evaluateAction2(action) {

        var gotoUrl = viewApprovedLcUrl;

        gotoUrl += "?documentNumber="+$("#dnBranch").val();

        if(action == "negotiation") {
            gotoUrl += "&documentClass="+"LC";
            gotoUrl += "&serviceType="+"Negotiation";
        } else if(action == "adjustment") {
            gotoUrl += "&documentClass="+"LC";
            gotoUrl += "&serviceType="+"Adjustment";
        } else if(action == "amendment") {
            gotoUrl += "&documentClass="+"LC";
            gotoUrl += "&serviceType="+"Amendment";
        } else if(action == "cancellation") {
            gotoUrl += "&documentClass="+"LC";
            gotoUrl += "&serviceType="+"Cancellation";
        } else if(action == "indemnityIssuance") {
            gotoUrl += "&documentClass="+"INDEMNITY";
            gotoUrl += "&serviceType="+"Issuance";

            if ($("#dsType1").val() == "REGULAR") {
                $.get(searchTrLineUrl, {cifNumber: $("#cNumber").val(), mainCifNumber: $("#mcNumber").val()}, function(data) {
                    if (data.trLines.length < 1) {
                    	var r=confirm("CIF has no existing/active TR Line. Do you still want to proceed?");
                    	if (r==true) {
                    		 gotoUrl += "&reinstateFlag="+$("#reinstateFlag").val();
                             location.href = gotoUrl;
                    	} else {
                    	}
                    } else {
                        gotoUrl += "&reinstateFlag="+$("#reinstateFlag").val();
                        location.href = gotoUrl;
                    }
                });

                return true;
            }
        }

        gotoUrl += "&reinstateFlag="+$("#reinstateFlag").val();
        location.href = gotoUrl;
    }

    $(document).ready(function () {
        $("#confirmYes").click(function () {
            mDisablePopup($("#popup_confirm_div"), $("#popup_confirm_bg"));
        });

        $("#confirmNo").click(function () {
            var ets = $("input:[name=createEts]:checked").val();

            evaluateAction2(ets);
        });
    });
</script>