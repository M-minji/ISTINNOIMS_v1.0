<%@ page contentType="text/html; charset=UTF-8" errorPage="/jsp/kw_error.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>

<script type="text/javascript">

function fn_enterKeyDown(event){
	if(event.keyCode == 13){
		checkPwd_go();
	}		
}

function back_go(){
	document.userInfoForm.action="/mes/main.do";
	document.userInfoForm.submit();
}

function checkPwd_go(){
	
	var shMemberPassword = $('#shMemberPassword').val();
	var shMemberKey = $('#shMemberKey').val();
	var shMemberId = $('#shMemberId').val();
	
	var params = "shMemberPassword=" + shMemberPassword + "&shMemberKey=" + shMemberKey + "&shMemberId=" + shMemberId;
	
	$.ajax({
		method : "post",
		url : "/mes/myPage/kw_myPageInfoCheck.do",
		dataType : "json",
		data : params,
		
		success:function(msg){
			var idx = msg.result.idx;
			var message = msg.result.message;
		
			if(idx == 0){
				$('.checkText').text(message);
				$('#shMemberPassword').val("");
				$('#shMemberPassword').focus();
				
			}else{
				document.userInfoForm.action="/mes/myPage/kw_myPage_uf.do";
				document.userInfoForm.submit();
			}
			
		}
	});
	  
}
</script>

		
<form name="userInfoForm" id="userInfoForm" method="post" onsubmit="return false">
	<input type="hidden" name="shMemberKey" id="shMemberKey" value="${vo.kStaffKey}" />
	<input type="hidden" name="shMemberId" id="shMemberId" value="${vo.kStaffId}" />
		
		
		<div id="contents">
			<div class="content_tit">
				<h2>회원정보 확인</h2>
			</div>
			
			<div class="m_find02">
				<p>* <b style="font-size:15px;color:red;">${vo.kStaffId}</b>&nbsp;님의 정보를 안정하게 보호하기 위해 비밀번호를 다시 한번 확인 합니다.</p>
			</div>	
			
			<div class="my_page_lf">	
				<table>
					<tbody>
						<tr>
							<th>아이디</th>
							<td>${vo.kStaffId}</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="shMemberPassword" id="shMemberPassword"  onkeydown="fn_enterKeyDown(event)"/></td>
						</tr>
						<tr>
							<td colspan="2">
								<span class="checkText" style="text-align:center;font-weight:bold;color:red; display:block;"></span>
							</td>
						</tr>
					</tbody>	
				</table>
			</div>		
					
			<div class="tbl_btn_mypage">
				<ul>
					<li>
						<a name="btn_01" id ="resultOkBtn" onclick="checkPwd_go();">확인</a>
					</li>
					<li>
						<a name="btn_01" onclick="back_go();">취소</a>
					</li>
				</ul>
			</div>
				
				
	
	</div>
	
</form>