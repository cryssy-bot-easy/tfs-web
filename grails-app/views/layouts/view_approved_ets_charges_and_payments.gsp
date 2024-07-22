<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main_ets" />
<title>Trade Finance System - ${title}</title>
</head>
<body>
<div id="outer_wrap">
<%-- HEADER --%>
<g:render template="../layouts/header"/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<span class="title_label">Principal Payment</span>
<br/><br/>
<div class="grid_wrapper">
	<table class="foreign_exchange approvedEtsPaymentsReadonly" border="1">
		<tr>
			<th>Account Number</th>
			<th>PN Number</th>
			<th>Mode of Payment</th>
			<th>Settlement Currency</th>
			<th>Amount (in Settlement Currency)</th>
		</tr>
		<g:each in="${approvedEtsProductPayment}" >
			<tr>
				<td>${(it?.approvedEtsProductPaymentReferenceNumber.toString().equals('0') || it?.approvedEtsProductPaymentPaymentInstrumentType.toString().equals('REMITTANCE')) ? '' : it?.approvedEtsProductPaymentReferenceNumber}</td>
				<td>${it?.approvedEtsProductPaymentPnNumber}</td>
				<td>${it?.approvedEtsProductPaymentPaymentInstrumentType}</td>
				<td>${it?.approvedEtsProductPaymentCurrency}</td>
				<td align="right"><g:textField name="${it?.approvedEtsProductPaymentPaymentInstrumentTypeAmount}" value="${it?.approvedEtsProductPaymentAmount}" readonly="readonly"/></td>
			</tr>
		</g:each>
	</table>
</div>
<br/><br/>
<span class="title_label">Proceeds Summary</span>
<br/><br/>
<div class="grid_wrapper">
	<table class="foreign_exchange approvedEtsPaymentsReadonly" border="1">
		<tr>
			<th>Mode of Settlement</th>
			<th>Settlement Currency</th>
			<th>Amount (in Negotiation Currency)</th>
		</tr>
		<g:each in="${approvedEtsProceedsPayment}" >
			<tr>
				<td>${it?.approvedEtsProceedsPaymentPaymentInstrumentType}</td>
				<td>${it?.approvedEtsProceedsPaymentCurrency}</td>
				<td align="right"><g:textField name="${it?.approvedEtsProceedsPaymentPaymentInstrumentTypeAmount}" value="${it?.approvedEtsProceedsPaymentAmount}" readonly="readonly"/></td>
			</tr>
		</g:each>
	</table>
</div>
<br/><br/>
<span class="title_label">Charges</span>
<br/><br/>
<table class="charges_table">
	<g:each in="${approvedEtsCharges}" >
		<tr>
			<td class="label_width"><span class="field_label">${it?.approvedEtsChargeDisplayName}</span></td>
			<td><span class="charges_currency">${it?.approvedEtsChargeOriginalCurrency}</span></td>
			<td><g:textField name="${it?.approvedEtsChargeIdAmount}" class="input_field_right" value="${it?.approvedEtsChargeOriginalAmount}" readonly="readonly"/></td>
		</tr>
	</g:each>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td><span class="field_label">Total Amount Charges</span></td>
		<td><span class="charges_currency">${settlementCurrency}</span></td>
		<td><g:textField name="totalAmountChargesEtsApproved" class="input_field_right" value="${totalAmountCharges}" readonly="readonly"/></td>
	</tr>
</table>
<br/><br/>
<span class="title_label">Charges Payment</span>
<br/><br/>
<div class="grid_wrapper">
	<table class="foreign_exchange approvedEtsPaymentsReadonly" border="1">
		<tr>
			<th>Account Number</th>
			<th>Mode of Payment</th>
			<th>Settlement Currency</th>
			<th>Amount (in Settlement Currency)</th>
		</tr>
		<g:each in="${approvedEtsServicePayment}" >
			<tr>
				<td>${(it?.approvedEtsServicePaymentReferenceNumber.toString().equals('0') || it?.approvedEtsServicePaymentPaymentInstrumentType.toString().equals('REMITTANCE'))  ? '' : it?.approvedEtsServicePaymentReferenceNumber}</td>
				<td>${it?.approvedEtsServicePaymentPaymentInstrumentType}</td>
				<td>${it?.approvedEtsServicePaymentCurrency}</td>
				<td align="right"><g:textField name="${it?.approvedEtsServicePaymentPaymentInstrumentTypeAmount}" value="${it?.approvedEtsServicePaymentAmount}" readonly="readonly"/></td>
			</tr>
		</g:each>
	</table>
</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	// formats the amount
	
	// product payment
	$("#APproductAmountEtsApproved").val(formatCurrency($("#APproductAmountEtsApproved").val()));
	$("#ARproductAmountEtsApproved").val(formatCurrency($("#ARproductAmountEtsApproved").val()));
	$("#CASAproductAmountEtsApproved").val(formatCurrency($("#CASAproductAmountEtsApproved").val()));
	$("#CASHproductAmountEtsApproved").val(formatCurrency($("#CASHproductAmountEtsApproved").val()));
	$("#CHECKproductAmountEtsApproved").val(formatCurrency($("#CHECKproductAmountEtsApproved").val()));
	$("#EBPproductAmountEtsApproved").val(formatCurrency($("#EBPproductAmountEtsApproved").val()));
	$("#IBT_BRANCHproductAmountEtsApproved").val(formatCurrency($("#IBT_BRANCHproductAmountEtsApproved").val()));
	$("#MDproductAmountEtsApproved").val(formatCurrency($("#MDproductAmountEtsApproved").val()));
	$("#REMITTANCEproductAmountEtsApproved").val(formatCurrency($("#REMITTANCEproductAmountEtsApproved").val()));
	$("#TR_LOANproductAmountEtsApproved").val(formatCurrency($("#TR_LOANproductAmountEtsApproved").val()));

	// proceeds payment
	$("#CASAproceedsAmountEtsApproved").val(formatCurrency($("#CASAproceedsAmountEtsApproved").val()));
	$("#IBT_BRANCHproceedsAmountEtsApproved").val(formatCurrency($("#IBT_BRANCHproceedsAmountEtsApproved").val()));
	$("#MC_ISSUANCEproceedsAmountEtsApproved").val(formatCurrency($("#MC_ISSUANCEproceedsAmountEtsApproved").val()));
	$("#PDDTSproceedsAmountEtsApproved").val(formatCurrency($("#PDDTSproceedsAmountEtsApproved").val()));
	$("#REMITTANCEproceedsAmountEtsApproved").val(formatCurrency($("#REMITTANCEproceedsAmountEtsApproved").val()));
	$("#SWIFTproceedsAmountEtsApproved").val(formatCurrency($("#SWIFTproceedsAmountEtsApproved").val()));
	
	// charges
	$("#SUPamountEtsApproved").val(formatCurrency($("#SUPamountEtsApproved").val()));
	$("#REMITTANCEamountEtsApproved").val(formatCurrency($("#REMITTANCEamountEtsApproved").val()));
	$("#POSTAGEamountEtsApproved").val(formatCurrency($("#POSTAGEamountEtsApproved").val()));
	$("#OTHER-EXPORTamountEtsApproved").val(formatCurrency($("#OTHER-EXPORTamountEtsApproved").val()));
	$("#NOTARIALamountEtsApproved").val(formatCurrency($("#NOTARIALamountEtsApproved").val()));
	$("#INTERESTamountEtsApproved").val(formatCurrency($("#INTERESTamountEtsApproved").val()));
	$("#DOCSTAMPSamountEtsApproved").val(formatCurrency($("#DOCSTAMPSamountEtsApproved").val()));
	$("#COURIERamountEtsApproved").val(formatCurrency($("#COURIERamountEtsApproved").val()));
	$("#CORRES-EXPORTamountEtsApproved").val(formatCurrency($("#CORRES-EXPORTamountEtsApproved").val()));
	$("#CORRES-CONFIRMINGamountEtsApproved").val(formatCurrency($("#CORRES-CONFIRMINGamountEtsApproved").val()));
	$("#CORRES-ADVISINGamountEtsApproved").val(formatCurrency($("#CORRES-ADVISINGamountEtsApproved").val()));
	$("#CORRES-ADDITIONALamountEtsApproved").val(formatCurrency($("#CORRES-ADDITIONALamountEtsApproved").val()));
	$("#CILEXamountEtsApproved").val(formatCurrency($("#CILEXamountEtsApproved").val()));
	$("#CFamountEtsApproved").val(formatCurrency($("#CFamountEtsApproved").val()));
	$("#CANCELamountEtsApproved").val(formatCurrency($("#CANCELamountEtsApproved").val()));
	$("#CABLEamountEtsApproved").val(formatCurrency($("#CABLEamountEtsApproved").val()));
	$("#BSPamountEtsApproved").val(formatCurrency($("#BSPamountEtsApproved").val()));
	$("#BOOKINGamountEtsApproved").val(formatCurrency($("#BOOKINGamountEtsApproved").val()));
	$("#BCamountEtsApproved").val(formatCurrency($("#BCamountEtsApproved").val()));
	$("#ADVISING-EXPORTamountEtsApproved").val(formatCurrency($("#ADVISING-EXPORTamountEtsApproved").val()));
	$("#totalAmountChargesEtsApproved").val(formatCurrency($("#totalAmountChargesEtsApproved").val()));

	// services payment
	$("#APserviceAmountEtsApproved").val(formatCurrency($("#APserviceAmountEtsApproved").val()));
	$("#ARserviceAmountEtsApproved").val(formatCurrency($("#ARserviceAmountEtsApproved").val()));
	$("#CASAserviceAmountEtsApproved").val(formatCurrency($("#CASAserviceAmountEtsApproved").val()));
	$("#CASHserviceAmountEtsApproved").val(formatCurrency($("#CASHserviceAmountEtsApproved").val()));
	$("#CHECKserviceAmountEtsApproved").val(formatCurrency($("#CHECKserviceAmountEtsApproved").val()));
	$("#EBPserviceAmountEtsApproved").val(formatCurrency($("#EBPserviceAmountEtsApproved").val()));
	$("#IBT_BRANCHserviceAmountEtsApproved").val(formatCurrency($("#IBT_BRANCHserviceAmountEtsApproved").val()));
	$("#MDserviceAmountEtsApproved").val(formatCurrency($("#MDserviceAmountEtsApproved").val()));
	$("#REMITTANCEserviceAmountEtsApproved").val(formatCurrency($("#REMITTANCEserviceAmountEtsApproved").val()));
	$("#TR_LOANserviceAmountEtsApproved").val(formatCurrency($("#TR_LOANserviceAmountEtsApproved").val()));
});
</script>
<g:javascript src="utilities/ets/commons/window_utility.js" />
</body>
</html>