<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
    <script type="text/javascript">
		
    	window.onload = function() {
        if (getCookie("save-id")) { 								// 쿠키에 저장된 ID가 있을 때
	            document.loginForm.id.value = getCookie("save-id"); // id값 입력
	            document.loginForm.save_id.checked = true; 			// 체크 - 활성화
	            $("#password").focus();
	        }
	    }
	    function setCookie(name, value, expiredays){ 				// 쿠키 저장(쿠키명,값,기간)
	        var todayDate = new Date();
	        todayDate.setDate(todayDate.getDate() + expiredays);
	        document.cookie = name + "=" + escape(value) + "; path=/; expires="+ todayDate.toGMTString() + ";"
	    }
	 
	    function getCookie(Name) { 									// 쿠키 로드
	        var search = Name + "=";
	        if (document.cookie.length > 0) { 						// if there are any cookies
	            offset = document.cookie.indexOf(search);
	            if (offset != -1) { 								// if cookie exists
	                offset += search.length; 						// set index of beginning of value
	                end = document.cookie.indexOf(";", offset); 	// set index of end of cookie value
	                if (end == -1)
	                    end = document.cookie.length;
	                return unescape(document.cookie.substring(offset, end));
	            }
	        }
	    }
	    
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
				document.loginForm.action = "/site/member/actionLogin.do";
				if (document.loginForm.save_id.checked == true) { 				// 체크 시
		            setCookie("save-id", document.loginForm.id.value, 7); 		// 아이디 입력필드값을 7일동안 저장
		        } else { 														// 아이디 저장을 체크 하지 않았을때
		            setCookie("save-id", document.loginForm.id.value, 0); 		// 날짜를 0으로 저장하여 쿠키삭제
		        }
				document.loginForm.submit();
			}
		}

		// maxlength 체크
		function maxLengthCheck(object){
			if (object.value.length > object.maxLength){
				object.value = object.value.slice(0, object.maxLength);
			}    
		}

		$(document).ready(function(){

			$("#id").focus();
			
			if ("${message}" != "") {
			    alert("${message}");
			}
			
		});
	</script>

    <div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">로그인</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <form name="loginForm" method="post" action="#">
            <fieldset>
                <legend class="screen_out">로그인</legend>
                <div class="loginarea">
                    <p class="logintit"><span>Welcome!</span> 강원도 귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
                    <div class="inputarea">
                        <div class="posr">
                            <label for="id" class="js-label-hide">아이디를 입력해주세요.</label>
                            <input type="text" id="id" name="id" maxlength="50" oninput="maxLengthCheck(this)"/>
                        </div>
                        <div class="posr">
                            <label for="password" class="js-label-hide">비밀번호를 입력해주세요.</label>
                            <input type="password" id="password" name="password"/>
                        </div>
                        <div class="chkbox">
                            <input type="checkbox" name="save_id" id="save_id"/>
                            <label for="save_id">아이디 저장하기</label>
                        </div>
                        <button type="button" class="loginbtn" onclick="actionLogin();">로그인</button>
                    </div>
                    <div class="btnarea clearfix">
                        <a href="/site/member/find_01.do" class="commonbtns yellow">아이디 찾기</a>
                        <a href="/site/member/reset_01.do" class="commonbtns orange">비밀번호 초기화</a>
                    </div>
                </div>
            </fieldset>
        </form>
        <div class="joininfo">
            <p>아직도 <strong>강원도귀농귀촌지원센터 홈페이지 회원</strong>이 아니십니까?</p>
            <a href="/site/member/join_01.do" class="commonbtns yellow">회원가입</a>
        </div>
    </div>


    