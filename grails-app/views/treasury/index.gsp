<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <%@ page import="net.ipc.utils.DateUtils" %>
    <title>Trade Finance System</title>
	<style type="text/css">
    	.treasury_button {background: url(../images/button_affirmative_b.png) no-repeat; border: none; font-size: 13px; font-weight: bold; margin: 1px 1em; padding: 2px 1.5em 3px 2px; text-align: left; height: 21px; float:right;}
    	.treasury_button:HOVER {background-position: 0 -21px;}
    	.treasury_button:ACTIVE {background-position: 0 -42px;}
    	span#welcome{font-size:1.5em;font-weight:bold;}
    	span#treasury_title{font-style: italic;font-weight:bold;font-size:1.2em;float:left;}
		table#treasury_table{border-collapse: collapse;}
		table#treasury_table td{padding: 0.5em 0;}
    </style>
    <script>
    	var dailyForeignRegularLcOpenedUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyForeignRegularLcOpened")}';
    	var dailyForeignCashLcOpenedUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyForeignCashLcOpened")}';
    	var dailyOutstandingForeignLcUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyOutstandingForeignLc")}';
    	var dailyFundingUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDailyFunding")}';
    	var WeeklyReport_on_MaturingusanceLCurl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runWeeklyReportOnMaturingUsancLc")}';
    </script>
    <g:javascript src="pop_up.js"/>
    
</head>
<body style="visibility: hidden;">
    <div id="outer_wrap">
        <%-- HEADER --%>
        <g:render template="/layouts/header"/>
        <div id="navigation">
            <div id="Accordion1" class="Accordion">
                <div class="AccordionPanel">
                    <div class="AccordionPanelTab panelHome" id="accordpanel_home">Home</div>
                    <div class="AccordionPanelContent">
                        <ul>
                            <li><a href="<g:createLink controller="treasury"/>">Treasury Reports Generation</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div id="body_forms">
        	<span id="welcome">Treasury Reports Generation Module</span>
        	<br/>
        	<br/>
        	<br/>
        	<table id="treasury_table">
        		<tr>
        			<td><span id="treasury_title">Generate Daily Foreign Regular LC Opened Report</span></td>
        			<td><input type="button" class="treasury_button" value="Execute" 
        			onclick="openDailyForeignRegularLcOpenedPopUp()"/></td>	
        		</tr>
        		<tr>
        			<td><span id="treasury_title">Generate Daily Foreign Cash LC Opened Report</span></td>
        			<td><input type="button" class="treasury_button" value="Execute" 
        			onclick="openDailyForeignCashLcOpenedPopUp()"/></td>
        		</tr>
        		<tr>
        			<td><span id="treasury_title">Generate Daily Outstanding Foreign LC Report</span></td>
        			<td><input type="button" class="treasury_button" value="Execute" 
        			onclick="openDailyOutstandingForeignLcPopUp()"/></td>
        		</tr>
        		<tr>
        			<td><span id="treasury_title">Generate Daily Funding Report</span></td>
        			<td><input type="button" class="treasury_button" value="Execute" 
        			onclick="openDailyFundingReportPopUp()"/></td>
        		</tr>
        		<tr>
        			<td><span id="treasury_title">Generate Weekly Report on Maturing Usance LC</span></td>
        			<td><input type="button" class="treasury_button" value="Execute" id="weeklyMaturingUsanceReport"/></td>
        		</tr>
        	</table>
			<g:render template="../layouts/loading"/>
			<g:render template="../commons/popups/online_reports_popup"/>
			<g:render template="../commons/popups/batch_processing_unit_code"/>
        </div>
    </div>    
    <g:javascript src="report/batches/online/generateDailyForeignRegularLcOpened.js"/>
    <g:javascript src="report/batches/online/generateDailyForeignCashLcOpened.js"/>
    <g:javascript src="report/batches/online/generateDailyOutstandingForeignLc.js"/>
    <g:javascript src="report/batches/online/generateDailyFundingReport.js"/>
    <g:javascript src="report/batches/fxlc/generateWeeklyReportonMaturingUsanceLcs.js"/>
    <g:javascript src="report/batches/processingUnitCode.js"/>
</body>
</html>