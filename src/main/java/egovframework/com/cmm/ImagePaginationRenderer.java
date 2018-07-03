package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public ImagePaginationRenderer() {

	}

	public void initVariables(){
		/* 기존 페이징
		firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_prevend.gif\" alt=\"처음\"   border=\"0\"/></a>&#160;";
        previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_prev.gif\"    alt=\"이전\"   border=\"0\"/></a>&#160;";
        currentPageLabel  = "<strong>{0}</strong>&#160;";
        otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a>&#160;";
        nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_next.gif\"    alt=\"다음\"   border=\"0\"/></a>&#160;";
        lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><img src=\"" + servletContext.getContextPath() +  "/images/egovframework/com/cmm/icon/icon_nextend.gif\" alt=\"마지막\" border=\"0\"/></a>&#160;";
        */

		firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pager-first\"><span class=\"screen_out\">처음</span></a>&#160;";
        previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pager-prev\"><span class=\"screen_out\">이전</span></a>&#160;";
        currentPageLabel  = "<a href=\"#\" class=\"current\"><span class=\"screen_out\">현재 페이지</span>{0}</a>&#160;";
        otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" >{2}</a>&#160;";
        nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pager-next\"><span class=\"screen_out\">다음</span></a>&#160;";
        lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \" class=\"pager-last\"><span class=\"screen_out\">마지막</span></a>&#160;";
        
        
	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
