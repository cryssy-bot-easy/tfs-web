package com.ucpb.tfsweb.admin

import grails.converters.JSON

import java.text.DecimalFormat

class DesignationController {

    def coreAPIService

    private DecimalFormat decimalFormat = new DecimalFormat("0")

    def index() {
        //render (view: "/admin/position/search")
        redirect(action: "search")
    }

    def search() {
        Map parameters = [description: params.description,
                level: params.level]

        def result = coreAPIService.dummySendQuery(parameters, "search", "designation/").result

        List matchinDesignations = []
        println "result > " + result

        result.each() { designation ->
            matchinDesignations.add([id: decimalFormat.format(designation?.id), description: designation?.description, level: decimalFormat.format(designation?.level)])
        }

        render (view: "/admin/designation/search", model: [designations: matchinDesignations])
    }

    def view() {
        def designation = coreAPIService.dummySendQuery([id: params.id], "getDesignation", "designation/").result
        println "designation " + designation

        render (view: "/admin/designation/view", model: [designation: designation])
    }

    def save() {

        print "saving"

        def returnValue = coreAPIService.dummySendCommand(params, "save", "designation/")

        redirect(action: "view", params: [positionCode:  params.positionCode])
    }

    def add() {
        redirect(action: "view")
    }

    def checkExisting() {
        def position = coreAPIService.dummySendQuery([positionCode: params.positionCode.toUpperCase()], "getPosition", "position/").result

        Boolean isExisting = Boolean.FALSE

        if (position) {
            isExisting = Boolean.TRUE
        }
        render([isExisting: isExisting] as JSON)
    }
}
