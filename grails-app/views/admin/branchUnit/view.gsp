<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
	<script type="text/javascript">
		$(document).ready(function() {
	    	$("#btnSaveForm").click(function(e) {
	           	if($("#unitCode").val().trim() != '' || $("#unitName").val().trim() != '') {
	               	$('form').submit();
	           	} else {
	               	alert('Unit Code or Unit Name cannot be blank');
	           	}
	       	});
		});
	</script>    
    <title> Trade Finance System </title>

</head>
<body>
<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="/layouts/header" model="${[title: "Branch Unit File Paremeter Maintenance"]}"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">User Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="branchUnitAdmin"/>">Back to Branch Unit <br/> Maintenance Inquiry Page</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">

        <br/><br/><br/>
        <g:form  id="branchUnitForm" class="inquiry_form" method="post" controller="branchUnitAdmin" action="save">
            <table class="body_forms_table">
					<tr>
                		<td><span class="field_label">Unit Code</span></td>
               			<g:if test="${branchUnitDetail?.unitCode}">
               				<td><g:textField name="unitCode" class="input_field" value="${branchUnitDetail?.unitCode}" maxlength="3" readonly="readonly"/></td>
               			</g:if>
               			<g:else>
               				<td><g:textField name="unitCode" class="input_field" value="${branchUnitDetail?.unitCode}" maxlength="3"/></td>
               			</g:else>
                	</tr>
                	<tr>
                		<td><span class="field_label">Unit Name</span></td>
                		<td><g:textField name="unitName" class="input_field" value="${branchUnitDetail?.unitName}" maxlength="50"/>	
                	</tr>
                	<tr>
                		<td><span class="field_label">Unit Address</span></td>
                		<td><g:textArea name="unitAddress" class="textarea" value="${branchUnitDetail?.address}" maxlength="300"/>	
                	</tr>
                	<tr>
                		<td><span class="field_label">Branch Type</span></td>
                		<td><g:textField name="branchType" class="input_field" value="${branchUnitDetail?.branchType}"  maxlength="50"/></td>
                	</tr>
                	<tr>
                		<td><span class="field_label">SWIFT STATUS</span></td>
                		<td><g:select name="swiftStatus" noSelection="['':'SELECT ONE...']" class="select_dropdown" value="${branchUnitDetail?.swiftStatus}" from="${['Enable','Disable']}"/></td>
                	</tr>
                <tr>
                    <td colspan="6">
                        <table class="body_forms_table_btn">
                            <tr>
                                <td>
                                    <input id="btnSaveForm" type="button" class="input_button" value="Save" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="button" class="input_button_negative" value="Cancel" id="resetLcBtn"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

        </g:form>
        
</div>
</div>
</body>
</html>