<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">

// 저장
function insert_go(){
	 if(chkIns()){
		if(confirm("저장하시겠습니까?")){
			document.getElementsByName("eItemPrice")[0].value = uncomma(document.getElementsByName("eItemPrice")[0].value);
			$("#mloader").show();
			document.frm.action = "/mes/item/item/kw_item_i.do";
			document.frm.submit();
		}
	}  
}

// validation
function chkIns(){
	if($("#eItemCateKey").val() == ""){
		alert("제품분류를 선택하세요.");
		$("#eItemCatePath").focus();
		return false;
	}
	if($("#eItemName").val() == ""){
		alert("모델명을 입력하세요.");
		$("#eItemName").focus();
		return false;
	}
	if($("#eItemStandard").val() == ""){
		alert("규격을 입력하세요.");
		$("#eItemStandard").focus();
		return false;
	}
	if($("#eItemUnit").val() == ""){
		alert("제품단위를 선택하세요.");
		$("#eItemUnit").focus();
		return false;
	}
	if($("#eItemMoneyUnit").val() == ""){
		alert("화폐단위를 선택하세요.");
		return false;
	}

	if($("#specialCode").val() == ""){
		alert("특수코드를 입력해주세요.");
		return false;
	} 	
	if($("#codeTxt").text() == ""){
		alert("코드생성을 눌러주세요.");
		return false;
	} 
	
	//코드번호
	$("#eItemCode").val($("#codeTxt").text());
	
	var lns = document.getElementsByName("eItemOutPriceProcessKey").length;
	if(lns > 0){
		for(var k =0; k<lns; k++){
			if(document.getElementsByName("eItemOutPriceProcessKey")[k].value=="" || document.getElementsByName("eItemOutProcessPrice")[k].value==""){
				alert ("공정을 선택하지 않았거나 가격을 입력하지 않았습니다.");
				return false;
			}
		}
	}
	return true;
}

// 목록
function cancel(){
	$("#mloader").show();
	document.frm.action = "/mes/item/item/kw_item_lf.do";
	document.frm.submit();
}

// 제품분류 팝업
function itemPopup(){
	var url = "/mes/item/popup/kw_item_lf.do";
	window.open(url ,"itemList","width=850,height=600,menubar=no,status=no,scrollbars=yes,location=no,resizable=yes");
}

// 제품분류 반환
function setItemPop(eItemCateKey, eItemCateName, eItemCatePath , middleCate, logoCode){
	
	//코드생성여부 체크
	codeReSet();
	
	$("#eItemCateKey").val(eItemCateKey);
	$("#eItemCateName").val(eItemCateName);
	$("#eItemCatePath").val(eItemCatePath);
	$("#logoCode").val(logoCode);
	$("#middleCate").val(middleCate);
	
}

function gubunSelect(){
	var target = document.getElementById("eItemUnit");
	if(target.options[target.selectedIndex].text == "선택"){
		$("#eItemUnitTxt").val("");
	}else{
		$("#eItemUnitTxt").val(target.options[target.selectedIndex].text);
	}
}

//중복체크
function codeCheck(){
	var target = document.getElementById("mainCate");
	var subTarget = document.getElementById("specialCode");
	var itemCate = "eItem";
	
	if($("#mainCate").val() == ""){
		alert("대분류을 확인해주세요.");
		return false;
	}
	if($("#middleCate").val() == ""){
		alert("품목분류명을 확인해주세요.");
		return false;
	}
	if($("#logoCode").val() == ""){
		alert("LOGO CODE를 등록해주세요.");
		return false;
	}
	if($("#specialCode").val() == ""){
		alert("특수코드를 등록해주세요.");
		return false;
	}
	
	var mainCate = $("#mainCate").val();
	var middleCate = $("#middleCate").val();
	var logoCode = $("#logoCode").val();
	var specialCode = $("#specialCode").val();
	
	$.ajax({
		url : "/mes/item/kw_codeSelectAjax.do"
	,	data :  {"mainCate": mainCate,"itemCate": itemCate, "middleCate":middleCate , "logoCode" : logoCode}
	,	dataType : "json"
	,	async : false
	,	cache : false
	,	success : function(data){
			var count = data.result.count;
			//$("#codeTxt").text(target.options[target.selectedIndex].value+"-"+$("#middleCate").val()+"-"+$("#logoCode").val()+"-"+count+"-");
			$("#codeTxt").text(mainCate+middleCate+logoCode+count+specialCode);
			$("#newCodeYN").val("Y");
		}
	});
}
// 행삭제
function delRow(obj){
	var tr = $(obj).parent().parent();
	tr.remove();

	chkSum();
}

// 선택박스 key값+name값 세팅
function setSelect(obj){
	var temp1 = $(obj).attr("name");
	var temp2 = $(obj).attr("name").split("_")[0];
	var ln = document.getElementsByName(temp2).length;

	if(temp1 != temp2 && ln > 0){
		var target = document.getElementsByName(temp2+"_All")[0];
		var gubunVal = target.options[target.selectedIndex].value;
		var gubunText = target.options[target.selectedIndex].innerText;

		for(var i = 0; i < ln; i++){
			document.getElementsByName(temp2)[i].value = gubunVal;
			if(document.getElementsByName(temp2)[i].previousElementSibling != null){
				document.getElementsByName(temp2)[i].previousElementSibling.value = gubunText;
			}
		}
	}else if(temp1 == temp2 && ln > 0){
		for(var i = 0; i < ln; i++){
			var target = document.getElementsByName(temp2)[i];
			var value = target.options[target.selectedIndex].value;
			var text = target.options[target.selectedIndex].innerText;

			document.getElementsByName(temp2)[i].value = value;
			if(document.getElementsByName(temp2)[i].previousElementSibling != null){
				document.getElementsByName(temp2)[i].previousElementSibling.value = text;
			}

				var k = 0;
				var cnt = 0;
				for (var j = 0; j < ln; j++) {
					if ($("select[name=eItemOutPriceProcessKey]").eq(i).val() == $("select[name=eItemOutPriceProcessKey]").eq(j).val()) {
						if($("select[name=eItemOutPriceProcessKey]").eq(i).val() != ""){
						k = j;
						cnt += 1;
						}
					}
				}
				if (cnt > 1) {
					alert("중복되는 공정이 있습니다.");
					document.getElementsByName("eItemOutPriceProcessKey")[k].value = "";
					return false;
				}

		}
	}
}

var rowIndex=0;
function fnc_addProcess(){
	var innerStr = "";
	// 구분(행삭제)
	innerStr += "	<tr>";
	innerStr += "		<th style='text-align: center'>";
	innerStr += "			<a class='del' onclick='delRow(this);'>X</a>";
	innerStr += "		</th>";
	// 공정선택
	innerStr += "		<td>";
	innerStr += "		<input type='hidden' id='eItemOutProcessName_"+rowIndex+"' name='eItemOutProcessName' value=''>";
	innerStr += "			<select id='eItemOutPriceProcessKey_"+rowIndex+"' name='eItemOutPriceProcessKey' onchange='setSelect(this)'>";
	innerStr += "			<option value='' >공정선택</option>";
	<c:forEach items="${gubunList7}" var="gubunList7">
	innerStr += "			<option value='${gubunList7.sGubunKey}' >${gubunList7.sGubunName}</option>";
	</c:forEach>
	innerStr += "			</select>";
	// 왼주단가
	innerStr += "			<input type='text' id='eItemOutProcessPrice_"+rowIndex+"' name='eItemOutProcessPrice' value='' style='width:10%;' maxlength='100' />";
	innerStr += "		</td>";

	innerStr += "</tr>";

	$(innerStr).appendTo("#lineRow1");

	rowIndex++;
}


function setComma(){
	document.getElementsByName("eItemPrice")[0].value = comma(document.getElementsByName("eItemPrice")[0].value);
}

function moneySelect(){
	var target = document.getElementById("eItemMoneyUnit");
	if(target.options[target.selectedIndex].text == "선택"){
		$("#eItemMoneyUnitTxt").val("");
	}else{
		$("#eItemMoneyUnitTxt").val(target.options[target.selectedIndex].text);
	}
}

function codeReSet(){
	var gbn = $("#newCodeYN").val();
	if(gbn != 'N'){
		alert("코드생성내역이 변경되었습니다. 코드생성을 다시 해주세요");
		$("#codeTxt").text("");
		return false;
	}
}
</script>

<form id="frm" name="frm" method="post" action="/mes/item/item/kw_item_i.do">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${mesItemVO.pageIndex}" />
	<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="${mesItemVO.recordCountPerPage}" />
	<input type="hidden" id="searchType" name="searchType" value="${mesItemVO.searchType}" />
	<input type="hidden" id="searchWord" name="searchWord" value="${mesItemVO.searchWord}" />
	
	<input type="hidden" id="logoCode" name="logoCode" value="" />
	<input type="hidden" id="eItemCode" name="eItemCode" value="" />
	<input type="hidden" id="middleCate" name="middleCate" value="" />
	<input type="hidden" id="newCodeYN" name="newCodeYN" value="N" />
	
	<div class="content">
		<div class="content_tit">
			<h2>제품 등록</h2>
		</div>
	</div>
		
	<div class="tbl_write_f">
		<table>
	  		<tbody>
	  			<tr>
		    		<th>*대분류</th>
		    		<td>
		    			<select id="mainCate" name="mainCate" onchange="codeReSet();">
		    				<option value="">선택</option>
		    				<option value="P">P:Plastic Magnet</option>
		    				<option value="N">N:Nd Magnet</option>
		    				<option value="R">R:Rubber Magnet</option>
		    				<option value="O">O:기타 아이템</option>
		    			</select>
		    		</td>
		  		</tr>
		  		<tr>
		    		<th>*제품분류</th>
					<td>
		    			<input type="hidden" id="eItemCateKey"  name="eItemCateKey" value="" />
		    			<input type="hidden" id="eItemCateName" name="eItemCateName" value="" />
		    			<input type="text"  class="inp_color" id="eItemCatePath" name="eItemCatePath" value="" readonly />
		    			<a class="mes_btn" onclick="itemPopup();">분류선택</a>
		    		</td>
		  		</tr>
		  		<tr>
		    		<th>*특수코드</th>
		    		<td>
		    			<select id="specialCode" name="specialCode" onchange="codeReSet();">
		    				<option value="">선택</option>
		    				<option value="A">A:사급</option>
		    				<option value="B">B:도급</option>
		    				<option value="C">C:해당없음</option>
		    			</select>
		    			<a class="mes_btn" onclick="codeCheck();">코드생성</a>
		    		</td>
		  		</tr>
		  		<TR>
		    		<th>*코드번호</th>
		    		<td>
		    			<span id="codeTxt"></span>
		    		</td>
		  		</tr>
		  		<tr>
		    		<th>*모델명</th>
		    		<td>
		    			<input type="text" id="eItemName" name="eItemName" value="" maxlength="50" />
		    		</td>
		  		</tr>
		  			  		
		  		<tr>
					<th>*규격</th>
					<td>
						<input type="text" id="eItemStandard" name="eItemStandard" value="" maxlength="50" />
					</td>
				</tr>
				<tr>
					<th>기본 단가</th>
					<td>
						<input type="text" style="text-align: right" id="eItemPrice" name="eItemPrice" value="" maxlength="20"  onkeypress='return isNumberKey(event);' onblur="setComma()"/>
						<input type="hidden" id="eItemMoneyUnitTxt" name="eItemMoneyUnitTxt" />
		    			<select id="eItemMoneyUnit" name="eItemMoneyUnit" onchange="moneySelect();">
		    				<option value="">선택</option>
		    				<c:forEach var="moneyList" items="${moneyList}" varStatus="i">
		    					<option value="${moneyList.sGubunKey}">${moneyList.sGubunName}</option>
		    				</c:forEach>
		    			</select>
					</td>
				</tr>
				<tr>
		    		<th>*제품단위</th>
					<td>
		    			<input type="hidden" id="eItemUnitTxt" name="eItemUnitTxt" />
		    			<select id="eItemUnit" name="eItemUnit" onchange="gubunSelect();">
		    				<option value="">선택</option>
		    				<c:forEach var="gubunList" items="${gubunList}" varStatus="i">
		    					<option value="${gubunList.sGubunKey}">${gubunList.sGubunName}</option>
		    				</c:forEach>
		    			</select>
		    		</td>
		  		</tr>
		  		<tr>
		    		<th>적정재고</th>
					<td>
		    			<input type="text" id="eItemInven" name="eItemInven" value="" maxlength="10" onkeypress="return isNumberKey(event);" onkeyup="return delHangle(event);" />
		    		</td>
		  		</tr>
		  		<tr>
		    		<th>비고</th>
					<td>
		    			<input type="text" id="eItemEtc" name="eItemEtc" value="" maxlength="100" />
		    		</td>
		  		</tr>
		  		<!-- 
				<tr>
					<th>외주 단가</th>
					<td>
						<a class="mes_btn" onclick="fnc_addProcess()">공정추가</a>
					</td>
				</tr>
				<tr>
		    		<th>업체명</th>
					<td>
		    			<input type="text" id="eItemCompanyName" name="eItemCompanyName" value="" maxlength="100" />
		    		</td>
		  		</tr>
		  		 -->
		  	</tbody>
			<tbody id="lineRow1">

			</tbody>
			<tbody>
				<tr>
		    		<th>포장사양서</th>
					<td>
		    			<textarea rows="15" style="width: 99%; resize: none;" id="eItemPacking" name="eItemPacking"></textarea>
		    		</td>
		  		</tr>
			</tbody>
		</table>
	</div>
	
	<div class="tbl_btn_right">
		<ul>
			<c:if test="${staffVo.kStaffAuthWriteFlag eq 'T'}">
				<li>
					<a onclick="insert_go();">저장</a> 
				</li>
			</c:if>
			<li>
				<a onclick="cancel();">목록</a>
			</li>
		</ul>
	</div>
	
</form>
