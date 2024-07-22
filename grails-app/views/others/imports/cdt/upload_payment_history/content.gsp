<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="layout" content="main" />
	<title>Trade Finance System</title>
	<g:javascript src="grids/upload_payment_history_jqgrid.js"/>
	<script type="text/javascript">

	    var referenceType = '${referenceType}';
		var serviceType = '${serviceType}';
		var documentType = '${documentType}';
		var documentClass = '${documentClass}';
		var username = '${username}'
		
		<%-- pay duties and taxes page  --%>
		var payDutiesAndTaxesUrl = '${g.createLink(controller:'payDutiesTaxes', action:'viewPayDutiesTaxesCdt')}'
	</script>
</head>
<body>
<div id="outer_wrap">
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>
	
	<%-- ACCORDION --%>
	<g:render template="../layouts/accordion"/>

	<div id="body_forms">
		
		<br />
		<table class="upload_header">
			<tr>
				<td><span class="field_label">File Location</span></td>
				<td><input type="file" id="fileLocation" class="input_field_file"/></td>
			</tr>
			<tr>
				<td />
				<td><g:submitToRemote class="input_button button_override" value="Upload" /></td>
			</tr> 
		</table>
		
		<%-- JQGRID --%>
		<div class="grid_wrapper">
	  		<table id="grid_list_cdt_upload_payment_history"></table>
			<div id="grid_pager_cdt_upload_payment_history"></div>
		</div>	
		
		<%-- FOOTER --%>
		<form>
		<div class="upload_footer">
			<table class="upload_tbl" cellspacing="5">
				<tr>
					<td><p class="upload_text">Total Amount Collected (TFS)</p></td><td><g:textField name="totalAmountCollectedsTFS" class="input_field" readonly="readonly"/></td>
				</tr>
				<tr>
					<td><p class="upload_text">Total Amount Collected (e2m)</p></td><td><g:textField name="totalAmountCollectedsE2M" class="input_field" readonly="readonly"/></td>
				</tr>
			</table>
		</div>
		<div class="upload_send">	
			<input type="button" id="btnUploadPayment" class="input_button3" value="Send to MOB-BOC" />
		</div>
		</form>
	</div>
</div>
</body>
</html>