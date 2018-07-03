package returnProject.site.intro.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/site/intro")
public class IntroController {
	
	/**
	 * 센터소개 > 인사말
	 */
	@RequestMapping(value = "/greeting.do")
	public String greeting(HttpServletRequest request){
		
		return "/site/intro/greeting";
	}
	
	/**
	 * 센터소개 > 센터안내
	 */
	@RequestMapping(value = "/introduce.do")
	public String introduce(HttpServletRequest request){
		
		return "/site/intro/introduce";
	}
	
	/**
	 * 센터소개 > 오시는길
	 */
	@RequestMapping(value = "/directions.do")
	public String directions(HttpServletRequest request){
		
		return "/site/intro/directions";
	}
}
