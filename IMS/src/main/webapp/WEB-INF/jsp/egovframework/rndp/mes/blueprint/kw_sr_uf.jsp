<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<script src="/js/jquery/jquery-3.7.1.min.js"></script>
<script src="/js/jquery-ui-1.14.1/jquery-ui.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	datepickerIdSet("eReqDate");
	datepickerIdSet("blueprintWdate");

	var sSignStatus  = $("#sSignStatus").val();
	if(sSignStatus == "등록"  || sSignStatus == "반려"){
		$("#oSignPass").val("N");
		 $('#oPass').prop('checked', false);
	}else{
		 $('#oPass').prop('checked', true);
		$("#oSignPass").val("Y");
	}
});




		function delRowf(obj){
			var tr = $(obj).parent().parent();
			tr.remove();
			  // eAssetKey의 개수를 다시 계산
		    var eAssetKeyArr = document.getElementsByName("eFileID").length;
		    
		    // eAssetKey의 개수가 0이면 메시지를 추가
		    if (eAssetKeyArr == 0) {
		        var tbody = document.getElementById("fileRow");
		        var messageRow = document.createElement('tr');
		        var messageCell = document.createElement('td');
		        
		        messageCell.colSpan = 2;
		        messageCell.textContent = "첨부파일을 선택하세요.";
		        
		        
		        messageRow.appendChild(messageCell);
		        tbody.appendChild(messageRow);
		    }
		}
		
		function addFile(){
		  var url = "/mes/blueprint/popup/kw_sr_File_add.do";
		  const form = document.createElement("form");
		    form.method = "POST";
		    form.action = url;
		    form.target = "ePDFAdd"; // 새 창 이름
		    
		    const csrfTokenGubun = document.createElement("input");
		    csrfTokenGubun.type = "hidden";
		    csrfTokenGubun.name = "csrfToken";
		    csrfTokenGubun.value = $("input[name=csrfToken]").val();
		    form.appendChild(csrfTokenGubun);
		
		    // 폼을 문서에 추가
		    document.body.appendChild(form);
		
		    // 새 창 열기
		    window.open("", "ePDFAdd","width=600,height=550,menubar=no,status=no,scrollbars=yes,location=no,resizable=yes");
		
		    // 폼 전송
		    form.submit();
		
		    // 폼 제거
		    document.body.removeChild(form);
		}
		function eDownload(fileId,eFileName){
			 if(confirm(eFileName+"을 다운로드 하시겠습니까?")){
					window.open("<c:url value='/cmm/fms/FileDown.do?atchFileId="+fileId+"&fileSn=0'/>");
				}
		}
		
		var fileRowIdex = 0;

		  function addFileInfoRow(eFileID,eFileName,eFileExt){
			  var eAssetKeyArr = document.getElementsByName("eFileID").length;
				if(eAssetKeyArr == 0){
					var tbody = document.getElementById("fileRow");
				    tbody.innerHTML = "";  
				}else{
					if(fileRowIdex==0){
						fileRowIdex =eAssetKeyArr+1;
					}
				}
				var innerStr = "";
				
				// 행삭제
				innerStr += "	<tr>";
				innerStr += "		<td>";
				innerStr += "			<a class='del' onclick=\"delRowf(this);\">X</a>";
				innerStr += "		</td>";
				innerStr += "		<td>" +eFileName;
				innerStr += "			<input type='hidden' id='eFileID_"+fileRowIdex+"' name='eFileID' value='"+eFileID+"'/>";
				innerStr += "			<input type='hidden' id='eFileName_"+fileRowIdex+"' name='eFileName' value='"+eFileName+"'/>";
				innerStr += "			<input type='hidden' id='eFileExt_"+fileRowIdex+"' name='eFileExt' value='"+eFileExt+"'/>";
				innerStr += "		</td>";
	 
				innerStr += "	</tr>";
				
				$(innerStr).appendTo("#fileRow");	
				
				fileRowIdex++;
				
			}
		

	// 오늘 날짜
	function nowDate(){
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
		var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
		var nowDate = year + "-" + month + "-" + day;

		return nowDate;
	}

	// 저장
	function update_go(){  
		if(chkIns()){
			if(confirm("저장하시겠습니까?")){
				$("#mloader").show();
				document.frm.action = "/mes/blueprint/kw_sr_u.do";
				document.frm.submit();
			}
		}
	}
	function chkIns(){
		if($("#eRequester").val() == ""){
			alert("작성자 명을 입력하세요.");
			$("#eRequester").focus();
			return false;
		}
		
		if($("#oSignPass").val() != 'Y'){
			if(document.getElementsByName("sSignStaffKey").length == 0){
				alert("승인권자를 선택해주세요");
				return false;
				}
			}
		$("#eReqContent").val($("<div>").text($("#eReqContent").val()).html()); 
		$("#eWorkStart").val($("<div>").text($("#eWorkStart").val()).html());
		$("#eWorkEnd").val($("<div>").text($("#eWorkEnd").val()).html());
		return true;
	}
		
 

	// 삭제
	function delete_go(){
		if(confirm("삭제하시겠습니까?")){
			$("#mloader").show();
			document.frm.action = "/mes/blueprint/kw_sr_d.do";
			document.frm.submit();
		}
	}

	// 삭제
	function delete_item_go(ver){
		$("#version").val(ver);
		$("#mloader").show();
		document.frm.action = "/mes/blueprint/kw_blueprint_item_d.do";
		document.frm.submit();
	}


	// 목록
	function cancel(){
		$("#mloader").show();
		document.frm.action = "/mes/blueprint/kw_sr_lf.do";
		document.frm.submit();
	}




	//파일다운
	function fn_egov_viewFile_md(id, extension){
		var url = "";
		
		if(extension != "pdf"){
			url = "<c:url value='/cmm/fms/getImage.do'/>?atchFileId="+id+"&fileSn=0"
			fn_egov_viewFile(url);
		}else{
			url = "<c:url value='/cmm/fms/getPdf.do'/>?atchFileId="+id+"&fileSn=0"
			fn_view_pdf(url);
		}
	}

	// 파일다운
	function fn_egov_downFile(atchFileId, fileSn){
		if(confirm("파일을 다운로드 하시겠습니까?")){
			window.open("<c:url value='/cmm/fms/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
		}
	}

	
	//처리내역 등록 
	function process_go(key,blueprintItemKey){
		$("#mloader").show();
		$("#version").val(key);
		$("#blueprintItemKey").val(blueprintItemKey);
		$("#newPrint").val("new");
		document.frm.action = "/mes/blueprint/kw_blueprint_process_if.do";
		document.frm.submit();
	}

	//상세 등록 
	function process_sing(key,blueprintItemKey){
		$("#mloader").show();
		$("#version").val(key);
		$("#blueprintItemKey").val(blueprintItemKey);
		$("#newPrint").val("new");
		document.frm.action = "/mes/blueprint/kw_blueprint_process_vf.do";
		document.frm.submit();
	}

	function requestSign(blueprintItemKey, sSignKey, gubun){
		$("#mloader").show();
		$("#gubun").val(gubun);
		$("#blueprintItemKey").val(blueprintItemKey);
		$("#sSignKey").val(sSignKey);
		document.frm.action = "/mes/blueprint/kw_blueprint_process_r.do";
		document.frm.submit();
	}
	
	

	function sel_asset(){	
		// 동적으로 폼 생성
	    const form = document.createElement("form");
	    form.method = "POST";
	    form.action = "/mes/asset/kw_asset_box_lf.do";
	    form.target = "AddrAdd"; // 새 창 이름
	    
	    const csrfTokenGubun = document.createElement("input");
	    csrfTokenGubun.type = "hidden";
	    csrfTokenGubun.name = "csrfToken";
	    csrfTokenGubun.value = $("input[name=csrfToken]").val();
	    form.appendChild(csrfTokenGubun);
	    
	    const kMenuKeyGubun = document.createElement("input");
	    kMenuKeyGubun.type = "hidden";
	    kMenuKeyGubun.name = "kMenuKey";
	    kMenuKeyGubun.value = "${key}";
	    form.appendChild(kMenuKeyGubun);

	    // 폼을 문서에 추가
	    document.body.appendChild(form);

	    // 새 창 열기
	    window.open("", "AddrAdd", "width=1400, height=650, status=no, toolbar=no, resizable=yes, menubar=no, location=no, scrollbars=yes");

	    // 폼 전송
	    form.submit();

	    // 폼 제거
	    document.body.removeChild(form);
	}

	function setAssetReturnPop(obj){  
		$.ajax({
				type		: "post"
			,	dataType	: "json"
			,	url			: "/mes/asset/kw_getAssetInfoList.do"
			,	data		: {
					eAssetKey : obj.aAssetKeyList
				}
			,	success		: function(msg){
				var eAssetInfoList  = msg.result.dataList;
					for(var i = 0; i < eAssetInfoList.length; i++){
						setAssetPop(eAssetInfoList[i]);
					}
				}
			
			});
	}


	var row_Index = 0;
	function setAssetPop(obj){
		
		var eAssetKeyArr = document.getElementsByName("eAssetKey").length;
		if(eAssetKeyArr == 0){
			var tbody = document.getElementById("lineRow");
		    tbody.innerHTML = "";  
		}
		
		
		var innerStr = "";
		
		// 행삭제
		innerStr += "	<tr>";
		innerStr += "		<td>";
		innerStr += "			<a class='del' onclick=\"delRow(this);\">X</a>";
		innerStr += "		</td>";
		// 자산유형
		innerStr += "		<td>" +obj.aAssetType;
		innerStr += "			<input type='hidden' id='eAssetKey_"+row_Index+"' name='eAssetKey' value='"+obj.aAssetKey+"'/>";
		innerStr += "		</td>";
		// 자산번호
		innerStr += "		<td>" +obj.aAssetNumber;
		innerStr += "		</td>";		
		// 자산명
		innerStr += "		<td>" +obj.aAssetName;
		innerStr += "		</td>";
		// 모델명
		innerStr += "		<td>" +obj.aAssetModel;
		innerStr += "		</td>";
		// 망구분
		innerStr += "		<td>"+obj.eNetworkType;
		innerStr += "		</td>";	
		// host
		innerStr += "		<td>"+obj.eHostName;
		innerStr += "		</td>";	
		// ip주소
		innerStr += "		<td>"+obj.eIp;
		innerStr += "		</td>";	
		// os
		innerStr += "		<td>"+obj.eOs;
		innerStr += "		</td>";	
		innerStr += "	</tr>";
		
		$(innerStr).appendTo("#lineRow");	
		
		row_Index++;
		
	}
	
	// 행삭제
	function delRow(obj){
		var tr = $(obj).parent().parent();
		tr.remove();
	}
	
	//행삭제
	function delRowTwo(obj){
		var tr = $(obj).parent().parent();
		tr.remove();
	}

	function approvalPop(){
		
		 var checkbox = $('#oPass');
	    if (checkbox.prop('checked')) {
	    	if(confirm("결재 제외로 선택되었습니다.\n결재자를 선택하시겠습니까?")){
	    		checkbox.prop('checked', false);
	    		$("#oSignPass").val("N");
	    	}else{
	    		return;
	    	}
	    }
		
		
		var ln = document.getElementsByName("referSign").length;
		var kStaffKey = "";
		var gubun = "";
		var preKStaffKey = "";
		for(var i = 0; i < ln; i++){
			var kStaffKey1 = document.getElementsByName("referSign")[i].value;
			var gubun1 = document.getElementsByName("gubun")[i].value;
			if(kStaffKey == ""){
				kStaffKey = kStaffKey1;
				gubun = gubun1;
			}else{
				kStaffKey = kStaffKey + ",";
				kStaffKey = kStaffKey + kStaffKey1;
				gubun = gubun + ",";
				gubun = gubun + gubun1;
			}
			
		}
		
		const form = document.createElement("form");
	    form.method = "POST";
	    form.action = "/mes/sign/popup/kw_signStaff_lf.do";
	    form.target = "AddrAdd"; // 새 창 이름
	    
	    const kStaffKeyGubun = document.createElement("input");
	    kStaffKeyGubun.type = "hidden";
	    kStaffKeyGubun.name = "kStaffKey1";
	    kStaffKeyGubun.value = kStaffKey;
	    form.appendChild(kStaffKeyGubun);
	    
	    
	    const gubunGubun = document.createElement("input");
	    gubunGubun.type = "hidden";
	    gubunGubun.name = "gubun1";
	    gubunGubun.value = gubun;
	    form.appendChild(gubunGubun);
	    
	    const csrfTokenGubun = document.createElement("input");
	    csrfTokenGubun.type = "hidden";
	    csrfTokenGubun.name = "csrfToken";
	    csrfTokenGubun.value = $("input[name=csrfToken]").val();
	    form.appendChild(csrfTokenGubun);
	    
	    const kMenuKeyGubun = document.createElement("input");
	    kMenuKeyGubun.type = "hidden";
	    kMenuKeyGubun.name = "kMenuKey";
	    kMenuKeyGubun.value = "${key}";
	    form.appendChild(kMenuKeyGubun);

	    // 폼을 문서에 추가
	    document.body.appendChild(form);

	    // 새 창 열기
	    window.open("", "AddrAdd", "width=1000, height=650, status=no, toolbar=no, resizable=yes, menubar=no, location=no, scrollbars=yes");
	    // 폼 전송
	    form.submit();

	    // 폼 제거
	    document.body.removeChild(form);
	}
	

	var referIndex = 0;
	function reCirSet(obj){
		//결재순서
		var lnTmp = document.getElementsByName("sSignStaffKey").length;
		
		var innerStr = "";
		
		// 행삭제
		innerStr += "	<tr>";
		innerStr += "		<td>";
		innerStr += "			<input type='hidden' id='referSign_"+referIndex+"' name='referSign' value='"+(obj.kStaffKey)+"'/>";
		innerStr += "			<input type='hidden' id='sSignStaffKey_"+referIndex+"' name='sSignStaffKey' value='"+(obj.kStaffKey)+"'/>";
		innerStr += "			<input type='hidden' id='sSignStaffPosition_"+referIndex+"' name='sSignStaffPosition' value='"+(obj.kPositionName)+"'/>";
		innerStr += "			<input type='hidden' id='sSignStaffName_"+referIndex+"' name='sSignStaffName' value='"+(obj.kStaffName)+"'/>";
		innerStr += "			<input type='hidden' id='sSignSequence_"+referIndex+"' name='sSignSequence' value='"+(Number(lnTmp)+1)+"'/>";
		innerStr += "			<input type='hidden' id='sSignStaffGubun_"+referIndex+"' name='sSignStaffGubun' value='"+(obj.gubun)+"'/>";
		innerStr += "			<input type='hidden' id='gubun_"+referIndex+"' name='gubun' value='"+(obj.gubun)+"'/>";
		innerStr += "			<span id='sn_sp_"+referIndex+"' class='sn_sp'>"+(Number(lnTmp)+1)+"</span>";
		innerStr += "		</td>";
		// 종류
		innerStr += "		<td>"
		innerStr += "			<span id='sn_sp_"+referIndex+"' class='sn_sp'>"+obj.gubun+"</span>";
		innerStr += "		</td>";		
		// 이름
		innerStr += "		<td>";
		innerStr += "			"+(obj.kPositionName)+" / "+(obj.kClassName)+" / "+(obj.kStaffName)+"";
		innerStr += "		</td>";
		innerStr += "	</tr>";
		
		$(innerStr).appendTo("#lineRow3");		
		
		referIndex++;
	}
	
	function deleteGyeoljaeList(){
		$('#lineRow3').empty();
	}
</script>
<form id="frm" name="frm" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesBlueprintVO.pageIndex}" />
	<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="${mesBlueprintVO.recordCountPerPage}" />
	<input type="hidden" id="searchWord" name="searchWord" value="${mesBlueprintVO.searchWord}" />
	<input type="hidden" id="searchType" name="searchType" value="${mesBlueprintVO.searchType}" />
	<input type="hidden" id="eIssueKey" name="eIssueKey" value="${mesBlueprintVO.eIssueKey}" />
	<input type="hidden" id="oSignPass" name="oSignPass" value="" />
  	<input type="hidden" id="sSignStatus" name="sSignStatus" value="${info.sSignStatus}" />
	

	<div class="content">
		<div class="content_tit">
			<h2>SR관리 정보 수정 페이지</h2>
		</div>
	</div>

	<div class="tbl_esti_detail_total">
		<div class="tbl_write">
			<table>
				<tbody>
					<tr>
	  					<th>작성자</th>
	  					<td colspan="1"> ${info.kStaffName}</td>
	  					<th>작성일</th>
						<td colspan="1"> 
							<input type="text" name="blueprintWdate" id="blueprintWdate" style="width:150px; text-align:center;" class="inp_color" readonly  value="${info.blueprintWdate }" />
	  					</td>
	  				</tr>
				 	<tr>
		  				<th>요청일자</th>
						<td colspan="3"> 
							<input type="text" id="eReqDate" name="eReqDate" value="${info.eReqDate }" style="width:150px; text-align:center;" class="inp_color" readonly   />
						</td>
					</tr>
	  				<tr>
		  				<th>*요청자</th>
						<td>
							<input type="text" id="eRequester" name="eRequester" style="width:70%;" value="${info.eRequester}" maxLength="100"/>
							<a class="mes_btn" onclick="selectWorkerPop('R', 'eRequester')" style="float: right; margin-right: 10px;" >담당자 선택</a>
							<input type="hidden" name="eReqOrg" id="eReqOrg" style="width:95%; text-align:left;" maxLength="50" value="${info.eReqOrg }" />
							<input type="hidden" name="eReqDept" id="eReqDept" style="width:95%; text-align:left;" maxLength="50" value="${info.eReqDept }" />
						</td>
						<th >요청자 소속</th>
							<td >
								<input type="text" id="eRequesterOrg" name="eRequesterOrg" style="width:95%;" maxLength="100" value="${info.eRequesterOrg}" />
								<span id="eRequesterOrgTxt" style="display: none;"></span>
							</td>
					</tr>
	  				
					<tr>
						<th	colspan="4" style="text-align:center;">
							요청사항
						</th>
					</tr>
					<tr>
						<td id="td_editor" colspan="4" align="center" scope="row"> 
 							<textarea id="eReqContent" name="eReqContent" cols="100%" rows="10" maxLength="1000" style="font-size: 20px; width: 100%; height: 300px; resize: none;" >${info.eReqContent}</textarea>
							 
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>
 		<div class="tbl_esti_detail_total">		
		<div class="tbl_write">
 			<table>
 				<tbody>
					<tr>
		  				<th>요청사유</th>
						<td> 
							<input type="text" name="eIssueCause" id="eIssueCause" style="width:95%; text-align:left;" maxLength="50" value="${info.eIssueCause }" />
						</td>
						<th>해결방법</th>
						<td> 
							<input type="text" name="eSolutionMethod" id="eSolutionMethod" style="width:95%; text-align:left;" maxLength="50" value="${info.eSolutionMethod }" />
						</td>
					</tr>
	  				<tr>
		  				<th>처리시작일시</th>
						<td> 
							<input type="text" name="eWorkStart" id="eWorkStart" style="width:95%; text-align:left;" maxLength="50" value="${info.eWorkStart }" />
						</td>
						<th>처리완료일시</th>
						<td>
							<input type="text" name="eWorkEnd" id="eWorkEnd" style="width:95%; text-align:left;" maxLength="50" value="${info.eWorkEnd }" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
		 <div class="tbl_list">
		<table>
			<thead>
				<tr>
					<th colspan="2">
					 <a class="mes_btn" onclick="addFile()" >파일 선택</a>
					</th>
				</tr>
				<tr>
					<th style="width: 25%;">구분</th>
					<th style="width: 75%;">첨부  파일명</th>
				</tr>
			</thead>
			<tbody id="fileRow">
				<c:if test="${not empty eFileInfoList}">
						 <c:forEach var="list" items="${eFileInfoList}" varStatus="i">
					 		<tr> 
					 			<td><a class='del' onclick="delRowf(this);">X</a></td>
					 			<td><a onclick="eDownload('${list.eFileID}','${list.eFileName}');">${list.eFileName}</a>
					 			<input type='hidden' id='eFileID_${i.index }' name='eFileID' value='${list.eFileID}'/>
						 		<input type='hidden' id='eFileName_${i.index }' name='eFileName' value='${list.eFileName}'/>
						 		<input type='hidden' id='eFileExt_${i.index }' name='eFileExt' value='${list.eFileName}'/>
					 			
					 			</td>
				 			</tr>
						 </c:forEach>
					 </c:if>
			 		<c:if test="${empty eFileInfoList}">
			 		<tr> <td colspan="2">첨부된 파일이 없습니다.</td></tr>
			 		</c:if>
			</tbody>
		</table>
	</div> 
	 

	 <div class="content" style="padding-top:20px;" id="viewDiv1">
		<div class="content_tit">
			<h2>장비 정보</h2>
		</div>
	</div>
	<div class="tbl_list" id="viewDiv2">
		<table>
			<caption style="text-align: left; margin-bottom:10px;">
				   <a class="mes_btn" onclick="sel_asset()" style="float:right">장비 선택</a>
			</caption>
				<thead>
				<tr>
					<th style="width: 10%;">구분</th>
					<th style="width: 12%;">자산유형</th>
					<th style="width: 12%;">자산번호</th>
					<th style="width: 12%;">자산명</th>
					<th style="width: 12%;">모델명</th>
					<th style="width: 12%;">망구분</th>
					<th style="width: 10%;">HOSTNAME</th>
					<th style="width: 10%;">IP</th>
					<th style="width: 10%;">OS</th>
				</tr>
			</thead>
			<tbody id="lineRow">
				<c:forEach var="list" items="${assetList}" varStatus="i">
					<tr>
						<td>
							<a class='del' onclick="delRow(this);">X</a>
						</td>
						
						<td> ${list.aAssetType}   
							<input type='hidden' id='eAssetKey_${i.index}' name='eAssetKey' value='${list.eAssetKey} '/>
						</td>
						
						<td>${list.aAssetNumber} 	 </td>		
						<td>${list.aAssetName}		</td>
						<td>${list.aAssetModel} 		</td>
						<td>${list.eNetworkType}  		</td>	
						<td>${list.eHostName} 			</td>	
						<td>${list.eIp}		</td>	
						<td>${list.eOs} 	</td>			
						
					</tr>
				</c:forEach>
			
				<c:if test="${empty assetList}">
					<tr>
						<td colspan="10">장비를 선택하세요.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	
	
	<div style="margin-top:30px;">   
		<div class="tbl_top">
			<ul class="tbl_top_left">
				<li>
				
					<a onclick="approvalPop();">승인권자 선택</a>
					 <label for="oPass" class="checkbox-container">
						결재 제외<input type="checkbox" id="oPass" name="oPass" class="checkbox" onclick="handleOPassClick();"/>
					</label>
				</li>
			</ul>
		</div>
			
		<div class="tbl_list">
			<table>
				<thead>
					<tr>
						<th colspan="5">결재 정보</th>
					</tr>
					<tr>
						<th style="width: 10%;">결재순서</th>
						<th style="width: 20%;">부서</th>
						<th style="width: *%;">성명</th>
					</tr>
				</thead>
				<tbody id="lineRow3"> 
					<c:forEach var="slist" items="${signList}" varStatus="j">
							<tr>
								<td>
									<input type='hidden' id='sSignStaffKey_${j.index}' name='sSignStaffKey' value='${slist.sSignStaffKey}'/>
									<input type='hidden' id='sSignStaffPosition_${j.index}' name='sSignStaffPosition' value='${slist.sSignStaffPosition}'/>
									<input type='hidden' id='sSignStaffName_${j.index}' name='sSignStaffName' value='${slist.sSignStaffName}'/>
									<input type='hidden' id='sSignSequence_${j.index}' name='sSignSequence' value='${slist.sSignSequence}'/>
									<input type='hidden' id='sSignStaffGubun_${j.index}' name='sSignStaffGubun' value='${slist.sSignStaffGubun}'/>
									<input type='hidden' id='referSign_${j.index}' name='referSign' value='${slist.sSignStaffKey}'/>
									<input type='hidden' id='gubun_${j.index}' name='gubun' value='${slist.sSignStaffGubun}'/>
									<span id='sn_sp_${j.index}' class='sn_sp'>${slist.sSignSequence}</span>
								</td>
							
								<td>
									<span id='sn_sp_${j.index}' class='sn_sp'>${slist.sSignStaffGubun}</span>
								</td>		
							
								<td>
									${slist.kPositionName}&nbsp;/&nbsp;${slist.kClassName}&nbsp;/&nbsp;${slist.sSignStaffName}
								</td>
							
							</tr>	
						</c:forEach>
					<c:if test="${empty signList}">
						<tr>
							<td colspan="8" style="text-align: center;">등록 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
				
			</table>
		</div>
	</div>
	
	
	
	<div class="tbl_btn_right">
		<ul>
			 
			<c:if test="${staffVo.kStaffAuthModifyFlag eq 'T'}">
				<li>
					<a style="cursor: pointer;" onclick="update_go();">저장</a>
				</li>
			</c:if>
			<li>
				<a style="cursor: pointer;" onclick="cancel();">목록</a>
			</li>
		</ul>
	</div>
</form>