package com.ucpb.tfsweb.main

import net.ipc.utils.DateUtils

/**
	 (revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick Nungay
	[Date deployed:] 10/23/2017
	Program [Revision] Details: Added parameters full name and email on re-sending email
	PROJECT: CORE
	MEMBER TYPE  : Groovy

*/
class CdtService {
	def coreAPIService
	
    def computeCollectionDate(Date remittanceDate, String reportType) {
        Calendar calendar = Calendar.getInstance()
        calendar.setTime(remittanceDate)

        switch (reportType) {
            case "IPF":
            case "EXPORT_CHARGES":
            case "IPF_EXPORT_CHARGES":
                return computeIpfExportsDate(calendar)

            case "FINAL_CDT":
            case "ADVANCE_CDT":
            case "FINAL_ADVANCE_CDT":
                return computeFinalAdvanceDate(calendar)

            case "ALL":
                return computeAllDate(calendar)
        }
    }

    def computeIpfExportsDate(Calendar calendar) {
        int count = 0

        while (count < 5) {
            calendar.add(Calendar.DAY_OF_YEAR, -1)

            if (DateUtils.isWeekday(calendar.get(Calendar.DAY_OF_WEEK))) {
                ++count
            }
        }

        if (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.MONDAY) {
            int daysBeforeMonday = (calendar.get(Calendar.DAY_OF_WEEK) - Calendar.MONDAY)
            daysBeforeMonday = -daysBeforeMonday

            calendar.add(Calendar.DAY_OF_WEEK, daysBeforeMonday)
        }

        Date collectionDateFrom = calendar.getTime()

        calendar.add(Calendar.DAY_OF_WEEK, 4)

        Date collectionDateTo = calendar.getTime()

        return [from: collectionDateFrom, to: collectionDateTo]
    }

    def computeFinalAdvanceDate(Calendar calendar) {
        int count = 0

        while (count < 10) {
            calendar.add(Calendar.DAY_OF_YEAR, -1)

            if (DateUtils.isWeekday(calendar.get(Calendar.DAY_OF_WEEK))) {
                ++count
            }
        }

        Date collectionDate = calendar.getTime()

        return [from: collectionDate, to: collectionDate]
    }

    def computeAllDate(Calendar calendar) {
        int remittanceDateDayOfMonth = calendar.get(Calendar.DAY_OF_MONTH)

        Date collectionDate

        if (remittanceDateDayOfMonth == 1) {
            calendar.add(Calendar.MONTH, -1)
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))

            collectionDate = calendar.getTime()
        } else if (remittanceDateDayOfMonth == calendar.getActualMaximum(Calendar.DAY_OF_MONTH)) {
            calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))

            collectionDate = calendar.getTime()
        }

        return [from: collectionDate, to: collectionDate]
    }
	
	def getDetailsByIedierdNumber(iedieirdNumbers, fullName, email) {
		def queryResult = coreAPIService.dummySendQuery([iedieirdNumber: iedieirdNumbers, fullName: fullName, email: email], "cdt/payment/resendEmail")?.details
		
		return queryResult
	}

}
