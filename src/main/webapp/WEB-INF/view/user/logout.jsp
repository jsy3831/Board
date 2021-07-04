<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!-- 로그아웃 모달 -->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">로그아웃 시 현재 페이지를 벗어날 수도 있습니다.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" @click="logoutTest">로그아웃</button>
				</div>
			</div>
		</div>
	</div>
	
<script>
	var vm = new Vue({
		el: "#logoutModal",
		data: {
			returnUrl: '',
			bdCode: 0,
			
		},
		created: function() {
			EventBus.$on('returnUrl', this.pushReturnUrl);
			EventBus.$on('bdCode', this.pushBdCode);
		},
		methods: {
			
			pushReturnUrl: function(returnUrl){
				this.returnUrl = returnUrl;
			},
			
			pushBdCode: function(bdCode){
				this.bdCode = bdCode;
			},
			
			logoutTest: function(){
				var vm = this;
				$.ajax({
					url: '/logoutTest',
					data: {
						
					},
					type: 'post',
					success: function(){
						if(vm.returnUrl == ''){
							
							if(vm.bdCode != 0){
								EventBus.$emit('bdCodeRe', vm.bdCode);	
							} else{
								history.go(0);	
							}
							
						} else {
							window.location.href = vm.returnUrl;
						}
					},
					error: function(){
						alert("로그아웃 에러");
					}
				});
			},
		},
	});
</script>	