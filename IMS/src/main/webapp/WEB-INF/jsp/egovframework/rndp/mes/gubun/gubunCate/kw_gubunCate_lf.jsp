<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">

function go_update(key){
	$("#mloader").show();
	$("#sGubunCateKey").val(key);
	document.frm.action = "/mes/gubun/gubunCate/kw_gubunCate_uf.do";
	document.frm.submit();
}

// 검색
function fn_guestList(pageNo) {
	$("#mloader").show();
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "/mes/gubun/gubunCate/kw_gubunCate_lf.do";
	document.frm.submit();
}

// 등록
function go_insert(){
	$("#mloader").show();
	document.frm.action = "/mes/gubun/gubunCate/kw_gubunCate_if.do";
	document.frm.submit();
}

// 목록
function cancel(){
	$("#mloader").show();
	document.frm.searchWord.value = "";
	document.frm.action = "/mes/gubun/kw_gubun_lf.do";
	document.frm.submit(); 
}

</script>



<form id="frm" name="frm" method="post" action="/mes/gubun/gubunCate/kw_gubunCate_lf.do">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesGubunCateVO.pageIndex}" />
	<input type="hidden" id="sGubunCateKey" name="sGubunCateKey" value="" />
	
	<div class="content_up">
		<div class="content_tit">
			<h2>구분 현황</h2>
		</div>
	
		<div class="tbl_top">	
			<ul class="tbl_top_left" >
				
				<li>
	      	     	<input type="text" class="input_search" id="searchWord" name="searchWord" maxlength="100" value="${mesGubunCateVO.searchWord}" />
	           	</li>
	           	<li>	
	           		<a style="cursor: pointer;" onclick="fn_guestList(1)">검색</a>
				</li>	
			</ul>
		</div>
	</div>


	<div class="lf_tbl_list">
   		<table>
      	 	<thead>
				<tr>
	    	       	<th style="width: 10%;">순번</th>
	    	       	<th>구분</th>
	    	       	<th>비고</th>
				</tr>
    	   	</thead>
    	   	<tbody>
    	     	<c:forEach var="gubunCateList" items="${gubunCateList}" varStatus="i" >
    	     		<tr style="cursor: pointer;" onclick="go_update('${gubunCateList.sGubunCateKey}');">
 						<td>
 							${paginationInfo.totalRecordCount - (mesGubunCateVO.pageIndex-1) * paginationInfo.recordCountPerPage  - i.index}
 						</td>
    	       			<td>
    	       				<c:out value="${gubunCateList.sGubunCateName}"/>
    	       			</td>
    	       			<td>
    	       				<c:out value="${gubunCateList.sGubunCateEtc}"/>
    	       			</td>
    	     		</tr>
    	     	</c:forEach>
    	     	<c:if test="${empty gubunCateList}">
					<tr>
						<td colspan="3">내역이 없습니다.</td>
					</tr>
				</c:if>
    	   	</tbody>
		</table>
	</div>
	
		<div class="tbl_bottom">	
			<ul class="tbl_bottom_left">	
				<li>
					<select name="recordCountPerPage" class="select_recordCountPerPage" id="recordCountPerPage" onchange="fn_guestList(1)">
	              		<option value="10" <c:if test="${mesGubunCateVO.recordCountPerPage eq 10}">selected="selected"</c:if>>Page/10</option>
	              		<option value="20" <c:if test="${mesGubunCateVO.recordCountPerPage eq 20}">selected="selected"</c:if>>Page/20</option>
	              		<option value="50" <c:if test="${mesGubunCateVO.recordCountPerPage eq 50}">selected="selected"</c:if>>Page/50</option>
	              		<option value="100" <c:if test="${mesGubunCateVO.recordCountPerPage eq 100}">selected="selected"</c:if>>Page/100</option>
	           		</select>
				</li>		
			</ul>
				<ul class="tbl_bottom_right">				
				<li>
	<!--  				<a style="cursor: pointer;" onclick="go_insert()">등록</a>   -->
				</li>
				<li>
					<a style="cursor: pointer;" onclick="cancel()" >뒤로가기</a>
				</li>
			</ul>
		</div>
  	<div class="tbl_paging">
	  	<span>
	  		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_guestList" />
		</span>
	</div>	
</form>
