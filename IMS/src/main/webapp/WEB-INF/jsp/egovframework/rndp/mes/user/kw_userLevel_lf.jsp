<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>   

<script>
	$(document).ready(function() {
		 $('table[role="grid"].gridjs-table tr').css("cursor","default");
		 $('table[role="grid"].gridjs-table th:nth-child(1) button').hide();
	});
	function go_insert(){
		document.listForm.action="/mes/user/kw_userLevel_if.do";
		document.listForm.submit();
	}
	function userLevelInfo(key){
		document.listForm.kClassKey.value = key;
		document.listForm.action="/mes/user/kw_userLevel_uf.do";
		document.listForm.submit();		
	}
	function userLevelDel(key){
		if(confirm("삭제하시겠습니까?")){
			document.listForm.kClassKey.value = key;
			document.listForm.action="/mes/user/kw_userLevel_d.do";
			document.listForm.submit();			
		}
	}
	
	function mesUserMenu(key){
		document.listForm.kClassKey.value = key;
		document.listForm.action = "/mes/user/kw_userMenu_vf.do";
		document.listForm.submit();
	}
</script>
<!-- 그리드 S -->
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/gridjs.production.min.js"></script>
<link href="/css/mes/mermaid.min.css" rel="stylesheet"	type="text/css" />
<link href="/css/mes/mermaid2.min.css" rel="stylesheet"	/>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery-ui.min.js"></script>
<link href="/css/mes/jquery-ui.min.css" rel="stylesheet"	type="text/css" />

<style>
td.gridjs-td:last-child{text-align:center !important;} 
</style>
<form name="listForm" id="listForm">	
<input type="hidden" name="kClassKey" id="kClassKey" />	

		<div class="content_up">
			<div class="content_tit">
				<h2>직급 관리</h2>	 
			</div>
		</div>

		
		
			<div class="lf_tbl_list">
				<table id="myTable" >
					<colgroup>
						<col width="7%" />
						<col width="*" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>직급명</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="levelList" items="${levelList}" varStatus="i">
							<tr>
								<td>${i.index + 1}</td>
								<td>${levelList.kClassName}</td>
								<td>
									<c:if test="${staffVo.kStaffAuthModifyFlag eq 'T'}">
										<a class="list_btn" onclick="userLevelInfo(${levelList.kClassKey})">
											수정
										</a>
									</c:if>
								 	<c:if test="${staffVo.kStaffAuthDelFlag eq 'T'}">
										<a class="list_btn" onclick="userLevelDel(${levelList.kClassKey})">
											삭제
										</a>									
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="tbl_paging">
		<%-- 	<span><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_guestList" /></span> --%>
		          </div>
			</div>
		
		
		<div class="tbl_bottom">
			<ul class="tbl_bottom_right" > 
				<c:if test="${staffVo.kStaffAuthWriteFlag eq 'T'}">
					<li><a onclick="go_insert()">등록</a></li>
				</c:if>
			</ul>
		</div>
</form>