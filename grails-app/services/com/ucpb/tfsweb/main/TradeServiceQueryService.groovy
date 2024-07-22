package com.ucpb.tfsweb.main

import com.google.gson.Gson
import com.google.gson.reflect.TypeToken

/**
 */
class TradeServiceQueryService {

    private static final String FIND_TRADE_SERVICE = "findTradeService"
    private static final String GET_APPROVED_AMENDMENTS = "getApprovedAmmendments"
    def queryService
    def finder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class


    public Map<String,Object> getTradeServiceDetails(String tradeServiceId){
        List<Map<String, Object>> tradeService = queryService.executeQuery(finder, FIND_TRADE_SERVICE, [tradeServiceId: tradeServiceId]);
        if(!tradeService.isEmpty()){
            String details = tradeService.get(0).get("DETAILS");
            return new Gson().fromJson(details, new TypeToken<Map<String,Object>>() {}.getType());
        }
        return null;
    }

    public long getApprovedAmmentments(String documentNumber){
        List<Map<String, Object>> tradeService = queryService.executeQuery(finder, GET_APPROVED_AMENDMENTS, [documentNumber: documentNumber]);
        if(!tradeService.isEmpty()){
            return Long.valueOf(tradeService.get(0));
        }
        return 0;
    }
}
