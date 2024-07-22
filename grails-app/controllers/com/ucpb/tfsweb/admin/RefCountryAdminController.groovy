package com.ucpb.tfsweb.admin

import net.ipc.utils.NumberUtils

class RefCountryAdminController {

    def coreAPIService

    def index() {
        redirect(action:'search')

    }
    def search() {

        Map parameters = [:]

        if(params.countryCode!= null && !params.countryCode.trim().isEmpty()) {
            parameters.put("countryCode", params.countryCode)
        }

        if(params.countryName != null && !params.countryName.trim().isEmpty()) {
            parameters.put("countryName", params.countryName)
        }

        if(params.countryISO != null && !params.countryISO.trim().isEmpty()) {
            parameters.put("countryISO", params.countryISO)
        }

        def returnValues = coreAPIService.dummySendQuery(parameters, "searchCountry", "refCountry/").details
        if (returnValues instanceof List) {
            print(parameters)
            render (view: "/admin/refCountry/search", model: [refCountry:returnValues])

        } else {
            render (view: "/admin/refCountry/search")
        }
    }

    def addCountry(){
           redirect(action:"view")
    }

    def view() {
        render (view: "/admin/refCountry/view")
        Map refCountryDetail
        if(params.u != null && !params.u.trim().isEmpty()) {

            refCountryDetail = coreAPIService.dummySendQuery([:], params.u, "refCountry/countryDetails/").details
            //println "hello " + refCustomerDetail?.clientType

            render (view: "/admin/refCountry/view", model: [refCountry: refCountryDetail])
        }
        //---
        //if (refCustomerDetail?.clientType.equals('1')) {
          //  render (view: "/admin/refCounty/viewIndividual", model: [refCustomer: refCustomerDetail])
        //} else {
         //   render (view: "/admin/refCustomer/viewCorporate", model: [refCustomer: refCustomerDetail])
        //}

    }
    def save(){
        def returnValue = coreAPIService.dummySendCommand(params, "save", "refCountry/countryDetails/")
        if (returnValue.status == "error") {
            forward (action: "view", params: [error: returnValue.error.description])
        } else {

                //redirect (action: search())
            forward (action: "view", params: [u: params.countryCode])
            //render (view: "/admin/refCountry/view", model: [refCountry: refCountryDetail])

        }
    }


}
