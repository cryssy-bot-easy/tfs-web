<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <title> Trade Finance System </title>
    <script type="text/javascript">

    	var addOrEditRequiredDocumentUrl = '${g.createLink(controller:'refRequiredDocumentsAdmin', action: 'addOrEditDocument')}';
    	var deleteRequiredDocumentUrl = '${g.createLink(controller:'refRequiredDocumentsAdmin', action: 'deleteDocument')}';

    	$(document).ready(function() {
    	    tableToGrid('#requiredDocumentTable', {width : 780, height: 480, scrollOffset : 0,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
    	    jQuery("#requiredDocumentTable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");

    	    $("#resetButton").click(function(){
    	    	$("#unitCode, #unitName").val("");
    		});

    		$("#btnAddNewDocument").click(function(){
    			$("#id").val("");
    			$("#documentType").val("");
    			$("#documentCode").val("");
    			$("#description").val("");
    			$("#documentCode").removeAttr("readonly","readonly");
    			loadPopup("popup_page", "popup_bg");
    	        centerPopup("popup_page", "popup_bg");
    		});
    		
    		$("#popup_closeAddNewDocument").click(function(){
    			$("#documentType").val("");
    			$("#documentCode").val("");
    			$("#description").val("");
    			disablePopup("popup_page", "popup_bg");
    		});

    		$("#popup_btnSaveNewDocument").click(function(){
				if ($("#documentType").val().trim() != "" && $("#documentCode").val().trim() != "" && $("#description").val().trim() != ""){
					saveDocument()
				}else{
					alert("Document Type, Document Code or Document Description cannot be blank");
				}
    		});
    		
    	    $("#btnAlertOk").click(function() {
    	        mDisablePopup($("#popup_alert_dv"), $("#popup_alert_bg"));
    	        location.reload();
    	    });

    	});

    	function saveDocument(){
			var rdData = {
				id: $("#id").val(),
				documentType: $("#documentType").val(),
				documentCode: $("#documentCode").val(),
				description: $("#description").val()
				}
		    $.post(addOrEditRequiredDocumentUrl, rdData, function (data) {
		    	jQuery("#requiredDocumentTable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");
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

    	function editDocument(id){
    		var gridData = $("#requiredDocumentTable").jqGrid("getRowData", id);
    		$("#documentType").val(gridData.Document_Type);
    		$("#documentCode").val(gridData.Document_Code);
    		$("#description").val(gridData.Description);
    		$("#documentCode").attr("readonly","readonly");
    		loadPopup("popup_page", "popup_bg");
    	    centerPopup("popup_page", "popup_bg");
    	}

    	function deleteDocument(id){
    		var gridData = $("#requiredDocumentTable").jqGrid("getRowData", id);
    		var rdData = {
    				id: id
    				}
    	    $.post(deleteRequiredDocumentUrl, rdData, function (data) {
    			if (data.success){
    				loadPopup("popup_alert_dv", "popup_alert_bg");
    	            centerPopup("popup_alert_dv", "popup_alert_bg");
    	            $("#alertMessage").text("Record Deleted.");
    			}else{
    				alert("Failed");
    			}
    	    });
    	}
		
    </script>
</head>
    <body style="visibility: hidden;">

        <div id="outer_wrap">

            <%-- HEADER --%>
            <g:render template="/layouts/header" model="${[title: "Required Documents Parameter Maintenance"]}"/>

            <div id="navigation">
                <div id="Accordion1" class="Accordion">
                    <div class="AccordionPanel">
                        <div class="AccordionPanelTab panelHome" id="accordpanel_home">Required Documents Maintenance Actions</div>
                        <div class="AccordionPanelContent">
                            <ul>
                                <li><a href="javascript:void(0)" id="btnAddNewDocument" />Add New Document</a></li>
                                <li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div id="body_forms">
                <br/><br/><br/>
                <div class="grid_wrapper">
                    <table id=requiredDocumentTable>
                        <thead>
<%--                        <th>ID</th>--%>
                        <th>Document Code</th>
                        <th>Document Type</th>
                        <th>Description</th>
                        <th>Edit</th>
                        <th>Delete</th>
                        </thead>
                        <tbody>
                        <g:each in="${requiredDocuments}" var="rd">
                            <tr>
<%--                            	<td style="width: 15px">${rd.id.toString().replace('.0','')}</td>--%>
                            	<td>${rd.documentCode}</td>
                            	<td>${rd.documentType}</td>
                                <td>${rd.description}</td>
                                <td style="width: 40px; "><a href="javascript:void(0)" style="color: red;" onclick="editDocument(${rd.i})">Edit</a></td>
                                <td style="width: 40px;"><a href="javascript:void(0)" style="color: red;" onclick="deleteDocument(${rd.id?.toString().replace('.0','')})">Delete</a></td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <div id="pager"></div>
                </div>
            </div>
        </div>
<g:render template="../admin/refRequiredDocument/new_required_document" />
<g:render template="../admin/common/alert" />
</body>
</html>