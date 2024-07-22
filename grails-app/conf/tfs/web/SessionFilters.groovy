package tfs.web

import net.ipc.utils.DateUtils;
/**
 * User: Marv
 * Date: 08/12/12
 */

/**
 * PROLOGUE
 * SCR/ER Description: redmine 4221 - EBP Nego, EBP Settlement - testing of IDLE time
 *	[Revised by:] Jesse James Joson
 *	[Date revised:] 5/10/2016
 *	Program [Revision] Details: to add datetime parameter for validation if 15 mins. is already reached.
 *	Date deployment: 6/16/2016 
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: SessionFilters.groovy 
*/
class SessionFilters {

    def filters = {

        // handles session timeout
        // all(controller:'*', action:'*view*|*save*|*update*|*upload*') {

        all(controller:'*', action:'*') {

            before = {

                println "your current controller is: " + params.controller
                println "your current action is: " + actionName

                def included = true
                if (params.controller == 'login') {
                    included = false
                } else if (params.controller == 'batch' && !actionName.equals('index')) {
                    included = false
                }

                if (included) {

//                // clears model based on current controller
					
					session['lastTimeUsed'] = DateUtils.dateTimeFormat2(new Date());
					
                    if(params.controller.contains("Ets")) {
                        session.removeAttribute("dataEntryModel")
                        session.removeAttribute("chargesModel")
                    } else if(params.controller.contains("DataEntry")) {
                        session.removeAttribute("etsModel")
                        session.removeAttribute("chargesModel")
                    } else if(!params.controller.contains("import") && params.controller.contains("Charges") && !params.controller.contains("other") && !params.controller.contains("export")) {
                        session.removeAttribute("etsModel")
                        session.removeAttribute("dataEntryModel")
                    }

//                println "etsModel >> " + session.etsModel
//                println "dataEntryModel >> " + session.dataEntryModel
//                println "chargesModel >> " + session.chargesModel

                    if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {

                        // makes sure session is cleared
                        session.invalidate()

                        flash.message = "Your current login session has expired."

                        // Use redirect here, as it is difficult to forward from a filter
                        // Anyway, this case should happen very rarely
                        redirect(controller: "login", action: "index")

                        return false
                    }
                }
            }
        }
    }
}
