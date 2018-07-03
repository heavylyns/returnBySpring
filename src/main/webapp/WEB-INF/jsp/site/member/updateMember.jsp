<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	
	<script type="text/javascript">
		function update_member(){
			if($("#password").val() == ""){
				alert("비밀번호를 입력하세요.");
				$("#password").focus();
				return false;
			}
			else if($("#password2").val() == ""){
				alert("비밀번호를 입력하세요.");
				$("#password2").focus();
				return false;
			}
			else if($("#password").val() != $("#password2").val()){
				alert("비밀번호가 같지 않습니다.");
				$("#password2").focus();
				return false;
			}
			else{
				document.frm.action = "/site/member/updateAction.do";
				document.frm.submit();
				alert("회원 정보가 정상적으로 수정되었습니다.")
			}
		}
	</script>
	 <div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">회원정보수정</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="joinwrap infomod-wrap">
            <p class="jointxt">※ 안전한 개인정보 보호를 위해 <strong>회원님의 동의 없이 제3자에게 정보를 제공하지 않습니다(변경할 비밀번호를 정확히 입력해주세요.).</strong></p>

            <form name="frm" method="post" action="">
            	<input type="hidden" name="id" value="${loginVO.id}"/>
            	<input type="hidden" name="name" value="${loginVO.name}"/>
                <fieldset>
                    <legend class="screen_out">회원정보 수정</legend>
                    <div class="joingraybox">
                        <div class="joininpbox">
                            <p class="inptit">아이디(E-Mail)</p>
                            <span class="fixtxt">${loginVO.id}</span>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">비밀번호</p>
                            <div class="posr">
                                <label for="password" class="js-label-hide">비밀번호를 입력해주세요.</label>
                                <input type="password" id="password" name="password" value=""/>
                            </div>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">비밀번호 재입력</p>
                            <div class="posr">
                                <label for="password2" class="js-label-hide">비밀번호를 재입력해주세요.</label>
                                <input type="password" id="password2" name="password2" value=""/>
                            </div>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">이름</p>
                            <span class="fixtxt">${loginVO.name}</span>
                        </div>
                    </div>
                    <div class="btnarea">
                        <a href="#lnk" class="commonbtns blue" onclick="javascript:history.back();">취소</a>
                        <a href="#lnk" class="commonbtns black" onclick="javascript:update_member();">확인</a>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
