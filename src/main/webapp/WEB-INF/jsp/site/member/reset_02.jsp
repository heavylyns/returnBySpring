<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
    <script type="text/javascript">
    	function reset_ok(){
    		//ajax 태워서 비번 변경
    		//alert 띄워주고
    		location.href="/site/member/login.do";
    	}
    </script>
    <div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">비밀번호 초기화</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <form action="#">
            <fieldset>
                <legend class="screen_out">비밀번호 초기화</legend>
                <div class="loginarea initpasswrap">
                    <div class="inputarea">
                        <div class="posr">
                            <label for="inp-pass" class="js-label-hide">비밀번호 입력</label>
                            <input type="text" id="inp-pass" name="inp-pass"/>
                        </div>
                        <div class="posr">
                            <label for="inp-repass" class="js-label-hide">비밀번호 확인</label>
                            <input type="password" id="inp-repass" name="inp-repass"/>
                        </div>
                        <div class="btnarea clearfix">
                            <button type="button" class="commonbtns blue" onclick="javascript:reset_ok();">확인</button>
                            <button type="button" class="commonbtns black" onclick="javascript:location.href='/site/main.do';">취소</button>
                        </div>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
    