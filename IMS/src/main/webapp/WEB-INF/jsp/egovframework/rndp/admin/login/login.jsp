<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/jsp/kw_error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>관리자 로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/admin/login.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/mes/common.css'/>" />
<script type="text/javascript">
	function fn_keyDown(event){
		if(event.keyCode == 13){
			login();
		}			
	}
	function login() {
		writeform.submit();
	}
</script>

</head>
<body onLoad="document.writeform.id.focus();" >
<div class="login_wrap">
        <header>
            <div class="inner">            
            <img src='/cmm/fms/getImage.do?atchFileId=${mainLogo}&fileSn=0'  alt="로고" onerror="this.src='/images/images/innost_logo.png'"/>             
            </div>

        </header>
        <section class="login_area">
            <div class="inner">
                 <p>* 본 서비스는 <span>IMS 시스템</span>으로 회원으로 등록된 사람에 한하여 이용가능합니다. </p> 
                 <p>* 원하시는 서비스를 이용하기 위해서는 로그인을 해주세요. </p> 
                <div class="tab_login">
                    <ul class="tab_btn_area">
                        <li class="tab_btn bio btn_bio"><a href="/mes/main.do"><span>회원 로그인</span></a></li>
                        <li class="tab_btn id on"><a><span>관리자 로그인</span></a></li> 
                    </ul>
                     <form name="writeform" id="adminVO" method="post" action="<c:url value='/admin/login.do'/>"> 
	                    <div class="tab_cont_area">
	                        <div class="tab_cont on" >
	                            <div class="input_wrap" style="height:48px">
	                                <input type="text" name="id" value="" placeholder="아이디" tabindex="1" class="inputbox"  required>
	                                <label for="userId"></label>
	                            </div>
	                            <div class="input_wrap" id="inputWrapPw" style="height:48px;">
	                                <input type="password" name="password" value="" placeholder="Password"  tabindex="2" id="password" class="password" onKeydown="javascript:fn_keyDown(event)" required>
	                                <label for="password"></label>  
	                            </div> 
	                            <a href="javascript:login()" class="btn_login">로그인</a>
	                        </div>
	                    </div>
                    </form>
                </div>

            </div>
        </section>

    </div>









<c:if test="${error eq 'noAuth' }">
	<script type="text/javascript"> 
	/* 2015 05 13  최고관리자 정보를 노출할수 없으므로 오프라인으로 해결  */
		alert('작업 권한이 있는 메뉴가 없습니다.\r\n최고관리자에게 권한설정을 직접 요청하세요.');
	</script>
</c:if>
<c:if test="${error eq 'flag' }">
	<script type="text/javascript">
		alert('Admin로그인 정보가 잘못되었습니다.\r\n다시 로그인 하세요.');
	</script>
</c:if>
<c:if test="${openerGb eq 'ok' }">
	<script type="text/javascript">
		window.opener.location.reload();
	</script>
</c:if>
</body>

</html>
