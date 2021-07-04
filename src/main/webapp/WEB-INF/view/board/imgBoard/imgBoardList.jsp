<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <!-- Begin Page Content -->
    <div class="container-fluid" id="imgBoard">   
    	<div class="card shadow mb-4">
    		<div class="card-header py-3">
	    		<span class="m-0 font-weight-bold text-primary">{{bcTitle}}</span>
	    		
				<div class="form-inline float-right">
	    			<div class="form-group">
		    			<select class="form-control" v-model="selected">
		    				<option v-for="option in options" v-bind:value="option.value">{{option.text}}</option>
		    			</select>
		    			<input type="text" class="form-control ml-1" placeholder="검색어 입력" v-model="searchWrd" v-on:keyup.enter="selectImgBoard(1)">
	
						<button class="btn btn-primary ml-1" type="button" @click="selectImgBoard(1)">
	                		<i class="fas fa-search fa-sm"></i>
	                	</button>
	    				<button type="button" class="btn btn-primary ml-3" v-if="memInfo.miCode != 0" v-on:click="goBoardInsert">글등록</button>
	    			</div>
				</div>
				
    		</div>
    		<div class="card-body">
				
    			<div class="row">
    				<div class="col-lg-3" v-for="(list, index) in imgBoardList">
    					<div class="card shadow mb-4">
    						<div class="card-body">
    						
								<a href="#" v-on:click="updateView(list.bdCode)">
	    							<img v-bind:src="list.pickedSrc" class="imgThumb" @error="imgError">
								</a>								
								    					
    						</div>
    						
    						<div class="card-header py-3">
    							<div class=float-right>
    								<img src="https://img.icons8.com/material-sharp/24/000000/visible.png">{{list.bdViews}}
    							</div>
    							<h6 class="m-0 font-weight-bold text-primary">
    								<a href="#" v-on:click="updateView(list.bdCode)">
    									{{list.bdTitle}}
    								</a>
    								({{list.brSum}})
    							</h6>
    							<h6 class="m-0 text-primary">{{list.miName}}({{list.bdEnrollDate}})</h6>
    						</div>
    					</div>
    				</div>
    			</div>
    			
    			<p style="text-align: center;" v-if="pagingInfo.records == 0">게시글이 존재하지않습니다.</p>
    			
    			<div class="float-right" v-if="memInfo.miCode != 0">
					<button type="button" class="btn btn-primary" v-on:click="goBoardInsert">글등록</button>
				</div>
    			
    		</div>
    	</div>
		<b-pagination ref="page" align="center" :total-rows="pagingInfo.records" :per-page="pagingInfo.perPage" v-model="pagingInfo.currentPage" limit="10" v-show="pagingInfo.records > 0"></b-pagination>
    </div>
   
    <!-- /.container-fluid -->

    <jsp:include page="/WEB-INF/view/board/imgBoard/script/imgBoardListScript.jsp"></jsp:include>
