<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<script type="text/javascript" src="<c:url value='/js/kw_common.js'/>"></script>
<script type="text/javascript">

$(function(){
	datepickerSet("topStartDate","topEndDate");
})


function selectValue(idx) {

	var obj = {
		aAssetKey 			:  $("#aAssetKey_"+idx).val(),
		aAssetNumber 		:  $("#aAssetNumber_"+idx).val(),
		aAssetStatus 		:  $("#aAssetStatus_"+idx).val(),
		aAssetName 			:  $("#aAssetName_"+idx).val(),
		aAssetMaker 		:  $("#aAssetMaker_"+idx).val(),
		aAssetModel			:  $("#aAssetModel_"+idx).val(),
		aAssetManufactureNumber	:  $("#aAssetManufactureNumber_"+idx).val(),
		aAssetIntroducer 	:  $("#aAssetIntroducer_"+idx).val(),
		aAssetDate 			:  $("#aAssetDate_"+idx).val(),
		aAssetCost 			:  $("#aAssetCost_"+idx).val(),
		aAssetType 			:  $("#aAssetType_"+idx).val(),
		eNetworkType 			:  $("#eNetworkType_"+idx).val(),
		eHostName 		:  $("#eHostName_"+idx).val(),
		eIp 		:  $("#eIp_"+idx).val(),
		eOs 		:  $("#eOs_"+idx).val()
		
								 
	};
	
	
	if(typeof(opener.setAssetPop) != "undefined"){
		window.opener.setAssetPop(obj);
		window.close();
	}
}

// 검색
function fn_guestList(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "/mes/asset/kw_Replacement_Pop.do";
	document.frm.submit();
}


function fn_search_detail(){
	
	if($("#search_detail").is(":visible")){
		$('#search_detail').attr("style", "display : none;");
	}else{
		$('#search_detail').attr("style", "display : block;");
	}	
}

</script>

<form id="frm" name="frm" method="post"  >
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesAssetVO.pageIndex}">
	<input type="hidden" id="searchType" name="searchType" value="${mesAssetVO.searchType}">
	<input type="hidden" id="searchType" name="searchType" value="${mesAssetVO.searchType}">
	<input  type="hidden" id="eAssetKey" name="eAssetKey" value="${mesAssetVO.eAssetKey}" />
	
	<div class="pop_head">
		<div id="pop_head">
			<div class="tit">
				<h3>부품교체 이력 조회</h3>
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
<!-- 				<li> -->
<!-- 					<span>자산번호</span> -->
<%-- 					<input type="text" id="searchTypeSet1" name="searchTypeSet1" style="width:150px;" class="searchWord" value="${mesAssetVO.searchTypeSet1}" /> --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<span>설치위치</span> -->
<%-- 					<input type="text" id="searchTypeSet2" name="searchTypeSet2" style="width:150px;" class="searchWord" value="${mesAssetVO.searchTypeSet2}" /> --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<span>자산명</span> -->
<%-- 					<input type="text" id="searchTypeSet3" name="searchTypeSet3" style="width:150px;" class="searchWord" value="${mesAssetVO.searchTypeSet3}" /> --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<span>제조사</span> -->
<%-- 					<input type="text" id="searchTypeSet4" name="searchTypeSet4" style="width:150px;" class="searchWord" value="${mesAssetVO.searchTypeSet4}" /> --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<span>도입일</span> -->
<%-- 					<input type="text" id="searchTypeSet5" name="searchTypeSet5" style="width:100px;" value="${mesAssetVO.searchTypeSet5}" readonly="readonly"/> --%>
<!-- 				</li> -->
				<li>
					<span>요청 일자</span>
					<input type="text" id="topStartDate" name="topStartDate" style="width:100px;text-align: center;" class="inp_color"  value="${mesAssetVO.topStartDate}" readonly />
		           	~ <input type="text" id="topEndDate" name="topEndDate" style="width:100px;text-align: center;" class="inp_color"  value="${mesAssetVO.topEndDate}" readonly />
					
				</li>
				<li>
					<a onclick="fn_guestList(1);" style="cursor: pointer;">
		    			검색
		     		</a>
				</li>
<!-- 				<li> -->
<!-- 					<a onclick="fn_search_detail();"  style="cursor: pointer;"> -->
<!-- 		    			상세검색 -->
<!-- 		     		</a> -->
<!-- 				</li> -->
			</ul>
<!-- 			<ul id="search_detail" style="display: none;"> -->
<!-- 				<li> -->
<!-- 					<span>모델명</span> -->
<%-- 					<input type="text" id="searchTypeSet6" name="searchTypeSet6" style="width:100px;" value="${mesAssetVO.searchTypeSet6}" /> --%>
<!-- 				</li> -->
<!-- 				<li> -->
<!-- 					<span>상태</span> -->
<%-- 					<input type="text" id="searchTypeSet7" name="searchTypeSet7" style="width:100px;" value="${mesAssetVO.searchTypeSet7}" /> --%>
<!-- 				</li> -->
<!-- 			</ul> -->
		</div>
		
		
		<div class="lf_tbl_list" id="pop_result_list">
			<table>
		        <thead>
					<tr>
						<th>No.</th>
						<th>자산유형</th>
						<th>자산번호</th>
						<th>자산명</th>
						<th>제조사</th>
						<th>모델명</th>
						<th>요청일</th>
						<th>요청자</th>
						<th>교체 정보</th>
						<th>작업일</th>
						<th>작업자</th>
					</tr>
		        </thead>
		        <tbody>
					<c:forEach var="list" items="${assetList}" varStatus="i">
							<tr  >
								<td>
									${paginationInfo.totalRecordCount - (mesAssetVO.pageIndex-1) * paginationInfo.recordCountPerPage  - i.index}
									<input type="hidden" value="${list.eEntryExitItemKey}" />
								</td>
								<td>${list.eAssetType}</td>
								<td>${list.eAssetNumber}</td>
								<td>${list.eAssetName}</td>
								<td>${list.eAssetMaker}</td>
								<td>${list.eAssetModel}</td>
								<td>${list.eReplacementRequestDate}</td>
								<td>${list.eReplacementRequester}</td>
								<td>${list.ePartReplacementReason}</td>
								<td>${list.eReplacementDate}</td>
								<td>${list.eReplacedBy}</td>
							</tr>
					</c:forEach>
					<c:if test="${empty assetList}">
						<tr>
							<td colspan="11">이력 정보가 없습니다.</td>
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

