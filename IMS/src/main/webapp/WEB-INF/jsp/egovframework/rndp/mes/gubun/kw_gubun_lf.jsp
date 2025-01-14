<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!-- 그리드 S -->
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/gridjs.production.min.js"></script>
<link href="/css/mes/mermaid.min.css" rel="stylesheet"	type="text/css" />
<link href="/css/mes/mermaid2.min.css" rel="stylesheet"	/>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery-ui.min.js"></script>
<link href="/css/mes/jquery-ui.min.css" rel="stylesheet"	type="text/css" />
<script type="text/javascript">
// 검색
function fn_guestList(pageNo) {
	$("#mloader").show();
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "/mes/gubun/kw_gubun_lf.do";
	document.frm.submit();
}

// 저장
viewService.prototype.go_view = function(obj) {
	$("#mloader").show();
	$("#sGubunKey").val(obj.childNodes[0].querySelectorAll("input")[0].value);
	document.frm.action = "/mes/gubun/kw_gubun_uf.do";
	document.frm.submit();
}


//구분관리 등록
function go_subInsert(){
	document.frm.pageIndex.value = "1";
	document.frm.searchWord.value = "";
	document.frm.action = "/mes/gubun/gubunCate/kw_gubunCate_lf.do";
	document.frm.submit();
}

// 상세코드 등록
function go_insert(){
	$('#mloader').show();
	document.frm.action = "/mes/gubun/kw_gubun_if.do";
	document.frm.submit();
}
$(document).ready(function() {
	$('#mloader').hide();
	$('table[role="grid"].gridjs-table th:nth-child(1) button').hide();
});
</script>
<style>
td.gridjs-td{padding:.7rem;}
</style>              
<form id="frm" name="frm" method="post" action="/mes/gubun/kw_gubun_lf.do">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesGubunVO.pageIndex}" />
	
	<input type="hidden" id="sGubunKey" name="sGubunKey" value="" />
	
	<div class="content_up">
		<div class="content_tit">
			<h2>코드관리 </h2>
		</div>
	
		<div class="tbl_top">
			<ul class="tbl_top_left" >
				<li>
					<select id="searchGubun" name="searchGubun">
						<option value="" selected>전체</option>
						<c:forEach var="gubunCateList" items="${gubunCateList}">
							<option value="${gubunCateList.sGubunCateKey}" <c:if test="${gubunCateList.sGubunCateKey eq mesGubunVO.searchGubun}">selected</c:if>>
								<c:out value="${gubunCateList.sGubunCateName}" />
							</option>
						</c:forEach>
			      	</select>
			    </li>
				<li>		
	            	<input type="text" class="input_search" id="searchWord" name="searchWord" value="${mesGubunVO.searchWord}" />
	           	</li>
	           	<li>	
	           		<a style="cursor: pointer;" onclick="fn_guestList(1)">검색</a>        	     			
				</li>	
			</ul>
		</div>
	</div>

	<div class="lf_tbl_list">
   		<table id="myTable"  style="width:100%; height:500px; overflow:auto;">
    	   	<thead>
				<tr>
		           	<th style="width: 10%;">No.</th>
		           	<th>구분</th>
					<th>구분명</th>
					<th>영문표기(약어)</th>
				</tr>
    	   	</thead>
       		<tbody>
         		<c:forEach var="gubunList" items="${gubunList}" varStatus="i">
         			<tr style="cursor: pointer;" onclick="go_update('${gubunList.sGubunKey}');">
           				<td>
           					${paginationInfo.totalRecordCount - (mesGubunVO.pageIndex-1) * paginationInfo.recordCountPerPage  - i.index}
           					<input type="hidden" value="${gubunList.sGubunKey}" />
           				</td>
           				<td>
           					<c:out value="${gubunList.sGubunCateName}" />
           				</td>
           				<td>
           					<c:out value="${gubunList.sGubunName}" />	
           				</td>
           				<td>
           					<c:out value="${gubunList.sGubunEtc}"/>
           				</td>
         			</tr>
         		</c:forEach>
         		<c:if test="${empty gubunList}">
					<tr>
						<td colspan="4">내역이 없습니다.</td>
					</tr>
				</c:if>
       		</tbody>
		</table>
		<div class="tbl_paging">
		  	<span>
				<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_guestList" />
		  	</span>
		</div>
	</div>
	

	
	
	<div class="tbl_bottom" style="margin-top: 90px;">
			<ul class="tbl_bottom_left" >
				<li>
					<select id="recordCountPerPage" name="recordCountPerPage" class="select_recordCountPerPage" onchange="fn_guestList(1)">
	              		<option value="10" <c:if test="${mesGubunVO.recordCountPerPage eq 10}">selected="selected"</c:if>>Page/10</option>
	              		<option value="20" <c:if test="${mesGubunVO.recordCountPerPage eq 20}">selected="selected"</c:if>>Page/20</option>
	              		<option value="50" <c:if test="${mesGubunVO.recordCountPerPage eq 50}">selected="selected"</c:if>>Page/50</option>
	              		<option value="100" <c:if test="${mesGubunVO.recordCountPerPage eq 100}">selected="selected"</c:if>>Page/100</option>
	           		</select>
				  </li>
				</ul>
			<ul class="tbl_bottom_right" >
				<c:if test="${staffVo.kStaffAuthWriteFlag eq 'T'}">
					<li> 
						<a style="cursor: pointer;" onclick="go_insert();">상세코드등록</a>
					</li>
					<li>	
						<a style="cursor: pointer;" onclick="go_subInsert();">구분관리</a>	
					</li>
				</c:if>
			</ul>
	</div>
</form>
