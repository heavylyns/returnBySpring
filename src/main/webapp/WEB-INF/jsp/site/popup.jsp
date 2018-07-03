<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${popupVO.title}</title>
</head>
<body>
	<a href="${popupVO.link}" target="_blank">
		<img src='<c:url value='/cmm/fms/getImage.do'/>?atchFileId=<c:out value="${popupVO.atch_file_id}"/>&fileSn=<c:out value="${popupVO.file_sn}"/>' alt="" style="width:${popupVO.size_width};"/>
	</a>
</body>
</html>