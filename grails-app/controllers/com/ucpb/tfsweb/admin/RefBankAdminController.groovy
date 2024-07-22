package com.ucpb.tfsweb.admin

class RefBankAdminController {

    def coreAPIService

    def index() {

        redirect(action:'search')

        //render (view: "/admin/refBank/search")
    }

    def search() {

        Map parameters = [:]

/*
        if(params.swiftCode != null && !params.swiftCode.trim().isEmpty()) {
            parameters.put("swiftCode", params.swiftCode)
        }
*/
        if(params.bic != null && !params.bic.trim().isEmpty()) {
            parameters.put("bic", params.bic)
        }

        if(params.branchCode != null && !params.branchCode.trim().isEmpty()) {
            parameters.put("branchCode", params.branchCode)
        }

        if(params.institutionName != null && !params.institutionName.trim().isEmpty()) {
            parameters.put("institutionName", params.institutionName)
        }

        if(params.depositoryFlag != null && !params.depositoryFlag.trim().isEmpty()) {
            parameters.put("depositoryFlag", params.depositoryFlag)
        }

        if (parameters != null && !parameters.isEmpty()) {
            def returnValues = coreAPIService.dummySendQuery(parameters, "searchBank", "refBank/").details

            if (returnValues instanceof List) {
                render (view: "/admin/refBank/search", model: [refBanks:returnValues])
            } else {
                render (view: "/admin/refBank/search")
            }
        } else {
            render (view: "/admin/refBank/search")
        }
    }

    def view() {

        Map refBankDetail

        if(params.u != null && !params.u.trim().isEmpty()) {

            refBankDetail = coreAPIService.dummySendQuery([:], params.u, "refBank/bankDetails/").details
        }

        render (view: "/admin/refBank/view", model: [refBank: refBankDetail])
    }

    def add() {
        redirect (action: "view")
        //render (view: "/admin/user/view", model: [action:"add"])
    }

    def save() {

        //println"saving\n"

        def returnValue = coreAPIService.dummySendCommand(params, "save", "refBank/bankDetails/")

        // Use forward to hide the URL string
        if (returnValue.status == "error") {
            forward (action: "view", params: [error: returnValue.error.description])
        } else {
            forward (action: "view", params: [u: params.bic+params.branchCode])
        }
    }
}
