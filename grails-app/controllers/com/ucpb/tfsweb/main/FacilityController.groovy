package com.ucpb.tfsweb.main

import grails.converters.JSON
import net.ipc.utils.DateUtils

class FacilityController {

    def facilityService

    def static DM_TR_FACILITY_MAPPING = [
            "USD" : "FTF",
            "PHP" : "FD5"
    ]

    def static FX_TR_FACILITY_MAPPING = [
            "USD" : "FTF",
            "PHP" : "FFT"
    ]

    def static IB_FACILITY_MAPPING = [
            "USD" : "FBF",
            "PHP" : "FFB"
    ]

    def static DB_FACILITY_MAPPING = [
            "USD" : "FBF",
            "PHP" : "FDB"
    ]

    def static UA_FACILITY_MAPPING = [
            "PHP" : "FD3",
            "USD" : "F3F",
            "SGD" : "F3S",
            "EUR" : "F3U",
            "JPY" : "F3Y",
            "AUD" : "F3Z",
            "GBP" : "F3G",
            "HKD" : "F3K",
            "CHF" : "F3I"

    ]

    def static DBP_FACILITY_MAPPING = [
            "PHP" : "FDB",
            "USD" : "FBF"
    ]

    def static EBP_FACILITY_MAPPING = [
            "USD" : ["FBE", "FEB"]
    ]




    def searchFacility() {
        println "searchFacility"
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        Map<String, Object> mapList = facilityService.findAllFacilityByCifNumber(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = facilityService.constructFacilityGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    //TODO: REFACTOR ME!
    def getEarmarkingFacilities(){
         def facilities = getFacilitiesByCurrency(params?.cifNumber,params?.mainCifNumber,params?.seqNo,'FCN');
        render facilities as JSON;
    }

    def getEarmarkingFacilitiesSearch(){
        def facilities = getFacilitiesByCurrencySearch(params?.cifNumber, params?.mainCifNumber, params?.seqNo, 'FCN');
        render facilities as JSON;
    }

    def getEarmarkingFacilitiesForUaSearch(){
        println "getEarmarkingFacilitiesForUaSearch"
        def facilities = getFacilitiesByCurrencySearch(params?.cifNumber, params?.mainCifNumber, params?.seqNo, UA_FACILITY_MAPPING[params.currency]);
        render facilities as JSON;
    }

    def searchForLoanFacilities(){
        def facilities = getFacilitiesByCurrencyAndTypes(params?.cifNumber,params?.mainCifNumber,params.currency,params.seqNo,params.facilityType);
        render facilities as JSON;
    }

    def getTrFacilities(){
        def facilityType;
        if("DOMESTIC".equalsIgnoreCase(params.documentType)){
            facilityType = DM_TR_FACILITY_MAPPING[params.currency];
        }else if ("FOREIGN".equalsIgnoreCase(params.documentType)){
            facilityType = FX_TR_FACILITY_MAPPING[params.currency];
        }

        def facilities = getFacilitiesByCurrencyAndTypes(params?.cifNumber,
				params?.mainCifNumber,
				params.currency,
                params.seqNo,
                facilityType);
        render facilities as JSON;
    }

    def getDbpFacilities(){
        def facilities = getFacilitiesByCurrencyAndTypes(params?.cifNumber,
				params?.mainCifNumber,
                params.currency,
                params.seqNo,
                DBP_FACILITY_MAPPING[params.currency]);
//        def facilities = getFacilitiesByCurrency(params?.cifNumber,params.currency,"FFT","FTF","FD5","F3F","F3S","F3U","F3Y","F3Z","F3G","F3K","F3I");
        render facilities as JSON;
    }

    def getEbpFacilities(){
        def facilities = getFacilitiesByCurrencyAndTypes(params?.cifNumber,
				params?.mainCifNumber,
                params.currency,
                params.seqNo,
                params.facilityType);
        render facilities as JSON;
    }

    def getFacilityBalance(){
        render (facilityService.getFacilityBalance(params.balanceQueryRequestId) as JSON);
    }

    def getFacilityBalanceRequest(){
        render (facilityService.getFacilityBalanceRequest(Long.valueOf(params.balanceQueryRequestId?.toString()), session?.etsModel?.serviceInstructionId) as JSON);
    }



    def getIBFacilities(){
        boolean isForeign = (session.etsModel?.documentType?.equals("FOREIGN") ||
                             session.dataEntryModel?.documentType?.equals("FOREIGN") ||
                             session.chargesModel?.documentType?.equals("FOREIGN")) ?
                            true :
                            false

        def facilities = getFacilitiesByCurrencyAndTypes(params.cifNumber,
				params?.mainCifNumber,
                params.currency,
                params.seqNo,
                isForeign ? IB_FACILITY_MAPPING[params.currency] : DB_FACILITY_MAPPING[params.currency],
        );
        render facilities as JSON;
    }

    def getUAFacilities(){
        def facilities = getFacilitiesByCurrencyAndTypes(params.cifNumber,
				params?.mainCifNumber,
                params.currency,
                params.seqNo,
                UA_FACILITY_MAPPING[params.currency]);
        render facilities as JSON;
    }

    private getFacilitiesByCurrency(String cifNumber,String mainCifNumber,String seqNo,String... facilityTypes){
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        List<Map<String,Object>> facilities = facilityService.getFacilities(cifNumber,mainCifNumber,seqNo,facilityTypes);

//        def results = facilityService.constructFacilityGrid(facilities,maxRows,rowOffset,currentPage);
//        def jsonData = [rows : results, page : params.int('page') ?: 1, records:  facilities.size(), total : Math.ceil(facilities.size()/params.int('rows') ?: 10) ]
        return facilityService.constructFacilityGrid(facilities,maxRows,rowOffset,currentPage);
    }

    private getFacilitiesByCurrencySearch(String cifNumber,
										  String mainCifNumber,
                                          String seqNo,
                                          String... facilityTypes){
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        List<Map<String,Object>> facilities = facilityService.getFacilitiesSearch(cifNumber,
																			mainCifNumber,
                                                                            seqNo,
                                                                            facilityTypes);
//        def results = facilityService.constructFacilityGrid(facilities,maxRows,rowOffset,currentPage);
//        def jsonData = [rows : results, page : params.int('page') ?: 1, records:  facilities.size(), total : Math.ceil(facilities.size()/params.int('rows') ?: 10) ]
        return facilityService.constructFacilityGrid(facilities,maxRows,rowOffset,currentPage);
    }

    private getFacilitiesByCurrencyAndTypes(String cifNumber,String mainCifNumber,String currency,String seqNo,String... facilityTypes){
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        List<Map<String,Object>> facilities = facilityService.getFacilitiesByCifCurrencyAndTypes(cifNumber,
				mainCifNumber,
                currency,
                seqNo ?: '',
                facilityTypes);

//        def results = facilityService.constructFacilityGrid(facilities,maxRows,rowOffset,currentPage);
//        def jsonData = [rows : results, page : params.int('page') ?: 1, records:  facilities.size(), total : Math.ceil(facilities.size()/params.int('rows') ?: 10) ]
        println 'facilityTypes ' + facilityTypes
        return facilityService.constructFacilityGrid(facilities,maxRows,rowOffset,currentPage);
    }

    def searchTrLines() {

        String trLines = facilityService.findTrLines(params)
        render([trLines: trLines] as JSON)
    }

    def requestFacilityBalance(){
        println params.facilityType
        render facilityService.insertFacilityBalanceQuery(params.facilityId,params.facilityType,params.cifNumber) as JSON;
    }

    def inquireFacilityBalance(){
        render facilityService.inquireFacilityBalance(session?.etsModel?.serviceInstructionId ?: params.serviceInstructionId) as JSON;
    }


    def getCurrentDate() {
        render([currentSystemDate: DateUtils.shortDateFormat(new Date())] as JSON)
    }
}
