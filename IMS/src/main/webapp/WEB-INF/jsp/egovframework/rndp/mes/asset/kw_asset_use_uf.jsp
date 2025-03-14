<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<script src="/js/jquery-ui-1.14.1/jquery-ui.min.js"></script>
<script type="text/javascript">
$(function(){
	
	datepickerIdSet("aAssetUseDate");
	
	
	$("#oPass").click(function(){
		 if($("#oPass").is(":checked")){
			  $("#oSignPass").val("Y");
		 }else{
			  $("#oSignPass").val("N");
		 }
	});
})


function update_go(){
	if(chkIns()){
		if(confirm("수정하시겠습니까?")){
			$('#mloader').show();
			document.frm.action = "/mes/asset/kw_asset_use_u.do";
			document.frm.submit(); 
		}
	}
}

// validation
function chkIns(){
	if($('#aAssetKey').val() == ""){
		alert("자산번호를 선택하세요.");
		return false;
	}
	
	
	var ln = document.getElementsByName("aAssetUseType").length;
	
	for(var i = 0; i < ln; i++){

		if($('#aAssetUseType_'+i).val() == ""){
			alert("상태를 선택하세요.");
			$('#aAssetUseType_'+i).focus();
			return false;
		}
		
		if($('#aAssetRequestDate_'+i).val() == ""){
			alert("날짜를 입력하세요.");
			$('#aAssetRequestDate_'+i).focus();
			return false;
		}
		
		//특수문자처리
		$('#aAssetInstallPlace_'+i).val(ConverttoHtml($('#aAssetInstallPlace_'+i).val()));
		$('#aAssetInstallPlaceDetail_'+i).val(ConverttoHtml($('#aAssetInstallPlaceDetail_'+i).val()));
		$('#aAssetUseHost_'+i).val(ConverttoHtml($('#aAssetUseHost_'+i).val()));
		$('#aAssetUseNet_'+i).val(ConverttoHtml($('#aAssetUseNet_'+i).val()));
		$('#aAssetUseIp_'+i).val(ConverttoHtml($('#aAssetUseIp_'+i).val()));
		$('#aAssetUseMac_'+i).val(ConverttoHtml($('#aAssetUseMac_'+i).val()));
		$('#aAssetUseOS_'+i).val(ConverttoHtml($('#aAssetUseOS_'+i).val()));
		$('#aAssetUseSector_'+i).val(ConverttoHtml($('#aAssetUseSector_'+i).val()));
		$('#aAssetUseManager_'+i).val(ConverttoHtml($('#aAssetUseManager_'+i).val()));
		$('#aAssetUsePhone_'+i).val(ConverttoHtml($('#aAssetUsePhone_'+i).val()));
	}
	
	

	if($("#oSignPass").val() != 'Y'){
		if(document.getElementsByName("sSignStaffKey").length == 0){
			alert("승인권자를 선택해주세요");
			return false;
		}
	}
	
	return true;
}

function cancle(){
	$('#mloader').show();
	document.frm.action = "/mes/asset/kw_asset_use_lf.do";
	document.frm.submit(); 
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


var referIndex = document.getElementsByName("sSignStaffKey").length;
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
	innerStr += "			<span id='sn_sp_"+referIndex+"' class='sn_sp'>"+obj.kPositionName+"</span>";
	innerStr += "		</td>";		
	// 이름
	innerStr += "		<td>";
	innerStr += "			 "+(obj.kStaffName)+" "+(obj.kClassName)+"";
	innerStr += "		</td>";
	innerStr += "	</tr>";
	
	$(innerStr).appendTo("#lineRow3");		
	
	referIndex++;
}

// 행삭제
function delRow(obj){
	
	var tr = $(obj).parent().parent();
	tr.remove();
	
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

function setAssetPop(obj){
	$("#aAssetNumber_sp").text(obj.aAssetNumber);
	$("#aAssetStatus_sp").text(obj.aAssetStatus);
	$("#aAssetName_sp").text(obj.aAssetName);
	$("#aAssetMaker_sp").text(obj.aAssetMaker);
	$("#aAssetModel_sp").text(obj.aAssetModel);
	$("#aAssetManufactureNumber_sp").text(obj.aAssetManufactureNumber);
	$("#aAssetIntroducer_sp").text(obj.aAssetIntroducer);
	$("#aAssetDate_sp").text(obj.aAssetDate);
	$("#aAssetCost_sp").text(obj.aAssetCost);
	

	$("#aAssetKey").val(obj.aAssetKey );
	$("#aAssetNumber").val(obj.aAssetNumber);
	$("#aAssetStatus").val(obj.aAssetStatus);
	$("#aAssetName").val(obj.aAssetName);
	$("#aAssetMaker").val(obj.aAssetMaker);
	$("#aAssetModel").val(obj.aAssetModel);
	$("#aAssetManufactureNumber").val(obj.aAssetManufactureNumber);
	$("#aAssetIntroducer").val(obj.aAssetIntroducer);
	$("#aAssetDate").val(obj.aAssetDate);
	$("#aAssetCost").val(uncomma(obj.aAssetCost));
	$("#aAssetImage").val(obj.aAssetImage);
}


/**
 * 이력 행추가
 */
var row_Index = parseInt("${fn:length(assetUseList)}");
function addRow(){
	
	var innerStr = "";
	
	// 행삭제
	innerStr += "	<tr>";
	innerStr += "		<td>";
	innerStr += "			<a class='del' onclick=\"delRow(this);\">X</a>";
	innerStr += "		</td>";
	// 순번
	innerStr += "		<td>"
	innerStr += "			<select id='aAssetUseType_"+row_Index+"' name='aAssetUseType'>";
	innerStr += "				<option value=''>선택</option>";
	innerStr += "			<c:forEach var='gubun35List' items='${gubun35List}'>";
	innerStr += "				<option value='${gubun35List.sGubunName}'>${gubun35List.sGubunName}</option>";						
	innerStr += "			</c:forEach>";
	innerStr += "			</select>";
	innerStr += "		</td>";
	// 요청일
	innerStr += "		<td>"
	innerStr += "			<input type='text' id='aAssetRequestDate_"+row_Index+"' name='aAssetRequestDate' class='inp_color' style='width:95%; text-align:center;' readonly/>";
	innerStr += "		</td>";		
	// 설치장소
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetInstallPlace_"+row_Index+"' name='aAssetInstallPlace' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";
	// 세부장소
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetInstallPlaceDetail_"+row_Index+"' name='aAssetInstallPlaceDetail' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";
	// host명
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUseHost_"+row_Index+"' name='aAssetUseHost' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	// 망구분
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUseNet_"+row_Index+"' name='aAssetUseNet' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	// ip주소
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUseIp_"+row_Index+"' name='aAssetUseIp' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	// max주소
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUseMac_"+row_Index+"' name='aAssetUseMac' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	// os버전
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUseOS_"+row_Index+"' name='aAssetUseOS' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	// 운영부서
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUseSector_"+row_Index+"' name='aAssetUseSector' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	// 운영담당자
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUseManager_"+row_Index+"' name='aAssetUseManager' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	// 연락처
	innerStr += "		<td>";
	innerStr += "			<input type='text' id='aAssetUsePhone_"+row_Index+"' name='aAssetUsePhone' style='width:95%;' maxlength='100' value=''/>";
	innerStr += "		</td>";	
	innerStr += "	</tr>";
	
	$(innerStr).appendTo("#lineRow");	
	
	datepickerIdSet("aAssetRequestDate_"+row_Index);
	
	row_Index++;
}


</script>


<form id="frm" name="frm" method="post">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesAssetVO.pageIndex}" />
	<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="${mesAssetVO.recordCountPerPage}" />
	<input type="hidden" id="searchWord"name="searchWord" value="${mesAssetVO.searchWord}">
	<input type="hidden" id="searchType" name="searchType" value="${mesAssetVO.searchType}" />
	
	<input type="hidden" id="aAssetKey" name="aAssetKey" value="${assetUseInfo.aAssetKey}">
	<input type="hidden" id="aAssetUseHKey" name="aAssetUseHKey" value="${assetUseInfo.aAssetUseHKey}">
	<input type="hidden" id="sSignKey" name="sSignKey" value="${assetUseInfo.sSignKey}">
	
	<div class="content">
		<div class="content_tit">
			<h2>대상장비 이력 수정</h2>
		</div>
	</div>
	
	<div class="tbl_write">
		<table>
			<caption style="text-align: left; margin-bottom:10px;">
				□ 대상장비 정보
			</caption>
			<tbody>
				<tr>
					<th>자산번호</th>
					<td>
						<span id="aAssetNumber_sp">${assetUseInfo.aAssetNumber}</span>
						<input type="hidden" id="aAssetNumber" name="aAssetNumber" value="${assetUseInfo.aAssetNumber}">
						<a class="mes_btn" onclick="sel_asset()">선택</a>						
					</td>
					<th>작성일자</th>
					<td>
						<input type="text" id="aAssetUseDate" name="aAssetUseDate" class='inp_color' value="${assetUseInfo.aAssetUseDate}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>제조사</th>
					<td>
						<span id="aAssetMaker_sp">${assetUseInfo.aAssetMaker}</span>
						<input type="hidden" id="aAssetMaker" name="aAssetMaker" value="${assetUseInfo.aAssetMaker}">
					</td>
					<th>*자산명</th>
					<td>
						<span id="aAssetName_sp">${assetUseInfo.aAssetName}</span>
						<input type="hidden" id="aAssetName" name="aAssetName" value="${assetUseInfo.aAssetName}">
					</td>
				</tr>
				<tr>
					<th>제조번호</th>
            		<td>
            			<span id="aAssetManufactureNumber_sp">${assetUseInfo.aAssetManufactureNumber}</span>	
            			<input type="hidden" id="aAssetManufactureNumber" name="aAssetManufactureNumber" value="${assetUseInfo.aAssetManufactureNumber}">					
            		</td>
					<th>모델명</th>
					<td>
						<span id="aAssetModel_sp">${assetUseInfo.aAssetModel}</span>
						<input type="hidden" id="aAssetModel" name="aAssetModel" value="${assetUseInfo.aAssetModel}">
					</td>
				</tr>
          		<tr>
            		<th>설치위치</th>
            		<td>
            			<span id="aAssetIntroducer_sp">${assetUseInfo.aAssetIntroducer}</span>
            			<input type="hidden" id="aAssetIntroducer" name="aAssetIntroducer" value="${assetUseInfo.aAssetIntroducer}">
            		</td>
            		<th>도입일</th>
            		<td>
            			<span id="aAssetDate_sp">${assetUseInfo.aAssetDate}</span>
            			<input type="hidden" id="aAssetDate" name="aAssetDate" value="${assetUseInfo.aAssetDate}">
            		</td>
          		</tr>				
          		<tr> 
            		<th>장비사진</th>
            		<td colspan="3">
						<a class="mes_btn" onclick="view_img()">view</a>
						<input type="hidden" id="aAssetImage" name="aAssetImage" value="${assetUseInfo.aAssetImage}">
					</td>
				</tr>				
			</tbody>
		</table>
	</div>
	
	<div class="tbl_list">
      	<table>
        	<caption style="text-align: left; margin-bottom:10px;">
				□ 대상장비 이력 <a class="mes_btn" onclick="addRow()" style="float:right">행추가</a>
			</caption>
        	<thead>
          		<tr>
          			<th style="width:7.5%;">구분</th>
            		<th style="width:7.5%;">*상태</th>
            		<th style="width:7.5%;">*요청일</th>
            		<th style="width:7.5%;">설치장소</th>
            		<th style="width:7.5%;">세부장소</th>
            		<th style="width:7.5%;">HOST명</th>
            		<th style="width:7.5%;">망구분</th>
            		<th style="width:7.5%;">IP주소</th>
            		<th style="width:7.5%;">MAC주소</th>
            		<th style="width:7.5%;">OS버전</th>
            		<th style="width:7.5%;">운영부서</th>
            		<th style="width:7.5%;">운영담당자</th>
            		<th style="width:7.5%;">연락처</th>
          		</tr>
        	</thead>
        	<tbody id="lineRow">
        		<c:forEach var="assetUseList" items="${assetUseList}" varStatus="i">        			
	        		<tr style="background-color:#dff0f4;">
	        			<td>
	        				<a class='del' onclick="delRow(this);">X</a>
	        			</td>
						<td>
							<select id='aAssetUseType_${i.index}' name='aAssetUseType'>
								<option value=''>선택</option>
							<c:forEach var='gubun35List' items='${gubun35List}'>
								<option value='${gubun35List.sGubunName}' <c:if test="${assetUseList.aAssetUseType eq gubun35List.sGubunName}">selected</c:if>>${gubun35List.sGubunName}</option>						
							</c:forEach>
							</select>
						</td>				
						<td>
							<input type='text' id='aAssetRequestDate_${i.index}' name='aAssetRequestDate' class='inp_color' style='width:95%; text-align:center;' value='${assetUseList.aAssetRequestDate}' readonly/>
						</td>
						<td>
							<input type='text' id='aAssetInstallPlace_${i.index}' name='aAssetInstallPlace' style='width:95%;' maxlength='100' value='${assetUseList.aAssetInstallPlace}'/>
						</td>
						<td>
							<input type='text' id='aAssetInstallPlaceDetail_${i.index}' name='aAssetInstallPlaceDetail' style='width:95%;' maxlength='100' value='${assetUseList.aAssetInstallPlaceDetail}'/>
						</td>
						<td>
							<input type='text' id='aAssetUseHost_${i.index}' name='aAssetUseHost' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUseHost}'/>
						</td>					
						<td>
							<input type='text' id='aAssetUseNet_${i.index}' name='aAssetUseNet' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUseNet}'/>
						</td>
						<td>
							<input type='text' id='aAssetUseIp_${i.index}' name='aAssetUseIp' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUseIp}'/>
						</td>
						<td>
							<input type='text' id='aAssetUseMac_${i.index}' name='aAssetUseMac' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUseMac}'/>
						</td>
						<td>
							<input type='text' id='aAssetUseOS_${i.index}' name='aAssetUseOS' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUseOS}'/>
						</td>
						<td>
							<input type='text' id='aAssetUseSector_${i.index}' name='aAssetUseSector' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUseSector}'/>
						</td>
						<td>
							<input type='text' id='aAssetUseManager_${i.index}' name='aAssetUseManager' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUseManager}'/>
						</td>				
						<td>
							<input type='text' id='aAssetUsePhone_${i.index}' name='aAssetUsePhone' style='width:95%;' maxlength='100' value='${assetUseList.aAssetUsePhone}'/>
						</td>	
					</tr>
        		</c:forEach>
			</tbody>
		</table>
	</div>
	
	
	<div style="margin-top:60px;">   
		<div class="tbl_top">
			<ul class="tbl_top_left">
				<li style="padding:0em;">
					<a onclick="approvalPop();">승인권자 선택</a>
					결재 제외 <input type="checkbox" id="oPass" name="oPass" class="checkbox" <c:if test="${assetUseInfo.oSignPass eq 'Y' }">checked="checked"</c:if>/>
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
				<c:forEach var="signList" items="${signList}" varStatus="i">
		          	<tr>
						<td>
							<a class="del" onclick=delRow(this);>X</a>
					
							<input type="hidden" id="sSignStaffKey_${i.index}" name="sSignStaffKey" value="${signList.sSignStaffKey}"/>
							<input type="hidden" id="sSignStaffName_${i.index}" name="sSignStaffName" value="${signList.sSignStaffName}"/>
							<input type="hidden" id="sSignStaffPosition_${i.index}" name="sSignStaffPosition" value="${signList.sSignStaffPosition}"/>
							<input type="hidden" id="sSignSequence_${i.index}" name="sSignSequence" value="${i.index}"/>
						</td>
						<td>
							${i.index + 1}
						</td>
						<td>
							${signList.sSignStaffPosition}
						</td>
						<td style="text-align:left; padding-left:5px; width:20%;">
							${signList.sSignStaffName}
						</td>
					</tr>
				</c:forEach>		
				</tbody>
				
			</table>
		</div>	
	</div>	
	
	<div class="tbl_btn_right">
		<ul>
			<c:if test="${staffVO.kStaffAuthWriteFlag eq 'T'}">
				<li>
	         		<a style="cursor: pointer;" onclick="update_go();">
						수정
					</a> 
				</li>
			</c:if>
			<li>
         		<a style="cursor: pointer;" onclick="cancle();">
					목록
				</a>
	 		</li>
	 	</ul>
	</div>
</form>