<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Begin Page Content -->
<div class="container-fluid" id="boardUpdate">
	<div class="row">
		<div class="col-lg-7">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">{{bcTitle}}</h6>
                </div>
				<div class="card-body">
					<div class="form-group">
		            	<input type="text" class="form-control" placeholder="제목을 입력하세요." v-model="bdTitle">
		            	작성자: {{board.miName}} 조회수: {{board.bdViews}} 등록일: {{board.bdEnrollDate}}
		            </div>
					<div class="form-group">
		            	<textarea id="editor" placeholder="내용을 입력하세요." v-html="bdContent"></textarea>
		            </div>
		            
		            <div class="form-group">
			            	
        					<form id="uploadForm" enctype="multipart/form-data">
	       					    <div id="dropZone" class="file-div card-body">
		                			<div id="fileDragDesc" v-if="fileList.length == 0 && totalFileSize == 0"> 파일을 드래그 해주세요. </div>
		                
		 			 	            <table id="fileListTable">
		             			    	<tbody id="fileTableTbody">
		             			    		<tr v-for="(list, index) in fileList" :key="list.bfCode">
		             			    			<td>{{list.bfOriTitle}}({{list.bfSize}}) <img src='img/delete-button.png' v-on:click="delStoFile(index, list.bfCode)"></td>
		             			    		</tr>
		             			    	</tbody>
		                			</table>
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
					            <input type="file" id="input_file" multiple="multiple"  />
<!-- 					            onchange="fileCheck(this);" -->
					            <button type="button" class="btn btn-primary">내 PC</button>
        					</div>
	        				<div class="float-right mt-2">
					            <button type="button" class="btn btn-outline-dark" v-on:click="goBoardView">이전으로</button>
					            <button type="button" class="btn btn-primary" v-on:click="boardUpdate">수정완료</button>
					            <button type="button" class="btn btn-primary" v-on:click="boardDelete">삭제</button>
				            </div>	
			            </div>
		            
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /.container-fluid -->

<jsp:include page="/WEB-INF/view/board/textBoard/script/boardUpdateScript.jsp"></jsp:include>