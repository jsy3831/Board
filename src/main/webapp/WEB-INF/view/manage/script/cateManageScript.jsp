<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
var vm = new Vue({
	el: "#cateManage",
	data: {
		parent: [],
		child: [],
		
		info: {},
		list: [],
		
		bcCode: 0,
		bcRoot: '',
		bcTitle: '', //카테고리명
		updateTitle: '',
		childTitle: '',
		
		bcType: 1, //게시판타입_text: 1, image: 2, media: 3
		bcRating: 0, //게시판권한_모두에게: 0, 일반: 10, 관리자: 90
		
		manageRat: 90,
		memInfo: {},
// 		bcTitle1: '', //메인카테고리명(등록)
// 		bcTitle2: '', //하위카테고리명
// 		bcTitle3: '', //메인카테고리명(조회)
		
		
// 		updateTitle1: '', //메인카테고리명(수정)
// 		updateTitle2: '', //하위카테고리명(수정)
// 		updateTitle3: '', //카테고리명(수정)
	},
	
	created: function(){
		EventBus.$on('test', this.onReceive);
		EventBus.$on('memInfo', this.pushMemInfo);
		
	},
	
	methods: {
		
		pushMemInfo: function(memInfo){
			this.memInfo = memInfo;
		},
		
		onReceive: function(test){
			EventBus.$emit('selector', 10000);
			EventBus.$emit('pselector', 20000);
			
			this.list = test;	
			
		},
		
		selectParent: function(){
			var vm = this;
			$.ajax({
				url: '/selectParent',
				data:{
					
				},
				type: 'post',
				success: function(list){
					vm.list = list;
					for(var p=0; p<vm.list.length; p++){
						
						for(var c=0; c<vm.list.length; c++){
							if(vm.list[p].bcCode == vm.list[c].bcRoot){
								vm.child.push(vm.list[c]);
								
							}
						}
						
						vm.list[p].child = vm.child;
						vm.child = [];
// 						console.log(vm.cateList[p]);
					}
					
// 					$.each(list, function(i,e){
// 						vm.info = {
// 								id: e.bcCode,
// 								parent: e.bcRoot,
// 								text: e.bcTitle
// 						};
// 						vm.list.push(vm.info)
// 					})
					
// 					console.log(vm.list);
					
// 					$('#tree').jstree("destroy");
// 					$('#tree').jstree({
// 						'plugins' : [ "wholerow" ],
// 						'core' : {
// 							'data' : vm.list,
// 							'themes' : {
// 								'name' : 'proton',
// 								'responsive' : true
// 							}
// 						}
// 					});
					
// 					$('#tree').on("hover_node.jstree", function(e, data) {
// 						$('#tree').append("<div>123</div>")
// 					});
					
// 					vm.info={};
// 					vm.list=[];
				},
				error: function(){
					alert("에러");
				}
			});
		},
		
		selectChild: function(code){
			var vm = this;
			vm.bcCode = code;
			$.ajax({
				url: '/selectChild',
				data:{
					"bcCode": vm.bcCode,
				},
				type: 'post',
				success: function(list){
// 					vm.test ='<div v-bind:id="code"></div>'
// 					vm.$nextTick(function(){
// 						$("#pd" + code).after($("#cd2"));
						vm.child = list;	
// 					})
				},
				error: function(){
					alert("에러");
				}
			});
		},
		
		insertCate: function(seq){
			var vm = this;
			if(seq!=0){
				vm.bcRoot=seq;
				vm.bcTitle = vm.childTitle;
				vm.childTitle='';
			}
			else{
				vm.bcRoot = "#";
				vm.bcType = 0;
			}
			$.ajax({
				url: '/insertCate',
				data:{
					"bcTitle": vm.bcTitle,
					"bcRoot": vm.bcRoot,
					"bcType": vm.bcType,
					"bcRating": vm.bcRating,
				},
				type: 'post',
				success: function(){
					alert("카테고리 등록");
					vm.cateTitle='';
// 					vm.selectParent();
					
					if(seq!=0){
						vm.formShow(2,vm.bcRoot);	
					}
					else{
						vm.formShow(1);
					}
					
					EventBus.$emit('message');
				},
				error: function(){
					alert("등록에러");
				}
			});
		},
		
		updateCate: function(seq,type,rat){
			var vm = this;
			if(confirm("수정 하시겠습니까?")){
				$.ajax({
					url: '/updateCate',
					data: {
						"bcTitle": vm.updateTitle,
						"bcCode": seq,
						"bcRating": rat
					},
					type: 'post',
					success: function(){
						
						if(type==1){
							vm.cancelShow(seq,1);
						}
						else{
							vm.cancelShow(seq,2);
						}
						EventBus.$emit('message');
					},
					error: function(){
						alert("에러");
					}
				});
			}
		},
		
		deleteCate: function(seq, sum){
			var vm = this;
			if(sum != 0){
				alert("게시글이 있는 카테고리는 삭제 불가합니다.")
				return;
			}
			if(confirm("해당 카테고리를 정말 삭제하시겠습니까?")){
				$.ajax({
					url: '/deleteCate',
					data:{
						"bcCode": seq,
					},
					type: 'post',
					success: function(){
						alert("카테고리 삭제 완료");
						EventBus.$emit('message');
					},
					error: function(){
						alert("에러");
					}
				});	
			}
			
		},
		
		//toggle이벤트 시작
		formShow : function(num,seq){			
			if(num==1){
// 				$("#aa").toggle();
// 		        $("#aaa").toggle();
		        $("#pcf").toggle();
		        $("#pC").toggle();
		        this.bcTitle='';
		        this.bcType= 1;
		        this.bcRating= 0;
			}
			else if(num==2){
// 				$("#bb").toggle();
// 		        $("#bbb").toggle();
		        $("#ccf"+seq).toggle();
				$("#cC"+seq).toggle();
				this.childTitle='';
				this.bcType= 1;
				this.bcRating= 0;
			}
// 			else{
// 				$("#bb").hide();
// 		        $("#bbb").hide();
// 		        $("#bbbb").hide();
// 		        $("#cC").show();
// 		        $("#ppp").hide();
// 		        this.ppppp = this.bcTitle3 + ' > 하위 카테고리';
// 			}	
		},
		
		updateShow: function(seq,num){
			if(num==1){
				$('[id^="cdiv"]').hide();
				$('[id^="clist"]').show();
				$('[id^="div"]').hide();
				$('[id^="list"]').show();
				
				$("#div" + seq).show();
				
				$("#list" + seq).hide();
				$("#pen" + seq).hide();
				$("#del" + seq).hide();
			}
			else{
				$('[id^="div"]').hide();
				$('[id^="list"]').show();
				$('[id^="cdiv"]').hide();
				$('[id^="clist"]').show();
				
				$("#cdiv" + seq).show();
				
				$("#clist" + seq).hide();
				$("#cpen" + seq).hide();
				$("#cdel" + seq).hide();
			}
		},
		
		cancelShow: function(seq,num){
			if(num==1){	
				$("#div" + seq).hide();
				
				$("#list" + seq).show();
				this.updateTitle = '';
			}
			else if(num==2){
				$("#cdiv" + seq).hide();
				
				$("#clist" + seq).show();
				this.updateTitle = '';
			}
// 			else if(num==3){
// 				$("div[id^='div']").hide();
				
// 				$("a[id^='list']").show();
// 				this.updateTitle1 = '';
// 			}
// 			else{
// 				$("div[id^='childDiv']").hide();
				
// 				$("a[id^='childList']").show();
// 				this.updateTitle2 = '';
// 			}
		},
		
		showIcon : function(seq,num){
			if(num==1){
				$("#pen" + seq).show();
				$("#del" + seq).show();
			}
			else{
				$("#cpen" + seq).show();
				$("#cdel" + seq).show();
			}
		},
		
		hideIcon : function(seq,num){
			if(num==1){
				$("#pen" + seq).hide();
				$("#del" + seq).hide();
			}
			else{
				$("#cpen" + seq).hide();
				$("#cdel" + seq).hide();
			}	
		},
		//toggle이벤트 끝
		
		checkRating: function(){
			var vm = this;
			if(vm.memInfo.mrCtg < vm.manageRat){
				alert("권한이 없습니다.");
				window.location.href = '/';
			}
		},
		
	},
	
	filters: {
		
	},
	watch: {
		
	},
	mounted: function() {
		var vm = this;
		window.addEventListener('load', () => {
			vm.checkRating();
			// run after everything is in-place
	    })
	},
});

</script>