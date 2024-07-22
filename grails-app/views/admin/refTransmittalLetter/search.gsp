<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>
    <script type="text/javascript">

    	var addOrEditTransmittalLetterUrl = '${g.createLink(controller:'refTransmittalLetterAdmin', action: 'addOrEditTransmittalLetter')}';
    	var deleteTransmittalLetterUrl = '${g.createLink(controller:'refTransmittalLetterAdmin', action: 'deleteTransmittalLetter')}';

    	$(document).ready(function() {
    		tableToGrid('#transmittalLetterTable', {width : 780, height: 480, scrollOffset : 0,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
    	    jQuery("#transmittalLetterTable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
    	    
	    	$("#btnAddNewDocument").click(function(){
	    		$("#transmittalLetterCode").val("");
	    		$("#letterDescription").val("");
	    		$("#transmittalLetterCode").removeAttr("readonly","readonly");
		    	
	    		loadPopup("popup_page", "popup_bg");
	            centerPopup("popup_page", "popup_bg");
	    	});

	    	$("#popup_closeAddNewDocument").click(function(){
	    		$("#transmittalLetterCode").val("");
	    		$("#letterDescription").val("");
	    		disablePopup("popup_page", "popup_bg");
	    	});

	    	$("#popup_btnSaveNewDocument").click(function(){
				if ($("#transmittalLetterCode").val().trim() != "" && $("#letterDescription").val().trim() != ""){
					saveLetter()
				}else{
					alert("Transmittal Letter Code or Letter Description cannot be blank.");
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

    	function saveLetter(){
    		var tlData = {
    				id: $("#id").val(),
    				transmittalLetterCode: $("#transmittalLetterCode").val(),
    				letterDescription: $("#letterDescription").val()
    				}
    	    $.post(addOrEditTransmittalLetterUrl, tlData, function (data) {
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
    	
    	function deleteLetter(id){
    		var gridData = $("#transmittalLetterTable").jqGrid("getRowData", id);
    		var rdData = {
    				id: id
    				}
    	    $.post(deleteTransmittalLetterUrl, rdData, function (data) {
    			if (data.success){
    				loadPopup("popup_alert_dv", "popup_alert_bg");
    	            centerPopup("popup_alert_dv", "popup_alert_bg");
    	            $("#alertMessage").text("Record Deleted.");
    			}else{
    				alert("Failed");
    			}
    	    });
    	}

    	function editLetter(id){
    		var gridData = $("#transmittalLetterTable").jqGrid("getRowData", id);
    		$("#transmittalLetterCode").val(gridData.Transmittal_Letter_Code);
    		$("#letterDescription").val(gridData.Letter_Description_Type);
    		$("#transmittalLetterCode").attr("readonly","readonly");
    		loadPopup("popup_page", "popup_bg");
    	    centerPopup("popup_page", "popup_bg");
    	}
    	
    </script>

</head>
    <body style="visibility: hidden;">

        <div id="outer_wrap">

            <%-- HEADER --%>
            <g:render template="/layouts/header" model="${[title: "Transmittal Letter Parameter Maintenance"]}"/>

            <div id="navigation">
                <div id="Accordion1" class="Accordion">
                    <div class="AccordionPanel">
                        <div class="AccordionPanelTab panelHome" id="accordpanel_home">Transmittal Letter Maintenance Actions</div>
                        <div class="AccordionPanelContent">
                            <ul>
                                <li><a href="javascript:void(0)" id="btnAddNewDocument" />Add New Transmittal Letter</a></li>
                                <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div id="body_forms">
                <br/><br/><br/>
                <div class="grid_wrapper">
                    <table id=transmittalLetterTable>
                        <thead>
                        <th>Transmittal Letter Code</th>
                        <th>Letter Description Type</th>
                        <th>Edit</th>
                        <th>Delete</th>
                        </thead>
                        <tbody>
                        <g:each in="${transmittalLetter}" var="tl">
                            <tr>
                            	<td>${tl.transmittalLetterCode}</td>
                                <td>${tl.letterDescription}</td>
                                <td style="width: 40px; "><a href="javascript:void(0)" style="color: red;" onclick="editLetter(${tl.i})">Edit</a></td>
                                <td style="width: 40px;"><a href="javascript:void(0)" style="color: red;" onclick="deleteLetter(${tl.id?.toString().replace('.0','')})">Delete</a></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <div id="pager"></div>
                </div>
            </div>
        </div>
<g:render template="../admin/refTransmittalLetter/new_required_document" />
<g:render template="../admin/common/alert" />
</body>
</html>