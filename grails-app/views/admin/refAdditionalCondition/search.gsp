<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>
    <script type="text/javascript">

    	var addOrEditUrl = '${g.createLink(controller:'refAdditionalConditionAdmin', action: 'addOrEdit')}';
    	var deleteUrl = '${g.createLink(controller:'refAdditionalConditionAdmin', action: 'delete')}';

    	$(document).ready(function() {
    		tableToGrid('#additionalConditionTable', {width : 780, height: 480, scrollOffset : 0,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
    	    jQuery("#additionalConditionTable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
    	    
	    	$("#btnAddNewDocument").click(function(){
	    		$("#conditionType").val("DEFAULT");
	    		$("#conditionCode").val("");
	    		$("#condition").val("");
	    		$("#conditionCode").removeAttr("readonly","readonly");
		    	
	    		loadPopup("popup_page", "popup_bg");
	            centerPopup("popup_page", "popup_bg");
	    	});

	    	$("#popup_closeAddNewDocument").click(function(){
	    		$("#conditionCode").val("");
	    		$("#condition").val("");
	    		disablePopup("popup_page", "popup_bg");
	    	});

	    	$("#popup_btnSaveNewDocument").click(function(){
	    		if ($("#conditionType").val().trim() != "" && $("#conditionCode").val().trim() != "" && $("#condition").val().trim() != ""){
	    			saveCondition();
			    }else{
				    alert("Condition Code, Condition Type, and Condition cannot be blank.");
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

    	function saveCondition(){
    		var addData = {
    				id: $("#id").val(),
    				conditionType: $("#conditionType").val(),
    				conditionCode: $("#conditionCode").val(),
    				condition: $("#condition").val()
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

    	function deleteCondition(id){
    		var gridData = $("#additionalConditionTable").jqGrid("getRowData", id);
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

    	function editCondition(id){
    		var gridData = $("#additionalConditionTable").jqGrid("getRowData", id);
    		$("#conditionCode").val(gridData.Condition_Code);
    		$("#conditionType").val(gridData.Condition_Type);
    		$("#condition").val(gridData.Condition);
    		$("#conditionCode").attr("readonly","readonly");
    		loadPopup("popup_page", "popup_bg");
    	    centerPopup("popup_page", "popup_bg");
    	}
    	
    </script>
</head>
    <body style="visibility: hidden;">

        <div id="outer_wrap">

            <%-- HEADER --%>
            <g:render template="/layouts/header" model="${[title: "Additional Condition Parameter Maintenance"]}"/>

            <div id="navigation">
                <div id="Accordion1" class="Accordion">
                    <div class="AccordionPanel">
                        <div class="AccordionPanelTab panelHome" id="accordpanel_home">Additional Condition Maintenance Actions</div>
                        <div class="AccordionPanelContent">
                            <ul>
                                <li><a href="javascript:void(0)" id="btnAddNewDocument" />Add New Condition</a></li>
                                <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="body_forms">
                <br/><br/><br/>
                <div class="grid_wrapper">
                    <table id=additionalConditionTable>
                        <thead>
                        <th>Condition Code</th>
                        <th>Condition Type</th>
                        <th>Condition</th>
                        <th>Edit</th>
                        <th>Delete</th>
                        </thead>
                        <tbody>
                        <g:each in="${additionalCondition}" var="ac">
                            <tr>
                            	<td>${ac.conditionCode}</td>
                            	<td>${ac.conditionType}</td>
                                <td>${ac.condition}</td>
                                <td style="width: 40px; "><a href="javascript:void(0)" style="color: red;" onclick="editCondition(${ac.i})">Edit</a></td>
                                <td style="width: 40px;"><a href="javascript:void(0)" style="color: red;" onclick="deleteCondition(${ac.id?.toString()?.replace('.0','')})">Delete</a></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <div id="pager"></div>
                </div>
            </div>
        </div>
<g:render template="../admin/refAdditionalCondition/new_required_document" />
<g:render template="../admin/common/alert" />
</body>
</html>