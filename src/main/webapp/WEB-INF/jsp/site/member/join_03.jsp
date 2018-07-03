<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	

	<script type="text/javascript">
		function email_chk(){	//이메일형식인지 체크
			var id = $("#id").val();
			var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			if( !re.test(id) ){	//이메일형식이 아니다!
				alert("잘못된 이메일 형식입니다.");
				$("#id").focus();
				return false;
			}
			else{				//이메일형식이다
				return true;
			}
		}	
		function chkPwd(str){
			var pw = str;
			var num = pw.search(/[0-9]/g);
			var eng = pw.search(/[a-z]/ig);
			var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

			if(pw.length < 8 || pw.length > 20){
				alert("비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.");
				return false;
			}
			if(pw.search(/₩s/) != -1){
				alert("비밀번호는 공백없이 입력해주세요.");
			  	return false;
			} 
			if(num < 0 || eng < 0 || spe < 0 ){
			  	alert("비밀번호는 영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
				return false;
			}
			return true;
		}
		function CheckPass(str){	// 비밀번호 영문과 숫자 조합인지 체크
			var reg1 = /^[a-zA-Z0-9]{10,20}$/;
			var reg2 = /[a-zA-Z]/g;
			var reg3 = /[0-9]/g;
			return ( reg1.test(str) && reg2.test(str) && reg3.test(str) );
		}
	
		function exist_chk(){	//중복확인
			if(!email_chk() ){	//이메일형식이 아닐 때 리턴
				return;
			}
			else{				//이메일 형식이 맞을 때
				var id = $("#id").val();	
				$.ajax({		//ajax 시작
					type : 'post',
					url  : '/site/member/exist_chk.do',
					data : 'id='+id,
					success : function(result){
						if(result.count == 0){
							alert("사용가능한 아이디입니다.");
							$("#isExist").val('N');
						}else{
							alert("이미 등록된 아이디입니다.");
							$("#isExist").val('Y');
						}
					}			
				});				//ajax 끝
			}
		}
		
		
		function join_ok(){			//회원가입
			if($("#id").val() == '' || $("#id").val() == null ){
				alert("아이디를 입력해 주세요.");
				$("#id").focus();
				return false;
			}
			if($("#password").val() == '' || $("#password").val() == null ){
				alert("비밀번호를 입력해 주세요.");
				$("#password").focus();
				return false;
			}
			if($("#password_chk").val() == '' || $("#password_chk").val() == null ){
				alert("비밀번호 확인이 필요합니다.");
				$("#password_chk").focus();
				return false;
			}
			if( chkPwd($("#password").val()) == false){
				$("#password").focus();
				return;
			}
			if( $("#password").val() != $("#password_chk").val() ){
				alert("비밀번호가 같지 않습니다.");
				$("#password_chk").focus();
				return false;
			}
			if( $("#region_code").val() == '' || $("#region_code").val() == null ){
				alert("선호지역을 선택해 주세요.");
				$("#region_code").focus();
				return false;
			}
			if( (!$("#member_type01").is(":checked")) && (!$("#member_type02").is(":checked")) ){
				alert("귀농귀촌 여부를 선택해 주세요.");
				$("#member_type01").focus();
				return false;
			}
			if( $("#isExist").val() == 'Y' ){
				alert("아이디 중복여부를 확인해주세요.");
				return false;
			}
			
			document.join_form.submit();
		}
		
	</script>
	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">회원가입</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="joinwrap">
            <div class="jointabwrap clearfix">
                <div class="jointab step1"><span>약관동의</span></div>
                <div class="jointab step2"><span>본인인증</span></div>
                <div class="jointab step3 active"><span>회원정보 입력</span></div>
                <div class="jointab step4"><span>가입완료</span></div>
            </div>
            <p class="jointxt">※ 안전한 개인정보 보호를 위해 <strong>회원님의 동의 없이 제3자에게 정보를 제공하지 않습니다(모든 항목을 입력해야 회원가입이 가능합니다.).</strong></p>
            <form id="join_form" name="join_form" action="/site/member/join_04.do" method="post">
            	<input type="hidden" id="isExist" value="Y" />
            	<input type="hidden" name="name" value="홍길동"/> <%--임시로 작성! --%>
                <fieldset>
                    <legend class="screen_out">회원가입 입력</legend>
                    <div class="joingraybox">
                        <div class="joininpbox">
                            <p class="inptit">아이디(E-Mail)</p>
                            <div class="posr">
                                <label for="inp-email" class="js-label-hide">이메일을 입력해주세요.</label>
                                <input type="text" id="id" name="id"/>
                            </div>
                            <a href="javascript:exist_chk();" id="id_chk" class="overbtn">중복확인</a>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">비밀번호</p>
                            <div class="posr">
                                <label for="password" class="js-label-hide">비밀번호를 입력해주세요.</label>
                                <input type="password" id="password" name="password"/>
                            </div>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">비밀번호 재입력</p>
                            <div class="posr">
                                <label for="password_chk" class="js-label-hide">비밀번호를 재입력해주세요.</label>
                                <input type="password" id="password_chk" name="password_chk"/>
                            </div>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">이름</p>
                            <span class="fixtxt">홍길동</span>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">귀농귀촌 선호지역</p>
                            <select name="region_code" id="region_code" title="선호지역 선택">
                                <option value="">선호지역을 선택해주세요.</option>
                                <c:forEach var="region" items="${regionCombo}"> 
                                	<option value="<c:out value='${region.region_code}'/>"><c:out value="${region.region_name}"/></option>
                            	</c:forEach>
                            </select>
                        </div>
                        <div class="joininpbox">
                            <p class="inptit">귀농귀촌 여부</p>
                            <div class="sel-radio">
                                <div>
                                    <input type="radio" id="member_type01" name="member_type" value="01"/>
                                    <label for="pre-farm">나는 귀농귀촌을 준비 중입니다.</label>
                                </div>
                                <div>
                                    <input type="radio" id="member_type02" name="member_type" value="02"/>
                                    <label for="alreay-farm">나는 이미 귀농귀촌 하였습니다.</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="btnarea">
                        <a href="javascript:history.back();" class="commonbtns blue">이전</a>
                        <a href="javascript:join_ok();" class="commonbtns black">회원가입</a>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
