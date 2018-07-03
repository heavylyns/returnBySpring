<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>강원상품권-관리자</title>

    <link rel="stylesheet" type="text/css" href="/admin/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/admin/css/layout.css"/>
    <link rel="stylesheet" type="text/css" href="/admin/css/admin.css"/>
    <link rel="stylesheet" type="text/css" href="/admin/css/datepicker.css"/>
    <link rel="stylesheet" type="text/css" href="/admin/css/icheck/minimal.css"/>
    <link rel="stylesheet" type="text/css" href="/admin/css/jqlistbox/jqlistbox.css"/>

    <script type="text/javascript"  src="/admin/js/libs/jquery-1.11.2.min.js"></script>
    <script type="text/javascript"  src="/admin/js/libs/common.libs.js"></script>
    <script type="text/javascript"  src="/admin/js/libs/jquery.ListBox.js"></script>
    <script type="text/javascript"  src="/admin/js/libs/jquery-ui-datepicker.min.js"></script>
    <!-- high charts -->
    <script type="text/javascript" src="/admin/js/libs/highcharts.js"></script>
    <script type="text/javascript" src="/admin/js/libs/drilldown.js"></script>
    <!-- //high charts -->
    <!--<script type="text/javascript"  src="/js/libs/retina.libs.js"></script>-->
    <script type="text/javascript"  src="/admin/js/common.js"></script>

    <!--[if lt IE 9]>
    <link rel="stylesheet" href="/admin/css/IE8.css"/>
    <script type="text/javascript" src="/admin/js/libs/html5.js"></script>
    <![endif]-->

</head>
<body>

		<tiles:insertAttribute name="contents" />

</body>
</html>

