<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="description" content="">
 	<meta name="author" content="">
  
	<title>noticeBoard Project</title>
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
	<!-- vue.js -->
	<script src="http://cdn.jsdelivr.net/npm/vue"></script>
	
	<!-- vue.js 개발자도구 사용 -->
	<script>Vue.config.devtools = true;</script>
	
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
	
	<!-- Custom styles for this page -->
	<link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	
	<!-- 내가작성한css -->
	<link href="css/board.css" rel="stylesheet">
	
	<script>
		var EventBus = new Vue();
	</script>
	
	<!-- 에디터 -->
	<script src="ckeditor/ckeditor.js"></script>
	
	<!-- 페이징 -->
	<script src="js/bootstrap-vue.js"></script>
</head>
