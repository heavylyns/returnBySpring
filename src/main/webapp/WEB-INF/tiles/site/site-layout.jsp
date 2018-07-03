<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, height=device-height, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui">
    <title>강원도 귀농귀촌</title>
    <link rel="stylesheet" href="/css/common.css"/>
    <link rel="stylesheet" href="/css/layout.css"/>
    <link rel="stylesheet" href="/css/main.css"/>
    <link rel="stylesheet" href="/css/utility.css"/>
    <link rel="stylesheet" href="/css/sub.css"/>
    <!-- <link rel="stylesheet" href="/css/jqlistbox/jqlistbox.css"/> -->
    <link rel="stylesheet" href="/css/fullcalendar/fullcalendar.css"/>
    <link rel="stylesheet" href="/css/datepicker.css"/>
    <script src="/js/libs/jquery-1.11.2.min.js"></script>
    <script src='/js/libs/fullcalendar/moment.min.js'></script>
    <script src="/js/libs/fullcalendar/fullcalendar.min.js"></script>
    <script src="/js/libs/fullcalendar/ko.js"></script>
    <script src="/js/libs/jquery.dotdotdot.min.js"></script>
    <script src="/js/libs/TweenMax.min.js"></script>
    <script src="/js/libs/jquery-ui-datepicker.min.js"></script>
    <script src="/js/libs/common.libs.js"></script>
    <script src="/js/libs/bsSlider.libs.js"></script>
    <script src="/js/libs/opSlider.libs.js"></script> 
    <!-- <script src="/js/libs/jquery.ListBox.js"></script> -->
    <script src="/js/common.js"></script>
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="/css/IE8.css"/>
    <script type="text/javascript" src="/js/libs/html5.js"></script>
    <script type="text/javascript" src="/js/libs/respond.min.js"></script>
    <![endif]-->
</head>
<body>
		<!-- header -->
		<tiles:insertAttribute name="header" />
		<!-- //header -->
		
			<!-- contents -->
			<tiles:insertAttribute name="contents" />
			<!-- //contents -->
			
		<!-- footer -->
		<tiles:insertAttribute name="footer" />
		<!-- //footer -->
</body>
</html>