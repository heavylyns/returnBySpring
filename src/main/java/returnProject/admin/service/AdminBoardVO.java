package returnProject.admin.service;

public class AdminBoardVO {

	private int rownum;
    private int board_no	 	= 0;	// 번호
	private String board_code	= "";	// 아이디
	private String board_name = "";
	private String title = "";
	private String contents;
	//private byte[] contents; 
	private int view_cnt = 0;
	private String status = "";
	private String writer ="";
	private String name;
	private String reg_date = "";
	private int prev_no;
	private int next_no;
	private String prev_title;
	private String next_title;
	private String attached_file_id;
	private String attached_file_yn;
	private String attached_file_url;
	private int group_num;
	private String region_code;
	private String region_name;
	private int reply_no;
	private int board_cnt;
	private String new_flag;
	
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBoard_code() {
		return board_code;
	}
	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
//	public byte[] getContents() {
//		return contents;
//	}
//	public void setContents(byte[] contents) {
//		this.contents = contents;
//	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getPrev_no() {
		return prev_no;
	}
	public void setPrev_no(int prev_no) {
		this.prev_no = prev_no;
	}
	public int getNext_no() {
		return next_no;
	}
	public void setNext_no(int next_no) {
		this.next_no = next_no;
	}
	public String getPrev_title() {
		return prev_title;
	}
	public void setPrev_title(String prev_title) {
		this.prev_title = prev_title;
	}
	public String getNext_title() {
		return next_title;
	}
	public void setNext_title(String next_title) {
		this.next_title = next_title;
	}
	public String getAttached_file_id() {
		return attached_file_id;
	}
	public void setAttached_file_id(String attached_file_id) {
		this.attached_file_id = attached_file_id;
	}
	public String getAttached_file_yn() {
		return attached_file_yn;
	}
	public void setAttached_file_yn(String attached_file_yn) {
		this.attached_file_yn = attached_file_yn;
	}
	public String getAttached_file_url() {
		return attached_file_url;
	}
	public void setAttached_file_url(String attached_file_url) {
		this.attached_file_url = attached_file_url;
	}
	public int getGroup_num() {
		return group_num;
	}
	public void setGroup_num(int group_num) {
		this.group_num = group_num;
	}
	public String getRegion_code() {
		return region_code;
	}
	public void setRegion_code(String region_code) {
		this.region_code = region_code;
	}
	public String getRegion_name() {
		return region_name;
	}
	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getBoard_cnt() {
		return board_cnt;
	}
	public void setBoard_cnt(int board_cnt) {
		this.board_cnt = board_cnt;
	}
	public String getNew_flag() {
		return new_flag;
	}
	public void setNew_flag(String new_flag) {
		this.new_flag = new_flag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
		
	
}
