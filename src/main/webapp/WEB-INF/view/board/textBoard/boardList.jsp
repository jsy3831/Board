<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <!-- Begin Page Content -->
        <div class="container-fluid" id="board">

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
	    		<span class="m-0 font-weight-bold text-primary">{{bcTitle}}</span>
	    		
				<div class="form-inline float-right">
	    			<div class="form-group">
		    			<select class="form-control" v-model="selected">
		    				<option v-for="option in options" v-bind:value="option.value">{{option.text}}</option>
		    			</select>
		    			<input type="text" class="form-control ml-1" placeholder="검색어 입력" v-model="searchWrd" v-on:keyup.enter="selectBoard(1)">
	
						<button class="btn btn-primary ml-1" type="button" @click="selectBoard(1)">
	                		<i class="fas fa-search fa-sm"></i>
	                	</button>
	    				<button type="button" class="btn btn-primary ml-3" v-if="memInfo.miCode != 0" v-on:click="goBoardInsert">글등록</button>
	    			</div>
				</div>      
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered table-hover" width="100%" cellspacing="0">
                	<colgroup>
						<col width="5%;" />
						<col width="50%" />
						<col width="15%;" />
						<col width="20%;" />
						<col width="5%;" />
						<col width="5%;" />
					</colgroup>
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>제목</th>
                      <th>작성자</th>
                      <th>날짜</th>
                      <th>조회수</th>
                      <th>댓글수</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(list, index) in boardList">
                      <td>{{index+1}}</td>
                      <td class="pointer" v-on:click="updateView(list.bdCode)">
                      	{{list.bdTitle}}
                      </td>
                      <td>{{list.miName}}</td>
                      <td>{{list.bdEnrollDate}}</td>
                      <td>{{list.bdViews}}</td>
                      <td>{{list.brSum}}</td>
                    </tr>
                  </tbody>
                </table>
                <p style="text-align: center;" v-if="pagingInfo.records == 0">게시글이 존재하지않습니다.</p>
              </div>
              <div class="float-right" style="margin-top:1%;" v-if="memInfo.miCode != 0">
				<button type="button" class="btn btn-primary" v-on:click="goBoardInsert">글등록</button>
		      </div>
            </div>
          </div>
        <b-pagination ref="page" align="center" :total-rows="pagingInfo.records" :per-page="pagingInfo.perPage" v-model="pagingInfo.currentPage" limit="10" v-show="pagingInfo.records > 0"></b-pagination>  
        <!-- /.container-fluid -->
        </div>
<jsp:include page="/WEB-INF/view/board/textBoard/script/boardListScript.jsp"></jsp:include>

