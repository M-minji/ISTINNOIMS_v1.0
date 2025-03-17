<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 그리드 S -->
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/gridjs.production.min.js"></script>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery-ui.min.js"></script>

<link href="/css/mes/mermaid.min.css" rel="stylesheet"	type="text/css" />
<link href="/css/mes/mermaid2.min.css" rel="stylesheet"	/>
<link href="/css/mes/jquery-ui.min.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
 
//현재날짜
function nowDate(){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
    var nowDate = year + "-" + month + "-" + day;
	
    return nowDate;
}

function setStartDate(d) {
    var settingDate = new Date();
    if(d == '7'){
        settingDate.setDate(settingDate.getDate()-7);
    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
    }else if(d == '1'){
        settingDate.setMonth(settingDate.getMonth()-1);
    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
    }else{
        settingDate.setMonth(settingDate.getMonth()-3);
    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
    }
    fn_guestList(1);
}

//검색
function fn_guestList(pageNo) {
	$("#mloader").show();
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "/mes/blueprint/kw_sr_lf.do";
	document.frm.submit();
}

//ENTER
function fn_keyDown(){
	if(event.keyCode == 13){
		fn_guestList(1);
	}			
}

//등록
function go_insert(){
	$("#mloader").show();
	document.frm.action = "/mes/blueprint/kw_sr_if.do";
	document.frm.submit();
}

//BOM 상세
viewService.prototype.go_view = function(obj) {
	if(obj.childNodes[0].querySelector("input")){
		$("#mloader").show();
		$("#eIssueKey").val(obj.childNodes[0].querySelector("input").value);
		document.frm.action = "/mes/blueprint/kw_sr_vf.do";
		document.frm.submit();
	}
}
$(document).ready(function() {
	 // No를 제외한 나머지 열의 너비를 150px로 설정-다른항목 한가지를 제외하고 공통으로 변경할때 -
	// 	  $('table[role="grid"].gridjs-table th:not(:nth-child(1))').css('width', '150px');
   // 그리드 헤더의 너비를 조정하는 스타일 변경
 $('gridjs-wrapper').css('overflow-y', 'hidden');  
 $('gridjs-tr').css('overflow-y', 'hidden');  
 $('table[role="grid"].gridjs-table th:nth-child(1) button').hide();
 $('table[role="grid"].gridjs-table th:nth-child(1)').css('width', '70px'); 
 $('table[role="grid"].gridjs-table th:nth-child(2)').css('width', '100px'); 
 $('table[role="grid"].gridjs-table th:nth-child(3)').css('width', '100px'); 
 $('table[role="grid"].gridjs-table th:nth-child(4)').css('width', '100px'); 
 $('table[role="grid"].gridjs-table th:nth-child(5)').css('width', '240px'); 
 $('table[role="grid"].gridjs-table th:nth-child(6)').css('width', '240px'); 
 $('table[role="grid"].gridjs-table th:nth-child(7)').css('width', '240px'); 
 $('table[role="grid"].gridjs-table th:nth-child(8)').css('width', '140px'); 
 $('table[role="grid"].gridjs-table th:nth-child(9)').css('width', '140px'); 
 $('table[role="grid"].gridjs-table th:nth-child(10)').css('width', '260px'); 
 tdBlock(9);
 datepickerSet('topStartDate', 'topEndDate');
 $('#mloader').hide();
});



function startApproval(eIssueKey, sSignStatus){
	$("#mloader").show();
	$("#eIssueKey").val(eIssueKey);
	$("#sSignStatus").val(sSignStatus);
	document.frm.action = "/mes/blueprint/kw_sr_lfr.do";
	document.frm.submit();
}

function excelDwonload(){
    document.frm.action = "/mes/blueprint/kw_srExcelListDwonload.do";
    document.frm.submit();
    document.frm.action = "/mes/blueprint/kw_sr_lf.do";
}

</script>


<form id="frm" name="frm" method="post" action="/mes/blueprint/kw_sr_lf.do">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesBlueprintVO.pageIndex}" />
	<input type="hidden" id="eIssueKey" name="eIssueKey" />
	<input type="hidden" id="sSignStatus" name="sSignStatus" />

	<div class="content_up">
		<div class="content_tit">
			<h2>SR관리 </h2>
		</div>
	
		<div class="tbl_top">
			<ul class="tbl_top_left" >
				 <li>
					<span>요청자</span>
					<input type="text" id="eTextSearchWord1" name="eTextSearchWord1" style="width:120px;" class="searchWord" value="${mesBlueprintVO.eTextSearchWord1}" maxlength="30"  />
				</li>
				<li>
					<span>요청내용</span>
					<input type="text" id="eTextSearchWord2" name="eTextSearchWord2" style="width:120px;" class="searchWord" value="${mesBlueprintVO.eTextSearchWord2}" maxlength="30" />
				</li>
				<li>
					<span>요청사유</span>
					<input type="text" id="eTextSearchWord3" name="eTextSearchWord3" style="width:120px;" class="searchWord" value="${mesBlueprintVO.eTextSearchWord3}" maxlength="30" />
				</li>
				<li>
					<span>해결방법</span>
					<input type="text" id="eTextSearchWord4" name="eTextSearchWord4" style="width:120px;" class="searchWord" value="${mesBlueprintVO.eTextSearchWord4}" maxlength="30" />
				</li>
	    	
	     		<li>
	           		<span>요청일자</span>
		       		<input type="text" id="topStartDate" name="topStartDate" class="inp_color" style="width:100px;" value="${mesBlueprintVO.topStartDate}" readonly />
		           	~ <input type="text" id="topEndDate" name="topEndDate" class="inp_color" style="width:100px;" value="${mesBlueprintVO.topEndDate}" readonly />
				</li>
	    		<li>	
	     			<a style="cursor: pointer;" onclick="fn_guestList(1)">
	     				검색
	     			</a>
	    		</li>
				<li>
					<a onclick="excelDwonload();" style="cursor: pointer;">
		    			현황 엑셀 다운로드
		     		</a>
				</li>
	    	</ul>
	    </div>		
 	</div>   
   <div id="tableContainer" class="lf_tbl_list"  >
		<table id="myTable"  >
			<thead>
				<tr>
					<th>No.</th>
					<th>작성자</th>
					<th>요청일자</th>
					<th>요청자</th>
					<th>요청내용</th>
					<th>요청사유</th>
					<th>해결방법</th>
					<th>처리시작일시</th>
					<th>처리완료일시</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${infoList}" varStatus="i">
					<tr onclick="eView(<c:out value='${list.eIssueKey}'/>);">
						<td>
							<c:if test="${list.eViewGubun eq 'Y'}"><span style="color: RED;">!</span></c:if>
							${paginationInfo.totalRecordCount - (mesBlueprintVO.pageIndex-1) * paginationInfo.recordCountPerPage  - i.index}
							<input type="hidden" value="${list.eIssueKey}" />
						</td>
						<td>${list.kStaffName} 	</td>
						<td>${list.eReqDate} 	</td>
						<td>${list.eRequester} 	</td>
						<td>${list.eReqContent}</td>
						<td>${list.eIssueCause}</td>
						<td>${list.eSolutionMethod}</td>
						
						<td>${list.eWorkStart}</td>
						<td>${list.eWorkEnd}</td>
						<td>
							<c:if test="${list.sSignStatus eq '제외' || list.sSignStatus eq '승인' || list.sSignStatus eq '반려'}">결재 ${list.sSignStatus}:</c:if>
							<c:if test="${list.sSignStatus eq '등록'}">
								<c:if test="${list.kStaffKey eq staffVO.kStaffKey}">
									<a style="cursor: pointer;" class="mes_btn" onclick="startApproval('${list.eIssueKey}','Y');">승인요청</a>
								</c:if>
								<c:if test="${list.kStaffKey ne staffVO.kStaffKey}">결재 준비</c:if>
							</c:if>							
							<c:if test="${list.sSignStatus eq '승인요청'}">
								<c:if test="${list.kStaffKey eq staffVO.kStaffKey && list.sSignProgress eq '0'}">
									<a style="cursor: pointer;" class="mes_btn" onclick="startApproval('${list.eIssueKey}','N');">요청취소</a>
								</c:if>
								<c:if test="${list.kStaffKey ne staffVO.kStaffKey || list.sSignProgress ne '0'}">결재 진행 중</c:if>
							</c:if>
							<c:if test="${list.sSignStatus eq '승인' || list.sSignStatus eq '제외'}">
									${list.eStatus}완료
							</c:if>
						 </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="tbl_paging">
			<span>
				<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_guestList"/>
			</span>
		</div>
	</div>	
  	    <div class="tbl_bottom"> 
  	    	<ul class="tbl_bottom_left" >
				<li>
					<select name="recordCountPerPage" class="select_recordCountPerPage" id="recordCountPerPage" onchange="fn_guestList(1)">
	              		<option value="10" <c:if test="${mesBlueprintVO.recordCountPerPage eq 10}">selected="selected"</c:if>>Page/10</option>
	              		<option value="20" <c:if test="${mesBlueprintVO.recordCountPerPage eq 20}">selected="selected"</c:if>>Page/20</option>
	              		<option value="50" <c:if test="${mesBlueprintVO.recordCountPerPage eq 50}">selected="selected"</c:if>>Page/50</option>
	              		<option value="100" <c:if test="${mesBlueprintVO.recordCountPerPage eq 100}">selected="selected"</c:if>>Page/100</option>
	           		</select> 
				</li>
			</ul>
  		    <ul class="tbl_bottom_right">		
		    	<c:if test="${staffVO.kStaffAuthWriteFlag eq 'T'}">
		    		<li>
		    			<a style="cursor: pointer;" onclick="go_insert();" >
		    				등록
		    			</a>
		    		</li>
	    		</c:if>
			</ul>	    
	    </div>		

	
	
</form>

	
