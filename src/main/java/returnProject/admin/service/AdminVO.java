package returnProject.admin.service;

import java.util.List;


public class AdminVO {

    private String rownum = "";	// 번호
	private String id;			// 아이디
	private String password;	// 비밀번호
	private String name;		// 이름
	private String organ_name;	// 기관명
	private String depart_name;	// 부서명
	private String phone_no1;	// 핸드폰번호 처음
	private String phone_no2;	// 핸드폰번호 중간
	private String phone_no3;	// 핸드폰번호 끝
	private String roleId;		// 권한
	private String reg_date;	// 생성일
	private String type;		// 수정 or 등록 구분값

	private String menuItems;			// 메뉴 권한 관리
	private List<AdminRoleVO> menus;	// 메뉴 권한 관리
	private String menuIds;				// 메뉴 권한 관리
	private String visit_date;
	private int visitor_cnt;
	
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
	public String getOrgan_name() {
		return organ_name;
	}
	public void setOrgan_name(String organ_name) {
		this.organ_name = organ_name;
	}
	public String getDepart_name() {
		return depart_name;
	}
	public void setDepart_name(String depart_name) {
		this.depart_name = depart_name;
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
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMenuItems() {
		return menuItems;
	}
	public void setMenuItems(String menuItems) {
		this.menuItems = menuItems;
	}
	public List<AdminRoleVO> getMenus() {
		return menus;
	}
	public void setMenus(List<AdminRoleVO> menus) {
		this.menus = menus;
	}
	public String getMenuIds() {
		return menuIds;
	}
	public void setMenuIds(String menuIds) {
		this.menuIds = menuIds;
	}
	public String getVisit_date() {
		return visit_date;
	}
	public void setVisit_date(String visit_date) {
		this.visit_date = visit_date;
	}
	public int getVisitor_cnt() {
		return visitor_cnt;
	}
	public void setVisitor_cnt(int visitor_cnt) {
		this.visitor_cnt = visitor_cnt;
	}
	
	
	
	
	
	
}
