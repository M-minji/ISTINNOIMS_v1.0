<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<!-- <script src="/js/jquery/jquery-3.7.1.min.js"></script> -->
<!-- <script src="/js/jquery-ui-1.14.1/jquery-ui.min.js"></script> -->
<script type="text/javascript" src="<c:url value='/js/html2canvas.js'/>"></script>
<script src="/js/jquery/qrcode.min.js"></script>
<script src="/js/jquery/html2canvas.js"></script>
 <script src="/js/jquery/jquery-3.7.1.min.js"></script>
<!-- <script src="/js/jquery/jquery-3.6.0.min.js"></script> -->
<!-- <link rel="stylesheet" type="text/css" href="/css/mes/print.css" media="print" />  -->
<head>
<meta charset="UTF-8">
<script type="text/javascript">
$(document).ready(function(){	
	barcodeCr();
}); 	

function capture() {
	html2canvas($("#print_div2"), {
		onrendered: function(canvas) { 
			var img = canvas.toDataURL("image/jpg");
//				window.open(img); // 이미지를 윈도우 팝업으로..
			win = window.open();
			self.focus(); 
			win.document.open();
	  		win.document.write('<html><head><title></title>');
	  		win.document.write('</haed><body><table><tr><td>');
	  		win.document.write('<img src=' + img + '>');
	  		win.document.write('</td></tr></table></body></html>');
  			setTimeout(function(){top.window.opener = top;top.window.open('','_parent','');top.window.close();});
			win.document.close();
  			setTimeout(function(){
  			    win.print();
  			    win.close();
  			    }, 5);

		}
	}); 
}

function in_print(){
 
	 var initBody = document.body.innerHTML;
	    var printContent = document.getElementById("print_div2").innerHTML;

	    // 프린트 이벤트 발생 전에 클래스 추가하여 스타일을 변경
	    document.body.classList.add('printing-mode');

	    window.onbeforeprint = function() {
	        // 프린트 미리보기 시 컨텐츠를 변경
	        document.body.innerHTML = printContent;
	    };

	    window.onafterprint = function() {
	        // 프린트 후에 초기화
	        document.body.innerHTML = initBody;
	        document.body.classList.remove('printing-mode'); // 프린트 모드 클래스 제거
	    };

	    window.print();
}

function barcodeCr(){
// 	var ln = ${fn:length(barlist)};
	var ln = 1;
	
// 	for(var i=0; i<ln; i++){
// 		var eBarcode = $('#eBarCode_'+i).val();
		var eBarcode = $('#eBarCode_1').val();
// 		$("#bcTarget_"+i).barcode(eBarcode, "qrcode", {barWidth:1, barHeight:50});
// 		$("#bcTarget_1").barcode(eBarcode, "qrcode");
// 	}
		var assetInfo = {
	            eHostName: "exampleHost",
	            eAssetModel: "exampleModel",
	            eAssetSNumber: "12345",
	            ePositionName1: "examplePosition",
	            eAssetDate: "2024-06-14"
	        };

// 	        var qrContent = 
// 	            "하나:" + assetInfo.eHostName + 
// 	            " 123:" + assetInfo.eAssetModel + 
// 	            " 123:" + assetInfo.eAssetSNumber + 
// 	            " 123:" + assetInfo.ePositionName1 + " - " + assetInfo.eAssetDate;
	        var cmToPixel = 1.8 * 96 / 2.54; 
		  var qrcode = new QRCode(document.getElementById("bcTarget_1"), {
              text: eBarcode,
              width: cmToPixel,
              height: cmToPixel,
              colorDark : "#000000",
              colorLight : "#ffffff",
              correctLevel : 3,  
              version: 10  
          });
		  
// 		  html2canvas(document.getElementById("target")).then(canvas => {
//               var imgData = canvas.toDataURL("image/png");
              
//               // Generate QR code with the image data
//               var qrcode = new QRCode(document.getElementById("qrcode"), {
//                   text: imgData,
//                   width: 256,
//                   height: 256,
//                   colorDark : "#000000",
//                   colorLight : "#ffffff",
//                   correctLevel : QRCode.CorrectLevel.H
//               });
//           });

}
</script>

 <style>
 	.container {
            padding : 1em;
		    
        }
 </style>

<title>Barcode</title>
   
<form id="frm" name="frm" method="post" >
			<div class="pop_head">
				<div id="pop_head">
					<div class="tit">
						<h3>QR코드 출력</h3>
					</div>
					<a href="javascript:self.close();"><img src="/images/btn/close.gif" width="22" height="21" /></a>
				</div>  
			</div>
			
			<div id="print_div2" class="container"><%-- value="http://${eIPaddress}:8080/asset/qr_asset_info.do?eAssetKey=${assetInfo.eAssetKey}" --%>
				<input type="hidden" name="eBarCode" id="eBarCode_1" value="${eIPaddress}" />
				 
			 	<table  style="/* border: 1px solid #000; */display:inline-block; width:100%; padding:0.1em; width: 17cm; height: 2cm;" >
			 		<tr style="">			 		
			 			<td style="width: 2cm; vertical-align: top; ">
			 				<div id="bcTarget_1"></div>
			 			</td>
			 			<td style="width: 15cm;font-size:10pt;text-align:center;">
			 				<table style="width: 100%; ">
			 					<tr style="border: 1px solid #ccc; height: 2.5em;">
			 						<td style="width: 2cm; border-right: 1px solid #ddd;border-left: 1px solid #ddd;">호스트명</td>
			 						<td style="width: 4cm; text-align:left;border-right: 1px solid #ddd;border-left: 1px solid #ddd;">${assetInfo.eHostName}</td>
			 						<td style="width: 2cm; border-right: 1px solid #ddd;border-left: 1px solid #ddd;">모델명</td>
			 						<td style="width: *; text-align:left;border-right: 1px solid #ddd;border-left: 1px solid #ddd;">${assetInfo.eAssetModel}</td>
			 					</tr>
			 					<tr style="border: 1px solid #ccc; height: 2.5em;">
			 						<td style=" border-right: 1px solid #ddd;border-left: 1px solid #ddd;">제조번호</td>
			 						<td style=" text-align:left;border-right: 1px solid #ddd;border-left: 1px solid #ddd;">${assetInfo.eAssetSNumber}</td>
			 						<td style=" border-right: 1px solid #ddd;border-left: 1px solid #ddd;">설치장소</td>
			 						<td style=" text-align:left;border-right: 1px solid #ddd;border-left: 1px solid #ddd;">${assetInfo.ePositionName1} - ${assetInfo.eAssetDate}</td>
			 					</tr>
			 				</table>
			 			</td>
			 		</tr>
			 	</table>
				 	
				       
			</div>
			<div class="tbl_btn_right">
				<ul>
					<li>
<!-- 						<a class="mes_btn" style="cursor: pointer;"   onclick="capture()">출력</a> -->
						<a onclick="in_print()">출력</a>
	          		</li>
	          	</ul>
			</div>
	</form>
</head>
