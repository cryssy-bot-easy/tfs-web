package com.ucpb.tfsweb.main.other.exports

import com.ucpb.tfs.application.command.SaveChargesFormDataEntryCommand

class ExportBillsService {

    def dataEntryService
    def parserService
    def commandService
    def commandBusService

    def queryService

    def tradeServiceFinder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class;

    Map<String, Object> updateExportBillsDataEntry(params) {
        ////println"updateDataEntry"
        String saveAs = params.saveAs

        // removes action and controller parameters
        params.remove("action")
        params.remove("controller")

//        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.username:"+params.username
//        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.unitcode:"+params.unitcode

        Map<String, String> parameterMap = new HashMap<String, String>()

        // default required documents
        if(params.requiredDocumentsList) {
            params.requiredDocumentsList = parserService.parseGrid(params.requiredDocumentsList)
        }

        if(params.proceedsPaymentSummary) {
            params.proceedsPaymentSummary = parserService.parseGrid(params.proceedsPaymentSummary)
        }

        // new required documents
        if(params.addedDocumentsList) {
            params.addedDocumentsList = parserService.parseGrid(params.addedDocumentsList)
        }

        // default instructions to the paying/accepting/negotiating bank
        if(params.instructionToBankList) {
            params.instructionToBankList = parserService.parseGrid(params.instructionToBankList)
        }

        // default additional condition
        if(params.additionalConditionsList) {
            params.additionalConditionsList = parserService.parseGrid(params.additionalConditionsList)
        }

        // new additional condition
        if(params.addedAdditionalConditionsList) {
            params.addedAdditionalConditionsList = parserService.parseGrid(params.addedAdditionalConditionsList)
        }

        // transmittal letter
        if(params.transmittalLetterList) {
            params.transmittalLetterList = parserService.parseGrid(params.transmittalLetterList)
            params.remove("originalCopy")
            params.remove("duplicateCopy")
        }

        if(params.addedTransmittalLetterList) {
            params.addedTransmittalLetterList = parserService.parseGrid(params.addedTransmittalLetterList)
            params.remove("originalCopy")
            params.remove("duplicateCopy")
        }

        // swift charges
        if(params.swiftChargesList) {
            params.swiftChargesList = parserService.parseGrid(params.swiftChargesList)
            params.remove("swiftCurrency")
            params.remove("swiftAmount")
//            params.remove("swiftChargesList")
        }
        // sets value of parameter map
        params.each {
            if(!(it.value instanceof java.util.List)) {
                Scanner scanner = new Scanner(it.value)

                if(scanner.hasNextBigDecimal() && !(it.key.contains("address") || it.key.contains("Address"))){
                    it.value = scanner.nextBigDecimal().toString()
                }
            }

            ////println">>>>>>>>>>>>>>>>>>>>>>>> " + it.value + " = " + it.value.getClass()
            parameterMap.put(it.key, it.value)
        }

        String statusAction = params.statusAction ?: ""

        updateExportBillsCommand(params.form, parameterMap, statusAction)

//        Map<String, Object> dataEntry = getDataEntry(params.tradeServiceId)
        Map<String, Object> dataEntry = null;
        try {
            dataEntry = dataEntryService.getDataEntry(params.tradeServiceId)
        } catch(Exception e) {
            // encountered for non ets data entry
            ////println"non - lc"
            dataEntry = dataEntryService.getNonEtsDataEntry(params.tradeServiceId)
        }

        return dataEntry
    }

    void updateExportBillsCommand(form, parameterMap, statusAction) {
        if(statusAction.equals("Return eTS to Branch")) {
            statusAction = "Return"
        }

        def command = new SaveChargesFormDataEntryCommand() //commandSetter(form, statusAction)
        ////println"updateCommand:" + command
        ////println"statusAction:" + statusAction
        //parameterMap

        ////printlnparameterMap

        command.setUserActiveDirectoryId(parameterMap.get("username"))
        command.setParameterMap(parameterMap)

        try {

            commandBusService.dispatch(command)
            // dispatch the command via the REST API instead of the RMI dispatcher
//            coreAPIService.sendProxiedCommand(command)

        } catch(Exception e) {
            e.printStackTrace()
        }
    }

    def searchExportBills(paramMap, maxRows, currentPage, rowOffset) {
        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceFinder, "findAllExportBills", paramMap)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
}
