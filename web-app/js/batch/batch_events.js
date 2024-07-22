$(function(){

/*  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR IBD-16-0219-01
	SCR/ER Description: Generate CIC File
	[Revised by:] Jesse James Joson
	[Date Deployed:] 02/24/2016
	Program [Revision] Details: Add some methods that will call by UI to extract CIC file
	PROJECT: WEB
	MEMBER TYPE  : Javascript
	Project Name: batch_events.js
*/

	/*  PROLOGUE:
	 * 	(revision)
		SCR/ER Number: 
		SCR/ER Description: Reconnect to sibs counter
		[Revised by:] Allan Comboy Jr.
		[Date Deployed:] 06/07/2016
		Program [Revision] Details: Add a request to check if SIBS disconnection ocuur
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: batch_events.js
	*/
	
	/*  PROLOGUE:
	 * 	(revision)
		SCR/ER Number:  20160613-044 - 20160623-080
		SCR/ER Description: Program abnormally terminates during SIBS DB access time-out.
		[Revised by:] Allan Comboy Jr.
		[Date Deployed:]  06/14/2016 - 06/24/2016 
		Program [Revision] Details: to reconnect when disconnected to sibs (for 4 additional programs) -( 06/24/2016(CREDEX anf FORM 4) )
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: batch_events.js
	 */

	/*PROLOGUE:
	 * 	(revision)
		SCR/ER Number: ER# 20140909-038
		SCR/ER Description: CIF Normalization Not Working in TFS
		[Revised by:] Jesse James Joson
		[Date Created:] 08/05/2016
		Program [Revision] Details: The CIF Normalization was redesigned, since not all tables are normalized. Add method for the CIF Extraction.
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: batch_event.js
	 *
	 */

	/*PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: batch_event.js
	 *
	 */

	/*PROLOGUE:
	 * 	(revision)
		SCR/ER Number:
		SCR/ER Description:
		[Revised by:] Cedrick C. Nungay
		[Date Revised:] 09/29/2017
		Program [Revision] Details: Updated displaying result for processing batch for Process Rma Document
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: batch_event.js
	 *
	 */
	/*PROLOGUE:
	 * 	(revision)
		[Revised by:] Rafael T. Poblete
		[Date Revised:] 06/20/2018
		Program [Revision] Details: Added case and function to generate Schedule 2, Schedule 3, Schedule 4 report and exception.
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: batch_event.js
	 *
	 */

	/*PROLOGUE:
	 * 	(revision)
		[Revised by:] Crystiann Puso
		[Date Revised:] 02/22/2024
		Program [Revision] Details: Added case and function to process cicls and generate cicls file.
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: batch_event.js
	 *
	 */
	
	var batchId="";
	
	$(".batch_button").click(function(){
	var reportName = $("#adhoc_dropdown option:selected").val();
		batchId = $(this).attr("id");
		fieldIdToChangeTime = $(this).parents("div").attr("id");
		if(fieldIdToChangeTime == "adhoc"){
			fieldIdToChangeTime = "adHoc";
			$(".are_you_sure").text("Execute " + $("#adhoc_dropdown option:selected").text() + "?");
			//online_reports_popup.js
			if(reportName=="expiredAmla"){
				openAdhocBatchReportPopupBetween();
			}else if(reportName=="rerouteTradeServiceJob"){
				openReRouteApproverPopup();
			}else{
				openAdhocBatchReportPopup();
				
			}

		}else{
			$(".are_you_sure").text("Execute " + $("#" + fieldIdToChangeTime).siblings(".duration").text() +
					" " + $(this).siblings("label").text() + "?");
			showConfirmPopup(); 
		}
	});
	
	$("#btnAlertConfirm").click(function(){
		
		mDisablePopup($("#popup_save_confirmation"),$("#confirmation_background"));
		var reportName="";
		if(batchId != "generateAdhoc"){
			//disable button
			$("#"+batchId).attr("disabled","disabled");
		}else{
			reportName= $("#adhoc_dropdown option:selected").text();
		}
		setTimeStart(fieldIdToChangeTime,reportName);
		switch(batchId){
			case "generateDailyAmlaInterface":
				generateDailyAmlaInterface();
				break;
			case "executeCifNormalization":
				executeCifNormalization();
				break;
            case "executeCloningLnappf":
                executeCloneLnappf();
                break;
            case "executePopulateCasaAccounts":
                executePopulateCasaAccounts();
                break;
			case "generateGlis":
				generateGlis();
				break;
			case "generateCicls":
				generateCicls();
				break;
			case "generateDailyInterface":
				generateDailyInterface();
				break;
			case "generateDailyBatchReports":
				generateDailyBatchReports();
				break;
			case "generateSpecialMco":
				generateSpecialMco();
				break;
			case "generateMonthEndMco":
				generateMonthEndMco();
				break;
			case "generateWeeklyBatchReports":
				generateWeeklyBatchReports();
				break;
			case "generateMonthlyBatchReports":
				generateMonthlyBatchReports();
				break;
			case "generateQuarterlyBatchReports":
				generateQuarterlyBatchReports();
				break;
			case "generateYearlyBatchReports":
				generateYearlyBatchReports();
				break;
			case "generateAdhoc":
				generateSelectedAdhoc();
				break;
            case "executeGlMovement":
            	executeGlMovement();
            	break;
            case "processRefBank":
            	processRefBanks();
            	break;
            case "processRmaDocument":
            	processRmaDocument();
            	break;
            case "executeAllocationFile":
            	executeAllocationFile();
            	break;
            case "updateTransactionRouting":
            	updateTransactionRouting();
            	break;
            case "executeUpdateAllocationUnitCode":
            	executeUpdateAllocationUnitCode();
            	break;
            case "executeAfterReportInterface":
            	executeAfterReportInterface();
            	break;
			case "generateSibsInterface":
				generateSibsInterface();
				break;
			case "generateCicInterface":  // IBD-16-0219-01
				generateCicInterface();
				break;
			case "generateYearEndInterface":
				generateYearEndInterface();
				break;
			case "generateYearEndHolidays":
				generateYearEndHolidays();
				break;
			case "generateDailySummaryOfDW":
				generateDailySummaryOfDW();
				break;
			case "generatecifPurgingInterface":
				generatecifPurgingInterface();
				break;
			case "generatecifPurgingInterface2":
				generatecifPurgingInterface2();
				break;
			case "generatecifPurgingInterface3":
				generatecifPurgingInterface3();
				break;
			case "executeDailyItrs":
				executeDailyItrs();
				break;
			case "executeDailyItrsReport":
				executeDailyItrsReport();
				break;
            default:
				triggerAlertMessage("Javascript Error: No ID for this action");
		}
	});
	
	$("#btnAlertOk").click(function(){
		mDisablePopup($("#popup_alert_dv"),$("#popup_alert_bg"));
	});

	$("#btnAlertNo").click(function(){
		mDisablePopup($("#popup_save_confirmation"),$("#confirmation_background"));
	});
});

function executeDailyItrs(){
	var batchUrl = dailyItrsUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"dailyItrs");
}

function executeDailyItrsReport(){
	var batchUrl = batchReportUrl;
	batchUrl+="?callback=?";
	var params= {duration:'itrs', inv:'batch', onlineReportDate:currentDate, branchUnitCode:branchUnitCode, branchUnitName:branchUnitName};
	executeBatchAction(batchUrl,params,"itrs");
}

function executeAfterReportInterface(){
	var batchUrl = afterReportInterfaceUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"afterReportInterface");
}

function executeUpdateAllocationUnitCode(){
	var batchUrl = updateAllocationUrl;
	var params = {};
	executeUpdateAction(batchUrl,params,"updateAllocationUnitCode");
}

function processRefBanks(){
	var batchUrl = interfaceUrl;
	var params = {adhoc:'true',methodName:'processRefBanks'};
	executeBatchAction(batchUrl,params,"refBankDiv");
}

function executeCifNormalization(){
	var batchUrl = cifNormalizationUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"special");
}

function executeCloneLnappf(){
    var batchUrl = interfaceUrl;
    var params = {adhoc:'true',methodName:'cloneLnappf'};
    executeBatchAction(batchUrl,params,"specialCloneLnappf");
}

function executePopulateCasaAccounts(){
    var batchUrl = populateCasaAccountsUrl;
    var params = {};
    executeBatchAction(batchUrl,params,"specialPopulateCasaAccounts");
}

function executeAllocationFile(){
	var batchUrl = allocationUrl;
	var params = {onlineReportDate:currentDate};
	executeBatchAction(batchUrl,params,"allocationFileDiv");
}

function updateTransactionRouting(){
	var batchUrl = interfaceUrl;
	var params = {adhoc:'true',methodName:'updateTransactionRouting'};
	executeBatchAction(batchUrl,params,"updateTransactionRoutingDiv");
}

function generateGlis(){
	var batchUrl = glisUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"glisDiv");
}

function generateCicls(){
	var batchUrl = ciclsUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"ciclsDiv");
}

function generateDailyInterface(){
	var batchUrl = interfaceUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"interface");
}

function generateMonthEndMco(){
	var batchUrl = batchReportIndividualUrl;
	batchUrl+="?callback=?";
	var params = {duration:'monthEndMcoDiv',inv:'batch',onlineReportDate:currentDate,branchUnitCode:branchUnitCode,
			branchUnitName:branchUnitName,methodName:'runTfsMcoReport'};
	executeBatchAction(batchUrl,params,"monthEndMcoDiv");
}

function generateSpecialMco(){
	var batchUrl = specialMcoUrl;
	batchUrl+="?callback=?";
	var params = {duration:'specialMcoDiv',inv:'batch',onlineReportDate:currentDate};
	executeBatchAction(batchUrl,params,"specialMcoDiv");
}

function generateDailyBatchReports(){
	var batchUrl = batchReportUrl;
	batchUrl+="?callback=?";
	var params = {duration:'daily',inv:'batch',onlineReportDate:currentDate,branchUnitCode:branchUnitCode,branchUnitName:branchUnitName};
	executeBatchAction(batchUrl,params,"daily");
}

function generateWeeklyBatchReports(){
	var batchUrl = batchReportUrl;
	batchUrl+="?callback=?";
	var params = {duration:'weekly',inv:'batch',onlineReportDate:currentDate,branchUnitCode:branchUnitCode,branchUnitName:branchUnitName};
	executeBatchAction(batchUrl,params,"weekly");
}

function generateMonthlyBatchReports(){
	var batchUrl = batchReportUrl,
		params = {duration:'monthly',inv:'batch',onlineReportDate:currentDate,branchUnitCode:branchUnitCode,branchUnitName:branchUnitName};;
	batchUrl+="?callback=?";

	$.getJSON(interfaceDirectoriesUrl,{},function(data){
		params.itrsDirectory = data.directories.itrs;
		executeBatchAction(batchUrl,params,"monthly");
	});
}

function generateQuarterlyBatchReports(){

	var batchUrl = batchReportUrl;

	batchUrl+="?callback=?";
	var params = {duration:'quarterly',inv:'batch',onlineReportDate:currentDate,branchUnitCode:branchUnitCode,branchUnitName:branchUnitName};
	executeBatchAction(batchUrl,params,"quarterly");
}

function generateYearlyBatchReports(){
	var batchUrl = batchReportUrl;
	batchUrl+="?callback=?";
	var params = {duration:'yearly',inv:'batch',onlineReportDate:currentDate,branchUnitCode:branchUnitCode,branchUnitName:branchUnitName};
	executeBatchAction(batchUrl,params,"yearly");
}
function generateDailyAmlaInterface(){
	var batchUrl = interfaceAmlaUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"interfaceDailyAmla");
}

function generateSibsInterface(){
	var batchUrl = sibsInterfaceUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"sibsInterface");
}

// IBD-16-0219-01
function generateCicInterface(){
	var batchUrl = cicInterfaceUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"cicInterface");
}

function generateYearEndInterface(){
	var batchUrl = yearEndInterfaceUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"yearEndInterface");
}

function generateYearEndHolidays(){
	var batchUrl = yearEndHolidaysUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"yearEndHolidays");
}

function generateDailySummaryOfDW(){
	var batchUrl = batchReportUrl;
	batchUrl+="?callback=?";
	var params = {duration:'dailySummary',inv:'batch',onlineReportDate:currentDate,branchUnitCode:branchUnitCode,branchUnitName:branchUnitName};
	executeBatchAction(batchUrl,params,"DailySummaryOfDW");
}

function generatecifPurgingInterface(){
	var batchUrl = cifPurgingInterfaceUrl;
	var params = {};
	executeBatchAction(batchUrl,params,"cifPurgingInterface");
}

function generatecifPurgingInterface2(){
	var batchUrl = cifPurgingInterfaceUrl2;
	var params = {};
	executeBatchAction(batchUrl,params,"cifPurgingInterface2");
}

function generatecifPurgingInterface3(){
	var batchUrl = cifPurgingInterfaceUrl3;
	var params = {};
	executeBatchAction(batchUrl,params,"cifPurgingInterface3");
}

var cntrS = 0;
var test = 0;
var stopRequest = false;
var sibslabel = false;
var modalShow = false;
var cntAtmpt = 0;

function executeBatchAction(batchUrl,params,category){
	var scndCall = "";
		


	if(category == "quarterly" || category == "daily" || category == "monthEndMcoDiv" ||  category == "specialMcoDiv" ||  category == "itrs" )	{
		scndCall = sibsfromGenericReport;
		scndCall+="?callback=?";
	} else {
		scndCall = "/tfs-web/batch/timeThread";
	}
	centerPopup("loading_div", "loading_bg");
	loadPopup("loading_div", "loading_bg");
	stopRequest = false;

	$.when(	
	$.getJSON(batchUrl,params,function(data){
		
		if(data.successList){
			
			var successList = typeof data.successList == "object" ? data.successList : data.successList.split(",");
			$.each($("div#" + category + " span"),function(idx,val){
				var i = $(this);
				var textValue = i.text();
				if($.inArray($.trim(textValue),successList) != -1){
					i.text(textValue + " - SUCCESS").addClass("success");

				} else {
					var testtext  = "hhreconmm"+textValue+"hhreconmm";
					
					if($.inArray($.trim(testtext),successList) != -1){
						i.text(textValue + " - SIBS DISCONNECTION Please Try after 15 minutes").addClass("success");
//						i.text(i.text().toString().replace(/hhreconmm/g,'') + " - SIBS DISCONNECTION Please Try after 15 minutes").addClass("success");
						
					}

				}

				$.each($(successList), function(idx, val) {
					// check if the value in success list is equal to the current line
					if (textValue === val.substring(0, textValue.length)) {
						if (val.substring(textValue.length + 2, textValue.length + 9) === 'WARNING') {
							i.text(textValue + " - " + val.substring(textValue.length + 10, val.length)).addClass("success");
						}
					}
				});
			});
		}

		$.each($("div#" + category + " span"),function(idx,val){
			if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
				if($(this).text()=="GL Movement"){
					$(this).text($(this).text() + " - Warnng: GL Movement file successfully generated but GL entries are not balance. Please call ITD Support").addClass("failed");	
				}else{
					$(this).text($(this).text() + " - FAILED").addClass("failed");
				}
			}
		});
		stopRequest = true;
		sibslabel = false;
		disableLoading();
	}).fail(function(){				
			alert("Critical Error: Function failed to return result.");
			stopRequest = true;
			sibslabel = false;
			disableLoading();
	}),$.getJSON(scndCall,params,function(data){
		
		if(data.successList){
			

//				var gunsandroses = bullshitRequest("/tfs-web/batch/timeThread",params,category);
			checkRequest(scndCall,params,category);
			
				}
		

		

		
}).fail(function(){				
	stopRequest = true;
	sibslabel = false;
	disableLoading();
})
	
)	
	
}











//

var modalRunning = false;
var times
	function hulahoop(batchUrl,params,category){
	modalRunning = true;
		var sec = 60
		var timer = setInterval(function() {
			
			
			if(stopRequest == true){
				document.getElementById('closeModal').click();
				return false;
			}
				
			
			
		   $('#msg').text("Retrying to connect to sibs: "+sec--);
		   if (sec == -1) {
	

		      clearInterval(timer);
		      document.getElementById('closeModal').click();
		      modalShow = false;
		      modalRunning = false;
		      checkRequest(batchUrl,params,category);
		   }
		   if(sec % 5 == 0){

			   checkRequest(batchUrl,params,category);	 
		   }
		}, 1000);
}
		
	



function checkRequest(batchUrl,params,category){
	$.when(	
			$.getJSON(batchUrl,params,function(data){
			
				if(data.successList){					
				
					times = JSON.stringify(data.successList);
					times = times.replace('[', '');
					times = times.replace(']', '');
					times = times.replace(/"/g, '');
										
					if(times=="false"){												
						
						if(modalShow == false){
							document.getElementById('startCnt').click();
					
						} else {
							document.getElementById('closeModal').click();
						
						}
						
					}					
					if(modalRunning == false){
						hulahoop(batchUrl,params,category);
						$('#attemptCnt').text("Attempt/s count: "+ cntAtmpt++);
					}					
				}				
				
			}).done(function() {
			    console.log( "checking if failed" );
				
			})
			
		)			
}

function executeUpdateAction(batchUrl,params,category){
	centerPopup("loading_div", "loading_bg");
	loadPopup("loading_div", "loading_bg");
	
	$.getJSON(batchUrl,params,function(data){

	}).success(function(data) { 
		if(data.successList){
			var successList = typeof data.successList == "object" ? data.successList : data.successList.split(",");
			$.each($("div#" + category + " span"),function(idx,val){
				if($.inArray($.trim($(this).text()),successList) != -1){
					$(this).text($(this).text() + " - SUCCESS").addClass("success");
				}
			});
		}

		$.each($("div#" + category + " span"),function(idx,val){
			if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
				if($(this).text()=="GL Movement"){
					$(this).text($(this).text() + " - Warnng: GL Movement file successfully generated but GL entries are not balance. Please call ITD Support").addClass("failed");	
				}else{
					$(this).text($(this).text() + " - FAILED").addClass("failed");
				}
			}
		});
		disableLoading();
	}).complete(function(data, jqXHR, textStatus, errorThrown) {
		console.log("completed");
		if(data.successList){
			var successList = typeof data.successList == "object" ? data.successList : data.successList.split(",");
			$.each($("div#" + category + " span"),function(idx,val){
				if($.inArray($.trim($(this).text()),successList) != -1){
					$(this).text($(this).text() + " - SUCCESS").addClass("success");
				}
			});
		}
		$.each($("div#" + category + " span"),function(idx,val){
			if(!$(this).hasClass("failed") && !$(this).hasClass("success") ){
				$(this).text($(this).text() + " - FAILED").addClass("failed");
			}
		});
		console.log("Status: " + textStatus + (new Date()));
		console.log("ErrorThrown: " + errorThrown + (new Date()));
		disableLoading();
	});
}



function generateSelectedAdhoc(){
	console.log("test 1");
	stopRequest = false;
	var batchUrl;
	
	centerPopup("loading_div", "loading_bg");
	loadPopup("loading_div", "loading_bg");

	console.log("SelectedADHOC: " + $("#adhoc_dropdown option:selected").val());
	
	if($("#adhoc_dropdown option:selected").hasClass("interface")){
		batchUrl = interfaceUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}
	else if($("#adhoc_dropdown option:selected").hasClass("reroute")){
		batchUrl = reRouteApproverUrl;
		console. log("batchUrl: " + batchUrl);
		console. log("docNumber: " + $("#docNumber").val());
		console. log("newApprover: " + $("#newApprover").val());
		
		$.getJSON(batchUrl,{adhoc:'true',
			methodName:$("#adhoc_dropdown option:selected").val(),
			docNumber:$("#docNumber").val(),
			newApprover:$("#newApprover").val()},
			adHocActionResult).complete(function(){
			disableLoading();
			});
	}else if($("#adhoc_dropdown option:selected").hasClass("interface2")){
		batchUrl = interfaceUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			dateOfTransactionFrom:$("#dateOfTransactionFrom").val(),dateOfTransactionTo:$("#dateOfTransactionTo").val(),interface2Check:true},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("CASA")){
		batchUrl = populateCasaAccountsUrl;
		$.getJSON(batchUrl,adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("CIFPURGING")){
		batchUrl = cifPurgingUrl;
		$.getJSON(batchUrl,adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("MASTEREXCEPTION")){
		batchUrl = masterExceptionUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("ALLOCATIONEXCEPTION")){
		batchUrl = allocationExceptionUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("sibsInterface")){
		batchUrl = sibsInterfaceUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("cicInterface")){ // IBD-16-0219-01
		batchUrl = cicInterfaceUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("cicInterfaceHistorical")){ // IBD-16-0219-01
		batchUrl = cicInterfaceUrl2;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("yearEndInterface")){
		batchUrl = yearEndInterfaceUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){			
			
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("yearEndHolidays")){
		batchUrl = yearEndHolidaysUrl;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){			
			
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("cifNormalization2")){
		// ER# 20140909-038 : Start
		batchUrl = cifNormalizationUrl2;
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).fail(function(){
			disableLoading();
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call interface method.</span>");
		});
		// ER# 20140909-038 : END
	}
	// IBD-16-0615-01 : Adhoc of account purging	
	else if($("#adhoc_dropdown option:selected").hasClass("cifPurgingInterface")){
		batchUrl = cifPurgingInterfaceUrl;
		screenTimer(null,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult);
		
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).complete(function(){
			disableLoading();
			
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("cifPurgingInterface2")){
		batchUrl = cifPurgingInterfaceUrl2;
		screenTimer(null,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult);
		
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).complete(function(){
			disableLoading();
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("cifPurgingInterface3")){
		batchUrl = cifPurgingInterfaceUrl3;
		screenTimer(null,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult);
		
		$.getJSON(batchUrl,{adhoc:'true',methodName:$("#adhoc_dropdown option:selected").val(),
			onlineReportDate:$("#onlineReportDate").val()},adHocActionResult).complete(function(){
			disableLoading();
		});
	}else if($("#adhoc_dropdown option:selected").hasClass("cocreeReport")){
		batchUrl = batchReportIndividualUrl;
		batchUrl+="?callback=?";
		var parameters= {inv:'batch',onlineReportDate:$("#onlineReportDate").val(),
				branchUnitCode:branchUnitCode,branchUnitName:branchUnitName,methodName:$("#adhoc_dropdown option:selected").val()};
		if(typeof $("#adhoc_dropdown option:selected").attr("id") !== 'undefined' &&
			 typeof $("#adhoc_dropdown option:selected").attr("class") !== 'undefined'){
			var param = {};
			param[$("#adhoc_dropdown option:selected").attr("class")] = $("#adhoc_dropdown option:selected").attr("id");
			$.extend(parameters,param);
		}
		$.getJSON(interfaceDirectoriesUrl,{},function(data){
			parameters.itrsDirectory = data.directories.itrs;
			$.getJSON(batchUrl,parameters,adHocActionResult).fail(function(){
				disableLoading();
				stopRequest = true;
				sibslabel = false;	
				triggerAlertMessage("<span class='failed'>Critical Error: Failed to call report method.</span>");
			});
		});
	}
	// IBD-16-0615-01 : END
	else{
		batchUrl = batchReportIndividualUrl;


		batchUrl+="?callback=?";
		console.log("START" + batchUrl + "END");
		var parameters= {inv:'batch',onlineReportDate:$("#onlineReportDate").val(),
				branchUnitCode:branchUnitCode,branchUnitName:branchUnitName,methodName:$("#adhoc_dropdown option:selected").val()};
		if(typeof $("#adhoc_dropdown option:selected").attr("id") !== 'undefined' &&
			 typeof $("#adhoc_dropdown option:selected").attr("class") !== 'undefined'){
			var param = {};
			// format: object = {'class':'id'}
			param[$("#adhoc_dropdown option:selected").attr("class")] = $("#adhoc_dropdown option:selected").attr("id");
			$.extend(parameters,param);
		}	
		console.log("START p" + parameters + "END");
		console.log("START ad" + adHocActionResult + "END");
	
		$.getJSON(batchUrl,parameters,adHocActionResult).fail(function(){
		
			disableLoading();
			stopRequest = true;
			sibslabel = false;	
			triggerAlertMessage("<span class='failed'>Critical Error: Failed to call report method.</span>");
		});
		
		
	}
	
	scndBatchUrl = sibsfromGenericReport;
	scndBatchUrl+="?callback=?";
	checkRequest(scndBatchUrl,"",adHocActionResults);
	

}

function adHocActionResults(data){
	stopRequest = false;
	
	console.log ("adHocActionResult2" );
	
	if('undefined' !== typeof data.successList && data.successList.length > 0){
		if(data.successList){
			cntAtmpt = 0;
			stopRequest = true;
		var successList = typeof data.successList == "object" ? data.successList : data.successList.split(",");
		if(successList[0].indexOf("hhreconmm") >= 0){
			successList[0]=successList[0].replace(/hhreconmm/g,'');
			sibslabel = true;
			
		}
		if(sibslabel == true){
		$(this).text($(this).text() + " - SIBS DISCONNECTION Please Try after 15 minutes").addClass("success");
		adHocReportStatus="SIBS DISCONNECTION Please Try after 15 minutes";
		disableLoading();
		triggerAlertMessage("<span class='success'>SIBS DISCONNECTION Please Try after 15 minutes : "+ $("#adhoc_dropdown option:selected").text() + "</span>");
		
		}else{
		adHocReportStatus="SUCCESS";
		disableLoading();
		triggerAlertMessage("<span class='success'>Successfully executed : "+ $("#adhoc_dropdown option:selected").text() + "</span>");
		}
		
		}
		sibslabel = false;
	}else{
		adHocReportStatus="FAILED";
		disableLoading();
		triggerAlertMessage("<span class='failed'>Error in executing : "+$("#adhoc_dropdown option:selected").text()  + "</span>");
	}
	stopRequest = true;
	
	
}

function adHocActionResult(data){
	stopRequest = false;
	
	console.log ("adHocActionResult1" );
	
	if('undefined' !== typeof data.successList && data.successList.length > 0){
		if(data.successList){
			cntAtmpt = 0;
			stopRequest = true;
		var successList = typeof data.successList == "object" ? data.successList : data.successList.split(",");
	
		if(successList[0].indexOf("hhreconmm") >= 0){
			successList[0]=successList[0].replace(/hhreconmm/g,'');
			sibslabel = true;
			
		}
		if(sibslabel == true){
		$(this).text($(this).text() + " - SIBS DISCONNECTION Please Try after 15 minutes").addClass("success");
		adHocReportStatus="SIBS DISCONNECTION Please Try after 15 minutes";
		disableLoading();
		triggerAlertMessage("<span class='success'>SIBS DISCONNECTION Please Try after 15 minutes : "+ $("#adhoc_dropdown option:selected").text() + "</span>");
		
		} else if(successList[0] == "dbException"){
			console.log ("successList: dbException");
			adHocReportStatus="FAILED";
			triggerAlertMessage("<span class='failed'>Error in executing : "+$("#adhoc_dropdown option:selected").text()  + " " + successList[1] +  "</span>");
			disableLoading();
		}else if (successList[0].startsWith("2")){
			adHocReportStatus="SUCCESS";
			disableLoading();
			triggerAlertMessage("<span class='warning'>" + successList[0].substring(1) +  "</span>");
		} else {
			var selectedLength = $("#adhoc_dropdown option:selected").text().length;
			if (successList[0].substring(selectedLength + 2, selectedLength + 9) === 'WARNING') {
				var name = successList[0].substring(selectedLength + 10, successList[0].length);
				adHocReportStatus = name;
				disableLoading();
				triggerAlertMessage("<span class='success'>"+ name + "</span>");
			} else {
				adHocReportStatus="SUCCESS";
				disableLoading();
				triggerAlertMessage("<span class='success'>Successfully executed : "+ $("#adhoc_dropdown option:selected").text() + "</span>");
			}
		}
		
		}
		sibslabel = false;
	}else{
		console.log ("data.successList / data.successList.length");
		console.log (data.successList +" / "+ data.successList.length);
		adHocReportStatus="FAILED";
		disableLoading();
		triggerAlertMessage("<span class='failed'>Error in executing : "+$("#adhoc_dropdown option:selected").text() + "</span>");
	}
	stopRequest = true;
	
	
}

function showConfirmPopup(){
	$("#popup_save_confirmation").css("width","70%");
	mCenterPopup($("#popup_save_confirmation"),$("#confirmation_background"));
	mLoadPopup($("#popup_save_confirmation"),$("#confirmation_background"));
}

function disableLoading(){
	disablePopup("loading_div", "loading_bg");
	setTimeEnd(fieldIdToChangeTime);
}

function setTimeStart(timeElementId,reportName){
	$.get(currentTimeUrl,function(data){
		$("#"+ timeElementId + " label#start").text("Time Start: " + data.time);
	}).fail(function(){
		var dt=new Date();
		$("#"+ timeElementId + " label#start").text("Time Start*: " + dt.getHours() + 
				":" + dt.getMinutes() + ":" + dt.getSeconds());
	});
	
	if(reportName != ""){
		$("#"+ timeElementId + " label#reportName").text("Name: " + reportName);
	}
}

function setTimeEnd(timeElementId){
	$.get(currentTimeUrl,function(data){
		$("#"+ timeElementId + " label#end").text("Time End: " + data.time);
	}).fail(function(){
		var dt=new Date();
		$("#"+ timeElementId + " label#end").text("Time End*: " + dt.getHours() + 
				":" + dt.getMinutes() + ":" + dt.getSeconds());
	});
	
	if(adHocReportStatus != ""){
		$("#"+ timeElementId + " label#reportStatus").text("Status: " + adHocReportStatus);
		adHocReportStatus="";
	}
}

function triggerAlertMessage(alertMessage) {
    var mSave_div = $("#popup_alert_dv");
    var mBg = $("#popup_alert_bg");
    $("#alertMessage").html(alertMessage);
    $("#popup_alert_dv").css("width","50%");
    mCenterPopup(mSave_div, mBg);
    mLoadPopup(mSave_div, mBg);
    
}

var reconn = "."
var prevCount = 0


function msgloadPopup(alertMessage) {
	if(alertMessage == "FALSE"){
		  $("#alertMessage").html("CONNECTED TO SIBS");
		 $("#btnAlertOk").show();
		
	}else{
	prevCount++;
//	centerPopup("loading_div", "loading_bg");
//	loadPopup("loading_div", "loading_bg");
    var mSave_div = $("#popup_alert_dv");
    var mBg = $("#popup_alert_bg");
    
    $("#alertMessage").html(alertMessage);
    if($.isNumeric(alertMessage)){
    
    $("#alertMessage").append('<br/>'+ "STANDBY");

    }
    

    $("#alertMessage").append(reconn + '<br/>');
    if(reconn.length >= 5)
    reconn = "";
    if(prevCount > 50)
    {
    reconn = reconn + "."; 
    prevCount = 0;
}
   
    
    $("#btnAlertOk").hide();
    $("#popup_alert_dv").css("width","15%");
    $("#popup_alert_dv").css({ 'height': "15%"});
    mCenterPopup(mSave_div, mBg);
    mLoadPopup(mSave_div, mBg); 
	$('#popup_alert_bg').css({
		"opacity": "0.2"
	});
	}
	
}

// IBD-16-0615-01 : timer for Account purging 
var modalShow2 = false;
var requestRunning = true;
	function screenTimer(batchUrl,params,category){
	
		modalRunning = true;
		
		var sec = 1;

		var minutes = 0;
		
			
			var timer = setInterval(function() {
				if(modalShow2 == false){
					document.getElementById('startCnt2').click();
				}
				
				if(stopRequest == true){
					document.getElementById('closeModal2').click();
					modalShow2 == true;
					clearInterval(timer);
					checkRequest(batchUrl,params,category);
					return false;
				} 
				sec++;

				var label = " Minute";
				
				if (sec % 60 == 0) {
					minutes++
				}
				
				if (minutes>1) {
					label = " Minutes";
				}
	
				
				
			   $('#msg2').text("Runtime:   " + minutes + label);
			   
			}, 1000);
	}
	// IBD-16-0615-01
	
	