<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


		<script type="text/javascript">
		
		
			function actionLogin() {
				if ($("#id").val() == "") {
					alert("아이디를 입력하세요");
					$("#id").focus();
					return false;
				} else if ($("#password").val() == "") {
					alert("비밀번호를 입력하세요");
					$("#password").focus();
					return false;
				} else {
					document.loginForm.action = "/admin/adminLogin.do";
					//document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
					//document.loginForm.action = "/j_spring_security_check";
					document.loginForm.submit();
				}
			}
			
			$(document).ready(function(){

				$("#id").focus();
				
				if ("${message}" != "") {
				    alert("${message}");
				}
			});
		</script>


		<div class="breadcrumb">
		    <ul>
		        <li class="home"><a href="#lnk">HOME</a></li>
		        <li><a href="#lnk">관리자</a></li>
		        <li class="active">로그인</li>
		    </ul>
		</div>
		
		<h3 class="subcont-tit">로그인</h3>
		<p class="subcont-titdes tc">관리자 페이지입니다. </p>
		
		<div class="contents">
		
		    <div class="stepcon-box">
		        <form action="/admin/adminLogin.do" name="loginForm"  class="entryform" method="post">
		            <fieldset>
		                <legend class="screen_out">관리자 로그인폼</legend>
		                <div class="entryform-wrap">
		                    <div class="form-line">
		                        <strong class="form-label"><label for="id">아이디</label></strong>
		                        <div class="form-input">
		                            <input type="text" id="id" name="id" class="form-inputbox">
		                        </div>
		                    </div>
		                    <div class="form-line">
		                        <strong class="form-label"><label for="password">비밀번호</label></strong>
		                        <div class="form-input">
		                            <input type="password" id="password" name="password" class="form-inputbox">
		                        </div>
		                    </div>
		                </div>
		                <!-- <button type="submit" class="defbtn pink">확인</button> -->
		                <button type="button" onclick="actionLogin();" class="defbtn pink">확인</button>
		            </fieldset>
		        </form>
		    </div>
		
		</div>
		
