<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	//파일 리스트 번호
	var fileIndex = 0;
	// 등록할 전체 파일 사이즈
	var totalFileSize = 0;
	// 파일 리스트
	var fileList = new Array();
	
	// 등록 가능한 파일 사이즈 MB
	var uploadSize = 500;
	// 등록 가능한 총 파일 사이즈 MB
	var maxUploadSize = 500;
	
	var vm = new Vue({
		el: '#mediaBoardUpdate',
		data: {
			board: {},
			bdTitle: '', //글제목
			bdContent: '', //글내용
			bcCode: ${bcCode}, //카테고리번호
			pbcCode: ${pbcCode},
			
			bcTitle: '${bcTitle}',
			
			bcType: ${bcType}, //게시판타입_text: 1, image: 2, media: 3
			
			bdCode: ${bdCode},
			
			stoFileList: [],
			
			picked: 0,
			pickedSrc: '', //대표이미지경로
			
			bcRating: ${bcRating}, //카테고리권한
			memInfo: {}, //유저정보
			
			//프로그래스바
			value: 0,
	        max: 100,
	        
	        youtubeSrc: '',
	        youtubeList: [],
		},
		created: function(){
			EventBus.$on('memInfo', this.pushMemInfo);
			EventBus.$emit('selector', this.bcCode);
			EventBus.$emit('pselector', this.pbcCode);
		},
		methods: {
			//대표이미지경로설정
			pickImg: function(src){
				var vm = this;
				vm.pickedSrc = src;
			},
			
			//게시글업데이트
			boardUpdate: function(){
				var vm = this;
				if(vm.stoFileList.length == 0 && vm.youtubeList.length == 0) {
					alert("영상을 첨부해주세요.");
					return;
				}
				if(vm.picked ==0){
					alert("대표이미지를 선택해주세요.");
					return;
				}
				if(confirm("수정 하시겠습니까?")){
					var content = CKEDITOR.instances.editor.getData();
					$.ajax({
						url: '/updateImgBoard',
						data: {
							"bdCode": vm.bdCode,
							"bdTitle": vm.bdTitle,
							"bdContent": content,
							"picked": vm.picked,
							"pickedSrc": vm.pickedSrc,
						},
						type: 'post',
						success: function(){
							vm.goBoardView();
						},
						error: function(){
							alert("수정실패");
						}
					});
				}
			},
			
			//글상세조회
			boardInfo: function(){
				var vm = this;
				$.ajax({
					url: '/boardInfo',
					data: {
						"bdCode": vm.bdCode,
						"bcType": vm.bcType,
					},
					type: 'post',
					success: function(obj){
						vm.board = obj.boardView;
						vm.bdTitle = obj.boardView.bdTitle;
						vm.bdContent = obj.boardView.bdContent;
						
						vm.stoFileList = obj.selectFile;
						
						for(var i=0; i<obj.selectFile.length; i++){
							if(obj.selectFile[i].picked != 0){
								vm.picked = obj.selectFile[i].picked;
							}
						}
						
						vm.youtubeList = obj.selectYoutube;
						
						for(var i=0; i<obj.selectYoutube.length; i++){
							if(obj.selectYoutube[i].picked != 0){
								vm.picked = obj.selectYoutube[i].picked;
							}
						}
						
						if (vm.stoFileList.length > 0) {
					        $("#fileDragDesc").hide(); 
					        $("fileListTable").show();
					        $("#imgNotice").show();
					    } else {
					        $("#fileDragDesc").show(); 
					        $("fileListTable").hide();
					        $("#imgNotice").hide();
					    }
						
						if (vm.youtubeList.length > 0) {
					        $("#youtubeForm").show();
					    } else {
					        $("#youtubeForm").hide();
					    }
						
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
			
			//유튜브썸네일삭제
			delYoutubeThumb: function(code){
				var vm = this;
				if(confirm("삭제 하시겠습니까?")){
					while(CKEDITOR.instances.editor.document.getById('youtube_' + code) != null){
						CKEDITOR.instances.editor.document.getById('youtube_' + code).remove();	
					}
					
					$.ajax({
						url: '/delYoutubeThumb',
						data: {
							"bfCode": code,
						},
						type: 'post',
						success: function(){
							if(code == vm.picked){
								vm.picked= 0;
								vm.pickedSrc='';
							}
							vm.selectYoutubeThumb();
						},
						error: function(){
							alert("유튜브썸네일삭제 실패");
						}
					});
				}
			},
			
			//유튜브썸네일조회
			selectYoutubeThumb: function(){
				var vm = this;
				$.ajax({
					url: '/selectYoutubeThumb',
					data: {
						"bdCode": vm.bdCode,
					},
					type: 'post',
					success: function(result){
						vm.youtubeList = result;
						
						if (vm.youtubeList.length > 0) {
					        $("#youtubeForm").show();
					    } else {
					        $("#youtubeForm").hide();
					    }
						
					},
					error: function(){
						alert("유튜브썸네일조회 실패");
					}
				});
			},
			//유튜브비디오삽입
			insertYoutubeThumb: function(){
				var vm = this;
				
				var url = "https://youtu.be/";
				var checkUrl = vm.youtubeSrc.substring(0, vm.youtubeSrc.lastIndexOf("/")) + "/";
				
				if(url != checkUrl){
					alert("입력하신 주소(URL)가 유효하지 않습니다.")
					return;
				}
				
				var content = CKEDITOR.instances.editor.getData();
				var src = vm.youtubeSrc.substring(vm.youtubeSrc.lastIndexOf("/"));
				
				var setImg = "https://i.ytimg.com/vi" + src + "/hqdefault.jpg";
				
				$.ajax({
					url: '/insertYoutubeThumb',
					data: {
						"bdCode": vm.bdCode,
						"listThumb": setImg,
					},
					type: 'post',
					async: false,
					success: function(code){
						vm.selectYoutubeThumb();
						vm.youtubeSrc = '';
						var setYoutube = "";
						
						setYoutube += "<div id='youtube_" + code + "' class='youtube-embed-wrapper' style='position:relative; padding-bottom:56.25%; padding-top:30px; height:0; overflow:hidden'>";
						setYoutube += "		<iframe allowfullscreen='' frameborder='0' height='360' src='https://www.youtube.com/embed" + src + "' style='position:absolute; top:0; left:0; width:100%; height:100%' width='640'>";
						setYoutube += "		</iframe>";
						setYoutube += "</div>";
						
						CKEDITOR.instances.editor.setData(content + setYoutube);
						
					},
					error: function(){
						alert("유튜브썸네일등록 실패");
					}
				});
				
			},
			
			//파일태그로업로드시
			fileChange: function(){
				var vm = this;
				$("#input_file").bind('change', function() {
					vm.selectFile(this.files);
			        //this.files[0].size gets the size of your file.
			        //alert(this.files[0].size);
			    });
			},
			
			//파일드랍다운시
			fileDropDown: function(){
				var vm = this;
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
			            vm.selectFile(files)
			        } else {
			            alert("ERROR");
			        }
			    });
			},
			
			//파일선택시
			selectFile: function(fileObject) {
				var files = fileObject;
				var vm = this;
			    
			 	// 다중파일 등록
			    if (files != null) {
			    	
			    	for (var i = 0; i < files.length; i++) {
			    		// 파일 이름
			            var fileName = files[i].name;
			            var fileNameArr = fileName.split("\.");
			            // 확장자
			            var ext = fileNameArr[fileNameArr.length - 1];
			            
			            var fileSize = files[i].size; // 파일 사이즈(단위 :byte)
			            console.log("fileSize="+fileSize);
			            if (fileSize <= 0) {
			                console.log("0kb file return");
			                alert("폴더 또는 내용이 없는 파일은 업로드 불가합니다.("+fileName+")");
			                continue;
			            }
			            
			            var fileSizeKb = fileSize / 1024; // 파일 사이즈(단위 :kb)
			            var fileSizeMb = fileSizeKb / 1024;    // 파일 사이즈(단위 :Mb)
			            
			            if ($.inArray(ext, [ 'mp4' ]) < 0) {
			                // 확장자 체크_배열내 값이 없으면 -1 반환
			                alert("동영상 파일(.mp4)만 업로드 가능합니다..("+fileName+")");
			            } else if (fileSizeMb > uploadSize) {
			                // 파일 사이즈 체크
			                alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
			            } else {
			            	
			                // 전체 파일 사이즈
			                totalFileSize += fileSizeMb;

			                // 파일 배열에 넣기
			                fileList[fileIndex] = files[i];

			                // 파일 번호 증가
			                fileIndex++;
			                
			            }
			    	}
			    } else{
			    	alert("ERROR");
			    }
			 	vm.insertFile();
			},
			
			//이미지등록
			insertFile: function(){
				
				var vm = this;
				var formData = new FormData();
				
				// 총용량을 500MB를 넘을 경우 업로드 불가
			    if (totalFileSize > maxUploadSize) {
			        // 파일 사이즈 초과 경고창
			        alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
			        totalFileSize = 0;
			        return;
			    }
				
				// 등록할 파일 리스트
			    var uploadFileList = Object.keys(fileList);
				
				if(uploadFileList.length == 0){
					return;
				}
				
				for (var i = 0; i < uploadFileList.length; i++) {
		            formData.append('files', fileList[uploadFileList[i]]);
		        }
				
				formData.append('bdCode', vm.bdCode);
				formData.append('bcType', vm.bcType);
				$.ajax({
					url: '/insertFile',
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
		            	$("#progressDiv").show();
		            },
		            complete: function(){
		            	$("#progressDiv").hide();
		            	fileList.length = 0;
		            },
		            
		            success: function(){
		            	vm.selectStoFile();
		            },
		            error: function(){
		            	alert("파일실패");
		            },
				});
			},
			
			//이미지에러시
			imgError: function(event){
				setTimeout(function(){
					event.target.src = event.target.src;	
				}, 1000);
			},
			
			//이미지조회
			selectStoFile: function(){
				var vm = this;
				$.ajax({
					url: '/selectFile',
					data: {
						"bdCode": vm.bdCode,
					},
					type: 'post',
					async: false,
					success: function(stoFile){
							vm.stoFileList = stoFile;
							
							if (vm.stoFileList.length > 0) {
						        $("#fileDragDesc").hide(); 
						        $("fileListTable").show();
						        $("#imgNotice").show();
						    } else {
						        $("#fileDragDesc").show(); 
						        $("fileListTable").hide();
						        $("#imgNotice").hide();
						    }
							
					},
					error: function(){
						alert("파일조회실패");
					},
				});
			},
			
			//이미지삭제
			delStoFile: function(list){
				var vm = this;
				if(confirm("삭제 하시겠습니까?")){
					while(CKEDITOR.instances.editor.document.getById('video_' + list.bfCode) != null){
						CKEDITOR.instances.editor.document.getById('video_' + list.bfCode).remove();	
					}
					
					$.ajax({
						url: '/removeImg',
						data: {
							"bfCode": list.bfCode,
							"bfPath": list.bfPath,
							"listThumb": list.listThumb,
							"bfStoTitle": list.bfStoTitle,
							
							"bcType": vm.bcType,
						},
						type: 'post',
						success: function(){
							if(list.bfCode == vm.picked){
								vm.picked= 0;
								vm.pickedSrc='';
							}
							vm.selectStoFile();
						},
						error: function(){
							alert("파일삭제실패");
						}
					});
				}
			},
			
			//비디오본문추가
			imgInEditor: function(src, code){
				var vm = this;
				
				var content = CKEDITOR.instances.editor.getData();
				
				var setImg = "";
				
				setImg += "<video id='video_"+ code + "' class='pointer imgThumb' controls>";
				setImg += "    <source src='" + src + "' type='video/mp4'>";
				setImg += "</video>";
				
				CKEDITOR.instances.editor.setData(content + setImg);
				
			},
			
			//에디터설정
			ckeditor: function(){
				CKEDITOR.replace('editor', {
			    	extraPlugins : 'confighelper',
			    	height: 500,
			    	allowedContent:true, //iframe 제거방지
			    	youtube_responsive: true //동영상크기 반응형
			    });
			},
			
			pushMemInfo: function(memInfo){
				this.memInfo = memInfo;
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
			
			//리스트로
			goBoard: function(){
				var vm = this;
				window.location.href = "/mediaBoard?bcCode="+vm.bcCode+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating
										+"&&currentPage="+${currentPage}+"&&selected="+${selected}+"&&searchWrd="+'${searchWrd}';
			},
			
			//본문
			goBoardView: function(){
				var vm = this;
				window.location.href = "/mediaBoardView?bdCode="+vm.bdCode+"&&bcCode="+vm.bcCode+"&&bcTitle="+vm.bcTitle+"&&bcRating="+vm.bcRating+"&&bcType="+vm.bcType+"&&pbcCode="+vm.pbcCode
										+"&&currentPage="+${currentPage}+"&&selected="+${selected}+"&&searchWrd="+'${searchWrd}';
			},
			
		},
		watch: {
			
		},
		mounted: function(){
			var vm = this;
			vm.ckeditor();
			vm.fileChange();
			vm.fileDropDown();
			vm.boardInfo();
			
			window.addEventListener('load', () => {
				vm.checkRating();
				// run after everything is in-place
		    })
		},
		
	});
</script>    