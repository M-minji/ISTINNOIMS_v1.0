<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">

// 저장
function update_go(){
	if(chkIns()){
		if(confirm("저장하시겠습니까?")){
			$("#mloader").show();
			document.frm.submit();	
		}
	}
}

// validation
function chkIns(){
	if ($("#sGubunCateName").val() == ""){
		alert("구분명을 입력하세요.");
		$("#sGubunCateName").focus();
		return false;
	}
	return true;
}

// 삭제
function delete_go(){
	if(parseInt($("#gbnCnt").val()) < 1){
		if(confirm("삭제하시겠습니까?")){
			$("#mloader").show();
			document.frm.action = "/mes/gubun/gubunCate/kw_gubunCate_d.do";
			document.frm.submit();
		}
	}else{
		alert("사용되고 있는 코드입니다. 삭제할 수 없습니다.");
	}
}
	
// 목록
function cancel(){
	$("#mloader").show();
	document.frm.action = "/mes/gubun/gubunCate/kw_gubunCate_lf.do";
	document.frm.submit(); 
}
	
</script>


<form id="frm" name="frm" method="post" action="/mes/gubun/gubunCate/kw_gubunCate_u.do">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesGubunCateVO.pageIndex}" />
	<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="${mesGubunCateVO.recordCountPerPage}" />
	<input type="hidden" id="searchWord" name="searchWord" value="${mesGubunCateVO.searchWord}" />
	
	<input type="hidden" id="sGubunCateKey" name="sGubunCateKey" value="${cateInfo.sGubunCateKey}" />
	<input type="hidden" id="gbnCnt" name="gbnCnt" value="${cateInfo.gbnCnt}" />
		
		<div class="content">
			<div class="content_tit">
				<h2>구분관리 수정</h2>
			</div>
		</div>
		
		<div class="tbl_list">
			<table>
		       	<thead>
		       		<tr>
	        	 		<th>구분</th>
	        	 		<th>비고</th>
		       		</tr>
		       	</thead>
		       	<tbody>
		       		<tr>
						<td>
							<input type="text" id="sGubunCateName" name="sGubunCateName" value="${cateInfo.sGubunCateName}"  maxlength="20"/>
						</td>
		           		<td>
		           			<input type="text" id="sGubunCateEtc" name="sGubunCateEtc" value="${cateInfo.sGubunCateEtc}"  maxlength="20" />
		           		</td>
		       		</tr>
		       	</tbody>
	   		</table>
	   	</div>

		<div class="tbl_btn_right">
			<ul>
				<li>
					<a style="cursor: pointer;" onclick="update_go();">저장</a> 	
				</li>
				<li>
					 <a style="cursor: pointer;" onclick="delete_go();">삭제</a>
				</li>
				<li>
					 <a style="cursor: pointer;" onclick="cancel();">목록</a>
				</li>
			</ul>
		</div>
</form>
