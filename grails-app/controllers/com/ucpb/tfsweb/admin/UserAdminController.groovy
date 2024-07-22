package com.ucpb.tfsweb.admin

import grails.converters.JSON
import java.text.SimpleDateFormat
import net.ipc.utils.NumberUtils

class UserAdminController {

    def coreAPIService

    def index() {
        redirect(action:'search')

        //render (view: "/admin/user/search")
    }

    def search() {

        Map parameters = [:]

        if(params.userid != null) {
            parameters.put("userId", params.userid)
        }

        if(params.username != null) {
            parameters.put("fullName", params.username)
        }

        def returnValues = coreAPIService.dummySendQuery(parameters, "search", "security/employee/").details
        List matchingUsers = []

        returnValues.each() { user ->
				matchingUsers.add([id: user?.userId, name: user?.fullName , lastLogin: user?.lastLogin])            
        }

        render (view: "/admin/user/search", model: [users:matchingUsers])
    }

    def view() {

        Map userDetail
        def allRoles

        def allPositions
		
        if (params.u != null && !params.u.equalsIgnoreCase("")) {

            userDetail = coreAPIService.dummySendQuery([:], params.u, "security/user/").details
            allRoles = coreAPIService.dummySendQuery([:], "", "security/roles/").details
			
             // query AD for this users roles
            Map parameters = [userid : params.u]
            def userInfo = coreAPIService.dummySendQuery(parameters, "search", "security/ldap/")

            if(userInfo.status?.equalsIgnoreCase("ok")) {
                // override roles fetched from the DB with the AD roles
                userDetail.roles =  ("not found".equals(userInfo.details)) ? [] : userInfo.details.roles
            }

            // do not include roles user already has
            allRoles = allRoles.minus(userDetail.roles)
        } else {
            allRoles = coreAPIService.dummySendQuery([:], "", "security/roles/").details
        }

        allPositions = coreAPIService.dummySendQuery([:], "allPositions", "position/").result
        def designations = coreAPIService.dummySendQuery([:], "allDesignations", "designation/").result

        def allDesignations = []

        designations.each {
            allDesignations << [id: NumberUtils.wholeNumberFormat(new Double(it.id.toString())), description: it.description]
        }

        render (view: "/admin/user/index", model: [user: userDetail, allRoles: allRoles, allPositions: allPositions, allDesignations: allDesignations])

    }

    def add() {
        redirect (action: "view")
        //render (view: "/admin/user/view", model: [action:"add"])
    }

    def save() {

        print "saving"
        // the field is not passed if it is not checked
        params.postingAuthority = params.postingAuthority != null ? "Y" : "N"

        if (session['username'] != null && !((String)session['username']).empty) {
            print "\nsession.username = ${session['username']}\n"
            params.sessionUsername = session['username']
        }

        if (session['fullname'] != null && !((String)session['fullname']).empty) {
            print "\nsession.fullname = ${session['fullname']}\n"
            params.sessionFullname = session['fullname']
        }

        params.isSuspended= params.isSuspended != null ? "Y" : "N"

        def returnValue = coreAPIService.dummySendCommand(params, "save", "security/user/")

        redirect(action: "view", params: [u:  params.userId])
    }

    def validateUser() {
        println "validateUser \n" + params
        if(params.userId != null) {

            Map parameters = [ldapDomain: params.ldapDomain, userid : params.userId]
            def returnValue = coreAPIService.dummySendQuery(parameters, "search", "security/ldap/")

            if(returnValue.status == "ok") {

                if (returnValue.details != "not found") {

                    List roles = []

                    returnValue.details?.roles?.each() { role ->
                        roles.add(role)
                    }

                    String unitCode = returnValue.details.extensionAttribute5
                    println "unitCode " + unitCode
                    Map results = [
                            status: "ok",
                            user:  [
                                    email: returnValue.details.email,
                                    userId: returnValue.details.sAMAccountName,
                                    fullName: returnValue.details.displayName,
                                    unitCode: unitCode,
                                    bookingUnitCode: unitCode ? unitCode?.substring(2, unitCode.length()) : "",
                                    email: returnValue.details.email,
                                    roles: roles
                            ],

                            isExisting: returnValue.isExisting
                    ]

                    println results



                    render results as JSON
                    return

                } else {
                    Map results = [
                            status: "not found",
                    ]
                    render results as JSON
                    return
                }
            }

        }

        Map results = [
                status : "error"
        ]

        render results as JSON
    }

    def retrieveSigningLimit() {
        def position = coreAPIService.dummySendQuery([positionCode: params.positionCode], "getPosition", "position/").result
        println position
        render([signingLimit: NumberUtils.currencyFormat(position?.signingLimit ?: 0)] as JSON)
    }

    def checkIfOfficer() {
        def result = coreAPIService.dummySendQuery([:], "user/" + session.username, "security/")?.details

        if (params.userToChange.equals(session.username)) {
            render([isOfficer: false] as JSON)
            return
        }

        result.roles.each {
            if ("TSDO".equals(it.roleId.roleId) || "TSDO".equals(it.parentRoleId?.roleId)) {
                render([isOfficer: true] as JSON)
                return
            }
        }

        render([isOfficer: false] as JSON)
    }

//    def authenticateChange() {
//        def result = coreAPIService.dummySendCommand([u: params.username, p: params.password], "authenticate", "security")?.details
//
//        def jsonData = [:]
//
//        if (result?.authenticated) {
//            boolean isOfficer = false
//
//            result?.roles?.each {
//                if ("TSDO".equals(it.parentRoleId?.roleId) || "TSDO".equals(it.roleId.roleId)) {
//                    isOfficer = true
//                }
//            }
//
//            if (result && isOfficer) {
//                jsonData = [success: true]
//            } else {
//                jsonData = [success: false, message: 'User authenticated is not an officer.']
//            }
//        } else {
//            jsonData = [success: false, message: 'You have entered an incorrect userid and/or password.']
//        }
//
//        render jsonData as JSON
//    }
}
