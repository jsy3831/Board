<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	var vm = new Vue({
		el: "#topBar",
		data: {
			memInfo: {}, //유저정보
			returnUrl: '',
			returnUrl1: '',
			loginError: '',
			
			miPwd: '',
			miPwdcf: '',
			miEmail: '',
			
			pwdError: '',
			pwdcfError: '',
			emailError: '',
		},
		
		created: function() {
			EventBus.$on('memInfo', this.pushMemInfo);
			EventBus.$on('returnUrl', this.pushReturnUrl);
		},
		
		methods: {
			modalClose: function(){
				var vm = this;
				$('#pwdModal').on('hide.bs.modal', function () {
					vm.miPwd = '';
					vm.loginError = '';
				})
				
				$('#editModal').on('hide.bs.modal', function () {
					vm.miPwd = '';
					vm.miPwdcf = '';
					vm.pwdError = '';
					vm.pwdcfError = '';
					vm.emailError = '';
				})
			},
			
			//회원정보수정창 이동전 인증
			goEditMemInfo: function(){
				var vm = this;
				
				if(vm.miPwd==''){
					vm.loginError = '<span class="errorBox">비밀번호를 입력해주세요.</span>';
					return;
				}
				
				$.ajax({
					url: '/selectLogin',
					data: {
						"miId": vm.memInfo.miId,
						"miPwd": vm.miPwd,
					},
					type: 'post',
					success: function(check){
						if(check == 0){
							vm.loginError = '<span class="errorBox">잘못된 비밀번호입니다.</span>';
						} else{
							
							$("#editModal").modal('show');
							vm.miEmail = vm.memInfo.miEmail;
							
							$("#pwdModal").modal('hide');
						}
					},
					error: function(){
						alert("에러");	
					}
				});
			},
			
			//회원정보 수정
			editMemInfo: function(){
				var vm = this;
				
				vm.pwdcfBlur();
				
				if(vm.pwdError != '' || vm.pwdcfError != '' || vm.emailError != ''){
					return;
				} 
				
				if (confirm("회원정보를 수정하시겠습니까?")) {
					$.ajax({
						url: '/editMemInfo',
						data: {
							"miCode": vm.memInfo.miCode,
							"miPwd": vm.miPwd,
							"miEmail": vm.miEmail,
						},
						type: 'post',
						success: function(){
							if(vm.returnUrl == ''){
								history.go(0);
							} else {
								window.location.href = vm.returnUrl1;
							}
						},
						error: function(){
							alert("에러");
						}
					});
				}
			},
			
			pwdBlur: function(){
		    	var vm =this;
				const reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
				
				if(vm.miPwd != '') {
				    if(reg.test(vm.miPwd)!==true){
					    vm.pwdError = '<span class="errorBox">8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</span>';
				    }
				    else{
				    	vm.pwdError = '';
					}
				} else {
					vm.pwdError = '';
				}
			    
			},
			pwdcfBlur: function(){
		    	var vm =this;
		    	if(vm.miPwd != '') {
			    	if(vm.miPwdcf==''){
			    		vm.pwdcfError = '<span class="errorBox">필수정보입니다.</span>';
			    	}
			    	else if(vm.miPwd !== vm.miPwdcf){
					    vm.pwdcfError = '<span class="errorBox">비밀번호가 일치하지 않습니다.</span>';
				    }
				    else{
				    	vm.pwdcfError = '';
					}
		    	} else {
		    		vm.miPwdcf = '';
					vm.pwdcfError = '';
				}
			},
			emailBlur: function(){
		    	var vm =this;
				const reg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			    if(reg.test(vm.miEmail)!==true){
				    vm.emailError = '<span class="errorBox">이메일 주소를 다시 확인해주세요.</span>';
			    }
			    else{
			    	vm.emailError = '';
				}
			},
			
			pushMemInfo: function(memInfo){
				this.memInfo = memInfo;
			},
			
			pushReturnUrl: function(returnUrl){
				this.returnUrl = encodeURIComponent(returnUrl);
				this.returnUrl1 = returnUrl;
			},
			
			deleteRegister: function(code){
				var vm = this;
				if (confirm("계정을 탈퇴하시겠습니까?")) {
					$.ajax({
						url: '/deleteRegister',
						data: {
							"miCode": code,
						},
						type: 'post',
						success: function(){
							window.location.href = "/logout";
							alert("회원탈퇴");
						},
						error: function(){
							alert("에러");
						},
					});
				}
			},
		},
		
		mounted: function(){
			var vm = this;
			vm.modalClose();
		},
	});
	
</script>