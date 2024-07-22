<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> Trade Finance System - ${title} </title>
<meta name="layout" content="${referenceType != 'ETS' ? 'main_loading' : 'main_ets' }" />
<g:if test="${windowed}">
<g:javascript src="utilities/ets/commons/window_utility.js" />
</g:if>
<g:javascript src="grids/payment_jqgrid.js"/>
<g:javascript src="popups/ets_opening_header_utility.js" />
<g:if test="${referenceType != 'DATA_ENTRY' }">
<g:javascript src="popups/mode_of_payment_charges_popup.js" />
</g:if>
<g:javascript src="popups/cif_normal_search_popup.js" />
<g:javascript src="utilities/nonlc/index_utilities.js" />
<g:javascript src="utilities/commons/ets_index_utility.js" />
<g:javascript src="popups/alert_utility.js" />
<g:javascript src="utilities/nonlc/nonlc_tabs_utility.js" />
<g:javascript src="utilities/commons/textarea_utility.js" />
<g:javascript src="popups/bank_address_popup.js" />

<script type="text/javascript">

    var serviceType = '${serviceType}';
	
	var referenceType = '${referenceType}';
	// for wiring purpose	
	var documentType = '${documentType}';
	var documentClass = '${documentClass}';
<%--	var documentSubType1 = '${documentSubType1}';--%>
<%--	var documentSubType2 = '${documentSubType2}';--%>
<%--	var etsNumberHolder = '${serviceInstructionId}';--%>
	var tradeServiceIdHolder = '${tradeServiceId}';
	var loggedInUser='${session['group']}';
	var userRole='${session.userrole.id}';
	var docStatus='${status}';
	var title = '${title}';
	var _viewMode="TSDM" != '${session['userrole']['id']}' && "BRANCH" != '${session['group']}' && 'true' != '${title.contains('Data Entry')}' ? "viewMode" :'${viewMode}';
	var hasRoute='${hasRoute}';
    if("TSDM" != '${session['userrole']['id']}' && "BRANCH" != '${session['group']}' && _viewMode != 'viewMode'){
    	hasRoute='true';
	}
	var formId = "#basicDetailsTabForm";
<%--	var gotoUrl;--%>
	var saveUrl;
	var uploadDocumentUrl;
	var updateUrl;
	var payUrl;
	var deleteDocumentUrl;
	var downloadDocumentUrl; 
	var updateStatusUrl;

	var computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';

	var computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

	var attachedDocumentsUrl;

	var createLoanUrl = '${g.createLink(controller:'payment', action:'createLoan')}';
	var updateLoanUrl = '${g.createLink(controller:'payment', action:'updateLoan')}';
	var inquireLoanUrl = '${g.createLink(controller:'payment', action:'inquireLoanStatus')}';
	var errorCorrectUrl = '${g.createLink(controller:'payment', action:'errorCorrectPayment')}';
	var reversePaymentUrl = '${g.createLink(controller:'payment', action:'reversePayment')}';
	var errorCorrectTfsUrl = '${g.createLink(controller:'payment', action:'errorCorrectTfsPayment')}';
	var inquireLoanStatusUrl = '${g.createLink(controller:'payment', action:'getLoanStatus')}';
	var reverseLoanUrl = '${g.createLink(controller:'payment', action:'reverseLoan')}';

  	//Auto Complete
    var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
    var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
    var autoCompleteCountryIsoUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountryIso')}';
    var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
    var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
    
    var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
    var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
    var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
    var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';

    var recomputeUrl = '${g.createLink(controller: 'recompute', action: 'recomputeCharge')}';
    var recomputeCurrencyUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency')}';
    var recomputeCurrencyComplicatedUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_NON_LC_SETTLEMENT')}';
    var recomputeCurrencyNON_LC_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_NON_LC_SETTLEMENT_NEW')}';
    var recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION')}';
    var checkCasaBalanceUrl = '${g.createLink(controller:'payment', action:'validateCasaTransactionAmount')}';

    var modeOfPaymentUrl = '${g.createLink(controller:"modeOfPayment", action: "viewModesOfPayment", params: [currency: currency])}';
    var verifyOfficerPasswordUrl = '${g.createLink(controller:'payment', action:'loginOfficer')}';
    var importerCbCodeUrl = '${g.createLink(controller:'cif', action:'searchCbCodeByCif')}';

    
    if(referenceType == "ETS") {
		if(serviceType.toUpperCase() == 'SETTLEMENT') {
	        saveUrl = '${g.createLink(controller: "daEtsSettlement", action: "saveSettlementEts")}';
	        updateUrl = '${g.createLink(controller: "daEtsSettlement", action: "updateSettlementEts")}';
	        updateStatusUrl = '${g.createLink(controller: "daEtsSettlement", action: "updateEtsStatus")}';
	        uploadDocumentUrl = '${g.createLink(controller: "daEtsSettlement", action: "uploadDocument")}';
	        downloadDocumentUrl = '${g.createLink(controller:'daEtsSettlement', action:'downloadFile')}';
	        deleteDocumentUrl = '${g.createLink(controller:'daEtsSettlement', action:'deleteDocument')}';
        }
        attachedDocumentsUrl = '${g.createLink(controller: "daEtsSettlement", action: "viewAttachments", params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
    } else if(referenceType == "DATA_ENTRY") {
        if(serviceType.toUpperCase() == "NEGOTIATION ACCEPTANCE") {
            saveUrl = '${g.createLink(controller: "daDataEntryNegotiationAcceptance", action: "saveNegotiationAcceptanceDataEntry")}';
            updateUrl = '${g.createLink(controller: "daDataEntryNegotiationAcceptance", action: "updateNegotiationAcceptanceDataEntry")}';
            updateStatusUrl = '${g.createLink(controller: "daDataEntryNegotiationAcceptance", action: "updateDataEntryStatus")}';
        } else if(serviceType.toUpperCase() == "NEGOTIATION ACKNOWLEDGEMENT") {
            saveUrl = '${g.createLink(controller: "daDataEntryNegotiationAcknowledgement", action: "saveNegotiationAcknowledgementDataEntry")}';
            updateUrl = '${g.createLink(controller: "daDataEntryNegotiationAcknowledgement", action: "updateNegotiationAcknowledgementDataEntry")}';
            updateStatusUrl = '${g.createLink(controller: "daDataEntryNegotiationAcknowledgement", action: "updateDataEntryStatus")}';
        } else if(serviceType.toUpperCase() == "SETTLEMENT") {
            saveUrl = '${g.createLink(controller: "daDataEntrySettlement", action: "saveSettlementDataEntry")}';
            updateUrl = '${g.createLink(controller: "daDataEntrySettlement", action: "updateSettlementDataEntry")}';
            updateStatusUrl = '${g.createLink(controller: "daDataEntrySettlement", action: "updateDataEntryStatus")}';
            uploadDocumentUrl = '${g.createLink(controller: "daDataEntrySettlement", action: "uploadDocument")}';
            downloadDocumentUrl = '${g.createLink(controller:'daDataEntrySettlement', action:'downloadFile')}';
            deleteDocumentUrl = '${g.createLink(controller:'daDataEntrySettlement', action:'deleteDocument')}';
	        attachedDocumentsUrl = '${g.createLink(controller: "daDataEntrySettlement", action: "viewAttachments", params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
        } else if(serviceType.toUpperCase() == "CANCELLATION") {
            saveUrl = '${g.createLink(controller: "daDataEntryCancellation", action: "saveCancellationDataEntry")}';
            updateUrl = '${g.createLink(controller: "daDataEntryCancellation", action: "updateCancellationDataEntry")}';
            updateStatusUrl = '${g.createLink(controller: "daDataEntryCancellation", action: "updateDataEntryStatus")}';
        }
    } else if(referenceType == "PAYMENT") {
        if(serviceType.toUpperCase() == 'SETTLEMENT') {
        	gotoUrl = '${g.createLink(controller:'daChargesSettlement', action:'viewSettlementCharges')}';
            updateUrl = '${g.createLink(controller:'daChargesSettlement', action:'updateSettlementCharges')}';

            computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
            computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

            payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
        }
    }
    var createLoanUrl = '${g.createLink(controller:'payment', action:'createLoan')}';
    var getLoanErrorsUrl = '${g.createLink(controller:'payment', action:'getLoanApplicationErrors')}';
    formId = "#basicDetailsTabForm"

	<%--used by attched documents jqgrid--%>

    $(document).ready(function() {
        $(formId).change(function() {
            formChanged = formId;
            formIsChanged = true;
        });

    });
</script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap" <g:if test="${windowed}">class="window"</g:if> >
			
	<%-- HEADER --%>
	<g:render template="../layouts/header"/>

	<%-- ACCORDION --%>
	<g:if test="${!windowed}">
	    <g:render template="../layouts/accordion"/>
	</g:if>
	
	<g:if test="${referenceType.equalsIgnoreCase('ETS')}">
		<g:render template="../nonlc/commons/nonlc_ets_tabs" />
	</g:if>
	
	<g:elseif test="${referenceType.equalsIgnoreCase('DATA_ENTRY')}">
		<g:render template="../nonlc/da/dataentry/content" />
	</g:elseif>
	
	<g:elseif test="${referenceType.equalsIgnoreCase('PAYMENT')}">
		<g:render template="../nonlc/commons/nonlc_payment_tabs" />
	</g:elseif>
</div>
<g:render template="../commons/popups/cif_search_normal" />
<g:render template="../commons/popups/cif_search_popup" />
<g:if test="${referenceType != 'DATA_ENTRY' }">
<g:render template="../commons/popups/mode_of_payment_charges_popup" />
</g:if>
<g:render template="/commons/popups/loan_details_popup"/>
<g:render template="/commons/popups/facility_id_popup"/>
<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />
<g:render template="../commons/popups/create_non_lc_popup" />

<g:render template="../commons/popups/facility_id_popup"/>

<g:render template="../commons/popups/bank_address_popup" />
<g:render template="../commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />

<g:render template="../layouts/confirm_alert" />
<g:render template="../layouts/confirm_alert_cancel" />

<g:render template="/layouts/loading" />

<g:render template="../layouts/alert_confirmation" model="${[popupId:'popup_cancel_basic_details',popupTitle:'Save Basic Details',
  popupMessage:'Do you want to save your changes?<br/>'+ 
  	'If Yes, save data then redirect to Unacted<br/>'+
  	'If No, resets data then redirect to Unacted<br/>'+
  	'If Close, disregard this popup' ,includeCancel:true,yesBtnId:'yesBtnBD',noBtnId:'noBtnBD',cancelBtnId:'cancelBtnBD'] }"/>
<g:render template="../layouts/alert" />

%{--<g:if test="${(session.dataEntryModel?.status != null && session.dataEntryModel?.status == 'FOR_REVERSAL') || (session.chargesModel?.status != null && session.chargesModel?.status == 'FOR_REVERSAL')}">--}%
    <script>
        if (typeof forReversal != "undefined" && forReversal) {
            $('#btnReturnEtsToBranch').removeClass();
            $('#btnPreApprove').removeClass();
            $('.actionWidget').hide();
            $('#btnReturnEtsToBranch').hide();
            $('#btnPreApprove').hide();
        }

        if (typeof reversalDE != "undefined" && reversalDE) {
            $('#btnReturnEtsToBranch').removeClass();
            $('#btnPreApprove').removeClass();
            $('.actionWidget').hide();
            $('#btnReturnEtsToBranch').hide();
            $('#btnPreApprove').hide();

            <%-- $('#payTransactionBtn').hide(); --%>

            $('#btnApprove').show();
            $('#btnCheck').show();
            $('#btnPrepare').show();
            $('#routeToLabel').show();
            $('#routeToLabel2').show();
            $('#routeTo').show();
        }
    </script>
%{--</g:if>--}%
</body>
</html>