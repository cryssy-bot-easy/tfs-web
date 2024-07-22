<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<%@ page import="net.ipc.utils.DateUtils" %>
		<title><g:layoutTitle default="Trade Finance System"/></title>
		
		<g:javascript library="jquery"/>
        <r:layoutResources />
        <%--<g:javascript src="jquery-1.8.1.min.js" />--%>

        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'styles.css')}" type="text/css" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.custom.css')}" type="text/css" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'ui.jqgrid.css')}" type="text/css" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'SpryAccordion.css')}" type="text/css" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'blank_styles.css')}" type="text/css" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}" type="text/css" />
        <style>
            @font-face {
              font-family: 'Lato';
              font-style: normal;
              src: url("${resource(dir: 'fonts', file: 'Lato-Regular.ttf')}");
            }
        </style>

        <script type="text/javascript">

            var formName = '${formName}';
            //Auto Complete
            var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
            var autoCompleteClientUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteClient')}';
            var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
            var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
            var autoCompleteLocalBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteLocalBanks')}';
            var autoCompleteRmaBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteRmaBanks')}';
            var autoCompleteDepositoryBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteDepositoryBanks')}';
            var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';

            var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';
            var autoCompleteDomesticProductCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteDomesticProductCurrency')}';
            var autoCompleteDomesticSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteDomesticSettlementCurrency')}';

            var autoCompleteDigitalSignatoriesUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteDigitalSignatories')}';
            var autoCompleteCommodityCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCommodityCode')}';
            var autoCompleteParticularsUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteParticulars')}';
            var autoCompleteParticipantCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteParticipantCode')}';

            <g:if test="${(session.dataEntryModel?.status != null && session.dataEntryModel?.status == 'FOR_REVERSAL') || (session.chargesModel?.status != null && (session.chargesModel?.status == 'FOR_REVERSAL' || session.chargesModel?.status == 'REVERSED'))}">
                var forReversal=true;
            </g:if>
            <g:else>
                var forReversal=false;
            </g:else>

            <g:if test="${session.dataEntryModel?.reversalDENumber}">
                var reversalDE=true;
            </g:if>
            <g:else>
                var reversalDE=false;
            </g:else>

            var mindate = new Date('${DateUtils.shortDateFormat(new Date().next())}');
            var newDate = new Date('${DateUtils.shortDateFormat(new Date())}');

        </script>
        
        <script type="text/javascript">
        var postList = 0
        var hasFacilityPost = false;
	    $(document).ajaxSend(function(event, jqxhr, settings){
		    if(settings.url.indexOf("/tfs-web/facility/getFacilityBalanceRequest") == -1 &&
			    settings.url.indexOf("/tfs-web/facility/inquireFacilityBalance") == -1 ){
			    if(settings.url.indexOf("/tfs-web/recompute/recomputeCurrency") != -1){
		    		postList++;
		    		if(formId == "#instructionsAndRoutingTabForm" || formId == "#chargesTabForm"){
	        	    	mLoadPopup($("#loading_div"), $("#loading_bg"));
	        	        mCenterPopup($("#loading_div"), $("#loading_bg"));
	                }
			    }
	    	} else {
	    		hasFacilityPost = true;
	    	}
	    });
	    $(document).ajaxComplete(function(event, jqxhr, settings){
	    	if(settings.url.indexOf("/tfs-web/facility/getFacilityBalanceRequest") != -1 ||
	    			settings.url.indexOf("/tfs-web/facility/inquireFacilityBalance") != -1 ){
	    		hasFacilityPost = true;
	    	}
	    	if(settings.url.indexOf("/tfs-web/recompute/recomputeCurrency") != -1 && !hasFacilityPost){
		    	postList--
	    	}
		    if(postList == 0 && !hasFacilityPost && (formId == "#instructionsAndRoutingTabForm" || formId == "#chargesTabForm")){
	    		mDisablePopup($("#loading_div"), $("#loading_bg"));
		    }

		    if(hasFacilityPost){
			    hasFacilityPost = !hasFacilityPost
		    }
	    });
	    $(document).ajaxStop(function(){
	    	if(hasFacilityPost){
			    hasFacilityPost = !hasFacilityPost
		    }
<%--		    if(postList > 0){--%>
<%--	    		mDisablePopup($("#loading_div"), $("#loading_bg"));--%>
<%--	    		postList = 0;--%>
<%--		    }--%>
	    });
	    $(function(){
            $("#instructionsRoutingTab").click(function (){
            	if(postList > 0){
        	    	mLoadPopup($("#loading_div"), $("#loading_bg"));
        	        mCenterPopup($("#loading_div"), $("#loading_bg"));
                }
            });
    	});
	    </script>

		<g:layoutHead/>
    </head>
	<body style="visibility: hidden;" onload="js_Load()">

        <g:render template="../product/commons/popups/create_export_bills_transaction" />
        <g:render template="../product/commons/popups/create_export_bills_transaction_tsd" />

		<g:layoutBody/>
        
        <g:hiddenField name="userrole" value="${(session['userrole']) ? session['userrole']['id'] : ""}" />
        
		<%--HIDDEN FIELD FOR DATEPICKER IMAGE--%>
        <g:hiddenField name="_datepickerImage" value="${createLinkTo(dir:'images',file:'calendar.png')}" />
        
        <g:javascript src="dialog.js"/>
        <g:javascript src="pop_up.js"/>


        <%-- <g:javascript src="jquery-ui-1.8.custom.min.js"/> --%>
        <g:javascript src="jquery-ui-1.9.0.custom.min.js"/>
        <g:javascript src="left_navi_accordion.js"/>
        <g:javascript src="SpryAccordion.js"/>
        <g:javascript src="tabs.js"/>
        <g:javascript src="grid.locale-en.js"/>
        <g:javascript src="jquery.jqGrid.min.js"/>
        <g:javascript src="jclock.js"/>
        <g:javascript src="jclock_class.js"/>
        <g:javascript src="jqgrid-utils.js"/>
        <g:javascript src="css_browser_selector.js"/>
        <g:javascript src="autoNumeric.js"/>
        <g:javascript src="jq-quickvalidate.js"/>
		<g:javascript src="json_parse.js" />
		<g:javascript src="json_parse_state.js" />
		<g:javascript src="json2.js" />
        <g:javascript src="numeric-utils.js" />
        <g:javascript src="guid_generator.js" />
        <g:javascript src="numeric_formats.js" />
        <g:javascript src="list-utils.js" />
        <g:javascript src="datepicker.js"/>
        <g:javascript src="fouc.js"/>
	    <g:javascript src="form_onload_serializer.js"/>
        
        <g:javascript src="tabs-utils.js" />
        <g:javascript src="select2.js"/>

        <g:javascript src="jquery.blockUI.js"/>
        <g:javascript src="utilities/commons/autocomplete_utility.js"/>
<%--        <g:javascript src="utilities/commons/number_padding_utility.js"/>--%>
        
		<%--must be always below any other js, to disable fields --%>
        <g:javascript src="utilities/commons/view_mode_utility.js" /> 
        <r:layoutResources />
	</body>
</html>