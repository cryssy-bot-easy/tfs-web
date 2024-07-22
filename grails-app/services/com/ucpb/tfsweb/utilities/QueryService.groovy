package com.ucpb.tfsweb.utilities

import com.incuventure.cqrs.query.QueryItem
import java.lang.reflect.Method

class QueryService {
    
    def queryBusService
    def coreAPIService

    String retrieveEtsNumberFromToken(tokenValue) {
        try {
            QueryItem qi = new QueryItem("token", com.incuventure.cqrs.token.TokenProvider.class, "getIdForToken", tokenValue)
            List<QueryItem> qis = new ArrayList<QueryItem>()
            qis.add(qi)

            HashMap<String, Object> returnValues = queryBusService.dispatch(qis)
            List mylist = (List) returnValues.get("token")

            return mylist[0]

        } catch (NoSuchMethodException nsme) {
            nsme.printStackTrace()
        }catch (Exception e){
            e.printStackTrace()
        }
    }

    List<Map<String, Object>> executeQuery(finder, methodName, param) {
        List<QueryItem> queryItems = new ArrayList<QueryItem>()

//        List<String> parameterList = new ArrayList<String>()
        List<Object> parameterList = new ArrayList<Object>()
        
        // iterates parameter passed and insert to parameter list
        param.each {
            Map.Entry map = (Map.Entry) it
            parameterList.add(map.getValue())
        }
	
        // converts array list to string[]
//        String[] parameters = parameterList.toArray(new String[0])
        Object[] parameters = parameterList.toArray()

        try {
            // create the query and add it to our items to dispatch
            QueryItem queryItem = null

            // checks if there is parameter to pass

            if(parameters.length > 0) {
                // instantiates query item and include parameters
                queryItem = new QueryItem("details", finder, methodName, parameters)
            } else {
                // instantiates query item without parameters
                queryItem = new QueryItem("details", finder, methodName)
            }

            queryItems.add(queryItem)

            HashMap<String, Object> result = queryBusService.dispatch(queryItems)
            // try the REST dispatcher
//            ////println"trying rest"
//            def result2 = coreAPIService.sendProxiedQuery(queryItems)
//
//            //println"result1: " + result
//            ////println"result2: " + result2
	
            List<Map<String, Object>> details = (List<Map<String, Object>>) result.get("details")


            return details

        } catch (NoSuchMethodException nsme) {
            nsme.printStackTrace()
            ////System.out.println("** SERVICE EXCEPTION: " + nsme);
        } catch (Exception e){
            ////println"***********"
            e.printStackTrace()
            ////System.out.println("** SERVICE EXCEPTION: " + e);

        }
    }

    List<Map<String, Object>> executeQueryFin(queryItems) {
//        List<QueryItem> queryItems = new ArrayList<QueryItem>()

//        List<String> parameterList = new ArrayList<String>()

        // iterates parameter passed and insert to parameter list
//        param.each {
//            Map.Entry map = (Map.Entry) it
//            parameterList.add(map.getValue())
//        }

        // converts array list to string[]
//        String[] parameters = parameterList.toArray(new String[0])

        try {
//            // create the query and add it to our items to dispatch
//            QueryItem queryItem = null
//
//            // checks if there is parameter to pass
//            if(parameters.length > 0) {
//                // instantiates query item and include parameters
//                queryItem = new QueryItem("details", finder, methodName, parameters)
//            } else {
//                // instantiates query item without parameters
//                queryItem = new QueryItem("details", finder, methodName)
//            }
//
//            queryItems.add(queryItem)

            HashMap<String, Object> result = queryBusService.dispatch(queryItems)
                    ////printlnresult
            List<Map<String, Object>> details = (List<Map<String, Object>>) result.get("details")

            return details
        } catch (NoSuchMethodException nsme) {
            nsme.printStackTrace()
        } catch (Exception e){
            e.printStackTrace()
        }
    }

}