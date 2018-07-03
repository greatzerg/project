<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SpringMVC国际化</title>
</head>
<body>
	 选择语言：<a href="${pageContext.request.contextPath}/test/messageProperties.html?langType=zh">中文</a> | <a href="${pageContext.request.contextPath}/test/messageProperties.html?langType=en">英文</a>
	<br></br>
	<spring:message code="money" />
	
	<form action="/test/messageProperties.html" method="POST">
			选择语言：
		<a href="${pageContext.request.contextPath}/test/messageProperties.html?langType=zh">中文</a> | 
		<a href="${pageContext.request.contextPath}/test/messageProperties.html?langType=en">英文</a>
		<input type="hidden" value="">
	</form>
</body>
</html>