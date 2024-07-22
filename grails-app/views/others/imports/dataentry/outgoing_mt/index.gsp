<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="net.ipc.utils.DateUtils" %>
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="main" />
    <script type="text/javascript">
        var referenceType = '${referenceType}';
        var serviceType = '${serviceType}';
        var documentType = '${documentType}';
        var documentClass = '${documentClass}';
        var username = '${username}';
        //Auto Complete
        var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
        var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
        var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
        var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
        <%--			var gotoUrl;--%>
        <%--			var saveUrl;--%>
        <%--			var uploadDocumentUrl;--%>
        <%--			var updateUrl;--%>
        <%--			var deleteDocumentUrl;--%>
        var updateStatusUrl = '${g.createLink(controller:'outgoingMt', action:'saveOutgoingMt')}';
        var windowed = ${windowed ?: false};
        var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
    </script>
    <g:javascript src="popups/alert_utility.js" />
    <g:javascript src="utilities/other_imports/commons/initialize_forms.js" />
    <g:javascript src="utilities/commons/textarea_utility.js"/>
    <g:javascript src="select2.js"/>
    <g:javascript src="utilities/commons/autocomplete_utility.js"/>
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
    <g:render template="../layouts/header"/>
    <g:render template="../layouts/accordion" />
    <div id="body_forms">
        <div id="body_forms_header">
            <table id="header_details" class="tabs_form_table">
                <tr>
                    <td class="label_width"> <span class="field_label"> Document Number </span> </td>
                    <td class="input_width"> <g:textField name="documentNumber" class="input_field"/> </td>
                </tr>
                <tr>
                    <td>&#160;</td>
                </tr>
                <tr>
                    <td> <span class="field_label"> Transaction Type </span> </td>
                    <td>
                        <g:radioGroup name="transactionTypeFlag" labels="['RTGS Peso','Foreign']" values="['P','F']">
                            ${it.radio}&#160;&#160;&#160;<g:message code="${it.label}" />
                        </g:radioGroup>
                    </td>
                </tr>
                <tr>
                    <td>&#160;</td>
                </tr>
                <tr>
                    <td> <span class="field_label"> SWIFT Address </span> </td>
                    <td>
                        <g:select name="swiftAddress" from="${['SWIFT Code 1', 'SWIFT Code 2', 'SWIFT Code N']}" class="select_dropdown" noSelection="['':'Select One']"/>
                    </td>
                </tr>
            </table>
            <table id="header_details2">
                <tr>
                    <td> <span class="field_label"> Date </span> </td>
                    <td> <g:textField name="outgoingMtDate" class="input_field" readonly="readonly"  value="${DateUtils.shortDateFormat(new Date())}"/> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> Funding Number </span> </td>
                    <td> <g:textField name="fundingNumber" class="input_field"/> </td>
                </tr>
                <tr>
                    <td> <span class="field_label"> Destination </span> </td>
                    <td> <g:textField name="outgoingMtDestination" class="input_field" readonly="readonly" /> </td>
                </tr>
            </table>
        </div>
        <div id="tab_container">
            <ul>
                <li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> MT Details </span></a></li>

                <li><a href="#instructions_tab" id="instructionsTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
            </ul>

            <g:form id="mtDetailsTabForm">
            <%-- TAB BASIC DETAILS --%>
                <div id="basic_details_tab">
                    <g:if test="${'103'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt103/mt_details_tab" />
                    </g:if>
                    <g:if test="${'199'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt199/mt_details_tab" />
                    </g:if>
                    <g:if test="${'202'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt202/mt_details_tab" />
                    </g:if>
                    <g:if test="${'299'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt299/mt_details_tab" />
                    </g:if>
                    <g:if test="${'499'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt499/mt_details_tab" />
                    </g:if>
                    <g:if test="${'742'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt742/mt_details_tab" />
                    </g:if>
                    <g:if test="${'752'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt752/mt_details_tab" />
                    </g:if>
                    <g:if test="${'799'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt799/mt_details_tab" />
                    </g:if>
                    <g:if test="${'999'.equalsIgnoreCase(referenceType)}">
                        <g:render template="../others/imports/dataentry/outgoing_mt/mt999/mt_details_tab" />
                    </g:if>
                </div>
            </g:form>
            <g:form id="instructionsAndRoutingTabForm">
                <div id="instructions_tab">
                    <g:render template="/commons/tabs/instructions_and_routing_tab" />
                </div>
            </g:form>

        </div> <%-- End of TABS --%>

    </div>
</div>

<g:render template="../commons/popups/mode_of_payment_charges_popup" />
<g:render template="../layouts/confirm_alert" />
<g:render template="../layouts/alert" />
%{--<g:render template="../commons/popups/ec_login" />--}%
%{--<g:render template="../commons/popups/reverse_button_confirmation" />--}%
<g:render template="../commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />

%{--<g:render template="../commons/popups/cif_search_popup" />--}%
%{--<g:render template="../others/commons/popups/other_import_charges_payment_popup"/>--}%
%{--<g:render template="../others/commons/popups/partial_amount_refund_popup"/>--}%
</body>
</html>