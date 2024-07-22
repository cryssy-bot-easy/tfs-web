package net.ipc.session;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.commons.lang.StringUtils;
import org.codehaus.groovy.grails.web.context.ServletContextHolder;
import org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes;
import org.springframework.context.ApplicationContext;

import com.ucpb.tfsweb.utilities.CoreAPIService;

public class UserSession implements Serializable, HttpSessionBindingListener {
	
	private static final long serialVersionUID = 3720922414597807221L;

	private static Map<UserSession, HttpSession> logins = new HashMap<UserSession, HttpSession>();
	
	private String username;
	
	private String ip;
	
	public UserSession() { }
	
	public UserSession(String username) {
		setUsername(username);
	}
	
	public UserSession(String username, String ip) {
		setUsername(username);
		setIp(ip);
	}
	
	public static boolean loggedIn(UserSession userSession) {
		if(logins.get(userSession) != null) return true;
		
		return false;
	}
	
	public static UserSession getUserSession(String username) {
		
		if(StringUtils.isEmpty(username)) return null;
		
		UserSession userSession = new UserSession(username);
		for(UserSession userSessionKey : logins.keySet()) {
			if(userSessionKey.equals(userSession)) return userSessionKey;
		}
		
		return null;
		
	}
	
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		System.out.println("Adding " + this.username + " with IP " + this.ip + " to session logins");
		logins.put(this, event.getSession());
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		System.out.println("Removing " + this.username + " with IP " + this.ip + " from session logins");
		
		String referrer = (String) event.getSession().getAttribute("referrer");
        if (referrer == null) {
            referrer = "sessionListener";
        }
        
		Map<String, String> params = new HashMap<String, String>();
		params.put("u", this.username);
		params.put("referrer", referrer);
		
		ApplicationContext ctx = (ApplicationContext)ServletContextHolder.getServletContext().getAttribute(GrailsApplicationAttributes.APPLICATION_CONTEXT);
        CoreAPIService coreAPIService = (CoreAPIService)ctx.getBean("coreAPIService");
        coreAPIService.dummySendCommand(params, "removeLogIn", "security");
		
		logins.remove(this);
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserSession other = (UserSession) obj;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}
	
}