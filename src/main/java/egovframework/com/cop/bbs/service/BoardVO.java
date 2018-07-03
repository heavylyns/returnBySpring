package egovframework.com.cop.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * 게시물 관리를 위한 VO 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 *   2009.06.29  한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class BoardVO extends Board implements Serializable {

    /** 검색시작일 */
    private String searchBgnDe = "";
    
    /** 검색조건 */
    private String searchCnd = "";
    
    /** 검색종료일 */
    private String searchEndDe = "";
    
    /** 검색단어 */
    private String searchWrd = "";
    
    /** 정렬순서(DESC,ASC) */
    private long sortOrdr = 0L;

    /** 검색사용여부 */
    private String searchUseYn = "";

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

    /** 최초 등록자명 */
    private String frstRegisterNm = "";

    /** 최종 수정자명 */
    private String lastUpdusrNm = "";

    /** 유효여부 */
    private String isExpired = "N";

    /** 상위 정렬 순서 */
    private String parntsSortOrdr = "";

    /** 상위 답변 위치 */
    private String parntsReplyLc = "";

    /** 게시판 유형코드 */
    private String bbsTyCode = "";
    
    /** 게시판 속성코드 */
    private String bbsAttrbCode = "";

    /** 게시판 명 */
    private String bbsNm = "";

    /** 파일첨부가능여부 */
    private String fileAtchPosblAt = "";
    
    /** 첨부가능파일숫자 */
    private int posblAtchFileNumber = 0;
    
    /** 답장가능여부 */
    private String replyPosblAt = "";
    
    /** 조회 수 증가 여부 */
    private boolean plusCount = false;
    
    private String boardCode;
    
    private String boardNo;
    
    private String regionCode;
    
    //---------------------------------
    // 2009.06.29 : 2단계 기능 추가
    //---------------------------------
    /** 하위 페이지 인덱스 (댓글 및 만족도 조사 여부 확인용) */
    private String subPageIndex = "";
    ////-------------------------------

    /**
     * searchBgnDe attribute를 리턴한다.
     * 
     * @return the searchBgnDe
     */
    public String getSearchBgnDe() {
	return searchBgnDe;
    }

    /**
     * searchBgnDe attribute 값을 설정한다.
     * 
     * @param searchBgnDe
     *            the searchBgnDe to set
     */
    public void setSearchBgnDe(String searchBgnDe) {
	this.searchBgnDe = searchBgnDe;
    }

    /**
     * searchCnd attribute를 리턴한다.
     * 
     * @return the searchCnd
     */
    public String getSearchCnd() {
	return searchCnd;
    }

    /**
     * searchCnd attribute 값을 설정한다.
     * 
     * @param searchCnd
     *            the searchCnd to set
     */
    public void setSearchCnd(String searchCnd) {
	this.searchCnd = searchCnd;
    }

    /**
     * searchEndDe attribute를 리턴한다.
     * 
     * @return the searchEndDe
     */
    public String getSearchEndDe() {
	return searchEndDe;
    }

    /**
     * searchEndDe attribute 값을 설정한다.
     * 
     * @param searchEndDe
     *            the searchEndDe to set
     */
    public void setSearchEndDe(String searchEndDe) {
	this.searchEndDe = searchEndDe;
    }

    /**
     * searchWrd attribute를 리턴한다.
     * 
     * @return the searchWrd
     */
    public String getSearchWrd() {
	return searchWrd;
    }

    /**
     * searchWrd attribute 값을 설정한다.
     * 
     * @param searchWrd
     *            the searchWrd to set
     */
    public void setSearchWrd(String searchWrd) {
	this.searchWrd = searchWrd;
    }

    /**
     * sortOrdr attribute를 리턴한다.
     * 
     * @return the sortOrdr
     */
    public long getSortOrdr() {
	return sortOrdr;
    }

    /**
     * sortOrdr attribute 값을 설정한다.
     * 
     * @param sortOrdr
     *            the sortOrdr to set
     */
    public void setSortOrdr(long sortOrdr) {
	this.sortOrdr = sortOrdr;
    }

    /**
     * searchUseYn attribute를 리턴한다.
     * 
     * @return the searchUseYn
     */
    public String getSearchUseYn() {
	return searchUseYn;
    }

    /**
     * searchUseYn attribute 값을 설정한다.
     * 
     * @param searchUseYn
     *            the searchUseYn to set
     */
    public void setSearchUseYn(String searchUseYn) {
	this.searchUseYn = searchUseYn;
    }

    /**
     * pageIndex attribute를 리턴한다.
     * 
     * @return the pageIndex
     */
    public int getPageIndex() {
	return pageIndex;
    }

    /**
     * pageIndex attribute 값을 설정한다.
     * 
     * @param pageIndex
     *            the pageIndex to set
     */
    public void setPageIndex(int pageIndex) {
	this.pageIndex = pageIndex;
    }

    /**
     * pageUnit attribute를 리턴한다.
     * 
     * @return the pageUnit
     */
    public int getPageUnit() {
	return pageUnit;
    }

    /**
     * pageUnit attribute 값을 설정한다.
     * 
     * @param pageUnit
     *            the pageUnit to set
     */
    public void setPageUnit(int pageUnit) {
	this.pageUnit = pageUnit;
    }

    /**
     * pageSize attribute를 리턴한다.
     * 
     * @return the pageSize
     */
    public int getPageSize() {
	return pageSize;
    }

    /**
     * pageSize attribute 값을 설정한다.
     * 
     * @param pageSize
     *            the pageSize to set
     */
    public void setPageSize(int pageSize) {
	this.pageSize = pageSize;
    }

    /**
     * firstIndex attribute를 리턴한다.
     * 
     * @return the firstIndex
     */
    public int getFirstIndex() {
	return firstIndex;
    }

    /**
     * firstIndex attribute 값을 설정한다.
     * 
     * @param firstIndex
     *            the firstIndex to set
     */
    public void setFirstIndex(int firstIndex) {
	this.firstIndex = firstIndex;
    }

    /**
     * lastIndex attribute를 리턴한다.
     * 
     * @return the lastIndex
     */
    public int getLastIndex() {
	return lastIndex;
    }

    /**
     * lastIndex attribute 값을 설정한다.
     * 
     * @param lastIndex
     *            the lastIndex to set
     */
    public void setLastIndex(int lastIndex) {
	this.lastIndex = lastIndex;
    }

    /**
     * recordCountPerPage attribute를 리턴한다.
     * 
     * @return the recordCountPerPage
     */
    public int getRecordCountPerPage() {
	return recordCountPerPage;
    }

    /**
     * recordCountPerPage attribute 값을 설정한다.
     * 
     * @param recordCountPerPage
     *            the recordCountPerPage to set
     */
    public void setRecordCountPerPage(int recordCountPerPage) {
	this.recordCountPerPage = recordCountPerPage;
    }

    /**
     * rowNo attribute를 리턴한다.
     * 
     * @return the rowNo
     */
    public int getRowNo() {
	return rowNo;
    }

    /**
     * rowNo attribute 값을 설정한다.
     * 
     * @param rowNo
     *            the rowNo to set
     */
    public void setRowNo(int rowNo) {
	this.rowNo = rowNo;
    }

    /**
     * frstRegisterNm attribute를 리턴한다.
     * 
     * @return the frstRegisterNm
     */
    public String getFrstRegisterNm() {
	return frstRegisterNm;
    }

    /**
     * frstRegisterNm attribute 값을 설정한다.
     * 
     * @param frstRegisterNm
     *            the frstRegisterNm to set
     */
    public void setFrstRegisterNm(String frstRegisterNm) {
	this.frstRegisterNm = frstRegisterNm;
    }

    /**
     * lastUpdusrNm attribute를 리턴한다.
     * 
     * @return the lastUpdusrNm
     */
    public String getLastUpdusrNm() {
	return lastUpdusrNm;
    }

    /**
     * lastUpdusrNm attribute 값을 설정한다.
     * 
     * @param lastUpdusrNm
     *            the lastUpdusrNm to set
     */
    public void setLastUpdusrNm(String lastUpdusrNm) {
	this.lastUpdusrNm = lastUpdusrNm;
    }

    /**
     * isExpired attribute를 리턴한다.
     * 
     * @return the isExpired
     */
    public String getIsExpired() {
	return isExpired;
    }

    /**
     * isExpired attribute 값을 설정한다.
     * 
     * @param isExpired
     *            the isExpired to set
     */
    public void setIsExpired(String isExpired) {
	this.isExpired = isExpired;
    }

    /**
     * parntsSortOrdr attribute를 리턴한다.
     * 
     * @return the parntsSortOrdr
     */
    public String getParntsSortOrdr() {
	return parntsSortOrdr;
    }

    /**
     * parntsSortOrdr attribute 값을 설정한다.
     * 
     * @param parntsSortOrdr
     *            the parntsSortOrdr to set
     */
    public void setParntsSortOrdr(String parntsSortOrdr) {
	this.parntsSortOrdr = parntsSortOrdr;
    }

    /**
     * parntsReplyLc attribute를 리턴한다.
     * 
     * @return the parntsReplyLc
     */
    public String getParntsReplyLc() {
	return parntsReplyLc;
    }

    /**
     * parntsReplyLc attribute 값을 설정한다.
     * 
     * @param parntsReplyLc
     *            the parntsReplyLc to set
     */
    public void setParntsReplyLc(String parntsReplyLc) {
	this.parntsReplyLc = parntsReplyLc;
    }

    /**
     * bbsTyCode attribute를 리턴한다.
     * 
     * @return the bbsTyCode
     */
    public String getBbsTyCode() {
	return bbsTyCode;
    }

    /**
     * bbsTyCode attribute 값을 설정한다.
     * 
     * @param bbsTyCode
     *            the bbsTyCode to set
     */
    public void setBbsTyCode(String bbsTyCode) {
	this.bbsTyCode = bbsTyCode;
    }

    /**
     * bbsAttrbCode attribute를 리턴한다.
     * 
     * @return the bbsAttrbCode
     */
    public String getBbsAttrbCode() {
	return bbsAttrbCode;
    }

    /**
     * bbsAttrbCode attribute 값을 설정한다.
     * 
     * @param bbsAttrbCode
     *            the bbsAttrbCode to set
     */
    public void setBbsAttrbCode(String bbsAttrbCode) {
	this.bbsAttrbCode = bbsAttrbCode;
    }

    /**
     * bbsNm attribute를 리턴한다.
     * 
     * @return the bbsNm
     */
    public String getBbsNm() {
	return bbsNm;
    }

    /**
     * bbsNm attribute 값을 설정한다.
     * 
     * @param bbsNm
     *            the bbsNm to set
     */
    public void setBbsNm(String bbsNm) {
	this.bbsNm = bbsNm;
    }

    /**
     * fileAtchPosblAt attribute를 리턴한다.
     * 
     * @return the fileAtchPosblAt
     */
    public String getFileAtchPosblAt() {
	return fileAtchPosblAt;
    }

    /**
     * fileAtchPosblAt attribute 값을 설정한다.
     * 
     * @param fileAtchPosblAt
     *            the fileAtchPosblAt to set
     */
    public void setFileAtchPosblAt(String fileAtchPosblAt) {
	this.fileAtchPosblAt = fileAtchPosblAt;
    }

    /**
     * posblAtchFileNumber attribute를 리턴한다.
     * 
     * @return the posblAtchFileNumber
     */
    public int getPosblAtchFileNumber() {
	return posblAtchFileNumber;
    }

    /**
     * posblAtchFileNumber attribute 값을 설정한다.
     * 
     * @param posblAtchFileNumber
     *            the posblAtchFileNumber to set
     */
    public void setPosblAtchFileNumber(int posblAtchFileNumber) {
	this.posblAtchFileNumber = posblAtchFileNumber;
    }

    /**
     * replyPosblAt attribute를 리턴한다.
     * 
     * @return the replyPosblAt
     */
    public String getReplyPosblAt() {
	return replyPosblAt;
    }

    /**
     * replyPosblAt attribute 값을 설정한다.
     * 
     * @param replyPosblAt
     *            the replyPosblAt to set
     */
    public void setReplyPosblAt(String replyPosblAt) {
	this.replyPosblAt = replyPosblAt;
    }

    /**
     * plusCount attribute를 리턴한다.
     * @return the plusCount
     */
    public boolean isPlusCount() {
        return plusCount;
    }

    /**
     * plusCount attribute 값을 설정한다.
     * @param plusCount the plusCount to set
     */
    public void setPlusCount(boolean plusCount) {
        this.plusCount = plusCount;
    }

    /**
     * subPageIndex attribute를 리턴한다.
     * @return the subPageIndex
     */
    public String getSubPageIndex() {
        return subPageIndex;
    }

    /**
     * subPageIndex attribute 값을 설정한다.
     * @param subPageIndex the subPageIndex to set
     */
    public void setSubPageIndex(String subPageIndex) {
        this.subPageIndex = subPageIndex;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

    
    
    
    /**
     * 김범수 추가
     */
    private String zip_code;	// 관리자 > 시/군별 상세현황 팝업 > 검색조건 추가
    private String dong_code;	// 관리자 > 시/군별 상세현황 팝업 > 검색조건 추가
    private String update_flag;	// 관리자 > 사용점 수리/변경 flag
    private String stat_flag;	// 관리자 > 사용점통계 flag
    private String busi_type;	// 업종코드
    private String out_flag;	// 관리자 > 사용점철회 flag
    private String mber_flag;	// 관리자 > 사용점수리 flag
    private String prev_id;		// 게시판 이전글 id
    private String prev_title;	// 게시판 이전글 title
    private String next_id;		// 게시판 다음글 id
    private String next_title;	// 게시판 다음글 title
    
    
	public String getZip_code() {
		return zip_code;
	}

	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}

	public String getDong_code() {
		return dong_code;
	}

	public void setDong_code(String dong_code) {
		this.dong_code = dong_code;
	}
	
	public String getUpdate_flag() {
		return update_flag;
	}

	public void setUpdate_flag(String update_flag) {
		this.update_flag = update_flag;
	}
	
	public String getStat_flag() {
		return stat_flag;
	}

	public void setStat_flag(String stat_flag) {
		this.stat_flag = stat_flag;
	}
	
	public String getBusi_type() {
		return busi_type;
	}

	public void setBusi_type(String busi_type) {
		this.busi_type = busi_type;
	}

	public String getOut_flag() {
		return out_flag;
	}

	public void setOut_flag(String out_flag) {
		this.out_flag = out_flag;
	}

	public String getMber_flag() {
		return mber_flag;
	}

	public void setMber_flag(String mber_flag) {
		this.mber_flag = mber_flag;
	}

	public String getPrev_id() {
		return prev_id;
	}

	public void setPrev_id(String prev_id) {
		this.prev_id = prev_id;
	}

	public String getPrev_title() {
		return prev_title;
	}

	public void setPrev_title(String prev_title) {
		this.prev_title = prev_title;
	}

	public String getNext_id() {
		return next_id;
	}

	public void setNext_id(String next_id) {
		this.next_id = next_id;
	}

	public String getNext_title() {
		return next_title;
	}

	public void setNext_title(String next_title) {
		this.next_title = next_title;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getRegionCode() {
		return regionCode;
	}

	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}

	
}
