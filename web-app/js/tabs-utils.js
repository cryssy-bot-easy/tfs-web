/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/17/12
 * Time: 7:39 PM
 * To change this template use File | Settings | File Templates.
 */

function initTabs() {
    var ctr = 0;

    $("#tabs li").each(function () {
        var formId = $(this).find("a").attr("id");
        console.log(formName + " : " + formId);
        if(formName == "cashLcPaymentTabForm") {
            if((formId + "Form") == "cashLcPaymentTabForm" || (formId + "Form") == "paymentDetailsTabForm") {
                $('#tab_container').tabs({ selected: ctr });

                $("#"+formId).click();
            }
        // Added else if for Tab Validation - Brian
        } else if (formName === "instructionsAndRoutingTabForm") {
        	if (formName.length > 12 && formId.length > 12 && formName.substring(0, 12) === formId.substring(0, 12)) {
        		$('#tab_container').tabs({ selected: ctr });
        		
        		$("#"+formId).click();
        	}
        } else {
            if(formName == (formId + "Form")) {
                $('#tab_container').tabs({ selected: ctr });

                $("#"+formId).click();
            }
        }

        ctr++;
    })
    
    //redirect to basic details tab every page reload
//    if($("#basicDetailsTab").length>0) $("#basicDetailsTab").click();
}

$(initTabs);
