<%--
   (revision)
   SCR/ER Number: 
   SCR/ER Description: 
   [Created by:] Cedrick C. Nungay
   [Date revised:] September 18, 2018
   [Date deployed:]
   Program [Revision] Details: Added autoCompleteFormOfUndertakingUrl, autoCompleteFunctionOfMessageUrl
       and autoCompleteFileIdentificationUrl for MT759
   PROJECT: WEB
   MEMBER TYPE  : Groovy Server Pages (GSP)
   Project Name: outgoing_mt.gsp
--%>
<g:applyLayout name="main">
    <html>
        <head>
            <script type="text/javascript">
                var formName = '${formName}';
                var formId="#basicDetailsTabForm";
                //Auto Complete
                var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
                var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
                var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
                var autoCompleteRmaBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteRmaBanks')}';
                var autoCompleteDepositoryBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteDepositoryBanks')}';
                var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
                var autoCompletePurposeOfMessageUrl = '${g.createLink(controller:'autoComplete', action:'autoCompletePurposeOfMessage')}';
                var autoCompleteFormOfUndertakingUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteFormOfUndertaking')}';
                var autoCompleteFunctionOfMessageUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteFunctionOfMessage')}';
                var autoCompleteFileIdentificationUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteFileIdentification')}';
                var saveInitialMtDetailsUrl = '${g.createLink(controller:'outgoingMt', action:'saveOutgoingMt')}';
                var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
                var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
                var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';
                var unactedTransactionsUrlBranch = '${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
                var unactedTransactionsUrlTsd = '${g.createLink(controller:'unactedTransactions', action:'viewUnactedTsd')}';

                var serviceType = 'CREATE';
                var saveOutgoingMtUrl = '${g.createLink(controller:'outgoingMt', action:'saveOutgoingMt')}';
                var generateOutgoingMtUrl = '${g.createLink(controller:'swift', action:'generateSwiftMessage')}';
                var _viewMode = '${viewMode}';
                var documentNumber = '${details?.documentNumber ?:
										details?.transactionReferenceNumber ?:
										details?.documentNumberMt799 ?:
										details?.lcNumber }';
            </script>
            <g:javascript src="utilities/commons/autocomplete_utility.js"/>
            <g:javascript src="utilities/other_imports/mt/outgoing/outgoing_mt_utility.js"/>
            <g:pageProperty name="page.additionalResources"/>
        </head>
        <body style="visibility: hidden;" onload="js_Load()">
        <div id="outer_wrap">
        	<g:pageProperty name="page.header"/>
            <g:render template="../layouts/accordion" />
            <div id="body_forms">
                <div id="tab_container">
                    <ul id="tabs">
                        <li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> MT Details </span></a></li>

                        <li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
                    </ul>

                    <g:form name="basicDetailsTabForm" controller="outgoingMt" action="saveOutgoingMt">
			            <g:hiddenField name="documentClass" value="MT" />
			            <g:hiddenField name="serviceType" value="CREATE" />
                        <g:hiddenField name="tsdInitiated" value="true"/>
                        <g:hiddenField name="existingDocumentNumber" value="${details?.documentNumber ?:
										details?.transactionReferenceNumber ?:
										details?.documentNumberMt799 ?:
										details?.lcNumber}"/>
                        <div id="basic_details_tab">
                            <g:pageProperty name="page.basicDetails"/>
                        </div>
                    </g:form>
    
                    <g:form name="instructionsAndRoutingTabForm" controller="outgoingMt" action="routeMtMessage">
                        <g:hiddenField name="commandName" value="${status}" />
                        <g:hiddenField name="routeOutgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%--Used for routing--%>
                        <div id="instructions_tab">
                            <g:render template="/commons/tabs/instructions_and_routing_tab" />
                        </div>
                    </g:form>
                </div>
            </div>
        </div>
            <g:hiddenField name="userrole" value="${(session['userrole']) ? session['userrole']['id'] : ""}" />

            <g:javascript src="utilities/commons/textarea_utility.js" />
            <g:render template="../layouts/alert" />
            <g:render template="../layouts/confirm_alert" />
            <g:render template="../commons/popups/view_mt_popup"/>
<%--			<g:javascript src="popups/alert_utility.js"/>--%>
            <g:javascript src="utilities/other_imports/mt/outgoing/outgoing_mt_disabler.js"/>
            <g:javascript src="numeric-utils.js"/>
        </body>
    </html>
</g:applyLayout>