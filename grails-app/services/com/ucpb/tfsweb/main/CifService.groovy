/**
 * PROLOGUE:
 * (revision)
 * SCR/ER Number:
 * SCR/ER Description: (Redmine #4134) Exporter CB Code field should be disabled and extracted from sibs LNSCOD base on CIF Number.
 * [Revised by:] Ludovico Anton Apilado
 * [Date revised:] 5/25/2017
 * Program [Revision] Details: on constructCifTableNormal() function and constructCifTable() function; added it.CBCODE?.trim()
 * Date deployment: 6/16/2017
 * Member Type: Groovy
 * Project: WEB
 * Project Name: CifService.groovy
 */

package com.ucpb.tfsweb.main

import java.awt.datatransfer.StringSelection;


class CifService {
    
    def queryService
    
    def cifFinder = com.ucpb.tfs.application.query.interfaces.CustomerInformationFileService.class
	def finder = com.ucpb.tfs.application.query.service.ICBCodeFinder.class
	
	Map<String, Object> findCifByCifInCDT(params){
		
		Map<String, Object> param = [cifNumber: params.cifNumber]
		
		println "PARAMS" + params
		println "PARAM" + param
		String methodName = "getCifByCifInCDT"
		
		List<Map<String, Object>> queryResult = queryService.executeQuery(cifFinder, methodName, param)
		
		println "Query Result" + queryResult
		
		return [sibsStatus: queryResult]
	}
	
    Map<String, Object> findCifsByCifNameAndNumber(maxRows, rowOffset, currentPage, params) {
//		String methodName = "getCifsByNameAndNumber"   // search cif on mock sibs db - changed description to avoid confusion
		String methodName = "getCifsByNameAndOrNumber" // search cif on actual sibs db
		println "PARAMSSSSSSSSS" + params
        Map<String, Object> param = [cifName: params.cifName?.trim() ?: "", cifNumber: params.cifNumber?.trim() ?: "", branchUnitCode : params.unitcode]
		
        List<Map<String, Object>> queryResult = queryService.executeQuery(cifFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size(), queryResult: queryResult]
    }
	
	Map<String, Object> findCifsByCache(maxRows, rowOffset, currentPage, queryResult) {
		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size(), queryResult: queryResult]
	}

    def constructCifTableNormal(display) {
        display.collect {
            UUID uuid = UUID.randomUUID()
            String id = String.valueOf(uuid)

			println "checkCBCODE1" + it.CBCODE
            [id: id,
                    cell:[
                            it.CIF_NUMBER?.trim(),
                            it.INDIVIDUAL == 'Y' ? it?.FIRSTNAME?.trim() + " " + it?.MIDDLENAME?.trim( )+ " " + it?.LASTNAME?.trim() : it?.LASTNAME?.trim() + it?.FIRSTNAME?.trim() + it?.MIDDLENAME?.trim(),
                    		it.BRANCH_UNIT_CODE?.toString()?.trim()?.length() < 3 ? String.format("%03d", Integer.parseInt(it.BRANCH_UNIT_CODE?.toString()?.trim())) : it.BRANCH_UNIT_CODE?.toString()?.trim(),
                       		(it.ADDRESS_LINE1?.trim() ?: "")+" "+(it.ADDRESS_LINE2?.trim() ?: "")+" "+(it.ADDRESS_LINE3?.trim() ?: ""),
                            it.INDIVIDUAL == 'Y' ? it?.FIRSTNAME?.trim() + " " + it?.MIDDLENAME?.trim( )+ " " + it?.LASTNAME?.trim() : it?.LASTNAME?.trim() + " " + it?.FIRSTNAME?.trim() + " " + it?.MIDDLENAME?.trim(),
                            it.OFFICER_CODE?.trim(),
							it.OFFICER_NAME?.trim(),
							it.ALLOCATION_UNIT_CODE,
							it?.FIRSTNAME?.trim(),
							it?.MIDDLENAME?.trim(),
							it?.LASTNAME?.trim(),
							it?.TIN_NUMBER,
							it?.ADDRESS_LINE1,
							it?.ADDRESS_LINE2,
							it?.ERROR?.trim(),
							it.CBCODE?.trim()
                    ]
            ]
        }
    }

    def constructCifTable(display) {
        display.collect {
			UUID uuid = UUID.randomUUID()
			String id = String.valueOf(uuid)
//			println "FIRSTNAME" + it.FIRSTNAME
//			println "MIDDLENAME" + it.MIDDLENAME
//			println "LASTNAME" + it.LASTNAME
//			println "TIN_NUMBER" + it.TIN_NUMBER
            ////println"it.OFFICER_CODE >> " + it.OFFICER_CODE
            ////println"it.OFFICER_NAME >> " + it.OFFICER_NAME
//            [id: it.CIF_NUMBER,
			println "checkCBCODE2" + it.CBCODE
			[id: id,
                    cell:[
                            it.CIF_NUMBER?.trim(),
                            it.CIF_NAME?.trim(),
                    		(it.BRANCH_UNIT_CODE != null && it.BRANCH_UNIT_CODE?.toString()?.trim() != '') ? String.format("%03d", Integer.parseInt(it.BRANCH_UNIT_CODE?.toString()?.trim())) : '',
							(it.ADDRESS_LINE1?.trim() ?: "")+" "+(it.ADDRESS_LINE2?.trim() ?: "")+" "+(it.ADDRESS_LINE3?.trim() ?: ""),
                            it.INDIVIDUAL == 'Y' ? it?.FIRSTNAME?.trim() + " " + it?.MIDDLENAME?.trim( )+ " " + it?.LASTNAME?.trim() : it?.LASTNAME?.trim() + " " + it?.FIRSTNAME?.trim() + " " + it?.MIDDLENAME?.trim(),
                            it.OFFICER_CODE?.trim(),
                            it.OFFICER_NAME?.trim(),
							it.ALLOCATION_UNIT_CODE,
							it?.FIRSTNAME?.trim(),
							it?.MIDDLENAME?.trim(),
							it?.LASTNAME?.trim(),
							it?.TIN_NUMBER,
							it.ADDRESS_LINE1?.trim(),
							it.ADDRESS_LINE2?.trim(),
							it.ADDRESS_LINE3?.trim(),
							it.ERROR?.trim(),
							it.CBCODE?.trim()
                    ]
            ]
        }
    }
	
	def constructMainCifTable(display) {
		display.collect {
			UUID uuid = UUID.randomUUID()
			String id = String.valueOf(uuid)
//			println "FIRSTNAME" + it.FIRSTNAME
//			println "MIDDLENAME" + it.MIDDLENAME
//			println "LASTNAME" + it.LASTNAME
//			println "TIN_NUMBER" + it.TIN_NUMBER
			////println"it.OFFICER_CODE >> " + it.OFFICER_CODE
			////println"it.OFFICER_NAME >> " + it.OFFICER_NAME
//            [id: it.CIF_NUMBER,
			println "checkCBCODE3" + it.CBCODE
			[id: id,
					cell:[
							it.CIF_NUMBER?.trim(),
							it.CIF_NAME?.trim(),
							(it.ADDRESS_LINE1?.trim() ?: "")+" "+(it.ADDRESS_LINE2?.trim() ?: "")+" "+(it.ADDRESS_LINE3?.trim() ?: ""),
							it.INDIVIDUAL == 'Y' ? it?.FIRSTNAME?.trim() + " " + it?.MIDDLENAME?.trim( )+ " " + it?.LASTNAME?.trim() : it?.LASTNAME?.trim() + " " + it?.FIRSTNAME?.trim() + " " + it?.MIDDLENAME?.trim(),
							it.OFFICER_CODE?.trim(),
							it.OFFICER_NAME?.trim(),
							it?.FIRSTNAME?.trim(),
							it?.MIDDLENAME?.trim(),
							it?.LASTNAME?.trim(),
							it?.TIN_NUMBER,
							it.ADDRESS_LINE1?.trim(),
							it.ADDRESS_LINE2?.trim(),
							it.ADDRESS_LINE3?.trim(),
							it.ERROR?.trim()
					]
			]
		}
	}

    def findMainCifsByCifNumber(maxRows, rowOffset, currentPage, params) {
        String methodName = "getMainCifsByClientCifNumber"

        Map<String, Object> param = [cifNumber: params.cifNumber ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(cifFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    Map<String, Object> findCifsByMainCifNumber(maxRows, rowOffset, currentPage, params) {
        String methodName = "getChildCifsByMainCifNumber"

        Map<String, Object> param = [cifNumber: params.cifNumber ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(cifFinder, methodName, param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
    
//    List<Map<String, Object>> findCasaAccountsFromCif(cifNumber) {
    List<Map<String, Object>> findCasaAccountsFromCif(cifNumber, currency) {
//        String methodName = "getCasaAccounts"
        String methodName = "getCasaAccountsByCifNumberAndCurrency"
//        Map<String, Object> param = [cifNumber: cifNumber ?: ""]
        Map<String, Object> param = [cifNumber: cifNumber ?: "",
                currency: currency ?: ""
        ]
		
        println "PAR"+param
		
        List<Map<String,Object>> queryResult = queryService.executeQuery(cifFinder, methodName, param)

        return queryResult
    }
	
	Map<String, Object> findCbCodeFromCif(cifNumber) {
        def queryResult = queryService.executeQuery(finder, 'findCbCodeFromCif', [cifNumber: cifNumber])
        return queryResult ? queryResult[0] : null
	}
}
