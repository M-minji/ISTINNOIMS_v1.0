<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
function meEnvUp(){
	
		if($("#companyName").val() == ""){
			alert("회사명이 입력되지 않았습니다");
			$("#companyName").focus();
			return false;
		}
		if($("#companyCeo").val() == ""){
			alert("기업 대표자가 입력되지 않았습니다");
			$("#companyCeo").focus();
			return false;
		}
		if($("#companyIncorpo").val() == ""){
			alert("기업 설립일이 입력되지 않았습니다");
			$("#companyIncorpo").focus();
			return false;
		}
		if($("#companyAddr").val() == ""){
			alert("소재지가 입력되지 않았습니다");
			$("#companyAddr").focus();
			return false;
		}
		if($("#companyTel").val() == ""){
			alert("대표전화가 입력되지 않았습니다");
			$("#companyTel").focus();
			return false;
		}
		if($("#companyNum").val() == ""){
			alert("사업자번호가 입력되지 않았습니다");
			$("#companyNum").focus();
			return false;
		}
		
		if(confirm("저장하시겠습니까?")){
			$("#mloader").show();
			
			var ln = document.getElementsByName("envVal").length;
			for(var i = 0; i < ln; i++){
				var value = document.getElementsByName("envVal")[i].value;
				document.getElementsByName("envVal")[i].value = value.replace(/,/g, "@@");
			}
			
			document.writeform.action = "/mes/user/env_List_i.do";
	 		document.writeform.submit();
		} 
	
	
}

$(document).ready(function () {
	// companyName 처리
    if ($("#companyName").length > 0) {
        const originalValue = $("#companyName").val();
        const restoredValue = decodeHtmlEntities(originalValue);
        $("#companyName").val(restoredValue);
    }

    // companyCeo 처리
    if ($("#companyCeo").length > 0) {  
        const originalValue = $("#companyCeo").val();
        const restoredValue = decodeHtmlEntities(originalValue);
        $("#companyCeo").val(restoredValue);
    }

    // companyAddr 처리
    if ($("#companyAddr").length > 0) {
        const originalValue = $("#companyAddr").val();
        const restoredValue = decodeHtmlEntities(originalValue);
        $("#companyAddr").val(restoredValue);
    }

    // companyFax 처리
    if ($("#companyFax").length > 0) {
        const originalValue = $("#companyFax").val();
        const restoredValue = decodeHtmlEntities(originalValue);
        $("#companyFax").val(restoredValue);
    }

    // companyTel 처리
    if ($("#companyTel").length > 0) {
        const originalValue = $("#companyTel").val();
        const restoredValue = decodeHtmlEntities(originalValue);
        $("#companyTel").val(restoredValue);
    }

    // sComType 처리
    if ($("#sComType").length > 0) {
        const originalValue = $("#sComType").val();
        const restoredValue = decodeHtmlEntities(originalValue);
        $("#sComType").val(restoredValue);
    }

    // sComCategory 처리
    if ($("#sComCategory").length > 0) {
        const originalValue = $("#sComCategory").val();
        const restoredValue = decodeHtmlEntities(originalValue);
        $("#sComCategory").val(restoredValue);
    }
});
function decodeHtmlEntities(str) {
	  const textarea = document.createElement("textarea");
	    textarea.innerHTML = str;  // HTML 엔티티를 디코딩
	    return textarea.value;
}
</script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
	<body>
	<form name="writeform" id="writeform" method="post" >
			
	
		<div class="content">
			<div class="content_tit">
				<h2>기업정보관리</h2>
			</div>
		</div>
		
			<div class="tbl_write_f">		
				<table>
					<tbody>
						<tr>
							<th>회사명 *</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="companyName" maxlength="20"/> 
								<input type="text" id="companyName" name="envVal" value="${companyName}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>대표자 *</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="companyCeo"  maxlength="20"/> 
								<input type="text" id="companyCeo" name="envVal" value="${companyCeo}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>설립일 *</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="companyIncorpo"  maxlength="20"/>
								<input type="text" id="companyIncorpo" name="envVal" value="${companyIncorpo}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>소재지 *</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="companyAddr"  maxlength="120"/> 
								<input type="text" id="companyAddr" name="envVal" value="${companyAddr}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH >대표전화 *</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="companyTel"  maxlength="20"/> 
								<input type="text" id="companyTel" name="envVal" value="${companyTel}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>팩스</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="companyFax"  maxlength="20"/> 
								<input type="text" id="companyFax" name="envVal" value="${companyFax}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>사업자번호 *</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="companyNum"  maxlength="20"/> 
								<input type="text" id="companyNum" name="envVal" value="${companyNum}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>업태</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="sComType"  maxlength="20"/>
								<input type="text" id="sComType" name="envVal" value="${sComType}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>종목</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="sComCategory"  maxlength="20"/>
								<input type="text" id="sComCategory" name="envVal" value="${sComCategory}" size="50" style="width : 50%;">
							</td>
						</tr>
						<tr>
							<TH>우선순위:1 -시스템사용도메인</th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="sDomain"  maxlength="30"/>
								<input type="text" id="sComCategory" name="envVal" value="${sDomain}" size="50" style="width : 50%;">
								※사용하는 도메인이 있을 경우 기입 예시)  naver.com, google.com
							</td>
						</tr>
						<tr>
							<TH>우선순위:2 -시스템 설정 </th>
							<TD style="text-align: left;">
								<input type="hidden" name="envName" value="sPublicIp" maxlength="30"/>
								<input type="text" id="sComCategory" name="envVal" value="${sPublicIp}" size="50" style="width : 50%;">
								※포트포워딩 및  VPN등 별도 정보 경우 기입(시스템 접속 포트 포함) <br>
							</td>
						</tr>
						<tr>
<!-- 						<TH>우선순위:3 -시스템 자동할당 IP</th> -->
<%-- 							<TD style="text-align: left;">${eIPaddress} --%>
<!-- 								<input type="hidden" name="envName" value="sPrivateIp" maxlength="30"/> -->
<%-- 								<input type="hidden" id="sComCategory" name="envVal" value="${eIPaddress}" size="50" style="width : 50%;"> --%>
<!-- 								 &nbsp;&nbsp;  ※시스템 서버에서 자동으로 확인된 IP/임의수정 불가, 사설 IP인경우 같은 네트워크망에서 접속 가능(같은 공유기).  -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>
			</div>
			
				<div class="tbl_btn_right">
					<ul>
							<li> 
								<c:if test="${staffVo.kStaffAuthWriteFlag eq 'T'}">
									<a href="javascript:meEnvUp();">저장</a>
								</c:if>
							</li>
					</ul>
				</div>
		
			</form>
	</body>
</html>