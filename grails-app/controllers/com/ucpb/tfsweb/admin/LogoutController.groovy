package com.ucpb.tfsweb.admin

import com.ibm.icu.text.StringSearch;

import grails.converters.JSON

class LogoutController {

	def logoutService
	
	def index(){
		render(view:'/admin/logout/index')
	}
	
	def searchUsersToLogout(){
		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		def parameters = [userId:params.userId?.toString().toUpperCase(),
						  loginStatus:params.loginStatus?.toString()] 
 
		def mapList = logoutService.findUsersToLogout(maxRows, rowOffset, currentPage,parameters)
		
		def totalRows = mapList.totalRows
		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def resultList = logoutService.constructUserToLogoutGrid(mapList.display)
		
		def jsonData = [rows: resultList, page: currentPage, records: totalRows, total: numberOfPages]
		
		render jsonData as JSON
	}
	
	def logoutUser(){
		session.removeAttribute("user");
		
		def parameters = [u:params.userId,referrer:'admin']
		def result = logoutService.logoutUser(parameters)
		def jsonData = [result:result]
		
		render jsonData as JSON
	}
}