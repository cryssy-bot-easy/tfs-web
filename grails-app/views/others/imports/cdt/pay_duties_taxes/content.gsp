<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System</title>
    <script type="text/javascript">
		    var referenceType = '${referenceType}';
			var serviceType = '${serviceType}';
			var documentType = '${documentType}';
			var documentClass = '${documentClass}';
			var username = '${username}'
	</script>
    
	<g:javascript src="grids/payment_jqgrid.js"/>
	<g:javascript src="popups/alert_utility.js" />	
	
	<g:javascript src="popups/mode_of_payment_charges_popup.js" />	
	
  </head>
  <body>
  
    <div id="outer_wrap">
	  
	  <%-- HEADER --%>
	  <g:render template="../layouts/header"/>
	  	  
	  <%-- ACCORDION --%>
	  <g:render template="../layouts/accordion"/>
	  
	  <div id="body_forms">
	    <span class="title_label">Importer Contact Person</span><br /><br />
		<table class="tabs_forms_table">
			<tr>
				<td class="label_width"><span class="field_label"> Importer Contact Person </span></td>
				<td class="input_width"><g:textField class="input_field" readonly="readonly" name="importerContactPerson" /></td>
				<td class="label_width"><span class="field_label"> Name of RM/BM with Unit/Branch </span></td>
				<td class="input_width"><g:textField class="input_field" readonly="readonly"  name="nameRmBmWithUnitBranch" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> Importer Contact Numbers </span></td>
				<td class="input_width"><g:textField class="input_field" readonly="readonly" name="importerContactNumbers" /></td>
				<td class="label_width"><span class="field_label"> RM/BM Email Address </span></td>
				<td class="input_width"><g:textField class="input_field" readonly="readonly"  name="rmBmEmailAddress" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> Importer Email Address </span></td>
				<td class="input_width"><g:textField class="input_field" readonly="readonly" name="importerEmailAddress" /></td>
				<td class="label_width"><span class="field_label"> Email Status </span></td>
				<td class="input_width"><g:textField class="input_field" readonly="readonly"  name="emailStatus" /></td>
			</tr>
		</table><br />
		<span class="title_label">Custom Duties Tax Payment Details</span><br /><br />
		<table class="tabs_forms_table">
			<tr>
				<td class="label_width"><span class="field_label"> CDT Amount </span></td>
				<td class="input_width"><g:textField class="input_field" readonly="readonly" name="cdtAmount" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> Bank Charge </span></td>
				<td class="input_width"><g:textField class="input_field_right numericCurrency" name="bankCharge" value="${bankCharge}" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> Total Amount Due</span></td>
				<td class="input_width"><g:textField class="input_field numeric_fifteen right" readonly="readonly" name="totalAmountDue"/></td>
			</tr>
			<tr>
				<td class="long_width"><span class="field_label"> Amount of Payment<span class="asterisk">* </span></span></td>
				<td class="input_width"><g:textField class="input_field_right" name="amountOfPayment"/></td>
			</tr>
		</table>
		<br />
		<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges" />
		<br/>
		<span class="title_label">Payment Summary</span>
		<div class="grid_wrapper">
			<table id="grid_list_payment_cdt"></table>
		<%--	<div id="grid_pager_pay_duties_and_taxes"></div>--%>
		</div>
		<table class="tabs_forms_table">
			<tr>
				<td class="label_width"><span class="field_label"> Total Amount of Payment </span></td>
				<td class="input_width"><g:textField class="input_field_right" readonly="readonly" name="totalAmountOfPayment" value="200.00"/></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> Document Number </span></td>
				<td class="input_width"><g:textField class="input_field numeric_fifteen right" name="documentNumber" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> CDT Transaction</span><br /><span class="field_label">Reference Number </span></td>
				<td class="input_width"><g:textField class="input_field numeric_fifteen right" readonly="readonly" name="cdtTransaction" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label"> CDT Payment</span><br /><span class="field_label">Reference Number </span></td>
				<td class="input_width"><g:textField class="input_field numeric_fifteen right" readonly="readonly" name="cdtpayment" /></td>
			</tr>
		</table>
		<br />
		<g:render template="../commons/popups/mode_of_payment_charges_popup" />
		<g:render template="../layouts/buttons_for_grid_wrapper" />
		<g:render template="../layouts/confirm_alert" />
		<g:render template="../layouts/alert" />
		<g:render template="../commons/popups/ec_login" />
		<g:render template="../commons/popups/reverse_button_confirmation" />
		
		</div>
	</div>
  </body>
</html>