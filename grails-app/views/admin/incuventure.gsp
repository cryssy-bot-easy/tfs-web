<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="admin" />
    <%@ page import="net.ipc.utils.DateUtils" %>
    <title>Trade Finance System</title>
    <style type="text/css">
    .duration {font-size: 18px; font-weight: bold; color:#000040;}
    .big_label_red {font-size: 18px; font-weight: bold; color: red}
    .batch_button {background: url(../images/button_affirmative_b.png) no-repeat; width: 64px; border: none; font-size: 13px; font-weight: bold; margin: 1px 1em; padding: 0 0 2px 2px; text-align: left; height: 21px;}
    .batch_button:HOVER {background-position: 0 -21px;}
    .batch_button:ACTIVE {background-position: 0 -42px;}
    span#welcome{font-size:1.2em;font-weight:bold;}
    span.failed{color:red}
    span.success{color:green}
    div.duration_category>label{font-size: 13px; font-weight: bold;padding-left:1em;}
    div.duration_category span{font-style:italic;padding-left:1.5em;display:block;}
    </style>
    <g:javascript src="pop_up.js"/>


</head>
<body style="visibility: hidden;">

<div id="outer_wrap">

    <%-- HEADER --%>
    <g:render template="/layouts/header"/>

    <div id="navigation">
        <div id="Accordion1" class="Accordion">
            <div class="AccordionPanel">
                <div class="AccordionPanelTab panelHome" id="accordpanel_home">Incuventure Tools Home</div>
                <div class="AccordionPanelContent">
                    <ul>
                        <li><a href="<g:createLink controller="incuventureAdmin"/>">Accounting Entry Upload</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div id="body_forms">
        <span id="welcome">IPC Admin Tools</span>
        <br/><br/><br/>
        <form action="index.gsp"></form>
            <div id="successDiv">
            <label class="duration">Accounting</label>
            <g:form name="accountingUploadForm" id="accountingUploadForm" method="POST" controller="incuventureAdmin" action="uploadDocument" enctype="multipart/form-data" >
                <table class="tabs_forms_table">
                    <tr>
                        <td><span class="field_label"> File Location </span> </td>
                        <td><input class="input_field_file" type="file" name="fileLocation" id="fileLocation"/>
                            <input type="hidden" name="fileDirectory"/>
                        </td>
                    </tr>
                    <tr> <%-- BUTTON --%>
                        <td/>
                        <td>
                            <g:submitButton name="Upload" class="input_button2 button_override"  />
                            %{--<input type="button" value="Upload" id="uploadAttachedFile" class="input_button2 button_override" />--}%
                        </td>
                    </tr>
                </table> <%-- End of SEARCH Form--%>
                <br/>
            </g:form>
            <g:textField class="input_field" name="cifToBeSearched" />
            <input type="button" value="Generate CIF List" id="generateCifList" class="input_button_long" />
            </div>
            


        <g:render template="../layouts/loading"/>
    </div>
</div>


<script>
    $(function(){

        $("#generateCifList").click(function(){
    		location.href = '${g.createLink(controller:'incuventureAdmin', action:'generateCifList')}?cifToBeSearched='+$("#cifToBeSearched").val();
        });
        $("#generateDailyInterface").click(function(){
            centerPopup("loading_div", "loading_bg");
            loadPopup("loading_div", "loading_bg");

            var batchUrl = '${g.createLink(controller:'batch', action:'interfaceFiles')}';

            $.getJSON(batchUrl,function(data){
                disablePopup("loading_div", "loading_bg");

                if(data.errors){
                    $.each($("div#interface span"),function(idx,val){
                        if($.inArray($(this).text(),data.errors) != -1){
                            $(this).text($(this).text() + " failed").addClass("failed");
                        }
                    });
                }

                $.each($("div#interface span"),function(idx,val){
                    if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
                        $(this).text($(this).text() + " success").addClass("success");
                    }
                });

            }).fail(function(){
                        disablePopup("loading_div", "loading_bg");
                        alert("failed to call interface method");
                    });
        });

		$("#generateSibsInterface").click(function(){
            centerPopup("loading_div", "loading_bg");
            loadPopup("loading_div", "loading_bg");
            
            var batchUrl = '${g.createLink(controller:'batch', action:'sibsInterfaceFiles')}';
            
            $.getJSON(batchUrl,function(data){
                disablePopup("loading_div", "loading_bg");

                if(data.errors){
                    $.each($("div#interface span"),function(idx,val){
                        if($.inArray($(this).text(),data.errors) != -1){
                            $(this).text($(this).text() + " failed").addClass("failed");
                        }
                    });
                }

                $.each($("div#interface span"),function(idx,val){
                    if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
                        $(this).text($(this).text() + " success").addClass("success");
                    }
                });

            }).fail(function(){
                        disablePopup("loading_div", "loading_bg");
                        alert("Failed to call SIBS interface method");
                    });
        });

		$("#generateYearEndInterface").click(function(){
            centerPopup("loading_div", "loading_bg");
            loadPopup("loading_div", "loading_bg");
            
            var batchUrl = '${g.createLink(controller:'batch', action:'yearEndInterfaceFiles')}';
            
            $.getJSON(batchUrl,function(data){
                disablePopup("loading_div", "loading_bg");

                if(data.errors){
                    $.each($("div#interface span"),function(idx,val){
                        if($.inArray($(this).text(),data.errors) != -1){
                            $(this).text($(this).text() + " failed").addClass("failed");
                        }
                    });
                }

                $.each($("div#interface span"),function(idx,val){
                    if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
                        $(this).text($(this).text() + " success").addClass("success");
                    }
                });

            }).fail(function(){
                        disablePopup("loading_div", "loading_bg");
                        alert("Failed to call Year End interface method");
                    });
        });
		
        $("#generateDailyBatchReports").click(function(){
            centerPopup("loading_div", "loading_bg");
            loadPopup("loading_div", "loading_bg");

            var sysDate = new Date('${DateUtils.shortDateFormat(new Date())}');
            var year = sysDate.getFullYear();
            var month = sysDate.getMonth();
            var day = sysDate.getDate();
            var currentDate = (month+1) + '/' + day + '/' + year;

            var procUnitCode = '909';

            var batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:'genericReports', action:'getJSONBatch')}';
            batchUrl+="?callback=?";

            $.getJSON(batchUrl,{duration:'daily',inv:'batch',onlineReportDate:currentDate,onlineReportPuc:procUnitCode},function(data){
                disablePopup("loading_div", "loading_bg");

                if(data.errors){
                    $.each($("div#daily span"),function(idx,val){
                        if($.inArray($(this).text(),data.errors.split(",")) != -1){
                            $(this).text($(this).text() + " failed").addClass("failed");
                        }
                    });
                }

                $.each($("div#daily span"),function(idx,val){
                    if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
                        $(this).text($(this).text() + " success").addClass("success");
                    }
                });

            }).fail(function(){
                        disablePopup("loading_div", "loading_bg");
                        alert("failed to call daily batch reports method");
                    });

        });

        $("#generateWeeklyBatchReports").click(function(){
            centerPopup("loading_div", "loading_bg");
            loadPopup("loading_div", "loading_bg");

            var sysDate = new Date('${DateUtils.shortDateFormat(new Date())}');
            var year = sysDate.getFullYear();
            var month = sysDate.getMonth();
            var day = sysDate.getDate();
            var currentDate = (month+1) + '/' + day + '/' + year;

            var procUnitCode = '909';

            var batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:'genericReports', action:'getJSONBatch')}';
            batchUrl+="?callback=?";

            $.getJSON(batchUrl,{duration:'weekly',inv:'batch',onlineReportDate:currentDate,onlineReportPuc:procUnitCode},function(data){
                disablePopup("loading_div", "loading_bg");

                if(data.errors){
                    $.each($("div#weekly span"),function(idx,val){
                        if($.inArray($(this).text(),data.errors.split(",")) != -1){
                            $(this).text($(this).text() + " failed").addClass("failed");
                        }
                    });
                }

                $.each($("div#weekly span"),function(idx,val){
                    if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
                        $(this).text($(this).text() + " success").addClass("success");
                    }
                });

            }).fail(function(){
                        disablePopup("loading_div", "loading_bg");
                        alert("failed to call daily batch reports method");
                    });

        });

        $("#generateMonthlyBatchReports").click(function(){
            centerPopup("loading_div", "loading_bg");
            loadPopup("loading_div", "loading_bg");

            var sysDate = new Date('${DateUtils.shortDateFormat(new Date())}');
            var year = sysDate.getFullYear();
            var month = sysDate.getMonth();
            var day = sysDate.getDate();
            var currentDate = (month+1) + '/' + day + '/' + year;

            var procUnitCode = '909';

            var batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:'genericReports', action:'getJSONBatch')}';
            batchUrl+="?callback=?";

            $.getJSON(batchUrl,{duration:'monthly',inv:'batch',onlineReportDate:currentDate,onlineReportPuc:procUnitCode},function(data){
                disablePopup("loading_div", "loading_bg");

                if(data.errors){
                    $.each($("div#monthly span"),function(idx,val){
                        if($.inArray($(this).text(),data.errors.split(",")) != -1){
                            $(this).text($(this).text() + " failed").addClass("failed");
                        }
                    });
                }

                $.each($("div#monthly span"),function(idx,val){
                    if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
                        $(this).text($(this).text() + " success").addClass("success");
                    }
                });

            }).fail(function(){
                        disablePopup("loading_div", "loading_bg");
                        alert("failed to call daily batch reports method");
                    });

        });
    });

    function generateDailyBatchReports(){
        alert("generateDailyBatchReports");
    }

    function generateWeeklyBatchReports(){
        alert("generateWeeklyBatchReports");
    }

    function generateMonthlyBatchReports(){
        alert("generateMonthlyBatchReports");
    }

    function generateReport() {

        var batchProcessingFlag = $('input[name=batchProcessingFlag]:checked').val();
        // alert(batchProcessingFlag);

        if (batchProcessingFlag != null && batchProcessingFlag != '') {

            var sysDate = new Date('${DateUtils.shortDateFormat(new Date())}');
            var year = sysDate.getFullYear();
            var month = sysDate.getMonth();
            var day = sysDate.getDate();
            var currentDate = (month+1) + '/' + day + '/' + year;

            var procUnitCode = '909';
            var batchUrl = '';

            if (batchProcessingFlag == 'revertToPending') {

                batchUrl = '${g.createLink(controller:'batch', action:'interfaceFiles', params:[batchProcessingFlag:'revertToPending'])}';

            } else if (batchProcessingFlag == 'expireLcs') {

                batchUrl = '${g.createLink(controller:'batch', action:'interfaceFiles', params:[batchProcessingFlag:'expireLcs'])}';

            } else if (batchProcessingFlag == 'purgeEts') {

                batchUrl = '${g.createLink(controller:'batch', action:'interfaceFiles', params:[batchProcessingFlag:'purgeEts'])}';

            } else if (batchProcessingFlag == 'abortPendingEtsReversal') {

                batchUrl = '${g.createLink(controller:'batch', action:'interfaceFiles', params:[batchProcessingFlag:'abortPendingEtsReversal'])}';

            } else if (batchProcessingFlag == 'glMovement') {

                batchUrl = '${g.createLink(controller:'batch', action:'interfaceFiles', params:[batchProcessingFlag:'glMovement'])}';

            } else if (batchProcessingFlag == 'dailySummaryAccountingEntries') {

                //for View Payment Accounting Entries
                batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:'genericReports', action:'runDailySummaryOfAccountingEntries')}';
                batchUrl += ('?inv=batch&batchProcessingFlag='+batchProcessingFlag+'&onlineReportDate='+currentDate+'&onlineReportPuc='+procUnitCode);

            } else if (batchProcessingFlag == 'amlaReportedTransactions') {

                batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runTradeServicesAMLAReportedTransactions")}';
                batchUrl += ('?inv=batch&batchProcessingFlag='+batchProcessingFlag+'&onlineReportDate='+currentDate+'&onlineReportPuc='+procUnitCode);

            } else if (batchProcessingFlag == 'fxNonLcNegotiatedYear') {

                batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runFxNonLcsNegoForTheYear")}';
                batchUrl += ('?inv=batch&batchProcessingFlag='+batchProcessingFlag+'&branchUnitCode='+procUnitCode);

            } else if (batchProcessingFlag == 'dmNonLcNegotiatedYear') {

                batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runDmNonLcsNegoForTheYear")}';
                batchUrl += ('?inv=batch&batchProcessingFlag='+batchProcessingFlag+'&branchUnitCode='+procUnitCode);

            } else if (batchProcessingFlag == 'fxOutstandingIb') {

                batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingInwardBillsForCollectionFxDaDpPerCurrency")}';
                batchUrl += ('?inv=batch&batchProcessingFlag='+batchProcessingFlag+'&branchUnitCode='+procUnitCode);

            } else if (batchProcessingFlag == 'dmOutstandingIb') {

                batchUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutstandingInwardBillsForCollectionDmDaDpPerCurrency")}';
                batchUrl += ('?inv=batch&batchProcessingFlag='+batchProcessingFlag+'&branchUnitCode='+procUnitCode);
            }

            // alert(batchUrl)
            if (batchUrl != '') {
                location.href=batchUrl;
            }

        } else {
            alert('Please select an action to execute.');
        }
    }
</script>

</body>
</html>
