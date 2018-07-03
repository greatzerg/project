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
	<script src="${BasePath}/resource/js/test/test.js" type="text/javascript"></script>
</head>
<style>
	.hidden{
		display:none;
	}
</style>
<body>
	<center>
		<div>
		 	<form id="submitForm" name="submitForm" enctype="multipart/form-data" 
				onsubmit="return false" action="##" method="post">
				上传文件：
		 		<input type="file" name="file" id="uploadPicFile" style="display: table;"
					multiple accept="image/jpeg,image/gif,image/png,.JPEG" onchange="getFileUrl('submitForm');"/>
				<div class="pic-list"></div>
				<button class="submit-btn" onclick="submitFile();">提交点评</button>
		 	</form>
		 </div>
	 </center>
	<script>
	var filesMap = new Array();
	var delFileNos = new Array();
	sessionStorage.fileNo = JSON.stringify(0);
	sessionStorage.delFileNos = JSON.stringify(new Array());
    
	function submitFile(){
		var form = document.getElementById('submitForm');
		var formData = new FormData(form);
		formData.append('delFileNos', delFileNos);
		$.ajax({
		    url: '/ssh/test/resource/submit.html',
		    type: 'POST',
		    data: formData,
		    contentType: false,
		    processData: false,
		    success: function(data) {
		        if (data.success) {
		        	sessionStorage.delFileNos = JSON.stringify(new Array());
		        	$("#submitForm").find(".pic-list").html("");
					console.log("上传成功");
		        } else {
		        	console.log("上传失败");
		        }
		    }
		});
	}
	
	function getFileUrl(sourceId) {
	    try {
	        var url;
	        delFileNos = new Array();
	        sessionStorage.fileNo = JSON.stringify(0);
	        var Browser_Agent = navigator.userAgent;
	        var fileform = document.forms[sourceId];
	        $("#submitForm").find(".pic-list").html("");
	        $("#submitForm").find(".pic-list").removeClass("hidden");
	        for (var i = 0; i < fileform["file"].files.length; i++) {
	            if (Browser_Agent.indexOf("MSIE") >= 1) { // IE 
	                url = document.getElementById(sourceId).value;
	            } else if (Browser_Agent.indexOf("Firefox") > 0) { // Firefox 
	                url = window.URL.createObjectURL(fileform["file"].files.item(i));
	            } else if (Browser_Agent.indexOf("Chrome") > 0) { // Chrome 
	                url = window.URL.createObjectURL(fileform["file"].files.item(i));
	            } else if (Browser_Agent.indexOf("Safari") > 0) {
	                url = window.URL.createObjectURL(fileform["file"].files.item(i));
	            } else if (Browser_Agent.indexOf("Android") > 0) {
	                url = window.URL.createObjectURL(fileform["file"].files.item(i));
	            }
	            $(".pic-list").append("<div class='img-item img-item" + JSON.parse(sessionStorage.fileNo) + "' id='viewer2'><a href='javascript:void(0)' class='pic-link' style='width:122px;height:122px;overflow:hidden;display:block;'><img id='imgPre' class='imgPre' src='" + url + "' style='width:122px;height:122px;'/></a><a href='javascript:void(0)' class='close-btn' onclick='cleanFile(&apos;" + JSON.parse(sessionStorage.fileNo) + "&apos;);'>X</a></div>");
	            var picture = new Picture(JSON.parse(sessionStorage.fileNo), fileform["file"].files[i]);
	            filesMap[i] = picture;
	            sessionStorage.fileNo = JSON.stringify(JSON.parse(sessionStorage.fileNo) + 1);
	        }
	    } catch (e) {
	        alert("您上传的图片有误，请重新尝试...");
	    }
	}
	
	function Picture(id, file){
		this.id = id;
		this.file = file;
	}
	
	function cleanFile(pictureId) {
	    $(".img-item" + pictureId).addClass("hidden");
	    var filesMap2 = new Array();
	    delFileNos = JSON.parse(sessionStorage.delFileNos);
	    filesMap = filesMap2;
	    delFileNos.push(pictureId);
	    sessionStorage.delFileNos = JSON.stringify(delFileNos);
	}
	</script>
</body>
</html>