package com.ucpb.tfsweb.main
import grails.converters.JSON
import net.ipc.session.UserSession
import net.ipc.utils.DateUtils;
//import com.ucpb.tfs.application.command.SaveAdditionalConditionsCommand
//import javax.servlet.http.HttpServletRequest


/**
 (revision)
 SCR/ER Number: 20170510-057
 SCR/ER Description: Encounter error 500 or unending loading screen when the idle timeout (15 minutes) was reached and try to click view MT or click the charges tab.
 [Revised by:] Jesse James Joson
 [Date deployed:] 6/16/2017
 Program [Revision] Details: Add the force logout function to be called by login.js which is similar to the normal logout function with inclusion of the error message to be prompted in login screen.
 Member Type: Groovy
 Project: WEB
 Project Name: LoginController.groovy
  */

class LoginController {

    def authenticationService
	def routingInformationService

    def securityService

    def coreAPIService

	def index(){
        // if user is already authenticated, redirect to unacted screen
        if(session['username']) {
            // redirect(controller: "unactedTransactions", action: "viewUnacted")
            forward controller: "unactedTransactions", action: "viewUnacted"
        }

		render(view:'/main/login')
	}
	
	def loggedIn(){

		////println"loggedIn"
        // redirect(controller: "unactedTransactions", action: "viewUnacted")
        forward controller: "unactedTransactions", action: "viewUnacted"
	}

    def login()
    {

        session['model'] = [:]
        //the old RMI authentication call is no longer used
        //def returnValue = authenticationService.authenticateLogin(params.username, params.pwd)
		
		String ipAddress = request.getHeader("X-FORWARDED-FOR")
		boolean isSessionLoggedIn = UserSession.loggedIn(new UserSession(params?.username))
		if(isSessionLoggedIn) {
			ipAddress = UserSession.getUserSession(params?.username).getIp()
		} else if (ipAddress == null) {
			ipAddress = request.getRemoteAddr()
		}
		
        Map authparams = [ldapDomain: params.ldapDomain, u: params.username, p: params.pwd, referrer: 'login', ip: ipAddress, isSessionLoggedIn: isSessionLoggedIn]
        def returnValue2 = coreAPIService.dummySendCommand(authparams, "authenticate", "security")

        if(returnValue2.details?.authenticated == true) {

            if (returnValue2.detailsMismatch == true) {
                flash.message = "AD Details does not match with TFS Details. Please request to update the user to a User Maintenance Administrator."
                render(view:'/main/login')
                return
            }

            session['username'] = params?.username
            session['firstname'] = returnValue2.details?.employee?.firstName
            session['lastname'] = returnValue2.details?.employee?.lastName
            session['fullname'] = returnValue2.details?.employee?.fullName
            session['unitcode'] = returnValue2.details?.employee?.unitCode
            session['userrole'] = returnValue2.details?.roles
            session['postAuthority'] = returnValue2.details?.employee?.postingAuthority
            session['userLevel'] = returnValue2.details?.employee?.level
            session['postingLimit'] = returnValue2.details?.employee?.postingLimit

            session['fullUnitCode'] = returnValue2.details?.employee?.fullUnitCode
			session['user'] = new UserSession(params?.username, ipAddress)

            if (returnValue2.details?.designationDetails) {
                session['designationLevel'] = returnValue2.details?.designationDetails?.level
            }

			if(session['userLevel']){
			    //session['higherUserHeirarchy'] = routingInformationService.getHigherUserHierarchySize(new Integer(session['userLevel']))
                session['higherUserHeirarchy'] = routingInformationService.getHigherUserHierarchySize(session['userLevel'])
			}

            def tempRoles = returnValue2.details?.roles
            def roles = []

            tempRoles.each() { role ->
                println "it role " + role.roleId.roleId
                //roles.add([id: role.roleId.roleId, description: role.description])
                roles.add([id: role.roleId.roleId?.trim(), description: role.description?.trim(), parentId: role.parentRoleId?.roleId?.trim()])
            }

            println "assigning user roles in session " + roles
            session['userrole'] = roles
            println "logging in user: " + params.username
            println "roles.size() " + roles.size()
            println "session.userrole " + session.userrole
            println "session.userrole.parentId > " + session.userrole.parentId

            // if user has only one role, use the first one
            if (roles.size() > 0) {
                println "role is greater than 0"
                if (roles.size() == 1) {
                    println "role is only 1"
                    session['userrole'] = roles.iterator().next()

                    // override role id with the parent id if one was found
                    // this is a workaround to the mismatch of original roles identified
                    println "session.userrole.parentId > " + session.userrole.parentId
                    if(session.userrole.parentId) {
                        session.userrole.id = session.userrole.parentId
                    }

                    if(session['userrole']['id'].startsWith('BR')) {
                        session['group'] = 'BRANCH'
                    } else if(session['userrole']['id'].startsWith('TSD')) {
                        session['group'] = 'TSD'
                    } else if(session['userrole']['id'].startsWith('TEL')) {
                        session['group'] = 'TELECOMS'
                    } else if(session['userrole']['id'].startsWith('ADMIN')) {
                        session['group'] = 'ADMIN'
                    } else if(session['userrole']['id'].startsWith('BATCH')) {
                        session['group'] = 'BATCH'
                    } else if(session['userrole']['id'].startsWith('IPC')) {
                        session['group'] = 'IPC'
                    } else if (session['userrole']['id'].startsWith('TRE')){
                        session['group'] = 'TRE'
                    } else if (session['userrole']['id'].contains('USER')) {
                        session['group'] = 'USER'
                    } else if (session['userrole']['id'].contains('SESSIONADMIN')) {
                        session['group'] = 'SESSIONADMIN'
                    }  else {
                        session['group'] = 'NONE'
                    }

                    println "user group " + session.group
                } else {
                    println "there were multiple roles"
                    render(view: '/main/roleselect')
                    return
                }
            } else {
                println "there is no role retrieved"
                flash.message = "User is not associated to any valid TFS groups."
                render(view:'/main/login')
                return
            }

            if(session.group.equalsIgnoreCase('USER')) {
                // redirect(controller: "userAdmin", action: "index")
                forward controller: "userAdmin", action: "index"
                return
            }

            if(session.group.equalsIgnoreCase('ADMIN')) {
                // redirect(controller: "admin", action: "index")
                forward controller: "admin", action: "index"
                return
            }

            if(session.group.equalsIgnoreCase('BATCH')) {
                // redirect(controller: "batch", action: "index")
                forward controller: "batch", action: "index"
                return
            }

			if(session.group.equalsIgnoreCase('TRE')) {
            	// redirect(controller: "treasury", action: "index")
                forward controller: "treasury", action: "index"
            	return
            }

            if(session.group.equalsIgnoreCase('IPC')) {
                // redirect(controller: "incuventureAdmin", action: "index")
                forward controller: "incuventureAdmin", action: "index"
                return
            }

            if(session.group.equalsIgnoreCase('TELECOMS')) {
            	// redirect(controller: "telecoms", action: "index")
                forward controller: "telecoms", action: "index"
                return
            }
			
            if(session.group.equalsIgnoreCase('SESSIONADMIN')) {
            	// redirect(controller: "logout", action: "index")
                forward controller: "logout", action: "index"
            	return
            }
			
            if(session.group.equalsIgnoreCase('NONE')) {
            	flash.message = "The user is not assigned to a valid application role"
                render(view:'/main/login')
            	return
            }

//            redirect(controller: "unactedTransactions", action: "viewUnacted")
            // todo: remove username from url string
			
			// To Do - Saving of Last Login
			
            // redirect(controller: "unactedTransactions", action: "viewUnacted")
            forward controller: "unactedTransactions", action: "viewUnacted"
			//render(view:'/commons/script/popupopener')

        } else if (returnValue2.details?.authenticated == false) {
//            flash.message = "You have entered an incorrect userid or password"
            flash.message = returnValue2.details?.errorMessage ?: "You have entered an incorrect userid and/or password."
            render(view:'/main/login')
        }
        else {
            flash.message = "A connection error occurred : " + returnValue2?.data?.status
            render(view:'/main/login')
        }

//        if(returnValue["data"][0]["status"] == "AUTHORIZED") {
//
//            session['username'] = params?.username
//            session['firstname'] = returnValue["data"][0]["userdetails"]["firstname"]
//            session['lastname'] = returnValue["data"][0]["userdetails"]["lastname"]
//            session['unitcode'] = returnValue["data"][0]["userdetails"]["unitcode"]
//            session['userrole'] = returnValue["data"][0]["userdetails"]["roles"]
//            session['postAuthority'] = returnValue["data"][0]["userdetails"]["postAuthority"]
//            session['userLevel'] = returnValue["data"][0]["userdetails"]["level"]
//            session['postingLimit'] = returnValue["data"][0]["userdetails"]["postingLimit"]
//
//			if(session['userLevel']){
//			session['higherUserHeirarchy'] = routingInformationService.getHigherUserHierarchySize(new Integer(session['userLevel']))
//			}
//
//            def roles = returnValue["data"][0]["userdetails"]["roles"]
//
//            session['userrole'] = roles
//
//            // if user has only one role, use the first one
//            if (roles.size() == 1) {
//                session['userrole'] = roles.iterator().next()
//
//                if(session['userrole']['id'].startsWith('BR')) {
//                    session['group'] = 'BRANCH'
//                } else if(session['userrole']['id'].startsWith('TSD')) {
//                    session['group'] = 'TSD'
//                } else if(session['userrole']['id'].startsWith('TEL')) {
//                    session['group'] = 'TELECOMS'
//                } else if(session['userrole']['id'].startsWith('ADMIN')) {
//                    session['group'] = 'ADMIN'
//                }else {
//                    session['group'] = 'NONE'
//                }
//
//            } else {
//                render(view: '/main/roleselect')
//                return
//            }
//
//            if(session.group.equalsIgnoreCase('ADMIN')) {
//                redirect(controller: "admin", action: "index")
//                return
//            }
//
////            redirect(controller: "unactedTransactions", action: "viewUnacted")
//            // todo: remove username from url string
//            redirect(controller: "unactedTransactions", action: "viewUnacted")
//			//render(view:'/commons/script/popupopener')
//
//        } else if (returnValue["data"][0]["status"] == "UNAUTHORIZED") {
//            flash.message = "You have entered an incorrect userid or password"
//            render(view:'/main/login')
//        }
//        else {
//            flash.message = "A connection error occurred : " + returnValue["data"]["status"]
//            render(view:'/main/login')
//        }
    }

    def selectRole() {
        println "inside selection of roles.."
        // set userrole to the one user selected
        session['userrole'] = session['userrole'].find { it.id == params.role}

        println "parameter role " + params.role

        if(session.userrole.parentId) {
            session.userrole.id = session.userrole.parentId
        }

        println "session.userrole.id " + session.userrole.id

        if(session['userrole']['id'].startsWith('BR')) {
            session['group'] = 'BRANCH'
        } else if(session['userrole']['id'].startsWith('TSD')) {
            session['group'] = 'TSD'
        } else if(session['userrole']['id'].startsWith('TEL')) {
            session['group'] = 'TELECOMS'
        } else if(session['userrole']['id'].startsWith('ADMIN')) {
            session['group'] = 'ADMIN'
        } else if(session['userrole']['id'].startsWith('BATCH')) {
            session['group'] = 'BATCH'
        } else if(session['userrole']['id'].startsWith('TRE')) {
    		session['group'] = 'TRE'
		} else if (session['userrole']['id'].contains('USER')) {
            session['group'] = 'USER'
        } else if (session['userrole']['id'].contains('SESSIONADMIN')) {
            session['group'] = 'SESSIONADMIN'
        } else {
            session['group'] = 'NONE'
        }

        println "session.group " + session.group
        // todo: remove this
        params.username = session['username']
		
        if(session.group.equalsIgnoreCase('USER')) {
            // redirect(controller: "userAdmin", action: "index")
            forward controller: "userAdmin", action: "index"
            return
        }

        if(session.group.equalsIgnoreCase('ADMIN')) {
            // redirect(controller: "admin", action: "index")
            forward controller: "admin", action: "index"
            return
        }

        // we then redirect to unacted screen
        // redirect(controller: "unactedTransactions", action: "viewUnacted")
        forward controller: "unactedTransactions", action: "viewUnacted"
    }

    def logout() {

        // clear out the session
//        session.removeAttribute('username')
//        session.removeAttribute('firstname')
//        session.removeAttribute('lastname')
//        session.removeAttribute('unitcode')
//        session.removeAttribute('userrole')
		
		def sessionMessage = "";
		if (session['sessionMessage'] != null) {
			println "sessionMessage: " + session['sessionMessage']
			sessionMessage = session['sessionMessage']
			session.removeAttribute("sessionMessage")
		}
		
        if (session['username'] != null) {

            Map params = [u: session['username']]
            coreAPIService.dummySendCommand(params, "removeLogIn", "security")

            // clears session
			if (session != null) {
				session.invalidate()				
			}
        }
		
		if (sessionMessage != "") {
			flash.message = sessionMessage
			render(view:'/main/login')
		}
		
		
        // render(view: '/main/login')
        // redirect(view: '/main/login')
        forward controller: "login", action: "index"
    }
	
	// temporary
	// if usertype = telecom and username = branch
	def telecomLoggedInBranch(){
		render(view: "/main/unauthorized")
    }

    def authenticateChange() {
        def result = coreAPIService.dummySendCommand([ldapDomain: securityService.getLdapDomain(session.unitcode),
                u: params.username,
                p: params.password], "authenticate", "security")?.details

        def jsonData = [:]

        if (result?.authenticated) {
            boolean isOfficer = false

            println "designationlevel " + session.designationLevel
            println "officerLevel " + result.designationDetails.level

//            if (session.designationLevel && session.designationLevel < result?.designationDetails?.level) {
            if (session.designationLevel && result?.designationDetails?.level < session.designationLevel && session.designationLevel) {
                isOfficer = true
            }
//            result?.roles?.each {
//                if ("TSDO".equals(it.parentRoleId?.roleId) || "TSDO".equals(it.roleId.roleId)) {
//                    isOfficer = true
//                }
//            }

            if (result && isOfficer) {
                jsonData = [success: true]
            } else {
                jsonData = [success: false, message: 'User must be of higher designation.']
            }
        } else {
            jsonData = [success: false, message: 'You have entered an incorrect userid and/or password.']
        }

        render jsonData as JSON
    }
	
	def startTimer() {
		def userrole
		def jsonData = [:]
		long min = 0		
		long sec = 0
		String message = "There is existing session."

		 if (session['lastTimeUsed'] != null) {
		 println "session['lastTimeUsed'] = " + session['lastTimeUsed']
		 Date now = new Date(DateUtils.dateTimeFormat2(new Date()));
		 Date lastUsed = new Date(session['lastTimeUsed']);
		 
		 println "now = " + now
		 println "lastUsed = " + lastUsed
		 
		 sec = (now.getTime()-lastUsed.getTime()) / 1000
		 min = sec / 60
		 sec = sec % 60
		 
		 println ("HANG TIME: " + min + " minute/s and " + sec + " second/s")

		 if (min == 15) {
			 message = "Already reached the session timeout."
		 }

		 }
		
		
		if (session['user'] != null) {	
			userrole = session['group']			
			jsonData = [success: true, message: message, role: userrole, min: min, sec: sec]			
		} else {
			message = "Session already invalidated."
			jsonData = [success: false, message: message]			
		}
		
		render jsonData as JSON
	}
	
	def sessionEnd() {
		println "sessionEnd()"
		
		session['sessionMessage'] = "Your current login session has expired."
		
		redirect controller: "login", action: "logout"
	}
}
