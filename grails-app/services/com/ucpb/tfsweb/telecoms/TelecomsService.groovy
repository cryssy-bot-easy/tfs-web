package com.ucpb.tfsweb.telecoms

import java.util.Map;
import org.springframework.transaction.annotation.Transactional;
import net.ipc.utils.DateUtils;
import org.codehaus.groovy.grails.web.util.WebUtils

class TelecomsService {

	/*	PROLOGUE:
		(revision)
		SCR/ER Number: 20151104-020
		SCR/ER Description: The Date/Time of Generated MTs on Telecom's inquiry changed when a transaction was post approved.
		[Revised by:] Jennie Nuas
		[Date revised:] 06/22/2015
		Program [Revision] Details: Changed MODIFIEDDATE to CREATEDDATE on function constructOutgoingMt().
		Date deployment:
		Member Type: GROOVY
		Project: CORE
		Project Name: TelecomsService.groovy
	 */

	def unactedFinder = com.ucpb.tfs.application.query.task.ITaskFinder.class
	def coreAPIService
	def queryService
	
	
	private final String EMPTY = ""
	
	
//	List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

	@Transactional(readOnly=true)
	Map<String, Object> findAllOutgoingMt(maxRows, rowOffset, currentPage,status) {
		String methodName = "findAllOutgoingMtByStatus"
		Map<String, Object> param = [status:status]

		List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}
	
	@Transactional(readOnly=true)
	List<Map<String, Object>> findAllNewMts(){
		String methodName = "findAllOutgoingMtByStatus"
		Map<String, Object> param = [status:'NEW']
						
		List<Map<String, Object>> queryResult = queryService.executeQuery(unactedFinder, methodName, param)
						
		return queryResult
	}
	
	
	
	def constructOutgoingMt(display) {
		display.collect {
			[id: it.ID,
					cell: [
							it.TRADEPRODUCTNUMBER,
							it.MTTYPE,
							DateUtils.shortDateFormat(it.CREATEDDATE) + " " + DateUtils.timeFormat(it.CREATEDDATE),
							it.MTSTATUS,
							constructLink(it.MTSTATUS?.toString(),it.ID?.toString())
							
					]
			]
		}
	}
	
	private String constructLink(String mtStatus,String entryId){
		if(mtStatus.equals(null) || entryId.equals(null)){
			return EMPTY;
		}
		def webUtils = WebUtils.retrieveGrailsWebRequest()
		String user = webUtils.session?.userrole?.description?.toString().toUpperCase() ?: EMPTY
		String transmitLink = "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+ entryId +"'; onTransmitMt(id);\">transmit</a>"
		String discardLink = "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+ entryId +"'; onDiscardMt(id);\">discard</a>"
		String reverseLink = "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+ entryId +"'; onReverseMt(id);\">reverse</a>"
		String viewLink = "<a href=\"#\" class=\"jqgrid_inline_links\" onclick=\"var id='"+ entryId +"'; onViewOutgoingMt(id);\">view</a>"
		String separator = " | " 
		StringBuilder builder = new StringBuilder(EMPTY);

		if(user.contains("PROCESSOR")){
			builder.append(viewLink)
		}else{
			switch(mtStatus){
			case "DISCARDED":
			case "TRANSMITTED":
				builder.append(reverseLink).append(separator).append(viewLink)
				break;
			default:
				builder.append(transmitLink).append(separator).append(discardLink).append(separator).append(viewLink)
			}		
		}
				
		return builder.toString()
	}
}