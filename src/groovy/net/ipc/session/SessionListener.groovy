package net.ipc.session

import javax.servlet.http.HttpSession
import javax.servlet.http.HttpSessionEvent
import javax.servlet.http.HttpSessionListener

import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes
import org.springframework.context.ApplicationContext

import com.ucpb.tfsweb.utilities.CoreAPIService

/**
 * User: IPCVal
 */
public class SessionListener implements HttpSessionListener {


    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {

        HttpSession httpSession = httpSessionEvent.getSession();

        if (httpSession.getAttribute("username") != null) {

            System.out.println("SESSION IS ABOUT TO BE DESTROYED!");

            String username = httpSession.getAttribute("username");
            System.out.println("username = " + username);
            System.out.println("Removing login from db...");
			
			httpSession.removeAttribute("user");
			
            // Remove login from db
            Map params = [u: username]

            // ServletContext context = httpSession.getServletContext();
            // GrailsApplication application = GrailsWebUtil.lookupApplication(context);
            // ((CoreAPIService)application.getMainContext().getBean("coreAPIService")).dummySendCommand(params, "removeLogIn", "security");

            ApplicationContext ctx = (ApplicationContext)ServletContextHolder.getServletContext().getAttribute(GrailsApplicationAttributes.APPLICATION_CONTEXT);
            CoreAPIService coreAPIService = (CoreAPIService)ctx.getBean("coreAPIService");
            coreAPIService.dummySendCommand(params, "removeLogIn", "security")
        }
    }
}
