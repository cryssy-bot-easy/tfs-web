package com.ucpb.tfsweb.utilities
import grails.converters.JSON
import net.ipc.utils.NumberUtils

class AccountingEntryService {

    def constructAcctEntryGrid(display) {
		
		def list = display.collect {
			
			def debitAmount = (it.entryType == 'Debit') ? NumberUtils.currencyFormat(new Double(it.originalAmount)) : ""
			def creditAmount = (it.entryType == 'Credit') ? NumberUtils.currencyFormat(new Double(it.originalAmount)) : ""
			def debitBaseAmount = (it.entryType == 'Debit') ? NumberUtils.currencyFormat(new Double(it.pesoAmount)) : ""
			def creditBaseAmount = (it.entryType == 'Credit') ? NumberUtils.currencyFormat(new Double(it.pesoAmount)) : ""
			
			def particularsNoCIFName = it.particulars.split("\\|")[0]
									

			[id: it.ID,
				cell:[
						it.unitCode,
						//it.respondingUnitCode, -- #4077
						it.bookCode,
						it.accountingCode,
						particularsNoCIFName, 	//Removed |<CIF NAME>
						it.bookCurrency,
						debitAmount, 			//Debit Amount
						creditAmount, 			//Credit Amount
						debitBaseAmount, 		//Debit Peso Amount
						creditBaseAmount,		//Credit Peso Amount
						it.gltsNumber
	
				]
			]			
			
		}
		
		return list
	}
	
}
