package com.ucpb.tfsweb.main

import grails.converters.JSON
import net.ipc.utils.NumberUtils

/**
 * Description:    Added filterByIdOrLabel, autoCompleteFormOfUndertaking, autoCompleteFunctionOfMessage,
 *                     autoCompleteFileIdentification methods for mt759
 * Modified by:    Cedrick C. Nungay
 * Date Modified:  09/18/2018
 */
class AutoCompleteController {

        def foreignExchangeService
        def coreAPIService
	
		//COUNTRY CODE
		def autoCompleteCountry(){

			String name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

            def ret = coreAPIService.sendQuery('getAllCountries', [keyword: name_startsWith])

            def temp = ret.response

			temp.each{ laman ->
					resultsList << [id: laman.CNTRY_CD, label: laman.CNTRY_NAME]
			}

			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
		}

		//COUNTRY CODE ISO
        def autoCompleteCountryIso(){

        	String name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

			def ret = coreAPIService.sendQuery('getAllISOCountries', [keyword: name_startsWith])
			
			def temp = ret.response
			temp.each{ laman ->
			resultsList << [id: laman.CNTRY_ISO + " - " + laman.CNTRY_NAME + " - " + laman.CNTRY_CD, label: laman.CNTRY_NAME, hidden: laman.CNTRY_CD]
			}
			
        	def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
        	render jsonData as JSON
        }

		def autoCompleteBanks(){

			def name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

            if (name_startsWith.contains("ANY BANK")) {
                resultsList << [id: "ANY BANK", label: "ANY BANK"]
            } else {
                def ret = coreAPIService.sendQuery('findBanksByKeyword', [keyword: name_startsWith])

                def temp = ret.response

                ////println"ret.response >> " + ret.response

                temp.each{ laman ->
                    resultsList << [id: laman.BIC_CODE+((laman.BRANCH_CODE != 'NULL' && laman.BRANCH_CODE != null) ? laman.BRANCH_CODE : 'XXX'), label: laman.INSTITUTION_NAME, address: laman.ADDRESS, cb_creditor_code: laman.CB_CREDITOR_CODE,currency:laman.REIMBURSING_CURR, fcduAccount:laman.FCDU_ACCOUNT, rbuAccount:laman.RBU_ACCOUNT, glcode: laman.GL_BANK_CD, glcodefcdu: laman.GL_CODE_FCDU, glcoderbu: laman.GL_CODE_RBU]
                }
            }

			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
			
		}

		def autoCompleteLocalBanks(){

			def name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

            if (name_startsWith.contains("ANY BANK")) {
                resultsList << [id: "ANY BANK", label: "ANY BANK"]
            } else {
                def ret = coreAPIService.sendQuery('findLocalBanksByKeyword', [keyword: name_startsWith])

                def temp = ret.response

                ////println"ret.response >> " + ret.response

                temp.each{ laman ->
                    resultsList << [id: laman.BIC_CODE+((laman.BRANCH_CODE != 'NULL' && laman.BRANCH_CODE != null) ? laman.BRANCH_CODE : 'XXX'), label: laman.INSTITUTION_NAME, address: laman.ADDRESS]
                }
            }

			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
			
		}

		def autoCompleteRmaBanks(){
			def name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

            if (name_startsWith.contains("ANY BANK")) {
                resultsList << [id: "ANY BANK", label: "ANY BANK"]
            } else {
                def ret = coreAPIService.sendQuery('findRmaBanksByKeyword', [keyword: name_startsWith])

                def temp = ret.response


				println "test by Robin: " // trying to get swift address
                temp.each{ laman ->
                println laman.BRANCH_CODE
                    //resultsList << [id: laman.BIC_CODE, label: laman.INSTITUTION_NAME, address: laman.ADDRESS, test: laman.BIC_CODE]
					resultsList << [id: laman.BIC_CODE+((laman.BRANCH_CODE != 'NULL' && laman.BRANCH_CODE != null) ? laman.BRANCH_CODE : 'XXX'), label: laman.INSTITUTION_NAME, address: laman.ADDRESS, cb_creditor_code: laman.CB_CREDITOR_CODE,currency:laman.REIMBURSING_CURR, fcduAccount:laman.FCDU_ACCOUNT, rbuAccount:laman.RBU_ACCOUNT, glcode: laman.GL_BANK_CD, glcodefcdu: laman.GL_CODE_FCDU, glcoderbu: laman.GL_CODE_RBU]
                }
            }

			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
			
		}

    def autoCompleteDepositoryBanks(){
        println "params " + params
        def name_startsWith = params.starts_with.toUpperCase()
        def currency = params.currency?.toUpperCase()
        def resultsList = []

        if (name_startsWith.contains("ANY BANK")) {
            resultsList << [id: "ANY BANK", label: "ANY BANK"]
        } else {
            def ret = coreAPIService.sendQuery('findDepositoryBanksByKeywordAndCurrency', [keyword: name_startsWith, currency:  currency])

//            def ret = coreAPIService.sendQuery('findDepositoryBanksByKeyword', [keyword: name_startsWith])

            def temp = ret.response

            temp.each{ laman ->
                resultsList << [id: laman.BIC_CODE, label: laman.INSTITUTION_NAME, fcduAccount:laman.FCDU_ACCOUNT, rbuAccount:laman.RBU_ACCOUNT, glcode: laman.GL_BANK_CD, glcodefcdu: laman.GL_CODE_FCDU, glcoderbu: laman.GL_CODE_RBU, currency:laman.REIMBURSING_CURR, cb_creditor_code: laman.CB_CREDITOR_CODE]
            }
        }

        def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
        render jsonData as JSON

    }
		
		//CURRENCIES
		def autoCompleteCurrency(){

            def name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

			//SIR INSERT List HERE
			def temp = [
					["id":"USD", "label":"US Dollar"],
					["id":"AUD", "label":"Australian Dollar"],
					["id":"BRL", "label":"Brazilian Real"],
					["id":"CAD", "label":"Canadian Dollar"],
					["id":"CHF", "label":"Swiss Franc"],
					["id":"CNY", "label":"Chinese Yuan"],
					["id":"EUR", "label":"Euro"],
					["id":"GBP", "label":"British Pound"],
					["id":"HKD", "label":"Hong Kong Dollar"],
					["id":"IDR", "label":"Indonesian Rupiah"],
					["id":"INR", "label":"Indian Rupee"],
					["id":"JPY", "label":"Japanese Yen"],
					["id":"KRW", "label":"South Korean Won"],
					["id":"MXN", "label":"Mexican Peso"],
					["id":"MYR", "label":"Malaysian Ringgit"],
					["id":"RUB", "label":"Russian Ruble"],
					["id":"SAR", "label":"Saudi Riyal"],
					["id":"SGD", "label":"Singapore Dollar"],
					["id":"THB", "label":"Thai Baht"],
					["id":"AED", "label":"United Arab Emirates Dirham"]
			]

			
            if (!params.type?.equals("FX")) {
                //println"type is FX.. no PHP available"
                temp << ["id":"PHP", "label":"Philippine Peso"]
            }

			temp.each{ laman ->
				//Kung ano pwede maging searchable
				if(laman.id.toUpperCase().contains(name_startsWith) ||  laman.label.toUpperCase().contains(name_startsWith)){
						  
					resultsList << laman
				
				}
			}

			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
			
		}

    def autoCompleteUsdPhpOnlyCurrency(){

        def name_startsWith = params.starts_with.toUpperCase()
        def resultsList = []

        //SIR INSERT List HERE
        def temp = [
                ["id":"USD", "label":"US Dollar"],
                ["id":"PHP", "label":"Philippine Peso"]
        ]

        temp.each{ laman ->
            //Kung ano pwede maging searchable
            if(laman.id.toUpperCase().contains(name_startsWith) ||  laman.label.toUpperCase().contains(name_startsWith)){

                resultsList << laman

            }
        }

        def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
        render jsonData as JSON

    }
		
		
		//CB CODE
		def autoCompleteCBCode(){

			def name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

            def ret = coreAPIService.sendQuery('findImporterByKeyword', [keyword: name_startsWith])

            def temp = ret.response

            temp.each{ laman ->
                ////printlnlaman
                resultsList << [id: laman.CB_CD, clientId: laman.ID, label: laman.CL_SH_NAME, address: laman.CL_ADDR_1 + '\n' + laman.CL_ADDR_2 + '\n' + laman.CL_ADDR_3?.value + '\n' + laman.CL_ADDR_4?.value, cifNumber: laman.UCPB_CIF_NO ]
            }
			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
			
		}
		
		//CB CODE
		def autoCompleteClient(){
			
			def name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []
	
			def ret = coreAPIService.sendQuery('findAllImporterByKeyword', [keyword: name_startsWith])

			def temp = ret.response

			temp.each{ laman ->
				////printlnlaman
				resultsList << [id: laman.CB_CD ?: laman.ID, clientId: laman.ID, label: laman.CL_SH_NAME, address: laman.CL_ADDR_1 + '\n' + laman.CL_ADDR_2 + '\n' + laman.CL_ADDR_3?.value + '\n' + laman.CL_ADDR_4?.value, cifNumber: laman.UCPB_CIF_NO ]
			}
			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
			
		}
		
		//IDENTIFIER CODE
		def autoCompleteIDCode(){

			def name_startsWith = params.starts_with.toUpperCase()
			def resultsList = []

            if (name_startsWith.contains("ANY BANK")) {
                resultsList << [id: "ANY BANK", label: "ANY BANK"]
            } else {
                def ret = coreAPIService.sendQuery('findBanksByKeyword', [keyword: name_startsWith])

                def temp = ret.response

                ////println"ret.response >> " + ret.response

                temp.each{ laman ->
                    resultsList << [id: laman.BIC_CODE, label: laman.INSTITUTION_NAME]
                }
            }

			def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
			render jsonData as JSON
			
		}

    def autoCompleteSettlementCurrency(){

        def name_startsWith = params.starts_with.toUpperCase()
        //println"name_startsWith >> " + name_startsWith
        def resultsList = []

        String currency = null

		if (session.etsModel){
	        session.etsModel.each {
	            //printlnit
	        }
		}

		if (session?.etsModel?.shipmentCurrency || session?.chargesModel?.shipmentCurrency || session?.dataEntryModel?.shipmentCurrency) {
			currency = session?.etsModel?.shipmentCurrency ?: session?.chargesModel?.shipmentCurrency  ?: session?.dataEntryModel?.shipmentCurrency
        } else if (session?.etsModel?.negotiationCurrency || session?.chargesModel?.negotiationCurrency || session?.dataEntryModel?.negotiationCurrency) {
            currency = session?.etsModel?.negotiationCurrency ?: session?.chargesModel?.negotiationCurrency ?: session?.dataEntryModel?.negotiationCurrency
        } else if (session?.etsModel?.currency || session?.chargesModel?.currency || session?.dataEntryModel?.currency) {
            currency = session?.etsModel?.currency ?: session?.chargesModel?.currency ?: session?.dataEntryModel?.currency
        }

		//println"currency === " + currency
        def temp = foreignExchangeService.obtainSettlementCurrency(currency)

        println "temp >> " + temp
        println name_startsWith
        temp.each{ laman ->
            ////printlnlaman.id.toUpperCase() + " >> " + name_startsWith
            //Kung ano pwede maging searchable
            if(laman.id.toUpperCase().contains(name_startsWith) ||  laman.label.toUpperCase().contains(name_startsWith)){

                resultsList << laman

            }
        }

        def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
        render jsonData as JSON

    }
	
	def autoCompleteDomesticProductCurrency(){
		def name_startsWith = params.starts_with.toUpperCase()
		def resultsList = []
		
		println "name_startsWith" + name_startsWith
		def temp = foreignExchangeService.obtainDomesticProductCurrency(params.currency)
		
		temp.each{ laman ->
			if(laman.id.toUpperCase().contains(name_startsWith) ||  laman.label.toUpperCase().contains(name_startsWith)){

				resultsList << laman

			}
		}

		def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
		render jsonData as JSON
	}

	def autoCompleteDomesticSettlementCurrency(){
		
		def name_startsWith = params.starts_with.toUpperCase()
//		println"name_startsWith >> " + name_startsWith
		def resultsList = []

		String currency = null

		if (session.etsModel){
			session.etsModel.each {
				//printlnit
			}
		}

		if (session?.etsModel?.shipmentCurrency || session?.chargesModel?.shipmentCurrency) {
			currency = session?.etsModel?.shipmentCurrency ?: session?.chargesModel?.shipmentCurrency
		} else if (session?.etsModel?.negotiationCurrency || session?.chargesModel?.negotiationCurrency) {
			currency = session?.etsModel?.negotiationCurrency ?: session?.chargesModel?.negotiationCurrency
		} else if (session?.etsModel?.currency || session?.chargesModel?.currency) {
			currency = session?.etsModel?.currency ?: session?.chargesModel?.currency
		}

		//println"currency === " + currency
		def temp = foreignExchangeService.obtainSettlementCurrency(currency)

//        //println"temp >> " + temp

		temp.each{ laman ->
			////printlnlaman.id.toUpperCase() + " >> " + name_startsWith
			//Kung ano pwede maging searchable
			if(laman.id.toUpperCase().contains(name_startsWith) ||  laman.label.toUpperCase().contains(name_startsWith)){

				resultsList << laman

			}
		}

		def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
		render jsonData as JSON

	}
	
    def autoCompleteTransactionTypeCode(){

        def name_startsWith = params.starts_with.toUpperCase()
        def resultsList = []

        //SIR INSERT List HERE
        def temp = [
                ["id":"A00", "label":"A00"],
                ["id":"A02", "label":"A02"],
                ["id":"A03", "label":"A03"],
                ["id":"A10", "label":"A10"],
                ["id":"A20", "label":"A20"],
                ["id":"A21", "label":"A21"],
                ["id":"A22", "label":"A22"],
                ["id":"A30", "label":"A30"],
                ["id":"A31", "label":"A31"],
                ["id":"A40", "label":"A40"],
                ["id":"A41", "label":"A41"],
                ["id":"A42", "label":"A42"],
                ["id":"A50", "label":"A50"],
                ["id":"A51", "label":"A51"],
                ["id":"B00", "label":"B00"],
                ["id":"B01", "label":"B01"],
                ["id":"B02", "label":"B02"],
                ["id":"B03", "label":"B03"],
                ["id":"B04", "label":"B04"],
                ["id":"B10", "label":"B10"],
                ["id":"B11", "label":"B11"],
                ["id":"B12", "label":"B12"],
                ["id":"B20", "label":"B20"],
                ["id":"B21", "label":"B21"],
                ["id":"B22", "label":"B22"],
                ["id":"B23", "label":"B23"],
                ["id":"B24", "label":"B24"],
                ["id":"B30", "label":"B30"],
                ["id":"B31", "label":"B31"],
                ["id":"B32", "label":"B32"],
                ["id":"B33", "label":"B33"],
                ["id":"B34", "label":"B34"],
                ["id":"B40", "label":"B40"],
                ["id":"B41", "label":"B41"],
                ["id":"C00", "label":"C00"],
                ["id":"C01", "label":"C01"],
                ["id":"C02", "label":"C02"],
                ["id":"C03", "label":"C03"],
                ["id":"C04", "label":"C04"],
                ["id":"D00", "label":"D00"],
                ["id":"D10", "label":"D10"],
                ["id":"E00", "label":"E00"],
                ["id":"E01", "label":"E01"],
                ["id":"E02", "label":"E02"],
                ["id":"E03", "label":"E03"],
                ["id":"F00", "label":"F00"],
                ["id":"F01", "label":"F01"],
                ["id":"F10", "label":"F10"],
                ["id":"F11", "label":"F11"],
                ["id":"F20", "label":"F20"],
                ["id":"F21", "label":"F21"],
                ["id":"F30", "label":"F30"],
                ["id":"F31", "label":"F31"],
                ["id":"F40", "label":"F40"],
                ["id":"F50", "label":"F50"],
                ["id":"F60", "label":"F60"],
                ["id":"F61", "label":"F61"],
                ["id":"F62", "label":"F62"],
                ["id":"G00", "label":"G00"],
                ["id":"G10", "label":"G10"],
                ["id":"G50", "label":"G50"],
                ["id":"G60", "label":"G60"],
                ["id":"G70", "label":"G70"],
                ["id":"H00", "label":"H00"],
                ["id":"H10", "label":"H10"],
                ["id":"H11", "label":"H11"],
                ["id":"H15", "label":"H15"],
                ["id":"H20", "label":"H20"],
                ["id":"H30", "label":"H30"],
                ["id":"H40", "label":"H40"],
                ["id":"H50", "label":"H50"],
                ["id":"H51", "label":"H51"],
                ["id":"H60", "label":"H60"],
                ["id":"H70", "label":"H70"],
                ["id":"H80", "label":"H80"],
                ["id":"H90", "label":"H90"],
                ["id":"H91", "label":"H91"],
                ["id":"H92", "label":"H92"],
                ["id":"I00", "label":"I00"],
                ["id":"I01", "label":"I01"],
                ["id":"I02", "label":"I02"],
                ["id":"K90", "label":"K90"],
                ["id":"J00I", "label":"J00I"],
                ["id":"J30", "label":"J30"],
                ["id":"J35", "label":"J35"],
                ["id":"J40", "label":"J40"],
                ["id":"J41", "label":"J41"],
                ["id":"J50", "label":"J50"],
                ["id":"K80", "label":"K80"],
                ["id":"L00", "label":"L00"],
                ["id":"L01", "label":"L01"],
                ["id":"L02", "label":"L02"],
                ["id":"L03", "label":"L03"],
                ["id":"L10", "label":"L10"],
                ["id":"L20", "label":"L20"],
                ["id":"L21", "label":"L21"],
                ["id":"L30", "label":"L30"],
                ["id":"L40", "label":"L40"],
                ["id":"M00I", "label":"M00I"],
                ["id":"M20", "label":"M20"],
                ["id":"M21", "label":"M21"],
                ["id":"M25", "label":"M25"],
                ["id":"M26", "label":"M26"],
                ["id":"M30", "label":"M30"],
                ["id":"M31", "label":"M31"],
                ["id":"M35", "label":"M35"],
                ["id":"M36", "label":"M36"],
                ["id":"M40", "label":"M40"],
                ["id":"M41", "label":"M41"],
                ["id":"M45", "label":"M45"],
                ["id":"M46", "label":"M46"],
                ["id":"M49", "label":"M49"],
                ["id":"M60", "label":"M60"],
                ["id":"M61", "label":"M61"],
                ["id":"M65", "label":"M65"],
                ["id":"M66", "label":"M66"],
                ["id":"M70", "label":"M70"],
                ["id":"M71", "label":"M71"],
                ["id":"M75", "label":"M75"],
                ["id":"M76", "label":"M76"],
                ["id":"M80", "label":"M80"],
                ["id":"M81", "label":"M81"],
                ["id":"M85", "label":"M85"],
                ["id":"M86", "label":"M86"],
                ["id":"M99", "label":"M99"],
                ["id":"N00I", "label":"N00I"],
                ["id":"P00", "label":"P00"],
                ["id":"P01", "label":"P01"],
                ["id":"P05", "label":"P05"],
                ["id":"P06", "label":"P06"],
                ["id":"P10", "label":"P10"],
                ["id":"P11", "label":"P11"],
                ["id":"P15", "label":"P15"],
                ["id":"P16", "label":"P16"],
                ["id":"P20", "label":"P20"],
                ["id":"P21", "label":"P21"],
                ["id":"P25", "label":"P25"],
                ["id":"P26", "label":"P26"],
                ["id":"P30", "label":"P30"],
                ["id":"P31", "label":"P31"],
                ["id":"P35", "label":"P35"],
                ["id":"P36", "label":"P36"],
                ["id":"P40", "label":"P40"],
                ["id":"P41", "label":"P41"],
                ["id":"P50", "label":"P50"],
                ["id":"P60", "label":"P60"],
                ["id":"P61", "label":"P61"],
                ["id":"P65", "label":"P65"],
                ["id":"P66", "label":"P66"],
                ["id":"P70", "label":"P70"],
                ["id":"P71", "label":"P71"],
                ["id":"P72", "label":"P72"],
                ["id":"P73", "label":"P73"],
                ["id":"Q00", "label":"Q00"],
                ["id":"Q05", "label":"Q05"],
                ["id":"Q10", "label":"Q10"],
                ["id":"Q11", "label":"Q11"],
                ["id":"Q20", "label":"Q20"],
                ["id":"R00", "label":"R00"],
                ["id":"R10", "label":"R10"],
                ["id":"R15", "label":"R15"],
                ["id":"R20", "label":"R20"],
                ["id":"R25", "label":"R25"],
                ["id":"R30", "label":"R30"],
                ["id":"R35", "label":"R35"],
                ["id":"R40", "label":"R40"],
                ["id":"R45", "label":"R45"],
                ["id":"R90", "label":"R90"],
                ["id":"R91", "label":"R91"],
                ["id":"R92", "label":"R92"],
                ["id":"R93", "label":"R93"],
                ["id":"R94", "label":"R94"],
                ["id":"J10", "label":"J10"],
                ["id":"J11", "label":"J11"],
                ["id":"J20", "label":"J20"],
                ["id":"J21", "label":"J21"],
                ["id":"K01", "label":"K01"],
                ["id":"K05", "label":"K05"],
                ["id":"K10", "label":"K10"],
                ["id":"K11", "label":"K11"],
                ["id":"K12", "label":"K12"],
                ["id":"K13", "label":"K13"],
                ["id":"K20", "label":"K20"],
                ["id":"K21", "label":"K21"],
                ["id":"K22", "label":"K22"],
                ["id":"K23", "label":"K23"],
                ["id":"K30", "label":"K30"],
                ["id":"K31", "label":"K31"],
                ["id":"K32", "label":"K32"],
                ["id":"K33", "label":"K33"],
                ["id":"K40", "label":"K40"],
                ["id":"K41", "label":"K41"],
                ["id":"K42", "label":"K42"],
                ["id":"K43", "label":"K43"],
                ["id":"K50", "label":"K50"],
                ["id":"K51", "label":"K51"],
                ["id":"K52", "label":"K52"],
                ["id":"K60", "label":"K60"],
                ["id":"K61", "label":"K61"],
                ["id":"K62", "label":"K62"],
                ["id":"K63", "label":"K63"],
                ["id":"K70", "label":"K70"],
                ["id":"K71", "label":"K71"],
                ["id":"K72", "label":"K72"],
                ["id":"K73", "label":"K73"],
                ["id":"M01", "label":"M01"],
                ["id":"M02", "label":"M02"],
                ["id":"M10", "label":"M10"],
                ["id":"M11", "label":"M11"],
                ["id":"M15", "label":"M15"],
                ["id":"M50", "label":"M50"],
                ["id":"M51", "label":"M51"],
                ["id":"M55", "label":"M55"],
                ["id":"N01", "label":"N01"],
                ["id":"N05", "label":"N05"],
                ["id":"N10", "label":"N10"],
                ["id":"N11", "label":"N11"],
                ["id":"N12", "label":"N12"],
                ["id":"N13", "label":"N13"],
                ["id":"N20", "label":"N20"],
                ["id":"N21", "label":"N21"],
                ["id":"N22", "label":"N22"],
                ["id":"N23", "label":"N23"],
                ["id":"N30", "label":"N30"],
                ["id":"N31", "label":"N31"],
                ["id":"N32", "label":"N32"],
                ["id":"N33", "label":"N33"],
                ["id":"N40", "label":"N40"],
                ["id":"N41", "label":"N41"],
                ["id":"N42", "label":"N42"],
                ["id":"N43", "label":"N43"],
                ["id":"N50", "label":"N50"],
                ["id":"N51", "label":"N51"],
                ["id":"N52", "label":"N52"],
                ["id":"N60", "label":"N60"],
                ["id":"N61", "label":"N61"],
                ["id":"N62", "label":"N62"],
                ["id":"N63", "label":"N63"],
                ["id":"N70", "label":"N70"],
                ["id":"N71", "label":"N71"],
                ["id":"N72", "label":"N72"],
                ["id":"N73", "label":"N73"]
        ]

        temp.each{ laman ->
            //Kung ano pwede maging searchable
            if(laman.id.toUpperCase().contains(name_startsWith) ||  laman.label.toUpperCase().contains(name_startsWith)){

                resultsList << laman

            }
        }

        def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
        render jsonData as JSON

    }

    def autoCompleteExportAdvising() {
        println "params >> " + params
        println "params >> " + params
        def resultsList = []

        def exportAdvising = coreAPIService.dummySendQuery([cifNumber: params.cifNumber, documentNumber : params.starts_with], "autoComplete", "exportAdvising/")?.details

        def temp = exportAdvising
		
		println "export advising autocomplete data: " + exportAdvising

        temp.each {

            def cif = [cifNumber: it.cifNumber,
            cifName: it.cifName,
            accountOfficer: it.accountOfficer,
            ccbdBranchUnitCode: it.ccbdBranchUnitCode,
			exporterCbCode: it.exporterCbCode,
			allocationUnitCode: it.allocationUnitCode,
			mainCifName: it.mainCifName,
			mainCifNumber: it.mainCifNumber]

            resultsList << [id: it.documentNumber.documentNumber,
                            label: it.documentNumber.documentNumber,
                            currency: it.currency.currencyCode,
                            amount: NumberUtils.currencyFormat(it.amount),
                            importerName: it.importerName,
                            exporterName: it.exporterName,
                            cbCode: it.exporterCbCode,
                            cif: cif,
                            buyerName: it.importerName,
                            sellerName: it.exporterName,
                            sellerAddress: it.exporterAddress,
                            buyerAddress: it.importerAddress]
        }

        def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
        render jsonData as JSON
    }
		
	def autoCompleteDigitalSignatories() {
		def name_startsWith = params.starts_with.toUpperCase()
		def resultsList = []

		def ret = coreAPIService.sendQuery('findAllDigitalSignatories', [keyword: name_startsWith])

		def temp = ret.response


		temp.each{ laman ->
			resultsList << [id: laman.FULLNAME, position: laman.POSITION]
		}

		def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
		render jsonData as JSON
	}
	
	//COMMODITY CODE
	def autoCompleteCommodityCode() {
		String name_startsWith = params.starts_with.toUpperCase()
		def resultsList = []
		def ret = coreAPIService.sendQuery('findCommodityCode', [keyword: name_startsWith])
		def temp = ret.response

		temp.each{
//				resultsList << [id: it.CODE, label: it.DESCRIPTION]
				resultsList << [id: it.CODE + ' - ' + it.DESCRIPTION, code: it.CODE, label: it.DESCRIPTION]
//				resultsList << [id: laman.CNTRY_ISO + " - " + laman.CNTRY_NAME + " - " + laman.CNTRY_CD, label: laman.CNTRY_NAME, hidden: laman.CNTRY_CD]
		}

		def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
		render jsonData as JSON
	}

	//PARTICULARS CODE
	def autoCompleteParticulars() {
		String name_startsWith = params.starts_with.toUpperCase()
		def resultsList = []
		def ret = coreAPIService.sendQuery('findParticulars', [keyword: name_startsWith])
		def temp = ret.response

		temp.each{
//			resultsList << [id: it.CODE, label: it.DESCRIPTION]
			resultsList << [id: it.CODE + ' - ' + it.DESCRIPTION, code: it.CODE, label: it.DESCRIPTION]
		}

		def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
				render jsonData as JSON
	}

	//PARTICIPANT CODE
	def autoCompleteParticipantCode() {
		String name_startsWith = params.starts_with.toUpperCase()
		def resultsList = []
		def ret = coreAPIService.sendQuery('findParticipantCode', [keyword: name_startsWith])
		def temp = ret.response

		temp.each{
			resultsList << [id: it.CODE, label: it.NAME]
		}

		def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
				render jsonData as JSON
	}

	def filterByIdOrLabel(list, filter) {
		def newResult = []
		list.each{ v ->
			if(v.id.toUpperCase().contains(filter) ||  v.label.toUpperCase().contains(filter)){
				newResult << v
			}
		}
		newResult
	}

	def autoCompleteFormOfUndertaking() {
		def name_startsWith = params.starts_with.toUpperCase(),
			resultsList = [ ['id':'DGAR', 'label':'Demand Guarantee'],
				['id':'DOCR', 'label':'Documentary Credit'], ['id':'STBY', 'label':'Standby Letter of Credit'],
				['id':'UNDK', 'label':'Undertaking'] ]

		render (['success':true, 'results':filterByIdOrLabel(resultsList, name_startsWith), 'total':resultsList.size()] as JSON)
	}

	def autoCompleteFunctionOfMessage() {
		def name_startsWith = params.starts_with.toUpperCase(),
				resultsList = [ ['id':'CLSVCLOS', 'label': 'Closing of client service call by Trade Operations'],
	                ['id':'CLSVOPEN', 'label': 'Opening of client service call by Trade Operations'],
	                ['id':'FRAUDMSG', 'label': 'Advice of a fraud attempt'],
	                ['id':'GENINFAD', 'label': 'General information advice'],
	                ['id':'ISSAMEND', 'label': 'Amendment of a free-form undertaking such as a dependent guarantee'],
	                ['id':'ISSUANCE', 'label': 'Issue of a free-form undertaking such as a dependent guarantee'],
	                ['id':'OTHERFNC', 'label': 'Other request'],
	                ['id':'REIMBURS', 'label': 'Request related to a reimbursement'],
	                ['id':'REQAMEND', 'label': 'Request to amend an undertaking'],
	                ['id':'REQFINAN', 'label': 'Financing request'],
	                ['id':'REQISSUE', 'label': 'Request to issue an undertaking'],
	                ['id':'TRANSFER', 'label': 'Transfer of an undertaking'] ]
		render (['success':true, 'results':filterByIdOrLabel(resultsList, name_startsWith), 'total':resultsList.size()] as JSON)
	}

	def autoCompleteFileIdentification() {
		def name_startsWith = params.starts_with.toUpperCase(),
				resultsList = [ ['id':'COUR', 'label': 'Courier delivery'],
				                ['id':'EMAL', 'label': 'Email transfer'],
				                ['id':'FACT', 'label': 'SWIFTNet FileAct'],
				                ['id':'FAXT', 'label': 'Fax transfer'],
				                ['id':'HOST', 'label': 'Host-to-Host'],
				                ['id':'MAIL', 'label': 'Postal delivery'],
				                ['id':'OTHR', 'label': 'Other delivery channel']]
		render (['success':true, 'results':filterByIdOrLabel(resultsList, name_startsWith), 'total':resultsList.size()] as JSON)
	}
	//PURPOSE OF MESSAGE
	def autoCompletePurposeOfMessage() {
        def name_startsWith = params.starts_with.toUpperCase()
        def resultsList = []
		
        def temp = [
            ["id":"ACNF", "label":"Advice and confirmation of the credit amendment"],
			["id":"ADVI", "label":"Advice of the credit amendment"],
			["id":"ISSU", "label":"Issuance of the credit amendment"]
        ]

        temp.each{ result ->
            if(result.id.toUpperCase().contains(name_startsWith) ||  result.label.toUpperCase().contains(name_startsWith)){

                resultsList << result

            }
        }

        def jsonData = ['success':true, 'results':resultsList, 'total':resultsList.size()]
        render jsonData as JSON
	}
	
//	def autoCompletePurposeOfMessage() {
//			def name_startsWith = params.starts_with.toUpperCase(),
//					resultsList = [ ["id":"ACNF", "label":"Advice and confirmation of the credit amendment"],
//									["id":"ADVI", "label":"Advice of the credit amendment"],
//									["id":"ISSU", "label":"Issuance of the credit amendment"]]
//			render (['success':true, 'results':filterByIdOrLabel(resultsList, name_startsWith), 'total':resultsList.size()] as JSON)
//	}
} //End of AutoCompleteController

		
		
		

