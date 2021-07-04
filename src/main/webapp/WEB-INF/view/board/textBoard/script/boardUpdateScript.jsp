<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<script>
	$(document).ready(function() {
	    $("#input_file").bind('change', function() {
	        selectFile(this.files);
	    });
	    
	    CKEDITOR.replace('editor', {
	    	extraPlugins : 'confighelper',
	    	height: 500,
	    	allowedContent:true, //iframe 제거방지
	    	youtube_responsive: true //동영상크기 반응형
	    });
	    
	    
	});
	
	// 파일 리스트 번호
	var fileIndex = 0;
	// 등록할 전체 파일 사이즈
	var totalFileSize = 0;
	// 파일 리스트
	var fileList = new Array();
	// 파일 사이즈 리스트
	var fileSizeList = new Array();
	// 등록 가능한 파일 사이즈 MB
	var uploadSize = 50;
	// 등록 가능한 총 파일 사이즈 MB
	var maxUploadSize = 500;
	
	$(function() {
	    // 파일 드롭 다운
	    fileDropDown();
	});
	
	// 파일 드롭 다운
	function fileDropDown() {
	    var dropZone = $("#dropZone");
	    //Drag기능 
	    dropZone.on('dragenter', function(e) {
	        e.stopPropagation();
	        e.preventDefault();
	        // 드롭다운 영역 css
	        dropZone.css('background-color', '#E3F2FC');
	    });
	    dropZone.on('dragleave', function(e) {
	        e.stopPropagation();
	        e.preventDefault();
	        // 드롭다운 영역 css
	        dropZone.css('background-color', '#FFFFFF');
	    });
	    dropZone.on('dragover', function(e) {
	        e.stopPropagation();
	        e.preventDefault();
	        // 드롭다운 영역 css
	        dropZone.css('background-color', '#E3F2FC');
	    });
	    dropZone.on('drop', function(e) {
	        e.preventDefault();
	        // 드롭다운 영역 css
	        dropZone.css('background-color', '#FFFFFF');
	
	        var files = e.originalEvent.dataTransfer.files;
	        if (files != null) {
	        	
	        	selectFile(files)
	        } else {
	            alert("ERROR");
	        }
	    });
	}
	
	// 파일 선택시
	function selectFile(fileObject) {
	    var files = fileObject;
	
	    // 다중파일 등록
	    if (files != null) {
	        
	        for (var i = 0; i < files.length; i++) {
	            // 파일 이름
	            var fileName = files[i].name;
	            var fileNameArr = fileName.split("\.");
	            // 확장자
	            var ext = fileNameArr[fileNameArr.length - 1];
	            
	            var fileSize = files[i].size; // 파일 사이즈(단위 :byte)
	            if (fileSize <= 0) {
	                console.log("0kb file return");
	                alert("폴더 또는 내용이 없는 파일은 업로드 불가합니다.("+fileName+")");
// 	                break;
	                continue;
	            }
	            
	            var fileSizeKb = fileSize / 1024; // 파일 사이즈(단위 :kb)
	            var fileSizeMb = fileSizeKb / 1024;    // 파일 사이즈(단위 :Mb)
	            
	            var fileSizeStr = "";
	            if ((1024*1024) <= fileSize) {    // 파일 용량이 1메가 이상인 경우 
	                console.log("fileSizeMb="+fileSizeMb.toFixed(2));
	                fileSizeStr = fileSizeMb.toFixed(2) + " Mb";
	            } else if ((1024) <= fileSize) {
	                console.log("fileSizeKb="+parseInt(fileSizeKb));
	                fileSizeStr = parseInt(fileSizeKb) + " Kb";
	            } else {
	                console.log("fileSize="+parseInt(fileSize));
	                fileSizeStr = parseInt(fileSize) + " Byte";
	            }
	
	            if ($.inArray(ext, [ 'PNG', 'bat', 'PNG', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'png',  'pdf', 'jpg', 'jpeg', 'gif', 'zip', 'hwp' ]) < 0) {
	                // 확장자 체크
	                /* alert("등록이 불가능한 파일 입니다.");
	                break; */
	                alert("등록이 불가능한 파일 입니다.("+fileName+")");
	            } else if (fileSizeMb > uploadSize) {
	                // 파일 사이즈 체크
	                alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " Mb");
// 	                break;
	            } else {
	                // 전체 파일 사이즈
	                totalFileSize += fileSizeMb;
	
	                // 파일 배열에 넣기
	                fileList[fileIndex] = files[i];
	
	                // 파일 사이즈 배열에 넣기
	                fileSizeList[fileIndex] = fileSizeMb;
	
	                // 업로드 파일 목록 생성
	                addFileList(fileIndex, fileName, fileSizeStr);
	
	                // 파일 번호 증가
	                fileIndex++;
	            }
	        }
	        if(totalFileSize > 0){
	        	$("#fileDragDesc").hide(); 
		        $("fileListTable").show();
	        }
	    } else {
	        alert("ERROR");
	    }
	}
	
	// 업로드 파일 목록 생성
	function addFileList(fIndex, fileName, fileSizeStr) {
	
	    var html = "";
	    html += "<tr id='fileTr_" + fIndex + "'>";
	    html += "    <td id='dropZone' class='left' >";
	    html += fileName + " (" + fileSizeStr +") " 
	           
	            + "<img src= 'img/delete-button.png' onclick='deleteFile(" + fIndex + ")'>"
	    html += "    </td>"
	    html += "</tr>"
	
	    $('#fileTableTbody').append(html);
	}
	
	// 업로드 파일 삭제
	function deleteFile(fIndex) {
	    console.log("deleteFile.fIndex=" + fIndex);
	    // 전체 파일 사이즈 수정
	    totalFileSize -= fileSizeList[fIndex];
	
	    // 파일 배열에서 삭제
	    delete fileList[fIndex];
	
	    // 파일 사이즈 배열 삭제
	    delete fileSizeList[fIndex];
	
	    // 업로드 파일 테이블 목록에서 삭제
	    $("#fileTr_" + fIndex).remove();
	    
	    console.log("totalFileSize="+totalFileSize);
	    
	    if (totalFileSize <= 0){
	    	$("#fileDragDesc").show(); 
	        $("fileListTable").hide();
	    }
	}
	
	var vm = new Vue({
		el: "#boardUpdate",
		data: {
			
			board: {}, //글정보
			bdTitle: '', //글제목
			bdContent: '', //글내용
			bdCode: ${bdCode}, //글번호
			bcCode: ${bcCode}, //카테고리번호
			pbcCode: ${pbcCode},
			
			bcTitle: '${bcTitle}',
			
			fileList: [], //파일리스트
			
			delFileList: [],
			delFile: {},
			
			bcType: ${bcType}, //게시판타입_text: 1, image: 2, media: 3
			
			bcRating: ${bcRating}, //카테고리권한
			memInfo: {}, //유저정보
			
			//프로그래스바
			value: 0,
			max: 100,
		},
		created: function() {
	    	EventBus.$on('memInfo', this.pushMemInfo);
		},	
		methods: {
			pushMemInfo: function(memInfo){
				this.memInfo = memInfo;
			},		
			delStoFile: function(index, code){
				var vm = this;
				
				vm.delFileList.push(code);
				
				console.log(vm.delFileList);
				
				vm.fileList.splice(index, 1);
				
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
						
						EventBus.$emit('selector', vm.bcCode);
						EventBus.$emit('pselector', vm.pbcCode);
						
					},
					error: function(){
						alert("에러");
					}
				});
			},
			
			//글수정
			boardUpdate: function() {
				var vm = this;
				
				// 등록할 파일 리스트
			    var uploadFileList = Object.keys(fileList);
		
			    // 용량을 500MB를 넘을 경우 업로드 불가
			    if (totalFileSize > maxUploadSize) {
			        // 파일 사이즈 초과 경고창
			        alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " Mb");
			        return;
			    }
				
			    if (confirm("수정 하시겠습니까?")) {
			        // 등록할 파일 리스트를 formData로 데이터 입력
			        var formData = new FormData($('#uploadForm')[0]);
			        for (var i = 0; i < uploadFileList.length; i++) {
			        	
			            formData.append('files', fileList[uploadFileList[i]]);
			        }
			        var content = CKEDITOR.instances.editor.getData();
			        formData.append('bdCode', vm.bdCode);
			        formData.append('bdTitle', vm.bdTitle);
			        formData.append('bdContent', content);
			        formData.append('bcCode', vm.bcCode);
			        formData.append('bcType', vm.bcType);
			        formData.append('delFileList', vm.delFileList);	
			        
					$.ajax({
						url: '/boardUpdate',
						data: formData,
						type: 'post',
						enctype : 'multipart/form-data',
			            processData : false,
			            contentType : false,
			            cache : false,
			            
			            xhr: function(){
							var xhr = new window.XMLHttpRequest();
			            	xhr.upload.addEventListener("progress", function(evt){
			            		console.log(evt);
			            		if(evt.lengthComputable){
									vm.value = (evt.loaded/evt.total)*100;
			            		}
			            	}, false);
			            	return xhr;
			            },
			            
			            beforeSend: function(){
			            	vm.value = 0;
			            	if(uploadFileList.length > 0){
			            		$("#progressDiv").show();
			            	}
			            },
			            complete: function(){
			            	$("#progressDiv").hide();
			            },
			            
						success: function(){
							alert("수정완료");
							vm.goBoardView();
						},
						error: function(){
							alert("에러");
						}
					});
			    }
			},
			
			//글삭제
			boardDelete: function() {
				var vm = this;
				if (confirm("삭제 하시겠습니까?")) {
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
			
			goBoardView: function(){
				var vm = this;
				window.location.href = "/boardView?bdCode="+vm.bdCode+"&&bcCode="+vm.bcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode
										+"&&currentPage="+${currentPage}+"&&selected="+${selected}+"&&searchWrd="+'${searchWrd}';
			},
			
			goBoard: function(){
				var vm = this;
				window.location.href = "/board?bcCode="+vm.bcCode+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating
										+"&&currentPage="+${currentPage}+"&&selected="+${selected}+"&&searchWrd="+'${searchWrd}';
			},
			
			//권한체크
			checkRating: function(){
				var vm = this;
				if(vm.memInfo.mrCtg < vm.bcRating){
					alert("권한이 없습니다.");
					window.location.href = '/';
				}
				else if(vm.memInfo.miCode == 0) {
					alert("글수정 권한이 없습니다.");
					history.go(-1);
				}
			},
			
		},
		
		mounted: function() {
			var vm = this;
			vm.boardInfo();
			
			window.addEventListener('load', () => {
				vm.checkRating();
				// run after everything is in-place
		    })
		},
	});
</script>