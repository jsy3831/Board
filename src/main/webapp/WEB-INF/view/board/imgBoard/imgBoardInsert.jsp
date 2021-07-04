<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Begin Page Content -->
<div class="container-fluid" id="imgBoard">
	
	<div class="row">
		<div class="col-lg-7">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">{{bcTitle}}</h6>
                </div>
				<div class="card-body">
						<div class="form-group">
			            	<input type="text" class="form-control" placeholder="제목을 입력하세요." v-model="bdTitle">
			            </div>
						<div class="form-group">
			            	<textarea id="editor" placeholder="내용을 입력하세요."></textarea>
			            	
			            </div>
			            <div class="form-group">
			            	
        					<form id="uploadForm" enctype="multipart/form-data">
        						
	       					    <div id="dropZone" class="file-div card-body">
		                			<div id="fileDragDesc"> 이미지를 드래그 해주세요. </div>
		                			
		                			<p id="imgNotice" style="color:red; display:none;">* 하단 이미지를 클릭하시면 본문에 추가됩니다.</p>
		                			<div class="row" id="fileListTable">
		                				<div class="col-lg-4" v-for="list in stoFileList">
		                					<figure>
		                						<figcaption>
		                							<span>
			                							<input type="radio" v-model="picked" v-bind:value="list.bfCode" v-bind:id="'repre' + list.bfCode" @click="pickImg(list.bfPath + list.listThumb)">
			                							<label :for="'repre' + list.bfCode">대표이미지</label>
		                							</span>
		                							<p>
			                							{{list.bfOriTitle}}({{list.bfSize}})
			                							<img src='img/delete-button.png' class="pointer" v-on:click="delStoFile(list)">
		                							</p>
		                						</figcaption>
		                						<img class="pointer imgThumb" v-bind:src="list.bfPath + list.listThumb" @error="imgError" v-on:click="imgInEditor(list.bfPath+list.viewThumb, list.bfCode, list.bfPath+list.bfStoTitle)">
		                					</figure>
		                				</div>
		                			</div>
	            				</div>
   						    </form>
   						    <div id="progressDiv" class="dp_n1 mt-2">
	   						    <b-progress :max="max" height="3rem">
								    <b-progress-bar :value="value">
								       	파일 업로드 진행률: <strong>{{value.toFixed(2)}}% / {{max}}%</strong>
									</b-progress-bar>
								</b-progress>
							</div>
							<div class="upload-btn-wrapper mt-2">
					            <input type="file" id="input_file" multiple="multiple" accept="image/*" />
					            <button type="button" class="btn btn-primary">내 PC</button>
        					</div>
        					
	        				<div class="float-right mt-2">
					            <button type="button" class="btn btn-outline-dark" v-on:click="goBoard(${bcType})">취소</button>
					            <button type="button" class="btn btn-primary" v-on:click="insertImgBoard">등록</button>
				            </div>	
			            </div>
				</div>
			</div>
		</div>
	</div>
<!-- /.container-fluid -->

</div>

<jsp:include page="/WEB-INF/view/board/imgBoard/script/imgBoardInsertScript.jsp"></jsp:include>
