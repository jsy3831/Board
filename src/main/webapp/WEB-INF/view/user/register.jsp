<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <div class="card o-hidden border-0 shadow-lg my-5" id="register">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
              	<a href="/" style="text-decoration:none">
                	<h1 class="h4 text-gray-900 mb-4">Board</h1>
                </a>
              </div>
              <form class="user">
                <div class="form-group">
                    <input type="text" class="form-control form-control-user" placeholder="이름" v-model="miName" v-on:blur="nameBlur">
                </div>
                
                <div class="form-group">
                	<span v-html="nameError"></span>
                </div>
                
                <div class="form-group">
                    <input type="text" class="form-control form-control-user" placeholder="아이디" v-model="miId" v-on:blur="idBlur" />
                </div>
                <div class="form-group">
                	<span v-html="idError"></span>
                </div>
                
                <div class="form-group">
                	<input type="password" class="form-control form-control-user" placeholder="비밀번호" v-model="miPwd" v-on:blur="pwdBlur">
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
                <div class="form-group">
                	<span v-html="emailError"></span>
                </div>
                
                <button type="button" class="btn btn-primary btn-user btn-block" v-on:mousedown="insertRegister()">
                  	계정등록
                </button>
                </form>
                <hr>
<!--                 <a href="index.html" class="btn btn-google btn-user btn-block"> -->
<!--                   <i class="fab fa-google fa-fw"></i> Register with Google -->
<!--                 </a> -->
<!--                 <a href="index.html" class="btn btn-facebook btn-user btn-block"> -->
<!--                   <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook -->
<!--                 </a> -->
<!--               </form> -->
<!--               <hr> -->
<!--               <div class="text-center"> -->
<!--                 <a class="small" href="forgot-password.html">Forgot Password?</a> -->
<!--               </div> -->
              <div class="text-center">
                <a class="small" href="/login1?returnUrl=/">계정이 이미 있으신가요? 로그인하세요!</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>    

    <jsp:include page="/WEB-INF/view/user/script/registerScript.jsp"></jsp:include>