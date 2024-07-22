package com.ucpb.tfsweb.main

import org.springframework.transaction.annotation.Transactional
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils

class DocumentFormatService {

    def queryService

    def documentFormatFinder = com.ucpb.tfs.application.query.reference.IDocumentFormatReferenceFinder.class

	@Transactional(readOnly=true)
	List<String> findAllDocumentFormat() {
		String methodName = "findAllDocumentFormat"

		Map<String, Object> param = [:]
		
		List<Map<String, Object>> queryResult = queryService.executeQuery(documentFormatFinder, methodName, param)

		if (queryResult) {
			if (queryResult.size() == 0) {
				return []
			}
		}
		
		return queryResult["FORMATCODE"]
	}
	
    @Transactional(readOnly=true)
    List<String> findAllDocumentFormatByTagging(tagging) {
        String methodName = "findAllDocumentFormatByTagging"
		println "tagging: "+tagging

        Map<String, Object> param = [tagging:tagging]
		println "param: "+param
        
        List<Map<String, Object>> queryResult = queryService.executeQuery(documentFormatFinder, methodName, param)

        println "queryResult: " + queryResult 
        if (!queryResult) {
            return ["PERFORMANCE"]
        } else {
            return queryResult["FORMATCODE"]?:""
        }
		

    }

    @Transactional(readOnly=true)
    String findDocumentFormat(formatCode, dataEntryModel) {
        String methodName = "findAllDocumentFormatByFormatCode"

        Map<String, Object> param = [formatCode: formatCode]

        List<Map<String, Object>> queryResult = queryService.executeQuery(documentFormatFinder, methodName, param)

        String formatDescription = queryResult["FORMATDESCRIPTION"][0]
		String ws = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" 
		
		String description
		if(formatDescription != null) {
			description = formatDescription.replaceAll("<nl>", "<br/>").replaceAll("<ws>", ws)
		} else {
			description = ""
		}
        
        description = description.replaceAll("<DOCUMENT_NUMBER>", dataEntryModel.documentNumber)
        description = description.replaceAll("<CURRENT_DATE>", DateUtils.fullDateFormat(new Date()).toUpperCase())
        description = description.replaceAll("<FORM_OF_DOCUMENTARY_CREDIT>", evaluateFormOfDocumentaryCredit(dataEntryModel.formOfDocumentaryCredit) ?: 'IRREVOCABLE')
        description = description.replaceAll("<IMPORTER_NAME>", dataEntryModel.importerName ?: dataEntryModel.applicantName ?: "(IMPORTER NAME)")
        description = description.replaceAll("<IMPORTER_ADDRESS>", dataEntryModel.importerAddress ?: dataEntryModel.applicantAddress ?: "(IMPORTER ADDRESS)")
        description = description.replaceAll("<EXPORTER_NAME>", (dataEntryModel.exporterName ?: dataEntryModel.beneficiaryName ?: "(EXPORTER NAME)").toUpperCase())
        description = description.replaceAll("<EXPORTER_ADDRESS>", (dataEntryModel.exporterAddress ?: dataEntryModel.beneficiaryAddress ?: "(EXPORTER ADDRESS)").toUpperCase())
        description = description.replaceAll("<CIF_NAME>", dataEntryModel.cifName)
        description = description.replaceAll("<CIF_ADDRESS>", dataEntryModel.address1 + (dataEntryModel.address2 ? (", " + dataEntryModel.address2) : ""))
        description = description.replaceAll("<CURRENCY>", dataEntryModel.currency)
        description = description.replaceAll("<AMOUNT_IN_WORDS>", NumberUtils.convert(new BigDecimal(dataEntryModel.amount).setScale(2), dataEntryModel.currency).toUpperCase())
        description = description.replaceAll("<AMOUNT>", dataEntryModel.currency + " " + NumberUtils.currencyFormat(new Double(dataEntryModel.amount)))
		description = description.replaceAll("<DESCRIPTION_OF_GOODS_SERVICES>", dataEntryModel.descriptionOfGoodsServices ?: "(DESCRIPTION OF GOODS AND SERVICES)")
		description = description.replaceAll("<PURPOSE_OF_STANDBY>", dataEntryModel.purposeOfStandby ? dataEntryModel.purposeOfStandby.toUpperCase() : "(PURPOSE OF STANDBY)")
		description = description.replaceAll("<ISSUE_DATE>", DateUtils.fullDateFormat(dataEntryModel.issueDate ? new Date(dataEntryModel.issueDate) : new Date()).toUpperCase())
        description = description.replaceAll("<PROCESS_DATE>", DateUtils.fullDateFormat(dataEntryModel.processDate ? new Date(dataEntryModel.processDate) : new Date()).toUpperCase())
        description = description.replaceAll("<EXPIRY_DATE>", DateUtils.fullDateFormat(new Date(dataEntryModel.expiryDate)).toUpperCase())
        description = description.replaceAll("<EXPIRY_COUNTRY>", dataEntryModel.expiryCountry ?: "(EXPIRY COUNTRY)")
        description = description.replaceAll("<APPLICABLE_RULES>", dataEntryModel.applicableRules ?: 'UCP')
        description = description.replaceAll("<AVAILABLE_WITH>", dataEntryModel.availableWith ?: "ANY BANK")
        description = description.replaceAll("<AVAILABLE_WITH_ADDRESS>", dataEntryModel.nameAndAddress ? dataEntryModel.nameAndAddress.toUpperCase() : "(NAME AND ADDRESS)")
		
		description = description.replaceAll("<BID_DATE>", "(BID DATE)")
		description = description.replaceAll("<ISSUE_DATE_FINANCIAL>", DateUtils.fullDateFormat2(dataEntryModel.issueDate ? new Date(dataEntryModel.issueDate) : new Date()))
        description = description.replaceAll("<PROCESS_DATE_FINANCIAL>", DateUtils.fullDateFormat2(dataEntryModel.processDate ? new Date(dataEntryModel.processDate) : new Date()))
		description = description.replaceAll("<EXPIRY_MINUS_ISSUE_DATE>", "(EXPIRY SANS ISSUE DATE)")
		description = description.replaceAll("<CONTRACT_ADDRESS>", "(Contract Address)")
		description = description.replaceAll("<BANK_ADDRESS>", "(Bank Address)")
		
        return description
    }
	
	String evaluateFormOfDocumentaryCredit(String formOfDocumentaryCredit){
		switch(formOfDocumentaryCredit){
			case "IS":
				return "IRREVOCABLE STANDBY"
			case "RS":
				return "REVOCABLE STANDBY"
			case "ITS":
				return "IRREVOCABLE TRANSFERABLE STANDBY"
			default:
				return null
		}
	}
	
}
