<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>

<html>

<tiles:insertAttribute name="header" ignore="true"></tiles:insertAttribute>

<body class="bg-gradient-primary">
	<div class="container">
		<tiles:insertAttribute name="body" ignore="true"></tiles:insertAttribute>
	</div>
	
	<tiles:insertAttribute name="bottomjs" ignore="true"></tiles:insertAttribute>
</body>
</html>