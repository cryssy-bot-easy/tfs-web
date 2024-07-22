package com.ucpb.tfsweb.mt

class IncomingMtController {

    def mtService
    def routingInformationService
    def coreAPIService
    
    protected String SOURCE_TYPE = "INCOMING"

    def viewIncomingMt() {
        if(chainModel) {
            session.mtModel = chainModel
        }

        if(session.mtModel) {
            if (session.mtModel.errorMessage) {
                flash.message = session.mtModel.errorMessage
            }
            session.mtModel.remove("errorMessage")

            render(view:"/mt/index", model: chainModel ?: session.mtModel)
        }else {
            render(view: "/main/unauthorized")
        }
    }

    def viewIncomingMtMessage() {
        String headerTitle = "Incoming MT Monitoring - MT Message"
        println "<<<<<<<<<<< " + params
        session.mtModel = [sourceType: SOURCE_TYPE, title: headerTitle, userType: params.userType]

        if (params.id) {
            //printlnparams.id
            Map<String, Object> mtMessageMap = mtService.getMtMessage(params.id)

            mtMessageMap.each {
                println it
                session.mtModel << it
            }

            def tradeService = coreAPIService.dummySendQuery([tradeServiceId: mtMessageMap.tradeServiceId], "details", "tradeservice/")?.details
            //println 'OOOOOOOOOOOOOOOOOOOOOOO ' + tradeService

            println ">>>>>>>> " + tradeService

            session.mtModel << [canCreateLC: "ABORTED".equals(tradeService?.status) ? true : false]
        }

        session.nextRoute = toSelect(routingInformationService.getAllTsdMakers());

        // chain to render page
        chain(action:"viewIncomingMt", model: session.mtModel)
    }

    def updateIncomingMtMessage() {
        params.statusAction = "update"

        Map<String, Object> mtMessageMap = mtService.updateMtMessage(params)

        String headerTitle = "Incoming MT Monitoring - MT Message"

        session.mtModel = [sourceType: SOURCE_TYPE, title: headerTitle, userType: "APPROVER"]

        mtMessageMap.each {
                session.mtModel << it
        }

        chain(action: "viewIncomingMt", model: session.mtModel)
    }

    def routeMtMessage() {
        params.statusAction = "route"

        Map<String, Object> mtMessageMap = mtService.updateMtMessage(params)

        String headerTitle = "Incoming MT Monitoring - MT Message"

        session.mtModel = [sourceType: SOURCE_TYPE, title: headerTitle, userType: "APPROVER"]

        mtMessageMap.each {
            session.mtModel << it
        }

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def closeMtMessage() {
        Map<String, Object> tradeServiceMap = mtService.getMtMessage(params.id)

        String headerTitle = "Incoming MT Monitoring - MT Message"
        session.mtModel = [sourceType: SOURCE_TYPE, title: headerTitle, userType: "MAKER"]
        
        if (tradeServiceMap != null) {
            params.statusAction = "close"

            Map<String, Object> mtMessageMap = mtService.updateMtMessage(params)

            mtMessageMap.each {
                session.mtModel << it
            }

            redirect(controller: "unactedTransactions", action: "viewUnacted")
        } else {
            String errorMessage = "MT message no longer exists."
            
            session.mtModel << [errorMessage: errorMessage]

            Map<String, Object> mtMessageMap = mtService.getMtMessage(params.id)

            mtMessageMap.each {
                session.mtModel << it
            }
            
            chain(action: "viewIncomingMt", model: session.mtModel)
        }
    }

    def returnMtMessage() {
        params.statusAction = "return"

        Map<String, Object> mtMessageMap = mtService.updateMtMessage(params)

        String headerTitle = "Incoming MT Monitoring - MT Message"

        session.mtModel = [sourceType: SOURCE_TYPE, title: headerTitle, userType: "APPROVER"]

        mtMessageMap.each {
            session.mtModel << it
        }

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    private Map<String,String> toSelect(input){
        Map<String,String> selectItems = new HashMap<String,String>();
        input.each{
            selectItems.put(it.ID,(it.LASTNAME + "," + it.FIRSTNAME));
        }
        return selectItems;
    }

    def createLc() {
        def parsedLcFromMt = mtService.generateTradeServiceFromMt(params.id).details

        chain(controller: "exportAdvising", action: "viewOpeningFirst", model: [parsedLc: parsedLcFromMt])
    }
}
