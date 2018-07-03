<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Spring 4 MVC - HelloWorld Index Page</title>
<%
	String basePath = request.getContextPath();
	request.setAttribute("BasePath", basePath);
%>
<script src="${BasePath}/resource/js/jquery.js"></script>
</head>
<body>
	helloWord!~${BasePath}
</body>
</html>