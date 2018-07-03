package returnProject.site.main.service;

import returnProject.admin.service.AdminMemberVO;

public class SiteMemberVO extends AdminMemberVO {

	private static final long serialVersionUID = 1L;
	
	private String enc_password;		//암호화된 사용자 Password  
	private String login_type="user";	//로그인 종류 - user 또는 admin
	
	
	public String getEnc_password() {
		return enc_password;
	}

	public void setEnc_password(String enc_password) {
		this.enc_password = enc_password;
	}

	public String getLogin_type() {
		return login_type;
	}

	public void setLogin_type(String login_type) {
		this.login_type = login_type;
	}
	
	
}
