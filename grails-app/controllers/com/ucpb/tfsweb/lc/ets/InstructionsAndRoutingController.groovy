package com.ucpb.tfsweb.lc.ets
import grails.converters.JSON
import com.ucpb.tfs.application.command.EtsCommand

class InstructionsAndRoutingController {

    def routingInformationService
    def commandService;
    def remarksService
    def coreAPIService

    def index() { }

    def getRoutes(){
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        String etsNumber = ""
        if(session.dataEntryModel) {
            //etsNumber = session.dataEntryModel.tradeServiceId

            if (session.dataEntryModel.reversalDENumber) {
                etsNumber = session.dataEntryModel.reversalDENumber
            } else if (session.dataEntryModel.reversalEtsNumber) {
            	etsNumber = session.dataEntryModel.tradeServiceId
        	} else if (session.dataEntryModel.reversalTradeServiceId) {
    			etsNumber = session.dataEntryModel.reversalTradeServiceId
            } else {
                etsNumber = session.dataEntryModel.tradeServiceId
            }
        } else if(session.etsModel) {

            if (session.etsModel.reversalEtsNumber) {
                etsNumber = session.etsModel.reversalEtsNumber
            } else {
                etsNumber = session.etsModel.serviceInstructionId
            }
        } else if(session.chargesModel) {
            etsNumber = session.chargesModel.etsNumber
        } else if(session.model) {
            etsNumber = session.model.tradeServiceId
        } else if (session.mtModel) {
            etsNumber = session.mtModel.tradeServiceId?.tradeServiceId
        }

        ////println"etsNumber >> " + etsNumber
        def mapList = routingInformationService.findAllRoutesByRoutingInformationId(maxRows, rowOffset, currentPage,etsNumber);
        def results = routingInformationService.buildRoutingInfoGrid(mapList.display)
        def jsonData = [rows: results, page: currentPage, records: mapList?.totalRows ?: 0, total: (mapList?.totalRows ?: 0 /maxRows)]

        render jsonData as JSON
    }

    def addInstruction(){
        println " yay " + params
        params.put("remarkId",getRemarksId());
        println "PARAMS:"+params
        commandService.createAndDispatch("addInstructions", session.username ,params);
        // returns json data to complete ajax transaction
        def jsonData = [success:true]
        render jsonData as JSON
    }

    def updateInstruction(){
        params.put("remarkId",getRemarksId());
		println "PARAMS:"+params
        commandService.createAndDispatch("updateInstructions", session.username,params);
        // returns json data to complete ajax transaction
        def jsonData = [success:true]
        render jsonData as JSON
    }

    def getInstructions(){
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
        println "hahahaha " + getRemarksId2()
		List<String> remarkIds = getRemarksId2()
        def mapList = remarksService.findAllRemarksByRemarkId(maxRows, rowOffset, currentPage,remarkIds);
        def results = remarksService.buildRemarksGrid(mapList.display, session.username)
        def jsonData = [rows: results, page: currentPage, records: mapList?.totalRows ?: 0, total: (mapList?.totalRows ?: 0 /maxRows)]

        render jsonData as JSON
    }

    private String getRemarksId(){
        println "what ? " + params
        if ("ETS".equalsIgnoreCase(params.referenceType)){
//            return session?.etsModel?.etsNumber;
            if (session.etsModel.reversalEtsNumber) {
                return session?.etsModel?.reversalEtsNumber
            }

            return session?.etsModel?.serviceInstructionId;
        }

        if ("DATA_ENTRY".equalsIgnoreCase(params.referenceType)) {
            return session?.dataEntryModel?.tradeServiceId;
        }

        if ("OUTGOING_MT".equalsIgnoreCase(params.referenceType)) {
            return session?.mtModel?.tradeServiceId?.tradeServiceId;
        }
    }
	
	private ArrayList<String> getRemarksId2(){
		println "what ? " + params
		List<String> remarkIds = new ArrayList<String>()
		if ("ETS".equalsIgnoreCase(params.referenceType)){
//            return session?.etsModel?.etsNumber;
			if (session.etsModel.reversalEtsNumber) {
				remarkIds.add(session?.etsModel?.reversalEtsNumber?.toString())
			}

			remarkIds.add(session?.etsModel?.serviceInstructionId?.toString())
		}

		if ("DATA_ENTRY".equalsIgnoreCase(params.referenceType)) {
			if (session?.dataEntryModel?.serviceInstructionId){
				if (session?.dataEntryModel?.reversalEtsNumber){
					remarkIds.add(session?.dataEntryModel?.reversalEtsNumber?.toString())
				} else {
					remarkIds.add(session?.dataEntryModel?.serviceInstructionId?.toString())
				}
			}
			remarkIds.add(session?.dataEntryModel?.tradeServiceId?.toString())
		}

		if ("OUTGOING_MT".equalsIgnoreCase(params.referenceType)) {
			remarkIds.add(session?.mtModel?.tradeServiceId?.tradeServiceId?.toString())
		}
		return remarkIds;
	}

    private String getServiceInstructionId(){
        return session?.dataEntryModel?.tradeServiceId ?: session?.etsModel?.serviceInstructionId;
    }

    def getChargesOverridenFlag() {
        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")

        render(chargesOverridenFlagMap as JSON)
    }
	
	def validateCutOffTime(){
						
		def returnValues = coreAPIService.dummySendCommand(params, "validate", "cutOff/").details
		
		println "CUTOFF STATUS " + returnValues
		
		render([cutOffStatus: returnValues?.cutOffStatus, cutOffTime: returnValues?.cutOffTime] as JSON)
	}
}
