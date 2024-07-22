package com.ucpb.tfsweb.admin

import java.util.Map;
import java.text.SimpleDateFormat;
import org.springframework.transaction.annotation.Transactional;

class LogoutService {

	def coreAPIService
	
	def userLogFinder = com.ucpb.tfs.application.query.service.IUserLogFinder.class
	def queryService
	
    Map<String, Object> findUsersToLogout(maxRows, rowOffset, currentPage,parameters) {
		List<Map<String, Object>> result = queryService.executeQuery(userLogFinder, "findUsersToLogout", parameters)
		
        Integer toIndex = ((currentPage * maxRows) < result?.size()) ? (currentPage * maxRows) : result?.size()
        return [display: result?.subList(rowOffset, toIndex), totalRows: result?.size()]
    }
	
	def logoutUser(parameters){
		def returnValue =  coreAPIService.dummySendCommand(parameters, "removeLogIn", "security").details
		return returnValue
	}
	
	def constructUserToLogoutGrid(display) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss aa");

		def list = display.collect {
			String isLoggedIn = it.ISLOGGEDIN?.toString().equals("1") ? "Logged In" : it.ISLOGGEDIN?.toString().equals("0") ? "Logged Out" : "-"
    			
			[id: it.ID, 
					cell: [
						it.ID,
						it.FULLNAME ?: "-",
						it.UNITCODE ?: "-",
						it.LAST_LOGIN ? sdf.format(it.LAST_LOGIN) : "-",
						it.LAST_LOGOUT ? sdf.format(it.LAST_LOGOUT) : "-",
						isLoggedIn ?: "-"
//						,
//						isLoggedIn.toUpperCase().equals("LOGGED IN") ?
//							 "<a href=\"javascript:void(0)\" onclick=\"userId='$it.ID';onLogoutClick(userId)\">logout</a>" : "-"
					]
			]
		}
		return list
	}
}