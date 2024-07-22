package com.ucpb.tfsweb.main
import grails.converters.JSON
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils
import org.apache.commons.lang.WordUtils
import org.grails.datastore.gorm.finders.MethodExpression.IsEmpty;
import org.springframework.transaction.annotation.Transactional

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: InquiryService
 */

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Revised by:] John Patrick C. Bautista
	[Date Revised:] 08/16/2017
	Program [Revision] Details: Added method for constructing the IC Inquiry grid.
	PROJECT: tfs-web
	MEMBER TYPE  : Groovy
	Project Name: InquiryService
 */
class InquiryService {

    def coreAPIService
    
    String getServiceType(serviceType) {
        switch (serviceType) {
            case "OPENING":
                return "Opening"
            case "AMENDMENT":
                return "Amendment"
            case "ADJUSTMENT":
                return "Adjustment"
            case "ISSUANCE":
                return "Issuance"
            case "CANCELLATION":
                return "Cancellation"
            case "NEGOTIATION":
                return "Negotiation"
            case "SETTLEMENT":
                return "Settlement"

            case "NEGOTIATION_DISCREPANCY":
                return "Negotiation Discrepancy"

            case "UA_LOAN_MATURITY_ADJUSTMENT":
                return "UA Loan Maturity Adjustment"
            case "UA_LOAN_SETTLEMENT":
                return "UA Loan Settlement"


            // For Documents against Acceptance
            case "NEGOTIATION_ACCEPTANCE":
                return "Negotiation Acceptance"
            case "NEGOTIATION_ACKNOWLEDGEMENT":
                return "Negotiation Acknowledgement"


            // For SettlementAccount: MD/AP/AR
            case "COLLECTION":
                return "Collection"
            case "APPLICATION":
                return "Application"
            case "REFUND":
                return "Monitoring Refund"
            case "SETUP":
                return "Setup"
            case "APPLY":
                return "Apply"
            case "SETTLE":
                return "Monitoring Settlement"
        }
    }

	//Bugfix #3187
    @Transactional(readOnly=true)
    def constructEtsBranchInquiryGrid(display, username) {

        Date today = new Date().clearTime()

        def list = display.collect {
            Map<String, Object> map = JSON.parse(it.DETAILS)

            String documentType = map.documentType ? ((map.documentType.equals("FOREIGN")) ? "FX" : "DM") : ''
            String documentClass = map.documentClass
            String documentSubType1 = (documentSubType1 == null ? "" : map.documentSubType1.charAt(0).toUpperCase().toString() + map.documentSubType1.substring(1, map.documentSubType1.length()).toLowerCase())

            Date dateApproved = it.DATEAPPROVED?.clearTime()

            Boolean isReversal = map.serviceType.contains("_REVERSAL")

            String reverseLink = (today == dateApproved && !isReversal && it.STATUS != 'REVERSED') ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; onReverseClick(id);\" >reverse</a>" : ""

            String rerouteLink = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; rerouteServiceInstruction(id);\" >re-route</a>"

            if (!it.LASTUSER.equals(username) || it.STATUS in ['RETURNED', 'APPROVED', 'REVERSED']) {
                rerouteLink = ""
            }

            [id: it.SERVICEINSTRUCTIONID,
                    cell: [
                        DateUtils.dateTimeFormat(it.CREATEDDATE),
                        DateUtils.dateTimeFormat(it.MODIFIEDDATE),
                        DateUtils.dateTimeFormat(it.DATEAPPROVED),
                        "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; onViewEtsClick(id);\" >" + it.SERVICEINSTRUCTIONID + "</a>",
                        map.cifNumber,
                        map.cifName,
                        (documentType + documentClass + " " + documentSubType1 + " " + map.serviceType)?.replaceAll("_", " "),
                		it.CREATEDBY ?: it.USERACTIVEDIRECTORYID,
                		it.APPROVEDBY ?: it.USERACTIVEDIRECTORYID,
                        it.LASTUSER ?: it.USERACTIVEDIRECTORYID,
                        it.STATUS,
//                        DateUtils.dateTimeFormat(new Date()),
//                        "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; onReroutePopupClick(id);\" >reroute</a>",
                        rerouteLink,
                        // !(it.TRADESERVICESTATUS in ["POSTED", "APPROVED", "PRE_APPROVED", "POST_APPROVED", "FOR_REVERSAL", "REVERSED"]) ? reverseLink : "", temporary hide since reversal is deferred
						!(it.TRADESERVICESTATUS in ["POSTED", "APPROVED", "PRE_APPROVED", "POST_APPROVED", "FOR_REVERSAL", "REVERSED"]) ? "" : "",
                        "MARV".equals(it.TRADESERVICESTATUS) ? "PENDING" : it.TRADESERVICESTATUS,
                        it.TSD_USER,
                        map.serviceType,
                        map.documentType,
                        map.documentClass,
                        map.documentSubType1,
                        map.documentSubType2,
                        it.TASKOWNER
                    ]
            ]
        }

        return list
    }
    
    @Transactional(readOnly=true)
    def constructEtsMainInquiryGrid(display, username) {
    	def list = display.collect {
    		Map<String, Object> map = JSON.parse(it.DETAILS)
    				
            String documentType = map.documentType ? ((map.documentType.equals("FOREIGN")) ? "FX" : "DM") : ''
    		String documentClass = map.documentClass
    		String documentSubType1 = map.documentSubType1 ? WordUtils.capitalizeFully(map.documentSubType1) : "" //map.documentSubType1?.charAt(0)?.toUpperCase()?.toString() + map.documentSubType1?.substring(1, map.documentSubType1.length()).toLowerCase()

            String rerouteLink = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; rerouteServiceInstruction(id);\" >re-route</a>"

            if (!it.LASTUSER.equals(username) || it.STATUS in ['RETURNED', 'APPROVED', 'REVERSED']) {
                rerouteLink = ""
            }

    		[id: it.SERVICEINSTRUCTIONID,
    		    cell: [
					it.UNITCODE,
    			    DateUtils.dateTimeFormat(it.CREATEDDATE),
    				"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; onViewEtsClick(id);\" >" + it.SERVICEINSTRUCTIONID + "</a>",
    				map.cifNumber,
    				map.cifName,
    				(documentType + documentClass + " " + documentSubType1 + " " + map.serviceType)?.replaceAll("_", " "),
    				it.LASTUSER ?: it.USERACTIVEDIRECTORYID,
    				it.STATUS,
//    				DateUtils.dateTimeFormat(new Date()),
//    				"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.SERVICEINSTRUCTIONID + "'; onReroutePopupClick(id);\" >reroute</a>",
                    rerouteLink,
    				map.serviceType,
    				map.documentType,
    				map.documentClass,
    				map.documentSubType1,
    				map.documentSubType2,
                    it.TASKOWNER
    			]
    		]
        }
    	
    	return list
    }
    
    @Transactional(readOnly=true)
    def constructBranchLcInquiryGrid(display) {
        def list = display.collect {
//            Map<String, Object> map = JSON.parse(it.DETAILS)


            [id: it.DOCUMENTNUMBER,
                    cell: [
                            it.DOCUMENTNUMBER,
                            it.CIFNUMBER,
							it.CIFNAME,
                            it.ORIGINALCURRENCY,
                            NumberUtils.currencyFormat(it.ORIGINALAMOUNT),
                            (it.OUTSTANDINGBALANCE > 0) ? NumberUtils.currencyFormat(it.OUTSTANDINGBALANCE) : NumberUtils.currencyFormat(new Double(0)),
							DateUtils.shortDateFormat(it.EXPIRYDATE),
                            it.LASTTRANSACTION,
							it.STATUS,
                            (!it.STATUS.equals("CANCELLED")) ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.DOCUMENTNUMBER + "'; onCreateEtsClick(id);\" >create eTS</a>" : "",
                            it.SERVICETYPE,
                            it.DOCUMENTTYPE,
                            it.DOCUMENTCLASS,
                            it.DOCUMENTSUBTYPE1,
                            it.DOCUMENTSUBTYPE2,
							it.MAINCIFNUMBER
                    ]
            ]
        }

        return list
//		//println"list = " +list
    }

    @Transactional(readOnly=true)
    def constructTsdLcInquiryGrid(display) {
        def list = display.collect {
                [id: it.DOCUMENTNUMBER,
                        cell: [
								it.UNITCODE,
                                it.DOCUMENTNUMBER,
                                it.CIFNUMBER,
                                it.CIFNAME,
                                it.ORIGINALCURRENCY,
                                NumberUtils.currencyFormat(it.ORIGINALAMOUNT),
                                (it.OUTSTANDINGBALANCE > 0) ? NumberUtils.currencyFormat(it.OUTSTANDINGBALANCE) : NumberUtils.currencyFormat(new Double(0)),
                                DateUtils.shortDateFormat(it.EXPIRYDATE),
                                it.LASTTRANSACTION,
                                it.STATUS,
								(!it.STATUS.equals("CANCELLED") && !it.STATUS.equals("CLOSED")) ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + it.DOCUMENTNUMBER + "'; onCreateEtsClick(id);\" >create Data Entry </a>" : "",
                                it.SERVICETYPE,
                                it.DOCUMENTTYPE,
                                it.DOCUMENTCLASS,
                                it.DOCUMENTSUBTYPE1,
                                it.DOCUMENTSUBTYPE2,
								it.MAINCIFNUMBER
                        ]
                ]
        }

        return list
    }
	
	@Transactional(readOnly=true)
	def constructTsdIcInquiryGrid(display) {
		def list = display.collect {
				[id: it.DOCUMENTNUMBER,
						cell: [
								it.UNITCODE,
								it.DOCUMENTNUMBER,
								it.CIFNAME,
								it.ORIGINALCURRENCY,
								NumberUtils.currencyFormat(it.ORIGINALAMOUNT),
								it.ICNUMBER,
								NumberUtils.currencyFormat(it.NEGOTIATIONAMOUNT),
//								it.ICDATE != null ? DateUtils.shortDateFormat(it.ICDATE) : DateUtils.shortDateFormat(it.LASTMODIFIEDDATE),
								DateUtils.shortDateFormat(it.LASTICDATE),
								"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\">Cancel </a>",
								it.SERVICETYPE,
								it.DOCUMENTTYPE,
								it.DOCUMENTCLASS,
								it.DOCUMENTSUBTYPE1,
								it.DOCUMENTSUBTYPE2,
								it.MAINCIFNUMBER
						]
				]
		}

		return list
	}

    @Transactional(readOnly=true)
    def constructBranchNonLcInquiryGrid(display) {
        def list = display.collect {
            String settleString = '<a href=\"javascript:void(0)\" class="jqgrid_inline_links" onclick="var id=\''+ it.DOCUMENTNUMBER +'\'; onSettleNegotiation(id)">create eTS</a>'

            //println it.STATUS

            if ("DA".equals(it.DOCUMENTCLASS) && !"ACCEPTED".equals(it.STATUS)) {
                settleString = ""
            }
            println it.STATUS
            String documentType = ((it.DOCUMENTTYPE == 'DOMESTIC') ? 'DM' : 'FX') + ' ' + it.DOCUMENTCLASS
            [id: it.DOCUMENTNUMBER,
                    cell: [
                            it.DOCUMENTNUMBER, 
//                            it.LASTTRANSACTION,
							documentType,
							it.CIFNAME ?: it.IMPORTERNAME,
							DateUtils.shortDateFormat(it.NEGODATE),
                            it.NEGOCURRENCY,
							NumberUtils.currencyFormat(new Double(it.OUTSTANDINGAMOUNT)),
                            NumberUtils.currencyFormat(new Double(it.NEGOAMOUNT)),
//                            '<a href=\"javascript:void(0)\" class="jqgrid_inline_links" onclick="var id=\''+ it.DOCUMENTNUMBER +'\'; onSettleNegotiation(id)">create eTS</a>',
                            (it.STATUS != 'CANCELLED' && it.STATUS != 'CLOSED') ? settleString : "",
                            it.SERVICETYPE,
                            it.DOCUMENTTYPE,
                            it.DOCUMENTCLASS
                    ]
            ]
        }
        return list
    }
	
	@Transactional(readOnly=true)
    def constructTsdNonLcInquiryGrid(display) {
        def list = display.collect {

            String documentType = ((it.DOCUMENTTYPE == 'DOMESTIC') ? 'DM' : 'FX') + ' ' + it.DOCUMENTCLASS
                [id: it.DOCUMENTNUMBER,
                        cell: [
								it.UNITCODE,
                                it.DOCUMENTNUMBER,
								documentType,
								it.STATUS,
								it.CIFNAME ?: it.IMPORTERNAME,
								DateUtils.shortDateFormat(it.MATURITYDATE),
								DateUtils.shortDateFormat(it.NEGODATE),
								DateUtils.shortDateFormat(it.SETTLEDDATE),
								NumberUtils.currencyFormat(new Double(it.SETTLEMENTAMOUNT)),
								it.NEGOCURRENCY,
								NumberUtils.currencyFormat(new Double(it.OUTSTANDINGAMOUNT)),
								NumberUtils.currencyFormat(new Double(it.NEGOAMOUNT)),
//								(it.STATUS != 'CANCELLED' && it.STATUS != 'CLOSED' && it.DOCUMENTTYPE != 'DOMESTIC') ? '<a href=\"javascript:void(0)\" class="jqgrid_inline_links" onclick="var id=\''+ it.DOCUMENTNUMBER +'\'; onCancelNegotiation(id)">Create Data Entry</a>' : '',
								(it.STATUS != 'CANCELLED' && it.STATUS != 'CLOSED') ? ('<a href=\"javascript:void(0)\" class="jqgrid_inline_links" onclick="var id=\''+ it.DOCUMENTNUMBER +'\'; onCancelNegotiation(id)">' + ((it.STATUS == 'ACKNOWLEDGED') ? 'Accept' : 'Cancel') + '</a>') : '',
								it.SERVICETYPE,
								it.DOCUMENTTYPE,
								it.DOCUMENTCLASS
                        ]
                ]
        }

        return list
    }

    // md collection for branch
    @Transactional(readOnly=true)
    def constructBranchMdCollectionInquiryGrid(display) {
        def list = display.collect {
            [id: it.TRADESERVICEID,
                    cell: [
                        it.DOCUMENTNUMBER,
                        it.CIFNAME,
                        NumberUtils.currencyFormat(it.AMOUNT),
                        "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.TRADESERVICEID+"'; createMdEts(id);\">create eTS</a>",
                        it.MODIFIEDDATE ? DateUtils.shortDateFormat(it.MODIFIEDDATE) : "",
                        NumberUtils.currencyFormat(it.TOTALMDCOLLECTED ?: 0),
                        it.SERVICETYPE,
                        it.DOCUMENTCLASS,
                        it.DOCUMENTTYPE,
                        it.DOCUMENTSUBTYPE1,
                        it.DOCUMENTSUBTYPE2
                    ]
            ]
        }

        return list
    }

    // md collection for main
    @Transactional(readOnly=true)
    def constructMainMdCollectionInquiryGrid(display) {
        def list = display.collect {
            [id: it.TRADESERVICEID,
                    cell: [
							it.CCBDBRANCHUNITCODE,
                            it.DOCUMENTNUMBER,
                            it.CIFNAME,
                            NumberUtils.currencyFormat(it.AMOUNT),
                            it.MODIFIEDDATE ? DateUtils.shortDateFormat(it.MODIFIEDDATE) : "",
                            NumberUtils.currencyFormat(it.TOTALMDCOLLECTED ?: 0),
                            it.SERVICETYPE,
                            it.DOCUMENTCLASS
                    ]
            ]
        }

        return list
    }

    // md application for branch
    @Transactional(readOnly=true)
    def constructBranchMdApplicationInquiryGrid(display) {
        def list = display.collect {
            // generate UUID
            UUID uuid = UUID.randomUUID()
            String id = String.valueOf(uuid)

            BigDecimal outstandingAmount = 0
            BigDecimal debitAmount = it.DAMT ?: 0
            BigDecimal creditAmount = it.CAMT ?: 0

            outstandingAmount = creditAmount - debitAmount

            String currency = it.CCCY ?: it.DCCY

            [id: id,
                    cell: [
                            it.SETTLEMENTACCOUNTNUMBER,
                            //DateUtils.shortDateFormat(new Date()),
							DateUtils.shortDateFormat(it.MODIFIEDDATE),
                            currency,
                            NumberUtils.currencyFormat(outstandingAmount.doubleValue()),
                            it.CIFNAME,
                            outstandingAmount > 0 ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var documentNumber='"+it.SETTLEMENTACCOUNTNUMBER+"'; var currency='"+currency+"'; var outstandingAmount='"+outstandingAmount+"'; var action='refund'; createMdApplication(documentNumber,currency,outstandingAmount,action);\">refund</a>" : "",
                            "",
                            "APPLICATION",
                            "MD"
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructMainMdApplicationInquiryGrid(display) {
        def list = display.collect {
            // generate UUID
            UUID uuid = UUID.randomUUID()
            String id = String.valueOf(uuid)

            BigDecimal outstandingAmount = 0
            BigDecimal debitAmount = it.DAMT ?: 0
            BigDecimal creditAmount = it.CAMT ?: 0

            outstandingAmount = creditAmount - debitAmount

            String currency = it.CCCY ?: it.DCCY
            
            String pnSupportFlag = "<input id=\"pnSupportFlag\" type=\"checkbox\" name=\"pnSupportFlag\" onclick=\"var id='"+id+"'; onTogglePnSupport(id)\">"
            
            if(it.MARGINALDEPOSITPNSUPPORT?.equalsIgnoreCase("YES")) {
                pnSupportFlag = "<input id=\"pnSupportFlag\" type=\"checkbox\" name=\"pnSupportFlag\" onclick=\"var id='"+id+"'; onTogglePnSupport(id)\" checked=\"checked\">"
            }

            [id: id,
                    cell: [
                            it.CCBDBRANCHUNITCODE,
                            it.SETTLEMENTACCOUNTNUMBER,
                            //DateUtils.shortDateFormat(new Date()),
							DateUtils.shortDateFormat(it.MODIFIEDDATE),
                            currency,
                            NumberUtils.currencyFormat(outstandingAmount.doubleValue()),
                            it.CIFNAME,
                            outstandingAmount > 0 ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var documentNumber='"+it.SETTLEMENTACCOUNTNUMBER+"'; var currency='"+currency+"'; var outstandingAmount='"+outstandingAmount+"'; var action='applyrefund'; createMdApplication(documentNumber,currency,outstandingAmount,action);\">apply to loan</a>" : "",
                            pnSupportFlag,
                            "APPLICATION",
                            "MD"
                    ]
            ]
        }

        return list
    }


    @Transactional(readOnly=true)
    def constructNegotiationInquiryBranch(display) {

        def list = display.collect {
            String action = ""

//            Map<String, Object> map = it.DETAILS ? JSON.parse(it.DETAILS ?: it.DETAILS) : new HashMap<String, Object>() // this is from ua loan settlement tradeservice

//            if ((map.negotiationNumber.equals(it.NEGOTIATIONNUMBER) && it.UACOUNT > 0) ||
//            !(map.containsKey("negotiationNumber"))) {
//                action = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"';var documentType='"+it.DOCUMENTTYPE+"'; onCreateUa(id,documentType);\">create eTS</a>"
//            }
            if (it.UACOUNT > 0 && it.APPROVEDSETTLEMENT == 0) {
                action = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"';var documentType='"+it.DOCUMENTTYPE+"'; onCreateUa(id,documentType);\">create eTS</a>"
            }

//            def outstandingBalance = map.containsKey("computedOutstandingBalance") ? map.computedOutstandingBalance :"0"

            [id: it.ID,
                    cell: [
                            it.DOCUMENTNUMBER,
                            it.NEGOTIATIONNUMBER,
                            it.PROCESSDATE ? DateUtils.shortDateFormat(it.PROCESSDATE) : "", //it.PROCESSDATE ? DateUtils.shortDateFormat(it.PROCESSDATE) : "",
                            it.NEGOTIATINGBANKSREFERENCENUMBER?.toUpperCase(),
                            it.NEGOTIATIONVALUEDATE ? DateUtils.shortDateFormat(it.NEGOTIATIONVALUEDATE) : "",
                            it.MATURITYDATE ? DateUtils.shortDateFormat(it.MATURITYDATE) : "",
                            it.PNNUMBER ?: it.ETSNUMBER, //"PN NUMBER",
                            NumberUtils.currencyFormat(new Double(it.NEGOTIATIONAMOUNT)),
                            //NumberUtils.currencyFormat(new Double(outstandingBalance)),
                            NumberUtils.currencyFormat(new Double(it.OUTSTANDINGBALANCE)),
							action, //(it.UACOUNT > 0 && it.SETTLEDCOUNT.compareTo(BigDecimal.ZERO) == 0) ? action : "", //(it.UACOUNT > 0 && it.SETTLEDCOUNT == 0) ? action : "",
                            it.DOCUMENTTYPE
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructNegotiationInquiryTsd(display) {

        def list = display.collect {
            String action = ""

//            Map<String, Object> map = it.DETAILS ? JSON.parse(it.DETAILS ?: it.DETAILS) : new HashMap<String, Object>() // this is from ua loan settlement tradeservice

//            if ((map.negotiationNumber.equals(it.NEGOTIATIONNUMBER) && it.UACOUNT > 0) ||
//            !(map.containsKey("negotiationNumber"))) {
//                action = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"';var documentType='"+it.DOCUMENTTYPE+"'; onCreateUa(id,documentType);\">create eTS</a>"
//            }
            if (it.UACOUNT > 0 && it.APPROVEDSETTLEMENT == 0) {
                action = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.ID+"';var documentType='"+it.DOCUMENTTYPE+"'; onCreateUa(id,documentType);\">create eTS</a>"
            }

//            def outstandingBalance = map.containsKey("computedOutstandingBalance") ? map.computedOutstandingBalance :"0"

            [id: it.ID,
                    cell: [
							it.UNITCODE,
                            it.DOCUMENTNUMBER,
                            it.NEGOTIATIONNUMBER,
                            it.PROCESSDATE ? DateUtils.shortDateFormat(it.PROCESSDATE) : "", //it.PROCESSDATE ? DateUtils.shortDateFormat(it.PROCESSDATE) : "",
                            it.NEGOTIATINGBANKSREFERENCENUMBER?.toUpperCase(),
                            it.NEGOTIATIONVALUEDATE ? DateUtils.shortDateFormat(it.NEGOTIATIONVALUEDATE) : "",
                            it.MATURITYDATE ? DateUtils.shortDateFormat(it.MATURITYDATE) : "",
                            it.PNNUMBER ?: it.ETSNUMBER, //"PN NUMBER",
                            NumberUtils.currencyFormat(new Double(it.NEGOTIATIONAMOUNT)),
                            //NumberUtils.currencyFormat(new Double(outstandingBalance)),
                            NumberUtils.currencyFormat(new Double(it.OUTSTANDINGBALANCE)),
							action, //(it.UACOUNT > 0 && it.SETTLEDCOUNT.compareTo(BigDecimal.ZERO) == 0) ? action : "", //(it.UACOUNT > 0 && it.SETTLEDCOUNT == 0) ? action : "",
                            it.DOCUMENTTYPE
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructIndemnityInquiryBranch(display) {

        def list = display.collect {

            String cancel = "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id=\'"+it.REFERENCENUMBER+"\'; var indemnityNumber=\'" + it.INDEMNITYNUMBER + "\'; onBgCancel(id, indemnityNumber);\">cancel</a>"

            if(it.INDEMNITYTYPE.equalsIgnoreCase("BE")) {
                cancel = ""
            }

            [id: it.REFERENCENUMBER,
                cell: [
                    it.REFERENCENUMBER,
                    it.CIFNAME,
                    NumberUtils.currencyFormat(it.ORIGINALAMOUNT),
                    it.INDEMNITYNUMBER,
                    it.STATUS,
                    it.SHIPMENTSEQUENCENUMBER,
                    NumberUtils.currencyFormat(it.SHIPMENTAMOUNT),
                    cancel
                ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructIndemnityInquiryTsd(display) {

        def list = display.collect {

            String cancel = "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id=\'"+it.REFERENCENUMBER+"\'; var indemnityNumber = \'" + it.INDEMNITYNUMBER + "\'; onBgCancel(id, indemnityNumber);\">cancel</a>"

            if(it.INDEMNITYTYPE.equalsIgnoreCase("BE")) {
                cancel = ""
            }
			if(it.STATUS.equalsIgnoreCase("CANCELLED")) {
				cancel = ""
            }

            [id: it.REFERENCENUMBER,
                cell: [
					it.UNITCODE,
                    it.REFERENCENUMBER,
                    it.CIFNAME,
                    NumberUtils.currencyFormat(it.ORIGINALAMOUNT),
                    it.INDEMNITYNUMBER,
                    it.STATUS,
                    it.SHIPMENTSEQUENCENUMBER,
                    NumberUtils.currencyFormat(it.SHIPMENTAMOUNT),
                    cancel
                ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructMainApInquiry(display) {

        def list = display.collect {

            Date currentDate = new Date()
            int apAging = (currentDate.getTime() - it.BOOKINGDATE.getTime()) / (1000 * 60 * 60 * 24)

            [id: it.ID,
                cell: [
					it.UNITCODE,
                    it.SETTLEMENTACCOUNTNUMBER,
                    it.CIFNAME,
                    it.BOOKINGDATE ? DateUtils.shortDateFormat(it.BOOKINGDATE) : "",
                    it.NATUREOFTRANSACTION,
                    it.CURRENCY,
                    NumberUtils.currencyFormat(it.ORIGINALAMOUNT ?: 0),
                    NumberUtils.currencyFormat(it.APOUTSTANDINGBALANCE ?: 0),
                    it.STATUS, //(it.ACTIVITYTYPE.equalsIgnoreCase("CREDIT")) ? "OUTSTANDING" : "REFUNDED",
                    apAging.toString() + " Day/s",
                    "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id=\'"+it.ID+"\'; onApplyToLoanAp(id);\">apply to loan</a>"
                ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructMainArInquiry(display) {

        def list = display.collect {

            Date currentDate = new Date()
            int arAging = (currentDate.getTime() - it.BOOKINGDATE.getTime()) / (1000 * 60 * 60 * 24)

            [id: it.ID,
                    cell: [
							it.UNITCODE,
                            it.SETTLEMENTACCOUNTNUMBER?.toUpperCase(),
                            it.CIFNAME,
                            it.BOOKINGDATE ? DateUtils.shortDateFormat(it.BOOKINGDATE) : "",
                            it.NATUREOFTRANSACTION?.toUpperCase(),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(it.ORIGINALAMOUNT ?: 0),
                            NumberUtils.currencyFormat(it.AROUTSTANDINGBALANCE ?: 0),
                            it.STATUS, //(it.ACTIVITYTYPE.equalsIgnoreCase("CREDIT")) ? "OUTSTANDING" : "REFUNDED",
                            arAging.toString() + " Day/s",
                            ""
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructBranchApInquiry(display) {

        def list = display.collect {

            Date currentDate = new Date()
            int apAging = (currentDate.getTime() - it.BOOKINGDATE.getTime()) / (1000 * 60 * 60 * 24)

            [id: it.ID,
                    cell: [
							it.UNITCODE,
                            it.SETTLEMENTACCOUNTNUMBER,
                            it.CIFNAME,
                            it.BOOKINGDATE ? DateUtils.shortDateFormat(it.BOOKINGDATE) : "",
                            it.NATUREOFTRANSACTION,
                            it.CURRENCY,
                            NumberUtils.currencyFormat(it.ORIGINALAMOUNT ?: 0),
                            NumberUtils.currencyFormat(it.APOUTSTANDINGBALANCE ?: 0),
                            it.STATUS, //(it.ACTIVITYTYPE.equalsIgnoreCase("CREDIT")) ? "OUTSTANDING" : "REFUNDED",
                            apAging.toString() + " Day/s",
							it.STATUS != 'REFUNDED' ? "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id=\'"+it.ID+"\'; onRefundAp(id);\">refund</a>" : '' //"refund"
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructBranchArInquiry(display) {

        def list = display.collect {

            Date currentDate = new Date()
            int arAging = (currentDate.getTime() - it.BOOKINGDATE.getTime()) / (1000 * 60 * 60 * 24)

            [id: it.ID,
                    cell: [
							it.UNITCODE,
                            it.SETTLEMENTACCOUNTNUMBER?.toUpperCase(),
                            it.CIFNAME,
                            it.BOOKINGDATE ? DateUtils.shortDateFormat(it.BOOKINGDATE) : "",
                            it.NATUREOFTRANSACTION?.toUpperCase(),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(it.ORIGINALAMOUNT ?: 0),
                            NumberUtils.currencyFormat(it.AROUTSTANDINGBALANCE ?: 0),
                            it.STATUS, //(it.ACTIVITYTYPE.equalsIgnoreCase("CREDIT")) ? "OUTSTANDING" : "REFUNDED",
                            arAging.toString() + " Day/s",
                            it.STATUS == 'OUTSTANDING' ? "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id=\'"+it.ID+"\'; onSettleAr(id);\">create eTS</a>" : ""
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly=true)
    def constructDataEntryInquiryGrid(display) {
        def list = display.collect {
//			Map<String, Object> map = JSON.parse(it.SIDETAILS ?: it.TSDETAILS)

            String transactionName = WordUtils.capitalizeFully(it.SERVICETYPE?.replaceAll("_", " "))

            if(it.SERVICETYPE.equals("NEGOTIATION_DISCREPANCY")) {
                transactionName = WordUtils.capitalizeFully(it.SERVICETYPE.split("_")[0])
                transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE.split("_")[1])
            } else if(it.SERVICETYPE.equals("UA_LOAN_MATURITY_ADJUSTMENT")) {
                transactionName = it.SERVICETYPE.split("_")[0]
                transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE.split("_")[1])
                transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE.split("_")[2])
                transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE.split("_")[3])
            } else if(it.SERVICETYPE.equals("UA_LOAN_SETTLEMENT")) {
                transactionName = it.SERVICETYPE.split("_")[0]
                transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE.split("_")[1])
                transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE.split("_")[2])            
            } else if(it.SERVICETYPE.equals("ISSUANCE")) {
                transactionName = WordUtils.capitalizeFully(it.DOCUMENTCLASS)
                transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE)
            } else if(it.SERVICETYPE.equals("CANCELLATION")) {
                if(it.DOCUMENTCLASS.equals("LC")) {
                    transactionName = WordUtils.capitalizeFully(it.SERVICETYPE)
                } else if(it.DOCUMENTCLASS.equals("INDEMNITY")) {
                    transactionName = WordUtils.capitalizeFully(it.DOCUMENTCLASS)
                    transactionName += " " + WordUtils.capitalizeFully(it.SERVICETYPE)
                }
            } else if(it.SERVICETYPE.equals("NEGOTIATION_ACKNOWLEDGEMENT")){
				transactionName = "Negotiation Acknowledged" //For DA
            } else if(it.SERVICETYPE.equals("NEGOTIATION_ACCEPTANCE")){
        		transactionName = "Negotiation Accepted" //For DA
			} else if(it.SERVICETYPE?.equalsIgnoreCase("CREATE")){
				transactionName = "Outgoing MT"
			}
			if(it.DOCUMENTCLASS in ['DR','DP','OA'] && it.SERVICETYPE.equalsIgnoreCase("NEGOTIATION")){
				transactionName = "Negotiation Acknowledged"
			}
			
            [id: it.TRADESERVICEID,
                    cell: [
						it.UNITCODE,
                        it.TRADEPRODUCTNUMBER?.toUpperCase(),
                        it.SERVICEINSTRUCTIONID,
                        it.CIFNAME,
                        transactionName?.replaceAll("_", " "),
                        it.STATUS,
                        it.LASTUSER,
                        DateUtils.dateTimeFormat(it.MODIFIEDDATE),
						"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.TRADESERVICEID+"'; onViewDataEntryClick(id);\">View</a>",
                        it.SERVICETYPE,
                        it.DOCUMENTTYPE,
                        it.DOCUMENTCLASS,
                        it.DOCUMENTSUBTYPE1,
                        it.DOCUMENTSUBTYPE2
                    ]
            ]
        }

        return list
    }

    def constructSettlementActualCorres(display){
        display.collect {
            [id: it.DOCUMENTNUMBER,
                    cell: [
                            it.DOCUMENTNUMBER,
                            it.CIFNAME,
                            DateUtils.shortDateFormat(new Date(it.LASTPAIDDATE)),
                            NumberUtils.currencyFormat(it.OUTSTANDINGBALANCE),
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.DOCUMENTNUMBER+"'; createCorresEts(id);\">create eTS</a>",
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\">view/edit</a>",
                            "Settlement"
                    ]
            ]
        }
    }

    // cdt payments
    Map<String, Object> findAllCdtPayments(maxRows, rowOffset, currentPage, params) {
        def param = [:]

        if (params.paymentReferenceNumber) {
            param << [ref: params.paymentReferenceNumber]
        }

        if (params.iedNumber) {
            param << [ied: params.iedNumber]
        }

        if (params.importerName) {
            param << [importer: params.importerName]
        }

        if (params.requestType) {
            param << [request: params.requestType]
        }

        if (params.status) {
            param << [status: params.status]
        }

        if (params.transactionDateFrom) {
            param << [txfrom: params.transactionDateFrom]
        }

        if (params.transactionDateTo) {
            param << [txto: params.transactionDateTo]
        }

        if (params.unitCode) {
            param << [unitcode: params.unitCode]
        }
		
		if (params.aabRefCode) {
			param << [aabRefCode: params.aabRefCode]
		}
		
        println "param " + param
        def queryResult = coreAPIService.dummySendQuery(param, "search", "cdt/payment/").details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
	Map<String, Object> findAllCdtEmailTable(maxRows, rowOffset, currentPage, params) {
		def param = [:]
		if (params.iedieirdNumber) {
			param << [iedieirdNumber: params.iedieirdNumber]
		}

		if (params.emailAddress) {
			param << [emailAddress: params.emailAddress]
		}

		if (params.emailStatus) {
			param << [emailStatus: params.emailStatus]
		}

		if (params.sentTime) {
			param << [sentTime: params.sentTime]
		}
		def queryResult = coreAPIService.dummySendQuery(param, "searchEmailTable", "cdt/payment/").details

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

    Map<String, Object> findAllCdtRemittance(maxRows, rowOffset, currentPage, params) {
        println "findAllCdtRemittance"
        def param = [:]

        if (params.reportType) {
            param << [reportType: params.reportType]
        }

        if (params.dateOfRemitanceFrom) {
            param << [dateOfRemitanceFrom: params.dateOfRemitanceFrom]
        }

        if (params.dateOfRemitanceTo) {
            param << [dateOfRemitanceTo: params.dateOfRemitanceTo]
        }

        if (params.collectionPeriodFrom) {
            param << [collectionPeriodFrom: params.collectionPeriodFrom]
        }

        if (params.collectionPeriodTo) {
            param << [collectionPeriodTo: params.collectionPeriodTo]
        }
        println "params:"+param

        def queryResult = coreAPIService.dummySendQuery(param, "search", "cdt/remittance/").details
        println 'queryResult ' + queryResult
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()?:0) ? (currentPage * maxRows) : queryResult?.size()?:0
        return [display: queryResult?.subList(rowOffset, toIndex)?:[], totalRows: queryResult?.size()?:0]
    }

    def constructCdtPaymentInquiryGrid(display, processingUnitCode, userRole) {
        display.collect {

            def refundLink = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; var processingUnitCode='"+processingUnitCode+"'; refundCdtPayment(id,processingUnitCode);\">Refund</a>"
			
			//no link for transaction which cannot be refunded
            if (((((it.status.equals("SENTTOBOC") && it.status.equals("REMITTED")) || !it.status.equals("FORREFUND"))  && !processingUnitCode.equals("909")) && !((it.status.equals("SENTTOBOC") && it.status.equals("REMITTED")) && processingUnitCode.equals("909"))) ||
					 ((!it.status.equals("SENTTOBOC") && !it.status.equals("REMITTED")) && processingUnitCode.equals("909")) || userRole.equals("TSDO") || userRole.equals("BRO")) {
                refundLink = ""
            } 
			
			//view link for approved refund transaction
			if((it.status.equals("FORREFUND") && processingUnitCode.equals("909")) || !it.dateRefunded.equals(null) || it.status.equals("REFUNDED")){
				refundLink = "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; viewApprovedCdtRefund(id);\">View</a>"
            }

            println it
            [id: it.iedieirdNumber,
                    cell: [
                            it.paymentReferenceNumber,
                            it.iedieirdNumber,
                            it.agentBankCode,
                            it.clientName,
                            NumberUtils.currencyFormat(it.amount),
                            it.paymentRequestType,
                            it.status?.equals("FORREFUND") ? "FOR REFUND" : it.status,
//                            it.dateUploaded,
                            it.pchcDateReceived,
							it.datePaid,
							it.dateRefunded ?: "",
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; viewCdtPayment(id);\">view</a>",
//                            it.status?.equals("FOR_REFUND") ? "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; refundCdtPayment(id);\">refund</a>" : "",
                            refundLink
                    ]
            ]
        }
    }
	def constructCdtEmailTableGrid(display) {
		display.collect {

			println it
			[id: it.id,
					cell: [
							it.iedieirdNumber,
							it.emailAddress,
							it.emailStatus,
							it.sentTime
					]
			]
		}
	}
    def constructCdtRemittanceInquiryGrid(display) {
        display.collect {
            [id: it.id,
                    cell: [
                            it.remittanceDate ? DateUtils.shortDateFormat(DateUtils.parse(it.remittanceDate)) : "",
                            it.paymentRequestType,
                            it.totalRemitted ? NumberUtils.currencyFormat(it.totalRemitted) : "",
                            it.collectionFrom ? DateUtils.shortDateFormat(DateUtils.parse(it.collectionFrom)) : "",
                            it.collectionTo ? DateUtils.shortDateFormat(DateUtils.parse(it.collectionTo)) : ""
                    ]
            ]
        }
    }

    // cdt clients
    Map<String, Object> findAllCdtClients(maxRows, rowOffset, currentPage, params) {
        def param = [importername: params.importerName]

        def queryResult = coreAPIService.dummySendQuery(param, "search", "cdt/importer/").details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    Map<String, Object> findAllCdtClients2(maxRows, rowOffset, currentPage, params, unitCode) {
        def param = [importername: params.importerName, aabRefCode: params.aabRefCode, importerTin: params.importerTin, customsClientNumber: params.customsClientNumber, unitCode: unitCode]
        println param

        def queryResult = coreAPIService.dummySendQuery(param, "search", "cdt/importer/").details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def constructCdtClientInquiryGrid(display) {
        display.collect {
            [id: it.agentBankCode,
                    cell: [
                            it.agentBankCode,
                            it.ccn,
                            it.tin,
                            it.clientName,
                            it.registrationDate,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.agentBankCode+"'; viewCdtClient(id);\">view</a>"
                    ]
            ]
        }
    }

    // cdt transactions
    Map<String, Object> findTodaysCdtTransactions(maxRows, rowOffset, currentPage, params) {
        def param = [unitcode: params.unitcode, uploadDate: params.uploadDate]

//        param << [uploadDate: new Date()]

        def queryResult = coreAPIService.dummySendQuery(param, "cdttodays", "cdt/payment/").details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    // cdt payment history
    Map<String, Object> findTodaysCdtHistoryTransactions(maxRows, rowOffset, currentPage, params) {
        def confDate = params.confDate
		if(confDate == null)
		confDate = ""
		def param = [unitCode: params.unitCode, confDate: confDate]

				
        def queryResult = coreAPIService.dummySendQuery(param, "history", "cdt/payment/").details
		
		
		BigDecimal cdtTotal = BigDecimal.ZERO
		BigDecimal totalPaid = BigDecimal.ZERO

//		ArrayList<String> tmpTrans = new ArrayList<String>();

		queryResult.each() { transaction ->
//			if(transaction?.confDate){
//				tmpTrans.add(transaction);
//			}
			if (transaction?.status?.toString().equalsIgnoreCase("PAID") || transaction?.status?.toString().equalsIgnoreCase("SENTTOBOC")) {
//            if (transaction?.status?.toString().equalsIgnoreCase("PAID")) {
				//cdtTotal = transaction.amount ? cdtTotal?.add(new BigDecimal(transaction.amount?.toString()?.replaceAll(",", ""))) : BigDecimal.ZERO
//				cdtTotal += (transaction.amount ? new BigDecimal(transaction.amount?.toString()?.replaceAll(",", "")) : BigDecimal.ZERO)
				totalPaid += (transaction.amount ? new BigDecimal(transaction.amount?.toString()?.replaceAll(",", "")) : BigDecimal.ZERO)
				println '* ' + transaction?.amount
				
				if(transaction?.confDate){
					
//					tmpTrans << transaction
					cdtTotal += (transaction.amount ? new BigDecimal(transaction.amount?.toString()?.replaceAll(",", "")) : BigDecimal.ZERO)
					
				}
				
				
			}
			
			
		}
		
		
//        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : tmpTrans?.size()
//        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size(), cdtTotal: cdtTotal, totalPaid: totalPaid? totalPaid : 0.00]
		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size(), cdtTotal: cdtTotal, totalPaid: totalPaid? totalPaid : 0.00]
		
    }

    def constructCdtPaymentHistoryGrid(display) {
        println "yehey"
        display.collect {
            [id: it.ccn,
                    cell: [
                            it.iedieirdNumber,
                            it.agentBankCode,
                            it.clientName,
                            NumberUtils.currencyFormat(it.amount),
                            NumberUtils.currencyFormat(it.amount),
                            it.paymentRequestType,
//	                            '',
                            it.e2mStatus,
                            it.status,
//                            it.dateUploaded,
                            it.pchcDateReceived,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; viewCdtPayment(id);\">view</a>"
                    ]
            ]
        }
    }

    def constructCdtPaymentGrid(display) {
        display.collect {
            [id: it.ccn,
                    cell: [
                            it.iedieirdNumber,
                            it.agentBankCode,
                            it.clientName,
                            NumberUtils.currencyFormat(it.amount),
                            it.paymentRequestType,
                            it.e2mStatus,
//                            it.dateUploaded,
                            it.pchcDateReceived,
                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; viewCdtPayment(id);\">view</a>"
                    ]
            ]
        }
    }

    def constructCdtTransactionsUploadGrid(display, headerTitle) {
	
		if(headerTitle && !headerTitle.contains('Upload Transactions')) {
            println 'haha :)'
            display.collect {
	            [id: it.ccn,
	                    cell: [
	                            it.iedieirdNumber,
	                            it.agentBankCode,
	                            it.clientName,
                                NumberUtils.currencyFormat(it.amount),
	                            NumberUtils.currencyFormat(it.amount),
	                            it.paymentRequestType,
//	                            '',
	                            it.e2mStatus,
								it.status,
	                            "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; viewCdtPayment(id);\">view</a>"
	                    ]
	            ]
	        }
		} else {
            println 'hehe'
			display.collect {
				[id: it.ccn,
						cell: [
								it.iedieirdNumber,
								it.agentBankCode,
								it.clientName,
								NumberUtils.currencyFormat(it.amount),
								it.paymentRequestType,
								'',
								it.e2mStatus,
								"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.iedieirdNumber+"'; viewCdtPayment(id);\">view</a>"
						]
				]
			}
		}
    }

    def constructRefundInquiryGrid(display) {
        display.collect {
            [id: it.DOCUMENTNUMBER,
                cell: [
                        it.DOCUMENTNUMBER,
                        it.CIFNAME,
                        NumberUtils.currencyFormat(it.OUTSTANDINGBALANCE),
                        "<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='"+it.DOCUMENTNUMBER+"'; refundPayments(id);\">refund</a>"
                ]
            ]
        }
    }

    def constructOutgoingMt(display) {
        display.collect {
            [id: it.ID,
                    cell: [
                            it.TRADEPRODUCTNUMBER,
                            it.MTTYPE,
                            DateUtils.shortDateFormat(it.MODIFIEDDATE),
                            DateUtils.timeFormat(it.MODIFIEDDATE),
							it.MTSTATUS
                    ]
            ]
        }
    }

    def searchExportBills(paramMap, maxRows, currentPage, rowOffset) {
        def queryResult = coreAPIService.dummySendQuery(paramMap, "details", "exportbills/search/")?.details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def searchRebates(paramMap, maxRows, currentPage, rowOffset) {
        def queryResult = coreAPIService.dummySendQuery(paramMap, "details", "rebate/search/")?.details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def searchImportProducts(params, maxRows, currentPage, rowOffset) {
        def paramMap = [documentNumber: params.documentNumber ?: "", cifName: params.cifName ?: "", cifNumber: params.cifNumber ?: "", unitcode: params.unitcode ?: ""]

        def queryResult = coreAPIService.dummySendQuery(paramMap, "importProducts/search", "product/")?.details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def searchAllImports(params, maxRows, currentPage, rowOffset) {
        def paramMap = [documentNumber: params.documentNumber ?: "", cifName: params.cifName ?: "", cifNumber: params.cifNumber ?: "", unitCode: params.unitCode ?: "", unitcode: params.unitcode ?: ""]

        def queryResult = coreAPIService.dummySendQuery(paramMap, "allimports/search", "product/")?.details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

    def searchAllExports(params, maxRows, currentPage, rowOffset) {
        def paramMap = [documentNumber: params.documentNumber ?: "",
                cifName: params.cifName ?: "",
                importersName: params.importerName ?: "",
                exportersName: params.exporterName ?: "",
                transaction: params.transaction ?: "",
				unitCode: params.unitCode ?: "",
				unitcode: params.unitcode ?: ""]

        def queryResult = coreAPIService.dummySendQuery(paramMap, "allexports/search", "product/")?.details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
}