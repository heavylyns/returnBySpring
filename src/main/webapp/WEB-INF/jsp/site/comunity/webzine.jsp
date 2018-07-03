<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">웹진</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
    </div>
    <div class="webzinewrap">
        <div class="incontainer">
            <div class="webzine-slidewrap">
                <div class="slidebox webzineslidejs webzineslide">
                    <button type="button"  class="bas-prev"><span class="screen_out">이전</span></button>
                    <div class="basicslide">
                        <div class="basicslide-container">
                            <ul class="slide">
                            	<c:forEach var="result" items="${resultList}">
	                                <li><a href="<c:url value="${result.link}"/>" target="${result.target}"><img src="/cmm/fms/getImage.do?atchFileId=${result.atch_file_id}&fileSn=${result.file_sn}" alt="${result.contents}" width="1010px" height="608px"/></a></li>
                            	</c:forEach>
                            </ul>
                        </div>
                    </div>
                    <button type="button" class="bas-next"><span class="screen_out">다음</span></button>
                </div>
            </div>
        </div>
    </div>
