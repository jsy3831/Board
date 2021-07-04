<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	var vm = new Vue({
		el: "#userManage",
		data:{
			userList: [],
			ratingList: [],
			
			selected: 1, // 검색조건
			options: [
				{text: '아이디', value: 1},
				{text: '이름', value: 2},
			], // 검색옵션
			searchWrd: '', // 검색어
			
			selec: 1,
			seWrd: '',
			
			pagingInfo: {
				currentPage: 1,
				records: 0,
				perPage: 10,
			}, //페이징정보
			manageRat: 90,
			memInfo: {},
		},
		created: function() {
	    	EventBus.$on('memInfo', this.pushMemInfo);
		},
		
		methods:{
			pushMemInfo: function(memInfo){
				this.memInfo = memInfo;
			},			
			countUser: function(){
				var vm = this;
				$.ajax({
					url: '/countUser',
					data: {
						"selected": vm.selected,
						"searchWrd": vm.searchWrd,
					},
					type: 'post',
					success: function(result){
						vm.pagingInfo.records = result;
						vm.selectUser(1);
					},
					error: function(){
						alert("갯수실패");
					},
				});
			},
			
			selectUser: function(search){
				var vm = this;
				
				if(search == 1){
					vm.pagingInfo.currentPage = 1;
					vm.selec = vm.selected;
					vm.seWrd = vm.searchWrd;
				}
				
				$.ajax({
					url: '/selectInfo',
					data:{
						"currentPage": vm.pagingInfo.currentPage,
						"perPage": vm.pagingInfo.perPage,
						"selected": vm.selec,
						"searchWrd": vm.seWrd,
					},
					type: 'post',
					success: function(list){
						vm.userList=list.selectUser;
						vm.ratingList=list.selectRating;
						
						EventBus.$emit('selector', 15000);
						EventBus.$emit('pselector', 20000);
					},
					error: function(){
						alert("에러");
					}
				});
			},
			
			updateRating: function(list){
				var vm = this;
				$.ajax({
					url: '/updateRating',
					data:{
						"mrCtg": list.mrCtg,
						"miCode": list.miCode,
					},
					type: 'post',
					success: function(){
						alert("변경 완료");
						vm.selectUser();
					},
					error: function(){
						alert("에러");
					},
				});
			},
			
			checkRating: function(){
				var vm = this;
				if(vm.memInfo.mrCtg < vm.manageRat){
					alert("권한이 없습니다.");
					window.location.href = '/';
				}
			},
			
		},
		mounted: function(){
			var vm = this;
			vm.countUser();
			
			this.$refs.page.$on('change', function(page){
				if (vm.pagingInfo.currentPage != page) {
					vm.pagingInfo.currentPage = page;
					vm.selectUser();
				}
			});
			
			window.addEventListener('load', () => {
				vm.checkRating();
				// run after everything is in-place
		    })
		},
	});
</script>