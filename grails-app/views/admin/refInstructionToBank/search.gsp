<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>
    <script type="text/javascript">

    	var addOrEditUrl = '${g.createLink(controller:'refInstructionToBankAdmin', action: 'addOrEdit')}';
    	var deleteUrl = '${g.createLink(controller:'refInstructionToBankAdmin', action: 'delete')}';

    	$(document).ready(function() {
    		tableToGrid('#instructionToBankTable', {width : 780, height: 480, scrollOffset : 0,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
    	    jQuery("#instructionToBankTable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
    	    
	    	$("#btnAddNewDocument").click(function(){
	    		$("#instructionToBankCode").val("");
	    		$("#instruction").val("");
	    		$("#instructionToBankCode").removeAttr("readonly","readonly");
		    	
	    		loadPopup("popup_page", "popup_bg");
	            centerPopup("popup_page", "popup_bg");
	    	});

	    	$("#popup_closeAddNewDocument").click(function(){
	    		$("#instructionToBankCode").val("");
	    		$("#instruction").val("");
	    		disablePopup("popup_page", "popup_bg");
	    	});

	    	$("#popup_btnSaveNewDocument").click(function(){
	    		if ($("#instructionToBankCode").val().trim() != "" && $("#instruction").val().trim() != ""){
	    			saveInstruction();
			    } else{
					alert("Instruction to Bank Code and Instruction should not be blank.");
				}
	    	});

	    	$("#popup_closeAddNewDocument").click(function(){
	    		disablePopup("popup_page", "popup_bg");
	    	});

	        $("#btnAlertOk").click(function() {
	            mDisablePopup($("#popup_alert_dv"), $("#popup_alert_bg"));
	            location.reload();
	        });
    	});

    	function saveInstruction(){
    		var addData = {
    				id: $("#id").val(),
    				instructionToBankCode: $("#instructionToBankCode").val(),
    				instruction: $("#instruction").val()
    				}
    	    $.post(addOrEditUrl, addData, function (data) {
    			if (data.success){
    				loadPopup("popup_alert_dv", "popup_alert_bg");
    	            centerPopup("popup_alert_dv", "popup_alert_bg");
    	            $("#alertMessage").text("Record Saved.");
    			}else{
    				alert("Failed");
    			}
    	    });
    		disablePopup("popup_page", "popup_bg");
        }

    	function deleteInstruction(id){
    		var gridData = $("#instructionToBankTable").jqGrid("getRowData", id);
    		var addData = {
    				id: id
    				}
    	    $.post(deleteUrl, addData, function (data) {
    			if (data.success){
    				loadPopup("popup_alert_dv", "popup_alert_bg");
    	            centerPopup("popup_alert_dv", "popup_alert_bg");
    	            $("#alertMessage").text("Record Deleted.");
    			}else{
    				alert("Failed");
    			}
    	    });
    	}

    	function editInstruction(id){
    		var gridData = $("#instructionToBankTable").jqGrid("getRowData", id);
    		//alert(JSON.stringify(gridData));
    		$("#instructionToBankCode").val(gridData.Instruction_to_Bank_Code);
    		$("#instruction").val(gridData.Instruction);
    		$("#instructionToBankCode").attr("readonly","readonly");
    		loadPopup("popup_page", "popup_bg");
    	    centerPopup("popup_page", "popup_bg");
    	}
    	
    </script>

</head>
    <body style="visibility: hidden;">

        <div id="outer_wrap">

            <%-- HEADER --%>
            <g:render template="/layouts/header" model="${[title: "Instruction to Bank Parameter Maintenance"]}"/>

            <div id="navigation">
                <div id="Accordion1" class="Accordion">
                    <div class="AccordionPanel">
                        <div class="AccordionPanelTab panelHome" id="accordpanel_home">Instructions to Bank Maintenance Actions</div>
                        <div class="AccordionPanelContent">
                            <ul>
                                <li><a href="javascript:void(0)" id="btnAddNewDocument" />Add New Instruction</a></li>
                                <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="body_forms">
                <br/><br/><br/>
                <div class="grid_wrapper">
                    <table id=instructionToBankTable>
                        <thead>
                        <th>Instruction to Bank Code</th>
                        <th>Instruction</th>
                        <th>Edit</th>
                        <th>Delete</th>
                        </thead>
                        <tbody>
                        <g:each in="${instructionToBank}" var="itb">
                            <tr>
                            	<td>${itb.instructionToBankCode}</td>
                                <td>${itb.instruction}</td>
                                <td style="width: 40px; "><a href="javascript:void(0)" style="color: red;" onclick="editInstruction(${itb.i})">Edit</a></td>
                                <td style="width: 40px;"><a href="javascript:void(0)" style="color: red;" onclick="deleteInstruction(${itb.id?.toString().replace('.0','')})">Delete</a></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <div id="pager"></div>
                </div>
            </div>
        </div>
<g:render template="../admin/refInstructionToBank/new_required_document" />
<g:render template="../admin/common/alert" />
</body>
</html>