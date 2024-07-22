package com.ucpb.tfsweb.main.lc.routing

import org.springframework.transaction.annotation.Transactional
import grails.converters.JSON
import net.ipc.utils.NumberUtils
import com.incuventure.cqrs.query.QueryItem
import net.ipc.utils.DateUtils

/**
 */
class RoutingInformationService {

	def ratesService
	def queryService
	def routingInformationFinder = com.ucpb.tfs.application.query.routing.IRoutingInformationFinder.class
	def queryBusService

	@Transactional(readOnly = true)
	def Map<String, Object> findAllRoutesByRoutingInformationId(maxRows, rowOffset, currentPage, routingInformationIds) {
		Map<String, Object> param = [routingInformationIds: routingInformationIds ?: ""]
		//printlnroutingInformationId
		List<Map<String, Object>> queryResult = queryService.executeQuery(routingInformationFinder, "findRoutesByRoutingInformationId", param)
		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	@Transactional(readOnly = true)
	def buildRoutingInfoGrid(display) {

		def list = display.collect {
//            Map<String, Object> map = JSON.parse(it.DETAILS)
			[id: it.ID,
					cell: [
							it.SENDERNAME ?: it.SENDERACTIVEDIRECTORYID,
							it.DATESENT ? DateUtils.dateTimeFormat(it.DATESENT) : "",
							it.STATUS.equals("PRE_APPROVED") ? "PRE APPROVED" : it.STATUS.equals("POST_APPROVED") ? "POST APPROVED" : it.STATUS,//it.STATUS
							it.RECEIVERNAME ?: it.RECEIVERACTIVEDIRECTORYID
					]
			]
		}
		
		return list
	}

	@Transactional(readOnly = true)
	def getProductServiceAttributes(String documentClass, String documentType, String documentSubType1, String documentSubType2, String serviceType) {
		println"documentClass >> " + documentClass
		println"documentType >> " + documentType
		println"documentSubType1 >> " + documentSubType1
		println"documentSubType2 >> " + documentSubType2
		println"serviceType >> " + serviceType

		if (documentType == null) {
			documentType = ""
		}

		// makes parameters an empty String if null since QueryItem only accepts String as parameter
		if (documentSubType1 == null) {
			documentSubType1 = ""
		}

		if (documentSubType2 == null) {
			documentSubType2 = ""
		}

		if (serviceType.contains("_REVERSAL")) {
//            println "reversal"
			serviceType = serviceType.replace("_REVERSAL", "")
		}

		String methodName = "getProductServiceAttributes"

		try {
			QueryItem qi = new QueryItem("data", routingInformationFinder, methodName, documentClass, documentType, documentSubType1, documentSubType2, serviceType)
			List<QueryItem> qis = new ArrayList<QueryItem>()
			qis.add(qi)

			HashMap<String, Object> returnValues = queryBusService.dispatch(qis)

			return returnValues.data[0]


		} catch (NoSuchMethodException nsme) {

			////println"invoking getProductServiceAttributes failed"
			nsme.printStackTrace()

			return "ERROR"
		}
	}


	@Transactional(readOnly = true)
	def getDocumentServiceRoute(String documentClass, String documentType, String documentSubType1, String documentSubType2, String referenceType, String serviceType, String username, String currentRole, String unitCode, documentData) {


	}

	def getNextBranchApprover(String documentClass, String documentType, String documentSubType1, String documentSubType2, String referenceType, String serviceType, String username, String currentRole, String unitCode, documentData) {
//		Map dataItems = findNextBranchRouteTarget(username)
		Map dataItems = findNextRouteTarget('BRO', unitCode, documentData.approvers)
		
//		serviceType = serviceType.toUpperCase()
//		if (serviceType.contains("_REVERSAL")) {
//			serviceType = serviceType.replace("_REVERSAL","")
//		}
//		serviceType = evaluateParameters(documentClass, serviceType)
		
		List<Map<String, Object>> nextRoute = []
				
		if (dataItems != null) {
			nextRoute = dataItems["data"]
		}
		
//		def statusLevel = ['PENDING':1,'RETURNED':1,'PREPARED':2,'CHECKED':3]
//		def productServiceAttributes = getProductServiceAttributes(documentClass, documentType, documentSubType1, documentSubType2, serviceType)
		
		def nextPerson = []

		// we go through the list adding only users that do not have the same
		// username as the current user (we cannot route something to ourselves)
		nextRoute.each() {
			
			if (!it.ID.equalsIgnoreCase(username)) {
//				if ((documentData?.settlementMode && !(documentData?.settlementMode in ['TR','DTR'])) || statusLevel[documentData.status] >= productServiceAttributes?.REQBRANCHAPPROVAL || it.PRIORITY == 1 ) {
						nextPerson.add(it)
//				}
			}
		}

		return nextPerson
	}

	def getNextMainApprover(String documentClass, String documentType, String documentSubType1, String documentSubType2, String referenceType, String serviceType, String username, String currentRole, String unitCode, documentData, userLevel) {

		List<Map<String, Object>> nextRoute = findNextRouteTarget('TSDO', unitCode, documentData.approvers)["data"]

		def previousApprovers = documentData.approvers?.split(",") ?: []
		////println"previousApprovers "+previousApprovers
		// evaluates servicetype and returns appropriate servicetype as per enum
		serviceType = evaluateParameters(documentClass, serviceType)

		def productServiceAttributes = getProductServiceAttributes(documentClass, documentType, documentSubType1, documentSubType2, serviceType?.toUpperCase())

		def approverLevel = documentData.approvers ? documentData.approvers.split(",").size() + 1 : 1

		BigDecimal amount = 0
		String currency = documentData.currency
//        documentData.each {
//            ////println"documentData " + it
//        }

		if (serviceType.equalsIgnoreCase("OPENING")) {
			amount = new BigDecimal(documentData.amount)
		} else if (serviceType.equalsIgnoreCase("AMENDMENT")) {
			amount = new BigDecimal(documentData?.amountTo ?: documentData?.outstandingBalance ?: documentData?.amountFrom ?: "0")

			if (documentData.amountSwitch?.equals("off")) {
				amount = new BigDecimal(documentData.outstandingBalance2 ?: documentData.outstandingBalance ?: documentData.amountFrom)
			}
		} else if (serviceType.equalsIgnoreCase("NEGOTIATION") && documentClass.equalsIgnoreCase("LC")) {
			amount = new BigDecimal(documentData.negotiationAmount)
			currency = documentData.negotiationCurrency
		} else if (serviceType.equalsIgnoreCase("ISSUANCE")) {
			amount = new BigDecimal(documentData.shipmentAmount)
			currency = documentData.shipmentCurrency
		} else if (serviceType.contains("ADVISING")) {
			amount = new BigDecimal(documentData.lcAmount ? documentData.lcAmount?.replaceAll(",","") : 0)
			currency = documentData.lcCurrency
		} else {
			// does not matter for everything else
			amount = 0
		}

//        amount = 0
		//amount = //ratesService.getPesoAmount(amount, currency)

		amount = ratesService.convertToPeso(documentData.tradeServiceId, currency, amount.toString())

		//println"amount to check is : " + amount + " transaction is financial: " + productServiceAttributes?.FINANCIAL
		//println"approver level is: " + approverLevel
		//println"route to post approver? " + productServiceAttributes?.POSTAPPROVALREQUIREMENT
		//println"nextRoute >> " + nextRoute
		//println"required approval level >> " + productServiceAttributes?.REQBRANCHAPPROVAL
		//println"previousApprovers : " + previousApprovers
		//println"approverLevel : " + approverLevel
		nextRoute.each {
			if (it.ID.equals(username)) {
				////printlnit.ID + " " + it.LIMIT
			}
		}


		def nextPerson = []

		// we go through the list adding only users that do not have the same
		// username as the current user (we cannot route something to ourselves)
		nextRoute.each() {

			// exclude the current user, those with no level and prior approvers
			if (!it.ID.equalsIgnoreCase(username) && (it.LEVEL != null) && (!previousApprovers.contains(it.ID))) {

				////printlnit
				// we only care about financial-ness of a transaction above maker
				if (approverLevel > 1) {
					// if this is a financial transaction
					if (productServiceAttributes && productServiceAttributes["FINANCIAL"] == 1) {
						// we can only consider this user if the amount in question is less than or equal to the user's
						// limit (unless we're at level 1 in which case we're still the checker and we don't mind)
						if (amount.compareTo(it.LIMIT) < 0 || amount.compareTo(it.LIMIT) == 0) {
							if (it.LEVEL > userLevel) {
								nextPerson.add(it)
							}
						}
					}
					else {
						if (it.LEVEL > userLevel) {
							////println"y"
							nextPerson.add(it)
						}
					}
				} else {
					// can only route to somebody higher
					if (it.LEVEL > userLevel) {
						// removed esamonte as route person from maker
//                        println documentData.status
						if (documentData.status == null || "PENDING".equals(documentData.status)) {
							if (it.LEVEL != 50) {
								nextPerson.add(it)
							}
						} else {
							nextPerson.add(it)
						}
					}
				}
			}

		}

		return nextPerson
	}

	def getNextMainApproverTsdInitiated(String documentClass, String documentType, String documentSubType1, String documentSubType2, String referenceType, String serviceType, String username, String currentRole, String unitCode, documentData, userLevel) {

		List<Map<String, Object>> nextRoute = findNextRouteTarget('TSDO', unitCode, documentData?.approvers)["data"]

		def nextPerson = []

		if (documentData?.approvers) {
			def previousApprovers = documentData.approvers.split(",")

			serviceType = evaluateParameters(documentClass, serviceType)

			def productServiceAttributes = getProductServiceAttributes(documentClass, documentType, documentSubType1, documentSubType2, serviceType?.toUpperCase())

			def approverLevel = ((documentData.approvers?.isEmpty())) ? 1 : documentData.approvers.split(",").size() + 1

			BigDecimal amount = 0

			documentData.each {
				////println"documentData " + it
			}

			if (serviceType.equalsIgnoreCase("OPENING")) {
				amount = new BigDecimal(documentData.amount)
			} else if (serviceType.equalsIgnoreCase("AMENDMENT")) {
				amount = new BigDecimal(documentData.amountTo)
			} else if (serviceType.equalsIgnoreCase("NEGOTIATION")) {
				amount = new BigDecimal(documentData.negotiationAmount)
			} else {
				// does not matter for everything else
				amount = 0
			}

			////println"amount to check is : " + amount + " transaction is financial: " + productServiceAttributes.FINANCIAL
			////println"approver level is: " + approverLevel

			// we go through the list adding only users that do not have the same
			// username as the current user (we cannot route something to ourselves)
			nextRoute.each() {

				// exclude the current user, those with no level and prior approvers
				if (!it.ID.equals(username) && (it.LEVEL != null) && (!previousApprovers.contains(it.ID))) {

					////printlnit

					// we only care about financial-ness of a transaction above maker
					if (approverLevel > 1) {

						// if this is a financial transaction
						if (productServiceAttributes != null && productServiceAttributes["FINANCIAL"] == 1) {
							// we can only consider this user if the amount in question is less than or equal to the user's
							// limit (unless we're at level 1 in which case we're still the checker and we don't mind)
							if (amount <= it.LIMIT) {
								////println"x"
								if (it.LEVEL > userLevel) {
									nextPerson.add(it)
								}
							}
						}
						else {
							if (it.LEVEL > userLevel) {
								////println"y"
								nextPerson.add(it)
							}
						}
					} else {
						// can only route to somebody higher
						if (it.LEVEL > userLevel) {
							////println"z"
							nextPerson.add(it)
						}
					}
				}
			}
		} else {
			// we go through the list adding only users that do not have the same
			// username as the current user (we cannot route something to ourselves)
			nextRoute.each() {
				if (!it.ID.equals(username)) {
					nextPerson.add(it)
				}
			}
		}

		////println"nextPerson"
		return nextPerson
	}

	def getAllTsdMakers() {
		def param = [:]
		return queryService.executeQuery(routingInformationFinder, "getAllTsdMakers", param);
	}

	def getBranchApprovalMode(documentClass, documentType, documentSubType1, documentSubType2, serviceType, previousApprovers) {


		serviceType = serviceType.toUpperCase()
//        println "hello " + serviceType
		if (serviceType.contains("_REVERSAL")) {
//            println "contains reversal"
			serviceType = serviceType.replace("_REVERSAL","")
		}

		def productServiceAttributes = getProductServiceAttributes(documentClass, documentType, documentSubType1, documentSubType2, serviceType)
		println "productServiceAttributes > " + productServiceAttributes + " " + previousApprovers
		// determine approval mode
		if ((previousApprovers != null) && (productServiceAttributes != null)) {
			//println"previousApprovers >> " + previousApprovers
			def approvers = previousApprovers.isEmpty() ? 1 : (previousApprovers.split(",").size() + 1)
			println"approvers >> " + approvers
			println"productServiceAttributes >> " + productServiceAttributes.REQBRANCHAPPROVAL

			if (approvers == productServiceAttributes.REQBRANCHAPPROVAL) {
				println"we will approve"
				return [approvalMode: 'APPROVE']
			} else {
				println"we will check"
				return [approvalMode: 'CHECK']
			}
		}

		return [approvalMode: 'NA']
	}

	def getMainApprovalMode(documentClass, documentType, documentSubType1, documentSubType2, serviceType, previousApprovers) {
		////println"this is: " + previousApprovers
		def productServiceAttributes = getProductServiceAttributes(documentClass, documentType, documentSubType1, documentSubType2, serviceType?.toUpperCase())

		// determine approval mode
		
		if (previousApprovers != null) {
			////printlnproductServiceAttributes
			def approvers = previousApprovers ? (previousApprovers.split(",").size() + 1) : 1
			if (approvers > 1) {
				////println"we will approve"
				return [approvalMode: 'APPROVE']
			} else {
				////println"we will check"
				return [approvalMode: 'CHECK']
			}
		}

		return [approvalMode: 'NA']
	}
	
	
	@Transactional(readOnly = true)
	def findNextBranchRouteTarget(username) {
		
		String methodName = "findNextBranchRouteTarget"
				
		try {
			QueryItem qi = new QueryItem("data", routingInformationFinder, methodName, username)
			List<QueryItem> qis = new ArrayList<QueryItem>()
			qis.add(qi)
			
			HashMap<String, Object> returnValues = queryBusService.dispatch(qis)
			
			return returnValues
					
					
		} catch (NoSuchMethodException nsme) {
			
			////println"invoking remote authenticate failed"
			nsme.printStackTrace()
			
			return "ERROR"
		}
		catch (Exception e) {
			////println"invoke exception **** " + e.message
			e.printStackTrace()
		}
	}

	@Transactional(readOnly = true)
	def findNextRouteTarget(roleId, unitCode, previousApprovers) {

		String methodName = "findNextRouteTarget"

		String[] approvers

		if (previousApprovers != null && !previousApprovers.isEmpty()) {
			approvers = previousApprovers.split(",")
		}

		try {
			QueryItem qi = new QueryItem("data", routingInformationFinder, methodName, roleId, unitCode)
			List<QueryItem> qis = new ArrayList<QueryItem>()
			qis.add(qi)

			HashMap<String, Object> returnValues = queryBusService.dispatch(qis)

			return returnValues


		} catch (NoSuchMethodException nsme) {

			////println"invoking remote authenticate failed"
			nsme.printStackTrace()

			return "ERROR"
		}
		catch (Exception e) {
			////println"invoke exception **** " + e.message
			e.printStackTrace()
		}
	}

	// to pass appropriate service type based on REFPRODUCTSERVICE
	String evaluateParameters(documentClass, serviceType) {
		switch (documentClass.toUpperCase()) {
			case "LC":
				if (serviceType.equalsIgnoreCase("NEGOTIATION")) {
					return "NEGOTIATION"
				} else if (serviceType.equalsIgnoreCase("ADJUSTMENT")) {
					return "ADJUSTMENT"
				} else if (serviceType.equalsIgnoreCase("AMENDMENT")) {
					return "AMENDMENT"
				} else if (serviceType.equalsIgnoreCase("CANCELLATION")) {
					return "CANCELLATION"
				} else if (serviceType.equalsIgnoreCase("UA LOAN MATURITY ADJUSTMENT")) {
					return "UA_LOAN_MATURITY_ADJUSTMENT"
				} else if (serviceType.equalsIgnoreCase("UA LOAN SETTLEMENT")) {
					return "UA_LOAN_SETTLEMENT"
				} else if (serviceType.equalsIgnoreCase("NEGOTIATION DISCREPANCY")) {
					return "NEGOTIATION_DISCREPANCY"
				} else {
					return serviceType
				}
			case "INDEMNITY":
				if (serviceType.equalsIgnoreCase("ISSUANCE")) {
					return "ISSUANCE"
				} else if (serviceType.equalsIgnoreCase("CANCELLATION")) {
					return "CANCELLATION"
				}
			case "AP":
				if (serviceType.equalsIgnoreCase("SETUP")) {
					return "SETUP"
				} else if (serviceType.equalsIgnoreCase("APPLY")) {
					return "APPLY"
				} else if (serviceType.equalsIgnoreCase("REFUND")) {
					return "REFUND"
				} else {
					return serviceType
				}
			case "AR":
				if (serviceType.equalsIgnoreCase("SETTLE")) {
					return "SETTLE"
				} else {
					return serviceType
				}

			default:
				return serviceType
		}
	}

	// get product reference to be used for assume posting authority
	def getProductReferences(String documentClass, String documentType, String documentSubType1, String documentSubType2, String serviceType, documentData, unitCode, username) {
		def productServiceAttributes = getProductServiceAttributes(documentClass, documentType, documentSubType1, documentSubType2, serviceType)

		BigDecimal amount = 0
		String currency = documentData.currency

		if (serviceType.equalsIgnoreCase("OPENING") || serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) {
			amount = new BigDecimal(documentData.amount)
		} else if (serviceType.equalsIgnoreCase("AMENDMENT")) {
			//amount = new BigDecimal(documentData.amountTo ?: documentData.outstandingBalance)
			amount = new BigDecimal(documentData?.amountTo ?: documentData?.outstandingBalance ?: documentData?.amountFrom ?: "0")

			if (documentData.amountSwitch?.equals("off")) {
				amount = new BigDecimal(documentData.outstandingBalance2 ?: documentData.outstandingBalance ?: documentData.amountFrom)
			}
		} else if (serviceType.equalsIgnoreCase("NEGOTIATION")) {
			if (documentClass?.equals("LC")) {
				amount = new BigDecimal(documentData.negotiationAmount)
				currency = documentData.negotiationCurrency
			} else {
				amount = new BigDecimal(documentData.amount ?: 0)
				currency = documentData.currency
			}
		} else if ((serviceType?.equalsIgnoreCase("SETTLEMENT")) || (serviceType?.equalsIgnoreCase("SETTLEMENT_REVERSAL"))) {
			if (documentClass in ["DA", "DP", "OA", "DR"]) {
				amount = new BigDecimal(documentData.productAmount)
				currency = documentData.currency
			}
		} else if (serviceType.contains("ADVISING")) {
			amount = new BigDecimal(documentData.lcAmount ? documentData.lcAmount.replaceAll(",","") : 0)
			currency = documentData.lcCurrency
		} else if (serviceType.equals("REFUND") && documentClass.equals("CDT")) {
			amount = new BigDecimal(documentData.totalAmountOfPayment.toString().replaceAll(",", ""))
		} else {
			// does not matter for everything else
			amount = 0
		}

		//amount = ratesService.getPesoAmount(amount, currency)
		amount = ratesService.convertToPeso(documentData.tradeServiceId, currency, amount.toString())

		//println"amount to check: " + amount
		////println"product references for apa " + productServiceAttributes
		////printlnproductServiceAttributes?.POSTAPPROVALREQUIREMENT

		Map<String, Object> param = [username: username, unitCode: unitCode]

		List<Map<String, Object>> queryResult = queryService.executeQuery(routingInformationFinder, "getUser", param)


		def user = queryResult[0]

		def productReference = [
				"financial": productServiceAttributes?.FINANCIAL == 1 ? true : false,
				"postApprovalRequirement": productServiceAttributes?.POSTAPPROVALREQUIREMENT,
				"amountToCheck": amount,
				"signingLimit": user.LIMIT,
				"postingAuthority": user.POST_AUTH
		]

		return productReference
	}

	// get appropriate statusAction for routing
	String getStatusAction(Boolean financial, String action, BigDecimal signingLimit, BigDecimal amountToCheck, String status, String postApprovalRequirement) {
		println "| statusAction passed >> " + action + " |"
		println "############################"
		println financial
		println action
		println postApprovalRequirement
		println "############################"

		String statusAction = action

		if (financial == true) { // financial
			if (action.equals("preApprove")) { // assume post
				statusAction = "posted" // set status to APPROVED always when assuming posting authority
			} else if (action.equals("Approve")) { // approve
				if (signingLimit < amountToCheck) {
//                    statusAction = "preApprove" // set status to PRE_APPROVED if beyond signing limit
					statusAction = "posted"
				}
			} else if (action.equals("postApprove")) { // post approve
				if (status.equals("PRE_APPROVED")) {
					statusAction = "Approve" // if current status is PRE_APPROVED, it means it is not yet POSTED and only if status is set to APPROVED will it be posted
				} else if (status.equals("APPROVED")) {
					statusAction = "postApprove" // if current status is APPROVED, set status to POST_APPROVE. this is FYI only
				}
			} else {
				statusAction = action;
			}
		} else { // non-financial
			if (action.equals("preApprove")) { // assume post
				if (postApprovalRequirement.equals("YES")) {
					statusAction = "posted" // set status to posted always and requires post approval
				} else if (postApprovalRequirement.equals("NO")){
					statusAction = "Approve" // set status to approve without post approval
				}
			} else {
				statusAction = action;
			}
		}

		println"| statusAction to return after evaluation >> " + statusAction + " |"
		return statusAction
	}
	
	Integer getHigherUserHierarchySize(level){
		Map<String, Object> param = [level: level]
		List<Map<String, Object>> queryResult = queryService.executeQuery(routingInformationFinder, "getHigherUserHierarchySize", param)
		return (queryResult==null ? 0 : queryResult.size())
	}
}
