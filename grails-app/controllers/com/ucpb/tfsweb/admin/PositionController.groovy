package com.ucpb.tfsweb.admin

import grails.converters.JSON

class PositionController {

    def coreAPIService

    def index() {
        //render (view: "/admin/position/search")
        redirect(action: "search")
    }

    def search() {
        Map parameters = [positionName: params.positionName,
                          signingLimitFrom: params.signingLimitFrom,
                          signingLimitTo: params.signingLimitTo]

        def result = coreAPIService.dummySendQuery(parameters, "search", "position/").result

        List matchingPositions = []
        println "result > " + result

        result.each() { position ->
            matchingPositions.add([code: position?.code?.code, positionName: position?.positionName, signingLimt: position?.signingLimit])
        }

        render (view: "/admin/position/search", model: [positions:matchingPositions])
    }

    def view() {
        def position = coreAPIService.dummySendQuery([positionCode: params.positionCode], "getPosition", "position/").result
        println "position " + position

        render (view: "/admin/position/view", model: [position: position])
    }

    def save() {

        print "saving"

        def returnValue = coreAPIService.dummySendCommand(params, "save", "position/")

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
