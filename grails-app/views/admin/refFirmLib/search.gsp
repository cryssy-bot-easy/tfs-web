<%@ page import="net.ipc.utils.NumberUtils; net.ipc.utils.DateUtils" contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="admin" />
	<title> Trade Finance System </title>
	<script type="text/javascript">
		var addOrEditUrl = '${g.createLink(controller:'refFirmLibAdmin', action: 'addOrEdit')}';
		var deleteUrl = '${g.createLink(controller:'refFirmLibAdmin', action: 'delete')}';

		$(document).ready(function() {
			tableToGrid("#refFirmLibTable", {width : 780, height: 350, scrollOffset : 0, rowNum: 15,  shrinkToFit: false, pager: '#pager', rowList: [10,20,30]})
			jQuery("#refFirmLibTable").jqGrid('setGridParam', {page: 1}).trigger("reloadGrid");

			$("#save_firmLib").click(function() {
				if($("#firmCode").val().trim() != "" && $("#firmDescription").val().trim() != "") {
					saveFirmLib();
				} else {
					firmLibAlertPopup();
					$("#alertMessage").text("Please fill in the required fields.");
				}
			});
			
			$(".close_firmLib").click(function() {
				mDisablePopup($("#popup_page"), $("#popup_bg"));
			});

			$("#btnAlertOk").click(function() {
				mDisablePopup($("#popup_alert_dv"), $("#popup_alert_bg"));
				if($("#statusFirmLib").val() == "ok") {
					location.reload();
				}
			});
		});

		function clearParams() {
			$("#firmCode, #firmDescription").val("");	
		}

		function saveFirmLib() {
			var addData = {
				firmCode: $("#firmCode").val(),
				firmDescription: $("#firmDescription").val().toUpperCase(),
				addOrEditFirmLib: $("#addOrEditFirmLib").val()
			}

			$.post(addOrEditUrl, addData, function(data) {
				if(data.success === "true") {
					$("#statusFirmLib").val("ok");
					$("#btnAlertOk").removeClass("input_button_negative");
					$("#btnAlertOk").addClass("input_button");
					firmLibAlertPopup();
    	            $("#alertMessage").text("Record Saved.");
				} else {
					$("#statusFirmLib").val("error");
					$("#btnAlertOk").removeClass("input_button");
					$("#btnAlertOk").addClass("input_button_negative");
					firmLibAlertPopup();
					$("#alertMessage").text("Existing Firm Code.");
				}
			});
		}

		function deleteFirmLib(firmCode) {
			var addData = {
				firmCode: firmCode
			}

			$("#firmLibAddEdit").hide();
			$("#firmLibConfirmation").show();
			$("#firmLibPopupLabel").text("Delete");
			firmLibPopup();

			$("#delete_firmLib").click(function() {
				$.post(deleteUrl, addData, function(data) {
					if(data.success === "true") {
						$("#statusFirmLib").val("ok");
						$("#btnAlertOk").removeClass("input_button_negative");
						$("#btnAlertOk").addClass("input_button");
						firmLibAlertPopup();
	    	            $("#alertMessage").text("Record Deleted.");
					} else {
						$("#statusFirmLib").val("error");
						$("#btnAlertOk").removeClass("input_button");
						$("#btnAlertOk").addClass("input_button_negative");
						firmLibAlertPopup();
						$("#alertMessage").text("Failed.");
					}
				});
			});
		}

		function addFirmLib() {
			$("#firmLibAddEdit").show();
			$("#firmLibConfirmation").hide();
			$("#addOrEditFirmLib").val("add");
			$("#firmLibPopupLabel").text("Add New Code");
			firmLibPopup();
		}
		
		function editFirmLib(idCount) {
			$("#firmLibAddEdit").show();
			$("#firmLibConfirmation").hide();
			var gridData = $("#refFirmLibTable").jqGrid("getRowData", idCount);
			$("#firmCode").val(gridData.Firm_Code).attr("readonly", "readonly");
			$("#firmDescription").val(gridData.Firm_Description);
			$("#addOrEditFirmLib").val("edit");
			$("#firmLibPopupLabel").text("Edit");
			firmLibPopup();
		}

		function firmLibPopup() {
			mLoadPopup($("#popup_page"), $("#popup_bg"));
			mCenterPopup($("#popup_page"), $("#popup_bg"));
		}

		function firmLibAlertPopup() {
			mLoadPopup($("#popup_alert_dv"), $("#popup_alert_bg"));
			mCenterPopup($("#popup_alert_dv"), $("#popup_alert_bg"));
		}
	</script>
</head>
<body>
<g:hiddenField name="addOrEditFirmLib" value=""/>
<g:hiddenField name="statusFirmLib" value=""/>
<div id="outer_wrap">
	<%-- HEADER --%>
	<g:render template="/layouts/header" model="${[title: "FirmLib Maintenance"]}"/>
	
	<div id="navigation">
		<div id="Accordion1" class="Accordion">
			<div class="AccordionPanel">
				<div class="AccordionPanelTab panelHome" id="accordpanel_home">FirmLib Administration Actions</div>
				<div class="AccordionPanelContent">
					<ul>
						<li><a href="javascript:void(0)" onclick="addFirmLib()">Add New Code</a></li>
						<li><a href="<g:createLink controller="admin"/>">Back to Admin Home</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	
	<div id="body_forms">
		<br/><br/><br/>
		<g:form id="refFirmLibInquiry" class="inquiry_form" method="post" controller="refFirmLibAdmin" action="search">
			<table class="body_forms_table">
				<tr>
					<td class="label_width"><span class="field_label">Firm Code</span></td>
					<td><g:textField name="searchFirmCode" class="input_field"/></td>
					<td class="label_width"><span class="field_label">Firm Description</span></td>
					<td><g:textField name="searchFirmDescription" class="input_field"/></td>
				</tr>
				<tr>
					<td colspan="3"/>
					<td><input type="button" class="input_button" value="Search" onclick="form.submit();"/></td>
				</tr>
				<tr>
					<td colspan="3"/>
					<td><input type="button" class="input_button_negative" value="Reset" onclick="clearParams(); form.submit();"/></td>
				</tr>
			</table>
			<div class="grid_wrapper">
				<table id="refFirmLibTable">
					<thead>
						<tr>
							<th width="180">Firm Code</th>
							<th width="400">Firm Description</th>
							<th width="100">Edit</th>
							<th width="100">Delete</th>
						</tr>
					</thead>
					<tbody>
						<g:each in="${refFirmLib}" var="firmLib">
							<tr>
								<td>${firmLib?.firmCode?.toUpperCase()}</td>
								<td>${firmLib?.firmDescription?.toUpperCase()}</td>
								<td><a href="javascript:void(0)" style="color: red;" onclick="editFirmLib(${firmLib?.idCount})">edit</a></td>
								<td><a href="javascript:void(0)" style="color: red;" onclick="deleteFirmLib('${firmLib?.firmCode?.toString()}')">delete</a></td>
							</tr>
						</g:each>
					</tbody>
				</table>
				<div id="pager"></div>
			</div>
		</g:form>
	</div>
</div>
<g:render template="../admin/refFirmLib/add_edit_firmlib"/>
<g:render template="../admin/common/alert" />
</body>
</html>