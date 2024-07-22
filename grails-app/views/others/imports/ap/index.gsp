<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System - ${title} </title>
    <script type="text/javascript">
        var serviceType = '${serviceType}';

        var referenceType = '${referenceType}';
        // for wiring purpose
        documentType = '${documentType}';
        var documentClass = '${documentClass}';
        documentSubType1 = '${documentSubType1}';
        documentSubType2 = '${documentSubType2}';

        var loggedInUser='${session['group']}';
        var userRole='${session.userrole.id}';
        var docStatus='${status}';
        var tradeServiceIdHolder = '${tradeServiceId}';

        var formId = "#basicDetailsTabForm";

        var gotoUrl;
        var saveUrl;
        var uploadDocumentUrl;
        var updateUrl;
        var deleteDocumentUrl;
        var updateStatusUrl;
        var addRemarksUrl;
        var attachedDocumentsUrl;
        var downloadDocumentUrl;

        var computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
        var computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';
        var recomputeUrl = '${g.createLink(controller: "recompute", action: "recompute")}';
        var recomputeCurrencyUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency')}';

        var payUrl;
        var verifyOfficerPasswordUrl = '${g.createLink(controller:'payment', action:'loginOfficer')}';
        var checkCasaBalanceUrl = '${g.createLink(controller:'payment', action:'validateCasaTransactionAmount')}';
        var errorCorrectUrl = '${g.createLink(controller:'payment', action:'errorCorrectPayment')}';
        var reversePaymentUrl = '${g.createLink(controller:'payment', action:'reversePayment')}';
        var errorCorrectTfsUrl = '${g.createLink(controller:'payment', action:'errorCorrectTfsPayment')}';

        var createLoanUrl = '${g.createLink(controller:'payment', action:'createLoan')}';
        var getLoanErrorsUrl = '${g.createLink(controller:'payment', action:'getLoanApplicationErrors')}';
        var inquireLoanUrl = '${g.createLink(controller:'payment', action:'inquireLoanStatus')}';
        var updateLoanUrl = '${g.createLink(controller:'payment', action:'updateLoan')}';
        var reverseLoanUrl = '${g.createLink(controller:'payment', action:'reverseLoan')}';


        //Auto Complete
        var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
        var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
        var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
        var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
        

        var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
        var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
        var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
        var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';
        var modeOfPaymentUrl = '${g.createLink(controller:"modeOfPayment", action: "viewModesOfPayment")}';

        if(referenceType == "ETS") {
            if(serviceType.toUpperCase() == "REFUND" && documentClass.toUpperCase() == "AP") {
                saveUrl = '${g.createLink(controller: "apEtsRefund", action: "saveRefundEts")}';
                gotoUrl = '${g.createLink(controller:'apEtsRefund', action:'viewRefundEts')}';
                updateUrl = '${g.createLink(controller:'apEtsRefund', action:'updateRefundEts')}';
                updateStatusUrl = '${g.createLink(controller:'apEtsRefund', action:'updateEtsStatus')}';
                
                attachedDocumentsUrl = '${g.createLink(controller:'apEtsRefund', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
                downloadDocumentUrl = '${g.createLink(controller:'apEtsRefund', action:'downloadFile')}';
		        uploadDocumentUrl = '${g.createLink(controller:'apEtsRefund', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'apEtsRefund', action:'deleteDocument')}';
            }
        } else if(referenceType == "DATA_ENTRY") {            
            if(serviceType.toUpperCase() == "SETUP" && documentClass.toUpperCase() == "AP") {
                saveUrl = '${g.createLink(controller: "apDataEntrySetup", action: "saveSetupDataEntry")}';
                gotoUrl = '${g.createLink(controller:'apDataEntrySetup', action:'viewSetupDataEntry')}';
                updateUrl = '${g.createLink(controller:'apDataEntrySetup', action:'updateSetupDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'apDataEntrySetup', action:'updateDataEntryStatus')}';

                attachedDocumentsUrl = '${g.createLink(controller:'apDataEntrySetup', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
                downloadDocumentUrl = '${g.createLink(controller:'apDataEntrySetup', action:'downloadFile')}';
		        uploadDocumentUrl = '${g.createLink(controller:'apDataEntrySetup', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'apDataEntrySetup', action:'deleteDocument')}';
            } else if(serviceType.toUpperCase() == "APPLY" && documentClass.toUpperCase() == "AP") {
                saveUrl =  '${g.createLink(controller: "apDataEntryApply", action: "saveApplicationDataEntry")}';
                gotoUrl = '${g.createLink(controller:'apDataEntryApply', action:'viewSetupDataEntry')}';
                updateUrl = '${g.createLink(controller:'apDataEntryApply', action:'updateApplicationDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'apDataEntryApply', action:'updateDataEntryStatus')}';

                attachedDocumentsUrl = '${g.createLink(controller:'apDataEntryApply', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
                downloadDocumentUrl = '${g.createLink(controller:'apDataEntryApply', action:'downloadFile')}';
		        uploadDocumentUrl = '${g.createLink(controller:'apDataEntryApply', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'apDataEntryApply', action:'deleteDocument')}';
            } else if(serviceType.toUpperCase() == "REFUND" && documentClass.toUpperCase() == "AP") {
                saveUrl =  '${g.createLink(controller: "apDataEntryRefund", action: "saveRefundDataEntry")}';
                gotoUrl = '${g.createLink(controller:'apDataEntryRefund', action:'viewRefundDataEntry')}';
                updateUrl = '${g.createLink(controller:'apDataEntryRefund', action:'updateRefundDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'apDataEntryRefund', action:'updateDataEntryStatus')}';

                attachedDocumentsUrl = '${g.createLink(controller:'apDataEntryRefund', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
                downloadDocumentUrl = '${g.createLink(controller:'apDataEntryRefund', action:'downloadFile')}';
		        uploadDocumentUrl = '${g.createLink(controller:'apDataEntryRefund', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'apDataEntryRefund', action:'deleteDocument')}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'apDataEntryRefund', action:'errorCorrectPayment')}';--}%
            }
            var _viewMode = '${viewMode}';
        	var hasRoute='${hasRoute}';
        }


        $(window).load(function() {
            if (${session.userrole.id.contains("TSD") && !(session.userrole.id.equals("TSDM"))}) {
                disableAllFields();
            }
        });

        function disableAllFields() {
            $("#body_forms :input").each(function () {
                if ($(this).attr("type") == "button") {
                    if ($(this).attr("id") != undefined && $(this).attr("id") != null) {
                        if ($(this).attr("id").indexOf("btnReturnChecker") == -1 &&
                                $(this).attr("id").indexOf("btnPreApprove") == -1 &&
                                $(this).attr("id").indexOf("btnCheck") == -1 &&
                                $(this).attr("id").indexOf("btnPostApprove") == -1 &&
                                $(this).attr("id").indexOf("btnReturnApprover") == -1 &&
                                $(this).attr("id").indexOf("btnApprove") == -1) {
                            $(this).attr("disabled", "disabled");
                        }
                    } else {
                        $(this).attr("disabled", "disabled");
                    }
                } else {
                    if ($(this).attr("type") == "checkbox") {
                        $(this).attr("disabled", "disabled");
                    } else if ($(this).prop("type") == "select-one") {
                        var id = $(this).attr("name");

                        if (!id) {
                            id = $(this).attr("id");
                        }

                        if (id != "routeTo") {
                            $(this).attr("disabled", "disabled");
                        }
                    } else if ($(this).prop("type") == "radio") {
                        var id = $(this).attr("name");

                        if (id) {
                            $("input[type=radio][name=" + id + "]").attr("disabled", "disabled");
                        } else {
                            id = $(this).attr("id");

                            $("input[type=radio][id=" + id + "]").attr("disabled", "disabled");
                        }
                    } else {
                        if ($(this).is(":hidden") == false) {
                            $(this).attr("disabled", "disabled");
                        }
                    }

                    // disable all auto complete
                    if ($(this).attr("class") != undefined && $(this).attr("class") != null) {
                        if ($(this).attr("class").indexOf("select2")) {
                            $(this).select2("disable");
                        }
                    }
                }
            });

            $("#body_forms a").each(function() {
                if ($(this).attr("class").indexOf("add_btn") != -1) {
                    $(this).hide();
                }
            });
        }
    </script>
    <g:javascript src="popups/alert_utility.js" />
    <g:javascript src="utilities/commons/textarea_utility.js" />
    <g:javascript src="popups/mode_of_payment_charges_popup.js" />
    <g:javascript src="utilities/commons/ets_index_utility.js" />
    <g:javascript src="popups/ets_opening_header_utility.js" />
    <g:javascript src="utilities/dataentry/initialize_forms.js" />
	<%-- <g:javascript src="new/mode_of_payment_utils.js" /> --%>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
    <g:render template="../layouts/header"/>

    <g:render template="../layouts/accordion" />

    <div id="body_forms">
        <div id="body_forms_header">
            <div id="header_details">
                <h3 class="header_details_title" id="longNameDisplay"> ${longName} </h3> <g:hiddenField name="longName" value="${longName}" />
                <h3 class="header_details_title" id="address1Display"> ${address1} </h3> <g:hiddenField name="address1" value="${address1}" />
                <h3 class="header_details_title" id="address2Display"> ${address2} </h3> <g:hiddenField name="address2" value="${address2}" />
			<g:hiddenField name="firstName" value="${firstName}"/>
			<g:hiddenField name="middleName" value="${middleName}"/>
			<g:hiddenField name="lastName" value="${lastName}"/>
			<g:hiddenField name="tinNumber" value="${tinNumber}"/>
			<g:hiddenField name="officerCode" value="${officerCode}"/>
			<g:hiddenField name="exceptionCode" value="${exceptionCode}"/>
                <br /><br /><br />
            </div>
            <g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
            <table id="header_details2">
                <tr>
                    <td><span class="field_label"> CIF Number <span class="asterisk">*</span></span> </td>
                    <td>
                        <g:textField name="cifNumber" value="${cifNumber}" class="input_field textFormat-7 required" readonly="readonly" />
                        <g:if test="${serviceType?.equalsIgnoreCase("SETUP")}">
                            <a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a>
                        </g:if>
                    </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> CIF Name </span> </td>
                    <td> <g:textField name="cifName" value="${cifName}" class="input_field textFormat-20" readonly="readonly" /> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> Account Officer </span> </td>
                    <td> <g:textField name="accountOfficer" value="${accountOfficer}" class="input_field" readonly="readonly" /> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField name="ccbdBranchUnitCode" value="${ccbdBranchUnitCode}" class="input_field textFormat-3" readonly="readonly" /> </td>
                </tr>
            </table>
        </div>
        <div id="tab_container">
            <ul id="tabs">
                <li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details <br/> &#160;</span></a></li>
                <li><a href="#attached_documents_tab" id="attachedDocumentsTab"><span class="tab_titles"> Attached<br/>Documents </span></a></li>
                <g:if test="${documentClass?.equalsIgnoreCase('AP') && serviceType?.equalsIgnoreCase("REFUND")}">
                <li class="cash_lc_payment_tab"><a href="#cash_lc_payment_tab" id="cashLcPaymentTab"><span class="tab_titles">Charges<br/>Refund</span></a></li>
                </g:if>
                <li><a href="#instructions_routing_tab" id="instructionsRoutingTab"><span class="tab_titles"> Instructions and Routing <br/> &#160;</span></a></li>
            </ul>


            <div id="basic_details_tab">
                <form id="basicDetailsTabForm">
                    <g:if test="${documentClass?.equalsIgnoreCase('AP')}">
                        <g:if test="${serviceType?.equalsIgnoreCase("SETUP")}">
                            <g:render template="../others/imports/ap/dataentry/setup/basic_details_tab" />
                        </g:if>
                        <g:if test="${serviceType?.equalsIgnoreCase("APPLY")}">
                            <g:render template="../others/imports/ap/dataentry/apply/basic_details_tab" />
                        </g:if>
                        <g:if test="${serviceType?.equalsIgnoreCase("REFUND")}">
                            <g:render template="../others/imports/ap/ets/refund/basic_details_tab" />
                        </g:if>
                        %{--<g:render template="../others/imports/ap/ets/basic_details_tab" />--}%
                    </g:if>
                    %{--<g:else>--}%
                    %{--<g:render template="../others/imports/md/collection/basic_details_tab" />--}%
                    %{--</g:else>--}%
                </form>
            </div>
		
			<div id="attached_documents_tab">
					<g:render template="../commons/tabs/attached_documents_tab"/>			
	        </div>
        
            <g:if test="${documentClass?.equalsIgnoreCase('AP') && serviceType?.equalsIgnoreCase("REFUND")}">
            <div id="cash_lc_payment_tab">
                <form id="cashLcPaymentTabForm">
                    <g:render template="../others/imports/ap/ets/refund/product_payment_tab" />
                </form>
            </div>
            </g:if>

            <div id="instructions_routing_tab">
                <form id="instructionsAndRoutingTabForm">
                    <g:render template="../commons/tabs/instructions_and_routing_tab" />
                </form>
            </div>
        </div>
    </div>

    <g:render template="../layouts/confirm_alert" />
    <g:render template="../layouts/alert" />
    <g:render template="../commons/popups/mode_of_payment_charges_popup" />

    <g:render template="../commons/popups/create_transaction_popup" />
    <g:render template="../commons/popups/create_ua_popup" />
    <g:render template="../commons/popups/create_ets_popup" />
    <g:render template="../commons/popups/create_non_lc_popup" />
    <g:render template="../commons/popups/loan_errors_popup"/>

	<g:javascript src="new/override_authorization_utils.js" />
      <g:render template="/commons/popups/override_authorization"
                model="[overrideAuthDivId: 'payAuthorizeDiv',
                        overrideAuthDivBg: 'payAuthorizeBg',
                        overrideAuthUsernameId: 'payAuthorizeUsername',
                        overrideAuthPasswordId: 'payAuthorizePassword',
                        overrideAuthConfirmId: 'payAuthorizeConfirm',
                        overrideAuthCancelId: 'payAuthorizeCancel',
                        overrideAuthCasaPaymentId: 'payAuthorizeCasaId'
                ]"/>

      <g:render template="/commons/popups/override_authorization"
                model="[overrideAuthDivId: 'unpayAuthorizeDiv',
                        overrideAuthDivBg: 'unpayAuthorizeBg',
                        overrideAuthUsernameId: 'unpayAuthorizeUsername',
                        overrideAuthPasswordId: 'unpayAuthorizePassword',
                        overrideAuthConfirmId: 'unpayAuthorizeConfirm',
                        overrideAuthCancelId: 'unpayAuthorizeCancel',
                        overrideAuthCasaPaymentId: 'unpayAuthorizeCasaId'
                ]"/>

    <g:render template="../commons/popups/cif_search_popup" />
</body>
</html>