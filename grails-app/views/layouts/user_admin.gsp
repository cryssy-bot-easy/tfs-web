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

        <script type="text/javascript">
	    $(document).ajaxStart(function(){
	    	mLoadPopup($("#loading_div"), $("#loading_bg"));
	        mCenterPopup($("#loading_div"), $("#loading_bg"));
	    });
	    $(document).ajaxStop(function(){
	    	mDisablePopup($("#loading_div"), $("#loading_bg"));
	    });
	    </script>

		<g:layoutHead/>
    </head>
	<body style="visibility: hidden;" onload="js_Load()">


		<g:layoutBody/>
        
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
        <g:javascript src="numeric_formats.js" />
        <g:javascript src="datepicker.js"/>
        <g:javascript src="fouc.js"/>

        <r:layoutResources />
	</body>
</html>