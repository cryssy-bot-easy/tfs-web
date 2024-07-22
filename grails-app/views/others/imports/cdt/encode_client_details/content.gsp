<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> Trade Finance System</title>
		<meta name="layout" content="main" />
		<script type="text/javascript">
		    var referenceType = '${referenceType}';
			var serviceType = '${serviceType}';
			var documentType = '${documentType}';
			var documentClass = '${documentClass}';
			var username = '${username}'
		</script>
		<g:javascript src="popups/alert_utility.js" />	
	</head>
	
	<body>
		<div id="outer_wrap">

				<%-- HEADER --%>
				<g:render template="../layouts/header"/>
				
				<%-- ACCORDION --%>
				<g:render template="../layouts/accordion"/>

				<div id="body_forms">
				<div id="body_forms_header">
					<table id="header_details2">
						<tr>
						  <td> <span class="field_label"> CIF Number </span> </td>
						  <td> 
						  		<g:textField name="cifNumber" class="input_field" />
						  		<a href="javascript:void(0)" class="search_btn popup_btn_cif_normal" id="popup_btn_cif"> Search/Look-up Button </a>
						   </td>
						</tr>
						<tr> 
						  <td> <span class="field_label"> CIF Name </span> </td>
						  <td> <g:textField name="cifName" class="input_field" readonly="readonly" /> </td>
						</tr>
						<tr> 
						  <td> <span class="field_label"> Account Officer </span> </td>
						  <td> <g:textField name="accntOfficer" class="input_field" readonly="readonly" /> </td>
						</tr>
						<tr> 
						  <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
						  <td> <g:textField name="ccbdBranchUnitCode" class="input_field" readonly="readonly" /> </td>
						</tr>
					</table>
				</div>
				<hr>
				<br/>
				<table class="tabs_forms_table">
					<tr>
						<td><span class="field_label">Importer TIN</span></td>
						<td><g:textField name="importerTIN" class="input_field" readonly="readonly"/></td>
					</tr>
					<tr>
						<td><span class="field_label">Registration (Importer) Name</span></td>
						<td><g:textField name="registrationName" class="input_field" readonly="readonly"/></td>
					</tr>
					<tr>
						<td><span class="field_label">Registration Date & Time</span></td>
						<td><g:textField name="registrationDateTime" class="input_field" readonly="readonly"/></td>
					</tr>
					<tr>
						<td><span class="field_label">AAB Ref Code</span></td>
						<td><g:textField name="aabRefCode" class="input_field" readonly="readonly"/></td>
					</tr>
					<tr>
						<td><span class="field_label">Customs Client Number</span></td>
						<td><g:textField name="customClientNumber" class="input_field" readonly="readonly"/></td>
					</tr>
					<tr>
						<td><span class="field_label">Bank Commission</span></td>
						<td><g:textField name="bankCommission" class="input_field"/></td>
					</tr>
					<tr>
						<td><span class="field_label">Fee Sharing</span></td>
						<td>
							<g:radioGroup name="freeSharing" labels="['Yes','No']" values="['Y','N']" class="small_margin_left">
						     ${it.radio}&#160;<g:message code="${it.label}" />
						    </g:radioGroup>	
						</td>
					</tr>
					<tr>
						<td><span class="field_label">Importer's CASA - Account Number</span></td>
						<td><g:select name="importerCasaAcctNumber" from="${['account number 1','account number 2','account number 3']}"
									class="select_dropdown" noSelection="['':'select one']"/>
						</td>
					</tr>
					<tr>
						<td>
							<span class="field_label">If with CASA Number:</span><br/>
							<span class="field_label">With Auto-Debit or Blanket Authority?</span>
						</td>
						<td valign="bottom"><g:select name="withAutoDebit" from="${['yes-with e-mail advice','yes-without e-mail advice','no']}"
									class="select_dropdown" noSelection="['':'select one']"/>
						</td>
					</tr>
					<tr>
						<td><span class="field_label">Importer's Contact Person</span></td>
						<td><g:textField name="importerContactPerson" class="input_field"/></td>
					</tr>
					<tr>
						<td><span class="field_label">Importer's Email Address</span></td>
						<td><g:textField name="importerEmail" class="input_field"/></td>
					</tr>
					<tr>
						<td valign="top"><span class="field_label">Importer's Contact Number/s</span></td>
						<td>
							<g:textArea name="importerContactNumber" class="textarea" rows="4"></g:textArea>
						</td>
					</tr>
				</table>
				<g:render template="../layouts/buttons_for_grid_wrapper" />
			</div>
		</div>		
		
		<g:render template="../layouts/confirm_alert" />
		<g:render template="../layouts/alert" />
		<g:render template="../commons/popups/cif_search_normal" />
		<g:javascript src="popups/cif_normal_search_popup.js"/>
	</body>
</html>