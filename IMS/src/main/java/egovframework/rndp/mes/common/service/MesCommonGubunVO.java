package egovframework.rndp.mes.common.service;

import egovframework.rndp.com.cmm.service.DefultVO;

public class MesCommonGubunVO extends DefultVO{
	private String sGubunKey					= "";
	private String sGubunCateKey             	= "";
	private String sGubunName                 	= "";
	private String sGubunMemo                 	= "";
	private String sGubunWdate                	= "";
	private String sGubunUdate	            	= "";
	private String sGubunCateTable           	= "";
	private String sGubunCateColumn          	= "";
	private String sGubunCateName            	= "";
	private String sGubunCateMean            	= "";
	private String sGubunCateWdate           	= "";
	private String sGubunCateUdate           	= "";
	private String searchWord					= "";
	private String sGubunCateKeySearch			= "";
	private String sGubunProcessCondition		= "";
	
	private String eTable		= "";
	private String eColumn		= "";
	private String ePkey		= "";
	
	
	
	
	public String geteColumn() {
		return eColumn;
	}
	public void seteColumn(String eColumn) {
		this.eColumn = eColumn;
	}
	public String getePkey() {
		return ePkey;
	}
	public void setePkey(String ePkey) {
		this.ePkey = ePkey;
	}
	public String geteTable() {
		return eTable;
	}
	public void seteTable(String eTable) {
		this.eTable = eTable;
	}
	public String getsGubunKey() {
		return sGubunKey;
	}
	public void setsGubunKey(String sGubunKey) {
		this.sGubunKey = sGubunKey;
	}
	public String getsGubunCateKey() {
		return sGubunCateKey;
	}
	public void setsGubunCateKey(String sGubunCateKey) {
		this.sGubunCateKey = sGubunCateKey;
	}
	public String getsGubunName() {
		return sGubunName;
	}
	public void setsGubunName(String sGubunName) {
		this.sGubunName = sGubunName;
	}
	public String getsGubunMemo() {
		return sGubunMemo;
	}
	public void setsGubunMemo(String sGubunMemo) {
		this.sGubunMemo = sGubunMemo;
	}
	public String getsGubunWdate() {
		return sGubunWdate;
	}
	public void setsGubunWdate(String sGubunWdate) {
		this.sGubunWdate = sGubunWdate;
	}
	public String getsGubunUdate() {
		return sGubunUdate;
	}
	public void setsGubunUdate(String sGubunUdate) {
		this.sGubunUdate = sGubunUdate;
	}
	public String getsGubunCateTable() {
		return sGubunCateTable;
	}
	public void setsGubunCateTable(String sGubunCateTable) {
		this.sGubunCateTable = sGubunCateTable;
	}
	public String getsGubunCateColumn() {
		return sGubunCateColumn;
	}
	public void setsGubunCateColumn(String sGubunCateColumn) {
		this.sGubunCateColumn = sGubunCateColumn;
	}
	public String getsGubunCateName() {
		return sGubunCateName;
	}
	public void setsGubunCateName(String sGubunCateName) {
		this.sGubunCateName = sGubunCateName;
	}
	public String getsGubunCateMean() {
		return sGubunCateMean;
	}
	public void setsGubunCateMean(String sGubunCateMean) {
		this.sGubunCateMean = sGubunCateMean;
	}
	public String getsGubunCateWdate() {
		return sGubunCateWdate;
	}
	public void setsGubunCateWdate(String sGubunCateWdate) {
		this.sGubunCateWdate = sGubunCateWdate;
	}
	public String getsGubunCateUdate() {
		return sGubunCateUdate;
	}
	public void setsGubunCateUdate(String sGubunCateUdate) {
		this.sGubunCateUdate = sGubunCateUdate;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getsGubunCateKeySearch() {
		return sGubunCateKeySearch;
	}
	public void setsGubunCateKeySearch(String sGubunCateKeySearch) {
		this.sGubunCateKeySearch = sGubunCateKeySearch;
	}
	public String getsGubunProcessCondition() {
		return sGubunProcessCondition;
	}
	public void setsGubunProcessCondition(String sGubunProcessCondition) {
		this.sGubunProcessCondition = sGubunProcessCondition;
	}
}
