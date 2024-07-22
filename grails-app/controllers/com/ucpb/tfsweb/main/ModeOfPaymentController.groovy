package com.ucpb.tfsweb.main

import grails.converters.JSON
import java.text.DateFormat
import java.text.DecimalFormat
import java.text.ParseException
import java.text.SimpleDateFormat

/**
 * User: Marv
 * Date: 08/12/12
 */

class ModeOfPaymentController {
    
    def modeOfPaymentService
	def holidayService
    def mdService
    def apService
    def casaService
	
    // constructs mode of payment based on parameters
    def viewModesOfPayment() {
        println session.etsModel
        if (session.etsModel != null && session.etsModel.documentClass in ["BP"]) {
            params.exportViaPddtsFlag = session.etsModel.exportViaPddtsFlag //(session.etsModel.serviceType.equals("NEGOTIATION")) ? "1" : null
            params.noAr = true
        } else if (session.dataEntryModel != null && session.dataEntryModel.documentClass in ["BP"]) {
            params.exportViaPddtsFlag = session.dataEntryModel.exportViaPddtsFlag
            params.noAr = true
        }

        if (session.etsModel != null && session.etsModel.documentClass in ["BC"]) {
            params.exportViaPddtsFlag = session.etsModel.exportViaPddtsFlag
            params.noAr = true
        } else if (session.dataEntryModel != null && session.dataEntryModel.documentClass in ["BC"]) {
            params.exportViaPddtsFlag = session.dataEntryModel.exportViaPddtsFlag
            params.noAr = true
        }
		
        Map<String, Object> modesOfPayment = modeOfPaymentService.constructModesOfPayment(params)

        render modesOfPayment as JSON
    }
	
	def checkDateIfHolidayOrNotBusinessDay() {
		//printlnparams
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		String loanMaturityDate;
		try{
			loanMaturityDate = df.format(df.parse(params.loanMaturityDate))
		}catch (ParseException e) {
		e.printStackTrace();
		}
		String branchUnitCode = (String)params.branchUnitCode
		println"branchUnitCode " + branchUnitCode
		println"loanMaturityDate " + loanMaturityDate
		println"holiday service >>>> " + holidayService

		Boolean isHoliday = holidayService.isHolidayOrIsNotABusinessDay(loanMaturityDate, branchUnitCode)

		def result = [:]
		result << [isHoliday : isHoliday]
		render result as JSON
	}

    def getTotalMd() {
		def decimalFormat = new DecimalFormat("###,###,##0.00")
        def md = mdService.getTotalMd(params.currency, params.documentNumber)
        def jsonData = [totalBalance: decimalFormat.format(new BigDecimal((String)md.TOTALCREDIT[0] ?: 0.00).subtract(new BigDecimal((String)md.TOTALDEBIT[0] ?: 0.00)))]
        render jsonData as JSON
    }

    def findAllApByCifNumberAndCurrency() {
		println "smarap" +params
        def aps = apService.findAllApByCifNumberAndCurrency(params.cifNumber, params.currency)

        render aps as JSON
    }

    def findAllApBySettlementAcctNo() {
        def aps = apService.findAllApBySettlementAcctNo(params.cifNumber, params.currency, params.settlementAccountNumber)

        render aps as JSON
    }

    def findAllApById() {
        def aps = apService.findAllApById(params.id)

        render aps[0] as JSON
    }

    def constructMultipleAp() {
        //println"########################"
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = apService.findMultipleAp(maxRows, rowOffset, currentPage, params)
        //printlnmapList
        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = mapList.display.collect {
            [id: it.ID,
                    cell: [
                            it.REFERENCETYPE,
                            it.CURRENCY,
                            it.AMOUNT
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
	
	def searchCasaAccountsByUser() {
		def userId = session['username']
		def accountNumber = params.accountNumber
        def currency = params.currency
//        def result = casaService.searchCasaAccountsByUser(userId, accountNumber)
		println "modeOfPaymentController.searchCasaAccountsByUser"
		println "userId: " + userId
		println "accountNumber: " + accountNumber
		println "currency: " + currency
        // MARV: added currency code for message string
        def result = casaService.searchCasaAccountsByUser(userId, accountNumber, currency)

        render result as JSON
	}
}
