<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<script type="text/javascript">

$(function(){
// 	datepickerSet("topStartDate", "topEndDate");
})


function selectItem(){  
	ePageInfoList();
	 var ePageInfoValue = document.getElementById("ePageInfo").value;
	 var previousValues = ePageInfoValue.split("_");
	 
	   if(ePageInfoValue == ''){
		   alert("선택된 정보가 없습니다.");
		   return;
	   }
	
	   if(previousValues.length > 0){
			var obj = {
				eKeyList :	$("#ePageInfo").val()
			}
			if(typeof(opener.setInfoReturnPop) != "undefined"){
			window.opener.setInfoReturnPop(obj);
			window.close();
			}
	   }
	
// 	var aAssetKeylen = document.getElementsByName("aAssetKey").length;
// 	if(aAssetKeylen > 0){
// 		for(var idx=0; idx < aAssetKeylen ; idx++){
// 			var aAssetKeyValue = document.getElementsByName("aAssetKey")[idx].value;
// 			var rowIndex = document.getElementsByName("rowIndex")[idx].value;
			
// 			if($("#check_"+aAssetKeyValue).is(":checked")){
// 				if(opnerValueChk($("#aAssetKey_"+rowIndex).val(), rowIndex) == true){
// 					var obj = {
// 							aAssetKey 			:  $("#aAssetKey_"+rowIndex).val(),
// 							aAssetNumber 		:  $("#aAssetNumber_"+rowIndex).val(),
// 							aAssetStatus 		:  $("#aAssetStatus_"+rowIndex).val(),
// 							aAssetName 			:  $("#aAssetName_"+rowIndex).val(),
// 							aAssetMaker 		:  $("#aAssetMaker_"+rowIndex).val(),
// 							aAssetModel			:  $("#aAssetModel_"+rowIndex).val(),
// 							aAssetManufactureNumber	:  $("#aAssetManufactureNumber_"+rowIndex).val(),
// 							aAssetIntroducer 	:  $("#aAssetIntroducer_"+rowIndex).val(),
// 							aAssetDate 			:  $("#aAssetDate_"+rowIndex).val(),
// 							aAssetCost 			:  $("#aAssetCost_"+rowIndex).val(),
// 							aAssetType 			:  $("#aAssetType_"+rowIndex).val(),
// 							eNetworkType 			:  $("#eNetworkType_"+rowIndex).val(),
// 							eHostName 		:  $("#eHostName_"+rowIndex).val(),
// 							eIp 		:  $("#eIp_"+rowIndex).val(),
// 							eOs 		:  $("#eOs_"+rowIndex).val()
// 						};
// 					if(typeof(opener.setAssetPop) != "undefined"){
// 						window.opener.setAssetPop(obj);
// 						window.close();
// 					}
// 				}
// 			} 
// 		}
// 	}

}
function opnerValueChk() {

	var eSWRegisterKeyArr = opener.document.getElementsByName("eSWRegisterKey").length;
	if(eSWRegisterKeyArr > 0){
		for(var i=0; i < eSWRegisterKeyArr ; i++){
			var eSWRegisterKey = opener.document.getElementsByName("eSWRegisterKey")[i].value;
			
				if(rowKey == eSWRegisterKey){
					alert($("#cnt_" + (Number(idx)+1)).val() + "번째 항목은  선택된 항목입니다. ");										
					return false;
				}
		}
	}
	
	return true;

}	
var accumulatedValues  = [];
window.onload = function() {
	restoreCheckboxesFromPageInfo();
	
    // 이전 페이지에서 넘어온 ePageInfo의 값
    var previousValues = document.getElementById("ePageInfo").value.split("_");
    
    // 초기화된 accumulatedValues 배열에 이전 값들을 추가합니다.
    if (previousValues.length > 0 && previousValues[0] !== '') {
	    accumulatedValues = previousValues.filter(function(value) {
	        return value !== ''; // 빈 값은 제외합니다.
	    });
    } 
    
    
    
};

function ePageInfoList() {
    var aKeylen = document.getElementsByName("eSWRegisterKey").length;
    var ePageInfoInput = document.getElementById("ePageInfo");
    
    if (aKeylen > 0) {
        var currentValues = ePageInfoInput.value.split("_"); // 현재 ePageInfo의 값 배열로 변환
        var newValues = []; // 새로운 값들을 임시 배열에 담습니다.
        
        for (var idx = 0; idx < aKeylen; idx++) {
            var eSWRegisterKeyValue = document.getElementsByName("eSWRegisterKey")[idx].value;
            
            if (document.getElementById("check_" + eSWRegisterKeyValue).checked) {
                // 선택된 aAssetKeyValue 값을 구분자 "_"로 분리하여 newValues에 추가
               if (newValues.indexOf(eSWRegisterKeyValue) === -1) {
                    newValues.push(eSWRegisterKeyValue); // 중복이 아니면 배열에 추가
                }
            }
        }
        
        // accumulatedValues 배열과 newValues 배열을 합쳐서 최종 값을 설정합니다.
        var finalValues = accumulatedValues.concat(newValues);
        
        // 최종 값을 ePageInfo에 설정합니다.
        ePageInfoInput.value = newValues.join("_");
    } 
}
function ePageInfoList2() {
    var aKeylen = document.getElementsByName("eSWRegisterKey").length;
    var ePageInfoInput = document.getElementById("ePageInfo");

    if (aKeylen > 0) {
        var currentValues = ePageInfoInput.value.split("_"); // 현재 ePageInfo의 값 배열로 변환
        var newValues = []; // 새로운 값들을 임시 배열에 담습니다.

        for (var idx = 0; idx < aKeylen; idx++) {
            var eSWRegisterKeyValue = document.getElementsByName("eSWRegisterKey")[idx].value;

            // 추가: 부모 창에서 중복 체크
            var eSWRegisterKeyArr = opener.document.getElementsByName("eSWRegisterKey").length;
            var isDuplicate = false;
            
            for (var i = 0; i < eSWRegisterKeyArr; i++) {
                var eSWRegisterKeyParent = opener.document.getElementsByName("eSWRegisterKey")[i].value;
                
                if (eSWRegisterKeyValue === eSWRegisterKeyParent) {
                    isDuplicate = true;
                    break;
                }
            }

            if (!isDuplicate && document.getElementById("check_" + eSWRegisterKeyValue).checked) {
                // 선택된 eSWRegisterKeyValue 값을 구분자 "_"로 분리하여 newValues에 추가
                if (newValues.indexOf(eSWRegisterKeyValue) === -1) {
                    newValues.push(eSWRegisterKeyValue); // 중복이 아니면 배열에 추가
                }
            }
        }

        // accumulatedValues 배열과 newValues 배열을 합쳐서 최종 값을 설정합니다.
        var finalValues = currentValues.concat(newValues);

        // 최종 값을 ePageInfo에 설정합니다.
        ePageInfoInput.value = finalValues.join("_");
    }
}
function restoreCheckboxesFromPageInfo() {
    var ePageInfoInput = document.getElementById("ePageInfo");
    var checkboxPrefix = "check_"; // 체크박스 id의 접두사
    
    if (ePageInfoInput) {
        var pageInfoValues = ePageInfoInput.value.split("_"); // ePageInfo의 값을 '_'로 분할하여 배열로 변환
        
        pageInfoValues.forEach(function(value) {
            var checkboxId = checkboxPrefix + value;
            var checkbox = document.getElementById(checkboxId);
            
            if (checkbox) {
                checkbox.checked = true; // 해당 체크박스를 체크 처리
            }
        });
    }
}
// 검색
function fn_guestList(pageNo) {
	ePageInfoList();
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "/mes/asset/popup/kw_license_pop.do";
	document.frm.submit();
}


function fn_search_detail(){
	
	if($("#search_detail").is(":visible")){
		$('#search_detail').attr("style", "display : none;");
	}else{
		$('#search_detail').attr("style", "display : block;");
	}	
}

function rowCheck(index){
	 // 해당 체크박스 요소를 가져옵니다.
    var checkbox = document.getElementById("check_" + index);

    // 체크박스의 현재 상태를 반전시킵니다.
    checkbox.checked = !checkbox.checked;
}
function selectRow(key) {
    var checkbox = document.getElementById("check_" + key);
    if (checkbox) {
        checkbox.checked = !checkbox.checked;
    }
}
</script>

<form id="frm" name="frm" method="post" action="/mes/asset/popup/kw_license_pop.do">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesAssetVO.pageIndex}">
	<input type="hidden" id="searchType" name="searchType" value="${mesAssetVO.searchType}">
	<input type="hidden" id="ePageInfo" name="ePageInfo" value="${mesAssetVO.ePageInfo}">
	
	<div class="pop_head">
		<div id="pop_head">
			<div class="tit">
				<h3>라이선스 등록 현황</h3>
			</div>
			<a href="javascript:self.close();"><img src="/images/btn/close.gif" width="22" height="21" /></a>
		</div>
	</div>
		
	<div class="popup_content">		
		<div id="itemCateZone" class="tbl_top">
			<ul class="tbl_top_left">
				<li>
	          		<select name="recordCountPerPage" class="select_recordCountPerPage" id="recordCountPerPage"  onchange="fn_guestList(1);">
	              		<option value="20" <c:if test="${mesAssetVO.recordCountPerPage eq 20}">selected="selected"</c:if>>Page/20</option>
	              		<option value="50" <c:if test="${mesAssetVO.recordCountPerPage eq 50}">selected="selected"</c:if>>Page/50</option>
	              		<option value="100" <c:if test="${mesAssetVO.recordCountPerPage eq 100}">selected="selected"</c:if>>Page/100</option>
       				</select>					
				</li>
				 <li>
					<span>제조사</span>
					<input type="text" id="searchTypeSet1" name="searchTypeSet1" style="width:150px;" class="searchWord" value="${mesAssetVO.searchTypeSet1}" />
				</li>
				<li>
					<span>라이선스명</span>
					<input type="text" id="searchTypeSet2" name="searchTypeSet2" style="width:150px;" class="searchWord" value="${mesAssetVO.searchTypeSet2}" />
				</li>
				 
				<li>
					<span>유효기간</span>
					<input type="text" id="searchTypeSet3" name="searchTypeSet3" style="width:150px;" class="searchWord" value="${mesAssetVO.searchTypeSet3}" />
				</li>
				 
				<li>
					<a onclick="fn_guestList(1);" style="cursor: pointer;">
		    			검색
		     		</a>
				</li>
			</ul>
			<ul class="tbl_top_right">
				<li>
					<a onclick='selectItem()'>선택</a>
				</li>
			</ul>
		</div>
		
		
		<div class="lf_tbl_list" id="pop_result_list">
			<table>
		        <thead>
					<tr>
							<th style="width:2%;">-</th>
							<th style="width:8%;">제조사</th>
							<th style="width:8%;">라이선스명</th>
							<th style="width:5%;">버전</th>
							<th style="width:8%;">구매일</th>
							<th style="width:8%;">시작일</th>
							<th style="width:8%;">종료일</th>
							<th style="width:8%;">유효기간</th>
							<th style="width:5%;">수량</th>
							<th style="width:5%;">사용수량</th>
							<th style="width:8%;">비고</th>
					</tr>
		        </thead>
		        <tbody>
						<c:forEach var="list" items="${assetList}" varStatus="i">
							<tr onclick="selectRow(<c:out value='${list.eSWRegisterKey}'/>);">
								<td>
									<input type="hidden" id="cnt_${i.index}" name="rowIndex" value="${i.index}"/>
									<input type="checkbox" id="check_${list.eSWRegisterKey}" name="check">
									<input type="hidden"  id="eSWRegisterKey" name="eSWRegisterKey" value="${list.eSWRegisterKey}" />
								</td>
								<td>
									${list.eManufacturer}
								</td>
								<td>
									${list.eProductName}
								</td>
								<td>
									${list.eVersion}
								</td>
								<td style="text-align: center; ">
									${list.ePurchaseDate}
								</td>
								<td style="text-align: center; ">
									${list.eStartDate}
								</td>
								<td style="text-align: center; ">
									${list.eEndDate}
								</td>
								<td>
									${list.eValidityPeriod}
								</td>
								<td style="text-align: center; padding-right:5px;">
									${list.eLicenseQuantity}
								</td>
								<td style="text-align: center; padding-right:5px;">
									${list.eUsedLicenseQuantity}
								</td>
								<td>
									${list.eRemarks}
								</td>
							</tr>
					</c:forEach>
					<c:if test="${empty assetList}">
						<tr>
							<td colspan="20">내역이 없습니다.</td>
						</tr>
					</c:if>
		        </tbody>
			</table>
		</div>		
		
		<div class="page">	
			<span>
		  		<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="fn_guestList" />
			</span>
		</div>	
	</div>
</form>

