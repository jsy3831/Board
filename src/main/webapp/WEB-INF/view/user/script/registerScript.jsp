<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	var vm = new Vue({
		el: "#register",
		data: {
			miId: '', //회원아이디
			miPwd: '', //회원패스워드
			miPwdcf: '', //패스워드확인
			miName: '', //회원이름
			miEmail: '', //회원이메일
			miCtg: 20, //회원가입승인
			mrCtg: 10, //회원등급
			
			nameError: '', //이름유효성
			idError: '', //아이디유효성
			pwdError: '', //패스워드유효성
			pwdcfError: '', //패스워드확인유효성
			emailError: '', //이메일유효성
			
			
		},
		
		methods: {
			
			//회원가입
			insertRegister: function(){
				var vm = this;
				if(vm.checkAll() == true){
					$.ajax({
						url: '/insertRegister',
						data: {
							"miId": vm.miId,
							"miPwd": vm.miPwd,
							"miName": vm.miName,
							"miEmail": vm.miEmail,
							"miCtg": vm.miCtg,
							"mrCtg": vm.mrCtg,
							
						},
						type: 'post',
						success: function(){
							alert("계정등록이 완료되었습니다.");
							window.location.href = '/login1?returnUrl=/';
						},
						error: function(){
//	 						window.location.href = '/page404';
						}
					});
				}
			},
			
			//유효성시작
			nameBlur: function(){
		    	var vm =this;
				const reg = /^[가-힣]{2,6}$/;
				if(vm.miName == ''){
					vm.nameError = '<span class="errorBox">필수정보입니다.</span>';
				}
				else if(reg.test(vm.miName)!==true){
					vm.nameError = '<span class="errorBox">올바른 이름이 아닙니다.</span>';
				}
			    else{
			    	vm.nameError = '';
			    	return true;
			    }
		    },
			idBlur: function(){
		    	var vm =this;
		    	var m = false;
		    	const reg = /^[A-Za-z0-9_\-]{5,20}$/;
		    	$.ajax({
		    		url: '/idCheck',
		    		data: {
		    			"miId": vm.miId,
		    		},
		    		type: 'post',
		    		async: false,
		    		success: function(one){
		    			if(one == 1){
		    				vm.idError = '<span class="errorBox">중복된 아이디입니다.</span>';
		    			}
		    			else{
		    				if(vm.miId == ''){
		    					vm.idError = '<span class="errorBox">필수정보입니다.</span>';
		    				}
		    				else if(reg.test(vm.miId)!==true){
		    					vm.idError = '<span class="errorBox">5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.</span>';
		    				}
		    				else{
		    					vm.idError = '<span class="successBox">사용 가능한 아이디입니다.</span>';
		    					m = true;
		    				}
		    			}
		    		},
		    		error: function(){
		    			alert("실패");
		    		}
		    	});
		    	if(m == true){
		    		return m;	
		    	}
		    	
			},
			pwdBlur: function(){
		    	var vm =this;
				const reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
			    if(vm.miPwd==''){
			    	vm.pwdError = '<span class="errorBox">필수정보입니다.</span>';
			    }
			    else if(reg.test(vm.miPwd)!==true){
				    vm.pwdError = '<span class="errorBox">8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.</span>';
			    }
			    else{
			    	vm.pwdError = '<span class="successBox">안전한 비밀번호입니다.</span>';
			    	return true;
				}
			},
			pwdcfBlur: function(){
		    	var vm =this;
		    	if(vm.miPwdcf==''){
		    		vm.pwdcfError = '<span class="errorBox">필수정보입니다.</span>';
		    	}
		    	else if(vm.miPwd !== vm.miPwdcf){
				    vm.pwdcfError = '<span class="errorBox">비밀번호가 일치하지 않습니다.</span>';
			    }
			    else{
			    	vm.pwdcfError = '<span class="successBox">비밀번호가 일치합니다.</span>';
			    	return true;
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
			    	return true;
				}
			},
			
			//전체유효성체크
			checkAll: function(){
				var vm = this;
				var flag = 1;
				if(vm.nameBlur()!==true){
					flag = 0;
				}
				if(vm.idBlur()!==true){
					flag = 0;
				}
				if(vm.pwdBlur()!==true){
					flag = 0;
				}
				if(vm.pwdcfBlur()!==true){
					flag = 0;
				}
				if(vm.emailBlur()!==true){
					flag = 0;
				}
				if(flag==1){
					return true;	
				}
				
			},
			//유효성끝
			
		},
		
		filters: {
			
		},
		watch: {
			
		},
		mounted: function() {
			
		},
	});
</script>