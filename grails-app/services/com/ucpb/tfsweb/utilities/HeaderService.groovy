package com.ucpb.tfsweb.utilities

import org.apache.commons.lang.WordUtils

class HeaderService {
	
	private String HEADER_TITLE = ""
	
	private String REFERENCE_TYPE="" //determine if import is ets or data entry
	private String SERVICE_TYPE = ""
	private String DOCUMENT_TYPE = ""
	private String DOCUMENT_CLASS = ""
	private String SUBTYPE1 = ""
	private String SUBTYPE2 = ""
	
	// evaluate documentType
	String getDocumentType(documentType) {
		if(documentType.equals("FOREIGN")) {
			return "FX"
		} else if(documentType.equals("DOMESTIC")) {
			return "DM"
		} else {
            return ""
        }
	}

	// evaluate subType1
	String getSubType1(subType1) {
		if(subType1.equals("REGULAR")) {
			return "Regular"
		} else if(subType1.equals("CASH")) {
			return "Cash"
		} else if(subType1.equals("STANDBY")) {
			return "Standby"
		} else {
            return ""
        }
	}
	
	// evaluate subType2
	String getSubType2(subType2) {
		if(subType2.equals("USANCE")) {
			return "Usance "
		} else if(subType2.equals("SIGHT")) {
			return "Sight "
		} else {
			return ""
		}
	}
	 
	// constructs ets header title
	String getEtsTitle(documentType, documentClass, subType1, serviceType, subType2) {
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SUBTYPE1 = getSubType1(subType1)
		SUBTYPE2 = ("REGULAR".equals(subType1)) ? getSubType2(subType2) : ""

        if(serviceType.equalsIgnoreCase("ISSUANCE") && documentClass.equalsIgnoreCase("INDEMNITY")) {
            DOCUMENT_CLASS = "LC Indemnity"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_MATURITY_ADJUSTMENT")) {
            SERVICE_TYPE = "UA Loan Maturity Adjustment"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) {
            SERVICE_TYPE = "UA Loan Settlement"
        }

        if(documentClass.equalsIgnoreCase("AP")) {
            if(serviceType.equalsIgnoreCase("REFUND")) {
                SERVICE_TYPE = "Monitoring Refund"
            }
        }

        if(documentClass.equalsIgnoreCase("AR")) {
            if(serviceType.equalsIgnoreCase("SETTLE")) {
                SERVICE_TYPE = "Monitoring Settlement"
            }
        }
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + SUBTYPE1 + " " + SUBTYPE2 + DOCUMENT_CLASS + " " + SERVICE_TYPE + " eTS"
		 
		return HEADER_TITLE
	}
	
	// constructs ets reversal header title
	String getEtsReversalTitle(documentType, documentClass, subType1, serviceType, subType2) {
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SUBTYPE1 = getSubType1(subType1)
		SUBTYPE2 = ("REGULAR".equals(subType1)) ? getSubType2(subType2) : ""

		if(serviceType.equalsIgnoreCase("ISSUANCE") && documentClass.equalsIgnoreCase("INDEMNITY")) {
			DOCUMENT_CLASS = "LC Indemnity"
		}

		if(serviceType.equalsIgnoreCase("UA_LOAN_MATURITY_ADJUSTMENT")) {
			SERVICE_TYPE = "UA Loan Maturity Adjustment"
		}

		if(serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) {
			SERVICE_TYPE = "UA Loan Settlement"
		}

		if(documentClass.equalsIgnoreCase("AP")) {
			if(serviceType.equalsIgnoreCase("REFUND")) {
				SERVICE_TYPE = "Monitoring Refund"
			}
		}

		if(documentClass.equalsIgnoreCase("AR")) {
			if(serviceType.equalsIgnoreCase("SETTLE")) {
				SERVICE_TYPE = "Monitoring Settlement"
			}
		}
		
		HEADER_TITLE = DOCUMENT_TYPE + (SUBTYPE1 ? (" " + SUBTYPE1) : "") + " " + SUBTYPE2 + DOCUMENT_CLASS + " " + SERVICE_TYPE + " eTS - Reversal"
		 
		return HEADER_TITLE
	}
	
	String getNonLcReversalTitle(documentType, documentClass, serviceType, referenceType) {
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SERVICE_TYPE = serviceType
		REFERENCE_TYPE = referenceType
		
		if(referenceType == "ETS") { 
			REFERENCE_TYPE = "eTS"
		} else if(referenceType == "DATA_ENTRY") {
			REFERENCE_TYPE = "Data Entry"
		} else {
			REFERENCE_TYPE = "Payment Processing"
		}
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + DOCUMENT_CLASS + " " + WordUtils.capitalizeFully(SERVICE_TYPE) + " " + REFERENCE_TYPE + " Reversal"
		
		return HEADER_TITLE
	}
	
	
	// constructs data entry header title
	String getDataEntryTitle(documentType, documentClass, subType1, serviceType, subType2) {
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SUBTYPE1 = getSubType1(subType1)
		SUBTYPE2 = ("REGULAR".equals(subType1)) ? getSubType2(subType2) : ""

        if((serviceType.equalsIgnoreCase("CANCELLATION") || serviceType.equalsIgnoreCase("ISSUANCE")) && documentClass.equalsIgnoreCase("INDEMNITY")) {
            DOCUMENT_CLASS = "LC Indemnity"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_MATURITY_ADJUSTMENT")) {
            SERVICE_TYPE = "UA Loan Maturity Adjustment"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) {
            SERVICE_TYPE = "UA Loan Settlement"
        }

        if(documentClass.equalsIgnoreCase("AP")) {
            if(serviceType.equalsIgnoreCase("APPLY")) {
                SERVICE_TYPE = "Monitoring Application"
            }
        }

        if(documentClass.equalsIgnoreCase("AR")) {
            if(serviceType.equalsIgnoreCase("SETTLE")) {
                SERVICE_TYPE = "Monitoring Settlement"
            }
        }

        if(serviceType.equalsIgnoreCase("NEGOTIATION_DISCREPANCY")) {
            SERVICE_TYPE = "Negotiation Discrepancy"
        }
        
        if(serviceType.equalsIgnoreCase("NEGOTIATION_ACKNOWLEDGEMENT")) {
        	SERVICE_TYPE = "Negotiation Acknowledgement"
        }
        
        if(serviceType.equalsIgnoreCase("NEGOTIATION_ACCEPTANCE")) {
        	SERVICE_TYPE = "Negotiation Acceptance"
        }
		
		HEADER_TITLE = DOCUMENT_TYPE + (SUBTYPE1 ? (" " + SUBTYPE1) : "") + " " + SUBTYPE2 + DOCUMENT_CLASS + " " + SERVICE_TYPE + " Data Entry"
		 
		return HEADER_TITLE
	}
	
	// constructs charges header title
	String getChargesTitle(documentType, documentClass, subType1, serviceType, subType2) {
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SUBTYPE1 = getSubType1(subType1)
		SUBTYPE2 = ("REGULAR".equals(subType1)) ? getSubType2(subType2) : ""

        if((serviceType.equalsIgnoreCase("CANCELLATION") || serviceType.equalsIgnoreCase("ISSUANCE")) && documentClass.equalsIgnoreCase("INDEMNITY")) {
            DOCUMENT_CLASS = "LC Indemnity"
        }
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + SUBTYPE1 + " " + SUBTYPE2 + DOCUMENT_CLASS + " " + SERVICE_TYPE + " - Payment Processing"
		 
		return HEADER_TITLE
	}
	
	//construct other imports header title
	String getOtherImportsTitle(referenceType,serviceType,documentType){
		REFERENCE_TYPE=referenceType
		SERVICE_TYPE=serviceType
		DOCUMENT_TYPE=documentType
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + SERVICE_TYPE + " - " + REFERENCE_TYPE
			
		return HEADER_TITLE
	}
	
	//construct other imports header title with static "of"
	String getOtherImportsTitleWithConjunction(referenceType,serviceType,documentType){
		REFERENCE_TYPE=referenceType
		SERVICE_TYPE=serviceType
		DOCUMENT_TYPE=documentType
		
		HEADER_TITLE = DOCUMENT_TYPE + " of " + SERVICE_TYPE + " - " + referenceType == "DATA_ENTRY" ? "Data Entry" : "eTS"
			
		return HEADER_TITLE
	}
	
	//constructs exports core header title with static "Bills for"
	String getExportsCoreTitle(documentType,documentClass,serviceType,referenceType){
		DOCUMENT_TYPE = documentType
		DOCUMENT_CLASS = documentClass
		SERVICE_TYPE = serviceType
		REFERENCE_TYPE = referenceType

		HEADER_TITLE = DOCUMENT_TYPE + " Bills for " + DOCUMENT_CLASS + " - " + SERVICE_TYPE + " (" + REFERENCE_TYPE + ")"
		
		return HEADER_TITLE
	}
	
	//constructs other exports header title
	String getOtherExportsTitle(referenceType,serviceType){
		REFERENCE_TYPE= referenceType
		SERVICE_TYPE= serviceType
		if ( serviceType == 'Opening' || serviceType == 'Amendment' || serviceType == 'Cancellation' || referenceType == 'Payment Processing'){
			HEADER_TITLE = "Advising Bank - " + SERVICE_TYPE + " - " + REFERENCE_TYPE
		}else if(REFERENCE_TYPE.equalsIgnoreCase('inquiry')){
			HEADER_TITLE =   SERVICE_TYPE  +  " - " + REFERENCE_TYPE
		}else{
			HEADER_TITLE = SERVICE_TYPE + " - " + REFERENCE_TYPE
		}
		return HEADER_TITLE
	}
	
	// constructs other exports inquiry header title
	String getOtherExportsInquiryTitle(referenceType, serviceType, documentType){
		REFERENCE_TYPE = referenceType
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = documentType
		if (serviceType == 'Processing' || serviceType == 'Refund'){
			HEADER_TITLE = SERVICE_TYPE + ' of ' + DOCUMENT_TYPE + ' - ' + REFERENCE_TYPE
		}else{
			HEADER_TITLE = DOCUMENT_TYPE + ' ' +  SERVICE_TYPE + ' - ' + REFERENCE_TYPE
		}
		return HEADER_TITLE
	}
	
	//constructs non lc ets header title with static "Non-LC" text
	String getNonLcEtsTitle(documentType, documentClass, serviceType, referenceType) {
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SERVICE_TYPE = serviceType
		REFERENCE_TYPE = referenceType
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + DOCUMENT_CLASS + " " + SERVICE_TYPE + " Non-LC - " + REFERENCE_TYPE
		 
		return HEADER_TITLE
	}
	
	//constructs non lc data entry header title with static "Non-LC" text
	String getNonLcDataEntryTitle(documentType, documentClass, serviceType, referenceType) {
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SERVICE_TYPE = serviceType
		REFERENCE_TYPE = referenceType
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + DOCUMENT_CLASS + " " + SERVICE_TYPE + " Non-LC - " + REFERENCE_TYPE
		 
		return HEADER_TITLE
	}
	
	//constructs non lc payment header title with static "Non-LC" text
	String getNonLcPaymentTitle(documentType, documentClass, serviceType, referenceType) {
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		SERVICE_TYPE = serviceType
		REFERENCE_TYPE = referenceType
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + DOCUMENT_CLASS + " " + SERVICE_TYPE + " Non-LC - " + REFERENCE_TYPE
		 
		return HEADER_TITLE
	}
}

/*package com.ucpb.tfsweb.utilities

*//**
 *
 * @author Marvin Volante <marvin.volante@incuventure.net>
 *
 *//*

class HeaderService {
	
	private String HEADER_TITLE = ""
	
	private String IMPORT_TYPE="" //determine if import is ets or data entry
	private String SERVICE_TYPE = ""
	private String DOCUMENT_TYPE = ""
	private String DOCUMENT_CLASS = ""
	private String DOCUMENTSUBTYPE1 = ""
    
    // evaluate documentType
	String getDocumentType(documentType) {
		if(documentType.equalsIgnoreCase("FOREIGN")) {
			return "FX"
		} else if(documentType.equalsIgnoreCase("DOMESTIC")) {
			return "DM"
		} else {
            return ""
        }
	}

    // evaluate documentSubType1
	String getSubType1(documentSubType1) {
		if(documentSubType1.equalsIgnoreCase("REGULAR")) {
			return "Regular"
		} else if(documentSubType1.equalsIgnoreCase("CASH")) {
			return "Cash"
		} else if(documentSubType1.equalsIgnoreCase("STANDBY")) {
			return "Standby"
		} else {
            return ""
        }
	}
	 
	// constructs ets header title
    String getEtsTitle(documentType, documentClass, documentSubType1, serviceType) {
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		DOCUMENTSUBTYPE1 = getSubType1(documentSubType1)

        if(serviceType.equalsIgnoreCase("ISSUANCE") && documentClass.equalsIgnoreCase("INDEMNITY")) {
            DOCUMENT_CLASS = "LC Indemnity"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_MATURITY_ADJUSTMENT")) {
            SERVICE_TYPE = "UA Loan Maturity Adjustment"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) {
            SERVICE_TYPE = "UA Loan Settlement"
        }

        if(documentClass.equalsIgnoreCase("AP")) {
            if(serviceType.equalsIgnoreCase("REFUND")) {
                SERVICE_TYPE = "Monitoring Refund"
            }
        }

        if(documentClass.equalsIgnoreCase("AR")) {
            if(serviceType.equalsIgnoreCase("SETTLE")) {
                SERVICE_TYPE = "Monitoring Settlement"
            }
        }

		HEADER_TITLE = DOCUMENT_TYPE + " " + DOCUMENTSUBTYPE1 + " " + DOCUMENT_CLASS + " " + SERVICE_TYPE + " eTS"
		 
		return HEADER_TITLE
    }
	
	// constructs data entry header title
	String getDataEntryTitle(documentType, documentClass, documentSubType1, serviceType) {
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		DOCUMENTSUBTYPE1 = getSubType1(documentSubType1)

        if((serviceType.equalsIgnoreCase("CANCELLATION") || serviceType.equalsIgnoreCase("ISSUANCE")) && documentClass.equalsIgnoreCase("INDEMNITY")) {
            DOCUMENT_CLASS = "LC Indemnity"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_MATURITY_ADJUSTMENT")) {
            SERVICE_TYPE = "UA Loan Maturity Adjustment"
        }

        if(serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) {
            SERVICE_TYPE = "UA Loan Settlement"
        }

        if(documentClass.equalsIgnoreCase("AP")) {
            if(serviceType.equalsIgnoreCase("APPLY")) {
                SERVICE_TYPE = "Monitoring Application"
            }
        }

		HEADER_TITLE = DOCUMENT_TYPE + " " + DOCUMENTSUBTYPE1 + " " + DOCUMENT_CLASS + " " + SERVICE_TYPE + " Data Entry"
		 
		return HEADER_TITLE
	}
	
	// constructs charges header title
	String getChargesTitle(documentType, documentClass, documentSubType1, serviceType) {
		SERVICE_TYPE = serviceType
		DOCUMENT_TYPE = getDocumentType(documentType)
		DOCUMENT_CLASS = documentClass
		DOCUMENTSUBTYPE1 = getSubType1(documentSubType1)

        if((serviceType.equalsIgnoreCase("CANCELLATION") || serviceType.equalsIgnoreCase("ISSUANCE")) && documentClass.equalsIgnoreCase("INDEMNITY")) {
            DOCUMENT_CLASS = "LC Indemnity"
        }
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + DOCUMENTSUBTYPE1 + " " + DOCUMENT_CLASS + " " + SERVICE_TYPE + " - Payment Processing"
		 
		return HEADER_TITLE
	}

    //construct other imports header title
	String getOtherImportsTitle(importType,serviceType,documentType){
		IMPORT_TYPE=importType
		SERVICE_TYPE=serviceType
		DOCUMENT_TYPE=documentType
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + SERVICE_TYPE + " - " + IMPORT_TYPE
			
		return HEADER_TITLE
	}
	
	//construct other imports header title with static "of"
	String getOtherImportsTitleWithConjunction(importType,serviceType,documentType){
		IMPORT_TYPE=importType
		SERVICE_TYPE=serviceType
		DOCUMENT_TYPE=documentType
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + "of" + " " + SERVICE_TYPE + " - " + IMPORT_TYPE
			
		return HEADER_TITLE
	}
	
	//construct other imports header title with static "&"
	String getOtherImportsTitleWithConjunctionAmp(importType,serviceType,documentType){
		IMPORT_TYPE=importType
		SERVICE_TYPE=serviceType
		DOCUMENT_TYPE=documentType
		
		HEADER_TITLE = DOCUMENT_TYPE + " " + "&" + " " + SERVICE_TYPE + " - " + IMPORT_TYPE
			
		return HEADER_TITLE
	}
}*/