package returnProject.popup.service;

import egovframework.com.cmm.service.FileVO;

public class PopupVO {

	private String rownum;			// 번호
	private String popup_no;		// no
	private String title;			// 제목
	private String input_type;		// 팝업 입력형식(image, html)
	private String output_type;		// 팝업 출력형식(layer, window)
	private String size_width;		// 창크기 너비
	private String size_height;		// 창크기 높이
	private String view_width;		// 창위치 가로
	private String view_height;		// 창위치 세로
	private String link;			// 링크 url 주소
	private String start_date;		// 시작일
	private String end_date;		// 종료일
	private String reg_date;		// 등록일
	private String contents;		// 대체텍스트
	private String target;			// 타겟(_blank, _self)
	private String view_flag;		// 게시여부(Y,N)
	private String view_type;		// 구분(organ, info, popup)	
	private String type;			// 수정 or 등록 구분값
	
	private String atch_file_id;	// 파일 ID
	private String file_sn;			// 파일 sn
	private String orignl_file_nm;	// 파일 name
	private FileVO file;
	
	
	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAtch_file_id() {
		return atch_file_id;
	}

	public void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}

	public String getInput_type() {
		return input_type;
	}

	public void setInput_type(String input_type) {
		this.input_type = input_type;
	}

	public String getOutput_type() {
		return output_type;
	}

	public void setOutput_type(String output_type) {
		this.output_type = output_type;
	}

	public String getSize_width() {
		return size_width;
	}

	public void setSize_width(String size_width) {
		this.size_width = size_width;
	}

	public String getSize_height() {
		return size_height;
	}

	public void setSize_height(String size_height) {
		this.size_height = size_height;
	}

	public String getView_width() {
		return view_width;
	}

	public void setView_width(String view_width) {
		this.view_width = view_width;
	}

	public String getView_height() {
		return view_height;
	}

	public void setView_height(String view_height) {
		this.view_height = view_height;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getView_flag() {
		return view_flag;
	}

	public void setView_flag(String view_flag) {
		this.view_flag = view_flag;
	}

	public String getView_type() {
		return view_type;
	}

	public void setView_type(String view_type) {
		this.view_type = view_type;
	}

	public FileVO getFile() {
		return file;
	}

	public void setFile(FileVO file) {
		this.file = file;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getPopup_no() {
		return popup_no;
	}

	public void setPopup_no(String popup_no) {
		this.popup_no = popup_no;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFile_sn() {
		return file_sn;
	}

	public void setFile_sn(String file_sn) {
		this.file_sn = file_sn;
	}

	public String getOrignl_file_nm() {
		return orignl_file_nm;
	}

	public void setOrignl_file_nm(String orignl_file_nm) {
		this.orignl_file_nm = orignl_file_nm;
	}
	
	
}
