<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<script type="text/javascript">

$(function(){
})


function selectAdd(num){  
	var obj = {
			ePosition :	$("#eDepartmentName_"+num).val(),
			eName :	$("#eContactName_"+num).val()
	}
	 
	if(typeof(opener.setReturnTextPop) != "undefined"){
	window.opener.setReturnTextPop(obj);
	window.close();
	}
}
	 
// 검색
function fn_guestList(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "/mes/contact/kw_info_list.do";
	document.frm.submit();
}

 
</script>

<form id="frm" name="frm" method="post" action="/mes/contact/kw_info_list.do">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesContactVO.pageIndex}">
	<input type="hidden" id="searchType" name="searchType" value="${mesContactVO.searchType}">
	
	<div class="pop_head">
		<div id="pop_head">
			<div class="tit">
				<h3>담당자 선택</h3>
			</div>
			<a href="javascript:self.close();"><img src="/images/btn/close.gif" width="22" height="21" /></a>
		</div>
	</div>
		
	<div class="popup_content">		
		<div id="itemCateZone" class="tbl_top">
			<ul class="tbl_top_left">
				<li>담당자명:		
	            	<input type="text" class="input_search" id="searchWord" name="searchWord" value="${mesContactVO.searchWord}" />
	           	</li>
	           	<li>	
	           		<a style="cursor: pointer;" onclick="fn_guestList(1)">검색</a>        	     			
				</li>	
			</ul> 
		</div>
		
		
		<div class="lf_tbl_list" id="pop_result_list">
			<table>
		        <thead>
					<tr>
					 	<th>속소사명</th>
			           	<th>부서명</th>
			           	<th>담당자명</th>
						<th>연락처</th>
						<th>메일</th>
					</tr>
		        </thead>
		        <tbody>
					<c:forEach var="list" items="${infoList}" varStatus="i">
	         			<tr style="cursor: pointer;" onclick="selectAdd('${i.index}');">
	           				<td>
	           					<c:out value="${list.eAgencyName}" />
	           					<input type="hidden" id="eAgencyName_${i.index}" value="${list.eAgencyName}" />
	           					<input type="hidden" id="eDepartmentName_${i.index}" value="${list.eDepartmentName}" />
	           					<input type="hidden" id="eContactName_${i.index}" value="${list.eContactName}" />
	           					<input type="hidden" id="ePhoneNumber_${i.index}" value="${list.ePhoneNumber}" />
	           				</td>
	           				<td>
	           					<c:out value="${list.eDepartmentName}" />	
	           				</td>
	           				<td>
	           					<c:out value="${list.eContactName}"/>
	           				</td>
	           				<td>
	           					<c:out value="${list.ePhoneNumber}" />	
	           				</td>
	           				<td>
	           					<c:out value="${list.eEmail}"/>
	           				</td>
	         			</tr>
	         		</c:forEach>
					<c:if test="${empty infoList}">
						<tr>
							<td colspan="20">내역이 없습니다.</td>
						</tr>
					</c:if>
		        </tbody>
			</table>
		</div>		
		
		<div class="page">	
			<span>
		  		<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_guestList" />
			</span>
		</div>	
	</div>
</form>

