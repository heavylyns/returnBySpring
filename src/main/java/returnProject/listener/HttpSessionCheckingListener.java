package returnProject.listener;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.http.HttpRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;




public class HttpSessionCheckingListener implements HttpSessionListener {
	
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    public void sessionCreated(HttpSessionEvent event) {
    	
    	HttpSession session = event.getSession();
		if(session.isNew()){
//			String sessionId = session.getId();
//			long creationTime = session.getCreationTime();
//			long lastAccessTime = session.getLastAccessedTime();
//			int maxInactiveInterval = session.getMaxInactiveInterval();
//			
//			System.out.println("sessionId : " + sessionId);
//			System.out.println("creationTime : " + creationTime);
//			System.out.println("lastAccessTime : " +  lastAccessTime);
//			System.out.println("maxInactiveInterval : " +  maxInactiveInterval);
//			System.out.println("새로운 세션입니다!!!!!!!!!!!!");
			session.setAttribute("visitorCounterYn", "Y");
		}else{
//			String sessionId = session.getId();
//			long creationTime = session.getCreationTime();
//			long lastAccessTime = session.getLastAccessedTime();
//			int maxInactiveInterval = session.getMaxInactiveInterval();
//			
//			System.out.println("sessionId : " + sessionId);
//			System.out.println("creationTime : " + creationTime);
//			System.out.println("lastAccessTime : " +  lastAccessTime);
//			System.out.println("maxInactiveInterval : " +  maxInactiveInterval);
//			System.out.println(session.getId());
//			System.out.println("새로운 세션 아니다!!!!!!!!!");
			session.setAttribute("visitorCounterYn", "N");
		}
	    // Kill the current session
//	   session.invalidate();
        if (logger.isDebugEnabled()) {
            logger.debug("Session ID".concat(event.getSession().getId()).concat(" created at ").concat(new Date().toString()));
        }
    }
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        if (logger.isDebugEnabled()) {
            logger.debug("Session ID".concat(event.getSession().getId()).concat(" destroyed at ").concat(new Date().toString()));
        }
    }
}