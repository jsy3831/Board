<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="container-fluid" id="userManage">

	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<span class="m-0 font-weight-bold text-primary">회원 관리</span>

			<div class="form-inline float-right">
	   			<div class="form-group">
	    			<select class="form-control" v-model="selected">
	    				<option v-for="option in options" v-bind:value="option.value">{{option.text}}</option>
	    			</select>
	    			<input type="text" class="form-control ml-1" placeholder="검색어 입력" v-model="searchWrd" v-on:keyup.enter="countUser()">
	
					<button class="btn btn-primary ml-1" type="button" @click="countUser()">
	               		<i class="fas fa-search fa-sm"></i>
	               	</button>
	    		</div>
			</div>      
				
							
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-hover" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>NO</th>
							<th>회원 아이디</th>
							<th>회원 이름</th>
							<th>회원 이메일</th>
							<th>회원가입 아이피</th>
							<th>회원 상태</th>
							<th>회원 등급</th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="(list, index) in userList">
<!-- 							<td>{{index+1}}</td> -->
							<td>{{list.miCode}}</td>
							<td>{{list.miId}}</td>
							<td>{{list.miName}}</td>
							<td>{{list.miEmail}}</td>
							<td>{{list.miIp}}</td>
							<td v-if="list.miCtg==20">인증</td>
							<td v-if="list.miCtg==40">탈퇴</td>
							<td>
								<select v-model="list.mrCtg">
									<option v-for="rating in ratingList" v-bind:value="rating.mrCtg">
										{{rating.mrTitle}}
									</option>
								</select>
								<button type="button" v-on:click="updateRating(list)">변경</button>
							</td>
						</tr>
					</tbody>
				</table>
				<p style="text-align: center;" v-if="pagingInfo.records == 0">회원이 존재하지않습니다.</p>
			</div>

		</div>
	</div>
	<b-pagination ref="page" align="center" :total-rows="pagingInfo.records" :per-page="pagingInfo.perPage" v-model="pagingInfo.currentPage" limit="10" v-show="pagingInfo.records > 0"></b-pagination>
</div>

<jsp:include page ="/WEB-INF/view/manage/script/userManageScript.jsp"></jsp:include>
