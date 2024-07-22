package com.ucpb.tfsweb.main

import com.ucpb.tfsweb.utilities.CommandService
import grails.converters.JSON
import net.ipc.utils.DateUtils
import org.springframework.util.StringUtils
import java.text.SimpleDateFormat

class PaymentController {

    private static final String LOAN_STATUS = "TRSTS"
    private static final String SUCCESS = "Y"
    private static final String FAILED = "N"
    private static final String APPROVED = "APPROVED"
    private static final String REJECTED = "REJECTED"
    private static final String PROCESSING = "PROCESSING"
    private static final String LOAN_SEQUENCE_NUMBER = "TRSEQ"
    private static final String PN_NUMBER = "ACCTNO"
    private static final String UNLINK = "TRUNLINK"

    def securityService

    def CommandService commandService;
    def chargesService;
    def loanService;
    def dataEntryService;
    def coreAPIService;
    def paymentService;
    def authenticationService;


    def index() { }

    def createLoan(){
        def jsonData = [success:true]
        println params
        String token = commandService.createAndDispatch("createLoan",session.username,params);
        render jsonData as JSON
    }

//    def updateLoan(){
//        def jsonData = [success:true]
//        commandService.createAndDispatch("updateLoan",session.username,params);
//        render jsonData as JSON;
//    }

    def getLoanApplicationErrors(){
        def errors = coreAPIService.dummySendCommand(params,"getLoanErrors","payment")?.errors;
        def model = [errors : errors];
        render (view : "/commons/popups/_loan_errors_popup",model : model);
    }

    def getLoanStatus(){
        def loanRequestDetails = coreAPIService.dummySendCommand(params,"getLoanStatus","payment");
        println loanRequestDetails;
        if(true == loanRequestDetails?.success){
            render loanRequestDetails as JSON;
        }else{
            render (view : "/commons/popups/_loan_errors_popup",model : [errors : loanRequestDetails?.errors]);
        }
    }

    def inquireLoanStatus(){
        def jsonData = [success:"FALSE"];
        Map<String,Object> tradeService = dataEntryService.getDataEntry(params.tradeServiceId);
        Map<String,Object> loan = loanService.getLoan(tradeService?.documentNumber);
        if(loan != null){
            if (SUCCESS.equals(loan.get(LOAN_STATUS))){
                jsonData.success = APPROVED;
                jsonData.status = "U".equals(loan.get(UNLINK)) ? "REVERSED" : "PAID";
                jsonData.pnNumber = loan.get(PN_NUMBER)?.toString();
                params.status = "U".equals(loan.get(UNLINK)) ? "REVERSED" : "PAID";
                params.pnNumber = loan.get(PN_NUMBER)?.toString();
                commandService.createAndDispatch("updateLoan",session.username,params);
            }else if (FAILED.equals(loan.get(LOAN_STATUS))){
                jsonData.success = REJECTED;
                params.status = "REJECTED";
                params.sequenceNumber = loan.get(LOAN_SEQUENCE_NUMBER);
                commandService.createAndDispatch("updateLoan",session.username,params);
            }else if(!StringUtils.hasText(loan.get(LOAN_STATUS))){
                jsonData.success = PROCESSING;
            }
            jsonData.sequenceNumber = loan.get(LOAN_SEQUENCE_NUMBER);
        }
        render jsonData as JSON;
    }

    def reverseLoan(){
        def jsonData = [success:false]
        if (loanService.reverseLoan(Long.valueOf(params.pnNumber))){
            commandService.createAndDispatch("updateLoan",session.username,params);
            jsonData = [success:true]
        }
        render jsonData as JSON;
    }

    def payItem() {
//        def jsonData = paymentService.payItem((session?.chargesModel?.tradeServiceId ?: session?.dataEntryModel?.tradeServiceId),
//                params.paymentDetailId,session?.username,(params.supervisorId ?: session.username));

        def jsonData = paymentService.payItem((session?.chargesModel?.tradeServiceId ?: session?.dataEntryModel?.tradeServiceId),
                params.paymentDetailId,session?.username, params.supervisorId, params.referenceId);

        println 'jsonData ' + jsonData
        if (jsonData.paymentReferenceNumber) {
            if (session.model && "CDT".equals(session.model.documentClass) && "PAYMENT".equals(session.model.serviceType)) {
                session.model?.paymentReferenceNumber = jsonData.paymentReferenceNumber
            }
        } else {
            if (session.model && "CDT".equals(session.model.documentClass) && "PAYMENT".equals(session.model.serviceType)) {
                session.model.remove("paymentReferenceNumber")
            }
        }

        render jsonData as JSON
    }



    def reversePayment() {
        def jsonData = paymentService.reversePayment(params.paymentDetailId,
                session?.username,
                params.reversalDENumber,
                params.supervisorId);

        if (session.model && "CDT".equals(session.model.documentClass) && "PAYMENT".equals(session.model.serviceType)) {
            session.model.remove("paymentReferenceNumber")
        }

        render jsonData as JSON;
    }

    def errorCorrectPayment() {
        def jsonData = [:]

        try {
            chargesService.undoPayment(params)

            jsonData = [success:true]

            render jsonData as JSON
        } catch(Exception e) {
            //System.out.println("***** ERROR " + e);
            jsonData = [success: false]

            render jsonData as JSON
        }
    }
	
	def errorCorrectTfsPayment() {
		def jsonData = paymentService.errorCorrectTfsPayment(params.paymentDetailId,
				session?.username,
				params.reversalDENumber);
		
		render jsonData as JSON;
	}

    def validateCasaTransactionAmount(){
        BigDecimal amount = new BigDecimal(params?.amount?.replaceAll(",","") ?: params?.amountSettlement?.replaceAll(",",""));
//        def result = paymentService.validateCasaTransactionAmount(session.unitcode,params.currency,amount);
        def result = paymentService.validateCasaTransactionAmount(session.username, params.currency, amount);
        println "result " + result
        render result as JSON;
    }

    def loginOfficer(){
        Map authparams = [ldapDomain: securityService.getLdapDomain(session.unitcode), u: params.username, p: params.password]
        def returnValue2 = coreAPIService.dummySendCommand(authparams, "authenticate", "security")

        def error

        if(returnValue2.details?.authenticated == true) {
            if (session.username.equals(params.username)) {
                error = "Cannot override self."
            } else {
                if (!returnValue2.details?.employee?.unitCode.equals(session.unitcode)) {
                    error = "Officer unit code must match user unit code"
                } else {
                    returnValue2.details?.roles.each () { role ->

                        if ("TSD".equals(session.group)) {
                            println "i am tsd"
                            if("TSDO".equals(role.roleId?.roleId) || "TSDO".equals(role.parentRoleId?.roleId)){
                                render ([success : true] as JSON);
                                return;
                            } else {
                                error = ""
                            }
                        }

                        if ("BRANCH".equals(session.group)) {
                            println "i am branch"
                            if("BRO".equals(role.roleId?.roleId) || "BRO".equals(role.parentRoleId?.roleId)){
                                render ([success : true] as JSON);
                                return;
                            }
                        }
                    }
                }
            }
        } else {
            error = "Incorrect username and/or password."
        }

        render ([success : false, error: error] as JSON);
    }

    def calculateLoanMaturityDate(){
        def result = [maturityDate: params.valueDate ?: DateUtils.shortDateFormat(new Date())]

        if (!params.loanTerm.equals('NaN')) {
            int loanTerm = Integer.valueOf(params.loanTerm);
            Calendar cal = Calendar.getInstance();
			if(params.valueDate){
				cal.setTime(new SimpleDateFormat("MM/dd/yyyy").parse(params.valueDate))
			}
            if ("M".equalsIgnoreCase(params.loanTermCode)){
                cal.add(Calendar.MONTH,loanTerm);
            }else if("D".equalsIgnoreCase(params.loanTermCode)){
                cal.add(Calendar.DATE,loanTerm);
            }

            result = [maturityDate : new SimpleDateFormat("MM/dd/yyyy").format(cal.getTime())];
        }



        render result as JSON;
    }

}
