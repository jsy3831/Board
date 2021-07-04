<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Begin Page Content -->
<div class="container-fluid" id="board">

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
			            	<textarea id="editor" placeholder="내용을 입력하세요." name="bdContent"></textarea>
			            </div>
			            <div class="form-group">
			            	
        					<form id="uploadForm" enctype="multipart/form-data">
        						
	       					    <div id="dropZone" class="file-div card-body">
		                			<div id="fileDragDesc"> 파일을 드래그 해주세요. </div>
		                
		 			 	            <table id="fileListTable">
		             			    	<tbody id="fileTableTbody"></tbody>
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
					            <button type="button" class="btn btn-primary">내 PC</button>
        					</div>
        					
	        				<div class="float-right mt-2">
					            <button type="button" class="btn btn-outline-dark" v-on:click="goBoard(${bcType})">취소</button>
					            <button type="button" class="btn btn-primary" v-on:click="insertBoard">등록</button>
				            </div>	
			            </div>
				</div>
			</div>
		</div>
	</div>
<!-- /.container-fluid -->
	
</div>

<jsp:include page="/WEB-INF/view/board/textBoard/script/boardInsertScript.jsp"></jsp:include>