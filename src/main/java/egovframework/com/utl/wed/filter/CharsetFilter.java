package egovframework.com.utl.wed.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;



public class CharsetFilter implements Filter{
	private String charset;
	public void init( FilterConfig config ) throws ServletException {
		this.charset = config.getInitParameter("charset");
	} 

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		//if (request.getCharacterEncoding() == null) {
			request.setCharacterEncoding(charset);
			chain.doFilter(request, response);
		//}
		
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	
}