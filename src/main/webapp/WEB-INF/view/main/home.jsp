<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container-fluid" id="home">

	<!-- Page Heading -->
	<!-- 	<h1 class="h3 mb-4 text-gray-800">홈화면</h1> -->

	<!-- 	<div id="sender-app"> -->
	<!-- 		<input v-model="text"> -->
	<!-- 		<button @click="sender">sender</button> -->
	<!-- 		<div v-if="receiveText">#sender-app: I sent a message a {{ receiveText }}</div>  -->
	<!-- 	</div> -->

	<!-- 	<div id="receiver-app"> -->
	<!-- 		<div v-if="text">#receiver-app: {{ text }}</div> -->
	<!-- 	</div> -->

	<!-- Content Row -->
	<div class="row">

		<div class="col-xl-7 col-lg-7">

			<!-- Area Chart -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">주간 글 등록 현황</h6>
				</div>
				<div class="card-body">
					<div class="chart-area">
						<canvas id="myAreaChart"></canvas>
						<p style="text-align: center;" v-if="lineDataCheck == 0">최근 1주일간 등록된 게시글이 존재하지않습니다.</p>
					</div>
				</div>
			</div>

			<!-- Bar Chart -->
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">가장 글이 많은 카테고리</h6>
				</div>
				<div class="card-body">
					<div class="chart-bar">
						<canvas id="myBarChart"></canvas>
						<p style="text-align: center;" v-if="barData.length == 0">게시글이 존재하지않습니다.</p>
					</div>
				</div>
			</div>

		</div>

		<!-- Donut Chart -->
		<div class="col-xl-5 col-lg-5">
			<div class="card shadow mb-4">
				<!-- Card Header - Dropdown -->
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">가장 많은 글을 작성한 회원</h6>
				</div>
				<!-- Card Body -->
				<div class="card-body">
					
					<div class="chart-pie pt-4">
						<canvas id="myPieChart"></canvas>
						<p style="text-align: center;" v-if="pieData.length == 0">게시글이 존재하지않습니다.</p>
					</div>
					
					<div class="mt-4 text-center small">
						<span class="mr-2" v-for="(list, index) in pieLabel">
							<i class="fas fa-circle text-primary" v-if="index == 0"></i>
							<i class="fas fa-circle text-success" v-if="index == 1"></i>
							<i class="fas fa-circle text-info" v-if="index == 2"></i>
							<i class="fas fa-circle text-warning" v-if="index == 3"></i>
							<i class="fas fa-circle text-danger" v-if="index == 4"></i>
							<i class="fas fa-circle text-secondary" v-if="index == 5"></i>
							{{list}}
						</span>
						
					</div>

				</div>
			</div>

			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">화제의 글</h6>
				</div>
				<div class="card-body">
					<ul class="nav nav-tabs">
						<li class="nav-item">
							<a class="nav-link active" data-toggle="tab" href="#table1" style="color:#858796">
								조회수 <img src="img/icons8-fire-48.png">
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#table2" style="color:#858796">
								댓글수 <img src="img/icons8-fire-48.png">
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane fade show active" id="table1">
							<div class="table-responsive">
								<table class="table table-hover" width="100%" cellspacing="0">
									<colgroup>
										<col width="70%;" />
										<col width="30%" />
									</colgroup>
									<tbody>
										<tr v-for="list in viewTop">
											<td class="pointer" @click="updateView(list)">{{list.bdTitle}} ({{list.brSum}})</td>
											<td>{{list.miName}}</td>
										</tr>
									</tbody>
								</table>
								<p style="text-align: center;" v-if="viewTop.length == 0">게시글이 존재하지않습니다.</p>
							</div>
						</div>
						<div class="tab-pane fade" id="table2">
							<div class="table-responsive">
								<table class="table table-hover" width="100%" cellspacing="0">
									<colgroup>
										<col width="70%;" />
										<col width="30%" />
									</colgroup>
									<tbody>
										<tr v-for="list in replyTop">
											<td class="pointer" @click="updateView(list)">{{list.bdTitle}} ({{list.brSum}})</td>
											<td>{{list.miName}}</td>
										</tr>
									</tbody>
								</table>
								<p style="text-align: center;" v-if="replyTop.length == 0">게시글이 존재하지않습니다.</p>
							</div>
						</div>
					</div>

				</div>
			</div>

		</div>

	</div>

</div>

<jsp:include page="/WEB-INF/view/main/script/homeScript.jsp"></jsp:include>
