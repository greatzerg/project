<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String basePath = request.getContextPath();
	request.setAttribute("BasePath", basePath);
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>添加记录</title>
	<script src="${BasePath}/resource/js/jquery.js"></script>
</head>
<style>
	.hidden{
		display:none !important;
	}
	.submitForm{
      	margin-bottom: 50px;
	    border: 15px solid #ccc;
	    padding: 20px;
    }
	.pic-list{
      	display: table;
	}
	.img-item {
	    width: 80px;
	    height: 100px;
	    overflow: hidden;
	    display: block;
	    float: left;
	    margin-right: 10px;
	    border: 1px #ccc solid;
	}
	.pic-link{
     	border-bottom: 1px solid #ccc;
      	width: 80px;
	    height: 80px;
	    overflow: hidden;
	    display: block;
	}
	.imgPre{
      	WIDTH: 100%;
	    HEIGHT: 100%;
	}
	
</style>
<body>
	<center>
		<div>
			<c:forEach begin="0" end="2"  var ="item">
			 	<form id="submitForm${item}" name="submitForm" class="submitForm" enctype="multipart/form-data" 
					onsubmit="return false" action="##" method="post">
					上传文件：
			 		<input type="file" name="file${item}" id="uploadPicFile${item}" style="display: table;"
						multiple accept="image/jpeg,image/gif,image/png,.JPEG" onchange="getFileUrl('submitForm', '${item}');"/>
					<div id="pic-list${item}" class="pic-list pic-list${item}"></div>
					<button class="submit-btn" onclick="submitFile('submitForm${item}','${item}');">提交点评</button>
			 	</form>
			</c:forEach>
 		</div>
	</center>
	<script>
	var filesMapArray = new Array();
	var delFileNosArray = new Array();
	var fileNoArray = new Array();
	
	<c:forEach begin="0" end="2"  var ="item">
		delFileNosArray['${item}'] = new Array();
		filesMapArray['${item}'] = new Array();
		fileNoArray['${item}'] = 0;
	</c:forEach>
    
	function submitFile(submitFormId, index){
		var form = document.getElementById(submitFormId);
		var formData = new FormData(form);
		console.log(index);
		console.log(delFileNosArray[index]);
		formData.append('proIndex', index);
		formData.append('delFileNos', delFileNosArray[index]);
		$.ajax({
		    url: '/ssh/test/resource/submitProductReview.html',
		    type: 'POST',
		    data: formData,
		    contentType: false,
		    processData: false,
		    success: function(data) {
		        if (data.success) {
		        	sessionStorage.delFileNos = JSON.stringify(new Array());
		        	$("#submitForm"+index).find(".pic-list" + index).css({"display": "none"});
		        	$("#submitForm"+index).find(".pic-list" + index).html("");
					console.log("上传成功");
		        } else {
		        	console.log("上传失败");
		        }
		    }
		});
	}
	
	function getFileUrl(sourceId, index) {
	    try {
	        var url;
	        var Browser_Agent = navigator.userAgent;
	        var fileform = document.forms[sourceId+index];
			delFileNosArray[index] = new Array();
			filesMapArray[index] = new Array();
			fileNoArray[index] = 0;
	        $("#submitForm"+index).find(".pic-list").html("");
	        $("#submitForm"+index).find(".pic-list").removeClass("hidden");
	        for (var i = 0; i < fileform["file" + index].files.length; i++) {
	            if (Browser_Agent.indexOf("MSIE") >= 1) { // IE 
	                url = document.getElementById(sourceId).value;
	            } else if (Browser_Agent.indexOf("Firefox") > 0) { // Firefox 
	                url = window.URL.createObjectURL(fileform["file" + index].files.item(i));
	            } else if (Browser_Agent.indexOf("Chrome") > 0) { // Chrome 
	                url = window.URL.createObjectURL(fileform["file" + index].files.item(i));
	            } else if (Browser_Agent.indexOf("Safari") > 0) {
	                url = window.URL.createObjectURL(fileform["file" + index].files.item(i));
	            } else if (Browser_Agent.indexOf("Android") > 0) {
	                url = window.URL.createObjectURL(fileform["file" + index].files.item(i));
	            }
	            $('#pic-list' + index).append("<div class='img-item img-item" + i + "' id='viewer2'><a href='javascript:void(0)' class='pic-link' ><img id='imgPre' class='imgPre' src='" + url + "' /></a><a href='javascript:void(0)' class='close-btn' onclick='cleanFile(" + index + "," + i + ")'>X</a></div>");
	            var picture = new Picture(fileNoArray[index], fileform["file" + index].files[i]);
	            filesMapArray[index][i] = picture;
	            fileNoArray[index] = fileNoArray[index] + 1;
	        }
	        console.log(filesMapArray);
	    } catch (e) {
	        alert("您上传的图片有误，请重新尝试...");
	    }
	}
	
	function Picture(id, file){
		this.id = id;
		this.file = file;
	}
	
	function cleanFile(index, pictureId) {
	    $("#pic-list"+index).find(".img-item" + pictureId).addClass("hidden");
	    delFileNosArray[index].push(pictureId);
	    console.log(delFileNosArray);
	}
	</script>
</body>
</html>