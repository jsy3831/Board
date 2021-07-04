<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	var returnUrl = null;
	var vm = new Vue({
		el: '#imgBoard',
		data: {
			bcCode: ${bcCode},
			pbcCode: ${pbcCode},
			imgBoardList: [], //글리스트
			
			bcTitle: '${bcTitle}',
			bcRating: ${bcRating},
			memInfo: {}, //유저정보
			
			bcType: ${bcType}, //게시판타입_text: 1, image: 2, media: 3
			
			pagingInfo: {
				currentPage: ${currentPage},
				records: 0,
				perPage: 8,
			}, //페이징정보
			
			selected: ${selected}, // 검색조건
			options: [
				{text: '제목', value: 1},
				{text: '내용', value: 2},
				{text: '작성자', value: 3},
			], // 검색옵션
			searchWrd: '${searchWrd}', // 검색어
			
			selec: ${selected},
			seWrd: '${searchWrd}',
		},
		created: function() {
	    	EventBus.$on('memInfo', this.pushMemInfo);
		},		
		methods: {
			//이미지에러시
			imgError: function(event){
				event.target.src = 'img/noimage.jpg';	
			},
			
			pushMemInfo: function(memInfo){
				this.memInfo = memInfo;
			},			
			selectImgBoard: function(search) {
				var vm = this;
				if(search == 1){
					vm.pagingInfo.currentPage = 1;
					vm.selec = vm.selected;
					vm.seWrd = vm.searchWrd;
				}
				$.ajax({
					url: '/selectImgBoard',
					data: {
						"bcCode": vm.bcCode,
						"currentPage": vm.pagingInfo.currentPage,
						"perPage": vm.pagingInfo.perPage,
						"selected": vm.selec,
						"searchWrd": vm.seWrd,
					},
					success: function(list) {
						vm.imgBoardList = list.selectImgBoardList;
						
						vm.pagingInfo.records = list.bdSum;
						
						EventBus.$emit('selector', vm.bcCode);
						EventBus.$emit('pselector', vm.pbcCode);
						
					},
					error: function() {
						alert("실패");
					},
				});
			},
			
			//페이지이동
			goBoardInsert: function(){
				var vm = this;
				window.location.href = "/imgBoardInsert?bcCode="+vm.bcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode
										+"&&currentPage="+vm.pagingInfo.currentPage+"&&selected="+vm.selec+"&&searchWrd="+vm.seWrd;
			},
			
			updateView: function(code){
				var vm = this;
				$.ajax({
					url: '/updateView',
					data: {
						"bdCode": code,
					},
					type: 'post',
					success: function(){
						window.location.href = "/imgBoardView?bdCode="+code+"&&bcCode="+vm.bcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode
												+"&&currentPage="+vm.pagingInfo.currentPage+"&&selected="+vm.selec+"&&searchWrd="+vm.seWrd;
					},
					error: function(){
						alert("에러");
					}
				});
				
			},
			
			//권한체크
			checkRating: function(){
				var vm = this;
				if(vm.memInfo.mrCtg < vm.bcRating){
					alert("권한이 없습니다.");
					window.location.href = '/';
				}
			},
			
		},
		mounted: function() {
			var vm = this;
			
			setTimeout(function(){
				vm.pagingInfo.currentPage = ${currentPage};	
			}, 100); //페이지버튼이 올바르지않은 경우를 위함

// 			this.$nextTick(function () {
// 				vm.pagingInfo.currentPage = ${currentPage};
// 			    // 모든 화면이 렌더링된 후 실행합니다.
// 			})
			
			vm.selectImgBoard();
			
			this.$refs.page.$on('change', function(page){
				if (vm.pagingInfo.currentPage != page) {
					vm.pagingInfo.currentPage = page;
					vm.selectImgBoard();
				}
			});
			
			window.addEventListener('load', () => {
				vm.checkRating();
				// run after everything is in-place
		    })
		    
		},
		
		watch: {
			imgBoardList: function(){
				var vm = this;
				if(vm.imgBoardList.length == 0){
					vm.pagingInfo.currentPage = ${currentPage};
					
					if(vm.pagingInfo.currentPage > 1){
						vm.pagingInfo.currentPage -= 1;
						vm.selectImgBoard();
	 				}
				}// 글삭제시 해당페이지에 글이 없을때 처리
			},
		
			'pagingInfo.currentPage': function(val){
// 				console.log("페이지변경 = " + val);
				var currentUrl = null;
				
				if(returnUrl != null){
					currentUrl = returnUrl;
				} else {
					currentUrl = window.location.href; //현재url
				}
				
				var splitUrl1= currentUrl.split('currentPage='); //현재url 자르기
				
				var splitUrl2 = splitUrl1[1].split('&&');
				
				returnUrl= splitUrl1[0] + 'currentPage=' + val + '&&' + splitUrl2[1] + '&&' + splitUrl2[2]; //리턴할 최종url
				
// 				console.log("페이지변경url = " + returnUrl);
				
				EventBus.$emit('returnUrl', returnUrl);
			},
			
			seWrd: function(val){
// 				console.log("검색어변경 = " + val);
				var currentUrl = null;
				
				if(returnUrl != null){
					currentUrl = returnUrl;
				} else {
					currentUrl = window.location.href; //현재url
				}
				
				var splitUrl1 = currentUrl.split('searchWrd=');
				
				returnUrl = splitUrl1[0] + 'searchWrd=' + val;
				
// 				console.log("검색어변경url = " + returnUrl);
				
				EventBus.$emit('returnUrl', returnUrl);
			},
			
			selec: function(val){
// 				console.log("검색조건변경 = " + val);
				var currentUrl = null;
				
				if(returnUrl != null){
					currentUrl = returnUrl;
				} else {
					currentUrl = window.location.href; //현재url
				}
				
				var splitUrl1 = currentUrl.split('selected=');
				
				var splitUrl2 = splitUrl1[1].split('&&');
				
				returnUrl= splitUrl1[0] + 'selected=' + val + '&&' + splitUrl2[1]; //리턴할 최종url
				
// 				console.log("검색조건변경url = " + returnUrl);
				
				EventBus.$emit('returnUrl', returnUrl);
			},
			
		},
		
	});

</script>