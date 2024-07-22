package com.ucpb.tfsweb.utilities

import com.incuventure.cqrs.query.QueryItem

class AuthenticationService {

//    def queryService
    def queryBusService

//    def finder = com.ipc.rbac.application.query.AuthenticationProvider.class
    def finder = com.ucpb.tfs.application.query.AuthenticationProvider.class

    def authenticateLogin(userid, password) {
        String methodName = "authenticate"

        try {
            QueryItem qi = new QueryItem("data", finder, methodName, userid, password)
            List<QueryItem> qis = new ArrayList<QueryItem>()
            qis.add(qi)

            HashMap<String, Object> returnValues = queryBusService.dispatch(qis)

            return returnValues


        } catch(NoSuchMethodException nsme) {

            ////println"invoking remote authenticate failed"
            nsme.printStackTrace()

            return "ERROR"
        }
    }

}
