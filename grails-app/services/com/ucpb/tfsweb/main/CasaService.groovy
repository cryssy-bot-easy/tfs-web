package com.ucpb.tfsweb.main

import org.apache.commons.lang.StringUtils

class CasaService {
	
	def coreAPIService
	
//    def searchCasaAccountsByUser(String userId, String accountNumber) {
//		def result = coreAPIService.dummySendCommand([userId:userId,accountNumber: StringUtils.trim(accountNumber)], "getCasaAccountStatus", "/payment")
//		return result
//    }

    def searchCasaAccountsByUser(String userId, String accountNumber, String currency) {
		println "casaService.searchCasaAccountsByUser"
		println "userId: " + userId
		println "accountNumber: " + StringUtils.trim(accountNumber)
		println "currency: " + StringUtils.trim(currency)
        def result = coreAPIService.dummySendCommand([userId:userId,
                accountNumber: StringUtils.trim(accountNumber),
                currency: StringUtils.trim(currency)], "getCasaAccountStatus", "/payment")
        return result
    }
}
