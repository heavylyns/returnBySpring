package returnProject.admin.service;

import java.util.List;

import egovframework.com.cop.bbs.service.BoardVO;


public class AdminMemberVO extends BoardVO {

    private String rownum = "";	// 번호
	private String id;			// 아이디
	private String password;	// 비밀번호
	private String name;		// 이름
	private String member_type;
	private String region_code;
	private String return_yn;
	private String reg_date;
	private String update_date;
	private String type;
	private String region_name;
	private int region_cnt;
	
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegion_code() {
		return region_code;
	}
	public void setRegion_code(String region_code) {
		this.region_code = region_code;
	}
	public String getReturn_yn() {
		return return_yn;
	}
	public void setReturn_yn(String return_yn) {
		this.return_yn = return_yn;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getMember_type() {
		return member_type;
	}
	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRegion_name() {
		return region_name;
	}
	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	public int getRegion_cnt() {
		return region_cnt;
	}
	public void setRegion_cnt(int region_cnt) {
		this.region_cnt = region_cnt;
	}
	
	
	
	
	
}
