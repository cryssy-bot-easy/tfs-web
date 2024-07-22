function convertToFieldId(fieldId){

    if (fieldId.toLowerCase()== "bankcommission" ) {
        return "BC"
    } else if (fieldId.toLowerCase() == "confirmingfee" ) {
        return "CORRES-CONFIRMING"
    } else if (fieldId.toLowerCase() == "commitmentfee") {
        return "CF"
    } else if (fieldId.toLowerCase() == "suppliesfee" ) {
        return "SUP"
    } else if (fieldId.toLowerCase() == "cablefee" ) {
        return "CABLE"
    } else if (fieldId.toLowerCase() == "cilexfee") {
        return "CILEX"
    } else if (fieldId.toLowerCase() == "advisingfee" ) {
        return "CORRES-ADVISING"
    } else if (fieldId.toLowerCase() == "documentarystamp" ) {
        return "DOCSTAMPS"
    } else if (fieldId.toLowerCase() == "notarialfee" ) {
        return "NOTARIAL"
    } else if (fieldId.toLowerCase() == "bspfee" ) {
        return "BSP"
    } else if (fieldId.toLowerCase() == "bookingcommission" ) {
        return "BOOKING"
    } else if (fieldId.toLowerCase() == "remittancefee" ) {
        return "REMITTANCE"
    } else if (fieldId.toLowerCase() == "exportsadvisingfee" ) {
        return "ADVISING-EXPORT"
    } else if (fieldId.toLowerCase() == "otherlocalbankcharges" ) {
        return "OTHER-EXPORT"
    } else if (fieldId.toLowerCase() == "cancellationfee" ) {
        return "CANCEL"
    } else if (fieldId.toLowerCase() == "postagefee" ) {
        return "POSTAGE"
    } else if (fieldId.toLowerCase() == "corresexportcharge" ) {
    	return "CORRES-EXPORT"
    }

}