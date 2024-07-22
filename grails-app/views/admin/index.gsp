<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>

	<script type="text/javascript">
		//Auto Complete
        var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
        var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
        var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
        var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';

		var changeCutOffUrl = '${g.createLink(controller: 'admin' , action: 'changeCutOff')}';
		
        $(document).ready(function(){
        	$("#cutOffDiv").hide();
			
        	$("#btnSaveCutOff").click(function(){
				if ($("#hour").val().trim() != "" && $("#minute").val().trim() != "" && $("#period").val() != ""){
					if (parseInt($("#hour").val().trim()) > 12 || parseInt($("#hour").val().trim()) == 0 || parseInt($("#hour").val().trim()) == "00"){
						alert("Hour should not be 0 or greater than 12");
						return;
					}

        			if (parseInt($("#minute").val().trim()) > 59 ){
						alert("Minute should not be greater than 59");
						return;
					}
			
					var addData = {
							hour: $("#hour").val().trim(),
							minute: $("#minute").val().trim(),
							period: $("#period").val()
							}
					
					$.post(changeCutOffUrl, addData, function(data){
						if (data.success){
							alert("Cut-off Time saved.");	
							location.reload();	
						}else{
							alert("Saving Failed");				
						}
					});
				}else{
					alert("Hour, minute, period should not be blank.");
				}
            });
        });

        function isNumberKey(evt)
        {
           var charCode = (evt.which) ? evt.which : event.keyCode
           if (charCode > 31 && (charCode < 48 || charCode > 57))
              return false;

           return true;
        }

        function showSetCutOff(){
        	$("#cutOffDiv").show();
        }
        
	</script>


  </head>
<body style="visibility: hidden;">

        <div id="outer_wrap">	
	  
            <%-- HEADER --%>
            <g:render template="/layouts/header"/>

            <div id="navigation">
                <div id="Accordion1" class="Accordion">
                    <div class="AccordionPanel">
                        <div class="AccordionPanelTab panelHome" id="accordpanel_home">Admin Home</div>
                        <div class="AccordionPanelContent">
                            <ul>
<%--                                <li><a href="<g:createLink controller="userAdmin"/>">User Maintenance</a></li>--%>
                                <li><a href="<g:createLink controller="refCustomerAdmin"/>">Customer Maintenance</a></li>
                                <li><a href="<g:createLink controller="refBankAdmin"/>">Bank Maintenance</a></li>
                                <li><a href="<g:createLink controller="refProductServiceAdmin"/>">Product Service Maintenance</a></li>
                                <li><a href="<g:createLink controller="refCountryAdmin"/>">Country Maintenance</a></li>

                                <li><a href="<g:createLink controller="designation"/>">Designation Maintenance</a></li>
                                <li><a href="<g:createLink controller="position"/>">Position Maintenance</a></li>

                                <li><a href="<g:createLink controller="uploadRma"/>">Upload RMA</a></li>
<%--                                <li><a href="<g:createLink controller="branchUnitAdmin"/>">Branch Unit File <br/>Parameter Maintenance</a></li>--%>
                                <li><a href="<g:createLink controller="refRequiredDocumentsAdmin" action="view"/>">Required Documents <br/>Parameter Maintenance</a></li>
                                <li><a href="<g:createLink controller="refTransmittalLetterAdmin" action="view"/>">Transmittal Letter <br/>Parameter Maintenance</a></li>
                                <li><a href="<g:createLink controller="refAdditionalConditionAdmin" action="view"/>">Additional Condition <br/>Parameter Maintenance</a></li>
                                <li><a href="<g:createLink controller="refInstructionToBankAdmin" action="view"/>">Instruction to Bank <br/>Parameter Maintenance</a></li>
                                <li><a href="<g:createLink controller="refFirmLibAdmin"/>">FirmLib Maintenance</a></li>
                                <li><a href="javascript:void(0)" onclick="showSetCutOff()">Set Cut-Off Time</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div id="body_forms">
                Welcome to the admin module
                <br/>
                <br/>
                <br/>
                <div id="cutOffDiv" style="">
                <table class="tabs_forms_table">
                	 <tr>
                	 	<td ><span class="field_label" id="stringCutOff"> CutOff Time</span></td>
                	 	<td>
                	 		<g:textField name="hour" class="input_field_short" value="${hour}" maxlength="2" onkeypress="return isNumberKey(event)" /> 
                	 		<g:textField name="minute" class="input_field_short" value="${minute}"  maxlength="2" onkeypress="return isNumberKey(event)" /> 
                	 		<g:select id="period" name="period" noSelection="['':' - ']" class="select_dropdown_short"  from="${['AM','PM']}" value="${period}" />
                	 	</td>
                	 	<td><input type="button" class="input_button" value="Save" id="btnSaveCutOff" /></td>
                	 </tr>
                </table>
                </div>
            </div>

        </div>
  </body>
</html>