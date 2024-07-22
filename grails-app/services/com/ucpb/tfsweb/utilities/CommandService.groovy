package com.ucpb.tfsweb.utilities

import com.ucpb.tfs.application.command.instruction.SaveAsPendingCommand
import com.ucpb.tfs.application.command.SaveBasicDetailsFormCommand
import com.ucpb.tfs.application.command.UploadDocumentCommand
import com.ucpb.tfs.application.command.DeleteDocumentCommand
import com.ucpb.tfs.application.command.SaveChargesFormCommand
import com.ucpb.tfs.application.command.SaveChargesPaymentFormCommand
import com.ucpb.tfs.application.command.SaveLcPaymentFormCommand
import com.ucpb.tfs.application.command.AddInstructionsCommand
import com.ucpb.tfs.application.command.UpdateInstructionsCommand

import com.ucpb.tfs.application.command.instruction.TagAsPreparedCommand
import com.ucpb.tfs.application.command.instruction.TagAsAbortedCommand
import com.ucpb.tfs.application.command.instruction.TagAsReturnedCommand
import com.ucpb.tfs.application.command.instruction.TagAsCheckedCommand
import com.ucpb.tfs.application.command.instruction.TagAsApprovedCommand
import com.ucpb.tfs.application.command.instruction.TagAsDisapprovedCommand
import com.ucpb.tfs.application.command.instruction.EmailCommand

import com.ucpb.tfs.application.command.SaveNatureOfAmendmentFormCommand
import com.ucpb.tfs.application.command.SaveSettlementToBeneficiaryFormCommand
import com.ucpb.tfs.application.command.PayCommand
import com.ucpb.tfs.application.command.SaveImporterExporterDetailsFormCommand
import com.ucpb.tfs.application.command.SaveShipmentsOfGoodsFormCommand
import com.ucpb.tfs.application.command.SaveAdditionalConditionsFormCommand
import com.ucpb.tfs.application.command.ErrorCorrectCommand
import com.ucpb.tfs.application.command.ReversePaymentCommand
import com.ucpb.tfs.application.command.AddSettlementCommand
import com.ucpb.tfs.application.command.DeleteSettlementCommand
import com.ucpb.tfs.application.command.EtsCommand
import com.ucpb.tfs.application.command.SaveDocumentsRequiredCommand
import com.ucpb.tfs.application.command.SaveNarrativeFormCommand
import com.ucpb.tfs.application.command.SaveOtherDocumentsInstructionsFormCommand
import com.ucpb.tfs.application.command.SaveDetailsOfGuaranteeFormCommand
import com.ucpb.tfs.application.command.SaveAdditionalDetailsFormCommand
import com.ucpb.tfs.application.command.SaveMt752Mt202FormCommand
import com.ucpb.tfs.application.command.SaveLoanDetailsFormCommand
import com.ucpb.tfs.application.command.SaveMt103DetailsFormCommand
import com.ucpb.tfs.application.command.SaveMt202DetailsFormCommand
import com.ucpb.tfs.application.command.SaveMt400DetailsFormCommand
import com.ucpb.tfs.application.command.SavePddtsFormCommand
import com.ucpb.tfs.application.command.ComputeCommand
import com.ucpb.tfs.application.command.SaveIncomingMtCommand
import com.ucpb.tfs.application.command.RouteIncomingMtCommand
import com.ucpb.tfs.application.command.CloseIncomingMtCommand
import com.ucpb.tfs.application.command.ReturnIncomingMtCommand
import com.ucpb.tfs.application.command.TransmitOutgoingMtCommand
import com.ucpb.tfs.application.command.DiscardOutgoingMtCommand
import com.ucpb.tfs.application.command.ReverseOutgoingMtCommand
import com.ucpb.tfs.application.command.SaveDiscrepancyFormCommand
import com.ucpb.tfs.application.command.SaveReimbursementDetailsFormCommand
import com.ucpb.tfs.application.command.SaveDetailsForTransmittalLetterCommand
import com.ucpb.tfs.application.command.TagAsReturnedToBranchCommand
import com.ucpb.tfs.application.command.TagAsPreApprovedCommand
import com.ucpb.tfs.application.command.TagAsPostApprovedCommand
import com.ucpb.tfs.application.command.TagAsPostedCommand
import com.ucpb.tfs.application.command.CreateLoanCommand;
import com.ucpb.tfsweb.lc.ets.InstructionsAndRoutingController;
import com.ucpb.tfsweb.main.UnactedTransactionsController;

//  PROLOGUE:
//* 	(revision)
//   SCR/ER Number:20160414-052
//   SCR/ER Description: Transaction was approved in TSD, but is found on TSD Makers' screen the next day, with Pending status.
//   [Revised by:] Allan Comboy Jr.
//   [Date Deployed:] 04/14/2016
//   Program [Revision] Details: Add error log receiver (TSD only)
//   PROJECT: WEB
//   MEMBER TYPE  : GROOVY
//   Project Name: CommandService.groovy

class CommandService {

    private static final String COMMAND_SUFFIX = "Command";

    def commandBusService
    def commandFactory
    def foreignExchangeService
    def ratesService
    
    def coreAPIService
	
//	def UnactedTransactionsController unactedTransactions;

    // add command
    String createCommand(parameterMap, saveAs) {
        SaveAsPendingCommand command = new SaveAsPendingCommand()

        // check if save as pending or draft
        if(saveAs.equalsIgnoreCase("DRAFT")) {
            command.setDraft(true)
        }

        // generate UUID
        UUID token = UUID.randomUUID()
		println "token UUID:"+token
        String tokenValue = String.valueOf(token)
        
        // add mytoken in parameters
        command.setToken(tokenValue)
        command.setUserActiveDirectoryId(parameterMap.get("username"))

        // sets parameter map to command
        command.setParameterMap(parameterMap)
        
        // dispatches command
        try {
			
            commandBusService.dispatch(command)
			
        } catch(Exception e) {
			e.printStackTrace()
        }

        return tokenValue
    }
    
    // ets update command
    void updateCommand(form, parameterMap, statusAction) {
        if(statusAction.equals("Return eTS to Branch")) {
            statusAction = "ReturnToBranch"
        }
		
        def command = commandSetter(form, statusAction)
		println "updateCommands:" + command
        println "statusAction:" + statusAction
        //parameterMap
		def tests = TagAsPreparedCommand;
        ////printlnparameterMap

        command.setUserActiveDirectoryId(parameterMap.get("username"))
        command.setParameterMap(parameterMap)

        try {
			

			commandBusService.dispatch(command)
			
			if (form.equals("instructionsAndRouting")){
				def com2 = new EmailCommand()
				
				com2.setUserActiveDirectoryId(parameterMap.get("username"))
				com2.setParameterMap(parameterMap)
				
				println "01"
				
				if(!statusAction.equalsIgnoreCase("Approve")) {				
					commandBusService.dispatch(com2)
				}
				
				println "02"
			}
            // dispatch the command via the REST API instead of the RMI dispatcher
//            coreAPIService.sendProxiedCommand(command)
	
        } catch(Exception e) {
			e.printStackTrace()
			UnactedTransactionsController.confirmationRoute(e.message.toString());
		}
	
    }
    
    // obtain command based on form and status action
    def commandSetter(form, statusAction) {
//        //println"form >> " + form
		
        switch(form) {
            case "basicDetails":
                if(statusAction.equalsIgnoreCase("deleteSettlement")) {
                    return new DeleteSettlementCommand()
                } else {
                    return new SaveBasicDetailsFormCommand()
                }
            case "attachedDocuments":
                if(statusAction.equalsIgnoreCase("uploadDocument")){
                    return new UploadDocumentCommand()
                } else if(statusAction.equalsIgnoreCase("deleteDocument")) {
                    return new DeleteDocumentCommand()
                }
            case "charges":
                return new SaveChargesFormCommand()
            case "chargesPayment":
                if(statusAction.equalsIgnoreCase("payCharges")) {
                    return new PayCommand()
                } else if(statusAction.equalsIgnoreCase("errorCorrect")) {
                    return new ErrorCorrectCommand()
                } else if(statusAction.equalsIgnoreCase("reverse")) {
                    return new ReversePaymentCommand()
                } else if(statusAction.equalsIgnoreCase("addSettlement")){
                    return new AddSettlementCommand()
                } else if(statusAction.equalsIgnoreCase("deleteSettlement")){
                    return new DeleteSettlementCommand()
                } else if("createLoan".equalsIgnoreCase(statusAction)){
                    return new CreateLoanCommand();
                }   else {
                    return new SaveChargesPaymentFormCommand()
                }
            case "lcPayment": case "proceeds":
                if(statusAction.equalsIgnoreCase("payCharges")) {
                    return new PayCommand()
                } else if(statusAction.equalsIgnoreCase("errorCorrect")) {
                    return new ErrorCorrectCommand()
                } else if(statusAction.equalsIgnoreCase("reverse")) {
                    return new ReversePaymentCommand()
                } else if(statusAction.equalsIgnoreCase("addSettlement")){
                    return new AddSettlementCommand()
                } else if(statusAction.equalsIgnoreCase("deleteSettlement")){
                    return new DeleteSettlementCommand()
                } else {
                    return new SaveLcPaymentFormCommand()
                }
            case "instructionsAndRouting":
                if(statusAction.equalsIgnoreCase("Prepare")) {
                    return new TagAsPreparedCommand();
                } else if(statusAction.equalsIgnoreCase("Abort")) {
                    return new TagAsAbortedCommand()
                } else if(statusAction.equalsIgnoreCase("Return")) {
                    return new TagAsReturnedCommand()
                } else if(statusAction.equalsIgnoreCase("ReturnToBranch")) {
                    return new TagAsReturnedToBranchCommand()
                } else if(statusAction.equalsIgnoreCase("Check")) {
                    return new TagAsCheckedCommand()
                } else if(statusAction.equalsIgnoreCase("Approve")) {
                    return new TagAsApprovedCommand()
                } else if(statusAction.equalsIgnoreCase("preApprove")) {
                    return new TagAsPreApprovedCommand()
                } else if(statusAction.equalsIgnoreCase("postApprove")) {
                    return new TagAsPostApprovedCommand()
                } else if(statusAction.equalsIgnoreCase("posted")) {
                    return new TagAsPostedCommand()
                } else if(statusAction.equalsIgnoreCase("Disapprove")) {
                    return new TagAsDisapprovedCommand()
                } else if(statusAction.equalsIgnoreCase("addInstructions")) {
                    return new AddInstructionsCommand()
                } else if(statusAction.equalsIgnoreCase("editInstructions")) {
                    return new UpdateInstructionsCommand()
                }
            case "natureOfAmendment":
                return new SaveNatureOfAmendmentFormCommand()
            case "settlementToBeneficiary":
                return new SaveSettlementToBeneficiaryFormCommand()
            case "ieDetails":
                return new SaveImporterExporterDetailsFormCommand()
            case "shipmentsOfGoods":
                return new SaveShipmentsOfGoodsFormCommand()
            case "documentsRequired":
                return new SaveDocumentsRequiredCommand()
            case "additionalConditions1":
                return new SaveAdditionalConditionsFormCommand()
            case "additionalConditions2":
                return new SaveReimbursementDetailsFormCommand()
            case "narrative":
                return new SaveNarrativeFormCommand()
            case "otherDocumentsInstruction":
                return new SaveOtherDocumentsInstructionsFormCommand()
            case "detailsOfGuarantee":
                return new SaveDetailsOfGuaranteeFormCommand()
            case "additionalDetails":
                return new SaveAdditionalDetailsFormCommand()
            case "mt752mt202":
                return new SaveMt752Mt202FormCommand()
            case "loanDetails":
                return new SaveLoanDetailsFormCommand()
            case "mt103":
                return new SaveMt103DetailsFormCommand()
            case "pddts":
                return new SavePddtsFormCommand()
            case "mtMessage":
                if(statusAction.equalsIgnoreCase("update")) {
                    return new SaveIncomingMtCommand()
                } else if(statusAction.equalsIgnoreCase("route")) {
                    return new RouteIncomingMtCommand()
                } else if(statusAction.equalsIgnoreCase("close")) {
                    return new CloseIncomingMtCommand()
                } else if(statusAction.equalsIgnoreCase("return")) {
                    return new ReturnIncomingMtCommand()
                } else if(statusAction.equalsIgnoreCase("transmit")) {
                    return new TransmitOutgoingMtCommand()
                } else if(statusAction.equalsIgnoreCase("discard")) {
                    return new DiscardOutgoingMtCommand()
                } else if(statusAction.equalsIgnoreCase("reverse")) {
                    return new ReverseOutgoingMtCommand()
                }
            case "discrepancy":
                return new SaveDiscrepancyFormCommand()
            case "detailsForTransmittalLetter":
                return new SaveDetailsForTransmittalLetterCommand()
            case "mt400":
            	return new SaveMt400DetailsFormCommand()
			case "mt202":
				return new SaveMt202DetailsFormCommand()
			case "detailsForMt202":
				return new SaveMt202DetailsFormCommand()
				
        }
    }

	String uploadCommand(parameterMap){
		////println"uploadCommand"
		
		UploadDocumentCommand command = new UploadDocumentCommand()
		 		
		// generate UUID
		UUID token = UUID.randomUUID()
		String tokenValue = String.valueOf(token)
		
		////println'tokenValue:' + tokenValue
		
		// add mytoken in parameters
		command.setToken(tokenValue)
		
		//TODO set userActiveDirectoryId from session
		command.setUserActiveDirectoryId(parameterMap.get("username"))
		command.setParameterMap(parameterMap)
				
		try {
			////println"before dispatch"
			commandBusService.dispatch(command)
		} catch(Exception e) {
			////println"exception"
			////printlne.toString()
			e.printStackTrace()
		}
		
		return tokenValue
	}
	
	Boolean deleteCommand(parameterMap){
		////println"deleteCommand"
		
		DeleteDocumentCommand command =  new DeleteDocumentCommand();
		
		// add mytoken in parameters
		command.setToken(parameterMap.tokenValue)
		
		//TODO set userActiveDirectoryId from session
		command.setUserActiveDirectoryId(parameterMap.get("username"))
		command.setParameterMap(parameterMap)
				
		try {
			////println"before dispatch"
			commandBusService.dispatch(command)
			
		} catch(Exception e) {
			////println"exception"
			////printlne.toString()
			e.printStackTrace()
			return false
		}
		
		return true				
		}
	
	public String createAndDispatch(String commandName,String userId, Map<String,?> parameters){
        Map<String,?> serializableMap = new HashMap<String, Object>(parameters);
        String token = String.valueOf(UUID.randomUUID());
        EtsCommand command = commandFactory.getCommand(commandName);
        command.setToken(token);
        command.setParameterMap(serializableMap);
        command.setUserActiveDirectoryId(userId);
        commandBusService.dispatch(command);

        return token;
    }


    // compute command
    String computeCommand(parameterMap) {
        ComputeCommand command = new ComputeCommand()

        // generate UUID
        UUID token = UUID.randomUUID()
        String tokenValue = String.valueOf(token)

        // add mytoken in parameters
        command.setToken(tokenValue)
        // TODO set userActiveDirectoryId from session
        command.setUserActiveDirectoryId(parameterMap.get("username"))

        // sets parameter map to command
        command.setParameterMap(parameterMap)

        // dispatches command
        try {
            commandBusService.dispatch(command)
        } catch(Exception e) {
            e.printStackTrace()
            ////println"Exception in computeCommand "
        }

        return tokenValue
    }

}
