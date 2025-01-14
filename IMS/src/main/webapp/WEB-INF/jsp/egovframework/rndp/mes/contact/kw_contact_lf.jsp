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
	document.frm.action = "/mes/contact/kw_contact_lf.do";
	document.frm.submit();
}
function go_insert() {
	document.frm.action = "/mes/contact/kw_contact_if.do";
	document.frm.submit();
}
// 저장
viewService.prototype.go_view = function(obj) {
	$("#mloader").show();
	$("#eContactNum").val(obj.childNodes[0].querySelectorAll("input")[0].value);
	document.frm.action = "/mes/contact/kw_contact_uf.do";
	document.frm.submit();
}
$(document).ready(function() {
	$('table[role="grid"].gridjs-table th:nth-child(1) button').hide();
});
</script>
<style>
td.gridjs-td{padding:.7rem;}
</style>              
<form id="frm" name="frm" method="post">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesContactVO.pageIndex}" />
	
	<input type="hidden" id="eContactNum" name="eContactNum" value="" />
	
	<div class="content_up">
		<div class="content_tit">
			<h2>담당자 정보관리 </h2>
		</div>
	
		<div class="tbl_top">
			<ul class="tbl_top_left" >
				<li>담당자명:		
	            	<input type="text" class="input_search" id="searchWord" name="searchWord" value="${mesContactVO.searchWord}" maxlength="20"/>
	           	</li>
	           	<li>	
	           		<a style="cursor: pointer;" onclick="fn_guestList(1)">검색</a>        	     			
				</li>	
			</ul>
		</div>
	</div>

	<div class="lf_tbl_list">
   		<table id="myTable" >
    	   	<thead>
				<tr>
		           	<th style="width: 10%;">No.</th>
		           	<th>소속사명</th>
		           	<th>부서명</th>
		           	<th>담당자명</th>
					<th>연락처</th>
					<th>메일</th>
					<th>기타</th>
				</tr>
    	   	</thead>
       		<tbody>
         		<c:forEach var="list" items="${infoList}" varStatus="i">
         			<tr style="cursor: pointer;" onclick="go_update('${list.eContactNum}');">
           				<td>
           					${paginationInfo.totalRecordCount - (mesContactVO.pageIndex-1) * paginationInfo.recordCountPerPage  - i.index}
           					<input type="hidden" value="${list.eContactNum}" />
           				</td>
           				<td>
           					${list.eAgencyName}
           				</td>
           				<td>
           					${list.eDepartmentName}
           				</td>
           				<td>
           					 ${list.eContactName} 
           				</td>
           				<td>
           					 ${list.ePhoneNumber} 
           				</td>
           				<td>
           					 ${list.eEmail}
           				</td>
           				<td>
           				     ${list.eNotes}
           				</td>
         			</tr>
         		</c:forEach>
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
			 
				</ul>
			<ul class="tbl_bottom_right" >
				<li>
					<a style="cursor: pointer;" onclick="go_insert();">등록</a>
				</li>
			 
			</ul>
	</div>
</form>
