package com.ucpb.tfsweb.utilities

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import groovyx.net.http.RESTClient

import java.lang.reflect.Type

import static groovyx.net.http.ContentType.JSON

class CoreAPIService {

    def grailsApplication

    def sendCommand(command, Map param) {

        def parameters

        if (param == null) {
            parameters = ''
        } else {
            parameters = new grails.converters.JSON(param)
        }

        def tfscore = new RESTClient("${grailsApplication.config.tfs.core.api.command.url}")

        def resp = tfscore.post(path: "details",
                body: parameters,
                requestContentType: groovyx.net.http.ContentType.JSON)

        return resp.data
    }

    def sendProxiedCommand(command) {

        // we first serialize the commmand to a JSON string
        def commandParameter = new Gson().toJson(command)

        // the parameter map will contain the full name of the command and the json-serialized command
        def parameterMap = [commandName: command.class.getCanonicalName(),
                command: commandParameter]

        // since the API expects JSON, we serialize the parameters to JSON
        def parameters = new Gson().toJson(parameterMap)

        def tfscore = new RESTClient("${grailsApplication.config.tfs.core.api.command.url}")

        def resp = tfscore.post(path: 'dispatchProxiedCommand',
                body: parameters,
                requestContentType: groovyx.net.http.ContentType.JSON)

        return resp.data
    }

    def sendProxiedQuery(query) {

        // we first serialize the commmand to a JSON string
        def queries = new Gson().toJson(query)

        // the parameter map will contain the json-serialized list of queries
        def parameterMap = [queryList: queries]

        // since the API expects JSON, we serialize the parameters to JSON
        def parameters = new Gson().toJson(parameterMap)

        def tfscore = new RESTClient("${grailsApplication.config.tfs.core.api.command.url}")

        def resp = tfscore.post(path: 'dispatchProxiedQuery',
                body: parameters,
                requestContentType: groovyx.net.http.ContentType.JSON)

        if (resp.data.status.equals("ok")) {

            Type listType = new TypeToken<Map<Map>>() {}.getType();


            Map x = resp.data;
            ////println"******** A " + x

            try {
                Object mylist = new Gson().fromJson(x.get("response").toString(), Object)
                ////println"******** B" + myList

                ////printlnmylist

                return resp.data.response
            }
            catch (Exception e) {
                ////println'-=-----'
                e.printStackTrace()
            }
        }

        return null;
    }

    def sendQuery(query, Map param) {

        if (param == null) {
            param = [:]
        }

        def tfscore = new RESTClient("${grailsApplication.config.tfs.core.api.query.url}")

        def resp = tfscore.get(path: query,
                requestContentType: JSON,
                query: param)


        return resp.data

    }

    def dummySendQuery(Map param, action, String... object) {

        if (param == null) {
            param = [:]
        }

        StringBuilder sb = new StringBuilder()
        sb.append("${grailsApplication.config.tfs.core.api.query2.url}")

        for (int idx = 0; idx < object.length; idx++) {
            sb.append(object[idx])
        }

        def tfscore = new RESTClient(sb.toString())

        def resp = tfscore.get(path: action,
                requestContentType: JSON,
                query: param)

        // convert from JSON to Map
        Gson gson = new Gson()
        Map returnData = gson.fromJson(resp.data.toString(), Map.class)

        return returnData

//        return resp.data
    }

    def dummySendCommand(Map param, action, String... object) {

        def parameters

        // JSONify the parameters
        if (param == null) {
            parameters = ''
        } else {
            parameters = new grails.converters.JSON(param)
        }

        StringBuilder sb = new StringBuilder()
        sb.append("${grailsApplication.config.tfs.core.api.webapi.url}")

        for (int idx = 0; idx < object.length; idx++) {
            sb.append(object[idx])
            sb.append("/")
        }

        def tfscore = new RESTClient(sb.toString())

        def resp = tfscore.post(path: action,
                requestContentType: JSON,
                body: param)

        // convert from JSON to Map
        Gson gson = new Gson()
        Map returnData = gson.fromJson(resp?.data?.toString(), Map.class)

        return returnData

        // return the data if there was no error, otherwise return null
        // TODO: we can improve this so it returns the actual exception message from core
//        if(resp.status.toString().equalsIgnoreCase("ok")) {
//            return resp.data
//        }
//        else {
//            return null
//        }
    }

    def httpGetCommand(Map param, action, String... object) {

        StringBuilder sb = new StringBuilder()
        sb.append("${grailsApplication.config.tfs.core.api.webapi.url}")

        for (int idx = 0; idx < object.length; idx++) {
            sb.append(object[idx])
            sb.append("/")
        }

        def tfscore = new RESTClient(sb.toString())

        def resp = tfscore.get(path: action,
                requestContentType: JSON,
                query: param)

        // convert from JSON to Map
        Gson gson = new Gson()
        Map returnData = gson.fromJson(resp.data.toString(), Map.class)

        return returnData

        // return the data if there was no error, otherwise return null
        // TODO: we can improve this so it returns the actual exception message from core
        //        if(resp.status.toString().equalsIgnoreCase("ok")) {
        //            return resp.data
        //        }
        //        else {
        //            return null
        //        }
    }
}
