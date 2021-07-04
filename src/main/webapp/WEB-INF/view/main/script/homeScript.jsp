<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>

// 	var SenderApp = new Vue({
// 	    el: '#sender-app',
// 		data:{
// 			text: '',
// 	        receiveText: ''
// 		},
// 	    created: function() {
// 	    	EventBus.$on('message', this.onReceive);
// 	    },
// 	    methods: {
// 	    	sender: function() {
// 	        	EventBus.$emit('message', this.text);
// 	            this.text = '';
// 	        },
// 	        onReceive: function(text) {
// 	        	this.receiveText = text;
// 	        }
// 	    }
// 	});
	
// 	var ReceiverApp = new Vue({
// 	    el: '#receiver-app',
// 	    data: {
// 	        text: '',
// 	    },
// 		created: function() {
// 	    	EventBus.$on('message', this.onReceive);
// 	    },
// 	    methods: {
// 	    	onReceive: function(text) {
// 	        	this.text = text;
// 	        },
	    	
// 	    }
// 	});
	var vm = new Vue({
		el: '#home',
		data: {
			
			//바차트관련
			barLabel: [],
			barData: [],
			
			//라인차트관련
			lineLabel1: [],
			lineLabel: [],
			lineData: [],
			lineDataCheck: 0,
			
			//테이블관련
			replyTop: [],
			viewTop: [],
			
			//파이차트관련
			pieLabel: [],
			pieData: [],
		},
		methods: {
			
			//bar차트 데이터
			selectBarData: function(){
				var vm = this;
				$.ajax({
					url: '/selectBarData',
					data: {
						
					},
					type: 'post',
					success: function(result){
						vm.barLabel = result.bcTitle;
						vm.barData = result.bdSum;
						
						if(vm.barData.length != 0){
							barChart(vm.barLabel, vm.barData);	
						}
						
					},
					error: function(){
						alert("실패");
					}
				});
			},
			
			//line차트 데이터
			selectLineData: function(){
				var vm = this;
				
				$.ajax({
					url: '/selectLineData',
					data: {
						
					},
					type: 'post',
					success: function(result){
						vm.lineLabel1 = result.date; 
						vm.lineData = result.sum;
						
						for(var i=0; i<vm.lineLabel1.length; i++){
							vm.lineLabel.push(vm.lineLabel1[i] + '일');
						}
						
						for(var i=0; i<vm.lineData.length; i++){
							vm.lineDataCheck += vm.lineData[i];
						}
						
						if(vm.lineDataCheck != 0){
							lineChart(vm.lineLabel, vm.lineData);
						}
						
					},
					error: function(){
						alert("실패");
					},
				});
			},
			
			//pie차트 데이터
			selectPieData: function(){
				var vm = this;
				$.ajax({
					url: '/selectPieData',
					data: {},
					type: 'post',
					success: function(result){
						vm.pieLabel = result.miName;
						vm.pieData = result.bdSum;
						
						if(vm.pieData.length != 0){
							pieChart(vm.pieLabel, vm.pieData);	
						}
					},
					error: function(){
						alert("실패");
					},
				});
			},
			
			//테이블 데이터
			selectTabData: function(){
				var vm = this;
				$.ajax({
					url: '/selectTabData',
					data: {},
					type: 'post',
					success: function(result){
						vm.viewTop = result.selectViewTop;
						vm.replyTop = result.selectReplyTop;
						
					},
					error: function(){
						alert("실패");
					},
				});
			},
			
			//조회수업데이트후 상세페이지이동
			updateView: function(list){
				var vm = this;
				$.ajax({
					url: '/updateView',
					data: {
						"bdCode": list.bdCode,
					},
					type: 'post',
					success: function(){
						if(list.bcType == 1){
							window.location.href = "/boardView?bdCode="+list.bdCode+"&&bcCode="+list.bcCode+"&&bcTitle="+list.bcTitle+"&&bcRating="+list.bcRating+"&&bcType="+list.bcType+"&&pbcCode="+list.pbcCode
												+"&&currentPage=1&&selected=1&&searchWrd=";
						} else if(list.bcType == 2){
							window.location.href = "/imgBoardView?bdCode="+list.bdCode+"&&bcCode="+list.bcCode+"&&bcTitle="+list.bcTitle+"&&bcRating="+list.bcRating+"&&bcType="+list.bcType+"&&pbcCode="+list.pbcCode
												+"&&currentPage=1&&selected=1&&searchWrd=";
						} else{
							window.location.href = "/mediaBoardView?bdCode="+list.bdCode+"&&bcCode="+list.bcCode+"&&bcTitle="+list.bcTitle+"&&bcRating="+list.bcRating+"&&bcType="+list.bcType+"&&pbcCode="+list.pbcCode
												+"&&currentPage=1&&selected=1&&searchWrd=";
						}	
					},
					error: function(){
						alert("에러");
					}
				});
			},
			
		},
		mounted:function(){
			var vm = this;
			vm.selectBarData();
			vm.selectLineData();
			vm.selectPieData();
			vm.selectTabData();
		},
	});
</script>

<script src="vendor/chart.js/Chart.min.js"></script>
<script src="js/demo/chart-area-demo.js"></script>
<script src="js/demo/chart-pie-demo.js"></script>
<script src="js/demo/chart-bar-demo.js"></script>