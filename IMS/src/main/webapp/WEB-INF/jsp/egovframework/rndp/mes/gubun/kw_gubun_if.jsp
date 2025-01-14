
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

$(document).ready(function(){
	addRow();
}); 

function insert_go(){
	if(chkIns()){
		if(confirm("저장하시겠습니까?")){
			$("#mloader").show();
			document.frm.submit();	
		}
	}
}

// validation
function chkIns(){
	var ln = document.getElementsByName("sGubunCateKey").length;
		
	if(ln > 0){
		for(var i = 0; i < ln; i++){
			if(document.getElementsByName("sGubunCateKey")[i].value == ""){
				alert((i+1)+"번째 구분을 선택하세요.");
				document.getElementsByName("sGubunCateKey")[i].focus();
				return false;
			}
			if(document.getElementsByName("sGubunName")[i].value == ""){
				alert((i+1)+"번째 구분명을 입력해주세요.");
				document.getElementsByName("sGubunName")[i].focus();
				return false;
			}
		}
	}else{
		alert("등록할 행이 없습니다.");
		return false;
	} 
	return true;
}

// 목록
function cancel(){
	$("#mloader").show();
	document.frm.action = "/mes/gubun/kw_gubun_lf.do";
	document.frm.submit(); 
}

// 행삭제
function delRow(obj){
	var tr = $(obj).parent().parent();
	tr.remove();		
}

//행추가
var itemRowIndex = 0;

function addRow() {	

	var innerStr = "";
	
	innerStr += "	<tr>";
	innerStr += "		<td>";
	innerStr += "			<a class='del' onclick='delRow(this)'>X</a>";
	innerStr += "		</td>";
	// 구분
	innerStr += "		<td>";
	innerStr += "			<select id='sGubunCateKey_"+itemRowIndex+"' name='sGubunCateKey'>";
	innerStr += "				<option value=''>미구분</option>";
	<c:forEach var="gubunCateList" items="${gubunCateList}" varStatus="i">
	innerStr += "				<option value='${gubunCateList.sGubunCateKey}'>${gubunCateList.sGubunCateName}</option>";
	</c:forEach>
	innerStr += "			</select>"; 
	innerStr += "		</td>";
	// 구분명
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='sGubunName_"+itemRowIndex+"' name='sGubunName' style='width:90%;'  maxlength='20' />";
	innerStr += "		</td>";
	// 비고
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='sGubunEtc_"+itemRowIndex+"' name='sGubunEtc' style='width:90%;' maxlength='20' />";
	innerStr += "		</td>";	
	innerStr += "	</tr>"; 
									
	$(innerStr).appendTo("#lineRow");
	
	itemRowIndex++;
}

</script>

<form id="frm" name="frm" method="post" action="/mes/gubun/kw_gubun_i.do">
	<input type="hidden" name="pageIndex" id="pageIndex" value="${mesGubunVO.pageIndex}" />
	<input type="hidden" name="recordCountPerPage" id="recordCountPerPage" value="${mesGubunVO.recordCountPerPage}" />
	<input type="hidden" name="searchWord" id="searchWord" value="${mesGubunVO.searchWord}" />
	<input type="hidden" name="searchGubun" id="searchGubun" value="${mesGubunVO.searchGubun}"  />


	<div class="if_content">
		<div class="content_tit">
			<h2>코드관리 등록</h2>
		</div>
<!-- 		<div class="tbl_top"> -->
<!-- 	    	<ul class="tbl_top_right">						 -->
<!-- 	    		<li> -->
<!-- 	    			<a style="cursor: pointer;" onclick="addRow();" > -->
<!-- 	    				행추가 -->
<!-- 	    			</a> -->
<!-- 	    		</li> -->
<!-- 			</ul>	     -->
<!-- 	    </div> -->
	</div>
	<div class="content" style="padding-top:20px;">
		<div class="content_tit">
			 <a class="mes_btn" style="float: right;" onclick="addRow();">입력 행추가</a>
		</div>
	</div>
	<div class="tbl_list">
		<table style="width:100%">
			<thead>
		       <tr>
      				<th style="width:6%;">행 삭제</th>
       				<th>구분</th>
       				<th>구분명</th>
       				<th>영문표기(약어)</th>
      			</tr>
       		</thead>
  	 		<tbody id="lineRow">
  	 		
			</tbody>
		</table>
	</div>
	
	<div class="tbl_btn_right">
		<ul>
			<c:if test="${staffVo.kStaffAuthWriteFlag eq 'T'}">	
				<li>
					<a style="cursor: pointer;" onclick="insert_go();">등록</a> 		 
				</li>	
			</c:if>		
			<li>
				<a style="cursor: pointer;" onclick="cancel();">목록</a>
			</li>
		</ul>
	</div>	
</form>
