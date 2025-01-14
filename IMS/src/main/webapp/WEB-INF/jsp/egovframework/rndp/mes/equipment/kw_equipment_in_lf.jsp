<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<!-- 그리드 S -->
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/gridjs.production.min.js"></script>
<link href="/css/mes/mermaid.min.css" rel="stylesheet"	/>
<link href="/css/mes/mermaid2.min.css" rel="stylesheet"	/>
<script type="text/javascript" src="/js/cdnjs_cloudflare_com_ajax_libs_jqueryui_1.12.1/jquery-ui.min.js"></script>
<link href="/css/mes/jquery-ui.min.css" rel="stylesheet"	type="text/css" />
<script src="/js/xlsx.full.min.js"></script>
<script src="/js/papaparse.min.js"></script>


<script type="text/javascript"> 
function fn_guestList(pageNo) {
	$('#mloader').show();
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "/mes/equipment/kw_equipment_in_lf.do";
	document.listForm.submit();
}
 

function go_insert(){
	$("#mloader").show();
	document.listForm.action = "/mes/equipment/kw_equipment_in_if.do";
	document.listForm.submit();
}

function fn_keyDown(event){
	if(event.keyCode == 13){
		fn_guestList(1);
	}			
}


function formDownload(){
    document.listForm.action = "/mes/equipment/kw_equipment_inExcelForm.do";
    document.listForm.submit();
    document.listForm.action = "/mes/equipment/kw_equipment_in_lf.do";
}

function readExcel(e) {
	$('#mloader').show();
    var input = event.target;
    var reader = new FileReader();
	var cnt = 0;
    reader.onload = function () {
        var data = reader.result;
        var workBook = XLSX.read(data, { type: 'binary' , cellDates: true, dateNF: 'yyyy-mm-dd' });
        workBook.SheetNames.forEach(function (sheetName) {
            var arr = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName], {header:1, raw:false});
            console.log(arr);
        	for(var i = 1 ; i < arr.length; i++){  
        		if(arr[i][0] != ""){
        			$.ajax({
            			method : "post"
            		,	cache  : false
            		,	url    : "/mes/equipment/kw_uploadAssetAjax.do"
            		,	dataType : "json"
            		,	async: false
                 	, 	data: {
                 			aAssetNumber: arr[i][0]
      			      	,	aAssetStatus: arr[i][1]
      				    ,	aAssetType: arr[i][2]
      					,	aAssetName: arr[i][3]
	      				,	aAssetMaker: arr[i][4]
	      				,	aAssetModel: arr[i][5]
	      				,	aAssetManufactureNumber: arr[i][6]
	      				,	aAssetForm: arr[i][7]
	      				,	aAssetIntroducer: arr[i][8]
	      				,	aAssetDate: arr[i][9]
	      				,	aAssetCost: uncomma(arr[i][10])
	      				,	aAssetPurpose: arr[i][11]
	      				,	aAssetEtc: arr[i][12]
	                 	}
            		,	success:function(msg){
            				console.log("성공");
            			}
            		,	error: function(xhr, status, error) {
                     		// 요청이 실패했을 때 수행할 작업
                     		console.log(error);
                     		if (xhr.status === 500) {
                     			// AJAX 요청 중단
                     			console.log('AJAX 요청이 중지되었습니다.');
							}
						} 
             		});
        		}
       		} 
        });
    };
    reader.readAsBinaryString(input.files[0]);
    
    e.target.value = ''; 
}


function eDate(){
	  var currentDate = new Date();
	  var eEosDates = document.getElementsByName("eEosDate");
	  var eEolDates = document.getElementsByName("eEolDate");
	  
	  for (var i = 0; i < eEosDates.length; i++) {
        var eEosDate = eEosDates[i].value;
        var eEolDate = eEolDates[i].value;
        
        var formattedEosDate = formatDateData(new Date(eEosDate));
        var formattedEolDate = formatDateData(new Date(eEolDate));
        
        // eEosDate 처리
        if (!isNaN(formattedEosDate.getTime())) {
            var differenceInDaysEos = Math.floor((formattedEosDate - currentDate) / (1000 * 60 * 60 * 24));
            var expiredEos = differenceInDaysEos < 0;
            var spantextEos = expiredEos ? ": 만료" : ":까지 " + differenceInDaysEos + "일 남음";
            
            document.getElementById("eEosDateTxt_" + i).innerHTML = spantextEos;
        } else {
            document.getElementById("eEosDateTxt_" + i).innerHTML = "";
        }
        
        // eEolDate 처리
        if (!isNaN(formattedEolDate.getTime())) {
            var differenceInDaysEol = Math.floor((formattedEolDate - currentDate) / (1000 * 60 * 60 * 24));
            var expiredEol = differenceInDaysEol < 0;
            var spantextEol = expiredEol ? ": 만료" : ":까지 " + differenceInDaysEol + "일 남음";
            
            document.getElementById("eEolDateTxt_" + i).innerHTML = spantextEol;
        } else {
            document.getElementById("eEolDateTxt_" + i).innerHTML = "";
        }
    }
	  
}

function formatDateData(date) {
	var formattedDate = new Date(date);
    return formattedDate;
}



viewService.prototype.go_view = function(obj) {
	if(obj.childNodes[0].querySelector("input")){  
		$("#eEquipmentInKey").val(obj.childNodes[0].querySelector("input").value);
		document.listForm.action = "/mes/equipment/kw_equipment_in_vf.do";
		document.listForm.submit();
	}
}


function eImport_go(eEquipmentItemKey){	
	var sUrl = "/mes/equipment/kw_eImport_update_pop.do?eEquipmentItemKey="+eEquipmentItemKey;
	window.open(sUrl, "AddrAdd", "width=1400, height=650, status=no, toolbar=no, resizable=yes, menubar=no, location=no, scrollbars=yes");
	window.focus();
}

$(document).ready(function() {
	datepickerSet("eTopStartDate","eTopEndDate");
 
 $(".clear-input").click(function() {
     var targetId = $(this).data("target");
     $("#" + targetId).val("");
 });
 $('table[role="grid"].gridjs-table th:nth-child(1) button').hide();
 $('table[role="grid"].gridjs-table th:nth-child(1)').css('width', '80px'); 
 $('table[role="grid"].gridjs-table th:nth-child(2)').css('width', '100px'); 
 $('table[role="grid"].gridjs-table th:nth-child(3)').css('width', '140px'); 
 $('table[role="grid"].gridjs-table th:nth-child(4)').css('width', '140px'); 
 $('table[role="grid"].gridjs-table th:nth-child(5)').css('width', '140px'); 
 $('table[role="grid"].gridjs-table th:nth-child(6)').css('width', '140px'); 
 $('table[role="grid"].gridjs-table th:nth-child(7)').css('width', '100px'); 
 $('table[role="grid"].gridjs-table th:nth-child(8)').css('width', '120px'); 
 $('table[role="grid"].gridjs-table th:nth-child(9)').css('width', '220px'); 
 $('table[role="grid"].gridjs-table th:nth-child(10)').css('width', '100px'); 
 $('table[role="grid"].gridjs-table th:nth-child(11)').css('width', '120px'); 
 $('table[role="grid"].gridjs-table td:nth-child(11)').each(function() {
	    $(this).css({
	        'white-space': 'nowrap',
	        'overflow': 'hidden',
	        'text-overflow': 'ellipsis'  // 텍스트가 넘칠 경우 '...'로 표시
	    });
	});
 $('table[role="grid"].gridjs-table th:nth-child(12)').css('width', '260px'); 
 $('table[role="grid"].gridjs-table td:nth-child(12)').each(function() {
	    $(this).css({
	    	  "cursor": "default"
	    });
	});
 tdBlock(11);
});
function startApproval(eEquipmentInKey, eStatus){
	$("#mloader").show();
	$("#eEquipmentInKey").val(eEquipmentInKey);
	$("#eStatus").val(eStatus);
	document.listForm.action = "/mes/equipment/kw_equipment_in_lfr.do";
	document.listForm.submit();
}
function excelDwonload(){
    document.listForm.action = "/mes/equipment/kw_equipmentExcelListDwonload.do";
    document.listForm.submit();
    document.listForm.action = "/mes/equipment/kw_equipment_in_lf.do";
}
</script>
  
<style>
  
</style>
<form name="listForm" id="listForm" method="post" action = "/mes/equipment/kw_equipment_in_lf.do">		
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesEquipmentVO.pageIndex}"/>
	<input type="hidden" id="eEquipmentInKey" name="eEquipmentInKey" value="" />
	<input type="hidden" id="eStatus" name="eStatus" value="" />
	
	<div class="content_up">
		<div class="content_tit">
			<h2>임시장비 반입출 관리</h2>
		</div>		
		
		<div class="tbl_top"> 
			<ul class="tbl_top_left">
				
				<li>
					<span>자산명</span>
					<input type="text" id="eSearchWord1" name="eSearchWord1" style="width:150px;" class="searchWord" value="${mesEquipmentVO.eSearchWord1}" maxlength="30"  />
				</li>
				<li>
					<span>모델명</span>
					<input type="text" id="eSearchWord2" name="eSearchWord2" style="width:150px;" class="searchWord" value="${mesEquipmentVO.eSearchWord2}" maxlength="30" />
				</li>
				<li>
					<span>제조사</span>
					<input type="text" id="eSearchWord3" name="eSearchWord3" style="width:150px;" class="searchWord" value="${mesEquipmentVO.eSearchWord3}" maxlength="30" />
				</li>
				<li>
					<span>반입 일자</span>
					<input type="text" id="eTopStartDate" name="eTopStartDate" style="width:100px; text-align: center;" class="inp_color"  value="${mesEquipmentVO.eTopStartDate}" readonly />
		           	~ <input type="text" id="eTopEndDate" name="eTopEndDate" style="width:100px; text-align: center;" class="inp_color"  value="${mesEquipmentVO.eTopEndDate}" readonly />
					
				</li>
				<li style="    padding-left: 50px;">
					<a onclick="fn_guestList(1);" style="cursor: pointer;">
		    			검색
		     		</a>
				</li>
				<li>
					<a onclick="fn_search_detail();" style="cursor: pointer;">
		    			상세검색
		     		</a>
				</li>
				<li>
					<a onclick="excelDwonload();" style="cursor: pointer;">
		    			현황 엑셀 다운로드
		     		</a>
				</li>
			</ul>
			<ul id="search_detail" style="display: none;">
				<li>
					<span>반입확인자</span>
					<input type="text" id="eSearchWord4" name="eSearchWord4" style="width:100px;" class="searchWord"  value="${mesEquipmentVO.eSearchWord4}" maxlength="30" />
					
				</li>
				<li>
					<span>반입사유</span>
					<input type="text" id="eSearchWord5" name="eSearchWord5" style="width:150px;" class="searchWord" value="${mesEquipmentVO.eSearchWord5}" maxlength="30"  />
				</li>
				<li>
					<span>반출확인자</span>
					<input type="text" id="eSearchWord6" name="eSearchWord6" style="width:150px;" class="searchWord" value="${mesEquipmentVO.eSearchWord6}" maxlength="30"  />
				</li>
 
			</ul>	
		</div>
	</div> 	
	
	<div id="tableContainer" class="lf_tbl_list"  >
		<table id="myTable"  >
			<thead>
				<tr>
					<th>No.</th>
					<th>작성자</th>
					<th>자산유형</th>
					<th>자산명</th>
					<th>제조사</th>
					<th>모델명</th>
					<th>반입일자</th>
					<th>반입확인자</th>
					<th>반입사유</th>
					<th>반출일자</th>
					<th>반출확인자</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${assetList}" varStatus="i">
<%-- 					<tr onclick="assetView(<c:out value='${list.eEntryExitItemKey}'/>);"> --%>
					<tr  >
						<td>
							<c:if test="${list.eViewGubun eq 'Y'}"><span style="color: RED;">!</span></c:if>
							${paginationInfo.totalRecordCount - (mesEquipmentVO.pageIndex-1) * paginationInfo.recordCountPerPage  - i.index}
							<input type="hidden" value="${list.eEquipmentInKey}" />
						</td>
						<td>${list.kStaffName}</td>
<%-- 						<td>${list.eSearchWord9}</td> --%>
						<td>${list.eAssetTypeName}</td>
						<td>${list.eAssetName}</td>
						<td>${list.eAssetMaker}</td>
<%-- 						<td>${list.eAssetSNumber}</td> --%>
						<td>${list.eAssetModel}</td>
						<td>${list.eEntryImportDate}</td>
						<td>${list.eEntryImporter}</td>
						<td>${list.eEntryNote}</td>
						<td>${list.eEntryExporterDate}</td>
						<td>${list.eExitExporter}</td>
						<td onclick="event.cancelBubble = true;">
							<c:if test="${list.sSignStatus eq '제외'}">결재 제외	</c:if>
							<c:if test="${list.sSignStatus eq '승인' || list.sSignStatus eq '반려'}">${list.sSignStatus}</c:if>
							<c:if test="${list.sSignStatus eq '등록'}">
								<c:if test="${list.kStaffKey eq staffVO.kStaffKey}"><a style="cursor: pointer;" class="mes_btn" onclick="startApproval('${list.eEquipmentInKey}','Y');">승인요청</a></c:if>
								<c:if test="${list.kStaffKey ne staffVO.kStaffKey}">결재 준비</c:if>
							</c:if>
							<c:if test="${list.sSignStatus eq '승인요청'}">
								<c:if test="${list.kStaffKey eq staffVO.kStaffKey && list.sSignProgress eq '0'}">
									<a style="cursor: pointer;" class="mes_btn" onclick="startApproval('${list.eEquipmentInKey}','N');">요청취소</a>
								</c:if>
								<c:if test="${list.kStaffKey ne staffVO.kStaffKey || list.sSignProgress ne '0'}">결재 진행 중</c:if>
							</c:if>
							
							<c:if test="${empty list.eEntryExporterDate}">
								<c:if test="${not empty list.eEntryImporter}">
							     ${list.eEntryImportDate}:   ${list.eStatus}
							     <c:if test="${list.sSignStatus eq '승인'  || list.sSignStatus eq '제외'}">
							    	 <a class="mes_btn" onclick="eImport_go(${list.eEquipmentItemKey});">반출등록</a>
							     </c:if>
								</c:if>
							</c:if>
							<c:if test="${list.eItemStatus eq '반출등록완료'}">
							    	 ${list.eEntryExporterDate}(${list.eExitExporter}):${list.eItemStatus}
							</c:if>
						</td>
						 
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="tbl_paging">
			<span>
				<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_guestList"/>
			</span>
		</div>
	</div>
    	<div class="tbl_bottom"> 
			<ul class="tbl_bottom_left">
				<li>
					<select name="recordCountPerPage" class="select_recordCountPerPage" id="recordCountPerPage" onchange="fn_guestList(1)">
	              		<option value="10" <c:if test="${mesEquipmentVO.recordCountPerPage eq 10}">selected="selected"</c:if>>Page/10</option>
	              		<option value="20" <c:if test="${mesEquipmentVO.recordCountPerPage eq 20}">selected="selected"</c:if>>Page/20</option>
	              		<option value="50" <c:if test="${mesEquipmentVO.recordCountPerPage eq 50}">selected="selected"</c:if>>Page/50</option>
	              		<option value="100" <c:if test="${mesEquipmentVO.recordCountPerPage eq 100}">selected="selected"</c:if>>Page/100</option>
	       			</select> 
       			</li>
			</ul> 	
			<ul class="tbl_bottom_right">
				<c:if test="${staffVO.kStaffAuthWriteFlag eq 'T'}">
					<li>
						<a onclick="go_insert()">반입 등록</a>
					</li>
				</c:if>
			</ul>
		</div>
</form>