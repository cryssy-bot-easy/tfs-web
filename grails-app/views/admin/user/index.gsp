<%@ page import="net.ipc.utils.NumberUtils" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
	PROLOGUE:
	(revision)
	SCR/ER Number: 20160321-081  
	SCR/ER Description: No "Create Transaction" under NON-LC for IBDMCB user.
	[Revised by:] Lymuel Arrome Saul
	[Date revised:] 06/08/2016
	Program [Revision] Details: The User Maintenance was revised by making the position required for users with unit code 909 and 910
								and the level is automatically updated in SEC_EMPLOYEE based from the position of the user.
	Date deployment: 06/17/2016
	Member Type: GSP
	Project: WEB
	Project Name: index.gsp
 --%>

<%--
    PROLOGUE:
    (revision)
    SCR/ER Number:
    SCR/ER Description:
    [Revised by:] Cedrick C. Nungay
    [Date revised:] 12/20/2017
    Program [Revision] Details: Added showing alert if domain is valid and if process is successful
    Member Type: GSP
    Project: WEB
    Project Name: index.gsp
--%>
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="user_admin" />
    <script type="text/javascript">

        function showAlert(alertMessage, title){
            $("#alertMessage").html(alertMessage);

            if (!title) {
                title = 'Alert!';
            }
            $('#popup_alert_dv > h2.popup_title').html(title)

            mLoadPopup($("#popup_alert_dv"), $("#popup_alert_bg"));
            mCenterPopup($("#popup_alert_dv"), $("#popup_alert_bg"));

            $("#btnAlertOk").focus();
            $("#btnAlertOk").click(function() { });
        }

        $(document).ready(function() {

            $("#userManagementCancel").click(function() {
                location.href = '${g.createLink(controller: "userAdmin", action: "search")}';
            });

            $("#userId").change(function() {
                $("#valid").val("false");
            });

            $("#position").change(function() {
                $("#postingLimit").val("");
                $.get('${g.createLink(controller: "userAdmin", action: "retrieveSigningLimit")}',
                        {positionCode: $("#position").val()}, function(data) {
                            $("#postingLimit").val(data.signingLimit);
                        });
            });

            $("#btnValidate").click(function() {
//                loadPopup("loading_div", "loading_bg");

                if($("#userId").val() != "") {
                    $.ajax({
                        url:"${g.createLink(controller:'userAdmin',action:'validateUser')}",
                        dataType: 'json',
                        data: {
                            userId: $("#userId").val(),
                            ldapDomain: $("#ldapDomain").val()
                        },
                        success: function(data) {
                            if(data.status == "ok") {
//                                disablePopup("loading_div", "loading_bg");

                                //$("#fullName").removeAttr('readonly');
                                //$("#unitCode").removeAttr('readonly');
                                $("#fullName").val(data.user.fullName);
                                $("#unitCode").val(data.user.unitCode);

                                $("#bookingUnitCode").val(data.user.bookingUnitCode);

                                $("#email").val(data.user.email);
                                $("#valid").val("true");

                                if($("#unitCode") == "") {

                                };

                                $('#userRoles')[0].options.length = 0;

                                if(data.user.roles) {
                                    var roles = data.user.roles;
                                    for(var x=0; x < data.user.roles.length; x++) {
                                        $('#userRoles').append(
                                                $('<option></option>').val(roles[x].roleId.roleId).html(roles[x].description)
                                        );
                                    }
                                }

                                if (data.isExisting == true && ${params.u == null}) {
                                    showAlert("User already exist in TFS. Saving this will update the existing user.");
                                } else {
                                    showAlert('User successfully found in Active Directory', 'Notification');
                                }

                            } else if (data.status == "not found") {
//                                disablePopup("loading_div", "loading_bg");
                                showAlert('User does not exist in Active Directory');
                            } else {
                                disablePopup("loading_div", "loading_bg");
                                showAlert('Unable to retrieve details from Active Directory');
                            };
                        },
                        error: function(request, status, error) {
//                            disablePopup("loading_div", "loading_bg");
                            showAlert(error);
                        },
                        complete: function() {
                        }
                    });
                }
            });

            $("#btnSaveForm").click(function(e) {
                $("#changeAuthorizationUsername, #changeAuthorizationPassword").val("");

                var error = 0;
        		var alert_msg = "";
        		var _pageHasErrors=false;
        		
        		if ($("#position").attr("class") != undefined && $("#position").attr("class") != null && $("#position").attr("class").indexOf("required") != -1) {
        	        if ($("#position").val() == "") {
        	            error ++;
        	            if(alert_msg.length > 0){
        	            	   alert_msg += "<br/>";
        	               }
                        alert_msg += "position";
        	        }
        	    }

        		if(error > 0){
        			showAlert("Missing Required Fields:<br/>"+alert_msg);
        			_pageHasErrors=true;
        		}

        		if(!_pageHasErrors){
	                if ($("#valid").val() == 'true') {
	                	var availableRole = $('#userRoles option').attr('selected', 'selected');
	                	var stat = $("#isSuspended").prop("checked");

	                	if (availableRole.length > 0) { 
                    		loadPopup("changeAuthorizationDiv", "changeAuthorizationBg");
                    		centerPopup("changeAuthorizationDiv", "changeAuthorizationBg");
                    	} else {
                    		if (stat){
	                    		loadPopup("changeAuthorizationDiv", "changeAuthorizationBg");
	                    		centerPopup("changeAuthorizationDiv", "changeAuthorizationBg");
                    		}else{
                    			showAlert("User role is blank");
                    		}
                    	}

	                    %{--if (${params.u == null}) { // add mode--}%
	                        %{--$('#userRoles option').attr('selected', 'selected');--}%
	                        %{--$('form').submit();--}%
	                    %{--} else {--}%
	                        %{--$.get('${g.createLink(controller: "userAdmin", action: "checkIfOfficer")}',--}%
	                                %{--{userToChange: $("#userId").val()},--}%
	                                %{--function(data) {--}%
	                                    %{--if (data.isOfficer == true) {--}%
	                                        %{--formChanged = false;--}%
	
	                                        %{--$('#userRoles option').attr('selected', 'selected');--}%
	                                        %{--$('form').submit();--}%
	                                    %{--} else {--}%
	                                        %{--loadPopup("changeAuthorizationDiv", "changeAuthorizationBg");--}%
	                                        %{--centerPopup("changeAuthorizationDiv", "changeAuthorizationBg");--}%
	                                    %{--}--}%
	                                %{--}--}%
	                        %{--);--}%
	                    %{--}--}%
	                } else {
	                    showAlert('Please validate userid before saving')
	                }
        		}
            });

            $("#changeAuthorizationConfirm").click(function() {
                $.post('${g.createLink(controller: "login", action: "authenticateChange")}',
                        {username: $("#changeAuthorizationUsername").val(), password: $("#changeAuthorizationPassword").val()},
                        function(data) {

                        if (data.success) {
                            formChanged = false;

                            $('#userRoles option').attr('selected', 'selected');
                            showAlert('Changes has been successfully saved.', 'Notification');

                            $("#btnAlertOk").click(function() {
                            	$('form').submit();
                            });
                        } else {
                            showAlert(data.message);
                        }

                });
            });

            $("#changeAuthorizationCancel").click(function() {
                disablePopup("changeAuthorizationDiv", "changeAuthorizationBg");
            });

    		$(".tellerIDRow").hide();
    		$(".positionRow").hide();
    		$(".designationRow").hide();
    		$(".postingLimitRow").hide();
    		$(".postingAuthorityRow").hide();
    		$(".casaLimitRow").hide();
			<%-- 04052017 Interim fix by Pat - to show switch for TFS E-mail notif--%>
    		$(".receiveEmailRow").show();
    		
            $("#userRoles").change(function(){
				if($(this).val() == 'BBOCCO' || $(this).val() == 'BBOCCP'){
            		//teller - show
            		$(".tellerIDRow").show();
            		//position - show
            		$(".positionRow").show();
            		//designation - hide
            		$(".designationRow").hide();
            		//posting limit - hide
            		$(".postingLimitRow").hide();
            		//posting authority -hide
            		$(".postingAuthorityRow").hide();
            		//casa limit - show
            		$(".casaLimitRow").show();
					// Receive Email - hide
            		$(".receiveEmailRow").show();
				}else if($(this).val() == 'FDPUO' || $(this).val() == 'FDPUP' || $(this).val() == 'MO' || $(this).val() == 'MP' ){
					//teller - show
					$(".tellerIDRow").show();
					//position - show
					$(".positionRow").show();
					//designation - hide
            		$(".designationRow").hide();
					//posting limit - hide
					$(".postingLimitRow").hide();
					//posting authority - hide
					$(".postingAuthorityRow").hide();
					//casa limit - hide
					$(".casaLimitRow").hide();
					// Receive Email - hide
            		$(".receiveEmailRow").show();
				}else if($(this).val() == 'HOPUP'){
					//teller - show
					$(".tellerIDRow").show();
					//position - show
					$(".positionRow").show();
					//designation - hide
            		$(".designationRow").show();
					//posting limit - show
					$(".postingLimitRow").hide();
					//posting authority - show
					$(".postingAuthorityRow").hide();
					//casa limit - show
					$(".casaLimitRow").show();
					// Receive Email - show
            		$(".receiveEmailRow").show();
				}else if($(this).val() == 'HOPUO'){
					//teller - show
					$(".tellerIDRow").show();
					//position - show
					$(".positionRow").show();
					//designation - hide
            		$(".designationRow").show();
					//posting limit - show
					$(".postingLimitRow").show();
					//posting authority - show
					$(".postingAuthorityRow").show();
					//casa limit - show
					$(".casaLimitRow").show();
					// Receive Email - show
            		$(".receiveEmailRow").show();
				}else if($(this).val() == 'TELO' || $(this).val() == 'TELP'){
					//teller - hide
					$(".tellerIDRow").hide();
					//position - show
					$(".positionRow").show();
					//designation - show
					$(".designationRow").show();
					//posting limit - hide
					$(".postingLimitRow").hide();
					//posting authority - hide
					$(".postingAuthorityRow").hide();
					//casa limit - hide
					$(".casaLimitRow").hide();
					// Receive Email - hide
            		$(".receiveEmailRow").hide();
				}else if($(this).val() == 'TFSBATCH' ){
					//teller - hide
					$(".tellerIDRow").hide();
					//position - show
					$(".positionRow").show();
					//designation - hide
					$(".designationRow").hide();
					//posting limit - hide
					$(".postingLimitRow").hide();
					//posting authority - hide
					$(".postingAuthorityRow").hide();
					//casa limit - hide
					$(".casaLimitRow").hide();
					// Receive Email - hide
            		$(".receiveEmailRow").hide();
				}else if($(this).val() == 'TFSADMIN' || $(this).val() == 'TFSUSER'){
					//teller - hide
					$(".tellerIDRow").hide();
					//position - show
					$(".positionRow").show();
					//designation - hide
					$(".designationRow").show();
					//posting limit - hide
					$(".postingLimitRow").hide();
					//posting authority - hide
					$(".postingAuthorityRow").hide();
					//casa limit - hide
					$(".casaLimitRow").hide();
					// Receive Email - hide
            		$(".receiveEmailRow").hide();
				}
            });

            $("#position").change(function(){
                if($("#bookingUnitCode").val() == '909' || $("#bookingUnitCode").val() == '910'){
	            	switch ($(this).val()){
	            	case 'JG4':
	            	case 'JG5':
	                case 'JG6':
	                default:
	                    $("#level").val("1");
	                break;
	                case 'JAM':
	                	$("#level").val("5");
	                break;
	                case 'AMGR':
	                	$("#level").val("8");
	                break;
	                case 'MGR1':
	                	$("#level").val("10");
	                break;
	                case 'MGR2':
	                	$("#level").val("15");
	                break;
	                case 'AVP1':
	                	$("#level").val("20");
	                break;
	                case 'AVP2':
	                	$("#level").val("25");
	                break;
	                case 'CS':
	                	$("#level").val("30");
	                break;
	                case 'VP':
	                	$("#level").val("35");
	                break;
	                case 'FVP':
	                	$("#level").val("40");
	                break;
	                case 'SVP':
	                	$("#level").val("45");
	                break;
	                case 'EVP':
	                	$("#level").val("50");
	                break;
	                case 'SEVP':
	                	$("#level").val("55");
	                break;
	                case 'PCEO':
	                	$("#level").val("60");
	                break;
	            	}
                }
            });
        });
    </script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
    <%-- HEADER --%>
    <g:render template="../layouts/header"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">User Administration Actions</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="userAdmin"/>">Back to User Admin</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

<div id="body_forms">
    <ul>
        <li>&nbsp;</li>
    </ul>

    <g:form id="userForm" class="inquiry_form" method="post" controller="userAdmin" action="save">
        <input id="valid" type="hidden" value="<g:if test="${params.u == null}">false</g:if><g:else>true</g:else>"/>
        <table id="userAdmin" class="body_forms_table">
            <tr>
                <td colspan="2"><span class="field_label">Suspended?</span></td>
                <td>
                    <input type="checkbox" name="isSuspended" id="isSuspended" <g:if test="${(user?.employeeDetails?.suspended)}">checked</g:if> />
                </td>
            </tr>
            <tr>
                <td colspan="2"><span class="field_label">Domain</span></td>
                <td>
                    <g:select from="${['BRANCH', 'UCPB8']}" value="" name="ldapDomain" class="select_dropdown" />
                </td>
            </tr>
            <tr>
            	<td colspan="2"><span class="field_label">Last Login</span></td>
            	<td><input type="text" class="input_field_normal_case" name=lastLogin" id="lastLogin" value = "${user?.lastLogin?.toString() }" readonly="true" /></td>
            </tr>
            <tr>
                <td colspan="2"><span class="field_label">User ID</span></td>
                <td>
                    <input type="text" class="input_field_normal_case" name="userId" id="userId" value="${user?.userId?.id}" <g:if test="${params.u != null}">readonly="readonly"</g:if>/>
                    %{--<g:if test="${params.u == null}">--}%
                        <input id="btnValidate" type="button" value="Validate"/>
                    %{--</g:if>--}%
                </td>
            </tr>
            <tr>
                <td colspan="2"><span class="field_label">User Name</span></td>
                <td>
                    <input type="text" class="input_field_normal_case" name="fullName" id="fullName" style="width: 200px;"
                           value="${user?.employeeDetails?.fullName!=null ? user?.employeeDetails?.fullName : (user?.employeeDetails?.firstName ?: "") + " " + (user?.employeeDetails?.lastName ?: "")}" readonly="readonly"/>
                </td>
            </tr>
            <tr>
                <td colspan="2"><span class="field_label">Email</span></td>
                <td>
                    <input type="text" class="input_field_normal_case" name="email" id="email" value="${user?.employeeDetails?.email}" readonly="readonly" style="width: 200px;"/>
                </td>
            </tr>

            <tr>
                <td colspan="2"><span class="field_label">Unit Code</span></td>
                <td>
                    <input type="text" class="input_field" name="unitCode" id="unitCode" value="${user?.employeeDetails?.fullUnitCode}" readonly="readonly" style="width: 50px;"/>
                </td>
            </tr>

            <tr>
                <td colspan="2"><span class="field_label">Booking Unit Code</span></td>
                <td>
                    <input type="text" class="input_field" name="bookingUnitCode" id="bookingUnitCode" value="${user?.employeeDetails?.unitCode}" readonly="readonly" style="width: 50px;"/>
                </td>
            </tr>
            <tr>
                <td colspan="2"><span class="field_label">User Roles</span></td>
                <td><select multiple="true" class="select_dropdown" id="userRoles" name="userRoles" style="width: 300px;">
						<g:if test="${params.u != null}">
							<g:each in="${user.roles}" var="role">
								<option value="${role.roleId.roleId}">${role.description}</option>
							</g:each>
						</g:if>
					</select>
                </td>
            </tr>
           <tr class="tellerIDRow">
                <td colspan="2"><span class="field_label">Teller ID</span></td>
                <td>
                    <input type="text" class="input_field" name="tellerId" id="tellerId" value="${user?.employeeDetails?.tellerId}" style="width: 50px;"/>
                </td>
            </tr>
            <tr class="positionRow">
                <td colspan="2"><span class="field_label">Position<g:if test="${user?.employeeDetails?.unitCode?.equalsIgnoreCase('909') || user?.employeeDetails?.unitCode?.equalsIgnoreCase('910')}"><span class="asterisk">*</span></g:if></span></td>
                <td>
                    <g:select name="position" noSelection="${['': 'SELECT ONE...']}" class="select_dropdown ${(user?.employeeDetails?.unitCode?.equalsIgnoreCase('909') || user?.employeeDetails?.unitCode?.equalsIgnoreCase('910')) ? "required" : ""}" style="width: 209px;"
                              value="${user?.employeeDetails?.position}" from="${allPositions?.positionName}" keys="${allPositions?.code?.code}"/>
                    <input id="level" name="level" type="hidden" value="${level}"/>
                </td>
            </tr>
            <tr class="designationRow">
                <td colspan="2"><span class="field_label">Designation </span></td>
                <td>
                    <g:select name="designation" noSelection="${['': 'SELECT ONE...']}" class="select_dropdown" style="width: 209px;"
                              value="${user?.employeeDetails?.designation?.id ? user?.employeeDetails?.designation?.id?.toString().replace('.0','') :
                                  ''}" from="${allDesignations?.description}" keys="${allDesignations?.id}"/>
                                 
                </td>
            </tr>
            <tr class="postingLimitRow">
                <td colspan="2"><span class="field_label">Posting Limit</span></td>
                <td>
                    <input type="text" class="input_field_right numericCurrency" name="postingLimit" id="postingLimit" value="${user?.employeeDetails?.postingLimit}"/>
                </td>
            </tr>
            <tr class="postingAuthorityRow">
                <td colspan="2"><span class="field_label">Posting Authority</span></td>
                <td>
                    <input type="checkbox" name="postingAuthority" id="postingAuthority" <g:if test="${(user?.employeeDetails?.postingAuthority)}">checked</g:if> />
                </td>
            </tr>
            <tr class="casaLimitRow">
                <td colspan="2"><span class="field_label">CASA Limit</span></td>
                <td>
                    <input type="text" class="input_field_right numericCurrency" name="casaLimit" id="casaLimit" value="${user?.employeeDetails?.casaLimit}"/>
                </td>
            </tr>
            
            <tr class="receiveEmailRow">
            	<td colspan="2"><span class="field_label">Receive Email?</span></td>
            	<td><g:radioGroup name="receiveEmail" labels="['Yes','No']" values="['true','false']" value="${user?.employeeDetails?.receiveEmail}"> 
            			${it.label} ${it.radio}
					</g:radioGroup>
				</td>
            </tr>

        </table>
        <table class="body_forms_table_btn">
                        <tr>
                            <td>
                                <input id="btnSaveForm" type="button" class="input_button" value="Save"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="button" class="input_button_negative" value="Cancel" id="userManagementCancel"/>
                            </td>
                        </tr>
                    </table>
    </g:form>

</div>
<%-- End of TABS --%>
</div>

<g:render template="/commons/popups/override_change_authorization"
          model="[overrideAuthDivId: 'changeAuthorizationDiv',
                  overrideAuthDivBg: 'changeAuthorizationBg',
                  overrideAuthUsernameId: 'changeAuthorizationUsername',
                  overrideAuthPasswordId: 'changeAuthorizationPassword',
                  overrideAuthConfirmId: 'changeAuthorizationConfirm',
                  overrideAuthCancelId: 'changeAuthorizationCancel'
          ]"/>

<g:render template="/layouts/loading" />
<g:render template="../admin/user/alert" />
</body>
</html>