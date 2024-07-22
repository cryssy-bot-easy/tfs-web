package com.ucpb.tfsweb.admin

class RefProductServiceAdminController {

    def coreAPIService

    def index() {
        //render (view: "/admin/refProductService/search")
        redirect(action:'search')

    }

    def search() {

        Map parameters = [:]

        if(params.productId != null && !params.productId.trim().isEmpty()) {
            parameters.put("productId", params.productId)
        }

        if(params.serviceType != null && !params.serviceType.trim().isEmpty()) {
            parameters.put("serviceType", params.serviceType)
        }

        def returnValues = coreAPIService.dummySendQuery(parameters, "searchProductService", "refProductService/").details

        println "returnValues = ${returnValues}"

        if (returnValues instanceof List) {
            render (view: "/admin/refProductService/search", model: [refProductServices:returnValues])
        } else {
            render (view: "/admin/refProductService/search")

        }
    }

    def view() {

        Map refProductServiceDetail

        if(params.u != null && !params.u.trim().isEmpty()) {

            refProductServiceDetail = coreAPIService.dummySendQuery([:], params.u, "refProductService/productServiceDetails/").details
            println(refProductServiceDetail);
        }
        render (view: "/admin/refProductService/view", model: [refProductService: refProductServiceDetail])
    }

    def add() {
        redirect (action: "view")
        //render (view: "/admin/user/view", model: [action:"add"])
    }

    def save() {

        println "saving\n"

        def returnValue = coreAPIService.dummySendCommand(params, "save", "refProductService/productServiceDetails/")

        // Use forward to hide the URL string
        if (returnValue.status == "error") {
            forward (action: "view", params: [error: returnValue.error.description])
        } else {
            forward (action: "view", params: [u: params.productServiceId])
        }
    }
}
