<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<script>
		function mem_break(){
			if(confirm("정말 탈퇴하시겠습니까?")){
				location.replace("/site/member/deleteMember.do");
				alert("회원 탈퇴가 정상적으로 처리되었습니다.");
				return false;
			}
		};
			
	</script>

	<div class="incontainer">
        <div class="subdepwrap">
            <p class="subdep2-tit">회원탈퇴</p>
            <p class="subdep2-desc">강원도귀농귀촌지원센터 홈페이지에 오신것을 환영합니다.</p>
        </div>
        <div class="joinwrap membreak-wrap">
            <div class="joingraybox">
                <div class="breakinfo-wrap">
                    <p class="breaktit">회원 탈퇴를 신청합니다.<span>귀농귀촌 홈페이지를 이용해 주셔서 감사합니다.</span><span>회원탈퇴를 하실 경우 아래 내용과 같이 회원정보가 처리됩니다.</span></p>
                    <ul>
                        <li>· 회원탈퇴 신청 즉시 회원탈퇴 처리되며, 해당 아이디의 회원정보는 즉시 삭제 처리 됩니다.</li>
                        <li>· 회원탈퇴 이후 같은 아이디로는 재가입이 불가능합니다.</li>
                    </ul>
                </div>
            </div>
            <div class="btnarea">
                <a href="#" class="commonbtns green" onclick="javascript:mem_break();">회원탈퇴 신청</a>
                <a href="/site/main.do" class="commonbtns blue">홈으로</a>
            </div>
        </div>
    </div>
