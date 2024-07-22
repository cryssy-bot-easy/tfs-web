package com.ucpb.tfsweb.main

import java.math.BigDecimal;

import grails.converters.JSON
import net.ipc.utils.NumberUtils

class AccountingEntryController {

	def coreAPIService
	def accountingEntryService

	def viewAccountingEntries(){

		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def accounting = coreAPIService.dummySendQuery([tradeServiceId : params?.tradeServiceId, type: "PAYMENT"], "accountingEntry", "tradeservice/") //returnMap.put("entries"...

		def totalCredit = 0
		def totalDebit = 0

		def totalCreditBase = 0
		def totalDebitBase = 0

		accounting?.entries?.each {
			if ("Credit".equalsIgnoreCase(it.entryType)) {
				totalCredit += it.originalAmount
				totalCreditBase += it.pesoAmount
			}

			if ("Debit".equalsIgnoreCase(it.entryType)) {
				totalDebit += it.originalAmount
				totalDebitBase += it.pesoAmount
			}
		}

		Integer toIndex = ((currentPage * maxRows) < accounting?.entries?.size()) ? (currentPage * maxRows) : accounting?.entries?.size()

		def totalRows = accounting?.entries?.size() ?:0
		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = accountingEntryService.constructAcctEntryGrid(accounting?.entries?.subList(rowOffset, toIndex))

		def jsonData = [rows: results,
			page: currentPage,
			records: totalRows,
			total: numberOfPages,
			userdata: [
				gltsNumber: (accounting?.entries && !accounting.entries.isEmpty()) ? accounting?.entries[0]?.gltsNumber : "",
				totalCredit: NumberUtils.currencyFormat(new Double(totalCredit.toString())),
				totalDebit: NumberUtils.currencyFormat(new Double(totalDebit.toString())),
				totalCreditBase: NumberUtils.currencyFormat(new Double(totalCreditBase.toString())),
				totalDebitBase: NumberUtils.currencyFormat(new Double(totalDebitBase.toString()))
			]
		]
		
		render jsonData as JSON

	}

	def viewTransactionAccountingEntries(){

		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def accounting = coreAPIService.dummySendQuery([tradeServiceId : params?.tradeServiceId, type: "TRANSACTION"], "accountingEntry", "tradeservice/") //returnMap.put("entries"...

		def totalCredit = 0
		def totalDebit = 0

		def totalCreditBase = 0
		def totalDebitBase = 0

		accounting?.entries?.each {
			if ("Credit".equalsIgnoreCase(it.entryType)) {
				totalCredit += it.originalAmount
				totalCreditBase += it.pesoAmount
			}

			if ("Debit".equalsIgnoreCase(it.entryType)) {
				totalDebit += it.originalAmount
				totalDebitBase += it.pesoAmount
			}
		}

		Integer toIndex = ((currentPage * maxRows) < accounting?.entries?.size()) ? (currentPage * maxRows) : accounting?.entries?.size()

		def totalRows = accounting?.entries?.size() ?:0
		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = accountingEntryService.constructAcctEntryGrid(accounting?.entries?.subList(rowOffset, toIndex))

		def jsonData = [rows: results,
			page: currentPage,
			records: totalRows,
			total: numberOfPages,
			userdata: [
				gltsNumber: (accounting?.entries && !accounting.entries.isEmpty()) ? accounting?.entries[0]?.gltsNumber : "",
				totalCredit: NumberUtils.currencyFormat(new Double(totalCredit.toString())),
				totalDebit: NumberUtils.currencyFormat(new Double(totalDebit.toString())),
				totalCreditBase: NumberUtils.currencyFormat(new Double(totalCreditBase.toString())),
				totalDebitBase: NumberUtils.currencyFormat(new Double(totalDebitBase.toString()))
			]
		]
 
		render jsonData as JSON


	}

	def validateAccountingEntry() {
		
//			Map parameterMap = [tradeServiceId : params.tradeServiceId]
			
			println "Validating Accounting Entries for TradeService ID: " + params?.tradeServiceId
			
			def accounting = coreAPIService.dummySendQuery([tradeServiceId : params?.tradeServiceId, type: "PAYMENT"], "accountingEntry", "tradeservice/") //returnMap.put("entries"...
			println "<<<<<<<<<<<<<<<<<<" + accounting
			
			
			
			def unitCode
			def accountingCode
			def bookCurrency
			def bookCode
			
			BigDecimal totalCredit = BigDecimal.ZERO
			BigDecimal totalDebit = BigDecimal.ZERO
			BigDecimal totalCreditBase = BigDecimal.ZERO
			BigDecimal totalDebitBase = BigDecimal.ZERO
			
			String passedParam
			String validatedEntries
			boolean totalBalance = true
			boolean allAreFound = true
			
				
			
				accounting?.entries?.each {
					
					//checking for not found in GLMAST
					if (it.particulars.toString().contains("NOT FOUND IN GLMAST")) {
						unitCode= it.unitCode
						accountingCode= it.accountingCode
						bookCurrency= it.bookCurrency
						bookCode= it.bookCode
						allAreFound = false
						println ">>>>..allAreFound? "+allAreFound

					}else if (it.accType.toString().equalsIgnoreCase("I") && allAreFound == true) {
						println ">>>>..allAreFound? "+allAreFound
						unitCode= it.unitCode
						accountingCode= it.accountingCode
						bookCurrency= it.bookCurrency
						bookCode= it.bookCode

					}
								
					if ("Credit".equalsIgnoreCase(it.entryType)) {
						totalCredit += it.originalAmount
						totalCreditBase += it.pesoAmount

					}
		
					if ("Debit".equalsIgnoreCase(it.entryType)) {
						totalDebit += it.originalAmount
						totalDebitBase += it.pesoAmount

					}
					
					
				}
				
				
				BigDecimal validateTotalCredit = totalCredit.setScale(2,BigDecimal.ROUND_HALF_UP)
				BigDecimal validateTotalDebit = totalDebit.setScale(2,BigDecimal.ROUND_HALF_UP)
				BigDecimal validateTotalCreditBase = totalCreditBase.setScale(2,BigDecimal.ROUND_HALF_UP)
				BigDecimal validateTotalDebitBase = totalDebitBase.setScale(2,BigDecimal.ROUND_HALF_UP)
				
				
				//check if accounting entries is balance
				if(validateTotalCredit == validateTotalDebit && validateTotalCreditBase == validateTotalDebitBase) {
					
					totalBalance = true
					println "Are all balance? "+totalBalance

				}else {
					totalBalance = false		
					println "Are all balance? "+totalBalance
					println "Total Original Debit: "+validateTotalDebit
					println "Total Original Credit: "+validateTotalCredit
					println "Total Base Debit: "+validateTotalDebitBase
					println "Total Base Credit: "+validateTotalCreditBase 
					

				}		
				
				if(accountingCode == null && unitCode == null){
					
					println "no accounting entries created"
					validatedEntries = "FOUND"
					
				} else {
				
					Map validateParam = [unitCode:unitCode, bookCode:bookCode, accountingCode:accountingCode, bookCurrency:bookCurrency]
		
					def result = coreAPIService.dummySendQuery(validateParam, "validate", "accounting/")			
					passedParam = result.get("result")
		
					if(passedParam.equalsIgnoreCase("false")) {
							
						validatedEntries = "<font color=\"red\">ACCOUNTING ENTRY NOT FOUND IN GLMAST!</font><br/><br/>"+
											"<P align=\"left\">"+
											"Please double check the following entries:<br/>"+	
											"Unit Code: <b>" + unitCode + "</b><br/>"+
											"Book Code: " +bookCode+"<br/>"+
											"Accounting Code:  " + accountingCode + "<br/>"+
											"Booking Currency: " + bookCurrency + "<br/><br/></P>"
														
					}else if(totalBalance == false){
						validatedEntries = "<font color=\"red\">Accounting is Unbalance!</font><br/><br/>"+
											"<P align=\"left\">" +
											"Total Original Debit Amount: "+validateTotalDebit +"<br/>"+
											"Total Original Credit Amount: "+validateTotalCredit +"<br/>"+
											"Total Base Debit Amount: "+validateTotalDebitBase +"<br/>"+
											"Total Base Credit Amount: "+validateTotalCreditBase +"</P>"
						
					}else {
						validatedEntries = "FOUND"			
					}
			
				}
	
			def paramAccounting = [validationResult:validatedEntries]
			render paramAccounting as JSON
	}
	
	def checkErrorStackTrace() {
		
		def thisError
		String errorResult;
			
		Map checkErrorInAccounting=[thisError:'NONE']
		def result = coreAPIService.dummySendQuery(checkErrorInAccounting, "checkError", "accounting/")
		errorResult  = result.get("result")

		println "===================================================="
		println "===================================================="
		println "===================================================="
		println "Is there any error? " + errorResult
		println "===================================================="
		println "===================================================="
		println "===================================================="
		
		def checkAccountingError = [checkResult:errorResult]
		render checkAccountingError as JSON
		
		}


}
