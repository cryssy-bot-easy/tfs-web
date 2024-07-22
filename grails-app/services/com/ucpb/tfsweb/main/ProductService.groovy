package com.ucpb.tfsweb.main

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number:
	SCR/ER Description: Redmine #4118 - If with outstanding EBC is tagged as Yes, the drop down lists of EBC document numbers
	are not complete. Example: Document number 909-11-307-17-00004-2 is not included in the list but it should be part of the
	drop down list since this is an approved EBC Nego and it is still outstanding.
	[Revised by:] John Patrick C. Bautista
	[Date Deployed:] 06/16/2017
	Program [Revision] Details: Added new method to query from Export Bills without the BP Currency restriction.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: ProductService
 */

class ProductService {

    def coreAPIService

    Map<String, Object> flattenProduct() {

    }

    def searchExportBillsByCifNumber(cifNumber, exportBillType) {
        def queryResult = coreAPIService.dummySendQuery([cifNumber: cifNumber, exportBillType: exportBillType], "byCifNumber", "exportbills/search/")?.details
		
        return queryResult.documentNumber.documentNumber
    }
	
	//	12092016 EBP Extraction - Case 2
	def getAllExportBills(cifNumber, exportBillType) {
		def queryResult = coreAPIService.dummySendQuery([cifNumber: cifNumber, exportBillType: exportBillType], "exportbills/retrieveAllExportBills")?.details
		

		return queryResult.documentNumber.documentNumber
	}
	
	// 01242017 - Redmine 4118: Remove restriction on BP Currency
	def getAllExportBillsNoBPCurrencyRestriction(cifNumber, exportBillType) {
		def queryResult = coreAPIService.dummySendQuery([cifNumber: cifNumber, exportBillType: exportBillType], "exportbills/retrieveAllExportBillsNoBPCurrencyRestriction")?.details
		

		return queryResult.documentNumber.documentNumber
	}
}
