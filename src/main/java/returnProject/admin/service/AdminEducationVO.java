package returnProject.admin.service;

import java.io.Serializable;

import egovframework.com.cop.bbs.service.Board;
@SuppressWarnings("serial")
public class AdminEducationVO extends Board implements Serializable {
	 /** 검색조건 */
    private String searchCnd = "";
    
    /** 검색단어 */
    private String searchWrd = "";

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int firstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int lastIndex = 1;

    /** 페이지당 레코드 개수 */
    private int recordCountPerPage = 10;

    /** 레코드 번호 */
    private int rowNo = 0;

	private int rownum;
    private int education_no;
	private String house_code;
	private String education_name;
	private String education_start;
	private String education_end;
	private String education_end2;//캘린더에 정확히 표시를 위해 1일을 추가해서 가져와야함, end+ 1일 의 값을 가진다.
	private String reg_date;
	private String del_yn;
	private String writer;
	private String name;
	private String education_start_year;
	private String education_start_month;
	private String education_start_day;
	private String education_end_year;
	private String education_end_month;
	private String education_end_day;
	
	private int r_edu_no;
	private String r_edu_title;
	private String r_edu_start;
	private String r_edu_end;
	private String r_edu_place;
	private String r_edu_tel;
	private String r_edu_summary;
	private String r_edu_contents;
	private String region_code;
	private String region_name;
	private String attached_file_id;
	private String display_yn;
	private String attached_file_yn;
	private String attached_file_cnt;
	private int prev_no;
	private int next_no;
	private String prev_title;
	private String next_title;
	private String standard_date;
	
	
	public String getSearchCnd() {
		return searchCnd;
	}
	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}
	public String getSearchWrd() {
		return searchWrd;
	}
	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public int getRowNo() {
		return rowNo;
	}
	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public int getEducation_no() {
		return education_no;
	}
	public void setEducation_no(int education_no) {
		this.education_no = education_no;
	}
	public String getHouse_code() {
		return house_code;
	}
	public void setHouse_code(String house_code) {
		this.house_code = house_code;
	}
	public String getEducation_name() {
		return education_name;
	}
	public void setEducation_name(String education_name) {
		this.education_name = education_name;
	}
	public String getEducation_start() {
		return education_start;
	}
	public void setEducation_start(String education_start) {
		this.education_start = education_start;
	}
	public String getEducation_end() {
		return education_end;
	}
	public void setEducation_end(String education_end) {
		this.education_end = education_end;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getEducation_start_year() {
		return education_start_year;
	}
	public void setEducation_start_year(String education_start_year) {
		this.education_start_year = education_start_year;
	}
	public String getEducation_start_month() {
		return education_start_month;
	}
	public void setEducation_start_month(String education_start_month) {
		this.education_start_month = education_start_month;
	}
	public String getEducation_start_day() {
		return education_start_day;
	}
	public void setEducation_start_day(String education_start_day) {
		this.education_start_day = education_start_day;
	}
	public String getEducation_end_year() {
		return education_end_year;
	}
	public void setEducation_end_year(String education_end_year) {
		this.education_end_year = education_end_year;
	}
	public String getEducation_end_month() {
		return education_end_month;
	}
	public void setEducation_end_month(String education_end_month) {
		this.education_end_month = education_end_month;
	}
	public String getEducation_end_day() {
		return education_end_day;
	}
	public void setEducation_end_day(String education_end_day) {
		this.education_end_day = education_end_day;
	}
	public int getR_edu_no() {
		return r_edu_no;
	}
	public void setR_edu_no(int r_edu_no) {
		this.r_edu_no = r_edu_no;
	}
	public String getR_edu_title() {
		return r_edu_title;
	}
	public void setR_edu_title(String r_edu_title) {
		this.r_edu_title = r_edu_title;
	}
	public String getR_edu_start() {
		return r_edu_start;
	}
	public void setR_edu_start(String r_edu_start) {
		this.r_edu_start = r_edu_start;
	}
	public String getR_edu_end() {
		return r_edu_end;
	}
	public void setR_edu_end(String r_edu_end) {
		this.r_edu_end = r_edu_end;
	}
	public String getR_edu_place() {
		return r_edu_place;
	}
	public void setR_edu_place(String r_edu_place) {
		this.r_edu_place = r_edu_place;
	}
	public String getR_edu_tel() {
		return r_edu_tel;
	}
	public void setR_edu_tel(String r_edu_tel) {
		this.r_edu_tel = r_edu_tel;
	}
	public String getR_edu_summary() {
		return r_edu_summary;
	}
	public void setR_edu_summary(String r_edu_summary) {
		this.r_edu_summary = r_edu_summary;
	}
	public String getR_edu_contents() {
		return r_edu_contents;
	}
	public void setR_edu_contents(String r_edu_contents) {
		this.r_edu_contents = r_edu_contents;
	}
	public String getRegion_code() {
		return region_code;
	}
	public void setRegion_code(String region_code) {
		this.region_code = region_code;
	}
	public String getAttached_file_id() {
		return attached_file_id;
	}
	public void setAttached_file_id(String attached_file_id) {
		this.attached_file_id = attached_file_id;
	}
	public String getDisplay_yn() {
		return display_yn;
	}
	public void setDisplay_yn(String display_yn) {
		this.display_yn = display_yn;
	}
	public String getRegion_name() {
		return region_name;
	}
	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	public String getAttached_file_yn() {
		return attached_file_yn;
	}
	public void setAttached_file_yn(String attached_file_yn) {
		this.attached_file_yn = attached_file_yn;
	}
	public String getAttached_file_cnt() {
		return attached_file_cnt;
	}
	public void setAttached_file_cnt(String attached_file_cnt) {
		this.attached_file_cnt = attached_file_cnt;
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
	public String getStandard_date() {
		return standard_date;
	}
	public void setStandard_date(String standard_date) {
		this.standard_date = standard_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEducation_end2() {
		return education_end2;
	}
	public void setEducation_end2(String education_end2) {
		this.education_end2 = education_end2;
	}
	
	
	
	
	
}
