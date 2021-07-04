<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	var vm = new Vue({
		el: '#mediaBoardView',
		data: {
			board: {}, //글정보
			bdTitle: '', //글제목
			bdContent: '', //글내용
			bdCode: ${bdCode}, //글번호
			bcCode: ${bcCode}, //카테고리번호
			pbcCode: ${pbcCode},
			
			bcTitle: '${bcTitle}',
			brContent: '', //댓글내용
			brList: [], //댓글리스트
			brCode: 0, //댓글고유번호
			
			fileList: [],
			
			bcType: ${bcType}, //게시판타입_text: 1, image: 2, media: 3
			
			bcRating: ${bcRating}, //카테고리권한
			memInfo: {}, //유저정보
			
			groupNo: 0, //그룹번호
			groupOrd: 0, //그룹내순서
			groupLayer: 0, //계층
		},
		created: function(){
			EventBus.$on('memInfo', this.pushMemInfo);
			EventBus.$emit('selector', this.bcCode);
			EventBus.$emit('pselector', this.pbcCode);
		},
		methods: {
			pushMemInfo: function(memInfo){
				this.memInfo = memInfo;
			},
			
			//글상세조회
			boardInfo: function(){
				var vm = this;
				$.ajax({
					url: '/boardInfo',
					data: {
						"bdCode": vm.bdCode,
					},
					type: 'post',
					success: function(obj){
						vm.board = obj.boardView;
						vm.bdTitle = obj.boardView.bdTitle;
						vm.bdContent = obj.boardView.bdContent;
						
						vm.fileList = obj.selectFile;
						
					},
					error: function(){
						alert("에러");
					}
				});
			},
			
			//글삭제
			boardDelete: function() {
				var vm = this;
				if(confirm("삭제 하시겠습니까?")){
					$.ajax({
						url: '/boardDelete',
						data: {
							"bdCode": vm.bdCode,
							"bcCode": vm.bcCode,
							"bdType": 2,
							"bcType": vm.bcType,
						},
						type: 'post',
						success: function(){
							vm.goBoard();
						},
						error: function(){
							alert("에러");
						}
					});
				}
			},
			
			//댓글창 focus시
			focus: function(){
				var vm = this;
				if(vm.memInfo.miCode == 0){
					alert("로그인 후 작성할 수 있습니다.");
					$("#replyArea").blur();
					window.location.href = "/login1?returnUrl="
				}
			},
			
			//답글달기
			formShow: function(code){
				var vm = this;
				if(vm.memInfo.miCode == 0){
					alert("로그인 후 작성할 수 있습니다.");
					window.location.href = "/login1?returnUrl="
					return;
				}
				
				if(code == '#'){
					$('[id^="child"]').hide();
					$('#replyForm').show();
				} else {
					$('#child'+code).toggle();
					$('[id^="child"]').not('#child'+code).hide();
					
					if($('[id^="child"]').is(':visible') == true){
						$('#replyForm').hide();
					} else {
						$('#replyForm').show();
					}
				}
				
			},
			
			//댓글등록
			replyInsert: function(flag, list) {
				
				var vm = this;
				
				if(vm.memInfo.miCode == 0){
					alert("로그인 후 작성할 수 있습니다.");
					window.location.href = "/login1?returnUrl="
					return;
				}
				
				if(flag==1){
					vm.groupNo = list.groupNo;
					vm.groupOrd = list.groupOrd;
					vm.groupLayer = list.groupLayer;
				}
				
				var str = vm.brContent;
				str = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
				$.ajax({
					url: '/replyInsert',
					data: {
						"brContent": str,
						"bdCode": vm.bdCode,
						"brType": 1,
						"groupNo": vm.groupNo,
						"groupOrd": vm.groupOrd,
						"groupLayer": vm.groupLayer,
						"brFlag": flag,
					},
					type: 'post',
					success: function(sum) {
						vm.replySelect();
						vm.board.brSum = sum;
						vm.brContent = '';
						vm.groupNo = 0;
						vm.groupOrd = 0;
						vm.groupLayer = 0;
						
						vm.formShow('#');
					},
					error: function() {
						alert("에러");
					}
				});
			},
			
			//댓글조회
			replySelect: function() {
				var vm = this;
				$.ajax({
					url: '/replySelect',
					data: {
						"bdCode": vm.bdCode,
					},
					type: 'post',
					success: function(list) {
						vm.brList = list;
					},
					error: function() {
						alert("에러");
					}
				});
			},
			
			//댓글삭제
			replyDelete: function(code, flag, groupno) {
				var vm = this;
				if(confirm("삭제 하시겠습니까?")){
					vm.formShow('#');
					$.ajax({
						url: '/replyDelete',
						data: {
							"brCode": code,
							"brType": 2,
							"bdCode": vm.bdCode,
							
							"brFlag": flag,
							"groupNo": groupno,
						},
						type: 'post',
						success: function(sum) {
							vm.replySelect();
							vm.board.brSum = sum;
						},
						error: function() {
							alert("에러");
						}
					});
				}
			},
			
			goBoard: function(){
				var vm = this;
				window.location.href = "/mediaBoard?bcCode="+vm.bcCode+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating
										+"&&currentPage="+${currentPage}+"&&selected="+${selected}+"&&searchWrd="+'${searchWrd}';
			},
			
			goImgBoardUpdate: function(){
				var vm = this;
				window.location.href = "/goMediaBoardUpdate?bdCode="+vm.bdCode+"&&bcCode="+vm.bcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode
										+"&&currentPage="+${currentPage}+"&&selected="+${selected}+"&&searchWrd="+'${searchWrd}';
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
		mounted: function(){
			var vm = this;
			vm.boardInfo();
			vm.replySelect();
			
			window.addEventListener('load', () => {
				vm.checkRating();
				// run after everything is in-place
		    })
		},
		
		watch: {
			
		},
	});
</script>    