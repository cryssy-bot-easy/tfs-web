package tfs.web

import grails.converters.JSON

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: TfsWebSelectTagLib
 
 * 	(revision).
	[Modified by:] Rafael Ski Poblete
	[Date Deployed:] 08/08/2018
	Description : Added senderToReceiverTypeforMT730 to be use in MT730 module only.
	
	[Date Modified:] 08/28/2018
	Description : Added senderToReceiverTypeforMT700 to be use in MT700 module only.
	
	[Date Modified:] 09/11/2018
	Description : Added senderToReceiverTypeforMT752 to be use in MT752 module only.
 */

/**
 * Description:   Modified formOfDocumentaryCredit and added purposeOfMessage for fixing MT707
 * Modified by:   Cedrick C. Nungay
 * Date Modified: 08/06/18
 */

class TfsWebSelectTagLib {

    def documentFormatService
    def coreAPIService

    static namespace = "tfs"

    def availableBy = { attrs, body ->
		//attrs.from = ["BY ACCEPTANCE", "BY DEFAULT PAYMENT", "BY MIXED PAYMENT", "BY MIXED PAYMENT", "BY PAYMENT"]
		//BASED FROM FSD
        attrs.from = ["BY ACCEPTANCE", "BY DEFAULT PAYMENT", "BY MIXED PAYMENT", "BY NEGOTIATION", "BY PAYMENT"]
		//Attrs.keys = ["BY ACCEPTANCE", "BY DEFAULT PAYMENT", "BY MIXED PAYMENT", "BY MIXED PAYMENT", "BY PAYMENT"]
		//BASED FROM FSD
        attrs.keys = ["A", "D", "M", "N", "P"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def docType = { attrs, body ->
        attrs.from = ["CONTRACT", "LETTER OF CREDIT", "BILL OF LADING"]
        attrs.keys = ["CON", "LC", "BL"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def status = { attrs, body ->
        attrs.from = ["PREPARED","CHECKED","APPROVED"]
        attrs.keys = ["PREPARED","CHECKED","APPROVED"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }
    
    def tradeProductStatus = { attrs, body ->
		attrs.from = ["OPEN", "CANCELLED", "CLOSED", "EXPIRED", "REINSTATED", "HOLD", "POSTED"]
		attrs.keys = ["OPEN", "CANCELLED", "CLOSED", "EXPIRED", "REINSTATED", "HOLD", "POSTED"]
		attrs.noSelection = ["": "SELECT ONE..."]
		out << g.select(attrs)
    }

    def etsStatus = { attrs, body ->
        attrs.from = ["DRAFT", "PREPARED", "CHECKED", "APPROVED", "DISAPPROVED", "RETURNED", "FOR REVERSAL", "REVERSED"]
        attrs.keys = ["DRAFT", "PREPARED", "CHECKED", "APPROVED", "DISAPPROVED", "RETURNED", "FOR_REVERSAL", "REVERSED"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }
	
	def dataEntryStatus = { attrs, body ->
		attrs.from = ["PREPARED", "CHECKED", "APPROVED", "DISAPPROVED", "RETURNED", "POSTED", "PRE APPROVED", "POST APPROVED"]
		attrs.keys = ["PREPARED", "CHECKED", "APPROVED", "DISAPPROVED", "RETURNED", "POSTED", "PRE_APPROVED", "POST_APPROVED"]
		attrs.noSelection = ["": "SELECT ONE..."]
		out << g.select(attrs)
	}

    def transactionType = { attrs, body ->
        attrs.from = ["FXLC REGULAR OPENING",
                      "FXLC CASH OPENING",
                      "FXLC STANDBY OPENING",
                      "DMLC REGULAR OPENING",
                      "DMLC CASH OPENING",
                      "DMLC STANDBY OPENING"]

        attrs.keys = ["FOREIGN-LC-REGULAR-OPENING",
                      "FOREIGN-LC-CASH-OPENING",
                      "FOREIGN-LC-STANDBY-OPENING",
                      "DOMESTIC-LC-REGULAR-OPENING",
                      "DOMESTIC-LC-CASH-OPENING",
                      "DOMESTIC-LC-STANDBY-OPENING"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def priceTerm = { attrs, body ->
        def DROPDOWN_VALUES = servletContext.dropdownValues

        Map<String,Object> map = (Map<String,Object>)DROPDOWN_VALUES.priceTerm[0]

        def valueList = []

        map.values().each{
			valueList << it.toString().toUpperCase()

        }

        attrs.from = map.values()
        attrs.keys = map.keySet().toArray()

        // attrs.from = valueList //map.values()
        // attrs.keys = valueList //map.keySet().toArray()

        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def tenor = { attrs, body ->
        def DROPDOWN_VALUES = servletContext.dropdownValues

        Map<String,Object> map = (Map<String,Object>)DROPDOWN_VALUES.tenor[0]

        def valueList = []

        map.values().each{
            if (((session.etsModel?.title?.contains('Amendment')) ||
                 (session.dataEntryModel?.title?.contains('Amendment')) &&
                    it?.toString()?.trim()?.equalsIgnoreCase('USANCE')) ||
                    session.etsModel?.title?.contains('Opening')){

                valueList << it?.toString()?.trim().toUpperCase()
			}
        }

        attrs.from = valueList //map.values()
        attrs.keys = valueList //map.keySet().toArray()
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def applicableRules = { attrs, body ->
        attrs.from = ["THE GUARANTEE IS SUBJECT TO INTERNATIONAL STANDBY PRACTICES", "THE GUARANTEE IS NOT SUBJECT TO ANY RULES", "THE GUARANTEE IS SUBJECT TO ANOTHER SET OF RULES, WHICH MUST BE SPECIFIED IN NARRATIVE (2ND SUBFIELD)", "THE GUARANTEE IS SUBJECT TO THE ICC UNIFORM RULES FOR DEMAND GUARANTEES"]
        attrs.keys = ["THE GUARANTEE IS SUBJECT TO INTERNATIONAL STANDBY PRACTICES", "THE GUARANTEE IS NOT SUBJECT TO ANY RULES", "THE GUARANTEE IS SUBJECT TO ANOTHER SET OF RULES, WHICH MUST BE SPECIFIED IN NARRATIVE (2ND SUBFIELD)", "THE GUARANTEE IS SUBJECT TO THE ICC UNIFORM RULES FOR DEMAND GUARANTEES"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def formOfDocumentaryCredit = { attrs, body ->
        def dataEntryModel = session.dataEntryModel
        if (dataEntryModel.documentType == 'FOREIGN' && dataEntryModel.documentClass == 'LC' &&
            (dataEntryModel.documentSubType1 == 'CASH' || dataEntryModel.documentSubType1 == 'REGULAR') &&
            dataEntryModel.serviceType == 'Amendment') {
            attrs.from = ['IRREVOCABLE', 'IRREVOCABLE TRANSFERABLE', 'IRREVOCABLE STANDBY', 'IRREVOC TRANS STANDBY']
            attrs.keys = ['I', 'IT', 'IS', 'ITS']
        } else {
            def options = ["IRREVOCABLE STANDBY", "REVOCABLE STANDBY", "IRREVOC TRANS STANDBY"]
            attrs.from = options
            attrs.keys = ['IS', 'RS', 'ITS']
        }
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def marineInsurance = { attrs, body ->
        attrs.from = ["C/O CLIENT", "C/O UCPBGEN"]
        attrs.keys = ["CLIENT", "UCPB_GEN"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def negotiationType = { attrs, body ->
        attrs.from = ["IMPORT BILLS", "UNDER ACCEPTANCE", "CASH LC", "TRUST RECEIPT"]
        attrs.keys = ["IB", "UA", "CL", "TR"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }
	
	//created by Arvin Guiam
	def currency = { attrs, body ->
		Map<String, Object> Rates = session.etsModel.rates
		def Currency = new ArrayList<String>()
		//ensures that the currencies PHP, USD and EUR are always on top
		Currency.add('PHP')
		Currency.add('USD')
		Currency.add('EUR')
		for (String Format : Rates.keySet().sort()){
			//ensures that the rest of the entries are not duplicates of PHP, USD and EUR
			if(!Format.contains('PHP') && !Format.contains('USD') && !Format.contains('EUR')){
				Currency.add(Format.toString().trim())
			}
		}
		attrs.from = Currency
		attrs.noSelection = ["": "SELECT ONE..."]
		out << g.select(attrs)
	}
	
	/*def settlementCurrency = { attrs, body ->
		def Currency = new ArrayList<String>()
		//ensures that PHP and USD is in the select dropdown
		Currency.add('PHP')
		Currency.add('USD')
		def currency = session.etsModel?.currency ?: session.chargesModel?.currency
		if(currency && !currency.contains('PHP') && !currency.contains('USD')){
			Currency.add(currency)
		}
		attrs.from = Currency
		attrs.noSelection = ["": "SELECT ONE..."]
		out << g.select(attrs)
	}*/

    def formatType = { attrs, body ->
        List<String> documentFormat

		/*if(attrs?.tagging){
			println "tagging: " + attrs.tagging
			def tagging = ("P".equals(attrs.tagging) || "PERFORMANCE".equals(attrs.tagging)) ? "PERFORMANCE" : "FINANCIAL"
			documentFormat = documentFormatService.findAllDocumentFormatByTagging(tagging)
		} else {*/
			documentFormat = documentFormatService.findAllDocumentFormat()
//		}
        attrs.from = documentFormat
        attrs.key = documentFormat
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def transactionName = { attrs, body ->
        attrs.from = ["ADJUSTMENT", "AMENDMENT", "CANCELLATION", "INDEMNITY ISSUANCE", "INDEMNITY CANCELLATION", "NEGOTIATION", "NEGOTIATION DISCREPANCY", "OPENING", "UA LOAN MATURITY ADJUSTMENT", "UA LOAN SETTLEMENT"]
        attrs.keys = ["ADJUSTMENT", "AMENDMENT", "CANCELLATION-LC", "ISSUANCE", "CANCELLATION-INDEMNITY", "NEGOTIATION", "NEGOTIATION_DISCREPANCY", "OPENING", "UA_LOAN_MATURITY_ADJUSTMENT", "UA_LOAN_SETTLEMENT"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }
    
//    def currencies = { attrs, body ->
//        ["USD",
//        "AUD",
//        "BRL",
//        "CAD",
//        "CHF",
//        "CNY",
//        "EUR",
//        "GBP",
//        "HKD",
//        "IDR",
//        "INR",
//        "JPY",
//        "KRW",
//        "MXN",
//        "MYR",
//        "PHP",
//        "RUB",
//        "SAR",
//        "SGD",
//        "THB",
//        "AED"]
//        attrs.from = []
//        attrs.keys = []
//        attrs.noSelection = ["":"SELECT ONE..."]
//        out << g.select(attrs)
//    }

    def documentClass = { attrs, body ->
        attrs.from = ["LC", "INDEMNITY", "NON-LC", "IMPORT ADVANCE", "AUXILIARY IMPORT PRODUCTS", "AUXILIARY EXPORT PRODUCTS", "EXPORT BILLS", "EXPORT ADVANCE","EXPORT ADVISING"]
        attrs.keys = ["LC", "INDEMNITY", "NON-LC", "IMPORT_ADVANCE", "AUXILIARY_IMPORT_PRODUCTS", "AUXILIARY_EXPORT_PRODUCTS", "EXPORT_BILLS", "EXPORT_ADVANCE","EXPORT_ADVISING"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def documentType = { attrs, body ->
        attrs.from = ["FOREIGN", "DOMESTIC"]
        attrs.keys = ["FOREIGN", "DOMESTIC"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

   def typeOfReport = { attrs, body ->
        attrs.from = ["IPF","FINAL CDT","ADVANCE CDT","EXPORT CHARGES","ALL"]
        attrs.keys = ["IPF","FINAL_CDT","ADVANCE_CDT","EXPORT_CHARGES","ALL"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }
   
   
   
   //ADDITIONAL
   
   def branchListCode = { attrs, body ->
	   def ret = coreAPIService.sendQuery('getAllBranchCode', [:])
	   def temp = ret.response
	   //        println "temp:"+temp
			   def from = []
			   def keys = []
		   temp.each{ laman ->
	   
			   from << ""+laman+""
			   keys << ""+laman+"" //added for accounting to get ID
			   println laman.toString();
	   
		   }
	   
			   attrs.from = from
			   attrs.keys = keys
			   attrs.noSelection = ["": "SELECT ONE..."]
			   out << g.select(attrs)
   }

    // yes, yes - with email advice, yes - without email advice, no

    def autoDebit = { attrs, body ->
        attrs.from = ["YES - WITH EMAIL ADVICE", "YES - WITHOUT EMAIL ADVICE", "NO"]
        attrs.keys = ["YES", "YES_WITH_EMAIL", "NO"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def operationBankCode = { attrs, body ->
        attrs.from = ["CRED", "SPAY", "SPRI", "SSTD"]
        attrs.keys = ["CRED", "SPAY", "SPRI", "SSTD"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def chargesInNegoCcy = { attrs, body ->
        attrs.from = ["AGENT", "COMM", "CORCOM", "DISC", "INSUR", "POST", "STAMP", "TELECHAR", "WAREHOUS"]
        attrs.keys = ["AGENT", "COMM", "CORCOM", "DISC", "INSUR", "POST", "STAMP", "TELECHAR", "WAREHOUS"]
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def paymentTransactionTypeImports = { attrs, body ->

    def ret = coreAPIService.sendQuery('getAllProductService', [:])

    def temp = ret.response
//        println "temp:"+temp
        def from = []
        def keys = []
    temp.each{ laman ->

        from << ""+laman.PRODUCTID+" "+laman.SERVICETYPE + ""
        keys << ""+laman.PRODUCTID+" "+laman.SERVICETYPE + "|" + laman.ID //added for accounting to get ID

    }

        attrs.from = from
        attrs.keys = keys
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def paymentTransactionTypeExports = { attrs, body ->
        def from = ["NEGOTIATION",
                "SETTLEMENT",
                "OPENING ADVISING",
                "AMENDMENT ADVISING",
                "CANCELLATION ADVISING"]

        def keys = ["NEGOTIATION",
                "SETTLEMENT",
                "OPENING_ADVISING",
                "AMENDMENT_ADVISING",
                "CANCELLATION_ADVISING"]

        attrs.from = from
        attrs.keys = keys
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def paymentChargeTypeImports = { attrs, body ->


        def from = ["Bank Commission",
                "MARINE / FIRE INSURANCE"]
        def keys = ["Bank Commission",
                "MARINE / FIRE INSURANCE"]
//        //TODO GET FROM QUERY FROM DATABASE

        //Just in case
//        def ret = coreAPIService.sendQuery('getAllCharge', [:])
//
//        def temp = ret.response
//        def from = []
//        def keys = []
//        temp.each{ laman ->
//
//            from << ""+laman.DISPLAYNAME+""
//            keys << ""+laman.DISPLAYNAME+""
//
//        }



        attrs.from = from
        attrs.keys = keys
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def paymentChargeTypeExports = { attrs, body ->
        def from = ["BANK COMMISSION",
                "CABLE FEE",
                "DOCUMENTARY STAMP",
                "OTHER LOCAL BANK'S CHARGES"]

        attrs.from = from
        attrs.keys = from
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }

    def exportTransactions = { attrs, body ->
        def from = ["EXPORT BILLS FOR COLLECTION",
                "DOMESTIC BILLS FOR COLLECTION",
                "EXPORT BILLS FOR PURCHASE",
                "DOMESTIC BILLS FOR PURCHASE",
                "EXPORT ADVISING"]

        def keys = ["EBC",
                "DBC",
                "EBP",
                "DBP",
                "EXPORT_ADVISING"]

        attrs.from = from
        attrs.keys = keys
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }
	
	def senderToReceiverTypeforMT730 = { attrs ->
		attrs.from = ['BENACC','BENREJ']//		//attrs.from = ['BENCON', 'PHONBEN', 'TELEBEN']//EDITED BY MAX SENDER RECEIVER
		attrs.noSelection = ['':'SELECT ONE...']
		attrs.class="${attrs.class} select_dropdown"
		out << g.select(attrs)
	}
	
	def senderToReceiverTypeforMT700 = { attrs ->
		attrs.from = ['PHONBEN', 'TELEBEN']
		attrs.noSelection = ['':'SELECT ONE...']
		attrs.class="${attrs.class} select_dropdown"
		out << g.select(attrs)
	}
	
	def senderToReceiverTypeforMT752 = { attrs ->
		attrs.from = ['RCB']
		attrs.noSelection = ['':'SELECT ONE...']
		attrs.class="${attrs.class} select_dropdown"
		out << g.select(attrs)
	}
	
	def senderToReceiverType1 = { attrs ->
	    attrs.from = ['REIMBREF']
		attrs.noSelection = ['':'SELECT ONE...']
		//henry
		attrs.class="${attrs.class} select_dropdown"
		out << g.select(attrs)
	}

	def senderToReceiverType2 = { attrs ->
		attrs.from = ['ACC','INS','INT','REC']
		attrs.noSelection = ['':'SELECT ONE...']
		attrs.class="select_dropdown"
		out << g.select(attrs)
	}

    def disposalOfDocuments = { attrs ->
    attrs.from = ['HOLD','NOTIFY','PREVINST','RETURN']
    		attrs.noSelection = ['':'SELECT ONE...']
    				attrs.class= "${attrs.class} select_dropdown"
    				out << g.select(attrs)
    }

    def purposeOfMessage = { attrs ->
        def options = ["ACNF", "ADVI", "ISSU"]
        attrs.from = options
        attrs.keys = options
        attrs.noSelection = ["": "SELECT ONE..."]
        out << g.select(attrs)
    }
}
