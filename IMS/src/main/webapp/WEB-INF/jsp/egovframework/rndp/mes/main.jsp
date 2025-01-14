<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<script src="/js/jquery-ui-1.14.1/jquery-ui.min.js"></script>
<script src="/js/highchart/code/highcharts.js"></script>
<script type="text/javascript">
/* 페이징 */
function fn_guestList(pageNo) {
	$('#mloader').show();
	document.frm.submit();
}

function fn_keyDown(){
	if(event.keyCode == 13){
		fn_guestList(1);
	}			
}

function nowDate(){
    var date = new Date();
    var year = date.getFullYear();
    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
    var nowDate = year + "-" + month + "-" + day;
	
    return nowDate;
}


$(document).ready(function(){	
	datepickerSet('topStartDate', 'topEndDate');
	

});






function setStartDate(d) {
	var settingDate = new Date();
	if(d == '1d'){
		settingDate.setDate(settingDate.getDate()-1);
		$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	}else if(d == '2d'){
		settingDate.setDate(settingDate.getDate()-2);
		$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	}else if(d == '3d'){
		settingDate.setDate(settingDate.getDate()-3);
		$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	}else if(d == '7'){
		settingDate.setDate(settingDate.getDate()-7);
		$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	}else if(d == '1'){
		settingDate.setMonth(settingDate.getMonth()-1);
		$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	}else{
		settingDate.setMonth(settingDate.getMonth()-3);
		$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	}

	fn_guestList(1);
}





function openTab(evt, tabName) {
    evt.preventDefault(); 
    
    var i, tabcontent, tablinks;
    // Hide all tab contents
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    
    // Remove the active class from all tabs
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    
    // Show the current tab and add an "active" class to the tab button
    document.getElementById(tabName).style.display = "block";
    evt.currentTarget.className += " active";
}


function moveDetail(url){
	$("#topStartDate").val("");
	$("#topEndDate").val("");
	if(url != ''){
		document.frm.action = url;
	}else{
		document.frm.action = "/mes/main.do";
	}
	document.frm.submit();
}



</script>
<style>
.seoeun_top{background:#f5f7fa; border: 1px solid #c8d1db; width: 100%; text-align: left;margin-bottom:10px; padding: 0.5em 0;}
.tabs {
    background-color: #ffffff;
    box-shadow: 0 0 1px rgba(0, 0, 0, 0.2);
    width: 100%;
    margin: 10px auto;
}

/* 탭 스타일 */
.tab_item {
    width: calc(50% - 2px);
    height: 40px;
    border-bottom: 3px solid #22499d;
    background-color: #f8fafc;
    line-height: 40px;
    font-size: 14px;
    text-align: center;
    color: #333333;
    display: block;
    float: left;
    text-align: center;
    font-weight: bold;
    transition: all 0.2s ease;
    border-top: 1px solid #ddd;
}

/* 라디오 버튼 UI삭제 */
input[name="tab_item"] {
    display: none;
}

/* 탭 컨텐츠 스타일 */
.tab_content {
    display: none;
    padding: 20px;
    clear: both;
    overflow: hidden;
    border: 1px solid #ddd;
    border-top: 0;
}

/* 선택된 탭 콘텐츠를 표시 */
#all:checked ~ #all_content,
#programming:checked ~ #programming_content {
    display: block;
}

/* 선택된 탭 스타일 */
.tabs input:checked + .tab_item {
    background-color: #fff;
    color: #009edb;
    position: relative;
}

.tabs input:checked + .tab_item::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -3px;
    width: 100%;
    border-bottom: 3px solid #fff;
    border-top: 3px solid #22499d;
    top: 0;
    border-left: 3px solid #22499d;
    border-right: 3px solid #22499d;
}
</style>
<form id="frm" name="frm" method="post"	action="/mes/main.do">
			
		 <div id="mes_container">
			<div class="main_title" >
				시스템 관리 현황
			</div>
			<div style="width:100%; display:block;">
				<ul class="tbl_top_left seoeun_top">
					<li style="padding-left:1em;">
						<input type="text" name="topStartDate" id="topStartDate" value="${vo.topStartDate}" style="width:100px;" readonly class="inp_color" />
						~ <input type="text" name="topEndDate" id="topEndDate" value="${vo.topEndDate}" style="width:100px;" readonly class="inp_color" />
					</li>
					<li>
						<a onclick="fn_guestList(1)">검색</a>
					</li>
					<li>
						<a style="cursor: pointer;" onclick="setStartDate('1d');">
							1일전
						</a>
					</li>
					<li>
						<a style="cursor: pointer;" onclick="setStartDate('2d');">
							2일전
						</a>
					</li>
					<li>
						<a style="cursor: pointer;" onclick="setStartDate('3d');">
							3일전
						</a>
					</li>
					<li>
						<a style="cursor: pointer;" onclick="setStartDate(7);">
							1주일
						</a>
					</li>
					<li>
						<a style="cursor: pointer;" onclick="setStartDate(1);">
							1개월
						</a>
					</li>
					<li>
						<a style="cursor: pointer;" onclick="setStartDate(3);">
							3개월
						</a>
					</li>
				</ul>
				<div class="main_left" style="">
					<ul>
						<li> 
							<div <c:if test="${ass766 eq 'T' }">onclick="moveDetail('/mes/issue/kw_issue_lf.do');" </c:if> style="cursor:pointer;">
								<table>
									<tr style="height: 10%">
										<th colspan="3" style="vertical-align: middle;font-size: 18pt;color: #22499d;">장애관리</th>
									</tr>
									<tr style="height: 10%;font-size: 16pt;color: #22499d;font-weight: bold;">
										<th>등록</th>
										<th>처리  중</th>
										<th>완료</th>
									</tr>
									<tr style="height: 10%;font-size: 15pt;">
										<th style="vertical-align: middle;"><span style="color: ${mainIssueInfo.eSearchWordA > 0 ? 'red' : 'inherit'};">${mainIssueInfo.eSearchWordA }</span> 건</th>
										<th style="vertical-align: middle;"><span style="color: ${mainIssueInfo.eSearchWordB > 0 ? 'red' : 'inherit'};">${mainIssueInfo.eSearchWordB }</span> 건</th>
										<th style="vertical-align: middle;"><span style="color: ${mainIssueInfo.eSearchWordC > 0 ? 'red' : 'inherit'};">${mainIssueInfo.eSearchWordC }</span> 건</th>
									</tr>
									<tr style="height: 5%">
										<th colspan="3" style="vertical-align: middle;"></th>
									</tr>
									 <tr style="height: 65%;">
										<th rowspan="4" colspan="3" style="vertical-align: top;">
										<table>
											<thead>
												<tr style="vertical-align: top;font-size: 14pt;color: #22499d;" >
													<th>No.</th>
													<th>자산유형 </th>
													<th>처리유형 </th>
													<th>상세구분</th>
													<th>요청일자</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="list" items="${mainIssueList}" varStatus="i">
													<tr style="height: 30px; border-bottom: 1px solid #ddd; ">
															<td>${i.count}</td>
															<td>${list.eAssetTypeName}</td>
															<td>${list.eIssueTypeName}</td>
															<td>${list.eProcessingTypeName}</td>
															<td>${list.eRequestDate}</td>
													</tr>
												</c:forEach>
												 <c:forEach var="i" begin="${fn:length(mainIssueList) + 1}" end="10">
												      <tr style="height: 30px;border-bottom: 1px solid #ddd; ">
												        <td>${i}</td>
												        <td>-</td>
												        <td>-</td>
												        <td>-</td>
												        <td>-</td>
												      </tr>
											    </c:forEach>
											</tbody>
										</table>
										</th>
									</tr>
								</table>
							</div>
						</li>
						<li > 
							<div>
								<table>
									<tr>
										<th colspan="3" style="vertical-align: middle;height: 7%;font-size: 16pt;color: #22499d;">대상장비  등록현황</th>
									</tr>
									<tr style="height: 90%;">
										<td>
											   <div class="tabs">
												    <input id="all" type="radio" name="tab_item" checked>
												    <label class="tab_item" for="all">자산유형별</label>
												    <input id="programming" type="radio" name="tab_item">
												    <label class="tab_item" for="programming" style="border-right: 3px solid #f8fafc;">제조사별</label>
												
												    <div class="tab_content" id="all_content" style="width:91%; height:300px;">
												        <div id="containerGraph1" onclick="moveDetail('/mes/asset/kw_asset_lf.do');" style="cursor:pointer;"></div>
<%-- 																<table <c:if test="${ass742 eq 'T' }">onclick="moveDetail('/mes/asset/kw_asset_lf.do');"  </c:if>   style="cursor:pointer;" > --%>
<!-- 																	<thead> -->
<!-- 																		<tr> -->
<!-- 																			<th colspan="1" style="width:50%; vertical-align: middle;height: 10%;font-size: 14pt;color: #22499d;text-align: center;"> -->
<!-- 																			자사유형명 -->
<!-- 																			</th> -->
<!-- 																			<th colspan="1" style="width:50%; vertical-align: middle;height: 10%;font-size: 14pt;color: #22499d;text-align: center;">  -->
<!-- 																				수량 -->
<!-- 																			</th> -->
<!-- 																		</tr> -->
<!-- 																	</thead> -->
<!-- 																	<tbody> -->
<%-- 																  	<c:forEach var="assetMakerList" items="${assetTypeList}" varStatus="j"> --%>
<%-- 																	  	  <c:if test="${j.index < 10}"> --%>
<!-- 																		  	<tr style="vertical-align: middle; font-size: 12pt; height: 28px; text-align: center;color: black; border-bottom: 1px solid #ddd; "> -->
<%-- 																			  	<td>${assetMakerList.aAssetType}</td> --%>
<%-- 																			  	<td>${assetMakerList.aAssetCost}</td> --%>
<!-- 																		  	</tr> -->
<%-- 																	  	  </c:if> --%>
<%-- 																	</c:forEach> --%>
<%-- 																    <c:forEach var="i" begin="${fn:length(assetTypeList) + 1}" end="10"> --%>
<!-- 																	      <tr style="vertical-align: middle; font-size: 12pt; height: 28px; text-align: center;color: black; border-bottom: 1px solid #ddd; "> -->
<!-- 																	        <td>-</td> -->
<!-- 																	        <td>-</td> -->
<!-- 																	      </tr> -->
<%-- 																    </c:forEach> --%>
<!-- 																	</tbody> -->
<!-- 																</table> -->
												    </div> 
												
												    <div class="tab_content" id="programming_content" style="width:91%; height:300px;">
												        <div id="containerGraph2" onclick="moveDetail('/mes/asset/kw_asset_lf.do');" style="cursor:pointer;"></div>
														
<%-- 																<table  <c:if test="${ass742 eq 'T' }">onclick="moveDetail('/mes/asset/kw_asset_lf.do');"  </c:if>   style="cursor:pointer;"  > --%>
<!-- 																	<thead> -->
<!-- 																		<tr > -->
<!-- 																			<th colspan="1" style="width:50%; vertical-align: middle;height: 10%;font-size: 14pt;color: #22499d;text-align: center;"> -->
<!-- 																			제조사명 -->
<!-- 																			</th> -->
<!-- 																			<th colspan="1" style="width:50%; vertical-align: middle;height: 10%;font-size: 14pt;color: #22499d;text-align: center;">  -->
<!-- 																				수량 -->
<!-- 																			</th> -->
<!-- 																		</tr> -->
<!-- 																	</thead> -->
<!-- 																	<tbody> -->
<%-- 																  	<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j"> --%>
<%-- 																	  	<c:if test="${j.index < 10}"> --%>
<!-- 																		  	<tr style="vertical-align: middle; font-size: 12pt; height: 28px; text-align: center;color: black; border-bottom: 1px solid #ddd; "> -->
<%-- 																			  	<td>${assetMakerList.aAssetMaker}</td> --%>
<%-- 																			  	<td>${assetMakerList.aAssetCost}</td> --%>
<!-- 																		  	</tr> -->
<%-- 																	  	</c:if> --%>
<%-- 																	</c:forEach> --%>
<%-- 																	 <c:forEach var="i" begin="${fn:length(assetMakerList) + 1}" end="10"> --%>
<!-- 																	      <tr style="vertical-align: middle; font-size: 12pt; height: 28px; text-align: center;color: black; border-bottom: 1px solid #ddd; "> -->
<!-- 																	        <td>-</td> -->
<!-- 																	        <td>-</td> -->
<!-- 																	      </tr> -->
<%-- 																    </c:forEach> --%>
<!-- 																	</tbody> -->
<!-- 																</table> -->
												    </div>
											 						    
												</div>
																							   
							            </td>
									</tr>
								</table>
							</div>
						</li>
						<li>
							<div>
								<table>
									<thead>
										<tr>
											<th colspan="3" style="vertical-align: middle;height: 10%;font-size: 18pt;color: #22499d;">
<%-- 											${displayDate} 통계 --%>
											</th>
										</tr>
									</thead>									
									
									<tbody>
										<tr ><td colspan="3" style="height: 5%;" >&nbsp; </td></tr>
										<tr>
											<td colspan="3" style="height: 85%;">
													<table>
														<tr > 
															<td colspan="1" style="width: 30%;height: 10%; padding-left: 15px;font-size: 14pt;cursor:pointer;" <c:if test="${ass766 eq 'T' }">onclick="moveDetail('/mes/issue/kw_issue_lf.do');" </c:if>  >장애  :</td>
															<td colspan="1" style="font-size: 14pt;"><span style="color: ${mainIssueTotal.eSearchWordA > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordA }</span> 건</td>
															<td colspan="1" style="width: 30%;height: 10%; padding-left: 15px;font-size: 14pt;cursor:pointer;" <c:if test="${ass746 eq 'T' }">onclick="moveDetail('/mes/blueprint/kw_blueprint_lf.do');"</c:if>   >변경  :</td>
															<td colspan="1" style="font-size: 14pt;"><span style="color: ${mainIssueTotal.eSearchWordB > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordB }</span> 건</td>
														</tr>
														<tr>
															<td colspan="4">&nbsp;</td>
														</tr>
														<tr > 
															<td colspan="1" style="width: 30%;height: 10%; padding-left: 15px;font-size: 14pt;cursor:pointer;" <c:if test="${ass763 eq 'T' }">onclick="moveDetail('/mes/blueprint/kw_issue_lf.do');" </c:if> >문제 : </td>
															<td colspan="1" style="font-size: 14pt;"><span style="color: ${mainIssueTotal.eSearchWordC > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordC }</span> 건</td>
															<td colspan="1" style="width: 30%;height: 12%; padding-left: 15px;font-size: 14pt;cursor:pointer;" <c:if test="${ass764 eq 'T' }">onclick="moveDetail('/mes/blueprint/kw_sr_lf.do');" </c:if> >SR &nbsp;&nbsp;: </td>
															<td colspan="1" style="font-size: 14pt;"><span style="color: ${mainIssueTotal.eSearchWordD > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordD }</span> 건</td>
														</tr>
														<tr>
															<td colspan="4">&nbsp;</td>
														</tr> 
														<tr <c:if test="${ass758 eq 'T' }"> onclick="moveDetail('/mes/inspection/kw_inspection_lf.do');"</c:if> style="cursor:pointer;">
															<td colspan="2" style="width: 50%;height: 10%; padding-left: 15px;font-size: 14pt;">정기점검[일/주/월] </td>
															<td colspan="2" style="width: 50%;font-size: 14pt;">
<%-- 															<span style="color: ${mainIssueTotal.eSearchWordE > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordE }</span> 건 --%>
															[&nbsp;&nbsp;<span style="color: ${mainIssueTotal.eSearchWordF > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordF }</span> 건  /&nbsp;&nbsp;<span style="color: ${mainIssueTotal.eSearchWordG > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordG }</span> 건  /&nbsp;&nbsp;<span style="color: ${mainIssueTotal.eSearchWordH > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordH }</span> 건&nbsp;&nbsp;]
															</td>
														</tr>
														<tr>
															<td colspan="4">&nbsp;</td>
														</tr>
<!-- 														<tr> -->
<%-- 															<td colspan="1" style="width: 40%;height: 10%; padding-left: 15px;font-size: 14pt;">[일간]  :&nbsp;&nbsp;${mainIssueTotal.eSearchWordF } 건</td> --%>
<%-- 															<td colspan="1" style="width: 30%;font-size: 14pt;">[주간]  :&nbsp;&nbsp;${mainIssueTotal.eSearchWordG } 건</td> --%>
<%-- 															<td colspan="1" style="width: 30%;font-size: 14pt;">[월간]  :&nbsp;&nbsp;${mainIssueTotal.eSearchWordH } 건</td> --%>
<!-- 														</tr> -->
														<tr >
															<td colspan="4" style="width: 100%;height: 12%; padding-left: 15px;font-size: 14pt;">자산 반출입현황  </td>
														</tr>	
														<tr>
															<td colspan="4">&nbsp;</td>
														</tr>
														<tr  <c:if test="${ass756 eq 'T' }"> onclick="moveDetail('/mes/asset/kw_eCondition_lf.do');"</c:if>  style="cursor:pointer;">
															<td colspan="2" style="width: 50%;height: 12%; padding-left: 15px;font-size: 13pt;text-align: center;">보유자산&nbsp;&nbsp;&nbsp;&nbsp;[출/입/미반입]</td>
															<td colspan="2" style="width: 50%;height: 12%; padding-left: 15px;font-size: 13pt;text-align: center;">
																[&nbsp;&nbsp;<span style="color: ${mainIssueTotal.eSearchWordI > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordI }</span>건 / &nbsp;&nbsp;<span style="color: ${mainIssueTotal.eSearchWordJ > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordJ }</span>건 /&nbsp;&nbsp; <span style="color: ${mainIssueTotal.eSearchWordK > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordK }</span>건&nbsp;&nbsp;] 
															</td>
														</tr>
														<tr>
															<td colspan="4">&nbsp;</td>
														</tr>
														<tr  <c:if test="${ass767 eq 'T' }"> onclick="moveDetail('/mes/equipment/kw_equipment_in_lf.do');"</c:if>  style="cursor:pointer;">
															<td colspan="2" style="width: 50%;height: 12%; padding-left: 15px;font-size: 13pt;text-align: center;">임시자산&nbsp;&nbsp;&nbsp;&nbsp;[입/출/미반출]</td>
															<td colspan="2" style="width: 50%;height: 12%; padding-left: 15px;font-size: 13pt;text-align: center;">
																[&nbsp;&nbsp;<span style="color: ${mainIssueTotal.eSearchWordL > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordL }</span>건 / &nbsp;&nbsp;<span style="color: ${mainIssueTotal.eSearchWordM  > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordM }</span>건 /&nbsp;&nbsp; <span style="color: ${mainIssueTotal.eSearchWordN > 0 ? 'red' : 'inherit'};">${mainIssueTotal.eSearchWordN }</span>건&nbsp;&nbsp;] 
															</td>
														</tr>
												</table>											
											</td>									
										</tr>
									</tbody>
								</table>
							</div>
						</li>
					</ul>
				</div>
				
				
				<div class="main_left" style="">
					<ul>
						<li>
							<div>
								<table>
									<thead>
										<tr style="height: 10%; ">
											<th colspan="3" style="vertical-align: middle;font-size: 16pt;color: #22499d;">EoS 현황</th>
										</tr>
										<tr style="height: 90%;vertical-align: top; cursor:pointer;"<c:if test="${ass755 eq 'T' }">  onclick="moveDetail('/mes/asset/kw_Hardware_lf.do');" </c:if> >
											 <td colspan="3">
											 	<table>
													<thead>
														<tr style="vertical-align: top;font-size: 14pt;color: #22499d;" >
															<th>No.</th>
															<th>대상</th>
															<th>유효기간</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="alist" items="${assetEosList}" varStatus="a">
															<tr style="vertical-align: middle; font-size: 12pt; height: 32px;border-bottom: 1px solid #ddd; ">
																<td colspan="1">${a.count }</td>
																<td colspan="1">${alist.eAssetModel }</td>
																<td colspan="1">${alist.eEosDate } : ${alist.searchTypeSet1 } </td>
															</tr>
														</c:forEach>
														 <c:forEach var="i" begin="${fn:length(assetEosList) + 1}" end="10">
														      <tr style="height: 32px;border-bottom: 1px solid #ddd; ">
														        <td>${i}</td>
														        <td>-</td>
														        <td>-</td>
														      </tr>
													    </c:forEach>
													</tbody>
												</table>
											 </td>
										</tr>
									</thead>
								</table>
							</div>
						</li>
						<li>
							<div>
								<table>
									<thead>
										<tr style="height: 10%">
											<th colspan="3" style="vertical-align: middle;font-size: 16pt;color: #22499d;">EoL 현황</th>
										</tr>
										<tr style="height: 90%;vertical-align: top; cursor:pointer;" <c:if test="${ass755 eq 'T' }"> onclick="moveDetail('/mes/asset/kw_Hardware_lf.do');" </c:if>>
											 <td colspan="3">
											 	<table>
													<thead>
														<tr style="vertical-align: top;font-size: 14pt;color: #22499d;" >
															<th>No.</th>
															<th>대상</th>
															<th>유효기간</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="blist" items="${assetEolList}" varStatus="b">
															<tr style="vertical-align: middle; font-size: 12pt; height: 32px;border-bottom: 1px solid #ddd; ">
																<td colspan="1">${b.count }</td>
																<td colspan="1">${blist.eAssetModel }</td>
																<td colspan="1">${blist.eEolDate } : ${blist.searchTypeSet2 } </td>
															</tr>
														</c:forEach>
														 <c:forEach var="i" begin="${fn:length(assetEolList) + 1}" end="10">
														      <tr style="height: 32px;border-bottom: 1px solid #ddd; ">
														        <td>${i}</td>
														        <td>-</td>
														        <td>-</td>
														      </tr>
													    </c:forEach>
													</tbody>
												</table>
											 </td>
										</tr>
									 </thead>
								</table>
							</div>
						</li>
						<li>
							<div>
								<table>
									<thead>
										<tr style="height: 10%">
											<th colspan="3" style="vertical-align: middle;font-size: 16pt;color: #22499d;">라이선스 현황</th>
										</tr>
										<tr style="height: 90%;vertical-align: top;cursor:pointer;"  <c:if test="${ass754 eq 'T' }">  onclick="moveDetail('/mes/asset/kw_Software_Register_lf.do');" </c:if>>
											 <td colspan="3">
											 	<table>
													<thead>
														<tr style="vertical-align: top;font-size: 14pt;color: #22499d;" >
															<th>No.</th>
															<th>대상</th>
															<th>유효기간</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="clist" items="${mainSoftwareList}" varStatus="c">
															<tr style="vertical-align: middle; font-size: 12pt; height: 32px;border-bottom: 1px solid #ddd; ">
																<td colspan="1">${c.count }</td>
																<td colspan="1">${clist.eProductName }</td>
																<td colspan="1">${clist.eEndDate } : ${clist.searchTypeSet1 } </td>
															</tr>
														</c:forEach>
														 <c:forEach var="i" begin="${fn:length(mainSoftwareList) + 1}" end="10">
														      <tr style="height: 32px;border-bottom: 1px solid #ddd; ">
														        <td>${i}</td>
														        <td>-</td>
														        <td>-</td>
														      </tr>
													    </c:forEach>
													</tbody>
												</table>
											 </td>
										</tr>
									 </thead>
								</table>
							</div>
						</li>
						 <li>
							<div>
								<table>
									<thead>
										<tr style="height: 10%">
											<th colspan="3" style="vertical-align: middle;font-size: 16pt;color: #22499d;">노후장비</th>
										</tr>
										<tr style="height: 90%;vertical-align: top;cursor:pointer;" <c:if test="${ass742 eq 'T' }"> onclick="moveDetail('/mes/asset/kw_asset_lf.do');" </c:if>>
											 <td colspan="3">
											 	<table>
													<thead>
														<tr style="vertical-align: top;font-size: 14pt;color: #22499d;" >
															<th>No.</th>
															<th>대상</th>
															<th>도입일자(사용년수)</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="dlist" items="${mainLifeStatusList}" varStatus="d">
															<tr style="vertical-align: middle; font-size: 12pt; height: 32px;border-bottom: 1px solid #ddd; ">
																<td colspan="1">${d.count }</td>
																<td colspan="1">${dlist.aAssetName }</td>
																<td colspan="1">${dlist.eAssetDate }(${dlist.eLifespan }) </td>
															</tr>
														</c:forEach>
														 <c:forEach var="i" begin="${fn:length(mainLifeStatusList) + 1}" end="10">
														      <tr style="height: 32px;border-bottom: 1px solid #ddd; ">
														        <td>${i}</td>
														        <td>-</td>
														        <td>-</td>
														      </tr>
													    </c:forEach>
													</tbody>
												</table>
											 </td>
										</tr>
									 </thead>
								</table>
							</div>
						</li>
					</ul>
				</div>
				
				
			</div>
		</div> 
	</form> 
 

	<c:forEach var="assetMakerList" items="${assetMakerList}" varStatus="j">
		<input type="hidden" id="aAssetMaker_${j.index}" name="aAssetMaker" value="${assetMakerList.aAssetMaker}">
		<input type="hidden" id="aAssetCost_${j.index}" name="aAssetCost" value="${assetMakerList.aAssetCost}">
	</c:forEach>

	<c:forEach var="assetTypeList" items="${assetTypeList}" varStatus="j">
		<input type="hidden" id="aAssetType_${j.index}" name="aAssetType" value="${assetTypeList.aAssetType}">
		<input type="hidden" id="aAssetTypeCost_${j.index}" name="aAssetTypeCost" value="${assetTypeList.aAssetCost}">
	</c:forEach>


<script>

const sAssetTypeCost = document.getElementsByName('aAssetTypeCost'); 
 const sAssetTypeCostValue = Array.from(sAssetTypeCost).map(sAssetTypeCost => parseInt(sAssetTypeCost.value)); 

 const sAssetType = document.getElementsByName('aAssetType'); 
 const sAssetTypeValue = Array.from(sAssetType).map(sAssetType => sAssetType.value); 

 const sAssetmcCount = document.getElementsByName('aAssetCost'); 
 const sAssetmcCountValue = Array.from(sAssetmcCount).map(sAssetmcCount => parseInt(sAssetmcCount.value)); 

 const sAssetMaker = document.getElementsByName('aAssetMaker'); 
 const sAssetMakerValue = Array.from(sAssetMaker).map(sAssetMaker => sAssetMaker.value); 

 const chart1 = Highcharts.chart('containerGraph2', { 
     chart: { 
         type: 'pie', width: 500,  height: 300  
     }, 
     title: { 
         text: '제조사별 통계' 
     }, 
     xAxis: { 
         categories: sAssetMakerValue, 
         crosshair: true 
     }, 
     yAxis: { 
         min: 0, 
         title: { 
             text: '-' 
         } 
     }, 
     tooltip: { 
         valueSuffix: '개' 
     }, 
     plotOptions: { 
     	 pie: { 
              allowPointSelect: true, 
              cursor: 'pointer', 
              dataLabels: { 
                  enabled: true, 
                  format: '<b>{point.name}</b>: {point.y}개' // 각 섹션의 데이터 라벨 포맷 설정 
              } 
     	 } 
     }, 
     series: [ 
         { 
         	name: '건', 
             data: sAssetMakerValue.map((name, index) => ({ name, y: sAssetmcCountValue[index] })), 
             visible: true 
         } 
     ] 
 }); 

 const chart2 = Highcharts.chart('containerGraph1', { 
     chart: { 
         type: 'pie', width: 500,  height: 300  
     }, 
     title: { 
         text: '자산유형별 통계' 
     }, 
     xAxis: { 
         categories: sAssetTypeValue, 
         crosshair: true 
     }, 
     yAxis: { 
         min: 0, 
         title: { 
             text: '-' 
         } 
     }, 
     tooltip: { 
         valueSuffix: '개' 
     }, 
     plotOptions: { 
     	 pie: { 
              allowPointSelect: true, 
              cursor: 'pointer', 
              dataLabels: { 
                  enabled: true, 
                  format: '<b>{point.name}</b>: {point.y}개' // 각 섹션의 데이터 라벨 포맷 설정 
              } 
     	 } 
     }, 
     series: [ 
         { 
         	name: '건', 
             data: sAssetTypeValue.map((name, index) => ({ name, y: sAssetTypeCostValue[index] })), 
             visible: true 
         } 
     ] 
 }); 
 </script> 



