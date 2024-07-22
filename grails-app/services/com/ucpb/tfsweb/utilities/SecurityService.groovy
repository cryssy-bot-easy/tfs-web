package com.ucpb.tfsweb.utilities

class SecurityService {

    public String getLdapDomain(String unitCode) {
        if ("909".equals(unitCode)) {
            return "UCPB8";
        }

        return "BRANCH";
    }
}
