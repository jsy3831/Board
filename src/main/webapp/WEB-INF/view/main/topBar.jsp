<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow" id="topBar">

	<!-- Sidebar Toggle (Topbar) -->
	<button id="sidebarToggleTop"
		class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="fa fa-bars"></i>
	</button>

	<!-- Topbar Search -->
<!-- 	<form -->
<!-- 		class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"> -->
<!-- 		<div class="input-group"> -->
<!-- 			<input type="text" class="form-control bg-light border-0 small" -->
<!-- 				placeholder="Search for..." aria-label="Search" -->
<!-- 				aria-describedby="basic-addon2"> -->
<!-- 			<div class="input-group-append"> -->
<!-- 				<button class="btn btn-primary" type="button"> -->
<!-- 					<i class="fas fa-search fa-sm"></i> -->
<!-- 				</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</form> -->

	<!-- Topbar Navbar -->
	<ul class="navbar-nav ml-auto">

		<!-- Nav Item - Search Dropdown (Visible Only XS) -->
		<li class="nav-item dropdown no-arrow d-sm-none" v-if="memInfo.miCode != 0">
			<a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="mr-2 text-gray-600 small">{{memInfo.miName}}님 어서오세요.</span>
			</a> <!-- Dropdown - Messages -->
			<div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in" aria-labelledby="searchDropdown">
				<a class="dropdown-item" href="#" data-toggle="modal" data-target="#pwdModal"> 
					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
					회원정보
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
					로그아웃
				</a>
<!-- 				<form class="form-inline mr-auto w-100 navbar-search"> -->
<!-- 					<div class="input-group"> -->
<!-- 						<input type="text" class="form-control bg-light border-0 small" -->
<!-- 							placeholder="Search for..." aria-label="Search" -->
<!-- 							aria-describedby="basic-addon2"> -->
<!-- 						<div class="input-group-append"> -->
<!-- 							<button class="btn btn-primary" type="button"> -->
<!-- 								<i class="fas fa-search fa-sm"></i> -->
<!-- 							</button> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</form> -->
			</div>
		</li>

		<!-- Nav Item - User Information -->
		<li class="nav-item dropdown no-arrow" v-if="memInfo.miCode != 0">
			<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="mr-2 d-none d-lg-inline text-gray-600 small">{{memInfo.miName}}님 어서오세요.</span>
			</a>
			<!-- Dropdown - User Information -->
			<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
				
				<a class="dropdown-item" href="#" data-toggle="modal" data-target="#pwdModal"> 
					<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
					회원정보
				</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
					로그아웃
				</a>
				
			</div>
		</li>
		<div class="card-body" v-else>
			<a class="btn btn-primary" :href="'/login1?returnUrl=' + returnUrl">로그인</a>
			<a class="btn btn-primary" href="/register">회원가입</a>
		</div>
	</ul>

	<!-- 회원정보 수정전 비번확인 모달 -->
	<div class="modal fade" id="pwdModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">비밀번호를 입력하세요.</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
                		<input type="password" class="form-control form-control-user" placeholder="비밀번호" v-model="miPwd" v-on:keyup.enter="goEditMemInfo">
                	</div>
                    <span v-html="loginError"></span>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" @click="goEditMemInfo">확인</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 회원정보 수정 모달 -->
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">회원정보</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
                		<input type="text" class="form-control form-control-user" :value="memInfo.miName" readonly>
                	</div>
					<div class="form-group">
                		<input type="text" class="form-control form-control-user" :value="memInfo.miId" readonly>
                	</div>
					
                    <div class="form-group">
                		<input type="password" class="form-control form-control-user" placeholder="새 비밀번호" v-model="miPwd" v-on:blur="pwdBlur">
                	</div>
                	<div class="form-group">
	                	<span v-html="pwdError"></span>
	                </div>
	                <div class="form-group">
	                	<input type="password" class="form-control form-control-user" placeholder="비밀번호확인" v-model="miPwdcf" v-on:blur="pwdcfBlur">
	                </div>
	                <div class="form-group">
	                	<span v-html="pwdcfError"></span>
	                </div>
	                <div class="form-group">
	                  <input type="email" class="form-control form-control-user" placeholder="이메일 주소" v-model="miEmail" v-on:blur="emailBlur">
	                </div>
	                <span v-html="emailError"></span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" @click="deleteRegister(memInfo.miCode)">회원탈퇴</button>
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" @click="editMemInfo">수정</button>
				</div>
			</div>
		</div>
	</div>
	
</nav>
<!-- End of Topbar -->
<jsp:include page="/WEB-INF/view/main/script/topBarScript.jsp"></jsp:include>