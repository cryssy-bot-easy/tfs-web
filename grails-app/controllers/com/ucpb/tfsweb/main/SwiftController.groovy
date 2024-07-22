package com.ucpb.tfsweb.main

import grails.converters.JSON
/**  PROLOGUE:
 * 	(revision).
	[Modified by:] Rafael Ski Poblete
	[Date Deployed:] 08/08/2018
	Description : Added 72Z to checkLineLimits method for handling 72Z line limit.
 */
class SwiftController {

    def coreAPIService;

    def index() { }


    def generateSwiftMessage(){
        try{
			def parameters = [ tradeServiceId : params.outgoingTradeServiceId ?: getTradeServiceIdFromSession(), messageType : params.messageType];
			if(params.sequenceNumber)
				parameters << [sequenceNumber: params.sequenceNumber]
			else
				parameters << [sequenceNumber: null]
				
			def result = coreAPIService.dummySendCommand(parameters, "validate","swift/");
			def model = [ message : result.message , errors : result.errors, messageType:params.messageType];

			
			//CHECK LINE LIMITS *needs improvement
			model.errors.addAll(checkLineLimits(model.message))
			
			flash.remove("mtErrorMessage")
            if(params.newWindow){
                render (view: "/main/view_mt",model: model);
            }else{
                render (view: "/commons/popups/_view_mt_popup",model: model);
            }
		}catch(Exception e){
			println e.getMessage()
            flash.mtErrorMessage='Failed to generate MT ' + params.messageType + '.'
			if(params.newWindow){
                render(view: "/main/view_mt")
			}else{
                render (view: "/commons/popups/_view_mt_popup");
			}
		}
    }

    def generateSwiftMessageViewMt() {

    }
	
	def checkSwiftMessage(){
        def model,parameters,result,currentMt
        println "checkingSwift"
        boolean hasError=false
		
        if (session?.dataEntryModel?.generateMt && "NONE".equals(session?.dataEntryModel?.generateMt)) {
            println "no mt will be generated..."
            model = [error: ""]
            render model as JSON
        } else {
            String[] mtArray
            mtArray=params.messages.split(",")

            try{ 
                for(String s:mtArray){
                    currentMt=s
   
                    parameters = [ tradeServiceId : params.outgoingTradeServiceId ?: getTradeServiceIdFromSession(), messageType : currentMt];
                    result = coreAPIService.dummySendCommand(parameters, "validate","swift/");
					//CHECK LINE LIMIT *needs improvement
					result.errors.addAll(checkLineLimits(result.message))
					
                    println result.errors
                    if(result.errors.size > 0){
                        hasError=true
                        break;
                    }
                }

                if (hasError){
                    model = [error: "Error in MT" + currentMt]
                }else{
                    model = [error: ""]
                }
//                model = [error: ""] //for local
                render model as JSON
            }catch(Exception e){
                model= [error:'Failed to generate MT, caught exception:<br/>'+e.getCause()?.getMessage()]
//                model = [error: ""] //for local
                render model as JSON
            }
        }
	}

    def generateMt701(){
		try{
			def parameters = [ tradeServiceId : getTradeServiceIdFromSession(), messageType : "700"];
	        def result = coreAPIService.dummySendCommand(parameters, "validateMultiMessages","swift/");
	        List<String> messages = result.messages;
	        StringBuilder compiledMessages = new StringBuilder();
	        if (messages.isEmpty()){
				compiledMessages.append('No MT701s will be generated.');
				flash.mtErrorMessage="No MT701s will be generated.";
	        }else{
	            for (String message : messages){
	                compiledMessages.append(message).append("\n");
	            }
	        }
	        def model = [ message : compiledMessages.toString(), errors : result.errors, messageType: '701'];
			flash.remove("mtErrorMessage")
			if(params.newWindow){
				render (view: "/main/view_mt",model: model);
			}else{
				render (view: "/commons/popups/_view_mt_popup",model: model);
			}
		}catch(Exception e){
			flash.mtErrorMessage='Failed to generate MT 701.'
			if(params.newWindow){
				render(view: "/main/view_mt")
			}else{
				render (view: "/commons/popups/_view_mt_popup");
			}
		}
    }

	/**
	 * check line limits of fields 
	 * @param message - whole mt message
	 * @return List<String> of errors
	 */
	private List<String> checkLineLimits(String message){
		//Map of fields, add fields here
		Map<String,Integer> fieldList = ["78":12,"72":6,"59":5,"77A":20,"79":35,
			"45B":100,"46B":100,"47B":100,"42M":4,"42P":4,"50K":5,"57D":5,"77J":70,"77B":3,"72Z":6]
		List<String> result = new ArrayList<String>()
		for(Map.Entry entry : fieldList.entrySet()){
			if(isLineOverLimit(message,":"+ entry.getKey() +":",entry.getValue())){
				result.add("Field "+ entry.getKey() + " has exceeded " + entry.getValue().toString() + " lines.")
			}
		}
		return result
	}
	
	
	/**
	 * Line limit checking for MT. *needs improvement*
	 * 
	 * @param message - Whole MT Message
	 * @param field - field number (e.g. :78:)
	 * @param limit - assigned limit to field
	 * @return boolean value that line has reached over limit
	 */
	private boolean isLineOverLimit(String message,String field,int limit){
		if(message.find(field)){
			String fieldMessage = message.substring(message.indexOf(field) + field.length())
			def normalizedMessage = fieldMessage =~ /(?s)(.*?)(:\d\d?[a-zA-Z]?:|\-\})/ //:00a: or -} end format
//			println "-----"+fieldMessage+"\n-----------"
			if(normalizedMessage.size() > 0){
//				println normalizedMessage[0][1]
				def matcher = normalizedMessage[0][1] =~ /(?m)(.$)/
				
//				println "NUMBER OF MATCHES:"+matcher.size()
				if(matcher.size() > 0 && matcher.size() > limit){
					return true;
				}
			}
		}
		return false;	
	}
	
    private String getTradeServiceIdFromSession(){
        String tradeServiceId;
        if (session?.dataEntryModel){
            tradeServiceId = session?.dataEntryModel['tradeServiceId'];
        }else if(session?.chargesModel){
            tradeServiceId = session?.chargesModel['tradeServiceId'];
        }
        return tradeServiceId;
    }


}
