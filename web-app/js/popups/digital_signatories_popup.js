 
/** PROLOGUE:
	 * 	(revision)
		SCR/ER Number: SCR# IBD-16-0615-01
		SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
		[Revised by:] Jesse James Joson
		[Date Revised:] 09/22/2016
		Program [Revision] Details: additional scripts to run account purging
		PROJECT: WEB
		MEMBER TYPE  : Javascript
		Project Name: digital_signatories_popup.js
 */

var popup_digisign = $("#popup_digital_signatories");
var popup_bg_digisign = $("#popupBackground_digital_signatories");

function openLcConfirmationOpeningPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateLcConfirmationOpeningReport');
	mCenterPopup(popup_digisign,popup_bg_digisign);
	mLoadPopup(popup_digisign,popup_bg_digisign);
}

function openLcConfirmationAmendmentPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateLcConfirmationAmendmentReport');
	mCenterPopup(popup_digisign,popup_bg_digisign);
	mLoadPopup(popup_digisign,popup_bg_digisign);
}

function openPddtsPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generatePddtsReport');
	mCenterPopup(popup_digisign,popup_bg_digisign);
	mLoadPopup(popup_digisign,popup_bg_digisign);
}

//cdt rem additional - Allan 7/7/2016
function openCdtRemittanceReportAuthorizedSignatoryPopUp(){	
	$(".buttonPopupGenDocument").attr('id','viewCdtRemittanceReport');
	mCenterPopup(popup_digisign,popup_bg_digisign);
	mLoadPopup(popup_digisign,popup_bg_digisign);
}

function closeDigitalSignatories() {
	mDisablePopup(popup_digisign,popup_bg_digisign);
}

function confirmDigitalSignatories() {
	mDisablePopup(popup_digisign,popup_bg_digisign);
}

$(document).ready(function() {
	//reports generation		
	//lc confirmation opening
	$("#generateLcConfirmationOpeningReport").live("click",function(){		
		if(($("#authorizedSignatory1").val()=="" ||	$("#authorizedSignatory2").val()=="")){
			alert("Please fill in all the required fields.");
		}else{			
			generateLcConfirmationOpeningReport();			
		}
	});
	
	//lc confirmation amendment
	$("#generateLcConfirmationAmendmentReport").live("click",function(){		
		if(($("#authorizedSignatory1").val()=="" ||	$("#authorizedSignatory2").val()=="")){
			alert("Please fill in all the required fields.");
		}else{			
			generateLcConfirmationAmendmentReport();			
		}
	});	
	
	
		//cdt remittance report - 
		$("#viewCdtRemittanceReport").live("click", function() {
			if(($("#authorizedSignatory1").val()=="" ||	$("#authorizedSignatory2").val()=="")){
				alert("Please fill in all the required field.");
			}else{
				
				$.when(
					    $.ajax({ // First Request
	 
						        success: function(){    
										if($("#reportType :selected").val() == "IPF" || $("#reportType :selected").val() == "FINAL_CDT" || 
												$("#reportType :selected").val() == "EXPORT_CHARGES" || $("#reportType :selected").val() == "ALL") {
									
											generateConsolidatedReportDailyCollectionsCdtOtherLevies("remittance");
										
										}
							        
							        	        
							        }           
							    }),
			
							    $.ajax({ //Seconds Request
							       
							        success: function(){                
							        	if($("#reportType :selected").val() == "ADVANCE_CDT" || $("#reportType :selected").val() == "ALL") {
											
											generateConsolidatedDailyReportDepositsCollected("remittance");
								
											
										}	
							        }           
							    })
			
							).then(function() {
						
							});
						
								
				
						
						
						
						
					}
				});	
		
			
	//pddts
	$("#generatePddtsReport").live("click",function(){		
		if(($("#authorizedSignatory1").val()=="" ||	$("#authorizedSignatory2").val()=="")){
			alert("Please fill in all the required fields.");
		}else{			
			generatePddtsReport();			
		}
	});	
	
	
	

	
		
});