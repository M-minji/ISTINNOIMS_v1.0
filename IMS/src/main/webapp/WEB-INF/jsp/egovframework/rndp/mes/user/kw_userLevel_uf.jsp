<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript" src="https://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function memberUp(){
	
	 const rank = document.getElementById("kClassRank").value.trim();
	    const className = document.getElementById("kClassName").value.trim();

	    if (rank === "") {
	        alert("순위를 입력하세요.");
	        document.getElementById("kClassRank").focus();
	        return false;
	    }
	 // 숫자만 남기도록 rank 값을 필터링
	    document.getElementById("kClassRank").value = rank.replace(/[^0-9]/g, '');
	    if (className === "") {
	        alert("직급명을 입력하세요.");
	        document.getElementById("kClassName").focus();
	        return false;
	    }

	    
	document.writeForm.action = "/mes/user/kw_userLevel_u.do";
	document.writeForm.submit();
}
</script>
<form name="writeForm" id="writeForm">		
	<input type="hidden" name="kClassKey" id="kClassKey" value="${classInfo.kClassKey }" />
	
			<div class="content">
				<div class="content_tit">
					<h2>직급 수정</h2>
				</div>
			</div>
		
	
	
			<div class="tbl_write_f">
				<table>
					<tbody>
						<tr>
							<th>순위</th>
							<td>
								<input type="text" name="kClassRank" id="kClassRank" value="${classInfo.kClassRank}" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onchange="filterNumericOnly(this)" />
							</td>
						</tr>
						<tr>
							<th>직급명</th>
							<td>
								<input type="text" name="kClassName" id="kClassName" value="${classInfo.kClassName}"  maxlength="20"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div class="tbl_btn_right">
				<ul>
					<li>
						<a href="javascript:memberUp();">저장</a>
					</li>
					<li>
						<a href="/mes/user/kw_userLevel_lf.do">목록</a>
					</li>
				</ul>
			</div>
		
</form>