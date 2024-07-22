
/*
	 (revision)
	 SCR/ER Number: ER# 20170109-040
	 SCR/ER Description: Transaction allowed to be created even the facility is expired
	 [Revised by:] Jesse James Joson
	 [Date revised:] 1/17/2017
	 Program [Revision] Details: Check the expiry date of the facility before allowing to amend LC
	 Member Type: Javascript
	 Project: WEB
	 Project Name: create_ets_utility.js.groovy
*/

function onEtsRedirectToClick() {
    var ets = $("input:[name=createEts]:checked").val();

    $.post(multipleServiceInstructionUrl, {tradeProductNumber: $("#dnBranch").val(), serviceType: ets, docType: $("#dsType1").val()}, function (data) {

        if (data.success == "true") {
            evaluateAction(ets);
        } else {
        	triggerAlertMessage(data.message);
        }
    });
}

function evaluateAction(action) {
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

function validateTrLine() {
    var result = 'success';



    return result;
}

function initializeCreateEts() {
    $("#etsRedirectTo").click(onEtsRedirectToClick);
}

$(initializeCreateEts);
