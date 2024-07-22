package com.ucpb.tfsweb.main

import org.springframework.util.Assert

/**
 */
class LoanService {

    def queryService

    def loanInterfaceService = com.ucpb.tfs.application.query.interfaces.LoanService.class;

    def Map<String,Object> getLoan(String documentNumber){
        Assert.isTrue(documentNumber != null, "Document number must not be null!");
        String parsedDocNumber = documentNumber?.replace("-","");
        List<Map<String, Object>> queryResult = queryService.executeQuery(loanInterfaceService, "getLoanDetails", [documentNumber : parsedDocNumber]);
        if(queryResult != null && !queryResult.isEmpty()){
            return queryResult.get(0);
        }
        return null;
    }

    def boolean reverseLoan(Long accountNumber){
        List<Map<String, Object>> queryResult = queryService.executeQuery(loanInterfaceService, "reverseLoan", [accountNumber : accountNumber]);
        if(queryResult != null && !queryResult.isEmpty()){
            return queryResult.get(0);
        }
        return false;
    }

    def List<Map<String,Object>> getLoanErrors(Long transactionSequenceNumber){
        return queryService.executeQuery(loanInterfaceService, "getLoanErrorRecord", [sequenceNumber : transactionSequenceNumber]);
    }





}
