package com.ucpb.tfsweb.main

import net.ipc.utils.NumberUtils
import java.text.SimpleDateFormat
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils

/*
	 (revision)
	 SCR/ER Number: ER# 20170109-040
	 SCR/ER Description: Transaction allowed to be created even the facility is expired
	 [Revised by:] Jesse James Joson
	 [Date revised:] 1/17/2017
	 Program [Revision] Details: Check the expiry date of the facility before allowing to amend LC
	 Member Type: Groovy
	 Project: WEB
	 Project Name: FacilityService.groovy
*/

class FacilityService {

    def queryService
    
    def facilityFinder = com.ucpb.tfs.application.query.interfaces.FacilityService.class;
    def coreAPIService;


    Map<String, Object> findAllFacilityByCifNumber(maxRows, rowOffset, currentPage, params) {
        String methodName = "getFacilitiesByCifNumber"

        Map<String, Object> param = [cifNumber: params.cifNumber ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(facilityFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]        
    }

    public List<Map<String,Object>> findAllFacilitiesByCifNumberAndType(String cifNumber, String facilityType){
        return queryService.executeQuery(facilityFinder,"getFacilitiesByCifNumberAndType",[cifNumber : cifNumber ?: '', type : facilityType ?: '']);
    }

    def constructFacilityGrid(sourceList,maxRows, rowOffset, currentPage) {
        Integer toIndex = ((currentPage * maxRows) < sourceList?.size()) ? (currentPage * maxRows) : sourceList?.size()

        def display = sourceList?.subList(rowOffset, toIndex)?.collect {
//            String date = convertDateString(it.EXPIRY_DATE.toString(),"MMddyy","MM/dd/yy");
            [
             id: it.FACILITY_REF_NUMBER,
//             id: it.FACILITY_ID,
                    cell:[
                            it.FACILITY_ID,
                            convertDateString(it.EXPIRY_DATE.toString(),"MMddyy","MM/dd/yyyy"), //it.AFEXP6
                            it.FACILITY_CURRENCY ?: "",
                            it.FACILITY_TYPE,
                            it.FACILITY_REF_NUMBER,
                            it.BALANCE_INQUIRY_ID
                    ]
            ]
        }

        int totalRows = sourceList?.size() ?: 0//display?.size() ?: 0

        return [rows : display,
            page : currentPage,
            records : totalRows,
            total : Math.ceil(totalRows / maxRows)
        ]
    }

    private String convertDateString(String sourceDateString,String sourceFormat,String outputFormat){
        SimpleDateFormat sourceDateFormat = new SimpleDateFormat(sourceFormat);
        SimpleDateFormat outputDateFormat = new SimpleDateFormat(outputFormat);
        return outputDateFormat.format(sourceDateFormat.parse(StringUtils.leftPad(sourceDateString,6,"0")));
    }

    String findTrLines(params) {
		String methodName = "getFacilitiesByCifNumberAndFacilityTypes"

        String[] facilityTypes = ['CLS', 'FFT', 'FTF']

        Map<String, Object> param = [cifNumber: params.cifNumber ?: "",
				mainCifNumber: params.mainCifNumber ?: "",
				seqNo: "",
                facilityTypes: facilityTypes]

        List<Map<String, Object>> queryResult = queryService.executeQuery(facilityFinder, methodName, param)
        def trLine = []

        queryResult.each {
            trLine << it.FACILITY_TYPE+it.FACILITY_ID
        }

        params.cifNumber
        ////printlntrLine
        return trLine?.toString()?.replace("[","")?.replace("]","")
    }

    def getFacilities(String cifNumber, String mainCifNumber, String seqNo, String... facilityTypes){
        println "facilityService.getFacilities : facilityTypes >> " + facilityTypes
        return queryService.executeQuery(facilityFinder, "getFacilitiesByCifNumberAndFacilityTypes", [cifNumber: cifNumber ?: '',
				mainCifNumber: mainCifNumber ?: '',
                seqNo: seqNo ?: '',
                facilityTypes: facilityTypes ?: '']);
    }

    def getFacilitiesSearch(String cifNumber,
							String mainCifNumber,
                            String seqNo,
                            String... facilityTypes){
        println "facilityService.getFacilitiesSearch : facilityTypes >> " + facilityTypes
        return queryService.executeQuery(facilityFinder, "getFacilitiesByCifNumberAndFacilityTypesSearch", [cifNumber: cifNumber,
				mainCifNumber: mainCifNumber ?: '',
                seqNo: seqNo,
                facilityTypes: facilityTypes]);
    }

    def getFacilitiesByCifCurrencyAndTypes(String cifNumber,String mainCifNumber,String currency,String seqNo, String... facilityTypes){
        println "\n\nfacilityService.getFacilitiesByCifCurrencyAndTypes : facilityTypes >> " + facilityTypes
        println "cifNumber >> " + cifNumber
        println "mainCifNumber >> " + mainCifNumber
        println "currency >> " + currency
        println "seqNo >> " + seqNo

        return queryService.executeQuery(facilityFinder, "getFacilitiesByCifCurrencyAndFacilityTypes",
                [cifNumber: cifNumber,
                 mainCifNumber: mainCifNumber,
                 currency : currency,
                 seqNo : seqNo ?: '',
                 facilityTypes: facilityTypes]);
    }

    def getFacilityBalance(String balanceQueryId){
        List<Map<String,Object>> result = queryService.executeQuery(facilityFinder, "getFacilityBalance", [transactionSequenceNumber: balanceQueryId ? Long.valueOf(balanceQueryId) : ""]);
        if(!result.isEmpty()){
            return result.get(0);
        }
        return new HashMap<String,Object>();
    }

    def insertFacilityBalanceQuery(String facilityId, String facilityType, String cifNumber){
        def parameters = [facilityId : facilityId, facilityType : facilityType, cifNumber: cifNumber];

        def result = coreAPIService.dummySendCommand(parameters, "insertBalance","facility/");
        return result
    }

    def getFacilityBalanceRequest(Long transactionNumber, String etsNumber){
        return coreAPIService.dummySendCommand([transactionSequenceNumber: transactionNumber, etsNumber: etsNumber],"getBalance","facility/");
    }

    def inquireFacilityBalance(String etsNumber){
        return coreAPIService.dummySendCommand([etsNumber : etsNumber],"inquireBalance","facility/");
    }

	def getFacilitiesByCifAndFacility(String cifNumber, String facilityRefNo, String facilityType, String facilityId) {
		return queryService.executeQuery(facilityFinder,"getFacilitiesByCifAndFacility",[cifNumber : cifNumber , facilityRefNo : facilityRefNo , facilityType : facilityType , facilityId : facilityId]);
			
	}

}
