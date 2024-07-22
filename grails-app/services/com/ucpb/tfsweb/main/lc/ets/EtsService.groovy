package com.ucpb.tfsweb.main.lc.ets

import com.ibm.icu.text.SimpleDateFormat
import grails.converters.JSON
import net.ipc.utils.DateUtils

import java.text.ParseException

/*	PROLOGUE:
 * 	(revision)
	SCR/ER Number: 20151118-063
	SCR/ER Description: FX UA Loan Settlement cannot create Ets entry, error message show "UA Loan Payment did not match".
	[Revised by:] Jesse James Joson
	[Date revised:] 11/25/2015
	Program [Revision] Details: Compare the PHP settlement amount with the original amount for settlement converted to PHP. 
	PROJECT: WEB
	MEMBER TYPE  : Groovy
 */
 
/*	PROLOGUE:
 * 	(revision)
	SCR/ER Number: ER# 20161108-037
	SCR/ER Description: Double reinstatement entry due to two transaction on an account, first ets was not yet approved  by TSD.
	[Revised by:] Jesse James Joson
	[Date revised:] 11/09/2016
	Program [Revision] Details: Transaction will be created if there is no pending transaction on the said account.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: EtsService
 */
 
 /**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: EtsService
 */

 
 

/*
	 (revision)
	 SCR/ER Number: ER# 20170109-040
	 SCR/ER Description: Transaction allowed to be created even the facility is expired
	 [Revised by:] Jesse James Joson
	 [Date revised:] 1/17/2017
	 Program [Revision] Details: Check the expiry date of the facility before allowing to amend LC
	 Member Type: Groovy
	 Project: WEB
	 Project Name: EtsService.groovy
*/

class EtsService {

    def commandService
    def queryService
    def parserService
    def foreignExchangeService
    def ratesService
	def facilityService

    def coreAPIService

    def chargesPaymentService

    def finder = com.ucpb.tfs.application.query.instruction.IServiceInstructionFinder.class
    def attachmentFinder = com.ucpb.tfs.application.query.instruction.IAttachmentFinder.class
    def valueHolderFinder = com.ucpb.tfs.application.query.reference.IValueHolderFinder.class

    // return ets
    Map<String, Object> getEts(etsNumber) {

        // sets method name and parameters
        String methodName = "findServiceInstruction"

        Map<String, Object> param = [etsNumber: etsNumber]
	
        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
	
        Map<String, Object> details = JSON.parse(queryResult[0]?.DETAILS)

        Map<String, Object> ets = new HashMap<String, Object>()

        details.each {
            ets.put(it.key, it.value)
        }

        ets.put("approvers", queryResult[0].APPROVERS)
        ets.put("serviceInstructionId",queryResult[0].SERVICEINSTRUCTIONID)
        ets.put("status",queryResult[0].STATUS)
        ets.put("tradeServiceId",queryResult[0].TRADESERVICEID)


//        def servicePaymentCount = chargesPaymentService.findServiceChargesPayment(10, 0, 1, queryResult[0].TRADESERVICEID).totalRows
//        def productPaymentCount = chargesPaymentService.findProductChargesPayment(10, 0, 1, queryResult[0].TRADESERVICEID).totalRows
//
//        if (servicePaymentCount > 0 && productPaymentCount > 0) {
//            ets.put("paymentComplete", true)
//        } else {
//            ets.put("paymentComplete", false)
//        }

        ets.put("paymentStatus", queryResult[0].PAYMENTSTATUS)
        ets.put("documentClass", queryResult[0].DOCUMENTCLASS)
        ets.put("documentType", queryResult[0].DOCUMENTTYPE)
        ets.put("documentSubType1", queryResult[0].DOCUMENTSUBTYPE1)
        ets.put("documentSubType2", queryResult[0].DOCUMENTSUBTYPE2)
        ets.put("documentNumber", queryResult[0].DOCUMENTNUMBER)

        return ets
    }

    // return list of all ets
    Map<String, Object> findAllEts(maxRows, rowOffset, currentPage) {
        String methodName = "findAllServiceInstruction"

        Map<String, Object> param = [:]

        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // return list of all approved ets
    Map<String, Object> findAllApprovedEtsWithParams(maxRows, rowOffset, currentPage, params) {
        String methodName = "etsInquiry"
//        List<String> transactionType = (params.transactionType) ? params.transactionType?.split("-") : null
        ////printlnparams
        Map<String, Object> param = [etsNumber: params.etsNumber ?: "",
                                     cifName: params.cifName ?: "",
                                     documentType: params.documentType ?: "", //(transactionType) ? (transactionType[0].equals("") ? "" : transactionType[0]) : "",
                                     documentClass: params.documentClass ?: "", //(transactionType) ? transactionType[1] : "",
                                     documentSubType1: params.documentSubType1 ?: "", //(transactionType) ? transactionType[2] : "",
                                     serviceType: params.transactionType ?: "", //(transactionType) ? transactionType[3] : "",
                                     status: params.status ?: "",
                                     createdDate: params.createdDate ?: "",
                            		 modifiedDate: params.modifiedDate ?: "",
                    				 approvedDate: params.approvedDate ?: "",
									 userId: params.userId ?: "",
                                     cifNumber: params.cifNumber ?: "",
                                     userActiveDirectoryId: params.userActiveDirectoryId ?: "",
									 unitcode: params.unitcode ?: ""
        ]

        List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // return list of ets with criteria
    List<Map<String, Object>> findEtsBy() {
        // TODO find ets by criteria
    }

    Map<String, Object> saveEts(params) {
        println "saveEts"
        String saveAs = params.saveAs

        // removes action and controller parameters
        params.remove("form")
        params.remove("action")
        params.remove("controller")
        params.remove("saveAs")
        params.remove("paramz")

        Map<String, String> parameterMap = new HashMap<String, String>()

        // sets value of parameter map
        params.each {
            Boolean skip= false;
            ////printlnit.key + "=" + it.value + " > " + it.value.getClass()
			if(it.key.equalsIgnoreCase("ccbdBranchUnitCode") || it.key.equalsIgnoreCase("unitcode")) {
				println "unit code key: " + it.key + ", value: " + it.value
//					it.value = String.format("%03d", Integer.parseInt(it.value))
        	} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Maturity Adjustment")) {
                it.value = "UA_LOAN_MATURITY_ADJUSTMENT"
            } else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Settlement")) {
                it.value = "UA_LOAN_SETTLEMENT"
            } else if(it.key.equalsIgnoreCase("documentPaymentSummary")) {
			println "documentPaymentSummary: " +params.documentPaymentSummary
			println "parserService.parseGrid(documentPaymentSummary): " +parserService.parseGrid(params.documentPaymentSummary)
//                it.value = parserService.parseGrid(params.documentPaymentSummary)
            } else if(it.value.getClass().toString().equalsIgnoreCase("class [Ljava.lang.String;")){
                ////println"please see markup, a String List was returned, will choose first entry. The Key" + it.key + "is duplicated"
                ////printlnit.value
                List tmpList = it.value
                if (!tmpList.isEmpty() && tmpList[0]!=null && tmpList[0]!="")
                {
                    it.value = tmpList[0]
                    skip = false

                } else {
                    skip= true
                }
            } else {
                Scanner scanner = new Scanner(it.value)

                //if(scanner.hasNextBigDecimal() && !(it.key.contains("address") || it.key.contains("Address") || it.key.contains("description") || it.key.contains("Description") || it.key.contains("Narrative"))){
                if (scanner.hasNextBigDecimal()) {
                    if (hasLetters(it.value.toString()) ||
						it.key?.toString()?.toUpperCase().contains("PARTICIPANTCODE") ||
						it.key?.toString()?.toUpperCase().contains("TINNUMBER") ||
						it.key?.toString()?.toUpperCase().contains("COMMODITYCODE")) {
                        it.value = it.value
                    } else {
                        it.value = scanner?.nextBigDecimal()?.toString()
                    }
                } else {
                    it.value = it.value
                }
            }
            if(!skip){
                parameterMap.put(it.key, it.value)
            }else {

            }

        }

        //TODO Change This
        def exchangeRate = foreignExchangeService.extractExchangeRateByBaseCurrency(ratesService.getRatesByBaseCurrency().display, params)
        def exchangeRateUrr = foreignExchangeService.extractExchangeRateUsdToPhpUrr(ratesService.getRatesByBaseCurrency().display, params)
        def usdToPHPSpecialRateExchangeRate = foreignExchangeService.extractUsdToPhpRate(ratesService.getRatesByBaseCurrency().display, ['currency':''])
        def baseCurrency = foreignExchangeService.extractCorrectCurrency(params)
        if(baseCurrency.toString().equalsIgnoreCase("USD")){
            parameterMap.put("creationExchangeRate",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))
        } else {
            parameterMap.put("creationExchangeRate",exchangeRate.setScale(6,BigDecimal.ROUND_HALF_UP))
        }
        parameterMap.put("creationExchangeRateUsdToPHPSpecialRate",usdToPHPSpecialRateExchangeRate['USD-PHP'].setScale(6,BigDecimal.ROUND_HALF_UP))
        parameterMap.put("creationExchangeRateUsdToPHPUrr",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))
        parameterMap.put("urr",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))

        println "baseCurrency:"+baseCurrency
        if(!baseCurrency.toString().equalsIgnoreCase("PHP") && !baseCurrency.toString().equalsIgnoreCase("USD") &&!baseCurrency.toString().equalsIgnoreCase("null")){
            def thirdToUsd = foreignExchangeService.extractExchangeRateByBaseCurrencyAngol(ratesService.getRatesByBaseCurrency().display,params)
            println "thirdToUsd:"+thirdToUsd
            parameterMap.put(baseCurrency+"-USD",thirdToUsd.setScale(8,BigDecimal.ROUND_UP))
        }

		
		//Normalize expiry Date Before Saving
		String expiryDate = parameterMap.get("expiryDate")
		if(expiryDate != null){
			try{
				parameterMap.put("expiryDate",DateUtils.normalizeExpiryDate(expiryDate))
			}catch(ParseException ex){
				throw new ParseException("Erroneous Date was not parsed successfully.",ex)
			}
		}

		String tokenValue = commandService.createCommand(parameterMap, saveAs)
		println "token value:	"+tokenValue
        String etsNumber = ""

        try {
            etsNumber = queryService.retrieveEtsNumberFromToken(tokenValue)
			println"etsNumber: " + etsNumber
        } catch(Exception e) {
            e.printStackTrace()
        }

        Map<String, Object> ets = getEts(etsNumber)

        return ets
    }

    Map<String, Object> updateEts(params) {
        //println"updateEts"
        // removes action and controller parameters
        params.remove("action")
        params.remove("controller")
        params.remove("paramz")

        // charges payment made
        if(params.chargesPaymentSummary) {
            params.chargesPaymentSummary = parserService.parseGrid(params.chargesPaymentSummary)
        }

        // lc payment made
        if(params.documentPaymentSummary) {
            params.documentPaymentSummary = parserService.parseGrid(params.documentPaymentSummary)
        }

        // proceeds payment made
        if(params.proceedsPaymentSummary) {
            params.proceedsPaymentSummary = parserService.parseGrid(params.proceedsPaymentSummary)
        }

        String statusAction = params.statusAction ?: ""
        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.username:"+params.username
        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.unitcode:"+params.unitcode

        Map<String, String> parameterMap = new HashMap<String, Object>()

        // set value of parameter map
        params.each {
            Boolean skip= false;
            ////printlnit.key + "=" + it.value + " > " + it.value.getClass()
            if(!(it.value instanceof java.util.ArrayList)) {
                if(it.key.equalsIgnoreCase("ccbdBranchUnitCode") || it.key.equalsIgnoreCase("unitcode")) {
					println "unit code key: " + it.key + ", value: " + it.value
//					if(it.value.length() > 0 && it.value.length() < 3 && String.format("%03d", Integer.parseInt(it.value)) != "000"){
//						it.value = String.format("%03d", Integer.parseInt(it.value))
//					}
	        	} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Maturity Adjustment")) {
                    it.value = "UA_LOAN_MATURITY_ADJUSTMENT"
                } else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Settlement")) {
                    it.value = "UA_LOAN_SETTLEMENT"
                } else if(it.value.getClass().toString().equalsIgnoreCase("class [Ljava.lang.String;")) {
                    //println"please see markup, a String List was returned, will choose first entry. The Key" + it.key + "is duplicated"
                    //printlnit.value
                    List tmpList = it.value
                    if (!tmpList.isEmpty() && tmpList[0]!=null && tmpList[0]!="")
                    {
                        it.value = tmpList[0]
                        skip = false

                    } else {
                        skip= true
                    }



                } else {
                    Scanner scanner = new Scanner(it.value)

//                    if(scanner.hasNextBigDecimal() && !(it.key.contains("address") || it.key.contains("Address"))){
//                        it.value = scanner.nextBigDecimal().toString()
//                    } else {
//                        //it.value = it.value
//                    }
                    if (scanner.hasNextBigDecimal()) {
                        if (hasLetters(it.value.toString()) || 
							it.key?.toString()?.toUpperCase().contains("ACCOUNTNUMBER") ||
							it.key?.toString()?.toUpperCase().contains("REFERENCENUMBER") ||
							it.key?.toString()?.toUpperCase().contains("PARTICIPANTCODE") ||
							it.key?.toString()?.toUpperCase().contains("TINNUMBER") ||
							it.key?.toString()?.toUpperCase().contains("COMMODITYCODE") ||
							it.key?.toString()?.toUpperCase().matches(".*MT\\d\\d\\d.*")) {
                            it.value = it.value
                        } else {
                            it.value = scanner?.nextBigDecimal()?.toString()
                        }
                    }  else {
                        it.value = it.value
                    }
                }
            }



            if(!skip){
                parameterMap.put(it.key, it.value)
            }else {

            }

            //parameterMap.put(it.key, it.value)
        }

        println  "params.form.toString():"+ params.form.toString()

        if(params.form.toString().equalsIgnoreCase("natureOfAmendment")){
            ////println"in nature of amendment rates insertion"
            def exchangeRate = foreignExchangeService.extractExchangeRateByBaseCurrency(ratesService.getRatesByBaseCurrency().display, params)
            def exchangeRateUrr = foreignExchangeService.extractExchangeRateUsdToPhpUrr(ratesService.getRatesByBaseCurrency().display, params)
            def usdToPHPSpecialRateExchangeRate = foreignExchangeService.extractUsdToPhpRate(ratesService.getRatesByBaseCurrency().display, ['currency':''])
            def baseCurrency = foreignExchangeService.extractCorrectCurrency(params)
            if(baseCurrency.toString().equalsIgnoreCase("USD")){
                parameterMap.put("creationExchangeRate",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))
            } else {
                parameterMap.put("creationExchangeRate",exchangeRate.setScale(6,BigDecimal.ROUND_HALF_UP))
            }
            parameterMap.put("creationExchangeRate",exchangeRate.setScale(6,BigDecimal.ROUND_HALF_UP))
            parameterMap.put("creationExchangeRateUsdToPHPSpecialRate",usdToPHPSpecialRateExchangeRate['USD-PHP'].setScale(6,BigDecimal.ROUND_HALF_UP))
            parameterMap.put("creationExchangeRateUsdToPHPUrr",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))
            parameterMap.put("urr",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))

            println "baseCurrency:"+baseCurrency
            if(!baseCurrency.toString().equalsIgnoreCase("PHP") && !baseCurrency.toString().equalsIgnoreCase("USD") && !baseCurrency.toString().equalsIgnoreCase("null")){
                def thirdToUsd = foreignExchangeService.extractExchangeRateByBaseCurrencyAngol(ratesService.getRatesByBaseCurrency().display,params)
                println "thirdToUsd:"+thirdToUsd
                parameterMap.put(baseCurrency+"-USD",thirdToUsd.setScale(8,BigDecimal.ROUND_UP))
            }
        }
		
		println "PARAM MAP"+parameterMap
        commandService.updateCommand(params.form, parameterMap, statusAction)

        Map<String, Object> ets = getEts(params.etsNumber)

        return ets
    }

	String uploadAttachedToEts(params) {
		////println"uploadAttachedToEts"
		// removes action and controller parameters
		params.remove("action")
		params.remove("controller")
		params.remove("fileLocation")
		params.form = "attachedDocuments"
		params.statusAction = "uploadDocument"


		String statusAction = params.statusAction ?: ""
		String docType = params.docType ?: ""

		Map<String, String> parameterMap = new HashMap<String, String>()

		// set value of parameter map
		params.each {
			parameterMap.put(it.key, it.value)
		}

		String token = commandService.uploadCommand(parameterMap)

		//Map<String, Object> ets = getEts(params.etsNumber)

		return token
	}

	//Returns attachment list from query
	def getAttachmentList(maxRows, rowOffset, currentPage){
        String methodName = "findAttachmentsOfEts"
		Map<String, Object> param = [:]
		List<Map<String, Object>> queryResult = queryService.executeQuery(finder01, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()

		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()?:0]

	}


    //Returns attachment list from query
    def getAttachmentList( maxRows, rowOffset, currentPage, etsNumberHolder){
        //String methodName = "findAttachmentsOfEts"
        String methodName = "findAttachmentsOfEts"
        Map<String, Object> param = [serviceInstructionId:etsNumberHolder]
        List<Map<String, Object>> queryResult = queryService.executeQuery(attachmentFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()

        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()?:0]

    }

    //Returns Grid Formatted Attachment list
    def getGridFormattedAttachments(List display, String tradeServiceId) {
        def list = display.collect { attach ->
            [id: attach.ID,
                    cell:[
                            attach.ATTACHMENTTYPE?:'--',
                            attach.FILENAME?:'filename',
                            attach.CREATEDDATE ? DateUtils.dateTimeFormat(attach.CREATEDDATE) : '--',
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + attach.ID + "'; var tradeServiceId='"+ tradeServiceId + "'; var grid_id='grid_list_attached_documents'; onViewFileClicked(id,grid_id,tradeServiceId);\">view</a>",
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id='" + attach.ID + "'; var tradeServiceId='"+ tradeServiceId + "'; var grid_id='grid_list_attached_documents'; onDeleteFileClicked(id,grid_id,tradeServiceId);\">delete</a>"
                    ]
            ]
        }

        return list

    }
	
	//Returns Grid Formatted Attachment list
	def getGridFormattedAttachmentsReadonly(List display, String tradeServiceId) {
		def list = display.collect { attach ->
			[id: attach.ID,
					cell:[
							attach.ATTACHMENTTYPE?:'--',
							attach.FILENAME?:'filename',
							attach.CREATEDDATE ? DateUtils.dateTimeFormat(attach.CREATEDDATE) : '--',
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + attach.ID + "'; var tradeServiceId='"+ tradeServiceId + "'; var grid_id='grid_list_attached_documents'; onViewFileClicked(id,grid_id,tradeServiceId);\">view</a>",
							""
					]
			]
		}

		return list

	}
	
    //return Computed Value from value holder
    def getComputedValue(String token){
        String methodName = "getValue"
        Map<String, Object> param = [token:token]
        List<Map<String, Object>> queryResult = queryService.executeQuery(valueHolderFinder, methodName, param)

        def temp = queryResult.get(0)
        def tmpString  = temp['VALUE'].toString()
        BigDecimal result = new BigDecimal(tmpString)

        return result
    }

    //returns computes and returns computed value
    def computeValue(params){
        Map<String, String> parameterMap = new HashMap<String, String>()

        // sets value of parameter map
        params.each {
            ////printlnit.key + "=" + it.value + " > " + it.value.getClass()
            if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Maturity Adjustment")) {
                it.value = "UA_LOAN_MATURITY_ADJUSTMENT"
            } else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Settlement")) {
                it.value = "UA_LOAN_SETTLEMENT"
            } else if(it.key.equalsIgnoreCase("documentPaymentSummary")) {
                it.value = parserService.parseGrid(params.documentPaymentSummary)
            } else {
                Scanner scanner = new Scanner(it.value)

                if(scanner.hasNextBigDecimal()){
                    it.value = scanner.nextBigDecimal().toString()
                } else {
                    it.value = it.value
                }
            }
            parameterMap.put(it.key, it.value)
        }

        String tokenValue = commandService.computeCommand(parameterMap)

        return tokenValue
    }

    String dummySaveEts(params) {
        String saveAs = params.saveAs

        // removes action and controller parameters
        params.remove("form")
        params.remove("action")
        params.remove("controller")
        params.remove("saveAs")
        params.remove("paramz")

        Map<String, String> parameterMap = new HashMap<String, String>()

        // sets value of parameter map
        params.each {
            Boolean skip= false;
            if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Maturity Adjustment")) {
                it.value = "UA_LOAN_MATURITY_ADJUSTMENT"
            } else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Settlement")) {
                it.value = "UA_LOAN_SETTLEMENT"
            } else if(it.key.equalsIgnoreCase("documentPaymentSummary")) {
                it.value = parserService.parseGrid(params.documentPaymentSummary)
            } else if(it.value.getClass().toString().equalsIgnoreCase("class [Ljava.lang.String;")){
                List tmpList = it.value
                if (!tmpList.isEmpty() && tmpList[0]!=null && tmpList[0]!="")
                {
                    it.value = tmpList[0]
                    skip = false

                } else {
                    skip= true
                }
            } else {
                Scanner scanner = new Scanner(it.value)

                if(scanner.hasNextBigDecimal() && !(it.key.contains("address") || it.key.contains("Address"))){
                    it.value = scanner.nextBigDecimal().toString()
                } else {
                    it.value = it.value
                }
            }
            if(!skip){
                parameterMap.put(it.key, it.value)
            }else {

            }

        }

        //TODO Change This
        def exchangeRate = foreignExchangeService.extractExchangeRateByBaseCurrency(ratesService.getRatesByBaseCurrency().display, params)
        def exchangeRateUrr = foreignExchangeService.extractExchangeRateUsdToPhpUrr(ratesService.getRatesByBaseCurrency().display, params)
        def usdToPHPSpecialRateExchangeRate = foreignExchangeService.extractUsdToPhpRate(ratesService.getRatesByBaseCurrency().display, ['currency':''])
        def baseCurrency = foreignExchangeService.extractCorrectCurrency(params)
        if(baseCurrency.toString().equalsIgnoreCase("USD")){
            parameterMap.put("creationExchangeRate",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))
        } else {
            parameterMap.put("creationExchangeRate",exchangeRate.setScale(6,BigDecimal.ROUND_HALF_UP))
        }
        parameterMap.put("creationExchangeRateUsdToPHPSpecialRate",usdToPHPSpecialRateExchangeRate['USD-PHP'].setScale(6,BigDecimal.ROUND_HALF_UP))
        parameterMap.put("creationExchangeRateUsdToPHPUrr",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))
        parameterMap.put("urr",exchangeRateUrr.setScale(6,BigDecimal.ROUND_HALF_UP))

        String tokenValue = commandService.createCommand(parameterMap, saveAs)

        String etsNumber = ""

        try {
            etsNumber = queryService.retrieveEtsNumberFromToken(tokenValue)
        } catch(Exception e) {
            e.printStackTrace()
        }

        return etsNumber
    }

    def validateMultipleServiceInstruction(tradeProductNumber, serviceType, serviceInstructionId, docType) {
        println serviceType
		
		if (serviceType != null && serviceType.toString().equalsIgnoreCase("amendment") && (docType in ["regular", "standby"])) {
			if(isFacilityExpired(tradeProductNumber) == true){ // if true = expired
				println ">>>>>tradeProductNumber " + tradeProductNumber
				return [success: "false", message: "The facility used is already expired, please validate in CLS.", action: "abort"]
			}
		}
		
        def webMap = coreAPIService.dummySendQuery([tradeProductNumber: tradeProductNumber,
                                                                    serviceType: serviceType], "getActiveServiceInstruction", "tradeservice/")
		def tradeServiceList = webMap.results
		// ER# 20161108-037 - Declare new variable to check if there existing transaction on TSD
		def tsdVsEts = false
		def lcCurrency
		
		if (tradeServiceList.size() > 1) {
			return [success: "false", message: "There is an on-going transaction for this Document Number. Abort this transaction?", action: "abort"]
		}
		
		// ER# 20161108-037 - This will check the transactions of the account to be transact.
		tradeServiceList.each {
			if (serviceInstructionId != null) {
				if (it.serviceInstructionId.get("serviceInstructionId").toString() != serviceInstructionId) {
				 	tsdVsEts = true
				}
				
			} else if (serviceInstructionId == null && it.status.toUpperCase() in ["PENDING", "PREPARED", "CHECKED", "PRE_APPROVED", "RETURNED"]) {
				tsdVsEts = true
			
			}
			
			
		}
		
		if (tsdVsEts) {
			return [success: "false", message: "There is an on-going transaction for this Document Number. Abort this transaction?", action: "abort"]
			
		}
		//ER# 20161108-037 - END
		
		def serviceInstructionList = webMap.details
        if (serviceInstructionList.size() > 0) {
            if (serviceType) {
                int sameTransactionCount = 0
				boolean isPendingReturned = false
                serviceInstructionList.each {
//                    if (it.details.get("serviceType").toString().toLowerCase().equals(serviceType) && // Comment to not allow second Ets be created while there is pending transaction on branch side
                    if (it.status in ["PENDING", "PREPARED", "CHECKED", "PRE_APPROVED", "RETURNED"]) {
							if(it.serviceInstructionId.get("serviceInstructionId") != serviceInstructionId){
								sameTransactionCount ++
								if (it.status in ["PENDING", "RETURNED"]) {
									isPendingReturned = true
								}
							}
                    }
                }

                if (sameTransactionCount.compareTo(0) > 0) {
					if(isPendingReturned){
						return [success: "false", message: "Pending transaction exists. Abort this transaction?", action: "continue"]
					} else {
						return [success: "false", message: "There is an on-going transaction for this Document Number. Abort this transaction?", action: "abort"]
					}
                } else {
                    return [success: "true"]
                }
            } else {
                int preparedCount = 0

                serviceInstructionList.each {
                    if (it.status in ["PREPARED", "CHECKED", "PRE_APPROVED"]) {
                        preparedCount ++
                    }
                }

                if (preparedCount.compareTo(0) > 0) {
                    return [success: "false", message: "There is an on-going transaction for this Document Number. Abort this transaction?", action: "abort"]
                }
            }
        }

        return [success: "true"]
    }

    def validateMultipleTradeService(tradeServiceId, tradeProductNumber, serviceType, isNotPrepared) {
        def serviceTypeString

        if (serviceType.contains("advising")) {
            serviceTypeString = evaluateExportsServiceTypes(serviceType)
        } else {
            serviceTypeString = evaluateNonLCServiceTypes(serviceType)
        }


        def params = [tradeServiceId: tradeServiceId,
                tradeProductNumber: tradeProductNumber,
                serviceType: serviceTypeString]

        if (isNotPrepared) {
            params << [isNotPrepared: "true"]
        }
        println params
        def tradeServiceList = coreAPIService.dummySendQuery(params, "getActiveTradeService", "tradeservice/").details

//        if (tradeServiceList.size() > 0 && "NEGOTIATION_ACCEPTANCE".equals(serviceTypeString)) {
        // applied to all transactions as per miss letty
        if (tradeServiceList.size() > 0) {
            return [success: "false", message: "There is an on-going transaction for this Document Number. Abort this transaction?"]
        }

        return [success: "true"]
    }

    String evaluateNonLCServiceTypes(serviceType) {
        switch (serviceType) {
            case "Settlement":
            case "Cancellation":
            case "Negotiation":
            case "amendment":
                return serviceType.toUpperCase()
            case "Negotiation Acceptance":
                return "NEGOTIATION_ACCEPTANCE"
            case "Negotiation Acknowledgement":
                return "NEGOTIATION_ACKNOWLEDGEMENT"
            case "indemnityIssuance":
                return "INDEMNITY_ISSUANCE"
            case "negotiationDiscrepancy":
                return "NEGOTIATION_DISCREPANCY"
            case "Settlement_Reversal":
                return "SETTLEMENT_REVERSAL"
        }
    }

    String evaluateExportsServiceTypes(serviceType) {
        switch (serviceType) {
            case "amendment_advising":
            case "cancellation_advising":
                return serviceType.toUpperCase()
        }
    }

    public boolean hasLetters(String s) {
        if (s == null) return false

        for (int i = 0; i < s.length(); i ++) {
            char c = s.charAt(i);

            if (Character.isLetter(c)) return true

            if (!Character.isDigit(c)) {
                if (c.toString() in [",", "."]) {
                    continue
                } else {
                    return true
                }
            }
        }
        return false;
    }

    def getReversal(serviceInstructionId, serviceType) {

        def hasReversal = coreAPIService.dummySendQuery([etsNumber: serviceInstructionId, serviceType: serviceType], "getReversal",
                "ets/")

        return hasReversal
    }
	
	def isFacilityExpired(documentNumber){
		println "@isFacilityExpired"
		def result = coreAPIService.dummySendQuery([documentNumber: documentNumber], "loadTradeproduct",
			"tradeservice/")
		
		if (result.get("facilityRefNo") == null) {
			return false
		}
		
		def facilityResult = facilityService.getFacilitiesByCifAndFacility(result.get("cifNumber"), result.get("facilityRefNo"),
																		   result.get("facilityType"), result.get("facilityId"));
		println ">>>>>>>>>>"+facilityResult
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		String todayStr = sdf.format(new Date())
		long today = todayStr.toLong()
		
		
		facilityResult.each {
			String expDateStr = it.get("EXPIRY_DATE").toString();
			long expDate = (expDateStr.substring(expDateStr.length()-2, expDateStr.length()) +
							expDateStr.substring(0, expDateStr.length()-2)).toLong()
			println "expDate = " + expDate
			println "today = " + today
							
			
			if (expDate > today) {
				println ">>>>>>NoT ExPiReD"
				return false
			} else if (expDate == today){
				println ">>>>>>NoT ExPiReD"
				return false
			} else if (expDate < today){
				println ">>>>>>ExPiReD"
				return true
			}
			
		}
		 
	}
	
}