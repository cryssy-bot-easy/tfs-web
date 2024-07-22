package com.ucpb.tfsweb.admin

import net.ipc.utils.NumberUtils

class RefCustomerAdminController {

    def coreAPIService

    def index() {
        redirect(action:'search')
        //render (view: "/admin/refCustomer/search")
    }

    def search() {

        Map parameters = [:]

        if(params.centralBankCode != null && !params.centralBankCode.trim().isEmpty()) {
            parameters.put("centralBankCode", params.centralBankCode)
        }

        if(params.clientTaxAccountNumber != null && !params.clientTaxAccountNumber.trim().isEmpty()) {
            parameters.put("clientTaxAccountNumber", params.clientTaxAccountNumber)
        }

        if(params.cifLongName != null && !params.cifLongName.trim().isEmpty()) {
            parameters.put("cifLongName", params.cifLongName)
        }

        if(params.cifLongNameB != null && !params.cifLongNameB.trim().isEmpty()) {
            parameters.put("cifLongNameB", params.cifLongNameB)
        }

        def returnValues = coreAPIService.dummySendQuery(parameters, "searchCustomer", "refCustomer/").details

        if (returnValues instanceof List) {
            render (view: "/admin/refCustomer/search", model: [refCustomers:returnValues])
        } else {
            render (view: "/admin/refCustomer/search")
        }
    }

    def view() {

        Map refCustomerDetail



        if(params.u != null && !params.u.trim().isEmpty()) {
            //printlnparams
            refCustomerDetail = coreAPIService.dummySendQuery([:], params.u, "refCustomer/customerDetails/").details
            //println "hello " + refCustomerDetail?.clientType
        }
        if (refCustomerDetail?.clientType.equals('1')) {
            render (view: "/admin/refCustomer/viewIndividual", model: [refCustomer: refCustomerDetail])
        } else {
            render (view: "/admin/refCustomer/viewCorporate", model: [refCustomer: refCustomerDetail])
        }

    }

    def add() {


        redirect (action: "view")
        //render (view: "/admin/user/view", model: [action:"add"])
    }
	
	def addIndividual() {
		//redirect (action: "view")
		//render (view: "/admin/user/view", model: [action:"add"])
		
		String headerTitle="Add Customer: Individual"
		Map refCustomerDetail
		
		if(params.u != null && !params.u.trim().isEmpty()) {
			refCustomerDetail = coreAPIService.dummySendQuery([:], params.u, "refCustomer/customerDetails/").details
		}
		
		render (view: "/admin/refCustomer/viewIndividual", model: [refCustomer: refCustomerDetail, title: headerTitle])

	}
	
	def addCorporate() {
		//redirect (action: "view")
		//render (view: "/admin/user/view", model: [action:"add"])
		
		String headerTitle="Add Customer: Corporate"
		Map refCustomerDetail
		
		if(params.u != null && !params.u.trim().isEmpty()) {
			refCustomerDetail = coreAPIService.dummySendQuery([:], params.u, "refCustomer/customerDetails/").details
		}
		
		render (view: "/admin/refCustomer/viewCorporate", model: [refCustomer: refCustomerDetail, title: headerTitle])
				
	}

    def save() {

        //println"saving\n"

        def returnValue = coreAPIService.dummySendCommand(params, "save", "refCustomer/customerDetails/")

        // Use forward to hide the URL string
        if (returnValue.status == "error") {
            forward (action: "view", params: [error: returnValue.error.description])
        } else {
            if (params.clientType.equals("1")) {
                redirect (action: "addIndividual", params: [u: NumberUtils.wholeNumberFormat(returnValue.details)])
                  //redirect (action: search())
            } else {
               // redirect (action: search())
                println(returnValue)
                redirect (action: "addCorporate", params: [u: NumberUtils.wholeNumberFormat(returnValue.details)])
            }
        }
    }

    def delete() {
        def returnValue = coreAPIService.dummySendCommand(params, "delete", "refCustomer/customerDetails/")

        // Use forward to hide the URL string
        if (returnValue.status == "error") {
            forward (action: "view", params: [error: returnValue.error.description])
        } else {
            if (params.clientType.equals("1")) {
                // redirect (action: "addIndividual", params: [u: NumberUtils.wholeNumberFormat(returnValue.details)])
                redirect (action: search())
            } else {
                redirect (action: search())
                // redirect (action: "addCorporate", params: [u: NumberUtils.wholeNumberFormat(returnValue.details)])
            }
        }


    }
}
