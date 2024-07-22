package com.ucpb.tfsweb.main

class ServiceInstructionService {

    Map<String, Object> constructServiceAvailable(documentClass, documentMap, accessFrom) {
        String tradeServiceId = documentMap.get("tradeServiceId")
        String documentType = documentMap.get("documentType")
        String documentSubType1 = documentMap.get("documentSubType1")
        String documentSubType2 = documentMap.get("documentSubType2")
        String documentNumber = documentMap.get("documentNumber")
        String productAmount = documentMap.get("productAmount")
        String productStatus = documentMap.get("productStatus")
        String outstandingBalance = documentMap.get("outstandingBalance")
        Integer bgCount = documentMap.get("bgCount")
        Integer icCount = documentMap.get("icCount")
        
        ////println"CRITERIAS:"
        ////println"tradeServiceId = " + documentMap.get("tradeServiceId")
        ////println"documentClass = " + documentMap.get("documentClass")
        ////println"documentType = " + documentMap.get("documentType")
        ////println"documentSubType1 = " + documentMap.get("documentSubType1")
        ////println"documentSubType2 = " + documentMap.get("documentSubType2")
        ////println"documentNumber = " + documentMap.get("documentNumber")
        ////println"productAmount = " + documentMap.get("productAmount")
        ////println"productStatus = " + documentMap.get("productStatus")
        ////println"outstandingBalance = " + documentMap.get("outstandingBalance")
        ////println"bgCount = " + documentMap.get("bgCount")

        Map<String, String> services = new HashMap<String, String>()
        if(!accessFrom.equals("tsd")) {
            services.put("negotiation", "Negotiation")
//            services.put("indemnityIssuance", "Indemnity Issuance")
            services.put("indemnityIssuance", "BG/BE Issuance")
            services.put("cancellation", "Cancellation")
        }  else{
//            if(!documentSubType1.equalsIgnoreCase("STANDBY")) {
                services.put("negotiationDiscrepancy", "Negotiation Discrepancy")
//            } 
        } 
		if(documentSubType1 == 'STANDBY' || (documentSubType1 in ['CASH', 'REGULAR'] && !accessFrom.equals("tsd"))){
			services.put("adjustment", "Adjustment")
		}
        services.put("amendment", "Amendment")
//		services.put("negotiationDiscrepancy", "Negotiation Discrepancy") //Added March 23, 2013 (via Joey), Removed April 02, 2013 (via Joey)

        switch (documentClass) {
            case "LC":
                switch (documentType) {
                    case "DOMESTIC":
						services.remove("indemnityIssuance")
                    case "FOREIGN":
                        switch (documentSubType1) {
                            case "CASH":
                            case "REGULAR":
                                if(productStatus == "CANCELLED") {
                                    services.remove("indemnityIssuance")
                                    services.remove("adjustment")
                                    services.remove("amendment")
                                }
                                if(productStatus == "CLOSED") {
                                    services.remove("indemnityIssuance")
                                    services.remove("adjustment")
                                    services.remove("negotiation")
                                    services.remove("cancellation")
                                }
                                if(productStatus == "EXPIRED") {
                                    if (new BigDecimal(outstandingBalance) <= 0) {
                                        services.remove("indemnityIssuance")
                                        services.remove("negotiation")
                                    }
									if (new BigDecimal(icCount) > 0 && !accessFrom.equals("tsd")) {
										services.put("negotiation", "Negotiation")
									}
                                    services.remove("cancellation")
                                }
                                /*if(bgCount > 0) {
                                	services.remove("cancellation")
                                }*/
							break;
							case "STANDBY":
								services.remove("indemnityIssuance")
								services.remove("negotiationDiscrepancy")
								if(productStatus == "CLOSED") {
									services.remove("adjustment")
									services.remove("negotiation")
									services.remove("cancellation")
								} else if(productStatus == "EXPIRED") {
									services.remove("cancellation")
								}
							break;
                        }
                }
        }

        return services
    }
}
