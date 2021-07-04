<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Begin Page Content -->
<div class="container-fluid" id="mediaBoardView">

	<div class="row">
		<div class="col-lg-7">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">{{bcTitle}}</h6>
                </div>
				<div class="card-body">
					<div class="form-group m-0">
						<div class="card-body">
							<p class="m-0 font-weight-bold" style="font-size:2rem">{{board.bdTitle}}</p>
							<p class="m-0"><span style="margin-right: 2rem">작성자: {{board.miName}}</span><span style="margin-right: 2rem">조회수: {{board.bdViews}}</span><span style="margin-right: 2rem">등록일: {{board.bdEnrollDate}}</span></p>
						</div>
		            	
		            </div>
					<div class="form-group">
						<div style="min-height:500px" class="card-body" v-html="board.bdContent">
						</div>
						
		            </div>
		            
		            <div class="float-left">
			            <button type="button" class="btn btn-outline-dark" v-on:click="goBoard">목록보기</button>
		            </div>
		            <div class="float-right">
			            <button type="button" class="btn btn-primary" v-on:click="goImgBoardUpdate" v-if="memInfo.miCode == board.miCode">수정</button>
			            <button type="button" class="btn btn-primary" v-on:click="boardDelete" v-if="memInfo.miCode == board.miCode || memInfo.mrCtg == 90">삭제</button>
		            </div>
				</div>
			</div>
		</div>
		<div class="col-lg-7">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">댓글({{board.brSum}})</h6>
                </div>
				<div class="card-body">
					<div class="form-group">
						<dl v-for="list in brList">
							
							<dt :style="[list.groupLayer != 0 ? {marginLeft: '1.5rem !important'} : {marginLeft: '0rem !important'}]" v-if="list.brDel == 0">
						  		<img src="img/icons8-curved-arrow-16.png" v-if="list.groupLayer != 0"> {{list.miName}} ({{list.brEnrollDate}})
						  		<img src="img/icon_writer_42x15.png" v-if="list.miCode == board.miCode">
						  		<img src="img/delete-button.png" v-if="memInfo.miCode == list.miCode || memInfo.mrCtg == 90" v-on:click="replyDelete(list.brCode, list.groupLayer, list.groupNo)" class="pointer">
								<div class="float-right pointer" v-if="list.groupLayer == 0" @click="formShow(list.brCode)">
									[ 답글달기 ]
			            		</div>
							</dt>
							<dt v-if="list.brDel == 1">
								삭제된 댓글입니다.
							</dt>
							<dd :style="[list.groupLayer != 0 ? {marginLeft: '3rem !important'} : {marginLeft: '0rem !important'}]" v-html="list.brContent" v-if="list.brDel == 0">
							</dd>
							<dd v-bind:id="'child' + list.brCode" class="dp_n1 ml-5">
								<div class="form-group">
									<div class="input-group">
										<textarea class="form-control" rows="3" style="resize: none;" placeholder="답글을 입력하세요." v-model="brContent"></textarea>
										<div class="input-group-append">
			        						<button type="button" class="btn btn-primary" @click="replyInsert(1,list)">등록</button>
			        					</div>
									</div>
					            </div>
							</dd>
							<hr>
						</dl>
					</div>
					<div class="form-group" id="replyForm">
						<div class="input-group">
							<textarea id="replyArea" class="form-control" rows="3" style="resize: none;" placeholder="댓글을 입력하세요." v-model="brContent" @focus="focus"></textarea>
							<div class="input-group-append">
		        				<button type="button" class="btn btn-primary" @click="replyInsert(0)">등록</button>
		        			</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<!-- /.container-fluid -->
</div>
    
<jsp:include page="/WEB-INF/view/board/mediaBoard/script/mediaBoardViewScript.jsp"></jsp:include>