<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>

<tiles:insertAttribute name="header" ignore="true"></tiles:insertAttribute>
	
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
		
		<tiles:insertAttribute name="sideBar" ignore="true"></tiles:insertAttribute>
		
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			
			<!-- Main Content -->
			<div id="content">
				<tiles:insertAttribute name="topBar" ignore="true"></tiles:insertAttribute>
				<tiles:insertAttribute name="body" ignore="true"></tiles:insertAttribute>
			</div>	
			<!-- End of Main Content -->
			
			<tiles:insertAttribute name="footer" ignore="true"></tiles:insertAttribute>
			
		</div>
		<!-- End of Content Wrapper -->
		
	</div>
	<!-- End of Page Wrapper -->
	
	<!-- Scroll to Top Button-->
	<tiles:insertAttribute name="topButton" ignore="true"></tiles:insertAttribute>

	<!-- Logout Modal-->
	<tiles:insertAttribute name="logout" ignore="true"></tiles:insertAttribute>
	
	<tiles:insertAttribute name="bottomjs" ignore="true"></tiles:insertAttribute>
		  
</body>

</html>
