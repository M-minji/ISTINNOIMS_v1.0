<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<title>Update</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value='/js/km_common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/km_diary.js'/>"></script>
<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<script src="/js/jquery/jquery-3.7.1.min.js"></script>
<script src="/js/jquery-ui-1.14.1/jquery-ui.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){	
	var eGubunPage = "${eGubunPage}";
	if (eGubunPage == "N") {
 		window.opener.location.reload(); // 부모 창 새로고침
		window.close();
	}
	datepickerIdSet("eEntryExporterDate");
	$('#eEntryExporterDate').val(nowDate());
	
});

function mesIMGregInsert() {
	if($("#eEntryExporterDate").val() == ''){
		alert("반출일자를 선택하세요.");
		$("#eEntryExporterDate").focus();
		return false;
	}
	if($("#eExitExporter").val() == ''){
		alert("반출 확인자를 입력하세요.");
		$("#eExitExporter").focus();
		return false;
	}
	
	document.frm.submit();
}
  
function nowDate(){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
    var nowDate = year + "-" + month + "-" + day;
	
    return nowDate;
}

</script>


<form id="frm" name="frm" method="post"   action="/mes/equipment/kw_eImport_update.do">
	<div class="pop_head">
		<div id="pop_head">
			<div class="tit">
				<h3>임시자산 반출 등록 POP</h3>
			</div>
			<a href="javascript:self.close();">
				<img src="/images/btn/close.gif" width="22" height="21">
			</a>
		</div>
	</div> 

	<div class="popup_content">
		<div class="lf_tbl_list" id="pop_result_list" align="center"> 
			<table>
			  <tbody>
					<tr>
						<th style="background-color: #f8fafc;">*반출 일자</th>
		      			<td style="text-align: left;">
		      				<input type="hidden" name='eEquipmentItemKey' id='eEquipmentItemKey' value='${mesEquipmentVO.eEquipmentItemKey }'> 
		      				<input type="text" name='eEntryExporterDate' id='eEntryExporterDate' value='' style="width:120px; text-align:center;" class="inp_color"   value=""  readonly="readonly">   
		      			</td>
		      			<th style="background-color: #f8fafc;">*반출 확인자</th>
		      			<td style="text-align: left;">
		      				<input type="text" name='eExitExporter' id='eExitExporter' value='' maxlength="30">  
		      			</td>
					</tr>
	    		</tbody>
			</table>
		</div>
		<div class="page">
		</div>
		<div class="tbl_btn_right">
			<ul>
				<li>
					<a style="cursor: pointer;" onclick="mesIMGregInsert();">
								등록
						</a>
				</li>
				<li>		
					 <a href="javascript:self.close();">
			  					닫기
		  			</a>
				</li>
			</ul>
		</div>
	</div>
</form>