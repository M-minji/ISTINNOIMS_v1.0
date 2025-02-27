<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>

<!-- 그리드 S -->
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/gridjs.production.min.js"></script>
<link href="/css/mes/mermaid.min.css" rel="stylesheet"	type="text/css" />
<link href="/css/mes/mermaid2.min.css" rel="stylesheet"	/>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery-ui.min.js"></script>
<link href="/css/mes/jquery-ui.min.css" rel="stylesheet"	type="text/css" />


<script type="text/javascript">

function go_insert(){
	document.listForm.action="/mes/inspection/kw_inspection_field_if.do";
	document.listForm.submit();
}


function fn_guestList(pageNo) {
	$('#mloader').show();
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "/mes/inspection/kw_inspection_field_lf.do";
	document.listForm.submit();
}


//$(function(){
//	$('table[role="grid"].gridjs-table th:nth-child(1) button').hide();
//	$('table[role="grid"].gridjs-table td:nth-child(6)').each(function() {
	 // nowrap을 적용하여 줄내림 방지, overflow는 숨기기
//	});
//})



function go_upd(key){
	console.log("Clicked key:", key); 
		$('#mloader').show();
		$("#eFieldKey").val(key);
		document.listForm.action = "/mes/inspection/kw_inspection_field_uf.do";
		document.listForm.submit();
}


</script>

<style>
td.gridjs-td:last-child{text-align:center !important;} 

#inspectionFieldList tr td {
    cursor: pointer !important;
}

td a {
    display: block; /* 블록 요소로 변경하여 td 크기를 가득 채움 */
    width: 100%; /* 가로 길이를 td와 동일하게 */
    height: 100%; /* 세로 길이를 td와 동일하게 */
    text-align: center; /* 텍스트 중앙 정렬  */
    line-height: inherit; /* td의 높이에 맞춤 */
}

</style>

<form name="listForm" id="listForm">		
	<input type="hidden" name="eFieldKey" id="eFieldKey"  value="" />
	<input type="hidden" name="pageIndex" id="pageIndex" value ="${mesInspectionVO.pageIndex}"/>

		<div class="content_up">
			<div class="content_tit">
				<h2>점검결과 필드 관리</h2>
			</div>
			
			<div class="tbl_top">
				<ul class="tbl_top_left" >
		       		<li>
						<select name="searchType" class="select_search" id="searchType"  >
							<option value="1"
								<c:if test="${mesInspectionVO.searchType eq 1}">selected="selected"</c:if>>전체</option>
							<option value="2"
								<c:if test="${mesInspectionVO.searchType eq 2}">selected="selected"</c:if>>이름</option>
							<option value="3"
								<c:if test="${mesInspectionVO.searchType eq 3}">selected="selected"</c:if>>필드</option>
						</select>
					</li>
					<li> 
						<input name="searchWord" type="text" class="searchWord" style="width:150px;" id="searchWord" value="${mesInspectionVO.searchWord}"  onkeypress="if(event.keyCode == 13 ){fn_guestList(1);}" maxlength="20"/>  
					</li>
					<li>
						<a onclick="fn_guestList(1)">검색</a>
					</li>			  
				</ul>
			</div>
		</div>	
		
			<div id="tableContainer" class="lf_tbl_list">
				<table id="myTable">
					<colgroup>
						<col width="5%" />
						<col width="15%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="2%" />
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>이름</th>
							<th>필드1</th>
							<th>필드2</th>
							<th>필드3</th>
							<th>필드4</th>
							<th>필드5</th>
						</tr>
					</thead>
					<tbody id="inspectionFieldList">
					    <c:choose>
					        <c:when test="${not empty fieldList}">
					            <c:forEach var="fieldList" items="${fieldList}" varStatus="i">
					                <tr>
					          			<td><a onclick="go_upd(${fieldList.eFieldKey})">${i.index + 1}</a></td>
					              		<td><a onclick="go_upd(${fieldList.eFieldKey})">${fieldList.eFieldName}</a></td>
					              		<td><a onclick="go_upd(${fieldList.eFieldKey})">${fieldList.eField1}</a></td>
					              		<td><a onclick="go_upd(${fieldList.eFieldKey})">${fieldList.eField2}</a></td>
					              		<td><a onclick="go_upd(${fieldList.eFieldKey})">${fieldList.eField3}</a></td>
					              		<td><a onclick="go_upd(${fieldList.eFieldKey})">${fieldList.eField4}</a></td>
					              		<td><a onclick="go_upd(${fieldList.eFieldKey})">${fieldList.eField5}</a></td>
					                    </tr>
					            </c:forEach>
					        </c:when>
					        <c:otherwise>
					            <tr>
					                <td colspan="8" style="text-align:center;">데이터가 없습니다.</td>
					            </tr>
					        </c:otherwise>
					    </c:choose>
					</tbody>
				</table>
				<div class="page">	
				  <span><ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_guestList" /></span>
				</div>
			</div>
			<div class="tbl_bottom">
				<ul class="tbl_bottom_left" >
					<li>
						<select name="recordCountPerPage" class="select_recordCountPerPage" id="recordCountPerPage"   onchange="fn_guestList(1)">
		              		<option value="10" <c:if test="${mesInspectionVO.recordCountPerPage eq 10}">selected="selected"</c:if>>Page/10</option>
		              		<option value="20" <c:if test="${mesInspectionVO.recordCountPerPage eq 20}">selected="selected"</c:if>>Page/20</option>
		              		<option value="50" <c:if test="${mesInspectionVO.recordCountPerPage eq 50}">selected="selected"</c:if>>Page/50</option>
		              		<option value="100" <c:if test="${mesInspectionVO.recordCountPerPage eq 100}">selected="selected"</c:if>>Page/100</option>
		       			</select> 
		       		</li>
				</ul>
				<ul class="tbl_bottom_right">
					<c:if test="${staffVO.kStaffAuthWriteFlag eq 'T'}">
						<li><a onclick="go_insert()">추가</a></li>
					</c:if>
				</ul>
			</div>
</form>
