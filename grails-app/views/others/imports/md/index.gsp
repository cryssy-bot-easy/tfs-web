<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <title> Trade Finance System - ${title} </title>
    <g:javascript src="popups/mode_of_payment_charges_popup.js" />
    <g:javascript src="utilities/commons/textarea_utility.js" />
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

      	//Auto Complete
        var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
        var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
        var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
        var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';

        var modeOfPaymentUrl = '${g.createLink(controller:"modeOfPayment", action: "viewModesOfPayment")}';

        var _viewMode = '${viewMode}';
		var hasRoute = '${hasRoute}';
		if("TSDM" != '${session['userrole']['id']}' && "BRANCH" != '${session['group']}' && _viewMode != 'viewMode'){
			hasRoute = 'true';
		}
		
        var formId = "#basicDetailsTabForm";

        var gotoUrl;
        var saveUrl;
        var uploadDocumentUrl;
        var updateUrl;
        var deleteDocumentUrl;
        var updateStatusUrl;
        var addRemarksUrl;

        var getRerma;

        var computeTotalUrl;
        var computeBalanceUrl;

        var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
        var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
        var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
        var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';

        var paymentStatusUrl = '${g.createLink(controller:'mdDataEntryCollection', action:'getPaymentStatus')}';
        var createLoanUrl = '${g.createLink(controller:'payment', action:'createLoan')}';
        var getLoanErrorsUrl = '${g.createLink(controller:'payment', action:'getLoanApplicationErrors')}';
        var inquireLoanUrl = '${g.createLink(controller:'payment', action:'inquireLoanStatus')}';
        var errorCorrectUrl = '${g.createLink(controller:'mdDataEntryCollection', action:'errorCorrectPayment')}';
        var reversePaymentUrl = '${g.createLink(controller:'payment', action:'reversePayment')}';
        var errorCorrectTfsUrl = '${g.createLink(controller:'payment', action:'errorCorrectTfsPayment')}';
        var reverseLoanUrl = '${g.createLink(controller:'payment', action:'reverseLoan')}';
        var checkCasaBalanceUrl = '${g.createLink(controller:'payment', action:'validateCasaTransactionAmount')}';
        var verifyOfficerPasswordUrl = '${g.createLink(controller:'payment', action:'loginOfficer')}';
        var findPnNumberByDocumentNumber = '${g.createLink(controller: "mdDataEntryApplication" , action: "getPnNumber")}';

        if(referenceType == "ETS") {
            if(serviceType == "Collection") {
                gotoUrl = '${g.createLink(controller:'mdEtsCollection', action:'viewCollectionEts')}';
                saveUrl =  '${g.createLink(controller: "mdEtsCollection", action: "saveCollectionEts")}';
                updateUrl = '${g.createLink(controller:'mdEtsCollection', action:'updateCollectionEts')}';
                updateStatusUrl = '${g.createLink(controller:'mdEtsCollection', action:'updateEtsStatus')}';

                var payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
            } else if(serviceType == "Application") {
                gotoUrl = '${g.createLink(controller:'mdEtsApplicationRefund', action:'viewApplicationRefundEts')}';
                saveUrl =  '${g.createLink(controller: "mdEtsApplicationRefund", action: "saveApplicationRefundEts")}';
                updateUrl = '${g.createLink(controller:'mdEtsApplicationRefund', action:'updateApplicationRefundEts')}';
                updateStatusUrl = '${g.createLink(controller:'mdEtsApplicationRefund', action:'updateEtsStatus')}';
            }
        } else if(referenceType == "DATA_ENTRY") {
            if(serviceType == "Collection") {
                gotoUrl = '${g.createLink(controller:'mdDataEntryCollection', action:'viewCollectionDataEntry')}';
                updateUrl = '${g.createLink(controller:'mdDataEntryCollection', action:'updateCollectionDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'mdDataEntryCollection', action:'updateDataEntryStatus')}';

                var payUrl = '${g.createLink(controller:'payment', action:'payItem')}';

            } else if(serviceType == "Application") {
                if(documentType == "REFUND") {
                    gotoUrl = '${g.createLink(controller:'mdDataEntryApplicationRefund', action:'viewApplicationRefundDataEntry')}';
                    saveUrl =  "";
                    updateUrl = '${g.createLink(controller:'mdDataEntryApplicationRefund', action:'updateApplicationRefundDataEntry')}';
                    updateStatusUrl = '${g.createLink(controller:'mdDataEntryApplicationRefund', action:'updateDataEntryStatus')}';
                    var payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                } else if(documentType == "APPLICATION") {
                    gotoUrl = '${g.createLink(controller:'mdDataEntryApplication', action:'viewApplicationDataEntry')}';
                    saveUrl =  '${g.createLink(controller:'mdDataEntryApplication', action:'saveApplicationDataEntry')}';
                    updateUrl = '${g.createLink(controller:'mdDataEntryApplication', action:'updateApplicationDataEntry')}';
                    updateStatusUrl = '${g.createLink(controller:'mdDataEntryApplication', action:'updateDataEntryStatus')}';
                }
            }
        }

    </script>
    <g:javascript src="popups/alert_utility.js" />
<%--    <g:javascript src="popups/mode_of_payment_charges_popup.js" />--%>
    <g:javascript src="utilities/other_imports/md/initialize_forms_basic_md_collection.js" />

    <g:javascript src="utilities/other_imports/md/basic_details_collection_md.js" />
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
            <table id="header_details2">
                <tr>
                    <td><span class="field_label"> CIF Number </span> </td>
                    <td><g:textField name="cifNumber1" value="${cifNumber}" class="input_field textFormat-7" readonly="readonly" /> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> CIF Name </span> </td>
                    <td> <g:textField name="cifName1" value="${cifName}" class="input_field textFormat-20" readonly="readonly" /> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> Account Officer </span> </td>
                    <td> <g:textField name="accountOfficer1" value="${accountOfficer}" class="input_field" readonly="readonly" /> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
                    <td> <g:textField name="ccbdBranchUnitCode1" value="${ccbdBranchUnitCode}" class="input_field textFormat-3" readonly="readonly" /> </td>
                </tr>
            </table>
        </div>
        <div id="tab_container">
            <ul id="tabs">
                <li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details <br/> &#160;</span></a></li>
                <g:if test="${serviceType?.equalsIgnoreCase('Collection')}">
                    <li><a href="#payment_tab" id="paymentDetailsTab"><span class="tab_titles"> Payment Details <br/> &#160;</span></a></li>
                </g:if>
                <g:if test="${serviceType?.equalsIgnoreCase('Application') && documentType?.equalsIgnoreCase('Refund')}">
                    <li><a href="#payment_tab" id="paymentDetailsTab"><span class="tab_titles"> MD Refund Details <br/> &#160;</span></a></li>
                </g:if>
                <li><a href="#instructions_routing_tab" id="instructionsRoutingTab"><span class="tab_titles"> Instructions and Routing <br/> &#160;</span></a></li>
            </ul>

                <div id="basic_details_tab">
                    <form id="basicDetailsTabForm">
                        <g:if test="${serviceType?.equalsIgnoreCase('Application')}">
                            <g:if test="${documentType?.equalsIgnoreCase('REFUND')}">
                                <g:render template="../others/imports/md/application/refund/basic_details_tab" />
                            </g:if>
                            <g:if test="${documentType?.equalsIgnoreCase('APPLICATION')}">
                                <g:render template="../others/imports/md/application/basic_details_tab" />
                            </g:if>
                        </g:if>
                        <g:else>
                            <g:render template="../others/imports/md/collection/basic_details_tab" />
                        </g:else>
                    </form>
                </div>

            <g:if test="${serviceType?.equalsIgnoreCase('Collection')}">
                    <div id="payment_tab">
                        <form id="paymentDetailsTabForm">
                            <g:render template="../commons/tabs/cash_lc_payment_tab" />
                        </form>
                    </div>
            </g:if>
			<g:if test="${serviceType?.equalsIgnoreCase('Application') && documentType?.equalsIgnoreCase('Refund')}">
			        <div id="payment_tab">
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
    %{--<g:render template="/commons/popups/override_confirmation"/>--}%

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

    <g:render template="/layouts/loading" />
</body>
</html>