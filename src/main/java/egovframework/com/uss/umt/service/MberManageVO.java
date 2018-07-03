package egovframework.com.uss.umt.service;

/**
 * 일반회원VO클래스로서 일반회원관리 비지니스로직 처리용 항목을 구성한다.
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *
 * </pre>
 */
public class MberManageVO extends UserDefaultVO{

	private static final long serialVersionUID = -4255594107023139972L;

	/** 이전비밀번호 - 비밀번호 변경시 사용*/
    private String oldPassword = "";

    /**
	 * 사용자고유아이디
	 */
	private String uniqId="";
	/**
	 * 사용자 유형
	 */
	private String userTy;
	/**
	 * 주소
	 */
	private String adres;
	/**
	 * 상세주소
	 */
	private String detailAdres;
	/**
	 * 끝전화번호
	 */
	private String endTelno;
	/**
	 * 팩스번호
	 */
	private String mberFxnum;
	/**
	 * 그룹 ID
	 */
	private String groupId;
	/**
	 * 주민등록번호
	 */
	private String ihidnum;
	/**
	 * 성별코드
	 */
	private String sexdstnCode;
	/**
	 * 회원 ID
	 */
	private String mberId;
	/**
	 * 회원명
	 */
	private String mberNm;
	/**
	 * 회원상태
	 */
	private String mberSttus;
	/**
	 * 지역번호
	 */
	private String areaNo;
	/**
	 * 중간전화번호
	 */
	private String middleTelno;
	/**
	 * 핸드폰번호
	 */
	private String moblphonNo;
	/**
	 * 비밀번호
	 */
	private String password;
	/**
	 * 비밀번호 정답
	 */
	private String passwordCnsr;
	/**
	 * 비밀번호 힌트
	 */
	private String passwordHint;
	/**
	 * 가입 일자
	 */
	private String sbscrbDe;
	/**
	 * 우편번호
	 */
	private String zip;
	/**
	 * 이메일주소
	 */
	private String mberEmailAdres;
	/**
	 * oldPassword attribute 값을  리턴한다.
	 * @return String
	 */
	public String getOldPassword() {
		return oldPassword;
	}
	/**
	 * oldPassword attribute 값을 설정한다.
	 * @param oldPassword String
	 */
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	/**
	 * uniqId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getUniqId() {
		return uniqId;
	}
	/**
	 * uniqId attribute 값을 설정한다.
	 * @param uniqId String
	 */
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	/**
	 * userTy attribute 값을  리턴한다.
	 * @return String
	 */
	public String getUserTy() {
		return userTy;
	}
	/**
	 * userTy attribute 값을 설정한다.
	 * @param userTy String
	 */
	public void setUserTy(String userTy) {
		this.userTy = userTy;
	}
	/**
	 * adres attribute 값을  리턴한다.
	 * @return String
	 */
	public String getAdres() {
		return adres;
	}
	/**
	 * adres attribute 값을 설정한다.
	 * @param adres String
	 */
	public void setAdres(String adres) {
		this.adres = adres;
	}
	/**
	 * detailAdres attribute 값을  리턴한다.
	 * @return String
	 */
	public String getDetailAdres() {
		return detailAdres;
	}
	/**
	 * detailAdres attribute 값을 설정한다.
	 * @param detailAdres String
	 */
	public void setDetailAdres(String detailAdres) {
		this.detailAdres = detailAdres;
	}
	/**
	 * endTelno attribute 값을  리턴한다.
	 * @return String
	 */
	public String getEndTelno() {
		return endTelno;
	}
	/**
	 * endTelno attribute 값을 설정한다.
	 * @param endTelno String
	 */
	public void setEndTelno(String endTelno) {
		this.endTelno = endTelno;
	}
	/**
	 * mberFxnum attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMberFxnum() {
		return mberFxnum;
	}
	/**
	 * mberFxnum attribute 값을 설정한다.
	 * @param mberFxnum String
	 */
	public void setMberFxnum(String mberFxnum) {
		this.mberFxnum = mberFxnum;
	}
	/**
	 * groupId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getGroupId() {
		return groupId;
	}
	/**
	 * groupId attribute 값을 설정한다.
	 * @param groupId String
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	/**
	 * ihidnum attribute 값을  리턴한다.
	 * @return String
	 */
	public String getIhidnum() {
		return ihidnum;
	}
	/**
	 * ihidnum attribute 값을 설정한다.
	 * @param ihidnum String
	 */
	public void setIhidnum(String ihidnum) {
		this.ihidnum = ihidnum;
	}
	/**
	 * sexdstnCode attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSexdstnCode() {
		return sexdstnCode;
	}
	/**
	 * sexdstnCode attribute 값을 설정한다.
	 * @param sexdstnCode String
	 */
	public void setSexdstnCode(String sexdstnCode) {
		this.sexdstnCode = sexdstnCode;
	}
	/**
	 * mberId attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMberId() {
		return mberId;
	}
	/**
	 * mberId attribute 값을 설정한다.
	 * @param mberId String
	 */
	public void setMberId(String mberId) {
		this.mberId = mberId;
	}
	/**
	 * mberNm attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMberNm() {
		return mberNm;
	}
	/**
	 * mberNm attribute 값을 설정한다.
	 * @param mberNm String
	 */
	public void setMberNm(String mberNm) {
		this.mberNm = mberNm;
	}
	/**
	 * mberSttus attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMberSttus() {
		return mberSttus;
	}
	/**
	 * mberSttus attribute 값을 설정한다.
	 * @param mberSttus String
	 */
	public void setMberSttus(String mberSttus) {
		this.mberSttus = mberSttus;
	}
	/**
	 * areaNo attribute 값을  리턴한다.
	 * @return String
	 */
	public String getAreaNo() {
		return areaNo;
	}
	/**
	 * areaNo attribute 값을 설정한다.
	 * @param areaNo String
	 */
	public void setAreaNo(String areaNo) {
		this.areaNo = areaNo;
	}
	/**
	 * middleTelno attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMiddleTelno() {
		return middleTelno;
	}
	/**
	 * middleTelno attribute 값을 설정한다.
	 * @param middleTelno String
	 */
	public void setMiddleTelno(String middleTelno) {
		this.middleTelno = middleTelno;
	}
	/**
	 * moblphonNo attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMoblphonNo() {
		return moblphonNo;
	}
	/**
	 * moblphonNo attribute 값을 설정한다.
	 * @param moblphonNo String
	 */
	public void setMoblphonNo(String moblphonNo) {
		this.moblphonNo = moblphonNo;
	}
	/**
	 * password attribute 값을  리턴한다.
	 * @return String
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * password attribute 값을 설정한다.
	 * @param password String
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * passwordCnsr attribute 값을  리턴한다.
	 * @return String
	 */
	public String getPasswordCnsr() {
		return passwordCnsr;
	}
	/**
	 * passwordCnsr attribute 값을 설정한다.
	 * @param passwordCnsr String
	 */
	public void setPasswordCnsr(String passwordCnsr) {
		this.passwordCnsr = passwordCnsr;
	}
	/**
	 * passwordHint attribute 값을  리턴한다.
	 * @return String
	 */
	public String getPasswordHint() {
		return passwordHint;
	}
	/**
	 * passwordHint attribute 값을 설정한다.
	 * @param passwordHint String
	 */
	public void setPasswordHint(String passwordHint) {
		this.passwordHint = passwordHint;
	}
	/**
	 * sbscrbDe attribute 값을  리턴한다.
	 * @return String
	 */
	public String getSbscrbDe() {
		return sbscrbDe;
	}
	/**
	 * sbscrbDe attribute 값을 설정한다.
	 * @param sbscrbDe String
	 */
	public void setSbscrbDe(String sbscrbDe) {
		this.sbscrbDe = sbscrbDe;
	}
	/**
	 * zip attribute 값을  리턴한다.
	 * @return String
	 */
	public String getZip() {
		return zip;
	}
	/**
	 * zip attribute 값을 설정한다.
	 * @param zip String
	 */
	public void setZip(String zip) {
		this.zip = zip;
	}
	/**
	 * mberEmailAdres attribute 값을  리턴한다.
	 * @return String
	 */
	public String getMberEmailAdres() {
		return mberEmailAdres;
	}
	/**
	 * mberEmailAdres attribute 값을 설정한다.
	 * @param mberEmailAdres String
	 */
	public void setMberEmailAdres(String mberEmailAdres) {
		this.mberEmailAdres = mberEmailAdres;
	}

	
	
	
	// 2016-06-21 김범수 추가

    private String open_year = "";		// 개업년도
    private String open_month = "";		// 개업 월
    private String open_day = "";		// 개업 일
    private String conditions = "";		// 업태
    private String store_name = "";		// 상호
    private String birth_year = "";		// 생년월일(연도)
    private String birth_month = "";	// 생년월일(월)
    private String birth_day = "";		// 생년월일(일)
    private String mber_status = "";	// 회원 구분(1:개인 사업자, 2:법인 사업자)
    private String cor_number01 = "";	// 법인등록번호(앞)
    private String cor_number02 = "";	// 법인등록번호(뒤)
    private String busi_type = "";		// 업종
    private String busi_type2 = "";		// 종목
    private String tel_no1 = "";		// 대표전화(지역)
    private String tel_no2 = "";		// 대표전화(중간)
    private String tel_no3 = "";		// 대표전화(마지막)
    private String fax_no1 = "";		// 팩스번호(지역)
    private String fax_no2 = "";		// 팩스번호(중간)
    private String fax_no3 = "";		// 팩스번호(마지막)
    private String phone_no1 = "";		// 연락처(처음)
    private String phone_no2 = "";		// 연락처(중간)
    private String phone_no3 = "";		// 연락처(마지막)
    private String re_name = "";		// 신청인 이름
    private String atchFileId = "";		// 사업자등록증 ID
    private String inp_busnumber01 = "";	// 사업자번호(처음)
    private String inp_busnumber02 = "";	// 사업자번호(중간)
    private String inp_busnumber03 = "";	// 사업자번호(마지막)
    private String rownum = "";			// 게시물 번호
    private String bank_name = "";		// 은행명
    private String bank_no = "";		// 계좌번호
    private String bank_holder = "";	// 예금주
    private String mber_flag = "";		// 승인여부
    private String req_date = "";		// 신청일
    private String app_date = "";		// 승인일
    private String ci = "";				// 휴대폰 본인인증 CI
    private String del_flag = "";		// 삭제 요청 flag
    private String update_flag = "";	// 수정 요청 flag
    private String update_memo = "";	// 수정 요청 내용
    private String area_no = "";		// 지역코드
    private String out_flag;			// 철회 flag
    private String out_type;			// 철회 type(admin/mine)
    private String out_memo;			// 철회 사유
    private String out_date;			// 철회일
    private String out_mberId;			// 철회 임시 아이디
    
	public String getOpen_year() {
		return open_year;
	}
	public void setOpen_year(String open_year) {
		this.open_year = open_year;
	}
	public String getOpen_month() {
		return open_month;
	}
	public void setOpen_month(String open_month) {
		this.open_month = open_month;
	}
	public String getOpen_day() {
		return open_day;
	}
	public void setOpen_day(String open_day) {
		this.open_day = open_day;
	}
	public String getConditions() {
		return conditions;
	}
	public void setConditions(String conditions) {
		this.conditions = conditions;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getBirth_year() {
		return birth_year;
	}
	public void setBirth_year(String birth_year) {
		this.birth_year = birth_year;
	}
	public String getBirth_month() {
		return birth_month;
	}
	public void setBirth_month(String birth_month) {
		this.birth_month = birth_month;
	}
	public String getBirth_day() {
		return birth_day;
	}
	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
	public String getMber_status() {
		return mber_status;
	}
	public void setMber_status(String mber_status) {
		this.mber_status = mber_status;
	}
	public String getCor_number01() {
		return cor_number01;
	}
	public void setCor_number01(String cor_number01) {
		this.cor_number01 = cor_number01;
	}
	public String getCor_number02() {
		return cor_number02;
	}
	public void setCor_number02(String cor_number02) {
		this.cor_number02 = cor_number02;
	}
	public String getBusi_type() {
		return busi_type;
	}
	public void setBusi_type(String busi_type) {
		this.busi_type = busi_type;
	}
	public String getBusi_type2() {
		return busi_type2;
	}
	public void setBusi_type2(String busi_type2) {
		this.busi_type2 = busi_type2;
	}
	public String getTel_no1() {
		return tel_no1;
	}
	public void setTel_no1(String tel_no1) {
		this.tel_no1 = tel_no1;
	}
	public String getTel_no2() {
		return tel_no2;
	}
	public void setTel_no2(String tel_no2) {
		this.tel_no2 = tel_no2;
	}
	public String getTel_no3() {
		return tel_no3;
	}
	public void setTel_no3(String tel_no3) {
		this.tel_no3 = tel_no3;
	}
	public String getFax_no1() {
		return fax_no1;
	}
	public void setFax_no1(String fax_no1) {
		this.fax_no1 = fax_no1;
	}
	public String getFax_no2() {
		return fax_no2;
	}
	public void setFax_no2(String fax_no2) {
		this.fax_no2 = fax_no2;
	}
	public String getFax_no3() {
		return fax_no3;
	}
	public void setFax_no3(String fax_no3) {
		this.fax_no3 = fax_no3;
	}
	public String getPhone_no1() {
		return phone_no1;
	}
	public void setPhone_no1(String phone_no1) {
		this.phone_no1 = phone_no1;
	}
	public String getPhone_no2() {
		return phone_no2;
	}
	public void setPhone_no2(String phone_no2) {
		this.phone_no2 = phone_no2;
	}
	public String getPhone_no3() {
		return phone_no3;
	}
	public void setPhone_no3(String phone_no3) {
		this.phone_no3 = phone_no3;
	}
	public String getRe_name() {
		return re_name;
	}
	public void setRe_name(String re_name) {
		this.re_name = re_name;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getInp_busnumber01() {
		return inp_busnumber01;
	}
	public void setInp_busnumber01(String inp_busnumber01) {
		this.inp_busnumber01 = inp_busnumber01;
	}
	public String getInp_busnumber02() {
		return inp_busnumber02;
	}
	public void setInp_busnumber02(String inp_busnumber02) {
		this.inp_busnumber02 = inp_busnumber02;
	}
	public String getInp_busnumber03() {
		return inp_busnumber03;
	}
	public void setInp_busnumber03(String inp_busnumber03) {
		this.inp_busnumber03 = inp_busnumber03;
	}
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getBank_no() {
		return bank_no;
	}
	public void setBank_no(String bank_no) {
		this.bank_no = bank_no;
	}
	public String getBank_holder() {
		return bank_holder;
	}
	public void setBank_holder(String bank_holder) {
		this.bank_holder = bank_holder;
	}
	public String getMber_flag() {
		return mber_flag;
	}
	public void setMber_flag(String mber_flag) {
		this.mber_flag = mber_flag;
	}
	public String getReq_date() {
		return req_date;
	}
	public void setReq_date(String req_date) {
		this.req_date = req_date;
	}
	public String getApp_date() {
		return app_date;
	}
	public void setApp_date(String app_date) {
		this.app_date = app_date;
	}
	public String getCi() {
		return ci;
	}
	public void setCi(String ci) {
		this.ci = ci;
	}
	public String getDel_flag() {
		return del_flag;
	}
	public void setDel_flag(String del_flag) {
		this.del_flag = del_flag;
	}
	public String getUpdate_flag() {
		return update_flag;
	}
	public void setUpdate_flag(String update_flag) {
		this.update_flag = update_flag;
	}
	public String getUpdate_memo() {
		return update_memo;
	}
	public void setUpdate_memo(String update_memo) {
		this.update_memo = update_memo;
	}
	public String getArea_no() {
		return area_no;
	}
	public void setArea_no(String area_no) {
		this.area_no = area_no;
	}
	public String getOut_flag() {
		return out_flag;
	}
	public void setOut_flag(String out_flag) {
		this.out_flag = out_flag;
	}
	public String getOut_type() {
		return out_type;
	}
	public void setOut_type(String out_type) {
		this.out_type = out_type;
	}
	public String getOut_date() {
		return out_date;
	}
	public void setOut_date(String out_date) {
		this.out_date = out_date;
	}
	public String getOut_mberId() {
		return out_mberId;
	}
	public void setOut_mberId(String out_mberId) {
		this.out_mberId = out_mberId;
	}
	public String getOut_memo() {
		return out_memo;
	}
	public void setOut_memo(String out_memo) {
		this.out_memo = out_memo;
	}
    
    
    
    
}

