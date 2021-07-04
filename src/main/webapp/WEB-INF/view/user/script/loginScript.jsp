<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	var vm = new Vue({
		el: "#login",
		data: {
			miId: '',
			miPwd: '',
			loginError: '',
			returnUrl: '${returnUrl}',
			idError: '',
			pwdError: '',
		},
		
		methods: {
			//로그인
			login: function() {
				var vm = this;
				
				vm.idError = '';
				vm.pwdError = '';
				vm.loginError = '';
				
				if(vm.miId==''){
					vm.idError = '<span class="errorBox">아이디를 입력해주세요.</span>';
					return;
				} else if(vm.miPwd==''){
			    	vm.pwdError = '<span class="errorBox">비밀번호를 입력해주세요.</span>';
			    	return;
			    } 
				
				$.ajax({
					url: '/selectLogin',
					data: {
						"miId": vm.miId,
						"miPwd": vm.miPwd,
					},
					type: 'post',
					success: function(check) {
						if(check == 0){
							vm.loginError = '<span class="errorBox">가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.</span>';
						} else{
// 							window.location.href = '/';
							
							if(vm.returnUrl == ''){
								history.go(-1);
							} else {
								window.location.href = vm.returnUrl;
							}
							
						}
					},
					error: function() {
						alert("실패");
					}
				});
			},
			
		},
		filters: {
			
		},
		watch: {
			
		},
		mounted: function() {
			
		}
	});
	
	

</script>