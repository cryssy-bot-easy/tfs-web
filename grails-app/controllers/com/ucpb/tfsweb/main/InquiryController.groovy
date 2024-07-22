package com.ucpb.tfsweb.main

import grails.converters.JSON
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils

import java.text.DateFormat
import java.text.DecimalFormat
import java.text.ParseException
import java.text.SimpleDateFormat

/**
 * User: Marv
 * Date: 08/12/12
 * 
 * PROLOGUE
 * SCR/ER Description: redmine 3800 - DBC/EBC - No Option for Cancellation
 *	[Revised by:] Maximo Brian Lulab
 *	[Date revised:] 3/31/2016
 *	Program [Revision] Details: to add option for cancellation for DBC negotiation
 *	Date deployment: 3/15/2016 
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: InquiryController.groovy 
 */
 
 /**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: InquiryController
 */

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Revised by:] John Patrick C. Bautista
	[Date Revised:] 08/16/2017
	Program [Revision] Details: Added method to render IC Inquiry. Added method for querying and constructing IC Inquiry grid.
	PROJECT: tfs-web
	MEMBER TYPE  : Groovy
	Project Name: InquiryController
 */
class InquiryController {

    def etsService
    def dataEntryService
    def inquiryService
    def unactedService
    def mdService
    def apService
    def arService

    def exportAdvisingService
    def exportBillsService

    def corresChargesSettlementService

    def coreAPIService
	
	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	DateFormat ds = new SimpleDateFormat("MMddyyyy");
    
    String userGroup() {
        if(session['userrole']['id'].startsWith('BR')) {
            session['group'] = 'BRANCH'
        } else if(session['userrole']['id'].startsWith('TSD')) {
            session['group'] = 'TSD'
        } else if(session['userrole']['id'].startsWith('TEL')) {
            session['group'] = 'TELECOMS'
        } else {
            session['group'] = 'NONE'
        }

        return session['group'].toString()
    }

    def viewEtsInquiry() {
        //String title = userGroup().equals("branch") ? "Branch eTS Inquiry" : "Main eTS Inquiry"
        String title = "eTS - Inquiry" //ginaya lang ung title sa screenshot
        render(view: "/inquiry/ets_inquiry", model:[title: title]) //pass val here
    }

    def viewLcInquiry() {
        //String title = userGroup().equals("branch") ? "Branch LC Inquiry" : "Main LC Inquiry"
        String title = "LC Document - Inquiry" //ginaya lang ung title sa screenshot
        render(view: "/inquiry/lc_inquiry", model:[title: title])
    }
	
	def viewIcInquiry() {
		String title = "IC Inquiry" 
		render(view: "/inquiry/ic_inquiry", model:[title: title])
	}

    def viewNonLcInquiry() {
//        String title = userGroup().equals("branch") ? "Branch Non-LC Inquiry" : "Main Non-LC Inquiry"
        String title = "Non LC Document - Inquiry" //ginaya lang ung title sa screenshot
        render(view: "/inquiry/non_lc_inquiry", model:[title: title])
    }

    def viewMdCollectionInquiry() {
        String title = "MD Collection - Inquiry"
        render(view:"/inquiry/md_collection_inquiry", model:[title: title])
    }

    def viewMdApplicationInquiry() {
        String title = "MD Application - Inquiry"
        render(view:"/inquiry/md_application_inquiry", model:[title: title])
    }

    def viewBgInquiry() {
        String title = "BG - Inquiry"
        render(view:"/inquiry/bg_inquiry", model:[title: title])
    }

    def viewNegotiationInquiry() {
        String title = "Negotiation - Inquiry"
        render(view:"/inquiry/negotiation_inquiry", model:[title: title])
    }
    
    def viewDataEntryInquiry() {
		String title = "Data Entry - Inquiry"
		render(view: "/inquiry/dataentry_inquiry", model:[title: title])
	}

	def viewImportAdvanceInquiry() {
        String title = "Import Advance - Inquiry" //rename via Joey (Dec. 4, 2012)
        render(view: "/inquiry/import_advance_inquiry", model:[title: title])
    }

    def viewExportAdvanceInquiry() {
        String title = "Export Advance - Inquiry" //rename via Joey (Dec. 4, 2012)
        render(view: "/inquiry/export_advance_inquiry", model:[title: title])
    }
	
	def viewActualCorresTransactionInquiry() {
		String title = "Settlement of Actual Corres Charges - Inquiry"
		render(view: "/inquiry/actual_corres_transaction_inquiry", model:[username: params.username, title: title])
	}
	
	def viewArMonitoringInquiry() {
		String title = "AR Monitoring - Inquiry"
		render(view: "/inquiry/ar_monitoring_inquiry", model:[title: title])
	}
	
	def viewApMonitoringInquiry() {
		String title = "AP Monitoring - Inquiry"
		render(view: "/inquiry/ap_monitoring_inquiry", model:[title: title])
	}

	def viewClientFileInquiry() {
		String title = "Collection of Custom Duties and Taxes - Inquiry Client"
		render(view: "/inquiry/client_file_inquiry", model:[username: params.username, title: title])
	}
	
	def viewCdtInquiry() {
		String title = "Collection of Custom Duties and Taxes - Inquiry Payment"
		render(view: "/inquiry/cdt_inquiry", model:[username: params.username, title: title])
	}
	
	def viewRemittanceInquiry() {
		String title = "Remittance of Custom Duties and Taxes - Inquiry"
		render(view: "/inquiry/remittance_inquiry", model:[username: params.username, title: title])
	}
	
	def viewOtherImportChargesInquiry() {
		String title = "Payment of Other Import Charges - Inquiry"
		render(view: "/inquiry/other_import_charges_inquiry", model:[username: params.username, title: title])
	}

	def viewRebateInquiry() {
		String title = "Rebate of Inquiry - TSD"
		render(view: "/inquiry/rebate_inquiry", model:[username: params.username, title: title])
	}
	
	def viewRefundCashLcChargesInquiry() {
		String title = "Refund Cash LC and/or Charges - Inquiry"
		render(view: "/inquiry/refund_cash_lc_charges_inquiry", model:[username: params.username, title: title])
	}
	
	//tempoarary view, just to display mt monitoring grid for user type telecom
	def viewMtMonitoringInquiry() {
		String title = "Outgoing MT Monitoring - MT Message"
		render(view: "/inquiry/mt_monitoring_inquiry", model:[title: title])
	}



    def viewApInquiry() {
        String title = "AP Monitoring - Inquiry"
        render(view: "/inquiry/ap_monitoring_inquiry", model:[title: title])
    }

    def viewArInquiry() {
        String title = "AR Monitoring - Inquiry"
        render(view: "/inquiry/ar_monitoring_inquiry", model:[title: title])
    }

    def searchEtsInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = etsService.findAllApprovedEtsWithParams(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows?:0
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = (session.userrole.id.contains("TS")) ?
            inquiryService.constructEtsMainInquiryGrid(mapList.display, session.username) :
            inquiryService.constructEtsBranchInquiryGrid(mapList.display, session.username)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchLcInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		try{
			if(params.openingDateFrom){
				params.openingDateFrom = ds.format(df.parse(params.openingDateFrom))
			}
			if(params.openingDateTo){
				params.openingDateTo = ds.format(df.parse(params.openingDateTo))
			}
		}catch (ParseException e) {
		e.printStackTrace();
		}
		
        def mapList = dataEntryService.findAllDataEntryWithParams(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows?:0
        def numberOfPages = Math.ceil(totalRows / maxRows)
        ////printlnsession['userrole']['id']
        def results
        if(session['userrole']['id'].startsWith('BR')) {
            results = inquiryService.constructBranchLcInquiryGrid(mapList.display)
        } else if (session['userrole']['id'].startsWith('TS')) {
            results = inquiryService.constructTsdLcInquiryGrid(mapList.display)
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
	
	def searchIcInquiryGrid() {
		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		try{
			if(params.openingDateFrom){
				params.openingDateFrom = ds.format(df.parse(params.openingDateFrom))
			}
			if(params.openingDateTo){
				params.openingDateTo = ds.format(df.parse(params.openingDateTo))
			}
		}catch (ParseException e) {
		e.printStackTrace();
		}
		
		def mapList = dataEntryService.getAllDataEntryWithParams(maxRows, rowOffset, currentPage, params);

		def totalRows = mapList.totalRows?:0
		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results
		if (session['userrole']['id'].startsWith('TS')) {
			results = inquiryService.constructTsdIcInquiryGrid(mapList.display)
		}

		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		render jsonData as JSON
	}

    def searchNonLcInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		params.userrole = (session['userrole']['id'].startsWith('BR')) ? 'BRANCH' : (session['userrole']['id'].startsWith('TS')) ? 'TSD' : null
		try{
			if(params.negotiationDateFrom){
				params.negotiationDateFrom = ds.format(df.parse(params.negotiationDateFrom))
			}
	        if(params.negotiationDateTo){
				params.negotiationDateTo = ds.format(df.parse(params.negotiationDateTo))
	        }
		}catch (ParseException e) {
		e.printStackTrace();
		}

        def mapList = dataEntryService.findAllNonLcDataEntryWithParams(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results
        if(session['userrole']['id'].startsWith('BR')) {
            results = inquiryService.constructBranchNonLcInquiryGrid(mapList.display)
        } else if (session['userrole']['id'].startsWith('TS')) {
            results = inquiryService.constructTsdNonLcInquiryGrid(mapList.display)
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // md collection inquiry for branch
    def searchBranchMdCollectionInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = mdService.findAllMdCollection(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructBranchMdCollectionInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // md collection inquiry for main
    def searchMainMdCollectionInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = mdService.findAllMdCollection(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructMainMdCollectionInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }


    // md application inquiry for branch
    def searchBranchMdApplicationInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = mdService.findAllMdApplication(maxRows, rowOffset, currentPage, params)
        ////println"mapList >> " + mapList.display
        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructBranchMdApplicationInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // md application inquiry for main
    def searchMainMdApplicationInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = mdService.findAllMdApplication(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructMainMdApplicationInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def togglePnSupport() {
        Boolean success = mdService.togglePnSupport(params)

        def jsonData = [success: success.toString()]

        render jsonData as JSON
    }

    // negotiation inquiry
    def searchNegotiationInquiryGrid() {
		println "params Negotiation: "+params
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		try{
			if(params.negotiationDateFrom){
				params.negotiationDateFrom = ds.format(df.parse(params.negotiationDateFrom))
			}
			if(params.negotiationDateTo){
				params.negotiationDateTo = ds.format(df.parse(params.negotiationDateTo))
			}
		}catch (ParseException e) {
		e.printStackTrace();
		}
		Map<String, Object> mapList
//		println "flash.tempResult.length()" + flash?.tempResult?.size()
//		if(flash?.tempResult && ((!flash?.tempResult?.param?.documentNumber || flash?.tempResult?.param?.documentNumber == params?.documentNumber) &&
//			 (!flash?.tempResult?.param?.clientName || flash?.tempResult?.param?.clientName == params?.clientName) && 
//			 (!flash?.tempResult?.param?.negotiationNumber || flash?.tempResult?.param?.negotiationNumber == params?.negotiationNumber) && 
//			 (!flash?.tempResult?.param?.cifName || flash?.tempResult?.param?.cifName == params?.cifName) && 
//			 (!flash?.tempResult?.param?.negotiationDateFrom || flash?.tempResult?.param?.negotiationDateFrom == params?.negotiationDateFrom) && 
//			 (!flash?.tempResult?.param?.negotiationDateTo || flash?.tempResult?.param?.negotiationDateTo == params?.negotiationDateTo) &&
//			 (!flash?.tempResult?.param?.unitcode || flash?.tempResult?.param?.unitcode == params?.unitcode))){
//			mapList = dataEntryService.findAllNegotiationDataEntryByCache(maxRows, rowOffset, currentPage, flash.tempResult.queryResult)
//		} else {
        	mapList = dataEntryService.findAllNegotiationDataEntry(maxRows, rowOffset, currentPage, params)
//		}
//		flash.tempResult = [param: params, queryResult: mapList?.queryResult]

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
		def results
		if(session['userrole']['id'].startsWith('BR')) {
			results = inquiryService.constructNegotiationInquiryBranch(mapList.display)
		} else if (session['userrole']['id'].startsWith('TS')) {
        	results = inquiryService.constructNegotiationInquiryTsd(mapList.display)
		}

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // view data entry from grid
    def viewDataEntry() {
        def forwardMap = unactedService.evaluateDataEntryParams(params)

        forward(forwardMap)
    }

    // bg inquiry
    def searchIndemnityInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = dataEntryService.findAllIndemnityIssuance(maxRows, rowOffset, currentPage, params)
		
        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results
		if(session['userrole']['id'].startsWith('BR')) {
			results = inquiryService.constructIndemnityInquiryBranch(mapList.display)
		} else if (session['userrole']['id'].startsWith('TS')) {
			results = inquiryService.constructIndemnityInquiryTsd(mapList.display)
		}
		
        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // tsd ap inquiry
    def searchMainApInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = apService.findAllAccountsPayable(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results

        if (session['group'].equals('BRANCH')) {
            results = inquiryService.constructBranchApInquiry(mapList.display)
        } else {
            results = inquiryService.constructMainApInquiry(mapList.display)
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // tsd ar inquiry
    def searchMainArInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = arService.findAllAccountsReceivable(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results

        if (session['group'].equals('BRANCH')) {
            results = inquiryService.constructBranchArInquiry(mapList.display)
        } else {
            results = inquiryService.constructMainArInquiry(mapList.display)
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // branch ap inquiry
    def searchBranchApInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = apService.findAllAccountsPayable(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructBranchApInquiry(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // branch ar inquiry
    def searchBranchArInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = arService.findAllAccountsReceivable(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructBranchArInquiry(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // data entry inquiry
    def searchDataEntryInquiryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = dataEntryService.findAllDataEntry(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
		println "totalRows"+totalRows
        def numberOfPages = totalRows ? Math.ceil(totalRows / maxRows) : 1
        def results = inquiryService.constructDataEntryInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // settlement of actual corres charges inquiry
    def searchActualCorresCharges() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = corresChargesSettlementService.findAllAdvanceCorresCharges(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        println 'h' + session['group']
        def results = mapList.display.collect() {

            String createString = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber+"'; createCorresEts(id);\">create ets</a>"

            def outstandingAdvance = it.totalAdvancedAmount - it.totalCoveredAmount

            if ("TSD".equals(session['group'])) {
                createString = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber+"'; createCorresDataEntry(id);\">create data entry</a>"

                if (outstandingAdvance <= 0) {
                    createString = ""
                }
                [id: it.documentNumber,
					cell: [
					 	it.ccbdBranchUnitCode,
                        it.documentNumber,
                        it.cifName,
                        DateUtils.shortDateFormat(it.createdDate ? new Date(it.createdDate) : new Date()),
                        NumberUtils.currencyFormat(outstandingAdvance),
                        createString
                    ]
        		]
            } else {
				[id: it.documentNumber,
					cell: [
					   it.documentNumber,
					   it.cifName,
					   DateUtils.shortDateFormat(it.createdDate ? new Date(it.createdDate) : new Date()),
					   NumberUtils.currencyFormat(outstandingAdvance),
					   createString
				   ]
			   ]
            }

        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def cdtInquiryPaymentInquiry() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		params.processingUnitCode = session.unitcode
		
		//Additional
		if(params.branchListCode)
		params.unitCode = params.branchListCode
		else
        params.unitCode = session.unitcode

        def mapList = inquiryService.findAllCdtPayments(maxRows, rowOffset, currentPage, params)
        println "cdtInquiryPaymentInquiry"
        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructCdtPaymentInquiryGrid(mapList.display, params.processingUnitCode, session.userrole.id)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
	
	def viewCdtEmailTableResend() {
		def maxRows = params.int('rows') ?: 50
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = inquiryService.findAllCdtEmailTable(maxRows, rowOffset, currentPage, params)
		def totalRows = mapList.totalRows
		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = inquiryService.constructCdtEmailTableGrid(mapList.display)

		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		render jsonData as JSON
	}
	
	
    def cdtInquiryRemittanceInquiry() {
        println "cdtInquiryRemittanceInquiry"
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = inquiryService.findAllCdtRemittance(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows?:0
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructCdtRemittanceInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def cdtInquiryClientInquiry() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

//        String uploader = "TSD"
//
//        if (session.userrole.id.startsWith("BR")) {
//            uploader = "BRANCH"
//        }

//        def mapList = inquiryService.findAllCdtClients(maxRows, rowOffset, currentPage, params)
        def mapList = inquiryService.findAllCdtClients2(maxRows, rowOffset, currentPage, params, session.unitcode)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructCdtClientInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def cdtTransactionsInquiry() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        params.unitcode = session.unitcode
//        params.uploadDate DateUtils.shortDateFormat(new Date())
        params.uploadDate = DateUtils.shortDateFormat(new Date())


        def mapList = inquiryService.findTodaysCdtTransactions(maxRows, rowOffset, currentPage, params)
        println "cdtTransactionsInquiry"
        // will be use use for if condition in inquiryservice
		def headerTitle = params.headerTitle
//        println params.headerTitle
        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
//        def results = inquiryService.constructCdtTransactionsUploadGrid(mapList.display, headerTitle)
        def results = inquiryService.constructCdtPaymentGrid(mapList.display)
		
        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def cdtTransactionsHistoryInquiry() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

//        def mapList = inquiryService.findTodaysCdtTransactions(maxRows, rowOffset, currentPage, params)
        params.unitCode = session.unitcode
//		println "###################" + params.sentBOCDate + "###############################"
//        println "params.unitCode " + params.unitCode
        def mapList = inquiryService.findTodaysCdtHistoryTransactions(maxRows, rowOffset, currentPage, params)
        println "cdtTransactionsHistoryInquiry"
        // will be use use for if condition in inquiryservice
        def headerTitle = params.headerTitle
//        println params.headerTitle
        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructCdtPaymentHistoryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
		
    }

    def searchRefundInquiry() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = dataEntryService.findAllDataEntryWithParams(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = inquiryService.constructRefundInquiryGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchImportAdvanceInquiry() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

//        def mapList = dataEntryService.findAllDataEntryWithParams(maxRows, rowOffset, currentPage, params)
        def criteriaMap = [cifName: params.cifName ?: null,
                           documentNumber: params.documentNumber ?: null,
                           currency: params.currency ?: null,
                           amountFrom: params.amountFrom ?: null,
                           amountTo: params.amountTo ?: null,
						   unitcode: params.unitcode ?: null,
						   unitCode: params.unitCode ?: null]

        def importAdvanceList = coreAPIService.dummySendQuery(criteriaMap, "search", "importadvance/payment/")?.details
		DecimalFormat df = new DecimalFormat("#,##0.00")
        def totalRows = importAdvanceList.size() ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results
			if(session['userrole']['id'].startsWith('BR')) {
				results = importAdvanceList.collect {
		            [id: it.documentNumber.documentNumber,
		                    cell: [
		                            it.documentNumber.documentNumber,
		                            it.cifName,
		                            it.currency.currencyCode,
		                            df.format(it.amount),
		                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; refundImportAdvance(id);\">refund</a>"
		                    ]
		            ]
		        }
			} else if (session['userrole']['id'].startsWith('TS')) {
				results = importAdvanceList.collect {
					[id: it.documentNumber.documentNumber,
							cell: [
									it.ccbdBranchUnitCode,
									it.documentNumber.documentNumber,
									it.cifName,
									it.currency.currencyCode,
									df.format(it.amount),
							]
					]
				}
			}

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchExportAdvanceInquiry() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def criteriaMap = [cifName: params.cifNameInquiry ?: null,
                documentNumber: params.documentNumber ?: null,
                currency: params.currency ?: null,
                amountFrom: params.amountFrom ?: null,
                amountTo: params.amountTo ?: null,
				unitCode: params.unitCode ?: null,
				unitcode: params.unitcode ?: null]
        def exportAdvanceList = coreAPIService.dummySendQuery(criteriaMap, "search", "exportadvance/payment/")?.details
		
        def totalRows = exportAdvanceList ? exportAdvanceList.size() : 0
        def numberOfPages = Math.ceil(totalRows / maxRows)

		def results
			if(session['userrole']['id'].startsWith('BR')) {
				results = exportAdvanceList.collect {

					[id: it.documentNumber.documentNumber,
	                    cell: [
	                            it.documentNumber.documentNumber,
	                            it.cifName,
	                            it.currency.currencyCode,
	                            it.amount ? NumberUtils.currencyFormat((Double)it.amount) : "0.00",
	                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; refundExportAdvance(id);\">refund</a>"
	                    ]
					]
				}
			} else if(session['userrole']['id'].startsWith('TS')) {
				results = exportAdvanceList.collect {
					
					[id: it.documentNumber.documentNumber,
					 cell: [
						 	it.ccbdBranchUnitCode,
					        it.documentNumber.documentNumber,
					        it.cifName,
					        it.currency.currencyCode,
					        it.amount ? NumberUtils.currencyFormat((Double)it.amount) : "0.00"
					        		]
					        				]
				}
			}

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def exportAdvisingInquiry() {
        String title = "Export Advising - Inquiry" //ginaya lang ung title sa screenshot
        render(view: "../inquiry/export_advising_inquiry", model:[title: title])
    }

    def exportAdvisingPaymentInquiry() {
        String title = "Export Advising (Payment) - Inquiry" //ginaya lang ung title sa screenshot
        render(view: "../inquiry/export_advising_payment_inquiry", model:[title: title])
    }

    def searchExportAdvisingPayment() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def paramMap = [documentNumber: params.documentNumber ?: "",
                lcNumber: params.lcNumber ?: "",
                exporterName: params.exporterName ?: "",
                processDate: params.processDate ?: "",
				unitCode: params.unitCode ?: ""]

        def resultMap = exportAdvisingService.searchExportAdvisingForPayment(paramMap, maxRows, currentPage, rowOffset)

        def totalRows = resultMap.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = resultMap.display.collect {

            Map<String, Object> map = JSON.parse(it.DETAILS)

            String payString = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.TRADESERVICEID+"'; payExportAdvising(id);\">pay transaction</a>"

            if (map.hasDuplicate) {
                payString = ""
            }

            [id: it.TRADESERVICEID,
                    cell: [
							it.CCBDBRANCHUNITCODE,
                            it.DOCUMENTNUMBER,
                            it.SERVICETYPE.replace("_ADVISING",""),
                            it.LCNUMBER,
                            it.EXPORTERNAME,
                            it.ISSUINGBANK,
//                            it.PAYMENTSTATUS,
                            payString
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchExportAdvising() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def paramMap = [documentNumber: params.documentNumber ?: "",
                lcNumber: params.lcNumber ?: "",
                exporterName: params.exporterName ?: "",
                processDate: params.processDate ?: "",
				unitCode: params.unitCode ?: ""]

        def resultMap = exportAdvisingService.searchExportAdvising(paramMap, maxRows, currentPage, rowOffset)

        def totalRows = resultMap.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = resultMap.display.collect {
            [id: it.documentNumber.documentNumber,
                    cell: [
							it.ccbdBranchUnitCode,
                            it.documentNumber.documentNumber,
                            it.lastTransaction, //it.cifName,
                            it.lcNumber.documentNumber,
                            it.currency.currencyCode,
                            NumberUtils.currencyFormat(new Double(it.amount.toString())),
                            it.exporterName,
                            it.issuingBank,
                            !("Cancellation".equals(it.lastTransaction)) ?
                                "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; var advisingBankType='"+it.advisingBankType+"'; createExportAdvising(id, advisingBankType);\">create transaction</a>" :
                                ""
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def payExportAdvisingTransaction() {
        params.unitcode = session.unitcode
        params.username = session.username

        Map returnedValues = coreAPIService.dummySendCommand(params, "payTransaction", "exportAdvising").details

        chain(controller: "exportAdvising", action: "viewPayment", model: [tradeServiceId: returnedValues.tradeServiceId.tradeServiceId])
    }

    def exportBillsInquiry() {
        String title = "Export Bills - Inquiry" //ginaya lang ung title sa screenshot
        render(view: "../inquiry/export_bills_inquiry", model:[title: title])
    }

    def searchExportBills() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def paramMap = [documentNumber: params.documentNumber ?: "",
            currency: params.currency ?: "",
            amountFrom: params.amountFrom,
            amountTo: params.amountTo, 
            cifName: params.cifName ?: "",
            corresBankCode: params.corresBankCode ?: "",
            serviceType: params.serviceType ?: "",
            transactionType: params.transactionType ?: "",
            status: params.status ?: "",
			unitCode: params.unitCode ?: "",
			unitcode: params.unitcode ?: ""]

        def result = inquiryService.searchExportBills(paramMap, maxRows, currentPage, rowOffset)
        println result
        def totalRows = result.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)


        def results

        String ahref = ""

        if ("BRANCH".equals(session.group)) {
            results = result.display.collect {
                String documentType = ""

                if (it.exportBillType in ["EBC", "EBP"]) {
                    documentType = "FOREIGN"
                } else {
                    documentType = "DOMESTIC"
                }

                ahref = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; var documentType='"+documentType+"'; settleExportBills(id, documentType);\">create eTS</a>"

                if (it.exportBillType in ["EBP", "DBP"] || it.status == "SETTLED") {
                    ahref = ""
                }

                [id: it.documentNumber.documentNumber,
                        cell: [
                                it.documentNumber.documentNumber,
                                it.cifName,
								it.exportBillType,
								it.status,
                                it.currency.currencyCode,
								NumberUtils.currencyFormat(it.outstandingAmount),
                                NumberUtils.currencyFormat(it.amount),
                                ahref
                        ]
                ]
            }
        } else if (session.group.contains("TSD")) {
        	results = result.display.collect {
                String transaction

                ahref = ""

                switch (it.exportBillType) {
                    case "EBP":
                        transaction = "Export Bills for Purchase"
						if(it.negotiationNumber != null) {
							ahref = ""
						}
						else {
							ahref = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; var documentType='FOREIGN'; var documentClass='BP'; transactBP(id, documentType, documentClass);\">settle</a>"
						}
                        break;
                    case "DBP":
                        transaction = "Domestic Bills for Purchase"
                        ahref = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; var documentType='DOMESTIC'; var documentClass='BP'; transactBP(id, documentType, documentClass);\">settle</a>"
                        break;
                    case "EBC":
                        transaction = "Export Bills for Collection"
                        if (!("CANCELLED".equals(it.status))) {
                            ahref = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; var documentType='FOREIGN'; var documentClass='BC'; transactBC(id, documentType, documentClass);\">cancel</a>"
							  }
                        break;
                    case "DBC":
                        transaction = "Domestic Bills for Collection"
						//add option for cancellation for redmine 3800 as of 03/31/2016
						if (!("CANCELLED".equals(it.status))) {
							ahref = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber.documentNumber+"'; var documentType='DOMESTIC'; var documentClass='BC'; transactBC(id, documentType, documentClass);\">cancel</a>"
								}
						//end of redmine 3800
                        break;
                }
				
				if (it.status == "SETTLED") {
					ahref = ""
				}

                [id: it.documentNumber.documentNumber,
                        cell: [
								it.ccbdBranchUnitCode,
                                it.documentNumber.documentNumber,
                                it.cifName,
                                it.corresBankCode,
                                transaction,
                                it.status,
                                it.processDate ? DateUtils.shortDateFormat(DateUtils.parse(it.processDate)) : "",
								NumberUtils.currencyFormat(new Double(it.outstandingAmount ? it.outstandingAmount.toString() : "0.0")),
                                NumberUtils.currencyFormat(new Double(it.amount ? it.amount.toString() : "0.0")),
                                it.settlementDate ? DateUtils.shortDateFormat(DateUtils.parse(it.settlementDate)) : "",
                                it.proceedsAmount ? NumberUtils.currencyFormat(new Double(it.proceedsAmount.toString())) : "",
                                ahref
                        ]
                ]
            }
        }


        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchRebates() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def paramMap = [corresBankCode: params.corresBankCode ?: "",
						unitCode: params.unitCode ?: ""]

        def result = inquiryService.searchRebates(paramMap, maxRows, currentPage, rowOffset)

        def totalRows = result.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = result.display.collect {

            [id: it.documentNumber.documentNumber,
                    cell:[
                          it.ccbdBranchUnitCode,
                            it.corresBankCode,
                            NumberUtils.currencyFormat(it.amount),
                            it.particulars,
                            DateUtils.shortDateFormat(DateUtils.parse(it.processDate.toString()))
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchImportProducts() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def result = inquiryService.searchImportProducts(params, maxRows, currentPage, rowOffset)

        def totalRows = result.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = result.display.collect {

            [id: it.documentNumber,
                    cell:[
                            it.documentNumber,
                            it.cifName,
                            NumberUtils.currencyFormat(new Double(it.outstandingBalance)),
							it.lastTransaction,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber+"'; refundPayments(id);\">refund</a>",
							it.documentClass
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchAllImportsForOtherCharges() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def result = inquiryService.searchAllImports(params, maxRows, currentPage, rowOffset)

        def totalRows = result.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = result.display.collect {
            String href = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber+"'; payOtherCharges(id);\">pay other charges</a>"

            if (!session['userrole']['id']?.equalsIgnoreCase("BRM")) {
                href = ""
            }

            [id: it.documentNumber,
                    cell:[
							it.documentNumber,
							it.productType,
							it.unitCode,
                            it.cifNumber,
                            it.cifName,
                            href
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewOtherExportChargesInquiry() {
        String title = "Payment of Other Export Charges - Inquiry"
        render(view: "/inquiry/other_export_charges_inquiry", model:[username: params.username, title: title])
    }

    def viewRefundExportChargesInquiry() {
        String title = "Refund of Other Export Charges - Inquiry"
        render(view: "/inquiry/refund_export_charges_inquiry", model:[username: params.username, title: title])
    }

    def searchAllExportsForOtherCharges() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def result = inquiryService.searchAllExports(params, maxRows, currentPage, rowOffset)

        def totalRows = result.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = result.display.collect {
            String href = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber+"'; payOtherCharges(id);\">pay other charges</a>"

            if (!session['userrole']['id']?.equalsIgnoreCase("BRM")) {
                href = ""
            }

            [id: it.documentNumber,
                    cell:[
							it.unitCode,
                            it.cifName,
                            it.productType,
                            it.documentNumber,
                            NumberUtils.currencyFormat(it.amount),
                            it.importerName,
                            it.exporterName,
                            href
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def searchAllExportsForRefund() {

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def result = inquiryService.searchAllExports(params, maxRows, currentPage, rowOffset)

        def totalRows = result.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = result.display.collect {
            String href = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.documentNumber+"'; refundExportCharge(id);\">refund</a>"

            if (!session['userrole']['id']?.equalsIgnoreCase("BRM")) {
                href = ""
            }

            [id: it.documentNumber,
                    cell:[
                            it.unitCode,
                            it.cifName,
                            it.productType,
                            it.documentNumber,
                            NumberUtils.currencyFormat(it.amount),
                            it.importerName,
                            it.exporterName,
                            href
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def getEtsDetails(String etsNumber, String lastUser, String currentOwner) {
        println params
        def response = coreAPIService.dummySendQuery([etsNumber: etsNumber,
                roleId: "BRO",
                unitCode: session.unitcode,
                lastUser: lastUser,
                currentOwner: currentOwner],
                "getNextBranchApprovers", "ets/")?.response

        render([nextBranchApprovers: response?.nextBranchApprovers,
                routedTo: response?.routedTo] as JSON)
    }
    def rerouteServiceInstruction() {
		params.loggedInUsername = session.username
		Map returnedValues = coreAPIService.dummySendCommand(params, "rerouteServiceInstruction", "ets");
		def errMessage = returnedValues.get("errMessage");
		def defaultAddress = returnedValues.get("email");
		def title = "eTS - Inquiry" //ginaya lang ung title sa screenshot
		def errModel
		
		if (errMessage != null){
			errModel = [title: title ,emailErr: true, message: errMessage, defaultAddress: defaultAddress]
		} else {
			errModel = [title: title]
		}
		render(view: "/inquiry/ets_inquiry", model: errModel) 
   }
		
	
	def viewOutgoingMt() {
		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = unactedService.findAllOutgoingMt(maxRows, rowOffset, currentPage)

		def totalRows = mapList.totalRows
		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = inquiryService.constructOutgoingMt(mapList.display)

		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		render jsonData as JSON
	}

//    def searchLcInquiryGrid() {
//        def maxRows = params.int('rows') ?: 10
//        def currentPage = params.int('page') ?: 1
//        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
//
//        def mapList = inquiryService.findAllCdtPayments(maxRows, rowOffset, currentPage, params)
//        println "cdtInquiryPaymentInquiry"
//        def totalRows = mapList.totalRows
//        def numberOfPages = Math.ceil(totalRows / maxRows)
//        def results = inquiryService.constructCdtPaymentInquiryGrid(mapList.display)
//
//        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
//        render jsonData as JSON
//    }
}
