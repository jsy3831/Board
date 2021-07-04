<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
var vm = new Vue({
	el: "#sideBar",
	data: {
		cateList: [], //카테고리리스트
		cateChildList: [], //하위카테고리리스트
		memInfo: {},
		selector: 0,
		pselector: 0,
	},
	
	created: function() {
		EventBus.$on('message', this.selectCate);
    	
    	EventBus.$on('pselector', this.pselect);
    	EventBus.$on('selector', this.select);
	},
	
	methods: {
		pselect: function(pselector){
			this.pselector = pselector;
		},
		select: function(selector){
			this.selector = selector;
		},
		
		//카테고리조회
		selectCate: function(){
			var vm = this;
			$.ajax({
				url: '/selectCate',
				data: {
					
				},
				type: 'post',
				success: function(list){
					vm.cateList = list;
					for(var p=0; p<vm.cateList.length; p++){
						
						for(var c=0; c<vm.cateList.length; c++){
							if(vm.cateList[p].bcCode == vm.cateList[c].bcRoot){
								vm.cateChildList.push(vm.cateList[c]);
								
							}
						}
						
						vm.cateList[p].child = vm.cateChildList;
						vm.cateChildList = [];
// 						console.log(vm.cateList[p]);
					}
// 					console.log("보내는쪽입니다"+ vm.cateList);
					EventBus.$emit('test', vm.cateList);
				},
				error: function(){
					alert("에러");
				}
			});
		},
		
		//페이지이동
		goBoard: function(child, pcode){
			var vm = this;
			//text게시판
			if(child.bcType == 1){
				window.location.href = "/board?bcCode="+child.bcCode+"&&bcTitle="+child.bcTitle+"&&bcRating="+child.bcRating
										+"&&bcType="+child.bcType+"&&pbcCode="+pcode+"&&currentPage=1&&selected=1&&searchWrd=";
			}
			//img게시판
			else if(child.bcType == 2){
				window.location.href = "/imgBoard?bcCode="+child.bcCode+"&&bcTitle="+child.bcTitle+"&&bcRating="+child.bcRating
										+"&&bcType="+child.bcType+"&&pbcCode="+pcode+"&&currentPage=1&&selected=1&&searchWrd=";	
			} else{
				window.location.href = "/mediaBoard?bcCode="+child.bcCode+"&&bcTitle="+child.bcTitle+"&&bcRating="+child.bcRating
				+"&&bcType="+child.bcType+"&&pbcCode="+pcode+"&&currentPage=1&&selected=1&&searchWrd=";
			}
			
		},
		
		getSession: function(){
			var vm = this;
			$.ajax({
				url: '/getSession',
				data: {
					
				},
				type: 'post',
				async: false,
				success: function(user){
					vm.memInfo = user;
					EventBus.$emit('memInfo', vm.memInfo);
				},
				error: function(){
					alert("에러");
				}
			});
		},
		
	},
	mounted: function(){
		var vm = this;
// 		window.addEventListener('load', () => {
// 			vm.getSession();
// 			vm.selectCate(); 
// 			// run after everything is in-place
// 	    })
	    
	    window.addEventListener("load", function() {
	    	
	    	vm.getSession();
			vm.selectCate();
	    });
	},

});

</script>